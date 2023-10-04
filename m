Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE97B8830
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbjJDSNf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243956AbjJDSNe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:13:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60287C9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:13:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AEFC433C8;
        Wed,  4 Oct 2023 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443211;
        bh=z/5CKU1M4u4ZozEKHKTydAYFB83lP1uwfJhhQZsQgLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztNg1Yu5jAdV2Lv2m+FA+MB6dD3ZzS73RU9aVWQeQnHnRdkIkSqHnmCit0pvPyLCD
         A7kD+w58HypYySWBfq5xiVJPXLvwe4tRhwE0cfy4rpy5HZ3yjcF537sSclX9anWQ9B
         tClcL2xb/6vlwbLWvKseWNc7dPlWGvIqRb0/+a3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 076/259] net: rds: Fix possible NULL-pointer dereference
Date:   Wed,  4 Oct 2023 19:54:09 +0200
Message-ID: <20231004175220.870807046@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Chernyshev <artem.chernyshev@red-soft.ru>

[ Upstream commit f1d95df0f31048f1c59092648997686e3f7d9478 ]

In rds_rdma_cm_event_handler_cmn() check, if conn pointer exists
before dereferencing it as rdma_set_service_type() argument

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: fd261ce6a30e ("rds: rdma: update rdma transport for tos")
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/rdma_transport.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index d36f3f6b43510..b15cf316b23a2 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -86,11 +86,13 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 		break;
 
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
-		rdma_set_service_type(cm_id, conn->c_tos);
-		rdma_set_min_rnr_timer(cm_id, IB_RNR_TIMER_000_32);
-		/* XXX do we need to clean up if this fails? */
-		ret = rdma_resolve_route(cm_id,
-					 RDS_RDMA_RESOLVE_TIMEOUT_MS);
+		if (conn) {
+			rdma_set_service_type(cm_id, conn->c_tos);
+			rdma_set_min_rnr_timer(cm_id, IB_RNR_TIMER_000_32);
+			/* XXX do we need to clean up if this fails? */
+			ret = rdma_resolve_route(cm_id,
+						 RDS_RDMA_RESOLVE_TIMEOUT_MS);
+		}
 		break;
 
 	case RDMA_CM_EVENT_ROUTE_RESOLVED:
-- 
2.40.1



