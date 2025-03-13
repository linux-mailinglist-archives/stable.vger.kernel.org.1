Return-Path: <stable+bounces-124375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8AA60299
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1401317D158
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D791F460D;
	Thu, 13 Mar 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJn/N0GN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64401F4604
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897584; cv=none; b=lDxQS5oZ3D87Iy78bs6+JQ7YmkJynh/OLyRoCSkzu4Loxs7kSYMaNNEbjYTAhEC+kkc1cM00TYXdlll/ofJO99hoZj679l/wpFxSXz+8/rwQtK7rYiL/vx+w51gYc2UZv4sl0mGOWmg8VnW6kZjv2Bb6JW1jUW3W2EppQXANuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897584; c=relaxed/simple;
	bh=kIgo7Z0ol1YO5mbiYm+NkOE6lwsRaO0zsnJzTvFdies=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llNJSDtjcQy32Jxq9QnbKAsYWBzKlTgUlAgNYPsEKMWz4UnAE55y6B6l64bNaZq9u+1Jl8gcwtcR48mgDH8jshxzMe9SnkLVY8eLqBZavhlGq8c3a5GZ2TaP3I0RB7BYPbyWNS1WO6RYno+uBN66GfTtkY/LmEAHSGROuHxbO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJn/N0GN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2239aa5da08so29336875ad.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897582; x=1742502382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoPGHO4MRKZ+E5eMJnri/MLA8qA+aj6gmbKv0R+IpzM=;
        b=CJn/N0GNaWd3/sYOSDAvui2USYhMm86rIQUuIOghSG9RY3MVxPrxyCkkSOQW0PlLDq
         s59fmw0LmDsCbc/GVSH7Ek/eKgFzni5+Hl8JGcH+HBHkYJjN6HN4ccb8duZzvTYdwTMZ
         3yEXnL/qAwnaC/QAykVA3QOey4OX+BiCkEr9Bo+7MP3uiUPr22I6uDH+gZh/w/A75GPT
         v7JjtS8uFcvweG5lc/5UwLxVc2Xp/1XC+Zg5++zZ48AM6dj7r0HcHjwW9lBPWWspzBlu
         QoRpcf6LOZvolbJ8/f5T39lq2HLS6Rx/E6SC0S/MbQFasH+y1Chu+5QYSZ2PIpBgy2MV
         AYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897582; x=1742502382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoPGHO4MRKZ+E5eMJnri/MLA8qA+aj6gmbKv0R+IpzM=;
        b=sR8hETCv3sT5HMJ11AaduyiMHEU8KrvTLIsHRm4xSaa4U1msW/O0DR3Kmf7t49zMxZ
         IfZGp+2UQdA0613Bbmx+2x3xXy38duOJYfnbXpKkxrlqLuvoxYZ8x1PVBlmgfCKloj8x
         yl8KwDImJL/4T3ySmWc1vnbeyhRZbL7u/+2fq3NZpL7lj2vrvujw4kmi0HPxal6PV3Yl
         d+3HLKQPF6vNy9dRm0/CccnC2r/nb3p88Qpei8ekEAoS7tIfTtciWuq2ls4FfEq85Rhs
         CbD18/fMg57jx2FMbSyR0mkAL2vvupNUQRT1GCPFSI98i2pAVBCK5tTCAZrJtSzT1oYs
         97Ug==
X-Gm-Message-State: AOJu0YzMMcjETkCL51dKsiWsZIcSAZkztqYlCbhu8tqgSuQlj+oXiOAS
	pJcifclhl0K8Jot7u99mNqQrqzpDLZOxuiGLCmJW+KAaQ2j+pDmPYrJspHPl
X-Gm-Gg: ASbGnct52pfGlJM5JbxtAdot2PgHgCaMgQjr9BWw0pBpyov97lMYL21Cfjdib3d4Vcr
	4xxY6a4JF8apYKMa1kk0ck3sg62Ctm5bZ6wt8jH8Xi9aNp+E4q1FdU0I/0/lM/qYiA+Zhz/jYt4
	Af3SnGPtfCwE/1s/OT4MxHPm495iNrlSZWcCk+MR0abGgL86FTk39IWphU/vw2mwJaeWN6JG6SB
	VdJt81HwskP/kHHEnNy7y/ZyoAD4VoTT4/nUcXM4B4XHMIkpRb2W1+s5gEq6COLJpW1kTGOKMrY
	zP8mmHDzHKBMEAdf72ZRseKNFth9L2/w7z5ISjYI0dWH8moAe/Tp3BnA1lBW+QMcR5vDmEY=
X-Google-Smtp-Source: AGHT+IHOgmN6E9zV5HgED94stXQ5iZHuuUxQ8FzeIkn4fAqGwpI45KxCf0c9LzduM3CuAvPkO0YHoQ==
X-Received: by 2002:a05:6a21:394c:b0:1f5:8d3b:e294 with SMTP id adf61e73a8af0-1f5c1181071mr88719637.16.1741897581812;
        Thu, 13 Mar 2025 13:26:21 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:21 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 18/29] xfs: fix 32-bit truncation in xfs_compute_rextslog
Date: Thu, 13 Mar 2025 13:25:38 -0700
Message-ID: <20250313202550.2257219-19-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit cf8f0e6c1429be7652869059ea44696b72d5b726 ]

It's quite reasonable that some customer somewhere will want to
configure a realtime volume with more than 2^32 extents.  If they try to
do this, the highbit32() call will truncate the upper bits of the
xfs_rtbxlen_t and produce the wrong value for rextslog.  This in turn
causes the rsumlevels to be wrong, which results in a realtime summary
file that is the wrong length.  Fix that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_rtbitmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index 37b425ea3fed..8db1243beacc 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -1131,15 +1131,17 @@ xfs_rtalloc_extent_is_free(
 	return 0;
 }
 
 /*
  * Compute the maximum level number of the realtime summary file, as defined by
- * mkfs.  The use of highbit32 on a 64-bit quantity is a historic artifact that
- * prohibits correct use of rt volumes with more than 2^32 extents.
+ * mkfs.  The historic use of highbit32 on a 64-bit quantity prohibited correct
+ * use of rt volumes with more than 2^32 extents.
  */
 uint8_t
 xfs_compute_rextslog(
 	xfs_rtbxlen_t		rtextents)
 {
-	return rtextents ? xfs_highbit32(rtextents) : 0;
+	if (!rtextents)
+		return 0;
+	return xfs_highbit64(rtextents);
 }
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


