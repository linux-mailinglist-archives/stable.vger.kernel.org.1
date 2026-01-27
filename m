Return-Path: <stable+bounces-211775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGmDEoa5eGlzsQEAu9opvQ
	(envelope-from <stable+bounces-211775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:11:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22B994B5A
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C73683029AE0
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB4F3559D1;
	Tue, 27 Jan 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A/c/TGtD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8F355024
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519466; cv=none; b=TI+SkLGck1oqqXsXdfCL9o2aWBKuIMxjRumLcp1BDn3mmdjdlgg0iBrZ8AJnZr0Z+Jg55Q7xlMuRrIHMd1LKI1WTps8PSRP8ZOQelVZZaQUAoBd0i0K9sVGFellxHh16oCe0qX93K1spTTXjnQBwIAOexFN7oJP3tu+OMkAYrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519466; c=relaxed/simple;
	bh=BSUOERwWp+IAYi6GSsD6gq1okWZePOPqJjDYBL7vTRI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QQLyILFiXkdrh/c1O5gQxbJmx9ep7vLMnhfB6TGJC6UXtvsgOloKO4T1hYTK1OgnsDDCexbKV3lPP944WxcWQ19mywCnLBMG8C8P59g0b8DREqU5wO9t0NqgwO0IlPNeqKAz0EbAat35o3yK6ynjeTjsKSDGgKCB5ntNYJkI/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A/c/TGtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FBFC16AAE;
	Tue, 27 Jan 2026 13:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519465;
	bh=BSUOERwWp+IAYi6GSsD6gq1okWZePOPqJjDYBL7vTRI=;
	h=Subject:To:Cc:From:Date:From;
	b=A/c/TGtDsmDfLVmioAuD+At2FuYNahMXEjF+LYsCg49gw7mw5uTCTXEyKWJ8pH7Rn
	 WS/CCYNMJa/4WnxFSjGi6qZNZ86U6PErMQ1mUHdBvBYRx9N27zzFdpPV32LnG6k64+
	 Hv1I35hSva+/JBS9cW5BvUlHhiCfaqpl7tKMs2o8=
Subject: FAILED: patch "[PATCH] ALSA: scarlett2: Fix buffer overflow in config retrieval" failed to apply to 6.6-stable tree
To: samasth.norway.ananda@oracle.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:11:02 +0100
Message-ID: <2026012702-happier-luckily-8c7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211775-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,suse.de:email]
X-Rspamd-Queue-Id: A22B994B5A
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6f5c69f72e50d51be3a8c028ae7eda42c82902cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012702-happier-luckily-8c7d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f5c69f72e50d51be3a8c028ae7eda42c82902cb Mon Sep 17 00:00:00 2001
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Date: Fri, 16 Jan 2026 17:27:06 -0800
Subject: [PATCH] ALSA: scarlett2: Fix buffer overflow in config retrieval

The scarlett2_usb_get_config() function has a logic error in the
endianness conversion code that can cause buffer overflows when
count > 1.

The code checks `if (size == 2)` where `size` is the total buffer size in
bytes, then loops `count` times treating each element as u16 (2 bytes).
This causes the loop to access `count * 2` bytes when the buffer only
has `size` bytes allocated.

Fix by checking the element size (config_item->size) instead of the
total buffer size. This ensures the endianness conversion matches the
actual element type.

Fixes: ac34df733d2d ("ALSA: usb-audio: scarlett2: Update get_config to do endian conversion")
Cc: stable@vger.kernel.org
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Link: https://patch.msgid.link/20260117012706.1715574-1-samasth.norway.ananda@oracle.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index f2446bf3982c..bef8c9e544dd 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -2533,13 +2533,13 @@ static int scarlett2_usb_get_config(
 		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
 		if (err < 0)
 			return err;
-		if (size == 2) {
+		if (config_item->size == 16) {
 			u16 *buf_16 = buf;
 
 			for (i = 0; i < count; i++, buf_16++)
 				*buf_16 = le16_to_cpu(*(__le16 *)buf_16);
-		} else if (size == 4) {
-			u32 *buf_32 = buf;
+		} else if (config_item->size == 32) {
+			u32 *buf_32 = (u32 *)buf;
 
 			for (i = 0; i < count; i++, buf_32++)
 				*buf_32 = le32_to_cpu(*(__le32 *)buf_32);


