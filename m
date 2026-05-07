Return-Path: <stable+bounces-244608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBUYO53F/Gk8TgAAu9opvQ
	(envelope-from <stable+bounces-244608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 19:02:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791C4EC9C0
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 19:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73B413040C2E
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED631F983;
	Thu,  7 May 2026 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ8vnqbX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C42F532F
	for <stable@vger.kernel.org>; Thu,  7 May 2026 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172744; cv=none; b=K+6kt1XYEqh/YzQCweX0TfrrsmCnihFmCV3JY/0Bb43Ib0xDv6j0qPz8YOSn/Fy6bx+3SoIzyavBoI3B891S2zUFVcfCDjvHfNE3i3YR5U9R5fkGNMWrM2x+0hAQzqeV3d2D+SselYRXAEu9rkH9WnNH34buOXA6dFIcCtUGHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172744; c=relaxed/simple;
	bh=QhvtuPuYuRikxrXlvfGt1GYpisVF2O1XfkkjalC53Gw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SchTgqI29oJ+TjKB0/jxOKGWXVaMjMgQ7d+slW0/oJ/pwjSlNzgH6CHig0o9TRsOAAz84QcqiaOGnCIHFbT44n8PeId0O7LLUE8AYaN7Do3AjW/q59LusNBLknkgWfOFKJHsd9ZlFh2u1i6HxYU97wgoJkGySZankaZxmbLIzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ8vnqbX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so679161a91.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778172742; x=1778777542; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHS86kLfvSZEt6u0DRNxMP3AK+yT0cLfftthW3UK2M0=;
        b=IZ8vnqbX0ySDjCyZnYCi2oTYizpZSy/rVnU90FHeNnXCe/lG4H5VguUR5szRgmVgnn
         hOI55m1zbS7oJMLKoKeD5HQRxElDZgU3TPDjDfdZTgKIWV8d5Ryuj/8k+5YxhxyV5rZi
         kPLSokG9f3YNwpKfrrldIUtgixlmT/8s0FScal0JniyqyrkWd8iTp0I5Z0hd1vZo5txc
         JhP1XByDbBoH3tzyjwpBv+nQW66tIzxjWZ/cMekvkuwQ2saiOdYAWF126Ko3Vv39Kk40
         Gf+ygIXEWk7xdvXlGUPQb9QV972j5vx+b/3DWMPVafy1RM3YIWYaEn9d4ms9O44jEfed
         lERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172742; x=1778777542;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHS86kLfvSZEt6u0DRNxMP3AK+yT0cLfftthW3UK2M0=;
        b=Pn3jR03mWvQ55TQypBLGyzrNXUXSmO37uz3E6tojbjrjgmVmlzukjAm+/8SzMWoPAp
         BMgtFHVpivHxnSUsCSiKkkojzzoqIzBubDqr7UMVYJaA34AWWXj7MXVJGOxVDV+knSs1
         /vlZrQ4d4aJzo+Qa0c44ZE7l0WB4y40bcPV0zw4IcJ/htudi6SQVPGt4PjCvBt+8k0l7
         RYVD389vkvGqTXhXHIY0Na0E3oazi72ijQLfb7p3fG/zOAvBqPX1sxBchL6ErO4l719Z
         ZJQk1vs7k8b84vcqVT7s0jeyKDLfMVB/i93sZokHaq5KkQYpFzqBEhu0culGJyODtt7/
         v8Xg==
X-Forwarded-Encrypted: i=1; AFNElJ9UFh3Tamd+Acfz1Y6r1uQy8MTgOaJa2bk1FqbWU5rgvmngxb+IrOauBuLC2Lim1MOD9Pc12i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0GcUZLegpfjt6kRxsu0d1CXLfiqphqwuqWpBr01tBI+NMTpot
	nFJP0eSxNLUSCNge7hhHXe61cQ5vuPDqL6c5yfXZaAkFjX0UO/xTuZt7
X-Gm-Gg: AeBDieu1On4tZ6HaY8gTw/ADHYq+wvdDzNA5QFy2dtSYQVKfPYk/UZIfFbfNvL7IdaD
	Qu8XM5F5ryaoCGL1i4DmzxJH02Qf0go+MbRk/3/sD+E7BPtPmku3iSzp5IqYdsMp8rNX1jZPyUp
	I0k+nGxjtUYQA0Q9OyCQQhIcSx1UYbtrMnhC8YXygnl6GChdQYVahR2NkhG8dm7wMuDjK+6WhV1
	6oalCTt+1hGUoJz7sP/mCiXS4IT7oelEukmRu1+f7b1AVDppFCzFr0p2LPDQYjGBn15wNq/S+GF
	nc6l7tB0m7BrviuCW95AEsLkTxNIRf1O6ERnpoSeRWqmS3Tc9hiFesfCW6JLaoattJ62FE6PJWI
	LxPdmR9N96McBV8F0M0ZkBY2BF2A6euDD3k2eZarPuMOz9kiFX0zW5bvR6olxLSLg0uQbe5yspS
	6qcUVkR/GX1refTPG5rD7USOE7bghqFsbSgT8Xo0kghoRspo00cQ==
X-Received: by 2002:a17:90b:3ecd:b0:366:3517:1a98 with SMTP id 98e67ed59e1d1-36635171b07mr1354381a91.0.1778172742408;
        Thu, 07 May 2026 09:52:22 -0700 (PDT)
Received: from localhost ([49.207.150.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4bd67b1sm9638608a91.1.2026.05.07.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:52:21 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
X-Google-Original-From: Piyush Sachdeva <psachdeva@microsoft.com>
Subject: [PATCH v3 0/2] smb: client: Spec-compliance fixes for Kerberos key
 derivation
Date: Thu, 07 May 2026 22:22:12 +0530
Message-Id: <20260507-kerbmi-v3-0-397ebbb53eff@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNQQ6CMBBFr0JmbU0zFQOuvIdhYYepjAZKWiQa0
 rtbUJcvef/9BSIH4QinYoHAs0TxQwazK4C663BjJW1mQI1HfcBaPTjYXlRLuioNtVg7giyPgZ2
 8ttCl+XJ82jvTtK5Xo5M4+fDenmZcvV/U6H90RqWVtnXlGMv8Vp57oeCjd9OefA9NSukDAbn91
 LIAAAA=
X-Change-ID: 20260429-kerbmi-dc0853cd29fc
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Tom Talpey <tom@talpey.com>
Cc: samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, vaibsharma@microsoft.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3196;
 i=psachdeva@microsoft.com; h=from:subject:message-id;
 bh=QhvtuPuYuRikxrXlvfGt1GYpisVF2O1XfkkjalC53Gw=;
 b=owGbwMvMwCV29FJ3ncRHDT/G02pJDJl/Djt29ets/C4cHbakV6Ptv5ByCLPywWLreA9z4eML9
 KJebz7dMZGFQYyLwVJMkWXDiTuyvPG7JOd9emIEM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6BgzcHEKwFRrTGJkmL5nbW9+q87HpdH5Gr17C1T+v/k2eTlbEKfbJwt7td2rtzEynKn8cSI
 rwac1bWFr6Oy59+Q9pi9UZUgVfyW3hnt6NIc6IwA=
X-Developer-Key: i=psachdeva@microsoft.com; a=openpgp;
 fpr=80350F71F916134953C3EB979E19C6F9839C3CFC
X-Rspamd-Queue-Id: 1791C4EC9C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244608-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[samba.org,vger.kernel.org,microsoft.com,manguebit.org,gmail.com,talpey.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spiyush1024@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

This series fixes two MS-SMB2 section 3.2.5.3 spec violations in the
Kerberos session key handling path of fs/smb/client.

Patch 1/2 (resend of v1 with a small cleanup folded in) fixes the
AES-256 mount failure with sec=krb5: encryption and decryption key
derivation must use Session.FullSessionKey (the full Kerberos session
key, typically 32 bytes for the aes256-cts-hmac-sha1-96 enctype)
instead of Session.SessionKey (the first 16 bytes).

Patch 2/2 closes the related corner case in the same section of the
spec: when the GSS protocol returns a session key shorter than 16
bytes, the buffer must be right-padded with zero bytes. The current
code copies the GSS key verbatim, which causes generate_key() to read
past the end of the allocated buffer and derive keys that do not match
the server. The trigger is deprecated short-key Kerberos enctypes
(e.g. single-DES, 8-byte session key); modern KDCs disable these by
default, so this is a latent issue rather than a reachable one, but it
is still a kernel slab over-read and a literal spec violation.

Verified against Azure Files (AES-256-GCM + Kerberos aes256-cts) which
previously failed to mount with EAGAIN; the dmesg "Session Key" trace
under CONFIG_CIFS_DEBUG_DUMP_KEYS now shows the full 32-byte session
key being used for encryption/decryption KDF input.

Link: https://lore.kernel.org/linux-cifs/20260409161538.3618-1-s.piyush1024@gmail.com/

Changes since v2:
  - Patch 1/2: cast ses->auth_key.len to int when used as field width
    for "%*ph" in the CONFIG_CIFS_DEBUG_DUMP_KEYS dump, fixing a
    -Wformat warning. Reported by Sashiko.

Changes since v1:
  - Patch 1/2: initialize full_key_size at declaration to silence
    -Wmaybe-uninitialized on some toolchains, and drop the now-
    redundant else branch (self-review).
  - Patch 1/2: tighten the FullSessionKey condition to also require
    Connection.Dialect == "3.1.1", matching MS-SMB2 3.2.5.3.1 verbatim.
  - New patch 2/2: zero-pad short GSS session keys per MS-SMB2 3.2.5.3,
    eliminating a latent slab over-read in generate_key().

Signed-off-by: Piyush Sachdeva <psachdeva@microsoft.com>
Signed-off-by: Piyush Sachdeva <s.piyush1024@gmail.com>
---
To: Steve French <sfrench@samba.org>
To: Paulo Alcantara <pc@manguebit.org>
To: Ronnie Sahlberg <ronniesahlberg@gmail.com>
To: Shyam Prasad N <sprasad@microsoft.com>
To: Tom Talpey <tom@talpey.com>
To: Bharath SM <bharathsm@microsoft.com>
Cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: linux-kernel@vger.kernel.org
Cc: vaibsharma@microsoft.com

---
Piyush Sachdeva (2):
      smb: client: Use FullSessionKey for AES-256 encryption key derivation
      smb: client: Zero-pad short GSS session keys per MS-SMB2

 fs/smb/client/ioctl.c         |  2 +-
 fs/smb/client/smb2pdu.c       | 23 ++++++++++++++++++-----
 fs/smb/client/smb2transport.c | 35 ++++++++++++++++++++++++++---------
 3 files changed, 45 insertions(+), 15 deletions(-)
---
base-commit: 0cbc300257d9b399491909806777f504ec687c1d
change-id: 20260429-kerbmi-dc0853cd29fc

Best regards,
--  
Piyush Sachdeva <s.piyush1024@gmail.com>


