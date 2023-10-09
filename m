Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED27BDF5C
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376979AbjJIN3W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377133AbjJIN3C (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:29:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41BCC6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:29:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF37C433C7;
        Mon,  9 Oct 2023 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858141;
        bh=ZgnkX/Zcp1YzgQZtPa17KqYuEiFz2Mfqxe80/W/AMHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKeI2C7yBwzdIl42JPbBIe7Sv1+Qceu+osdvpdvkZhZ2O7eUo0Ua0OjV+KLux5uFc
         2mEP6LujbU8U/2HmJ/kd7fPOTYvD30BYxipeA9UnzCTbvlqjD4BpoH5CGVuuLfi4Q+
         GNUF/HxOZHvsp6PXTAThYVbGb64/EW/bFEQ4D9Tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 029/131] net: rds: Fix possible NULL-pointer dereference
Date:   Mon,  9 Oct 2023 15:01:09 +0200
Message-ID: <20231009130117.203256707@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
 net/rds/rdma_transport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index 5f741e51b4baa..bb38124a5d3db 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -86,10 +86,12 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 		break;
 
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
-		rdma_set_service_type(cm_id, conn->c_tos);
-		/* XXX do we need to clean up if this fails? */
-		ret = rdma_resolve_route(cm_id,
+		if (conn) {
+			rdma_set_service_type(cm_id, conn->c_tos);
+			/* XXX do we need to clean up if this fails? */
+			ret = rdma_resolve_route(cm_id,
 					 RDS_RDMA_RESOLVE_TIMEOUT_MS);
+		}
 		break;
 
 	case RDMA_CM_EVENT_ROUTE_RESOLVED:
-- 
2.40.1



