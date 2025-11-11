Return-Path: <stable+bounces-194429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFDC4B61E
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 04:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C78B4F1BFC
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450E431354A;
	Tue, 11 Nov 2025 03:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uwc6dYkp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8431280E
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833550; cv=none; b=gaoqJ8f8JYf8jz8OVwA+tO5Ed8i4+ZQQ/7sGO1JuNlPZt9B4cYbLJYADOHLDtO1RE+nxYp4huPH52pNTXBdfSVij0HCYdaZspSW63TZyvzc29IEZKTCTZT/8dF6cHD//rT21bvY879yXXTkomlGRN1cHchwGEjM7CMGY6Uk7IWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833550; c=relaxed/simple;
	bh=+UF0U9ktVBob3A/lcfxhzsJESRA/QtoDYtlBSNJ4Tyo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Z4IcobF55qZqRiFwUfBxbneXEijaYfE05Mk13BaKVbawMlN3JMlXKhkLSaoihQ4fpRH/gfhdBi9Iz0IlFH8nU7uKE/r3XewLTLkOCWq8oGPvLHV1Uppvpp8EXi7LYPQXWHA4/mWmvg4RYMzYR9J4A+bYkcfUCwGeJT6Y+hMnXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=uwc6dYkp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297f35be2ffso30537065ad.2
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 19:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1762833546; x=1763438346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zaki1dJRjP74wUpIytuVOLgp00ZkGBIrjulzCXlFmaI=;
        b=uwc6dYkpLCJ3VVBa58gsnp584KBYivs18aWCAMTQR6Bl6soM/Gmoyyyy13PlFcB/Vb
         Y0TUsOvS38fhHTbgID4W0PxeuH5psxInu0TViJc4FkhNXuvyP/1qGoHBmILQ5IV16f/g
         C2UHJNOl2z/4zYp7ySpkOEjRcjhNYs+x83medJzZOJt12fExCHSxclLGOBPBKUi/Ffs+
         I0dAANmgBWNTgeCXmi+PjiBBYSYb4TcvMr2Yo57lDtF8VqwaIanzCf/8N6mrsdECEk4V
         siiCDDtrPq/AeLz6wLKvNUGgJGGFfrOQ1gI4Fa52yIpizHzbtWKm6iJKOcMcXoeKa0Te
         1OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833546; x=1763438346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zaki1dJRjP74wUpIytuVOLgp00ZkGBIrjulzCXlFmaI=;
        b=FqnDIWisjuT3NBB+bjIOMZ6NFqrzmcuxPl88zcsP/+Axt9J/8K/1pCcPFDXjpQv0EK
         3IYfVFvSR7+4lxINazE+3Ujpt2hRLTw89TeT92HLx+VCrfPe7IodLTDFiikHKCGpCP2Y
         IFceT2VhMwexjM28TnObVBHjLJ7h0hIhsdaHEZGLcIy6Bjd6IYXvTNhEsSz8tDngHe+A
         LuUPKsUK+S5EjI9cZyu6OGPXXNZ6rcUlSzjgwDnJ5gf15yLHqgVV4GN5ZtJC+tq7teoE
         3RSkz+a/IhsbqxIgfo/kn8QIJbf49UXkMh5zzIXKAPpTZtoMBSmaTAdaEnGS45twnEgV
         EoaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8hCw6hJ87F4L2vEix3YCOy/GVCYq7kHaA0D5oDA4KX5Tvu5VaVIUWIompALlY/g/x5Ozt2y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzByXiGcSy2O0MJb5M2mSVEMzc1+TPZLT7CZ9i9h5yr9zBXhbrM
	tHY0oAxw6GFqVdfkv6uuWWeJLwQ2dWs7H2YU/tSOeqxMzIf0kylTrLGJKyM2Fotj4tHPPpMQFbK
	QyrkP
X-Gm-Gg: ASbGncvqCot4tt04MFKkSl/zX+9OUFiNH41R+dKpQK+7yqz4VPbHhm2r7zu/OKKDIDq
	EWqocKfSkKDS08KHpslmR8zLIvcJH5MPRG8mwV8JODBflG/9v6lTBgs1F++wA/vErzxBVGgrI5m
	ylBv1wBQJ3zk8E82+VQ+2T566rgm2LlimN0ZakQPlLjJXByXrCQK/u4ZWS51XOwlTe5/+H6hkOI
	44Hv/vUN6Ih9i4xZLtjBJ2a+L7PRK10V6HaDgw8lF56Nk0QvfLQkHNAhDh6/Gmwk0BLFYoIvbZg
	3zaj5ieIbmYb3sEVT3NKxHqpdTdwjPuGhHHpcdhDIOi9g1ppi0FgcslFPvkwXELNksQhrDOzwgn
	+fymD3goe6NPZSLxl2iwX9Qipp+/TVzte7o/9GpwPYMPvn2VVpxwNuffukPUEdG9OaWnkb9jMTL
	Fx+VY5
X-Google-Smtp-Source: AGHT+IE9dckM/lpvYIEDg0p2eRqp9MywsmXo0hss80hXMoZRXKWDhJP/+h2caPDJG3Rin8ijJUrKhg==
X-Received: by 2002:a17:903:244a:b0:295:6511:c0a0 with SMTP id d9443c01a7336-297e56b8511mr133329605ad.33.1762833546280;
        Mon, 10 Nov 2025 19:59:06 -0800 (PST)
Received: from efdf33580483 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d83c941esm109187725ad.44.2025.11.10.19.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 19:59:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) incompatible integer to
 pointer
 conversion passing 'u32' (aka 'uns...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 11 Nov 2025 03:59:05 -0000
Message-ID: <176283354519.6732.6112901271453838446@efdf33580483>





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 incompatible integer to pointer conversion passing 'u32' (aka 'unsigned int') to parameter of type 'unsigned long *' [-Wint-conversion] in drivers/net/phy/phy_device.o (drivers/net/phy/phy_device.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:ca6f6d9806fc2b70ae08b439179af266398dd55e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  44c21f603a9a2b315280fc66ec569fb726e51fac



Log excerpt:
=====================================================
drivers/net/phy/phy_device.c:3061:16: error: incompatible integer to pointer conversion passing 'u32' (aka 'unsigned int') to parameter of type 'unsigned long *' [-Wint-conversion]
 3061 |         linkmode_fill(phydev->eee_broken_modes);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/linkmode.h:13:49: note: passing argument to parameter 'dst' here
   13 | static inline void linkmode_fill(unsigned long *dst)
      |                                                 ^
  CC      drivers/gpu/drm/i915/gt/intel_gtt.o
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-arm-allmodconfig-6912921d2fd2377ea9956acc/.config
- dashboard: https://d.kernelci.org/build/maestro:6912921d2fd2377ea9956acc

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-i386-allmodconfig-6912926a2fd2377ea9956bce/.config
- dashboard: https://d.kernelci.org/build/maestro:6912926a2fd2377ea9956bce

## multi_v7_defconfig on (arm):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-arm-691292192fd2377ea9956ac9/.config
- dashboard: https://d.kernelci.org/build/maestro:691292192fd2377ea9956ac9

## x86_64_defconfig on (x86_64):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-x86-691292272fd2377ea9956ad4/.config
- dashboard: https://d.kernelci.org/build/maestro:691292272fd2377ea9956ad4


#kernelci issue maestro:ca6f6d9806fc2b70ae08b439179af266398dd55e

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

