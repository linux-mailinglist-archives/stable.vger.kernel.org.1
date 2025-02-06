Return-Path: <stable+bounces-114131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5032A2AD91
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C7F18829A0
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9451EA7FD;
	Thu,  6 Feb 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MOSZZrIK"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D01F4184
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858888; cv=none; b=hZG7OtAahnJPukPB2PxtkOu0zv19+zxXmJtLktO4Tz9zXqH4ohQBIerO+N5qLc6ZyyW+ftkA+Hs75ZllWcoA9pFoZOjTlrBCV9ZEDNQ2n5bdhgzcbOu0aKhLABu+38UfP55M9IW5XbyWywNAnumWNNd1qYZl+wBvbx0KRFmGISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858888; c=relaxed/simple;
	bh=XOOTvQxLfNLLCtGtyHssyJCI6nfHC0FOnt0reqw/QyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFhUyFetFZHrgCvdfx3aHTjb45lDfe/gPFSNavWSJ7d6DArwV6w1OF8vsfJsCxM8pbhaFq9KfNNeU0OE540a1dMoMmRarPYVSK6vcxz/7gnLPwedJSDE0UzqYu2Mpc2WnlSP1h+Bmm9MjLZRlsbu11q6HHRBGlgvDv6U0QxbzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MOSZZrIK; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B52B3F875
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858883;
	bh=pZe37e0fLzRewKJ0Cbc8vQZsSMn5WjWiH3X9f9l60lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=MOSZZrIKxTzD8hTm8LG0DUOSi4XIbB7LbsZLHFsSrxkUd1b0EK+B4vj2PosZAyFh3
	 PvsbxO42nON5t4+Jxki0pflT1MNIFVbkZTVhKzcj234czpUH4hKy9EsvZJjFspm1Yp
	 F/oAMXL+ayBpMyzPCmf66JSYiWkk90/qZSEnTazcDRIQKKRQW5pdr40APDnorDMuU/
	 +7ve+PKiaRVnxPEatbnHuU4wYn1o5rhk2XcJ4iEn/KAiteMFzJ1ipMc3Aiftlmt5qV
	 w7+r2vp1AusoU9Q/8wZn5Z+qqH/y932ydkKhx6RfOl2NMFnEp9tNAto91aV42jfj33
	 MuxNIY+RXYsLw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fa166cf693so1358321a91.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858879; x=1739463679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZe37e0fLzRewKJ0Cbc8vQZsSMn5WjWiH3X9f9l60lM=;
        b=XyH7g5uULEcX38OdIO/iXA2hsM3QPNB/PV64nmbPFQ4tTLN7uHY3xcE8Qwr+bfbReE
         kGmpDJHYhdTCteiKiKssw1nbO5/UOtXbTLlUTLrCVN0fITy+4eCDkjVrPNPsbcfZ2km+
         IVEWhnBmnZMuM7mTgBx4CwjyF2P9nRhzd56BGCgp7NAFhWzqrNUmlLj4dd8BttsllzDx
         oicc1mXsZaX3Ns2aVTyB1SUdgEILhA9mRlAc/BrQ8+bx+7dIuj9srwWTZg12jAFecpE3
         g0Nd2U31YEZg1yFzfNoGkEkCqh7p+fQFtOND8IVBW5Pa2s0Cr4ofUuA6dN6/xEMYSTdY
         +o4A==
X-Forwarded-Encrypted: i=1; AJvYcCW/dFGHWNPkTR0QaBoJqBrR0HrN/AwmlVV69KYftKbsdG4jjWCclWvgwW++LRfbkOWyKdvCmtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6+wRRQAKhnfN0NqtyJn4yKtteDovSGjnEPnn43FISrhRZ1UKK
	j0CrbZ191+YQKtJrditrJnKWUqOQMHblSDLDhcxlEjkzXjqG239Gsyb08lQ96rAHUAsmNxacz8U
	WrdjYhnryWNlaPk9Mk4x7UkCegB3VXYq/s1YhYpxJRFk0gvbYZLBQmHi5mw3gSWZpUOtj7A==
X-Gm-Gg: ASbGncvScvg9Hhnm/yWiu5QFCYGBTIDorkUP7/+PXlBp+t0dE07iCiNCIokBTv9sdzo
	Yqs3jW4fc7SuU1lB6eT+2SY7giX2kGJk7oPiiwPg3Ey+z1cvqci1tPH19CEYxx2RLXAZ33HfQ3O
	33qgiYBj0Gp4zHIpZ9jhkUKMr+BUmQiCMLFpLKWsOL71E+CARjtuzxorpjvku/5iN1Tc6o2cj36
	ankYSK8oHvpjA0PEz4s6VGQ9ZGzLD1J/Jlfe+6ZkD4hJH5+Ao2q31l16eCGEJemMk+hYNPw+gMx
	n0AnwHn0xOLgIFCKqwKj23Q=
X-Received: by 2002:a05:6a00:2306:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-730351395d0mr11544075b3a.12.1738858879509;
        Thu, 06 Feb 2025 08:21:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJxQNMwytESazGcRRJxXO0440G/R5YVbJ/936nw36KAck2qH7AqdK8MXi+qx0+0tMiPNz2GA==
X-Received: by 2002:a05:6a00:2306:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-730351395d0mr11544044b3a.12.1738858879190;
        Thu, 06 Feb 2025 08:21:19 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c16215sm1542191b3a.142.2025.02.06.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:21:18 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 6.1 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 01:20:54 +0900
Message-ID: <20250206162055.1387169-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit bb8e287f596b62fac18ed84cc03a9f1752f6b3b8.

The backport for linux-6.1.y, commit bb8e287f596b ("btrfs: avoid
monopolizing a core when activating a swap file"), inserted
cond_resched() in the wrong location.

Revert it now; a subsequent commit will re-backport the original patch.

Fixes: bb8e287f596b ("btrfs: avoid monopolizing a core when activating a swap file") # linux-6.1.y
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b2cded5bf69c..f4a754d62bf4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7387,8 +7387,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
-
-		cond_resched();
 	}
 
 	if (orig_start)
-- 
2.45.2


