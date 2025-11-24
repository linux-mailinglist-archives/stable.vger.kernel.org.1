Return-Path: <stable+bounces-196688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97671C809DD
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2D084E4BA9
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F131301473;
	Mon, 24 Nov 2025 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Yqz87Az1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92960285C8B
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989152; cv=none; b=FI2/1fv1GrBInveehs8Zx/2rra2arMd/w62l1DLgZtmXE6udBCWVGtEy8EPAYamv1nFYmRsvy04HnQC9MH3i8aKKpTjycU4vQb8Y+S3cBznzhnF9/nigBKwRkUMPKJWhoYlmttBtzFtbXLA9tGdiAT8TUIAbYYwgbxsyUvSaOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989152; c=relaxed/simple;
	bh=ZS+oc1EH2l66FaqOGhjgJX6MBnmHcCb61TSeWXPVjfU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gTqVOJHnWZyJ67pJmAW4w4YtH1DvIYI+J8cKcd2kHrwYddSTpF5+Y1N30qJrbLwZ1w2h6FX+csWUdH0UWU9/zKzp7k/ORoG1+DjPLeSGaxMBg124lHamV6+sVxCCkpgt9ob6CSlJgl21iKPg9iI6c5bhMmyLZPjZYqKTHYrO6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Yqz87Az1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b996c8db896so4627361a12.3
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 04:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1763989150; x=1764593950; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkT1VvD7QvpWCucq/0jTel+dWmYxPo5YKZhT+XsjcuI=;
        b=Yqz87Az1KLVxgX+ePvn54TmOPSbiZCDSL291crFqLP8lFNTM2mh8IWRwsTzqS+j1/m
         KwP+VOSX2PpPo3Da/e0IH8yLwySDALwbOrKI8uKFKTYwfhb/QUjfbKlFD5XY+ef/+nxC
         vh5w8zge15EGjENP8YLaXWBISw2IR6ySQ313eSsaHJmR44jcCBNVBngit4b/3rWihOyy
         vI/5Pex3oerr4lcIruuid1gdZUknCkcYLcbcVeWo5YeWUzRNxduXPi3BpLjNiYOC+Kbv
         J96ArPKw8GGqN2EnkAMqr++Z31yCvb0NJ23IdXxjsdcRs/Whoo5yGAMCZpdwnIkXVRxj
         YtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763989150; x=1764593950;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkT1VvD7QvpWCucq/0jTel+dWmYxPo5YKZhT+XsjcuI=;
        b=jR4pclSPiTRyYYdtPeaeda5pvSkXb3yGxNHtuTPHb/aNF6m29R+w7zUY5lLIBD1rzs
         YIrz5noLPCKCU/6O0aUR8x2Z07O90/qVtNzeuLJ4hSfZSHiLCTP3QJYPwcfKaCqXSKCz
         iLrV+KSr660m6tIvr6602U8jUuE6cMVJxTBaFfe0Da5IlRbOaygabXnFaI6RRSev4YYG
         MAPgmzPRzJbjU0kvMTUSzGsUpkBE7gsMVxbj/k4iEbDO4RUgW2ZlKl2XDHHdDrpg2vkR
         dPqQp4N60te/SzRSb28dqi+g+cx+M83GzCNtjV3OlmDr5CqiatoD8EfyKmBBGO5ZjwBX
         1kFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCAcxWyW62M+gMmoaMlNIXGtbboOXKSNNQXjv3IpWgLz0dD/kaEUhX4pp+3R8U9X0nYvTgX7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2TaHQWQ5BP3I90UWJ1QF9cDXT2/uX7Y032u6v/0clJO+MpOJ
	Wl59jsdRIpekb/uhTZ/eiC7gGdVg+IL2sIHQqVETXZIO2nYLLJ7GcWRljFkO71Cmpvk=
X-Gm-Gg: ASbGncvwstHo+7mzCoDus757zahWQ/KViSdaqvKr83yFrOMtXeQirUxrJjBOCizSkq7
	eNciN8wYUOF8wzYkgktFBHfltvyNYVNjDek+o7UZ166VNb3v8Ook0bOXBjy4bYrUhGosFozwwjD
	y8Q1/xAjkG/z86zD4q4uvRtJoLGFsOfksxPH1hKuYJhzsJwPIXek1x9Wup3uqb9wDO/tL0yIUpQ
	lXgdtZcPFCh9VsYE2tqBWILOXEX7XHSgocxn4D8sz7Bx9rpP3uEqvfowuSEwGvznWSOqC9QxsZo
	xM1nSy+MRRJU4Y9U4JnAKFKiFSjhmn48Stwsor9k8VFmHfo742/6alH33WZLTBGOP4IHQ53PPTu
	836f4K8LgK1RJUWz8egw7Sx1XuGmw6bqwRPFqOaTtnHD4c6mciT4wLcLvD+v2vNlY5g7Ay12KYx
	C5AzWiDZDtTjoy6N0=
X-Google-Smtp-Source: AGHT+IEDyKHq2yljVWDuHDrt2oXDhepA1O0Qoc597pw7+11wst+kEZ4D6ObFGVQqtnoFNZj+4+SxDw==
X-Received: by 2002:a05:7301:168e:b0:2a4:5154:b346 with SMTP id 5a478bee46e88-2a7192e071cmr7948075eec.35.1763989149723;
        Mon, 24 Nov 2025 04:59:09 -0800 (PST)
Received: from f771fd7c9232 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc38a66bsm51275168eec.1.2025.11.24.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 04:59:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) variable 'val' is
 uninitialized
 when passed as a const pointer arg...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 24 Nov 2025 12:59:08 -0000
Message-ID: <176398914850.89.13888454130518102455@f771fd7c9232>





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 variable 'val' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer] in drivers/staging/rtl8712/rtl8712_cmd.o (drivers/staging/rtl8712/rtl8712_cmd.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5b83acc62508c670164c5fceb3079a2d7d74e154
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  d5dc97879a97b328a89ec092271faa3db9f2bff3
- tags: v6.12.59


Log excerpt:
=====================================================
drivers/staging/rtl8712/rtl8712_cmd.c:148:28: error: variable 'val' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
  148 |                 memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
      |                                          ^~~
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm64-allmodconfig-6924331af5b8743b1f5e538f/.config
- dashboard: https://d.kernelci.org/build/maestro:6924331af5b8743b1f5e538f

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-69243317f5b8743b1f5e538c/.config
- dashboard: https://d.kernelci.org/build/maestro:69243317f5b8743b1f5e538c

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-69243353f5b8743b1f5e53bf/.config
- dashboard: https://d.kernelci.org/build/maestro:69243353f5b8743b1f5e53bf

## x86_64_defconfig+allmodconfig on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-allmodconfig-69243323f5b8743b1f5e5395/.config
- dashboard: https://d.kernelci.org/build/maestro:69243323f5b8743b1f5e5395


#kernelci issue maestro:5b83acc62508c670164c5fceb3079a2d7d74e154

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

