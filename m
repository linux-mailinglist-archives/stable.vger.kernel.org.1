Return-Path: <stable+bounces-219935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNHMKvZXoWldsQQAu9opvQ
	(envelope-from <stable+bounces-219935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:38:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202481B49CB
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7435530514BE
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14AA3815D5;
	Fri, 27 Feb 2026 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="tZraIH7i"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9BA25FA05
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772181489; cv=none; b=VLXYA0wiKjcDkQR9s+bmsVALpTXQoQM57QoLQhLaVNbGwpNd/3P3yLzEt8gPVkYTOpO+13njFXrebnW9Xrfb90q/CSYQXnGwJH1To8NOI1hKHnbFTSw9598jbcOGF+us58kmxo0NB8bBFT+0yZD4fkhXnpWJJQTtHcv0pK3csK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772181489; c=relaxed/simple;
	bh=rpehv16MZmxjKTJIidVETzV4xPaqpZtEzRFO04c4Nhc=;
	h=From:To:Subject:Date:Message-Id; b=j4El8XWOzEwLGfbHCVach52BLNVuoLdXN3JxyHrlafsBy0jQgiDbOKkun1wY8zLoVuRjMH1Zz+rHlbYBGsQiHA+7ZHFnVtS01cpo2jOBpdv6Ydm+CFvpT+utQtDMKuqJX3eQFQ3REQp/aUUuRlzApXdQDWNr+cRwsZAESe9HoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=tZraIH7i; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tZraIH7iaw5re6DM+VbEpn2NFTBBHqoAowzXyFUlC1hEQb6Q2Gc1a65pdNya9XZmbua3HXOQJDHmW
	 1NK+TpJJSsTISSUBw5rrjvO5TnaMZ+jjU5+rClBASdmUpkfUPrSyc7fSe53lDMuN3wcB6OwSxrFqFL
	 ZajeTT+v+nhZmedM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.78])
	by rmsmtp-lg-appmail-31-12045 (RichMail) with SMTP id 2f0d69a1572b8ca-3928d;
	Fri, 27 Feb 2026 16:34:52 +0800 (CST)
X-RM-TRANSID:2f0d69a1572b8ca-3928d
From: Rajani Kantha <681739313@139.com>
To: hkelam@marvell.com,
	kuba@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.12] Octeontx2-af: Add proper checks for fwdata
Date: Fri, 27 Feb 2026 16:34:51 +0800
Message-Id: <20260227083451.20062-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219935-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[139.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 202481B49CB
X-Rspamd-Action: no action

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit 4a3dba48188208e4f66822800e042686784d29d1 ]

firmware populates MAC address, link modes (supported, advertised)
and EEPROM data in shared firmware structure which kernel access
via MAC block(CGX/RPM).

Accessing fwdata, on boards booted with out MAC block leading to
kernel panics.

Internal error: Oops: 0000000096000005 [#1]  SMP
[   10.460721] Modules linked in:
[   10.463779] CPU: 0 UID: 0 PID: 174 Comm: kworker/0:3 Not tainted 6.19.0-rc5-00154-g76ec646abdf7-dirty #3 PREEMPT
[   10.474045] Hardware name: Marvell OcteonTX CN98XX board (DT)
[   10.479793] Workqueue: events work_for_cpu_fn
[   10.484159] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   10.491124] pc : rvu_sdp_init+0x18/0x114
[   10.495051] lr : rvu_probe+0xe58/0x1d18

Fixes: 997814491cee ("Octeontx2-af: Fetch MAC channel info from firmware")
Fixes: 5f21226b79fd ("Octeontx2-pf: ethtool: support multi advertise mode")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Link: https://patch.msgid.link/20260121094819.2566786-1-hkelam@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 3 +++
 drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 992fa0b82e8d..d0215f5e9a06 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1224,6 +1224,9 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 	u8 cgx_idx, lmac;
 	void *cgxd;
 
+	if (!rvu->fwdata)
+		return LMAC_AF_ERR_FIRMWARE_DATA_NOT_MAPPED;
+
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
 		return -EPERM;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
index 38cfe148f4b7..f85e57b07c57 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
@@ -56,7 +56,7 @@ int rvu_sdp_init(struct rvu *rvu)
 	struct rvu_pfvf *pfvf;
 	u32 i = 0;
 
-	if (rvu->fwdata->channel_data.valid) {
+	if (rvu->fwdata && rvu->fwdata->channel_data.valid) {
 		sdp_pf_num[0] = 0;
 		pfvf = &rvu->pf[sdp_pf_num[0]];
 		pfvf->sdp_info = &rvu->fwdata->channel_data.info;
-- 
2.17.1



