Return-Path: <stable+bounces-183647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E311BC7308
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 04:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C68119E2C5F
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 02:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352B48615A;
	Thu,  9 Oct 2025 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt3Iaty+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EDD4C81
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759976283; cv=none; b=k5L6grfUCirqPi7IB/hGqJouhgcUZtXkbIWetUMRSWk56x2KOwhW5+oZBNREwaGC3jIb5M2mBO7Di5nuLl2JuPVrELTX+/i4o/OM5sDv6ZlyogcSzvy3q0YThE1dVAduPt+Z0tsdn+185W2PmKgtTZpMPEkDtE69dihvaFdU6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759976283; c=relaxed/simple;
	bh=UPpanAGwa+ZBbXwSP7/T+zKiHQf8/QkRlgpF98tPimE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSXz7E+R1FTfv6UqtTNyBIy5Ic0xCuHh3HjRX6hdjUPPrWlzqq58q2Td0n1VbCzJCdkmfbFQYsdSCO3DDDrebL2vq0gKuUSFXQ32qtStlL4S0UmX71adzDFui5VqKCG5+qlhtjVI9xDu1OHCJNPIS3KxZ70yZ4oQL7Rf+vVuG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt3Iaty+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4256866958bso262925f8f.1
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 19:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759976280; x=1760581080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMwXLPH27WuiEOjKg3ccYDptKtMt8Wlr4nTnNsdwDvo=;
        b=Xt3Iaty+qg50iyEURpxQNUtJE2jdftMplckT92f/N8mV0G0Fh/GJk7rzsKcLoT1+yJ
         4FgEraiMHq8cBxbhL6xLZAwN+qv1bjTGkJ0cO1RT6tOK0ktxktB0L5pNKeosjf4aya4M
         BPhEpUTQyIJgrwyAD2Bo1nSIiE+YSmqHPbzNZ8TskYEAalc4JONdrZDfINUugQzi0eXk
         o0aA5jeCchlqHcmIGtml/dvL8fMquQOmiTbFCh4CqXS/rHvdFP2ijj7pDHjCNZIDLAIu
         2KiTfkXW0rsWBBIxeLhYGr38HXJjauktcNhXKFbnAcHw3dth1G3UkrqHngYELzsvkV5h
         73hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759976280; x=1760581080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMwXLPH27WuiEOjKg3ccYDptKtMt8Wlr4nTnNsdwDvo=;
        b=EqdjgTgoIwxKlxhtMhD9Li2D+14WK2aSz+knUZDET+LjcnXvlRSJyVNwAhqCxreOvK
         d8eHtYIbYV+joi+MXt3UZ+7/aqOMNxu7hBqLAsVCjuZ/kUJfU9DUFh+z3Z/qM8pM0uSq
         za+bw+pBWUz5c4SzpfGoR12T3oKYrMLaX2nHe9CuALLwmnixA6frXtWpJ3C4s8nDf+VJ
         7I7fTCv8/JGzRYDXYu+OnGlE84E1Ta9L59W7CZpRuuFDYc0VF7E33DXtHXKbzUjM6El6
         Q9GZkWJuOEJIPjcGa7FtV0LsbH41NRBXKiBssHjmCv7HmceVw2S61QbEtHd1Sqkoi2pR
         lsEw==
X-Forwarded-Encrypted: i=1; AJvYcCWPouDLtZhP6gBB22M5w/mQPrJ03B/XuqXUzWsHN5F7AHxJXv271883pV7fWft1jkLF+I4AuzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4c2GWYA4BJFkJnk3o/XvUhzDHM1IdWIjJKzFSS8VGhQiS7rTO
	PktDHzosOKQuSGR4fYnBwgmVxroSwTcJgD3CfbztEvEZbZBFvKb1wNAN
X-Gm-Gg: ASbGnctc/DxqWFXzq+FChFJB0K22Wj5/8w/nCbm6vjpknRw0w66r6hjocPmCpdB5jBU
	0HdxwITiez/KpXEQx0+a3MsnEuLgHikyRFS7eObJFm1j6JebkDjdDFzekpn52vpooAjfg3S3sTT
	zlIjZ+XFSu0YoTGH4NKcnzi3jLa0n+sJwqKVeDVicS/sK1yG5a9xIqurxeznTu/WHoxajcHaIbd
	WyEtU0sWqylg0ZW6C5I9BaP8MNYFGLkIKug9+xYC69XZRhfpRC8sdx+uHCAbvX2gUJxPnbQYkdX
	nAdqwSLDxdLWvsXnzJ7q6DvgppCgYuDHxGyXTisBy7TJU0TjYltX94tPo2Eb963I9ncCR6/ezGN
	GOcZ7pmTDOfwuWoCrfcBFb8WXPAof+yc2Mt1Ed4g8JEQ/qnVDTD+ERlsz1mzdVWw=
X-Google-Smtp-Source: AGHT+IGkF8cnCg0NUgJr87v3b6RBEHWZZ8L7rvOevRDn7+hjom4Wb24Qm/GEl5r+wlLmW+LXsMv0Yw==
X-Received: by 2002:a05:6000:4025:b0:403:8cc:db66 with SMTP id ffacd0b85a97d-4266e7df9c6mr3333203f8f.32.1759976279696;
        Wed, 08 Oct 2025 19:17:59 -0700 (PDT)
Received: from ekhafagy-ROG-Strix.. ([41.37.1.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d7f91esm60094215e9.20.2025.10.08.19.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 19:17:59 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@linux.ie,
	daniel@ffwll.ch,
	mario.kleiner.de@gmail.com,
	hersenxs.wu@amd.com,
	Igor.A.Artemiev@mcst.ru,
	nikola.cornij@amd.com,
	srinivasan.shanmugam@amd.com,
	roman.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	eslam.medhat1993@gmail.com
Subject: [PATCH 5.10.y 0/2] drm/amd/display: Fix potential null dereference
Date: Thu,  9 Oct 2025 05:17:10 +0300
Message-ID: <cover.1759974167.git.eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series backports commit [52f1783ff414 ("drm/amd/display: Fix potential null dereference")]
to stable branch 5.10.y. However to apply this i had to backport commit
[3beac533b8da ("drm/amd/display: Remove redundant safeguards for dmub-srv destroy()")] first.

Igor Artemiev (1):
  drm/amd/display: Fix potential null dereference

Roman Li (1):
  drm/amd/display: Remove redundant safeguards for dmub-srv destroy()

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--
2.43.0


