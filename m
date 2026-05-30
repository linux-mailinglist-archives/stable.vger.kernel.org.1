Return-Path: <stable+bounces-257032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBC3A24SG2rM+wgAu9opvQ
	(envelope-from <stable+bounces-257032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:38:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD5660E4F1
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25C4D300E171
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAE933031C;
	Sat, 30 May 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iY9iZnBg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F283090F4;
	Sat, 30 May 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159041; cv=none; b=kYuZviWUmaXgLUW2Z5l0EyIgv0akOjT5V4oDT+DTmiOA5rUEdlVIp0UCSnJxrygFOHoUsY2wzkJ4R1CE6vG8u6vH7J5qks4ChQSDZFvCyWjUE4DUc0AwavqBvUBoN4LFLFosmghf/I7aknYO1TBP/K511Jg9gpeXxq4FqMN4Lv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159041; c=relaxed/simple;
	bh=rB2DM+K+dkm4mMybs0bQF3F4udOBh4IDyTJ9aXsRKJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgsuxv3vCCI+/s2L91sOyIYqSOrNFF/KB7sAPIA+2nbfnTJUO6Hjq5etjAwst9DFRwNrxMS/vOTddYpSuz9uyekG7Sc7SzGSiI0jODOr3xMLbmkeu/dY+0R4k8Fm+x3Kk93HPVVjSzTbFK1h9dP6VphYpYN3vdKz4GsDTFcEq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iY9iZnBg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C11F00893;
	Sat, 30 May 2026 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780159040;
	bh=HJmDqEo74SA15haTFiplSHcLuyYzG87gJ3YI+D4zrrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iY9iZnBgU1roE6vUwd6HtC0+s69Yunf5Qzi1GgoXriU9xLmS8QPOKVnv0DzfPMmk8
	 E5dk7HamnbQ9eG3SoJiBgdi4Y7GPBYcYh0ydoFoaejc7aXx+yixQbqoZ54TYOrmiw2
	 EiLT3bMWvfFLHLwANNqYMChxbv0/9qU3Kq7biBvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>
Subject: [PATCH 6.1 067/969] usb: gadget: f_ncm: validate minimum block_len in ncm_unwrap_ntb()
Date: Sat, 30 May 2026 17:53:11 +0200
Message-ID: <20260530160302.227021944@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257032-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CAD5660E4F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 8f993d30b95dc9557a8a96ceca11abed674c8acb upstream.

The block_len read from the host-supplied NTB header is checked against
ntb_max but has no lower bound. When block_len is smaller than
opts->ndp_size, the bounds check of:
	ndp_index > (block_len - opts->ndp_size)
will underflow producing a huge unsigned value that ndp_index can never
exceed, defeating the check entirely.

The same underflow occurs in the datagram index checks against block_len
- opts->dpe_size.  With those checks neutered, a malicious USB host can
choose ndp_index and datagram offsets that point past the actual
transfer, and the skb_put_data() copies adjacent kernel memory into the
network skb.

Fix this by rejecting block lengths that cannot hold at least the NTB
header plus one NDP.  This will make block_len - opts->ndp_size and
block_len - opts->dpe_size both well-defined.

Commit 8d2b1a1ec9f5 ("CDC-NCM: avoid overflow in sanity checking") fixed
a related class of issues on the host side of NCM.

Fixes: 2b74b0a04d3e ("USB: gadget: f_ncm: add bounds checks to ncm_unwrap_ntb()")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Link: https://patch.msgid.link/2026040753-baffle-handheld-624d@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_ncm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1211,8 +1211,8 @@ parse_ntb:
 
 	block_len = get_ncm(&tmp, opts->block_length);
 	/* (d)wBlockLength */
-	if (block_len > ntb_max) {
-		INFO(port->func.config->cdev, "OUT size exceeded\n");
+	if ((block_len < opts->nth_size + opts->ndp_size) || (block_len > ntb_max)) {
+		INFO(port->func.config->cdev, "Bad block length: %#X\n", block_len);
 		goto err;
 	}
 



