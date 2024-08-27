Return-Path: <stable+bounces-70403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3838960DEB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65781C23183
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA41C57B1;
	Tue, 27 Aug 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RvyOcuJU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECAC1C57A6;
	Tue, 27 Aug 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769784; cv=none; b=b90XXfouaWgmWl3TTNfIcKXb+zNqqwEYcnZOAAIGWWgrdWYH9s9MlqfYZc33KRz3BHERhC23W7A4VzEJsejg4+H6ByFtRLlXDA8gQnfz+H4ZmV+o7l3U/5yC4yQMoSTXCDrtyINkttXJ9SDg9AKVfBHBvM35xOzO3GTF3y9861I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769784; c=relaxed/simple;
	bh=4Uufag33SRdq930koZmnvG1BheY2GMhJxamfQwPpeR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYeYpzncQw8mPwehMhOlzT5514CpjiDYk7iET7tfoGRSfkxZZ4ZzKQz/UL6Bc3xW/WvQrNcR+k3q5sOzKEeG3RA8ijnUCup761MbOlOcS5Vb7ois9sxOA4xdWz4hk4I15am0scAeYX6UGbbp5gChoYldlhLrR/9VqqaqOpmZVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RvyOcuJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805A1C6104E;
	Tue, 27 Aug 2024 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724769784;
	bh=4Uufag33SRdq930koZmnvG1BheY2GMhJxamfQwPpeR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvyOcuJUnk1VvUplyl4fUuBbpVF2Ov7hQ3+sxOwgMVVvEcEpcNE/sktnUDlypvvj7
	 vB/ptRcGF8TdYgmlSy6zzN6L5L0xOthZKIIUB4j1u20WicNNGmYlw3Io/Y3z5d13WS
	 N1BdvC9K5CH5MfohhryCCfCj00vp2ZWSFQFErQv4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6 034/341] net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings
Date: Tue, 27 Aug 2024 16:34:25 +0200
Message-ID: <20240827143844.710388190@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit 58a63729c957621f1990c3494c702711188ca347 upstream.

After napi_complete_done() is called when NAPI is polling in the current
process context, another NAPI may be scheduled and start running in
softirq on another CPU and may ring the doorbell before the current CPU
does. When combined with unnecessary rings when there is no need to arm
the CQ, it triggers error paths in the hardware.

This patch fixes this by calling napi_complete_done() after doorbell
rings. It limits the number of unnecessary rings when there is
no need to arm. MANA hardware specifies that there must be one doorbell
ring every 8 CQ wraparounds. This driver guarantees one doorbell ring as
soon as the number of consumed CQEs exceeds 4 CQ wraparounds. In practical
workloads, the 4 CQ wraparounds proves to be big enough that it rarely
exceeds this limit before all the napi weight is consumed.

To implement this, add a per-CQ counter cq->work_done_since_doorbell,
and make sure the CQ is armed as soon as passing 4 wraparounds of the CQ.

Cc: stable@vger.kernel.org
Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
Link: https://patch.msgid.link/1723219138-29887-1-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c |   22 ++++++++++++++--------
 include/net/mana/mana.h                       |    1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1778,7 +1778,6 @@ static void mana_poll_rx_cq(struct mana_
 static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 {
 	struct mana_cq *cq = context;
-	u8 arm_bit;
 	int w;
 
 	WARN_ON_ONCE(cq->gdma_cq != gdma_queue);
@@ -1789,16 +1788,23 @@ static int mana_cq_handler(void *context
 		mana_poll_tx_cq(cq);
 
 	w = cq->work_done;
+	cq->work_done_since_doorbell += w;
 
-	if (w < cq->budget &&
-	    napi_complete_done(&cq->napi, w)) {
-		arm_bit = SET_ARM_BIT;
-	} else {
-		arm_bit = 0;
+	if (w < cq->budget) {
+		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
+		cq->work_done_since_doorbell = 0;
+		napi_complete_done(&cq->napi, w);
+	} else if (cq->work_done_since_doorbell >
+		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {
+		/* MANA hardware requires at least one doorbell ring every 8
+		 * wraparounds of CQ even if there is no need to arm the CQ.
+		 * This driver rings the doorbell as soon as we have exceeded
+		 * 4 wraparounds.
+		 */
+		mana_gd_ring_cq(gdma_queue, 0);
+		cq->work_done_since_doorbell = 0;
 	}
 
-	mana_gd_ring_cq(gdma_queue, arm_bit);
-
 	return w;
 }
 
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -274,6 +274,7 @@ struct mana_cq {
 	/* NAPI data */
 	struct napi_struct napi;
 	int work_done;
+	int work_done_since_doorbell;
 	int budget;
 };
 



