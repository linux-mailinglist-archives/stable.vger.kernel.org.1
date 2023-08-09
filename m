Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B211775BFA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjHILWk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjHILWj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0EC211D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E82D6320B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72236C433C8;
        Wed,  9 Aug 2023 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580155;
        bh=AvlywrVnNI3uG2oYlFJjm8gsao2iitHN45do+b9vbS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=caXoe+kXXstl/VFhSG1s+/LrMUXONp7cCB4gyWJiTdVoir7OLcMoQ5fUMl4RsznmG
         5urUo1dGNhPwiFJULEijgtF/8o1+rYzejNW4dpZQ99tiuuO55b2HEsqVME/JI9Nj3t
         lmRF4hK3BYgu0ixLk81MlULcPZ7b/BiF1lLgPc60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Victor Nogueira <victor@mojatatu.com>,
        Lin Ma <linma@zju.edu.cn>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 248/323] net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64
Date:   Wed,  9 Aug 2023 12:41:26 +0200
Message-ID: <20230809103709.424541114@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index c9bdb4476a5bc..c0ab1e38e80c6 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -176,6 +176,13 @@ static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
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
 			priv->min_rate[i] = *(u64 *)nla_data(attr);
@@ -198,6 +205,13 @@ static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
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
 			priv->max_rate[i] = *(u64 *)nla_data(attr);
-- 
2.39.2



