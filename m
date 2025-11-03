Return-Path: <stable+bounces-192239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EB9C2D3D0
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B65189A05B
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E031A072;
	Mon,  3 Nov 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1cDta+0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811831A54A
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188507; cv=none; b=NG8ljhFhR7RIzbxEJgZh9p+bCxLpS29bGaxdRR+WpJ5q5r8l8ZhN4xIpq0TKGxUDIGfaitEwit5hHhMo2F4BzsffW8y+FJD31BAxGVxhuHtx1NQNS28XgcaQxhFBDvp1cTnZFt5iGmEOYd8R9TS16xE1TVzvj2KUQ1DUht54SiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188507; c=relaxed/simple;
	bh=QVjhfMLQHjrgRMPIbt314bhjxXbir3hpnY4sM9EUf7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxvSemdR1Dff8EgZ9Thggv0clLF7eV3hkwH0zHix0GA1Fc+aMkh8tEvWU+6nG0dyyVrZ3E768sc8sYyMraxd0DkqGd72zqjMZeo5jeRlMlR4ACfVRxU/FXLCF7AZAhtPUH791VZSvwlPCxVbYauJ//JekKKUqD8jMiGf8iUvFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1cDta+0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b556284db11so3894902a12.0
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 08:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188505; x=1762793305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZeg8I26rc6UbearIJ6Ec2S3DjEynyvxSgAdjW2/ZNw=;
        b=D1cDta+0aILAknYn5nm1LmtJDQOYWRMoVh6ldmqDhA1OKI7azLUKxuVjOyP8PPAxGZ
         WBTBtJbvAF1fuOzqh++jzfQlHzE8YT0TaqVrbeRjrWRAO+B6cTpmSiGON79QvtKt4fo6
         kiBYUY8kdnw90EZqNqoAIc393CnV8Gc7zZ5saGVLdhTR73uk8pDw4D2v0p8NnZyowlII
         wDemScjx3lu6id0YkOwEMdfJE1OSOPKKoW8jD5HBxVf03v4vkvsXz4O9VmaRmffVg7sl
         erXgXMPU0P/ShLjLKfrBIc+o2a2fBPrlKTckIqrcpp+Yq6XvIEfPsKnF+XTydD3AWGmU
         LMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188505; x=1762793305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZeg8I26rc6UbearIJ6Ec2S3DjEynyvxSgAdjW2/ZNw=;
        b=DNBBLLnaJlCU7VwLpaZLgyls2vTAnODV+UncBvZXC85tjMKUsy1gRzEp3DDzwb8Our
         OCEJcMlikDwnBynlWh4IP3EHxuqGvvDhYmh+AdMf2BO2lZYMzNoC3xaYsiKmFfC+Dh6Z
         dLkvnKx0fNLbnOg9gFNWBnpI3X0+ZDcEEa14e3uiJXasZCC8U9wWg31rq1ir/jjyB5Ym
         NB9bCmXZGMMrRqJspIeyeFkVaILopy+5s89FWm+o7pmCb2UxmHKCSAAf1qbPtzdGLhp8
         vI6amQkyHr4YJEYWAq54DGUHwnBZWC8hYnB3W7WaytsZbmdqIRePt4g00ob1gwUh6j1c
         2kig==
X-Forwarded-Encrypted: i=1; AJvYcCW5IMTF3xqjtHMa8F+ZPYI20r2oJRYCRJDTGP23QsIYX5Tmg7wWhe4Eiqz91KK72mpwmSo3U+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUD0lG+cO4sUQ22+hPW9oIOvpwWIMz04YM5n+umCBStjk7gtt
	NTgjIPmepyPKXj1mLUFzqcEDLn60sr0elFhcArX9qJSappCCYRPjflzJ
X-Gm-Gg: ASbGncurKfvy7tyRzU4wvJOwJDV042ljrj2DmQZgHREGLNvYW8eH6gnX0Lgz7Nhwa0F
	svviCikpFg7qupoxBoQfGj3JWsyGrplcz7A0IKhbNJwkYefvE5GC0zN5wPlKsFVPe6/qg/bNxTi
	VeNamgxOHbHxhg0FiL0c2c/Opx4sxRkuCLvBXr44x+1PtY0wBLuF4ia8u67AJmVd/mz092x/ulU
	WiQJ0/FN66rrNnFEwm7Mod1+X3LhgXuOBn4uzzAnT4EBNbnPUaUIqzt8xxzwiwfWxsO/LEoSzXY
	BB2Ee3X4hIUD1MPsUtxjAfxSQVgkkDZ5WtoRkDOIfxIY3pUx8oQ6fotMxDGHo3furPodpYb18J7
	OB2VktIR5lJy0d0AvpCWQhFY3zb3Utqn8p7BwBxOxz96QzFoXuLKo2HmFInzGEkI6U1ROCk9sYw
	AUxKpRLD7hNtkO2dIvFWW6
X-Google-Smtp-Source: AGHT+IH4dvliuPCPeEksMdouK++OLCepXxAi6BbzFrOf3xBpwY6kdtXvLuXYSMFRaScgJRVXvvJYDQ==
X-Received: by 2002:a17:903:2442:b0:295:82c6:dac3 with SMTP id d9443c01a7336-29582c6de47mr78872695ad.32.1762188505225;
        Mon, 03 Nov 2025 08:48:25 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm1607264a91.18.2025.11.03.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:24 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v5 4/5] xfs: check the return value of sb_min_blocksize() in xfs_fs_fill_super
Date: Tue,  4 Nov 2025 00:47:22 +0800
Message-ID: <20251103164722.151563-5-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid the
filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
for sb_set_blocksize()")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/xfs/xfs_super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1067ebb3b001..bc71aa9dcee8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1693,7 +1693,10 @@ xfs_fs_fill_super(
 	if (error)
 		return error;
 
-	sb_min_blocksize(sb, BBSIZE);
+	if (!sb_min_blocksize(sb, BBSIZE)) {
+		xfs_err(mp, "unable to set blocksize");
+		return -EINVAL;
+	}
 	sb->s_xattr = xfs_xattr_handlers;
 	sb->s_export_op = &xfs_export_operations;
 #ifdef CONFIG_XFS_QUOTA
-- 
2.43.0


