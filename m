Return-Path: <stable+bounces-223593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKrwFsChrmkLHAIAu9opvQ
	(envelope-from <stable+bounces-223593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:32:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC1237226
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C656C30530A2
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B65036404E;
	Mon,  9 Mar 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc/5g3dh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5691238178
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052260; cv=none; b=c/sLe+/wwlZFX6epO/0OfHVQkXPDzaZkn3QfwqYWUxngF9y2BO/v0G8+UzJ2IJ1cUltosJL8K7uxMzsIqCoGRJenzP1NaYGCZQjrdpKwtCYmzZU8Kyj7lpqIN7bxBq3sjm0A/+/n0ddVfUy0S1UqNKShjHd1mnS5F3g/8d50f2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052260; c=relaxed/simple;
	bh=I4VhLGxV7OVpyVEPKpRlfLvPe7al9k3jMKaog6stCmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0srC2OCi2rRCgswfbScBqORgA9OTa4ZKtlMlUCPijUdlH0GkUlr1kVKBxR7GWW1m4D0GEWVp1rnegpSgV6e4ICQxd5PlcklGkh3K+jtBcErNBuTSdj/9eLP0UbtN/CelGiKqvbgEJKAEX6rOPDk5HjhoC1DX/VexlIN/Wtee3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc/5g3dh; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3597fea200dso6128417a91.3
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052259; x=1773657059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt1A8GB8orVztyFXC9NAQIyKbNAxGtNa35UhGGLkqWo=;
        b=dc/5g3dhL1G4eHzFA2hkVuqy4NHOHi3rJmR+wQb76eZQugJxSWM3amXwMm9zealzvm
         zm/BGdu+HimBOByCXShWgvWr+0Th0vERQ6NhxqxzZ1trGxG/tb/nZHpS3hQmnL4w39uH
         gtW4+ieRdnsIFw94S4+sUTCzamVCksWmrOrwni7N4yKx9StgBEiTNelSFf3u2yiTjuvn
         Cg7l/kbplAUwmDTY1hAnB8FXiwlv43a+Tmz7ez7PnxhaZQPT5Oigr05o8pu3cSaHabes
         69DPhCoKMfrPnOeC9m7VjVMhAtGm7rHuVNgez4PIYwdKxRKWnZPajsU6IT7bCE+XLrGM
         n0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052259; x=1773657059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt1A8GB8orVztyFXC9NAQIyKbNAxGtNa35UhGGLkqWo=;
        b=cZO3AxT58vE/T2d8iw15TE9gU+IMjk4O05yvvjANhCIe/FEYPMUoQcW2ndq77bcrTd
         Qr7cgW+H2LkEx4spOQREpBCwjk63gmEsBXuGAx86CSyMd0CpPfaG5RkDTf3WvupHhO3z
         vA4fSC4sHBMXjDtOXO9AKAOoMVfnmC5s8R1QrmtT/AehmDM3tnjmBXPxFAmW/OyMD7rp
         42AqLteKSMmDMFSheujeEjJwN1NQ9sfBzOwGWLu/1gD0Zqz7qm7kmKYljaNZpeFMyDGd
         RUa+0vK1QddCf4TLwmms7RmO9UAU2PISCgCIgnZu4OB4RG+cNLhzyRMulGxYnpcngkHj
         fWzg==
X-Gm-Message-State: AOJu0YwkQEDwKVzfEwNCeBNKJopTGYUAsfCXrCkCBS2Rirf3eVCFyWkg
	Wb2QJmPjmIuLgxdZnV9lT6NoQEHvCqDl0Msc8P0PHDrREigpOqG8Eiv0
X-Gm-Gg: ATEYQzzVcZw++TwPw3ISnH+FgvyOW8Q18v318aG1A89pqLVvU0ysKNQxG8UtCpNv0I/
	AeUpJHVV4LZJjbObaZiHd5bmRor+4GrCYvfJBgkpsryFBb6e6YrGGXlfFriDyT8rRslhKma3L2O
	HofIufpRQzeK/7Rq1BZarlj+7BBjImbwysXWdgiH36OsY4tkxlaAOdLHIOX4kKS90TdlgANEgOz
	WfT24CppXbpj0mm4fageAgCYYElx8VIKmui98wrTLK4zhdrUXe0vX8hY7K0g50lXbMyco+2+wPD
	OZXM4OWFiP6AhGpoWrAGvj/8Eq3Wrgu1y7FeUVhj5hR4HoWhffD9jKGKglzCGjlSDe/bYNjOoL1
	Bo8irujhyseyDWl7uuUbwq3FJ9VacD7FJO4002tZjeWmRHNPxIuOKc8xz98UXq+JWmLnA4BNd1a
	K/MsYBpdNZTwO51xsiJU7HFNdlaDFWyWso2/bYNUtFhlqnmZZ/yix4tHC0/VCmYg==
X-Received: by 2002:a17:902:ce88:b0:2ae:593c:48fe with SMTP id d9443c01a7336-2ae823cb7d1mr107829595ad.13.1773052258942;
        Mon, 09 Mar 2026 03:30:58 -0700 (PDT)
Received: from bharathsm-Virtual-Machine.. ([167.220.110.101])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2ae83e57c1csm154206615ad.18.2026.03.09.03.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:30:58 -0700 (PDT)
From: Bharath SM <bharathsm.hsk@gmail.com>
X-Google-Original-From: Bharath SM <bharathsm@microsoft.com>
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	dhowells@redhat.com,
	sprasad@microsoft.com,
	pc@manguebit.com,
	ematsumiya@suse.de,
	henrique.carvalho@suse.com,
	bharathsm@microsoft.com
Cc: stable@vger.kernel.org
Subject: [PATCH] smb: client: fix in-place encryption corruption in SMB2_write()
Date: Mon,  9 Mar 2026 16:00:49 +0530
Message-ID: <20260309103049.22169-1-bharathsm@microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E6FC1237226
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-223593-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,redhat.com,microsoft.com,manguebit.com,suse.de,suse.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharathsmhsk@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.957];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

SMB2_write() places write payload in iov[1..n] as part of rq_iov.
smb3_init_transform_rq() pointer-shares rq_iov, so crypt_message()
encrypts iov[1] in-place, replacing the original plaintext with
ciphertext. On a replayable error, the retry sends the same iov[1]
which now contains ciphertext instead of the original data,
resulting in corruption.

The corruption is most likely to be observed when connections are
unstable, as reconnects trigger write retries that re-send the
already-encrypted data.

This affects SFU mknod, MF symlinks, etc. On kernels before
6.10 (prior to the netfs conversion), sync writes also used
this path and were similarly affected. The async write path
wasn't unaffected as it uses rq_iter which gets deep-copied.

Fix by moving the write payload into rq_iter via iov_iter_kvec(),
so smb3_init_transform_rq() deep-copies it before encryption.

Cc: stable@vger.kernel.org #6.3+
Signed-off-by: Bharath SM <bharathsm@microsoft.com>
---
 fs/smb/client/smb2pdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index c43ca74e8704..5188218c25be 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5307,7 +5307,10 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 
 	memset(&rqst, 0, sizeof(struct smb_rqst));
 	rqst.rq_iov = iov;
-	rqst.rq_nvec = n_vec + 1;
+	/* iov[0] is the SMB header; move payload to rq_iter for encryption safety */
+	rqst.rq_nvec = 1;
+	iov_iter_kvec(&rqst.rq_iter, ITER_SOURCE, &iov[1], n_vec,
+		      io_parms->length);
 
 	if (retries) {
 		/* Back-off before retry */
-- 
2.48.1


