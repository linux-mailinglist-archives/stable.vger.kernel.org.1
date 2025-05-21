Return-Path: <stable+bounces-145826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB666ABF41E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7FD4E53CB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF1D2673AC;
	Wed, 21 May 2025 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSg4tiE5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BF2638BA;
	Wed, 21 May 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829828; cv=none; b=FoKLl1pb3fWS7/7YKgA6/cMLeX9zf1EfD5B/MofYTy280Gd2kgC6d7WXj4micfFkKQ94lBao+uSIbN4op2njE4PAAqF8IpMnUZWIre+kiUDykZvkrwe+GJiOoz6dXUwNLaur+Z2YbVUpBWzm/8Jd2HaP9++PVxuuobAHnq1r5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829828; c=relaxed/simple;
	bh=c3ubuxlNGg+Ji+wcS0AvojNc40TamrkIX8Wle4MHPYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVunm2hgrSHS2aGzwC0G9ueuG1hB4NaWsGI4ibENfjLFfnOLdOcFf8oZOtNNilvb1Qb+hXTrJnQrgHczPf2mNLDuW8f6EbxLTbFAE5oGnw/2rGSgZIRHVvkuJTYSmc124ztgsJU23DhUcjCKp/D1Gf3kwYDN3visSOjfmBOLKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSg4tiE5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso1736279f8f.3;
        Wed, 21 May 2025 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747829825; x=1748434625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfuPOLZyIK6X8T/dJ1EwKYVAFAe+RVKQ4JBOq0cMKGw=;
        b=cSg4tiE5X/5/VOjAGbJ69agg3pi0dg1JAsKVFPAsGH6lsalIAJ/0HvKDnm327Yujus
         DP5mySoaq/Zng2YuKOjBQk7LI1TJeCJww31hIFPG44v0j+hwNeK8Po6ByMtQxEHdu+0g
         jGilGR5d4YTpsPuHaLzEuvqM9dM6NnNhH4lLWS/8MRpMi9di0r7HJ9w3oLwVIpfXF17b
         yvw/YScUFsPcKMPM+RZVZRnyz07ROpa+ZZA0M8edyJSuDWxEiMS5OvQ1gUknU5PXXjCf
         CeZXdsxLDyPx3d9+1MlK43LAa/TZe7MKGR0nTND5HaFLX3wAfmEGkTzz2oZ4aZuDnYah
         6jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747829825; x=1748434625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfuPOLZyIK6X8T/dJ1EwKYVAFAe+RVKQ4JBOq0cMKGw=;
        b=mwVdesMA5iqCGQbEdevznGjsei44TUtZviPc93DcYktxEpm8I2zW49yoV3FjeQPXBG
         Ls8tnfolBNOFQNmesd120Gd/KzBP1xOSnOq/uHy3ssOMxVXisVYAUzV9+C1zVaAGq621
         ZJLF0GLMUIJSk+8BZXdTpZEtJXUGR7p1q3PHOuB9m1Yp1c6LldvAKYjM8JoVWvg3lhQn
         UA2CeLaqacCfNHclTOPcq16gfhnHY0GB6r365P9LxDQDlmnjAneQf6Vl9ROY5CmQiYhu
         LtX5y75MjS3GGFTVAnD7WO7o0ahhysQxfUModVzO3KhbzQlH6Abb0AhFSvTi9JZbuRcz
         VQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCUHXBcrXnCf8ssgMfxnapZlyycNL9eLUy5xB/wtR5hFWFXSNC6g9KfGtqLNERMsBbGh4xeus8Yu7NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFoAIxMZNXLlELhgPc6uSXvp69Aul1tzwT6VQ6ptRpFUVgUErM
	MBHbeAdU4HqajY8RTHBEZbUnIAl8/IOQN5++2dXccMScX+nP/urgRUkoSLpRcZGG
X-Gm-Gg: ASbGncukohY0BAM18b9kIx/7KppbBxbmlDsVzjyvjUK84nOTKJEbHjwBych2fHg5Vj7
	51HE8XlWSoI5ZBp4VDd2UzSM0NQf0b0zFg6N8gthZV96xWs9WiDeEDrBuLOEniZzCD0ntGNQuFa
	pi+TQ2fSC/u5c9kXxMiRdxsqECYTABlhSOhr6vW49n//2R3o3SFc/Pfgt8w+eNREXF8Ho2qaA9o
	MJSw32619nwCkYShZTjL3G72On0frN7zOfaygOuKaMyyoqIVEPg3SoDbNJb7Q5Sx3USWUn7u9XL
	xaws/KF3IgRQ2jx2N6nvJppHVPYjhVJOg/ty3VgpxculA7ubwslD6skt6jZJ4QmoGdBgOEb/58b
	zJvJHKehGCs0=
X-Google-Smtp-Source: AGHT+IGZlaDNF7NrgM+N8oVDV7cfzlt2gT8aGvYGQB8TWqnfBvlAc/9tBoQAYcqRT+FOD6n7tEWTQQ==
X-Received: by 2002:a05:6000:2908:b0:3a3:6c9e:1691 with SMTP id ffacd0b85a97d-3a36c9e17ffmr11035075f8f.53.1747829824548;
        Wed, 21 May 2025 05:17:04 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f0552esm66327845e9.11.2025.05.21.05.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:17:03 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	guido.kiener@rohde-schwarz.com,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/2] usb: usbtmc: Fix read/get_stb and timeout in get_stb
Date: Wed, 21 May 2025 14:16:53 +0200
Message-ID: <20250521121656.18174-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1: Fixes a regression introduced by a previous commit where the
         changed return value of usbtmc_get_stb caused
	 usbtmc488_ioctl_read_stb and the USBTMC_IOCTL_GET_STB ioctl to fail.

Patch 2: Fixes the units of the timeout value passed to
         wait_event_interruptible_timeout in usbtmc_get_stb.

Dave Penkler (2):
  usb: usbtmc: Fix read_stb function and get_stb ioctl
  usb: usbtmc: Fix timeout value in get_stb

 drivers/usb/class/usbtmc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
2.49.0


