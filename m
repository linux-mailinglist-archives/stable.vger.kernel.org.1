Return-Path: <stable+bounces-217932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLFIKp3snWncSgQAu9opvQ
	(envelope-from <stable+bounces-217932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 19:23:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA3C18B4DC
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 19:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D51C530E4F55
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4542C11E8;
	Tue, 24 Feb 2026 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7nJ35jY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043302C027C
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957013; cv=none; b=TT+0enbNK5HSUXMJlKwWY0RRW5JGRhdVIcPaBDJcbzaZDzxELyAQutwJNBOeT/V0Q/loKUBWCROvsuoo1qFNr7WCMNzxElpOXN8aLphTf43UF9aeYuVdsQz5337JCS3u0a9xd2P6oSF++dgo7WcN0ysGVJRPnhLinkwdAfz1GFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957013; c=relaxed/simple;
	bh=1tkVRXlNkR9Fmy1nO0DHn37Is2OgEtPJWOq31cgnHx8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Forqc6jX9h5xuAR5vF26vT3DiFNj8t04cqbmHBeOJaedsSm5+WBtavbbMOvNEDrxsZHiOpQtwk1xqqgkPRasLnyrNs6g/TgPmaHnV0sZgTb2vYyyQ1CEQvEg5ktrrgzuZgv0gZQcsc+L0Hmpd8B6HB58YUACV5xCSw2dCRIiZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7nJ35jY; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b88622fbe54so138780866b.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771957010; x=1772561810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aWRna/o7J6EKgHI9SPvVfoppVmpzZKMT5lNJXeS/XVM=;
        b=K7nJ35jYwW6QSefvIXFHZ/w0StHGqePyGy4CB+e1tzVTfvrrzcudp5CfOH9k1xBpEw
         A70536GTviy7BZ623hSZHh01+9ZEL7Yv7tdf7Iuw827lR3D8qTe+xXEtZYdt2U4G+2NF
         PcvwRfVErv3B3rWYC+6XwjRNAsaN9DJy2DRovK+JfZ6vRdMtJ2WqR/PS3Jr2EjDvDcN2
         1yt0GgZAxZYudutNA/59hhhF7R5bZvN3sk0gYnFOEVuPwaKoLA2kCkln8ZYiKMy1RhBj
         RrUrRo8ZwQcxCIBzYuLH4qwDR7abX5h9CxcEcz5/R56pNFZaFRUcwANFVcdj3p1rPM/V
         oUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771957010; x=1772561810;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWRna/o7J6EKgHI9SPvVfoppVmpzZKMT5lNJXeS/XVM=;
        b=XSDg1/LigLlq9xruacnA3sjfdzIY2zpLDj5hSy0McWHyXirOOQz6mgYps8PAHJwzeH
         J8/wj0eth05jARM4Y+JWeX67P/YhZVmEaw2zfR02S3vO2dD0DL04u/Mc6VSx4EQ+V59p
         e4l4vwFmBVLQoIqimlv10/Q4TpqHb53ssvMARfLS0ehG3UKLE9YYMlgXACaosDrVWVsx
         CQt7r5gekCR4TR6R0lYNr8Ivjbtn3/m4gtWtUkuKW9Jg9ynTSX0mwxu7CzD6+NQcOfN1
         vAv9HvkrKQ1Ym2khKyaY49nvksLdemAurV8wIVNkn1Q63rISQ9h02VAycQVx9aElZUBU
         PkJA==
X-Forwarded-Encrypted: i=1; AJvYcCWUdna4lpIymF4MGRyXr1ilunUmuBCoBgCGWPfe5mkZZiQkBlCwdOYLDt34X/zdnTESWMMzQHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSgPRBwQq4SnhuX5Xvxvr0n5T5SaaUnUYU8VV0pDp5O/NyFyF
	459XNwwzh6AWRqR23xKt5Qx4sLfOvaNLWB3E86YBK1qUWKEyX+KH6QJ0jeVseiCIBto/IypNIPe
	rD4vVuDWTpmDTwsIg6w==
X-Received: from edya24.prod.google.com ([2002:aa7:cf18:0:b0:658:143:cbdb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9308:b0:b90:47e6:e0ad with SMTP id a640c23a62f3a-b9081b6dc76mr879570166b.56.1771957009985;
 Tue, 24 Feb 2026 10:16:49 -0800 (PST)
Date: Tue, 24 Feb 2026 18:16:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAbrnWkC/z2NwQqDQAwFf0VybsAGFe2vlB5081qDZVeyIAXx3
 7t48DZzmdkpww2ZHtVOjs2ypVjkfqsozGP8gE2Lk9TS1SINTxYVzopRL04RvHoK/E1hYYg2vbS TDF1LpbM63vY7H8/XcfwBuOaJD3MAAAA=
X-Change-Id: 20260224-binder-dead-binder-done-proc-lock-e2d4825b2965
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=1tkVRXlNkR9Fmy1nO0DHn37Is2OgEtPJWOq31cgnHx8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpnesK7Fm0Sl+mGuKgqGOVK8Oy8n4pDAOTIp/Zp
 +CO0DK71pmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZ3rCgAKCRAEWL7uWMY5
 RqGID/9T3kWXlSFd9MQx732cdnl8ctymu3Br4l8pGx9Bf9S1XAgLb/WQhisXY2j5d+dfWNZvrZX
 uq/mUzgzfZdwiQcIng+XyT6bsZnyN4Q74Z3sjsgqsd+inEwf3f4OlQi9vzLqIMtHPuWTORDp9SF
 suvPnCik9X5er95WBsJ1UnBSWjmZ8HRcHIcfjMQD7OKMIdMUr3lybpmu0F+aeFPReD2ImQJO52L
 9xPgMRZnwL8uy7lVJs87EgyzNvpkcLNjeCj9vXHZs6F26aNUofX7OFeDsdXil91VKRsyiMxXA1p
 PKVIbsKNpRVxbhJaHQX3TgLu+8P2eSGuOLutwuTUaD1zkrSeqza3S4z5NBu8gZwJFwiG+hWASUK
 FCQjBFjx3EoXipnl5tqjVL430AOGZsJ6z06eaH7j0tBsjze9OzmeR3YbzescZEJuLZM8dCcUXBL
 st6on8qGd1nTQdSN28cmrKHhTo120jv8mtdEnTlurteGM8kDtCC55eEDNHaOCntzsxu41LEabId
 PHMu6GnuggsLk5uOE9Zp1cKdk2Il4NabO/5aKAxImfNJAkgWwk8caC0nEKy4N/nFNHV9Uw9HOB4
 lmtqD1syRclXcEnv/4MQO1wCoaf48SW8O+9YJGEM1jVOZcO25hMu5J8OhyI9MleD2t1cOW+9r1x 2/6f+19Nv0foVqA==
X-Mailer: b4 0.14.3
Message-ID: <20260224-binder-dead-binder-done-proc-lock-v1-1-bbe1b8a6e74a@google.com>
Subject: [PATCH] rust_binder: call set_notification_done() without proc lock
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217932-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,c8287e65a57a89e7fb72];
	NEURAL_HAM(-0.00)[-0.964];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 2FA3C18B4DC
X-Rspamd-Action: no action

Consider the following sequence of events on a death listener:
1. The remote process dies and sends a BR_DEAD_BINDER message.
2. The local process invokes the BC_CLEAR_DEATH_NOTIFICATION command.
3. The local process then invokes the BC_DEAD_BINDER_DONE.
Then, the kernel will reply to the BC_DEAD_BINDER_DONE command with a
BR_CLEAR_DEATH_NOTIFICATION_DONE reply using push_work_if_looper().

However, this can result in a deadlock if the current thread is not a
looper. This is because dead_binder_done() still holds the proc lock
during set_notification_done(), which called push_work_if_looper().
Normally, push_work_if_looper() takes the thread lock, which is fine to
take under the proc lock. But if the current thread is not a looper,
then it falls back to delivering the reply to the process work queue,
which involves taking the proc lock. Since the proc lock is already
held, this is a deadlock.

Fix this by releasing the proc lock during set_notification_done(). It
was not intentional that it was held during that function to begin with.

I don't think this ever happens in Android because BC_DEAD_BINDER_DONE
is only invoked in response to BR_DEAD_BINDER messages, and the kernel
always delivers BR_DEAD_BINDER to a looper. So there's no scenario where
Android userspace will call BC_DEAD_BINDER_DONE on a non-looper thread.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
Tested-by: syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Sorry, no report link. Was reported via internal issue tracker.
---
 drivers/android/binder/process.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 41de5593197c..f06498129aa9 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1295,7 +1295,8 @@ pub(crate) fn clear_death(&self, reader: &mut UserSliceReader, thread: &Thread)
     }
 
     pub(crate) fn dead_binder_done(&self, cookie: u64, thread: &Thread) {
-        if let Some(death) = self.inner.lock().pull_delivered_death(cookie) {
+        let death = self.inner.lock().pull_delivered_death(cookie);
+        if let Some(death) = death {
             death.set_notification_done(thread);
         }
     }

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260224-binder-dead-binder-done-proc-lock-e2d4825b2965

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


