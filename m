Return-Path: <stable+bounces-28244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D510887CEEC
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 15:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A7328434B
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127A845027;
	Fri, 15 Mar 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HwCNqalG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AED3FB1B
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513002; cv=none; b=qJPifu0VnF7wGQiknCxdzE6enxZ/dPbSHCUkpPqu33xyGnfK0GnctCXbtvp71VwpJebRd5CKnW+9Hj6yfdn3334NfLyxI4Wv92B056LagfhcXPtM7Dj59OUxdej5K1vtb3UP1jZprsgApcxE9zd/NBPJwhjXOgcjLwcfxpmdPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513002; c=relaxed/simple;
	bh=KfYUBD7UBkzcBcghQDhrh4UXWg6wcsJSwijPDwGd+xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDRBG8qoB2ud2Oph8jOcOCXOBKCKRl8K4p51Nxc6lwnQqZSy3k1Ydzdm5htJ1l3lmp/UdjrooCLLpRO9wOTiWDgwP6vFfDtw+cZqkK2zqcEI/w+QY5I60IsFJfNO8r7Ek+kgZnvxs+GdeMyWsaKyjc68UjNC/rqJxFgRSwBzFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HwCNqalG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a466a1f9ea0so204045066b.1
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710512998; x=1711117798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26x5Ax6QaYFW/lMxTgpz/jUxgNJVrtQaQeSP0hgClqs=;
        b=HwCNqalG9e38Unx0blfPCy7hKTXJXIfw/xLgPb5GLE6RNWVa2gUMjnOxs+QF0KNJyY
         oKuOFm1zxJh/INpx6YWniq6GkotQkReSO35ln5oL7QsJMyoYwBtHebuczvkAtw6I/+gd
         fwfSweriXw0W27J3ZoQgRIlue6cUQPToraG+DRgt7xe18Yy29TLFrgghGlOVMlPdiVD6
         zipng7eC/es7xo1wBg+NVaeUPqqF8PoYStIsqxN+qdzeJrcyiE8d5lvNAHTff+/Vk/mz
         n3hJ9nDDPPp6dFcSEtf+ucaHVFFd6rz2ksIcJJRzkmovzdMNhIMqTEJ/g0l51aj0Q0pe
         8o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710512998; x=1711117798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26x5Ax6QaYFW/lMxTgpz/jUxgNJVrtQaQeSP0hgClqs=;
        b=o/XNSJyvbACHS5ex9bvA171mqSXcvsEnhQPoR7kI0QOnMFTAKRfcYV0mECIB7uiQt9
         +RcsZWdEdBJ5PSL2uPjaawKO/8Uvdc7mDltdKu6NCVKH/kSYW0ClYFBjltyRuU/FbnjJ
         a4/PZUhac+hxhDgdUoMoUxL2LkUSEWTVnmT47Yobky5HI1KlHTdO8q57ed88VfcrJuTZ
         RjN8Vzku+oAl8r6u6o0tYMQQ+WL6LoK3tb43vO4yNSzK9MFXbkHnnqkeFU4DBCPDds2+
         xcBstOBSS3Z6bel5KgghxpcmS2gAJnVdKttJwSl03OpZiSN9WkCN4Y66EA7rtY7HcA9B
         Zl5A==
X-Gm-Message-State: AOJu0Yz+oNZrXzkWlZdaPxg67XX78TW6s359b/ZdnAVai7fGKZk+CW3B
	u2Dx2BYbWali1Qjj1oyE95BJT9X0UFKKSvc+deyRF7jjPC/EU/rZgQTs3WDcDBA=
X-Google-Smtp-Source: AGHT+IEZqEc+qFGuULCGQaqf2Z6e4zQ1Np1mSGjmmzxskLbaDmx1sdHG1RUdJKKtsyZZdnlj6/7Lbw==
X-Received: by 2002:a05:6402:1f04:b0:568:a30c:2dae with SMTP id b4-20020a0564021f0400b00568a30c2daemr3938824edb.0.1710512998347;
        Fri, 15 Mar 2024 07:29:58 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id y14-20020aa7ccce000000b005653c441a20sm1726147edt.34.2024.03.15.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 07:29:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	mforney@mforney.org
Cc: stable@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] Revert "ext4: apply umask if ACL support is disabled"
Date: Fri, 15 Mar 2024 15:29:56 +0100
Message-Id: <20240315142956.2420360-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
commit caused a regression because now the umask was applied to
symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
has been fixed somewhere else already.

Fixes: https://lore.kernel.org/lkml/28DSITL9912E1.2LSZUVTGTO52Q@mforney.org/
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ext4/acl.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index ef4c19e5f570..0c5a79c3b5d4 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,11 +68,6 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
-	/* usually, the umask is applied by posix_acl_create(), but if
-	   ext4 ACL support is disabled at compile time, we need to do
-	   it here, because posix_acl_create() will never be called */
-	inode->i_mode &= ~current_umask();
-
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
-- 
2.39.2


