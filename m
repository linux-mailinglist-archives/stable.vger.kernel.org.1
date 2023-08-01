Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADFC76AF63
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjHAJrB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjHAJqj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:46:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2A139
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3104361502
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417A9C433C8;
        Tue,  1 Aug 2023 09:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883118;
        bh=Kghv55kihN/uXVOFLfX12mVjiXFUB0Nq0hq/76ygEog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFOOWuu09MmJNPaxDtmgKoxDhoRv6K6Ry1A31JTZq8dAsYuyc+g2TYK0H616IBn/N
         Sf+tVkvaA9HVV7J6UAnlwdFGz554c1Y6o1xVadV+4aeQMRWRPhItCpZkcvv1adbfit
         0wOuGwzKzr2kbfXYh73waEMDWXGrSOEDPnjM5y6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Victor Nogueira <victor@mojatatu.com>,
        Lin Ma <linma@zju.edu.cn>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 094/239] net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64
Date:   Tue,  1 Aug 2023 11:19:18 +0200
Message-ID: <20230801091929.124031120@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 6c58c8816abb7b93b21fa3b1d0c1726402e5e568 ]

The nla_for_each_nested parsing in function mqprio_parse_nlattr() does
not check the length of the nested attribute. This can lead to an
out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
be viewed as 8 byte integer and passed to priv->max_rate/min_rate.

This patch adds the check based on nla_len() when check the nla_type(),
which ensures that the length of these two attribute must equals
sizeof(u64).

Fixes: 4e8b86c06269 ("mqprio: Introduce new hardware offload mode and shaper in mqprio")
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Link: https://lore.kernel.org/r/20230725024227.426561-1-linma@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_mqprio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index ab69ff7577fc7..793009f445c03 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -290,6 +290,13 @@ static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
 						    "Attribute type expected to be TCA_MQPRIO_MIN_RATE64");
 				return -EINVAL;
 			}
+
+			if (nla_len(attr) != sizeof(u64)) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute TCA_MQPRIO_MIN_RATE64 expected to have 8 bytes length");
+				return -EINVAL;
+			}
+
 			if (i >= qopt->num_tc)
 				break;
 			priv->min_rate[i] = nla_get_u64(attr);
@@ -312,6 +319,13 @@ static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
 						    "Attribute type expected to be TCA_MQPRIO_MAX_RATE64");
 				return -EINVAL;
 			}
+
+			if (nla_len(attr) != sizeof(u64)) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute TCA_MQPRIO_MAX_RATE64 expected to have 8 bytes length");
+				return -EINVAL;
+			}
+
 			if (i >= qopt->num_tc)
 				break;
 			priv->max_rate[i] = nla_get_u64(attr);
-- 
2.39.2



