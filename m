Return-Path: <stable+bounces-111180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B80A22006
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CC3168562
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5FB1B4F15;
	Wed, 29 Jan 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+VLH/FB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CF191F95
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738163580; cv=none; b=KVT1PDS3RUE+WDhLExRnPQY5DkXg6lMNH+nTAr+7gA4FOCOCvADx4FMy9tzLJAMczkwOcY6Zer5WPEf25QjDru237iMIGjYu+8DEmxUahvI4javn73HhskFtDtOfCw4qiVBna8ozP6tSY2c/mCtxPQMELhW2dVGsCbdXcJw4Kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738163580; c=relaxed/simple;
	bh=Z9rKKIVZX1wMbqng6xDiHvcTLFZoAV7xesHEZrsg4mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tthaPjh7dwjc/SN+gChxCWlUY5yN0LULRr+IEgFFT/feXxTNMjwY4NP+eD1tm8jN/6MOOhVpxlI2BwjjCMr+2ldFUBNOyK7R5pTvsZ2aMVtrxROxH4ze7Y2oaCbwueWr97GlTvZMGcmT34se0Tq2IJ61LNYCjgMNfsWNze/Nbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+VLH/FB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738163578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eYQ/lbZ9cZ4B91PK+ltYFjybvOyribsZchCWu1ti4xo=;
	b=P+VLH/FBdSyOS1Tb5ik3Yao60WaNGUHE6dS2fSS6tN7fD7VuwOVS4FF0jNuJqSnUMjowcr
	vjIPGEYTUSduy+86bIdZQ9RkjLlkEcAsn1SQC9U/Vb4PUlf5WQWwME6AqLeh9Csokt6hnn
	MaTiy2t+QFp5od4f0K5KIWG8EMJyt1E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-40vnPp1xO6SlOl-M-qEyag-1; Wed, 29 Jan 2025 10:12:56 -0500
X-MC-Unique: 40vnPp1xO6SlOl-M-qEyag-1
X-Mimecast-MFC-AGG-ID: 40vnPp1xO6SlOl-M-qEyag
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436379713baso32966185e9.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 07:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738163575; x=1738768375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYQ/lbZ9cZ4B91PK+ltYFjybvOyribsZchCWu1ti4xo=;
        b=jSjE6dV68FkmRASSDVvsC3n6od3B1b9a1p4E8FlW0jX9/DpiFN5Y12F/EUgqWRDzs8
         IQulU27lQENHjzjLOcN2ASsjf1ovwKb+QblAoQR3sL+BjEZJR+UdPSGenVndYZmN6nMv
         IHAz0gOCAF1hqAOmAGb2MmvKO5rwvvhEcKmG+kwduLdwJo/OOvHbWD2LIPLVfj/fFNAn
         CWIIxw8egFablblm3NKf7L7KN3hxO7BmD0ENxmGBRAi+21CsCFncjwG1pW9FwdTGuMuB
         wEpfbQgD/oRvmgKWAKN4U1iCPXTx/Y5QG3U6gul7ZFZTF1MvG3w3ixGwXonW6JX/wdKv
         y9MA==
X-Gm-Message-State: AOJu0YzKWEoFtQhpMCu23TSw59usMzyx6IXvOlcBxKC1z558MTtw7x4E
	rDqp6spVgmpiBzjSstbA0szVpnQwiAVf0JQ2E6ZHcVWZSs2LkCbboLrG+Ot3biyVWpmYpH2rERg
	oYPt/T4ZV+uwjMWcMVY1wYidezjYo8KsejBzYpxifQdPbsH7g/jDCuP+Lkd1sD17p
X-Gm-Gg: ASbGncuUMj/EoZlWZ8wyVcvk3eIkARAGCERELFOZAplORocv6JEv2JsnG39oCUK+IHe
	MxojHKE16HLY5Dwoo/p6NMKGPQLj0E+dgEtx7j2GvhlXsEMjlkTk6I1M8DXE/VT1Zd45AQuExKM
	huAy4mf+9TyIxph7p2pGwCcA4ndZgDOuaOhG/qWrmUYOU68KEAKzsmPE4kFo2Ut520U/sCcxIbS
	1FQCzzQCePpaoHkleQAKGTJXN3DFelD+5ZiZXF/qtQdZyCSqIgOy6ZuKxYQIZ/Bo3dyV26Q3zQN
	1DXIH+/O+uGVcNsmtmhfSvZH2Trh9Pc7yR9R5QIRu8pkfU8vRpsLt83n
X-Received: by 2002:a05:600c:4e87:b0:434:f0df:a14 with SMTP id 5b1f17b1804b1-438dc3abb93mr31522525e9.2.1738163574992;
        Wed, 29 Jan 2025 07:12:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4t49CPV6bC9T+Oagi2xeVe0ATh3Ubx6W2a1hP5ph8tmEs4kW1H8/uIxrzPrJIqLKf4O/t/w==
X-Received: by 2002:a05:600c:4e87:b0:434:f0df:a14 with SMTP id 5b1f17b1804b1-438dc3abb93mr31522295e9.2.1738163574656;
        Wed, 29 Jan 2025 07:12:54 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2abeasm25934075e9.20.2025.01.29.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 07:12:54 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fs: fix adding security options to statmount.mnt_opt
Date: Wed, 29 Jan 2025 16:12:53 +0100
Message-ID: <20250129151253.33241-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepending security options was made conditional on sb->s_op->show_options,
but security options are independent of sb options.

Fixes: 056d33137bf9 ("fs: prepend statmount.mnt_opts string with security_sb_mnt_opts()")
Fixes: f9af549d1fd3 ("fs: export mount options via statmount()")
Cc: <stable@vger.kernel.org> # v6.11
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c11127c594c0..c44d264dcd4a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5199,30 +5199,29 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
 	struct super_block *sb = mnt->mnt_sb;
+	size_t start = seq->count;
 	int err;
 
-	if (sb->s_op->show_options) {
-		size_t start = seq->count;
-
-		err = security_sb_show_options(seq, sb);
-		if (err)
-			return err;
+	err = security_sb_show_options(seq, sb);
+	if (err)
+		return err;
 
+	if (sb->s_op->show_options) {
 		err = sb->s_op->show_options(seq, mnt->mnt_root);
 		if (err)
 			return err;
+	}
 
-		if (unlikely(seq_has_overflowed(seq)))
-			return -EAGAIN;
+	if (unlikely(seq_has_overflowed(seq)))
+		return -EAGAIN;
 
-		if (seq->count == start)
-			return 0;
+	if (seq->count == start)
+		return 0;
 
-		/* skip leading comma */
-		memmove(seq->buf + start, seq->buf + start + 1,
-			seq->count - start - 1);
-		seq->count--;
-	}
+	/* skip leading comma */
+	memmove(seq->buf + start, seq->buf + start + 1,
+		seq->count - start - 1);
+	seq->count--;
 
 	return 0;
 }
-- 
2.48.1


