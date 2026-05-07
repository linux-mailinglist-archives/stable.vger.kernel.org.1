Return-Path: <stable+bounces-244610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBH6Nf3D/GnSTAAAu9opvQ
	(envelope-from <stable+bounces-244610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:55:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7F4EC875
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C2B13042416
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7CE453497;
	Thu,  7 May 2026 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLOKaJ2P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60945107A
	for <stable@vger.kernel.org>; Thu,  7 May 2026 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172751; cv=none; b=iAdGdXl19C62TJq9rou5/Qb44ZTfTSUUvy3DNnuyy2526pFAc3WyPehDr3CkuwfMSvydHwf8Qqei0p4AhO0L4tgapujN+mvvOPEbZZGJ7cT2arQ/5pGvPgSEm/7f0Ai1uL0VXgZQn8DaGTI+gBeBU0QxwFj/uArpb4pAInP/M4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172751; c=relaxed/simple;
	bh=aHoBqTbdr56DO71Zlzzaandq5SHQ8sCJYyYln2KmSW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBza/eFvWzCHmzRas/uuNOsTqyCR6JMBM/515hwuTfVu6BtZ3PVvVGKu6I2b6jPmmZ+HMRrFw+uicL2GNrttrpNZ0KlTSS7vfP60oVdeIvpCgw3VFRyID21vMSGQpFDMUjfPvOgkT4AHdSx8UFQRIZ+HjK7Ff33JGEtntqyCyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLOKaJ2P; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b9ea536877so8108745ad.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778172749; x=1778777549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yv2fHWPI4GY7ycdmc2I4lTP92YQsllQ8O6sfU4iOItg=;
        b=hLOKaJ2PpTO1yTKqpMknJRZzPhXHNq7xaXp8V5BnrxFTCvd0QcDK0DZAgm9VzK5bTT
         Bux/AzMC2D7MJSLwhzTFDYnZc/PcFfAPrt8RjuB79Xlff9UFigczDKCeflfeCkGTz2G7
         HABg0Kz931SdXv4whao41c0gDBwe/KKq6Y93up4S8hhGD6St0cVinpDlhAcwwesiCqFs
         Z31FaqJ6koWowukjj/sUlfYD1qGPef56yjJbpvWTC/ZDLJf7Or6GBkk1inCS5dXXNvHH
         TEnPVgXz9V6ixzjwa7SYJTbCt+ZIiVAH4LzRzP2VOMF76lXLsF0xCUxlnpIInpu0Rg1C
         y0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172749; x=1778777549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yv2fHWPI4GY7ycdmc2I4lTP92YQsllQ8O6sfU4iOItg=;
        b=JZ6rmgTxIexmb2NTqElKlORN2ULJ3ydjJk8BmL1YSbtx+YAOjjpkEW/x0ohG2HGfJV
         hyHKSZGUrKMMaBG83Y7FVUfQUNwsiBIp9g8P1UP1ubOEWs7D6uBw0e/NhGGUTmAyZDCQ
         kxYzuzN35uTyx6QIpjkZfOYp7JKIrs9IfS/NUNzmdzBpo3A4YhZZRwqDOgI5vuQOSNBh
         ks3VvOfyMDcIv12Q4oB+TK8TTKFV/66GMZIpvOzSjSgE0a8gd4YV3byM4rmZSQtm8k3C
         DuCwHJm5Mlcl2CdbLFmGkfWpdVjXBqboQDv7JONJZHK/v3artoU0V+PTu86N0csP6EJh
         zkPA==
X-Forwarded-Encrypted: i=1; AFNElJ9dmZs5qkywZKYghaGOVbfGpCO5N7RxoNFzaeuPGKHy5351LrxVaG6KOWUaU9FW/GlUJJ4SStw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX4ZMcWEv/ve+SCbzkuA5/fTolZRA0dBw6Y6iXb7+/bvUX3BKw
	7BK0c6ZBJf5tnyxWmggC5tGBpYDAHHOy0hPqfmwuDJ2lzGjPCwt0jm9M
X-Gm-Gg: Acq92OEgfvAMEUNYnM7MGseaUkNwxQScppD2YUmdcMi0EU7gKa6zMZmC+jFrh5JWgGY
	ul5MjOiIPnGmaW187xR02lhB4U8kOvMpF9cj7t4sqe+7u2RCvmzCpJz1FsvoDWLAZxVQmZrrYAC
	oN4KLEFNKhcP9ATpN4tj7RTbdhyRDF/HVvJZOMM9xG/cxviP5SDqD1pXKyhbc/+J2PfJiuMyh3l
	E5FdWUgV2J/ogOlU+/TFyGyFunidLuoSK9zorw4ugt3a3V1sLb2Qmau0wgyLB5a2ifYx01w4tKI
	6C6B3pm94aeWBRHBmytDZQPhjNRqtu/Z5G/vIThS4mw5kcl656NaxFrFHalxHe+JWTgVOJwkUMY
	H694EjfC2/ElrjT2yCAG1CbINQbkav368tRrwvNwKwxYsmvulNyw3Vd+QOdtcLGncQQi+FNpu+1
	8rPIxSDCHNJP5uuKaJEu34xhdg2y1HibVE7d4FjBw=
X-Received: by 2002:a17:903:4b03:b0:2ba:21c2:d6cb with SMTP id d9443c01a7336-2babd4bdb6dmr31502595ad.16.1778172749225;
        Thu, 07 May 2026 09:52:29 -0700 (PDT)
Received: from localhost ([49.207.150.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae783dc50sm2551575ad.43.2026.05.07.09.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:52:28 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
X-Google-Original-From: Piyush Sachdeva <psachdeva@microsoft.com>
Date: Thu, 07 May 2026 22:22:14 +0530
Subject: [PATCH v3 2/2] smb: client: Zero-pad short GSS session keys per
 MS-SMB2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-kerbmi-v3-2-397ebbb53eff@microsoft.com>
References: <20260507-kerbmi-v3-0-397ebbb53eff@microsoft.com>
In-Reply-To: <20260507-kerbmi-v3-0-397ebbb53eff@microsoft.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Tom Talpey <tom@talpey.com>
Cc: samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, vaibsharma@microsoft.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3414;
 i=psachdeva@microsoft.com; h=from:subject:message-id;
 bh=aHoBqTbdr56DO71Zlzzaandq5SHQ8sCJYyYln2KmSW0=;
 b=owGbwMvMwCV29FJ3ncRHDT/G02pJDJl/Djv5n01fPnF6wi83E+7DM3gmtQm4HoiepBY1uZTl8
 JPUFofrHRNZGMS4GCzFFFk2nLgjyxu/S3LepydGMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEz1rmhGhl3Z+fqduVN3PKrUWPizViSXMyR50q3G2+V9rS87JQqKuRkZDv53CLH
 Zq7rpwDS+S/4HPjx+HeCpof6Laa5EUNHBg5X5TAA=
X-Developer-Key: i=psachdeva@microsoft.com; a=openpgp;
 fpr=80350F71F916134953C3EB979E19C6F9839C3CFC
X-Rspamd-Queue-Id: B6B7F4EC875
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244610-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

Per MS-SMB2 section 3.2.5.3, Session.SessionKey is the first 16 bytes
of the GSS cryptographic key, right-padded with zero bytes if the key
is shorter than 16 bytes.

SMB2_auth_kerberos() copies the GSS session key from the cifs.upcall
response using kmemdup(msg->data, msg->sesskey_len, ...) and stores
the GSS-reported length verbatim in ses->auth_key.len. generate_key()
reads SMB2_NTLMV2_SESSKEY_SIZE bytes from this buffer when feeding the
HMAC-SHA256 KDF for signing key derivation. If a GSS mechanism returns
a session key shorter than 16 bytes (e.g. a deprecated single-DES
Kerberos enctype with an 8-byte session key), the KDF call performs an
out-of-bounds slab read and derives keys that do not match the server,
which pads per the spec.

Modern KDCs disable short-key enctypes by default, so this is latent
rather than reachable in production, but it is still a kernel heap
over-read.

Allocate auth_key.response with kzalloc() at a length of
max(msg->sesskey_len, SMB2_NTLMV2_SESSKEY_SIZE), copy the GSS key in,
and rely on kzalloc()'s zero initialization for the spec-mandated
padding. Set ses->auth_key.len to the padded length. Larger GSS keys
(e.g. the 32-byte aes256-cts-hmac-sha1-96 session key) continue to be
stored at their natural length, preserving the FullSessionKey path.

Emit a cifs_dbg(VFS, ...) message when a short key is encountered to
surface deprecated-enctype usage.

NTLMv2 and NTLMSSP code paths produce a 16-byte session key by
construction and are unaffected.

Signed-off-by: Piyush Sachdeva <psachdeva@microsoft.com>
Signed-off-by: Piyush Sachdeva <s.piyush1024@gmail.com>
---
 fs/smb/client/smb2pdu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index cb61051f9af3..995fcdd30681 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1713,17 +1713,30 @@ SMB2_auth_kerberos(struct SMB2_sess_data *sess_data)
 	is_binding = (ses->ses_status == SES_GOOD);
 	spin_unlock(&ses->ses_lock);
 
+	/*
+	 * Per MS-SMB2 3.2.5.3, Session.SessionKey is the first 16 bytes of the
+	 * GSS cryptographic key, right-padded with zero bytes if shorter.
+	 * Allocate at least SMB2_NTLMV2_SESSKEY_SIZE bytes (zeroed) so the KDF
+	 * input buffer is always valid for HMAC-SHA256 even with deprecated
+	 * Kerberos enctypes that return a short session key.
+	 */
+	if (unlikely(msg->sesskey_len < SMB2_NTLMV2_SESSKEY_SIZE))
+		cifs_dbg(VFS,
+			 "short GSS session key (%u bytes); zero-padding per MS-SMB2 3.2.5.3\n",
+			 msg->sesskey_len);
+
 	kfree_sensitive(ses->auth_key.response);
-	ses->auth_key.response = kmemdup(msg->data,
-					 msg->sesskey_len,
-					 GFP_KERNEL);
+	ses->auth_key.len = max_t(unsigned int, msg->sesskey_len,
+				  SMB2_NTLMV2_SESSKEY_SIZE);
+	ses->auth_key.response = kzalloc(ses->auth_key.len, GFP_KERNEL);
 	if (!ses->auth_key.response) {
 		cifs_dbg(VFS, "%s: can't allocate (%u bytes) memory\n",
-			 __func__, msg->sesskey_len);
+			 __func__, ses->auth_key.len);
+		ses->auth_key.len = 0;
 		rc = -ENOMEM;
 		goto out_put_spnego_key;
 	}
-	ses->auth_key.len = msg->sesskey_len;
+	memcpy(ses->auth_key.response, msg->data, msg->sesskey_len);
 
 	sess_data->iov[1].iov_base = msg->data + msg->sesskey_len;
 	sess_data->iov[1].iov_len = msg->secblob_len;

-- 
2.53.0


