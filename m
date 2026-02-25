Return-Path: <stable+bounces-218313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EHgHDxTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F363018F740
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1280B3125D9E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB5220C012;
	Wed, 25 Feb 2026 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mgrLQVdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54218DB2A;
	Wed, 25 Feb 2026 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983117; cv=none; b=Qs42YsjEI2WsQ3OVXvfKBDDcrGN8zY2I+zYYOK4YIfct6XHRcPnS3tO1oiQPMlW8vxpWxI15XIo+ftHYFB9uuBPHOOoOCgIdxCDVQ4L/JXyDBskx8w7VTX2jWTUlc5YcYkLC++qyl9qritlawBR7wj8oELVHjDxa27FHzI6QAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983117; c=relaxed/simple;
	bh=hLGc49nYL8IVfQ7nYp7oQKeQpUA52pAsxdF+8nyHECU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSr3Upk742To8syA0FddceFIW6s9hfEBJbHGV2S7nO0HuSGcmE5A/EAoUg6M8a513Nuzi/uexK43IoIv+4w4qUD26eLJI7ByInlvScuTNX7mJHP/zRD0grMnZAUn9tAR+z9dv+fAjSn1FDcpeO0F9dYmq/E/upN13TO58Ocws9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mgrLQVdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE442C116D0;
	Wed, 25 Feb 2026 01:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983116;
	bh=hLGc49nYL8IVfQ7nYp7oQKeQpUA52pAsxdF+8nyHECU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgrLQVdlXhYLVrsZvljHeRnyA9Mau9VlzTkEueRpv18D9BiqRNKA5wzYt2wX8U2nq
	 Xw+S2mZixJl4Y1R3pzltw2Nq/o5Qz4l3klsYGK+TrStgeABhKP3D4WQ9/WEZhnNRWr
	 bgAdqtu92EPmECffYTdDNDiCAUM/t3YWjxYLJ61A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kari Argillander <kari.argillander@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 276/781] rust: pwm: Fix potential memory leak on init error
Date: Tue, 24 Feb 2026 17:16:25 -0800
Message-ID: <20260225012406.467604294@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,samsung.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218313-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,samsung.com:email]
X-Rspamd-Queue-Id: F363018F740
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kari Argillander <kari.argillander@gmail.com>

[ Upstream commit a2633dc243c35754a0c2270131d8a199c987c9bf ]

When initializing a PWM chip using pwmchip_alloc(), the allocated device
owns an initial reference that must be released on all error paths.

If __pinned_init() were to fail, the allocated pwm_chip would currently
leak because the error path returns without calling pwmchip_put().

Fixes: 7b3dce814a15 ("rust: pwm: Add Kconfig and basic data structures")
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
Link: https://patch.msgid.link/20260102-pwm-rust-v2-1-2702ce57d571@gmail.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/pwm.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index cb00f8a8765c8..2ba9cfd02bfdb 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -601,7 +601,11 @@ pub fn new(
         let drvdata_ptr = unsafe { bindings::pwmchip_get_drvdata(c_chip_ptr) };
 
         // SAFETY: We construct the `T` object in-place in the allocated private memory.
-        unsafe { data.__pinned_init(drvdata_ptr.cast())? };
+        unsafe { data.__pinned_init(drvdata_ptr.cast()) }.inspect_err(|_| {
+            // SAFETY: It is safe to call `pwmchip_put()` with a valid pointer obtained
+            // from `pwmchip_alloc()`. We will not use pointer after this.
+            unsafe { bindings::pwmchip_put(c_chip_ptr) }
+        })?;
 
         // SAFETY: `c_chip_ptr` points to a valid chip.
         unsafe {
-- 
2.51.0




