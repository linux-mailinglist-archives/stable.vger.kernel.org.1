Return-Path: <stable+bounces-145746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22379ABE964
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836FA161DAD
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D66221FAE;
	Wed, 21 May 2025 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwSxDibg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7F221F0C;
	Wed, 21 May 2025 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792435; cv=none; b=BZnUjVvtZDxm69k39BmpEP1mgMdPZ1ggwRWDYdabLY7AgMYzXwL+fA/eQIzO/9Lw0mYaqCssG98Qd+p3gy3fLpUq1BO92t8YcSHIWWjC3DxrdG+B0tHsF2zQuii0EAOAcUuligpd0W84IFz3Py4E3DiGyg4xodwI77/mV5L6fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792435; c=relaxed/simple;
	bh=+SWjNDzBMp8S37NaGQn1wgk8MhGHspoDe6lFI6sPKMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5wjW4IYtlPyR0Ja69E4Z68ioNuMcIVJbMdFwNgTDZrkztG7dbjKDmxDbOeuHXglEZROk84Jyy00OuGhYhGCA20tea0Ag4KXd3LKYOITAiwpMsyu3e+J2MJsureFxywLpaoyMAAwJl3ZWYX+WOgaGmele3lgEso2XrCWa5kBgVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwSxDibg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af5085f7861so4098914a12.3;
        Tue, 20 May 2025 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747792433; x=1748397233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66xskfZTYSTa36h/Txw1DnBFo3eDhYKJWl/CVOCE5Po=;
        b=fwSxDibgfRFUqIZmkDeIMQ7lXRHKmidyKbdH3bOea8Jjwk/HD7pZu+AQcd6uk9OB4f
         xzX4F3lOBJhMKyuPmuvv8uTcO5UTUDnz2G4XMSRextVExWs4OB+w5lj1PF6e8ifpj/qk
         jilFxOg0GnxIHNITiihrQPGmIdHynQwwf2FgJJNuSlqFhUW+EtX5rE8BUdqcEEnn+ifZ
         pz9Af+pK5lgMarinuL8sSXVINN8/Jt6hwbuAMBRoZ+BskRNswpXedfKs5T9DusLUzRDu
         XQP8mNJlAMLUhoMCDWSC1x3qeXcEc13Dw1ya7rk8e5WixwQmQsM10rEKJiUyKFqlQNRK
         xn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747792433; x=1748397233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66xskfZTYSTa36h/Txw1DnBFo3eDhYKJWl/CVOCE5Po=;
        b=GgZhsKqH1m+5w1TYmu28pPW8VZIpEybaFrZjnxVtxyzOTY7e7qSi3oNdAuU3Wp9QLp
         jL41p83xr/GryMslTe5oVFeUktV4tCvUEW4HneFhfZ9yMItw2rJLt6I2siR2bF/6IBm2
         kb+Ka7Nhrid8c/ar+rRfs7qJFwDnhMk9mI2lhLCAUAj0bBhMAnI3xc6uprqMPWoN8QGa
         CN64Lk5qi+Gs2rIhVK8niijYvrJEVWoBlaZg4YXwAPtOjtJuw2mguOsCrVOBhZpFPWvu
         fdMkPQqA6Y5lp7Zb6Hs+hkA6st965SdRQjy/EYDnXj61bWVWGRraIAgpoQBG/7H4/mwg
         Gd6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXY2GJmESLakuaH9gtng4Xz7iBD4+1ZZcNrWE5SYJ0RiO9HVKtT8pHSJxkSlvVTlNk7RsW5EUhVSsYRpFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMl6HSTxRuHrdNEdt4JqDJW2ozpG70YCSmDkwo1o18Rmn2qZh
	WxgHjQoUxOz/IK7B9F9l1bSlhFG3APM72b0NB9qzGG5dlbku0+Z8Byd/X89EMkQaGXE=
X-Gm-Gg: ASbGnctHlQhG+UXfQqXgXe0c1N7FOeFJLBNp9vb52sMQwwqW6FimbLXPrXkmdE/pOyl
	rfbAvHnpMszwkkPiA27MUWqNdETOqGAa9mB/lcv5Af1WBqGQQrsv1HzZn0uTQmxNVcqn05y/P3S
	alT1+N8LMyUSra3ESVu5DPId/DmV6JRUul52ynQRas06b99tgFW1U6G3bszTklwpqmjsrSttrEV
	SPhRk37V0H7cj83PkwQ8KcL1lVRajicW2MIqjiu5u18oXm9EmyuBDIH1SrX/ygxyMAGBe99RJWy
	GvGrTcUXn6gPuU6WuT7Ij0/AvGiX8cWUwH9JRAA3GRmm
X-Google-Smtp-Source: AGHT+IG6AHmgtTNfQSoE+ReVE0/1RMinnFw7ZGP/lKTU73d4o6z4SY8xExogy/CUeNN2W96IiAaTew==
X-Received: by 2002:a17:902:c951:b0:22e:7971:4d48 with SMTP id d9443c01a7336-231de37ebb8mr235956365ad.45.1747792433210;
        Tue, 20 May 2025 18:53:53 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eedb59sm82796665ad.257.2025.05.20.18.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 18:53:52 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.10 5/5] kernfs: dont call d_splice_alias() under kernfs node lock
Date: Wed, 21 May 2025 09:53:35 +0800
Message-ID: <20250521015336.3450911-6-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521015336.3450911-1-dqfext@gmail.com>
References: <20250521015336.3450911-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Kent <raven@themaw.net>

Commit df6192f47d2311cf40cd4321cc59863a5853b665 upstream.

The call to d_splice_alias() in kernfs_iop_lookup() doesn't depend on
any kernfs node so there's no reason to hold the kernfs node lock when
calling it.

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Link: https://lore.kernel.org/r/162642772000.63632.10672683419693513226.stgit@web.messagingengine.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 0443a9cd72a3..f301605d70b0 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1122,7 +1122,6 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 					struct dentry *dentry,
 					unsigned int flags)
 {
-	struct dentry *ret;
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
 	struct inode *inode = NULL;
@@ -1142,11 +1141,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	/* Needed only for negative dentry validation */
 	if (!inode)
 		kernfs_set_rev(parent, dentry);
-	/* instantiate and hash (possibly negative) dentry */
-	ret = d_splice_alias(inode, dentry);
 	up_read(&kernfs_rwsem);
 
-	return ret;
+	/* instantiate and hash (possibly negative) dentry */
+	return d_splice_alias(inode, dentry);
 }
 
 static int kernfs_iop_mkdir(struct inode *dir, struct dentry *dentry,
-- 
2.43.0


