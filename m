Return-Path: <stable+bounces-81212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835DA99251D
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 08:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B5F281A21
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC71115B0E4;
	Mon,  7 Oct 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxRzDPye"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48716800;
	Mon,  7 Oct 2024 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283995; cv=none; b=s8pbnF0n5J9Gux8oyGk3LrykmNY5usqlSW+0tk+CP404yzvKsDoVbnXnATF//eVoJYetHGgPSEt/0h/uMmj0MhgFmJurtYM6LJVt39zy7wTwxV1S7zkRbuftr/qZyNVM9WvlHlfJvVo6qXennSTjz+2Zygdk4oWz0w6T0Ia8A8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283995; c=relaxed/simple;
	bh=MhoIs3jpZky22qoMXlfwHS5b1TYGEYKhWGXzdqB4OTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Prj4QoqzOnUSBaIsj6Sx+NS4UCeOle/5hZwnsU2auMZ4poP5YoNAxIPlEy4r9oTDhW0bXUo1Ptj16KAd10FUqxcurCfUbbFlCGPiCwbnmHs5AEgdCJcMD0uqZm8IRYcmI1mqlzqgX3aR5tuGBcRur4lAZZs4WPfLh/n7zYADHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxRzDPye; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-287df15714cso676494fac.2;
        Sun, 06 Oct 2024 23:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728283993; x=1728888793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ceeahQe9wcl46lPcO7fUS/hyZJL8m6PhkmRtZJytXcI=;
        b=PxRzDPyeDu/hzK/fqr3bsUz+H99wpkJs71bhs0+cfVWqekWFrV18NONWC8x8lD3hFf
         QW6qwrzgwYB6wlMfdUyN/w8SD2ndjQ5swClZlOGLpmL4VkrS068rUhCQCCmd3D1tVc8H
         p3yFd2kDh+OLMu8AxQaDAz6gcNsjW0wzlVLY7itZJuNQp2k0hNedG2k3PFjEnL1GTZf7
         PPcgL5j25gZVNjQTx+uivcjnhdro5V9Wz+VCYiL20VvD2j0kb9SznYOc1OldKNBWu3xy
         uHw9nt1v1KpWygsJUaDDdY7FIKl4QPiNfiBqu9R4OBiOpot50C0tv4ZGB5j9da5nH9q2
         /XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728283993; x=1728888793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceeahQe9wcl46lPcO7fUS/hyZJL8m6PhkmRtZJytXcI=;
        b=e1+lkI+9GlGg9JpY8I2cQX0lZnjfWxgK7Z3pwvfXT8GYEEoHv0lPTslRw5/fxury6e
         Ht97XgPsZbzVG1jDn7W/Md+DNr5TNTSz8Vdbq5V7csOmfHMce3kvYfcVoVzSp19bre7t
         DW1SMeDKLaNA13qKKmgI1UxBqOZhkOMIrPHO4E5ziThkUSEePBQD9JQBPEeE89YR9KkP
         SPLBYkRkzp212iBr0XhMjIagrTOxzyhE8vXuG2rem45+IAGmTO6RY4zfMsMWJYa8wgM/
         XKofL/cb/kgsjo6xY8Cop5NvD7+4pswOMiFOWtt5GIp1MiUOBsluKit8xWYNITbR1T65
         MhtA==
X-Forwarded-Encrypted: i=1; AJvYcCV2zpZfE6Vni54kdlAYv+K+nzLHqGOifc2GgFzOysQUOakr/75NWAYPaIFu2doc2p1hR9r5slnhWJd8hdA=@vger.kernel.org, AJvYcCXnpLt1YIRvbpCeBsnLbpZowWc3OSt85rQXyjp4Q7KcWR72VL2hovm8HTs1xzBmycizRYV8CsrA@vger.kernel.org
X-Gm-Message-State: AOJu0YysxZjAaM7lXefGM1LfAa5Ui5/gd+pfcSRHlITPSaicN9zXdpHO
	+QxnMDXE9opOVkPmihU4xcrmK7powPjQQQCiiBwBe5p7wSul4eEn
X-Google-Smtp-Source: AGHT+IEpvg/fv2oPovXfNcR+vR0vuvo5MLzuioMarvk5onqXjaJ/QULoZRprNjdBZBm6qHzZvky/qg==
X-Received: by 2002:a05:6870:168a:b0:287:7695:6a87 with SMTP id 586e51a60fabf-287c1d38d48mr6445913fac.10.1728283993195;
        Sun, 06 Oct 2024 23:53:13 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c376cfsm3542555a12.61.2024.10.06.23.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:53:12 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org
Cc: usama.anjum@collabora.com,
	peterx@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] mm: remove the newlines, which are added for unknown reasons and interfere with bug analysis
Date: Mon,  7 Oct 2024 15:53:07 +0900
Message-Id: <20241007065307.4158-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking at the source code links for mm/memory.c in the sample reports 
in the syzbot report links [1].

it looks like the line numbers are designated as lines that have been 
increased by 1. This may seem like a problem with syzkaller or the 
addr2line program that assigns the line numbers, but there is no problem 
with either of them.

In the previous commit d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC"), 
when modifying mm/memory.c, an unknown line break is added to the very first 
line of the file. However, the git.kernel.org site displays the source code 
with the added line break removed, so even though addr2line has assigned 
the correct line number, it looks like the line number has increased by 1.

This may seem like a trivial thing, but I think it would be appropriate 
to remove all the newline characters added to the upstream and stable 
versions, as they are not only incorrect in terms of code style but also 
hinder bug analysis.

[1]

https://syzkaller.appspot.com/bug?extid=4145b11cdf925264bff4
https://syzkaller.appspot.com/bug?extid=fa43f1b63e3aa6f66329
https://syzkaller.appspot.com/bug?extid=890a1df7294175947697

Fixes: d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC")
Cc: stable@vger.kernel.org
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..7dffe8749014 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1,4 +1,3 @@
-
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  *  linux/mm/memory.c
--

