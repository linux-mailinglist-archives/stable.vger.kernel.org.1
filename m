Return-Path: <stable+bounces-212421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD3uLfUyeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:01:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B122A4F35
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C0A31B4D6E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5E92FDC5D;
	Wed, 28 Jan 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L37cckwO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD862F25EF;
	Wed, 28 Jan 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615461; cv=none; b=PayN727tFXvyD0itnIi3uAO2MTlsCMXoc/C7Mli7zGpSmvWPM/goTx/hlof2sj4rPwBu1tVtjykmYRI+i+N1N5vWg9mZ03Jj8A9QiAEna4UwVAq2fHs4MwfU/rwcrehjbye0NYmAInzjfd0eAKdqmxEZojRT7nwJGmUa9VopOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615461; c=relaxed/simple;
	bh=pGujftbgDHhR1FCxvaY7aHSiuYSwi40XjTgyAF0PJeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/MXtypCOmayVJsd/3y8upUwsBDmHBrvgcHAopswwy+71OX94NH+ZSlThkKrL7B0QtklnFSXI83+RIKcnaSBOkYmAsfKN81Nylw24pIwUwYcAfvBHDYV4FAhegaGBXFvIw1tkD/TEZt+4Nj0DtpnQEOIeyrO52Kix/1ab/O5UD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L37cckwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033A8C4CEF1;
	Wed, 28 Jan 2026 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615461;
	bh=pGujftbgDHhR1FCxvaY7aHSiuYSwi40XjTgyAF0PJeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L37cckwOfG//cHnZ2FnTiBGgPDIitzATf492ZUUwYUcJedIPImi+hNFiFTNJz9Hru
	 DXlDsZbQNVLAbKrNeBcKK42p078d3EiXsVUuKVM5ruW74cf/dd+CENnWHUydYwdfas
	 sLbdUU9cahv5bafgEkV3StxAukize4qQ6rjDvqYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 017/227] wifi: ath12k: cancel scan only on active scan vdev
Date: Wed, 28 Jan 2026 16:21:02 +0100
Message-ID: <20260128145344.963823139@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212421-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[qualcomm.com:query timed out,msgid.link:query timed out];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[jeff.johnson.oss.qualcomm.com:query timed out,manish.dharanenthiran.oss.qualcomm.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5B122A4F35
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>

[ Upstream commit 39c90b1a1dbe6d7c49d19da6e5aec00980c55d8b ]

Cancel the scheduled scan request only on the vdev that has an active
scan running. Currently, ahvif->links_map is used to obtain the links,
but this includes links for which no scan is scheduled. In failure cases
where the scan fails due to an invalid channel definition, other links
which are not yet brought up (vdev not created) may also be accessed,
leading to the following trace:

Unable to handle kernel paging request at virtual address 0000000000004c8c
pc : _raw_spin_lock_bh+0x1c/0x54
lr : ath12k_scan_abort+0x20/0xc8 [ath12k]

Call trace:
 _raw_spin_lock_bh+0x1c/0x54 (P)
 ath12k_mac_op_cancel_hw_scan+0xac/0xc4 [ath12k]
 ieee80211_scan_cancel+0xcc/0x12c [mac80211]
 ieee80211_do_stop+0x6c4/0x7a8 [mac80211]
 ieee80211_stop+0x60/0xd8 [mac80211]

Skip links that are not created or are not the current scan vdev. This
ensures only the scan for the matching links is aborted and avoids
aborting unrelated links during cancellation, thus aligning with how
start/cleanup manage ar->scan.arvif.

Also, remove the redundant arvif->is_started check from
ath12k_mac_op_cancel_hw_scan() that was introduced in commit 3863f014ad23
("wifi: ath12k: symmetrize scan vdev creation and deletion during HW
scan") to avoid deleting the scan interface if the scan is triggered on
the existing AP vdev as this use case is already handled in
ath12k_scan_vdev_clean_work().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: feed05f1526e ("wifi: ath12k: Split scan request for split band device")
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 095b49a39683c..ffeb667734358 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5254,7 +5254,8 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 
 	for_each_set_bit(link_id, &links_map, ATH12K_NUM_MAX_LINKS) {
 		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
-		if (!arvif || arvif->is_started)
+		if (!arvif || !arvif->is_created ||
+		    arvif->ar->scan.arvif != arvif)
 			continue;
 
 		ar = arvif->ar;
-- 
2.51.0




