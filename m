Return-Path: <stable+bounces-114156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A50A2B092
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295D63A687C
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E681DED5A;
	Thu,  6 Feb 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT1nl5m+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE11DE899
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865767; cv=none; b=ha1+lrjYPvsddIsXBXNdXbXuxuCZtQn6bTIpOVXnyQY4d6PFtpe/IbT5JkWwH7qT9TUMBdNRCh3I2q2X+LEDOkBbTZu18we0V24MiOF+E+q8pd2D0sJ07LrKV9ol3dG5eEsYexURzLDEcqTY0SAwwZKf9f2G5wNhdfpbTPDlR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865767; c=relaxed/simple;
	bh=0aQ4SHrAEfM9qQCF9mgDHsyk90MmqOlKk227lDmfxXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SInI88wVUdRQF4Mm2bVh43Zk/pnv9QEvrWtwQZ5U3BETtOr8gFtiDpN2HlB646KQG7zR9LK8ssUx1mGxJKGkjY2JfS7WB/4z58PlLCTL0psLl8ONyTTNSkbYDVnv+SEoc+1k2vamH4hHjcxtbLHdTeijfn2EGefqOcRrptdgBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT1nl5m+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f2cfd821eso23351485ad.3
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738865765; x=1739470565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pep0Zfd9ohRJIrL1/uMD1v5Vjq7RMwGGxGwQTK8Q/M4=;
        b=bT1nl5m+py9SwiusNtK8bJz8qNiW2h/o6xYaGkhnL5SzI4eNIKIsUoGFtWkdiLv9Z+
         Lj0Gnvda1RVFiorD93ToBfDPlrAGFpiZG9Re1PG60g/JMgCC7bAgSCyiUtzf1Ukj3oJw
         1Kme81Gp9uevSAf8mdWDj/Ot446xsilB81zJul3Z3lNUP4zPdAz361B8+9cdz0GCSA2q
         F2HqPIe4LFTMxOskjqCiYIe4/T+juBaBjtWwvHvJ58GxPcyA2WT1F+EjOaePiHEv5IBS
         87rpQE/QjHHxPSZ4k0z0g1RsMWUWujZGVsOHHKHg2f/2kHWAeCWvQhYXTZL60WLMbELg
         a8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865765; x=1739470565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pep0Zfd9ohRJIrL1/uMD1v5Vjq7RMwGGxGwQTK8Q/M4=;
        b=Ry1kSyx37vAbjlIlweNu7OTcWnJkdaa+ZV63hFXw7rzjhjuDF6Q+nwqT69TM28VmOX
         l1/btppxpDDVeD0/7k8xaLqWbPfTAlETTId7xLfgvAzQaqq484XCGfCAygna4QYFcm3H
         AyTkKezwIaDZ49P00k7XF4VQMqGXC97KwY6ihu7xmfivcTHMicfUT/GcMl0KtszzJ1qN
         ZVK4QP6q9JgSIIlg3tgWdaFXEbr6JSzWeEMYkWq0Cc+f35w3HAT1AcEfpk56W+8wf9fb
         uoeIwYAkH6hxdXC78vx6YPRzcgYYqBub2DYMZc9+Zr6LeGrvRiEMQlje//z8JfbCbtL3
         e44Q==
X-Gm-Message-State: AOJu0Yyj3t5hi53Lkp6f/T3/KXrsBOOyAouFn0h3pOjfXYFC5mKgjdH1
	uZ9piOWE7Kck7349TrLqGKEj1Z15EFOFG4NeD86euor2KZO6ioU9dEj4Ig==
X-Gm-Gg: ASbGnctbbdBviW2BxwCCQAk8hixtPxptcLjPQKYONTiwFa2a/uu8jxYuMjtpbmd+pDt
	oZwdlx9loSeIdbY0+YKr5isHNGAjJcq81dirs3DeaQR0mClXGqv2vG/1r36fR9RWRRlb+Hqkplm
	VEzBI5iJ6+1opCpPKlVx//cEjs2EsoyEKAgpm37INreR66uHjJ9WMwyoaCQRLFcA9iUFGJv7VTQ
	9Z5R1+AyhVTVWwxK/2kX24hXPHl5zwT0KnVtnBnLeKtnnSIYwq2b4Bjs6Q7TKw+7ttnYGgBiG1U
	1Ood6xTuckwN2n2padX0E1pWN3ZVGXYQCIJzdg43zfGVNmHWTlrlttQYjQ==
X-Google-Smtp-Source: AGHT+IHJzQX0CCRIse2rym7GVNocgq7QEYtT9FC6fer5pUJ92m/1Yzywfdk8t3+UmoIvZt88ty1N/w==
X-Received: by 2002:a05:6a00:a15:b0:727:d55e:4be3 with SMTP id d2e1a72fcca58-7305d463732mr341269b3a.7.1738865764958;
        Thu, 06 Feb 2025 10:16:04 -0800 (PST)
Received: from carrot.. (i222-151-22-8.s42.a014.ap.plala.or.jp. [222.151.22.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1375sm1587200b3a.119.2025.02.06.10.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:16:04 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 0/3] nilfs2: protect busy buffer heads from being force-cleared
Date: Fri,  7 Feb 2025 03:14:29 +0900
Message-ID: <20250206181559.7166-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please apply this series to the 6.1-stable tree.

This series makes it possible to backport the latter two patches
(fixing some syzbot issues and a use-after-free issue) that could not
be backported to 6.1.y.

To achieve this, one dependent patch (patch 1/3) is included, and each
patch is tailored to avoid extensive page/folio conversion.  Both
adjustments are specific to nilfs2 and do not include tree-wide
changes.

It has also been tested against the latest 6.1.y.

Thanks,
Ryusuke Konishi


Ryusuke Konishi (3):
  nilfs2: do not output warnings when clearing dirty buffers
  nilfs2: do not force clear folio if buffer is referenced
  nilfs2: protect access to buffers with no active references

 fs/nilfs2/inode.c   |  4 ++--
 fs/nilfs2/mdt.c     |  6 ++---
 fs/nilfs2/page.c    | 55 ++++++++++++++++++++++++++-------------------
 fs/nilfs2/page.h    |  4 ++--
 fs/nilfs2/segment.c |  4 +++-
 5 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.43.5


