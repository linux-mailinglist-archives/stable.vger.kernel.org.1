Return-Path: <stable+bounces-203397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9FCDD6D6
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 08:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD4323022F37
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C962F28FF;
	Thu, 25 Dec 2025 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPbbcRHm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA4262FC0
	for <stable@vger.kernel.org>; Thu, 25 Dec 2025 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647722; cv=none; b=BqtygcMLYNnZysFx3t6FXvP1YkFjnJ1UvWthYaYknODRkj6/VzZGYuMSo7nv1yNrdBCAtAo5qT9MKezeJNNWZ8mIqE4///QY1ylF+yGt+E5BXbQwJuLaN+ZdxAaWo2WLKg/VYqBeU2jpqoxtT3HpMRjjl+enohLc9BRq67M6J7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647722; c=relaxed/simple;
	bh=nDbknJ7IUdumOxpo9hBQLkqYxDx2G2kdEPg/Zd1nCmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6y6dcgo6lYh+8fh5JWsmb4bUBh+REW8DKm3tY05Hqk+DPzR24qDtLICWGbRL+099qY3GaMEOE+5HIYP3w9DDRh4/iz7AfY7nYhxpBmdj7PZcZEOA+rP23/lzA0jb2nTPtnXVDmfx7Cech88vvRPI3R7ncl5rS/IurBxeFumRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPbbcRHm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so6101382b3a.1
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 23:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766647719; x=1767252519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6BFcbd9iyFXSrOLN1khZAr09vJHb19aUamed8L/NRg=;
        b=BPbbcRHmr2XAdJPMbciFDgXmgU2jEEOqvaF0Uodl2q4pcJDvclntXFPZBMU4D3Xmj9
         6EiI/uap6ZpVRRZCcMoDJixOIp/Q74rr4fZAXLUm7ON3pfULkisWRbsdReDXWge4UeBG
         3L9v7CvBQFDnG5tCjk+MXQDu+N2CGaJ3kTe7I81zz7N0bGn1sozoFkMn1XvWv/f9IS++
         dlFmBlqBrJNh9bHjIGT9ah8fgeQqbRnq/HXFszpC/oWICopN6Ix4hJ6MXRygPu9P+Gz+
         r35zBYl+8grrB7AkgdvIhsmieZHHX1eUtTXIbhLg+a1vCn5z5oUlp9n5qjQZpp5cMjTy
         PzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766647719; x=1767252519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6BFcbd9iyFXSrOLN1khZAr09vJHb19aUamed8L/NRg=;
        b=aHwRMdSG4yBS8Kp+ATRe+5Feo9ZVAJizntfxDdqOhWNFMY8dbH/865+/4+HRwhbBel
         BiaD/D2N7R8wi1jJIXpzk+cETZky9SyHdVccZ4y7hoIH2QySfGFrmK3CheMJ7Ey/jG96
         6kyAFfhRaTWhsj4/nigxVgpTxz49NtUjvlS8TF1rPv0DDUrHTegHKW0HVJeEw9uSPKH7
         4GHbJpGvPUo6VDgj/jKROPTvAY5or7isqPc5/pGiXVaE7vn0xkayRfJ0wVnWtezr+2fi
         FuQvj8ddafMGEiRTRaUJ3cT0uoF3J+EZfAiBC+AxHMSV6lUOvUBbczuL2O179ROORcsO
         MShg==
X-Forwarded-Encrypted: i=1; AJvYcCVIG6zWciiahNturqnNBz7IAE9ZPFMrQJbLLlDapRLKxsYLVsFroPdltCbifn3HEiE4n3DyoNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7pv7QRHkqLxX+aFyaq5mZfk2GitSf0Z3zAG5K/CP0QiOz0jR
	K26sV3a2bU4HtRXFQ2moUgIosQv22eCKIKV0h0X4ATVng+zIArb2Sy39
X-Gm-Gg: AY/fxX7BL9PPdsJwHNNmDzfGjpuRbBaEVTiYwcGdL5FoTbCnQJDO5Nx+u8mC6RwgW7i
	M9OZXDEUiWXGPgn9AggwNcxEnqONwPuP7CRoGcO4n34eOnqBjfMnnLrEW094k3awbzFwJO8GOOt
	p1tjmOtBzmEc67nAydUpRMaZaT512kk6DMmnxYNaA2PZs59LgNaAlE481FTAcVpaFwsQSsmCs4w
	whngTDnd/1T8g3bBhjqLe0QiOuOV/r1mugtDjeq7G70/6dk5bSYx7HVdJTBrN706478ZSL9Fgb6
	k5g+7g/ZQ1X6H3Ke09Fw14zyg3vaSoCPqd264ZDxhKrcieW6Y2HtLp0cEdsMOPmBBEBjT5vO0W0
	31YEa6sBJQ7vEmPUM97uYtG8E5gm2wgTZEnflQMDgbWZask3rkrfV9DufI5Hhq/BEaUDJIS8Pu+
	n9Pf8Ba8rCGl0Me7ULEzl1HZKl9ObPnsXUOok7K50=
X-Google-Smtp-Source: AGHT+IF2kBqM1Pc1oeCfW9iKt8MagjLl70ZYlJlrxss71glv1f95LGdDpd860qL8p+WKwgQCmnLTnQ==
X-Received: by 2002:a05:6a20:9189:b0:366:14ac:8c6c with SMTP id adf61e73a8af0-376ab2e8f52mr18576741637.66.1766647719168;
        Wed, 24 Dec 2025 23:28:39 -0800 (PST)
Received: from localhost.localdomain ([111.125.235.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79620bd3sm15961406a12.4.2025.12.24.23.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 23:28:38 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] io_uring: fix filename leak in __io_openat_prep()
Date: Thu, 25 Dec 2025 12:58:29 +0530
Message-Id: <20251225072829.44646-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 __io_openat_prep() allocates a struct filename using getname(). However,
for the condition of the file being installed in the fixed file table as
well as having O_CLOEXEC flag set, the function returns early. At that
point, the request doesn't have REQ_F_NEED_CLEANUP flag set. Due to this,
the memory for the newly allocated struct filename is not cleaned up,
causing a memory leak.

Fix this by setting the REQ_F_NEED_CLEANUP for the request just after the
successful getname() call, so that when the request is torn down, the
filename will be cleaned up, along with other resources needing cleanup.

Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 io_uring/openclose.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index bfeb91b31bba..15dde9bd6ff6 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -73,13 +73,13 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		open->filename = NULL;
 		return ret;
 	}
+	req->flags |= REQ_F_NEED_CLEANUP;
 
 	open->file_slot = READ_ONCE(sqe->file_index);
 	if (open->file_slot && (open->how.flags & O_CLOEXEC))
 		return -EINVAL;
 
 	open->nofile = rlimit(RLIMIT_NOFILE);
-	req->flags |= REQ_F_NEED_CLEANUP;
 	if (io_openat_force_async(open))
 		req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;

base-commit: b927546677c876e26eba308550207c2ddf812a43
-- 
2.34.1


