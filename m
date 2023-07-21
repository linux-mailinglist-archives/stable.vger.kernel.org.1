Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3EE75D3FD
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGUTQi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjGUTQg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1045E1BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EB0061D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04E0C433C8;
        Fri, 21 Jul 2023 19:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966995;
        bh=ElAdtHySEFrLacSBSTpAbBVBu8ZxFEA9lWL3++5Ezrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHpzFencMf5hCjKGUrM8my2ZXke+LWlFMa8zm0bnhsCNleDRrIn4HkmhjwAEL+rSQ
         zsA3yKom/F4qXSyhazpCjiXwB8s+P5K4Xh/pKgM5elYnFSVWN0kYkhBlMEn05RMQCw
         kHBl6zCYKvdGNJy17FEi/nZqpaMU+YUJoBmp/D7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jamal Hadi Salim <jhs@mojatatu.com>,
        Eric Dumazet <edumazet@google.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15 532/532] net/sched: sch_qfq: reintroduce lmax bound check for MTU
Date:   Fri, 21 Jul 2023 18:07:16 +0200
Message-ID: <20230721160643.463604601@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pedro Tammela <pctammela@mojatatu.com>

commit 158810b261d02fc7dd92ca9c392d8f8a211a2401 upstream.

25369891fcef deletes a check for the case where no 'lmax' is
specified which 3037933448f6 previously fixed as 'lmax'
could be set to the device's MTU without any bound checking
for QFQ_LMAX_MIN and QFQ_LMAX_MAX. Therefore, reintroduce the check.

Fixes: 25369891fcef ("net/sched: sch_qfq: refactor parsing of netlink parameters")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_qfq.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -428,10 +428,17 @@ static int qfq_change_class(struct Qdisc
 	else
 		weight = 1;
 
-	if (tb[TCA_QFQ_LMAX])
+	if (tb[TCA_QFQ_LMAX]) {
 		lmax = nla_get_u32(tb[TCA_QFQ_LMAX]);
-	else
+	} else {
+		/* MTU size is user controlled */
 		lmax = psched_mtu(qdisc_dev(sch));
+		if (lmax < QFQ_MIN_LMAX || lmax > QFQ_MAX_LMAX) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "MTU size out of bounds for qfq");
+			return -EINVAL;
+		}
+	}
 
 	inv_w = ONE_FP / weight;
 	weight = ONE_FP / inv_w;


