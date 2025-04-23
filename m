Return-Path: <stable+bounces-135904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F200A9913B
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B1E924C4A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DEB2820C2;
	Wed, 23 Apr 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dSVIJ/bv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4E292924;
	Wed, 23 Apr 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421147; cv=none; b=C96yYZ0yLanNe2w1aqx0KDcAZnUXKRVNbaUrDdKCrfCQysE546EUxQIjGvVV4aj/WNY0g3L8ud8/ScOSZk+RYk9+x9M1V1N0lXazSEP5HAO1WTgLv4oAMdOcRwvfI3qbUWzUP8rtczaUjFmddtw/BoGbP+qRc4EyeMEuKeReq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421147; c=relaxed/simple;
	bh=12c78STudlL1M+UovmdfpkqIW1DHg5kEpDUABzLXDrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhYLH2DpGeTR9gvpSec900biYzVzPR7mXI40xZeExEeKh4r+4gOG6bnJZ1xDRjiTZWpWCTJ7TOV4rViGt4vbGwuCBnLZCrdleTLmNZcGG65MtpOshKkjUIK+wmss5i+tNA+TkuI+FH8SodphFx/HLIZo7wEuhqiDeKUIIoV8TtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dSVIJ/bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2F3C4CEE2;
	Wed, 23 Apr 2025 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421147;
	bh=12c78STudlL1M+UovmdfpkqIW1DHg5kEpDUABzLXDrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSVIJ/bvaAjb6Qnl1R8qsisHhDexOY2W1wF8U8B6JRq9z/vPE536V8oY4JtluefJs
	 MzBtFfi+zZ90KlI0CtzXKOaLyNUZCdYf0UfGj6NVh8gPR7HRkJaj8UluVdpFHbxu9X
	 LixGF3fOovNetlHN0CzhrOGLizrkj9w7Dl5E2lic=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Troy Hanson <quic_thanson@quicinc.com>
Subject: [PATCH 6.1 112/291] bus: mhi: host: Fix race between unprepare and queue_buf
Date: Wed, 23 Apr 2025 16:41:41 +0200
Message-ID: <20250423142628.949897435@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Hugo <quic_jhugo@quicinc.com>

commit 0686a818d77a431fc3ba2fab4b46bbb04e8c9380 upstream.

A client driver may use mhi_unprepare_from_transfer() to quiesce
incoming data during the client driver's tear down. The client driver
might also be processing data at the same time, resulting in a call to
mhi_queue_buf() which will invoke mhi_gen_tre(). If mhi_gen_tre() runs
after mhi_unprepare_from_transfer() has torn down the channel, a panic
will occur due to an invalid dereference leading to a page fault.

This occurs because mhi_gen_tre() does not verify the channel state
after locking it. Fix this by having mhi_gen_tre() confirm the channel
state is valid, or return error to avoid accessing deinitialized data.

Cc: stable@vger.kernel.org # 6.8
Fixes: b89b6a863dd5 ("bus: mhi: host: Add spinlock to protect WP access when queueing TREs")
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Youssef Samir <quic_yabdulra@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Troy Hanson <quic_thanson@quicinc.com>
Link: https://lore.kernel.org/r/20250306172913.856982-1-jeff.hugo@oss.qualcomm.com
[mani: added stable tag]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/host/main.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1201,11 +1201,16 @@ int mhi_gen_tre(struct mhi_controller *m
 	struct mhi_ring_element *mhi_tre;
 	struct mhi_buf_info *buf_info;
 	int eot, eob, chain, bei;
-	int ret;
+	int ret = 0;
 
 	/* Protect accesses for reading and incrementing WP */
 	write_lock_bh(&mhi_chan->lock);
 
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	buf_ring = &mhi_chan->buf_ring;
 	tre_ring = &mhi_chan->tre_ring;
 
@@ -1223,10 +1228,8 @@ int mhi_gen_tre(struct mhi_controller *m
 
 	if (!info->pre_mapped) {
 		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
-		if (ret) {
-			write_unlock_bh(&mhi_chan->lock);
-			return ret;
-		}
+		if (ret)
+			goto out;
 	}
 
 	eob = !!(flags & MHI_EOB);
@@ -1243,9 +1246,10 @@ int mhi_gen_tre(struct mhi_controller *m
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
 	mhi_add_ring_element(mhi_cntrl, buf_ring);
 
+out:
 	write_unlock_bh(&mhi_chan->lock);
 
-	return 0;
+	return ret;
 }
 
 int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,



