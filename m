Return-Path: <stable+bounces-202920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32234CCA2A6
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 04:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A64A1301E6CF
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 03:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54F12C0284;
	Thu, 18 Dec 2025 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaTA2qCQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4023D294
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766028216; cv=none; b=M04FxPOEZNwXD9v2X29EPDgm1glRPSiCNoVkfA4QGYr0U2hLuknBWJNdSqfQVdrmW3m4GMX9uigabM4hDp4EMv+kUeL+GVNwAoIh9MfnXa0fTXY0odFzYI6uuTiu3Pd23Of5dqy+IQiA+F/dZbqsAQTmqilHJHyPLomSxr0PxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766028216; c=relaxed/simple;
	bh=hFFblwx86ZqfGEV3nxo2B7GDHQAhuu5OeGAZxPRChv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7wGUFssWV87yS+enflCqeIbHatx1ITu9Uq8AdDe1eUOWThDUF0rjkkmY+o20DcUm2sGEt4z52lXk1SeBiC8YCnPwh0nLOtl7UlQxld9R3RvkUr0Ia8KzcgcT3ZhWNfUGe7D4yVA/fKocZbHZYOIXYwAkyz26SEaDlEYSBo3zxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaTA2qCQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7ade456b6abso171506b3a.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 19:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766028214; x=1766633014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UG7pfV58XRZ1xvXhlyO6OK4zqz4Y181lJscZD1whg/U=;
        b=aaTA2qCQPtiF9SLs+dGvKc8W6z3dGHr3OdEJka2EKWKnaf/8Samx3IGpXUbMXqOX49
         pshFajsx5Y4zE/EyOlB503An+7PJb0Wb/cu5DX5Bp0bWs5UcG/JLL2F8TBOGMebN5Fbc
         LsYoeEIP7QYQ8TTJYQ2lrGeAiofIvdJ4gTXS3opoUV6BZyDVcNUTCkkqB8hn7Ti3P6eL
         aGZPcgQw3TbdAIzQBQYHY1yGejpFtLkCZNIc/qvwoxpMNuiSlE1uvqQVDfhetZOAI3RT
         06kEdy8CQuPAUL3/waPxDsoc1LN/H/gfp/rlQzkJCKlBLirlb3enFiICupq+ckiWmtBU
         wYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766028214; x=1766633014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG7pfV58XRZ1xvXhlyO6OK4zqz4Y181lJscZD1whg/U=;
        b=m7TeTvZla45LV+0qm4JFvwXMMmrO3Zc0gtgU08r6ywfTsUtp19sDesq4+8HuG/24ek
         rxGafsV8dHCqaPtyvDfWc/KmOsnByQtiuB9DzbDIfsmPdRYm8n1xvb+h+uzT1M0U9b4c
         Q43CkIwZbmk2q1o7BGTCjmYr2TJGRLQcOclTHXBTi1RsYPUHq0TGXFvvcgvisEFDrH58
         O/6zn5gkIpe2Ah1X3L4dRu6RFjO8F2B0kTtMiJdnt0kVIflDG7M+EHNNtylyE8LuRD0D
         aLYUQc/AFpeVjobPb235+u++SoCoXRm0vS9gYtkk146SSn3Gl5AfD9gQHavox2twPeXP
         +YpA==
X-Forwarded-Encrypted: i=1; AJvYcCWt20r903Y4dHg5mbw3p+izKsz5aj+ookj8tAfl9Ko4knaC6y4JOykNqbN9XPxvaBd2cYQiOYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVm05MaaqLRiYvxn23aQ6TsqY79qhKku7aEM0cga69rVhcLicL
	R4tmvekOo+x17EqycV/XARBd4/b7yyL0n9008cHeJx7uVRY4nxetpA+x
X-Gm-Gg: AY/fxX4LaSnWIJ81M7pWXM7bl569puP7QrIaZ0aBTYLkDMzT/EpT3oaQLSeUOwk5evC
	TNr4TsD+GNxLVfdQ3HyNY7FXZQHBNo8fVfh5CGkpiDVE+NMvhbNV8qbhmcSfGCDk6gwfLCwVsi6
	hQvCobFFtRmbcNH1HmtqlHOdOBX2+PNbzl+malX5+3U5KORw1v1Wt51Bgi2L4raPNBr16wJtIwd
	vEKA/jT8BBqqyxdMTg7A78cGg0yweoHLoz9gE2P6jzqA+xoj7ItEqYHu7ufXyntjc/t4DzDafYs
	aFhfSTjHG7whci26pMclZgfiLV0UrY/0voIQLqGI2R7jlButy5erSVkeGx+qONG9NTwzrMIuSfM
	WUb+eT+o4B0wXK0F0OLKSEzqJyr8WSSGWhXu5ac1GHNNqlmbNpL0/2QsZNunAFL9f/3FM9TUOe/
	z06uk=
X-Google-Smtp-Source: AGHT+IGQvq/DdZI6Fp9wfMB+YHKDour/ZpI/dwBFNByAuJ3jrP5gtK30k5BaErSIpjYma/as4s6gNg==
X-Received: by 2002:a05:6a00:bb84:b0:7e8:4471:8e4 with SMTP id d2e1a72fcca58-7f66a470cd1mr18789906b3a.69.1766028214396;
        Wed, 17 Dec 2025 19:23:34 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe12125b0fsm884992b3a.20.2025.12.17.19.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 19:23:33 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	stable@vger.kernel.org,
	syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com
Subject: [PATCH] exec: do not call sched_mm_cid_after_execve() on exec fail
Date: Thu, 18 Dec 2025 11:23:23 +0800
Message-ID: <20251218032327.199721-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_mm_cid_after_execve() is called from the failure path
of bprm_execve(). At that point exec has not completed successfully,
so updating the mm CID state is incorrect and can trigger a panic,
as reported by syzbot.

Remove the call from the exec failure path.

Cc: stable@vger.kernel.org
Reported-by: syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 fs/exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9d5ebc9d15b0..9044a75d26ab 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1773,7 +1773,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 	if (bprm->point_of_no_return && !fatal_signal_pending(current))
 		force_fatal_sig(SIGSEGV);
 
-	sched_mm_cid_after_execve(current);
 	rseq_force_update();
 	current->in_execve = 0;
 
-- 
2.43.0


