Return-Path: <stable+bounces-220079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BlTEsomo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:32:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA0C1C4E75
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C8C73019E15
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054EA3090D5;
	Sat, 28 Feb 2026 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgt9Kfb6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66E2E54A3;
	Sat, 28 Feb 2026 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299968; cv=none; b=LxT2nZpKHRczVIG9vsZHwECHryWzrsfIzxReuDLBDeti1c5M07sfn5LXIE3o/6wzhz2OVj9JHZEDBlS/7PebEPeMbM7m41QopUm4vbHgVWKt0DVCQumczVS7+g9MFSRFi9VT46Fi36igTJ+PeYNzJTWdJZ+vtPWEjKE/jhM4VWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299968; c=relaxed/simple;
	bh=E9+cyPqKW0RtkA1EiJIhnyPK+6LSG9lKcHTsb9AatU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjsH20irYW79jmPNYlSdRwHwtI8xATWYlWcEXPOnKGbVLYdYThFOpTkDdSHuE9f1qZoAPZdBKz4j+rElcvbf98MBhdBPLwHt7oQKOIz+Pt/zCKYdnUoVOj1LnTYoWnF8Zqoc3ONBqu5IK+IXtp4pS3aGK2VGfg/vF9eqtE/bEEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgt9Kfb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1FAC19423;
	Sat, 28 Feb 2026 17:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299968;
	bh=E9+cyPqKW0RtkA1EiJIhnyPK+6LSG9lKcHTsb9AatU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgt9Kfb60UmOEVaau+dKycPAO+1uYHZ08vwrSngSPChuv+HcDgnZ8Jbg41A9tToFb
	 FXpiw3oyPVpt5uBxO/2gL8RvfRgZqArU1mW6s2Z/V6MWNK6a0p2KPrejjwOmtImODt
	 95INj2UIUOZm/qh4QzTg+Lk75VFETYKa9iEYgJIn1aVSsxjBqrDuTJtoxcpzekYMAC
	 leKwLZURfhqU9qwycNAHCmOOQpGd9TiDjRSeZBOM/m9r690TPXzvL5rBYNbVdVjwwR
	 dy2NaEnfSD6tL/7CKzYTpGliogg7bCFh6XI6TOdmhc8pcLQZIwcsvnX3dXF2lc6OTE
	 FBK/ZvrFJHgvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 001/844] rust_binder: Fix build failure if !CONFIG_COMPAT
Date: Sat, 28 Feb 2026 12:18:34 -0500
Message-ID: <20260228173244.1509663-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220079-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[xry111.site,gmail.com,google.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,xry111.site:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AA0C1C4E75
X-Rspamd-Action: no action

From: Xi Ruoyao <xry111@xry111.site>

commit 174e2a339bf731e080ced67c215ad609a677560b upstream.

The bindgen utility cannot handle "#define compat_ptr_ioctl NULL" in the
C header, so we need to handle this case on our own.

Simply skip this field in the initializer when !CONFIG_COMPAT as the
SAFETY comment above this initializer implies this is allowed.

Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Closes: https://lore.kernel.org/all/CANiq72mrVzqXnAV=Hy2XBOonLHA6YQgH-ckZoc_h0VBvTGK8rA@mail.gmail.com/
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20251209125029.1117897-1-xry111@xry111.site
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder/rust_binder_main.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index c79a9e7422401..9a527268f5b45 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -314,6 +314,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
         owner: THIS_MODULE.as_ptr(),
         poll: Some(rust_binder_poll),
         unlocked_ioctl: Some(rust_binder_ioctl),
+        #[cfg(CONFIG_COMPAT)]
         compat_ioctl: Some(bindings::compat_ptr_ioctl),
         mmap: Some(rust_binder_mmap),
         open: Some(rust_binder_open),
-- 
2.51.0


