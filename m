Return-Path: <stable+bounces-233353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFWzNPdl02nmhwcAu9opvQ
	(envelope-from <stable+bounces-233353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 09:51:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F63A2145
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 09:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5290300ECAC
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 07:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218CA22538F;
	Mon,  6 Apr 2026 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtWye16E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5717D2
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775461871; cv=none; b=qqSTCNIrWtxYI4CX1ie9kOiMzPLlLhYcrEfnr3fADCuzselPWKuL2UcYSpPMGY3MsTLJQKbGbBS1DZJIKhsuymNN6HcFTsNdUM9RZPKss7pNQxnee+pD9ihDa/Rjoaj4PNcxtayy0hjGrCoTBA0BQZtryFAY8+0jUvxCmy/NjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775461871; c=relaxed/simple;
	bh=9oLFOPLbcEP5zMFcmtTTYeCP7QRgw3sR2GvdV3mT4NM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mElISgs8yWPvENCoRNv2zNPUcOuwE3fs12fY2ykjqw35Moor/BPNCJmeraXhm7zpFyFKodXZOtKwoyrfWFxQuORhPK8EOV0YQDi4QA1VPhwclT/mxRGQMDfZ6dLpkQ95GF+dzF3CIJhhDl6xmvZnmjIY+4Ft1cELwgEpD+EQKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtWye16E; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab232cc803so15330675ad.3
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775461869; x=1776066669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfRe07VDdxyeiOp2leNAtv/+o9PcSTvv9BUYN12UeKs=;
        b=MtWye16Ed97CJdE6B4g9DUmwoav16sZSbS5VL13omwWGz8UR9xCBbtLe+fvsoPOKzT
         0xIbHD0hRTolPVQ0NemuCngg9AwnZd9/6io5yz6GAC0evOu8Dpys0tlrcnAAKxJGs6Gf
         Du9lk7zI+MNGJqn4BGzCLlWcFxBFCAfd6NSKc+rrD2kK33xaw/FZte+ppO+ECb9roa35
         golq6RMU/DilnxXDm4sQNeg3zfA6K+/GuIawa5gOBDQOd//Wn2rSf45F7exKao+GKHLO
         Fw1YNEdFSohlmfNhW6SjFS/n6pVp19K7P+SgXlXIQRJttAmPs6/aYyAf8VClszuzFw+T
         vb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775461869; x=1776066669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfRe07VDdxyeiOp2leNAtv/+o9PcSTvv9BUYN12UeKs=;
        b=YJYYTHVFYp3NYXzAdxK6fS2P19QU9XwVvrBwXu98jBZcjxIt6GBNDrBkhURxXHQGLB
         l5fzPUIhBFDVc1NQLZrnJtrttIP5PdDtrir1uLqH1hitsYhAxw4cSjiyGCp7LXRJaTl/
         KWsImb+WO6Wzn65EtLvUUPNo0UAl/T4hmjr3dqHVq4SgDDxWW5xJmweMFUyWeCUEbV3v
         rn2xBuUd++1RG9J7dqQaRMKkzRVR7P3njtfe+D6ZQGU7BB3u05y1QJjPy/V1MYKVhLUS
         20XAeSq8Rp7WIppgTZfHDiijs5xCnXnqpDIHacEqXbLPydxXy26M5nk/Sn62N4YItCGh
         OnCw==
X-Forwarded-Encrypted: i=1; AJvYcCV2uxcmjuAWBVFWS571MMepY6LJu+NX2nHzWtMWy2HXKElnq2jzUW22CvoQrncSSeBUTPLbA7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KpZIM+n1OsHtt0+vWAxtHBzGk4+wE2Y71/sQRpGe4LrZR6Em
	A/KKZjZc7QHnh8fF2RoacGu2UrwC+v/w3c5m65Z6J/b/75/RbAVVWhiY
X-Gm-Gg: AeBDiesXrM+b9ErUSICnsnFONdLBn5eTLMWNEzebxhGyNdyAFdA8FreBnZveO4JdJFw
	rn0Bi05I7I69bqvUoklSXFDUtKsteQ6oWOANwvRQVB4WxZxxKLR5fo9FuD499sGFN/2rTIZ1MEb
	eZ4vGmItpPyb3Dup92+EjQpwmdskoh7mv1+Iep8rec5EiJULxKhMxTPSRqtPxAy+GEnCOq+3l3U
	zRVFopdM6G071kyTXb5bjCEUDUemIDWQJbygAXVuEPIR8psTA5G1ezPk8+jk0h1tTqOoxvBwfio
	rnBob/n+2CstJybq0fME5k3v0Jl495XvuMDUr5SdSalP5CgRcUXMNmpRQsZXmr5ceUgloX3JbfY
	IywMuKCdw9vWYAMVB2TflYGl42NGrEQalACDfi7TMmXDCKT5sZiRi7AYoAgVeXUo5ND/2fxm2w7
	AtfcYY6EuaOKT02EsPHZlE1YoXH5fI8VjhQ4sQ6H2FhQk4aCiNQ++HDHgWenKiwrinAoaN4A==
X-Received: by 2002:a17:902:e749:b0:2b0:c106:a42b with SMTP id d9443c01a7336-2b2817fb179mr138260415ad.12.1775461869125;
        Mon, 06 Apr 2026 00:51:09 -0700 (PDT)
Received: from localhost.localdomain (hpcs-gw.cs.tsukuba.ac.jp. [130.158.42.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm167478635ad.27.2026.04.06.00.51.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Apr 2026 00:51:08 -0700 (PDT)
From: skoyama.kernel@gmail.com
X-Google-Original-From: skoyama@ddn.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	bhupesh@igalia.com,
	Sohei Koyama <skoyama@ddn.com>,
	Andreas Dilger <adilger@dilger.ca>,
	stable@vger.kernel.org
Subject: [PATCH v2] ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()
Date: Mon,  6 Apr 2026 16:48:30 +0900
Message-Id: <20260406074830.8480-1-skoyama@ddn.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,linux.alibaba.com,suse.cz,linux.ibm.com,gmail.com,huawei.com,igalia.com,ddn.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233353-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoyamakernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dilger.ca:email,ddn.com:email,ddn.com:mid]
X-Rspamd-Queue-Id: 449F63A2145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sohei Koyama <skoyama@ddn.com>

The commit c8e008b60492 ("ext4: ignore xattrs past end")
introduced a refcount leak in when block_csum is false.

ext4_xattr_inode_dec_ref_all() calls ext4_get_inode_loc() to
get iloc.bh, but never releases it with brelse().

Fixes: c8e008b60492 ("ext4: ignore xattrs past end")
Signed-off-by: Sohei Koyama <skoyama@ddn.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/ext4/xattr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7bf9ba19a89d..19c72e38fb82 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1165,7 +1165,7 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 {
 	struct inode *ea_inode;
 	struct ext4_xattr_entry *entry;
-	struct ext4_iloc iloc;
+	struct ext4_iloc iloc = { .bh = NULL };
 	bool dirty = false;
 	unsigned int ea_ino;
 	int err;
@@ -1260,6 +1260,8 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 			ext4_warning_inode(parent,
 					   "handle dirty metadata err=%d", err);
 	}
+
+	brelse(iloc.bh);
 }
 
 /*
-- 
2.39.3 (Apple Git-146)


