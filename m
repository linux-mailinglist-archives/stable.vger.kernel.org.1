Return-Path: <stable+bounces-200997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F9DCBC49D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 04:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FDDF300C2B7
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 03:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2516927EFE9;
	Mon, 15 Dec 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6dR8qBy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285024677D
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765767916; cv=none; b=UCzoXmiuqf74hpfeTyETfWcoIrtIDfVRgbgajs637UPQ+6pM7g3qojWzr2jmymuVAFNqgcysiQ9KqpWrvy8ohkuemmZwkg+jNHG1ltnzHQ/ytKTXGE80hyt7FzcmW1Po9h8HoNAgz1FDzbMzprGlv69HP0+V4dYh37LnN1GP5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765767916; c=relaxed/simple;
	bh=g8FVms4VncapiBHywfgsts5vQa+1lh2OyHkG+GRkKr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RRgfCPASJ3K5XDHkdR6bCtc0lNMSptVHew1Mrl0ShXpmSr04HNi6Bs1oTIRpqd/ZhzLI38m76BywMNHnCw/XZafIgQA0p35M+5j4WFJHgShvAlxu1Sd2goy8f7Fp/s03BUM0ZmirHn/wCmXeSAW/pOwWxN1PKLx+FseDvIDZo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6dR8qBy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so2389467b3a.1
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765767915; x=1766372715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zXXpU/9CotrtWEEiG98xKEab5CXEiDdNLNXM5TNCU28=;
        b=c6dR8qByAH0ibKyWiZuKlWy7QATnlpejXRSURuAlOcncMm+I6H9cJZ+SpWGh0vEPTZ
         jn4T0Xr8uU13MHJpEyUIMmc5kzRyqsIXwoat8R4CN2YdiylSCaknJYHp/purm78ZciMa
         JHSffZ8wQeV9Jbt5lCwdHG913HZX02RGgrnMtpNF6BLQYKuJ7sbffWn8FtZijjVYsp1U
         4A707KrXDzQwgzfKx2bRAf94lEopi/rutB6yk25nvovoB+9ivHbfm+JH+X+HV3yIYJSF
         uT33FrREVV8nfS9dYszpXhkuZ288ipwtKoh6m9dhTYYJTUmEcJrkX1Z9v+ai2UARiIMT
         wcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765767915; x=1766372715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXXpU/9CotrtWEEiG98xKEab5CXEiDdNLNXM5TNCU28=;
        b=gGGQ2KWljkb6Yf6eLi2BU8/C3d//GqJytjQus9DkcKO0pstoy+aPqmGjqXS6vWyGQG
         RnjVw98GWZhAnGPK6OqAZN+c9/4DDbRZV1eF5DEoIa+53yLiI+9G3tFvsZEDTrt2+LPI
         +rHKr/C5FsLUhgXkHOQwSkKXxrudCc3u7O+/NmTIpWsBjWX/qJUATWePYsTQre2rlR87
         E4wFOHa7fqMD252epfAV/50PJJEb4VHirAotr9MfluSoRl5YRt1qYgdPoG7VlsN9Ac8X
         FnF29/ekraFdqqiGZC9TxGNQPC4lTUzvIL8PtWJS3a2wdx10WSI1DOZMDVntnPX6LGLm
         MeCg==
X-Forwarded-Encrypted: i=1; AJvYcCWAVNV60eDPR/ievFVdtJt3klNJZNKxq7ETPg2SO8rJO+m1Nth45UuLatQb1xm4fQLCfbyqP18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxygk13N3ED8fB54UknMCWAB3bcws7I+4g1Ro8qToDvWt87xFzb
	ffCZ/hUqoUSzciG/1TGDCXghcJn/jLM7+TnEcBjkutNJ4WqvNfGnyq8hgyTFwFBfPRI=
X-Gm-Gg: AY/fxX6RH4oO+QgPUmu3RYznESctTRVkISSvIkcHq97jP3e/eqwSHrHpIexol/co8/C
	amRtpDUl2advxUAPL+a1JXgxtKA/okm16R0f4qfi7VMQum6ABJG4CMT8aENc3D29yz1OJT6v8TD
	1Chtu4FthfpVh5RXVzQGZabb4KMu1bpw3gmgHKMw4r6FAgd5+Yd+uQVPsy6a+/7oTcn0r4/wKz3
	55w5BUVxdIDpyflUggutS5vVMxpI42Nu0wHkrtXl7zSVPvIfRkvXRHEIdqKyVm4ifHsRtswyp+N
	kn4v9cB8uDZdVr0wsuKuQusOm1TF8/VH+jA8fy/JAqjws+twLYCaeIVysVNWnQdtiSZYmJq+4/q
	G7EhjdZG2NIhffiA2DzegQTlGz3LwiG7aGapv4dEw+f/V1t9g1Mn0hr8HPnWBHfkYcHO1i0YdbS
	sMSvD6+0GoHoyHSDIw5Q==
X-Google-Smtp-Source: AGHT+IEhG+s7Qdn4IqoxJXommoVwYHiYpBqW2Ql1hw6PgOHtDqOeuQwZ9k+xUgSbT5iSjK3nvYGa2g==
X-Received: by 2002:a05:6a00:4502:b0:7b9:ef46:ec61 with SMTP id d2e1a72fcca58-7f667b26cffmr7887410b3a.26.1765767914706;
        Sun, 14 Dec 2025 19:05:14 -0800 (PST)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c27733edsm11076298b3a.20.2025.12.14.19.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:05:13 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	athul.krishna.kr@protonmail.com,
	j.neuschaefer@gmx.net,
	carnil@debian.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()
Date: Sun, 14 Dec 2025 19:00:42 -0800
Message-ID: <20251215030043.1431306-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch reverts fuse back to its original behavior of sync being a no-op.

This fixes the userspace regression reported by Athul and J. upstream in
[1][2] where if there is a bug in a fuse server that causes the server to
never complete writeback, it will make wait_sb_inodes() wait forever.

Thanks,
Joanne

[1] https://lore.kernel.org/regressions/CAJnrk1ZjQ8W8NzojsvJPRXiv9TuYPNdj8Ye7=Cgkj=iV_i8EaA@mail.gmail.com/T/#t
[2] https://lore.kernel.org/linux-fsdevel/aT7JRqhUvZvfUQlV@eldamar.lan/

Changelog:
v1: https://lore.kernel.org/linux-mm/20251120184211.2379439-1-joannelkoong@gmail.com/
* Change AS_WRITEBACK_MAY_HANG to AS_NO_DATA_INTEGRITY and keep
  AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM as is.

Joanne Koong (1):
  fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()

 fs/fs-writeback.c       |  3 ++-
 fs/fuse/file.c          |  4 +++-
 include/linux/pagemap.h | 11 +++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.47.3


