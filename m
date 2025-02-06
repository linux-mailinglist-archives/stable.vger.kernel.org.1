Return-Path: <stable+bounces-114125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FF9A2AD81
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462DA1625EC
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161BA22F3B2;
	Thu,  6 Feb 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pBBytQLq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FA1EDA34
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858740; cv=none; b=ItFvRgasDqdbvhL9kzHy4BHMAhm4V5pAe/YgWtMY61GyC0TQWoIU2w5kkXkqjU79MOBbtB9oe/0dgDu1Eq8WlYMx+l34GFiKybQ3q5wD7E45xbQJr8w513PpOcE/YQYXKG+KamG4uxEpFopXqWJU2qe1rgUwwuXeoJNtX1Y/FWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858740; c=relaxed/simple;
	bh=yPC8cd7Yv67TQ9v6m+NzySO1aVEnoWgnIgj/PobXDiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F22mWgwaqUGLcyBpJBnc83Gk1zETjwCgE3tXe9sz8ucxzHqwWojcvxY9443otBHgj7ojv48LnBI8/fgZaAKmPDW8U/8NjdbfcynEep+5oTDdzRWWjAo03aNDfLN92xfY7IgBbt4UXZmFhymcro+Lxe4KhQyEQQiQtzU/KstgiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pBBytQLq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C9AD3F212
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858736;
	bh=qKjpIhWfmA+LnTLvHuIXBkussVnGJzoHBFiGN/VOc40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=pBBytQLqZ6BMwMu3UTw3dVuGddRhd7R3fFhRH1G4VFPHGlm5Ix1ZXG/hrAL3k8ze7
	 MMgS3CRrwh1EJwLNiE/4vy1H6KhDMU7vO8W+oBONzLOqKXZ/8kbVTppu+jKbSwBlGu
	 WVUgsGjl20JFX0uPG8Lzx6fgwsf6lM4rXqZetho6KF2qVjjempNnQaPTZq/RwlLDyd
	 RewjBPrstjklxcwXn63uK6d+S0YulvJbCfwOLCGX/LIDgy3aLrC+AvP3VOsuKVCIwB
	 T0ZTCSiQO5fSvWtaZ2eUpUnL6lM990A7htt+5nEtNoZcF+hgE2ceAjXT054XwXzA86
	 35rtZsLGWPzLQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f9f90051a2so2211900a91.2
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858734; x=1739463534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKjpIhWfmA+LnTLvHuIXBkussVnGJzoHBFiGN/VOc40=;
        b=m/dtLKNJdKZzCLYSmaSexuhEXSPsYdBgFxdZAsYZAGuleReJL9GxLdnbGqNNKoqGSz
         rC+GHp+mrhueypbdBbLYxe3dcUO6++Q35lcPi/5FS7dkxgU3/jh7tw5ovHcmH2PLIJsw
         GvU1x7JeBi00t4WBf+v58LaKTJZi/9CJMS2vKDclDKnVr8pzvqp7YVodQP7jBl3749Lj
         sViJApwYdCtRevplUovsbktoFNZYdlmpI0ytiIT5/zKsVrP/buRDhi6boiNIS3Y1ixfs
         eAByv27WftN8sK1QCKMzrqJpaCnsYM4OUbmYzlcpv94ps9VHCoJHuP/tXOhnk6xauYNq
         Ymog==
X-Forwarded-Encrypted: i=1; AJvYcCVjbSYP4dr8M81Fx82+CpXxi1dSMetkg9Mqbjmm9H+fuCP26KhWvthUd1l0Cln6h3knDvPe6C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWx186bUxQSZM1ZktFPM1TzQGbjvkQUoFD5jH1Y1PpDDtKYtWg
	HC5gkaTZpPF9F5cLj7gO9d5+3qwjEFT7O/ZaR8QSCkV1vOR6SR5W0aDkWlApWMRSN4KzB3fFFq9
	KPNv4BQzhGBrn3RvZbfO9j2OkpsJiwh3nAJHzfEkIGIl6q0ie+k+hZJ443cb/HcPQEq14pg==
X-Gm-Gg: ASbGncsvPQQjIACW3Li4cESjp8lYaJXW2/qiYALa1pPgZImfxLfm+h6gedF/SqZm5rb
	XYTTVBSeZxxdCyYSeezh7re2nEWG4ggF6Od1gxGQfEGZMbEwdGigdaPCX6AlKohwitTVNtvbkCq
	pGWA9t2QsZz1QxXrooF2CaxrhFNsSRd8ynH0CB2HnVQwo0OcB2VDg0DFYpAjeXwrCBVDx2VmRXy
	x0PzdCbnlBmJlyJP16yIiKt9FVbhe+WpEVVk+tNm8ljBuCgNG1/dZmTEjVW/5mnDXWLJKFC2U9e
	mCPF0gkOjJMVgbmXQMZZClU=
X-Received: by 2002:a05:6a00:400b:b0:72f:590f:2853 with SMTP id d2e1a72fcca58-730351057d0mr12166151b3a.9.1738858734714;
        Thu, 06 Feb 2025 08:18:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA/91WD4JaWRk4/x7RA1iTyYs0oakbKCfq3gGuIzQRdPwJTV2wKWgvn2Sy2poifVVIO3tHbg==
X-Received: by 2002:a05:6a00:400b:b0:72f:590f:2853 with SMTP id d2e1a72fcca58-730351057d0mr12166113b3a.9.1738858734361;
        Thu, 06 Feb 2025 08:18:54 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c1634asm1531019b3a.147.2025.02.06.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:18:54 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 5.4 2/2] btrfs: avoid monopolizing a core when activating a swap file
Date: Fri,  7 Feb 2025 01:18:25 +0900
Message-ID: <20250206161825.1386953-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206161825.1386953-1-koichiro.den@canonical.com>
References: <20250206161825.1386953-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.

This commit re-attempts the backport of the change to the linux-5.4.y
branch. Commit 3d770d44dd5c ("btrfs: avoid monopolizing a core when
activating a swap file") on this branch was reverted.

During swap activation we iterate over the extents of a file and we can
have many thousands of them, so we can end up in a busy loop monopolizing
a core. Avoid this by doing a voluntary reschedule after processing each
extent.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 fs/btrfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cd72409ccc94..004894e6dd23 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11079,6 +11079,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		}
 
 		start += len;
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
-- 
2.45.2


