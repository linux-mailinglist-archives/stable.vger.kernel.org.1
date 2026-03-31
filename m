Return-Path: <stable+bounces-231472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEvxLJ31y2nlMwYAu9opvQ
	(envelope-from <stable+bounces-231472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:26:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1229236C90C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D6173074F00
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AADF2EE262;
	Tue, 31 Mar 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XqnyJFQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09363E3174;
	Tue, 31 Mar 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974261; cv=none; b=LR8tnHR02woPyvkNPbovREG05pLrQ0WLrMcP2GL7cKbI21d3cexGx2p9Sa0yT1RTgnN6ubOovdQ2sJiqt1Ne/n+k+q5XIHr1NyPmqLM3vbFeY1UkckunklBhlk8uD4VeyxvNHDi4LTtv+Vh96caca06IfWUkRUjFe15NDdVvRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974261; c=relaxed/simple;
	bh=VbU2nzil7mn/8wc8sKECzkVYZfwUmOsYv+t/2LoTj0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmwdZP53ZPqO39c19eMnHM18dXt+Ht7Rlq7OH4Oju/GtpIusMhh3VA8YjqzeDCaLIKkya3dxFY7V8zqa8HVpcrtOGA1eh4H9odvkp14Q3NPszCuccRVFyubqCDPD6986XYgUPDiTJ2QEOz+EYlb7WxNaISvEEGav9SELfUOcaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XqnyJFQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4579CC19423;
	Tue, 31 Mar 2026 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974260;
	bh=VbU2nzil7mn/8wc8sKECzkVYZfwUmOsYv+t/2LoTj0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XqnyJFQfLOULUfv6UwKNVGSXVDjzhdNJFtLkOJ6VI/s6m7joC6FCr9eKZgcgYlAbF
	 ZeVT6SffIg1Z0uOHCWkYt+b2kCB47mVY44LygaulWa4FLXwhQpOdEYO6YAFDjApMoQ
	 hicbDB6gC32UhK8JXOajh+HrI2v3xBB2xiqbfG/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julius Lehmann <lehmanju@devpi.de>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 017/175] HID: magicmouse: fix battery reporting for Apple Magic Trackpad 2
Date: Tue, 31 Mar 2026 18:20:01 +0200
Message-ID: <20260331161730.415061911@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231472-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,devpi.de:email]
X-Rspamd-Queue-Id: 1229236C90C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julius Lehmann <lehmanju@devpi.de>

[ Upstream commit 5f3518d77419255f8b12bb23c8ec22acbeb6bc5b ]

Battery reporting does not work for the Apple Magic Trackpad 2 if it is
connected via USB. The current hid descriptor fixup code checks for a
hid descriptor length of exactly 83 bytes. If the hid descriptor is
larger, which is the case for newer apple mice, the fixup is not
applied.

This fix checks for hid descriptor sizes greater/equal 83 bytes which
applies the fixup for newer devices as well.

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-magicmouse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 99d0dbf62af37..bb725dfcef196 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -963,7 +963,7 @@ static __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	 */
 	if ((is_usb_magicmouse2(hdev->vendor, hdev->product) ||
 	     is_usb_magictrackpad2(hdev->vendor, hdev->product)) &&
-	    *rsize == 83 && rdesc[46] == 0x84 && rdesc[58] == 0x85) {
+	    *rsize >= 83 && rdesc[46] == 0x84 && rdesc[58] == 0x85) {
 		hid_info(hdev,
 			 "fixing up magicmouse battery report descriptor\n");
 		*rsize = *rsize - 1;
-- 
2.51.0




