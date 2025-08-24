Return-Path: <stable+bounces-172716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A3B32F26
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 12:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909F51662D0
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 10:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1E274B22;
	Sun, 24 Aug 2025 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UHf28JYd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB682609FC
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756033149; cv=none; b=Y0XZ/8TpkHW5gPu5yhyxs3k2APJ3asq8COUo0MUqYiH8zBsNUcBAInmjHWxVhDUbg483CHP5jWTSwy4bzLj+ineSksQFrITDVi/f60W1GD3YXFYRXhqvhKEdTG68Rk9nAAP84vQkfAzYVJSpeS6MgcE9Ik2YdPrfYhZdRZ7Atq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756033149; c=relaxed/simple;
	bh=V/ks0y36nQyBGq9fKjWNVwUmEqHLVUqosPv3r+DpJ2Y=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=YCszhTWWyYjY0HlKVUmxVSOmPcuWDTec8lKa359A2SIN0vV5L8SxEt3E7X74nXs+vDsDLgDT8kYADgkLYGTMxmKH0O8Er+Ag3dR8L5ik9nbX0sohEUMqkZwYxofl4x/t//UPv4CQ6X8W/sVfwIMy0YcHboAOjfpLOtKYObYpB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UHf28JYd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7702fc617e9so1618489b3a.1
        for <stable@vger.kernel.org>; Sun, 24 Aug 2025 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1756033147; x=1756637947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYIGgpghCKirYQeLBiS3LwpwDwYywmxYDm9Ru5uIfNk=;
        b=UHf28JYdCS6V9VPZ/HxJnTC9AryHZJxEfnKLUI0CV5WXzXrV8amUMx+u2guGw6yJGR
         /syIs3unpVkFck8JuaRiIpzqiWp4LsqCoo68Ipimw8ybr40X0B19+2/sg5D2A6VB+gQm
         5/tM98HPhN2JjoqHHfBHrEZqv2uYd5NMhQIIIqMleUECtHcTIpJs7UPAmLgKczvLbbp5
         YipXD/BlBL1+vaARghikU23x24mRjY7nTVBiAFc+hbvXPzGH+hBzDck0MYjNjwHxPyQg
         L7TW27iZLuh6GObq1/VBChnBxqW9CNgpnlGEkiAegBvbMuj7iyP1bKG6oRTMs6yfvk2Q
         +YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756033147; x=1756637947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oYIGgpghCKirYQeLBiS3LwpwDwYywmxYDm9Ru5uIfNk=;
        b=vlXPEDwW9hY7Q2KYEMMnVDmxMeckTubGeAmNH2rwWRCqW4i9YoJNJkZJg1RHSm7yLZ
         hNMQKYBjR+yaHhn2yLbs8xjrLEOVV2zLZL1fIIujcnC4rLZL6MEPwSIPy7gBBlLS3K+6
         XD+rnsH8atvul2wLSV+kj4vlPWnlFkE0R4WUwi+9VRTP5bwiJ2DHiWnbuf+P+T/G79Jt
         4PeG2r3s5kF+6DiM7BtOXZTQnSEHiETtYlfLhGFlKbVh5MIISo5DvuBDWDS813/u2PPq
         eFqTarUquCoWbLbcv6LDnv/f2zxXcJcgZgbgBgBfs9scRzW5FlouxN0u4ngk0vLlrW4Y
         F7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtsBw2RlQ9Rmeo4vUM5Yd3Hd1ZL/ipv1BeBpbVHd5y/rKIuMMeVyihpLus9MtZfTZudwMJzqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzanHGaxsR0YQJwJbBawlWBkjON1sWG61LgEC3Z5ckkA4dhsRHo
	DhvEO4FFLkg8xc0sba0IsVxxgy1N0i4Fi5qhdxNl9w0jcRwEf5yGUHbuwOQ9O1Y9zOVA2fFx5Bd
	EP+YI
X-Gm-Gg: ASbGncsot55IiuJCKJlzr69HHbUh+4sEpW2+s50gGO8urdESJya7djmkm2KywIBD1By
	yA9y7sQAA6unDSgqGHarSAmNkNQA2CSfgEZumMuNoQQBvC04/KeGbKcEehvaKBv6eS7gdPjuiDS
	/5oZVRW/ZM/oQHiVefz+K/HI5IxRJuKsxHNTSij8nnbKIRZhhQ+Ct2yO0EURUpOGqaMHppSgRn1
	HWQ96yKdtg3j0bxLpY+4wnJFVDFsHGy9gtB/Lr22edBOtau9JKmnCDq2v/bM8sLbReDuhkZXMl4
	tjeENSG9IAY/nVvGhBpq2dmo5I26qobWmzS00iafRxY/pXSZFrlJ1On+vLk1CEdIlpn1yBw8Dle
	QJia2ocMxrhcyM5oB
X-Google-Smtp-Source: AGHT+IF6bjV7SL0pciZpMwWhqBpmcQ9x0Cggi7KokVI6gcgz+igP+zd6cpUo8nTF3fhnLtQSrkLWdw==
X-Received: by 2002:a05:6a20:b107:b0:240:5f9:6359 with SMTP id adf61e73a8af0-24340d02456mr9058540637.34.1756033147167;
        Sun, 24 Aug 2025 03:59:07 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8b05b8sm4069689a12.23.2025.08.24.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 03:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) field designator
 'remove_new' does
 not refer to any field in type ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 24 Aug 2025 10:59:06 -0000
Message-ID: <175603314579.574.1531089528864911974@16ad3c994827>





Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 field designator 'remove_new' does not refer to any field in type 'struct platform_driver' in drivers/usb/musb/omap2430.o (drivers/usb/musb/omap2430.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:1292a5a18d3398e6fbc86c391b6dd3bc3bf00f16
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  6aaf3ebf041044bb47bc81d4166cc33c00ed75f5



Log excerpt:
=====================================================
drivers/usb/musb/omap2430.c:584:3: error: field designator 'remove_new' does not refer to any field in type 'struct platform_driver'
  584 |         .remove_new     = omap2430_remove,
      |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68aadf6e233e484a3fad5913

## multi_v7_defconfig on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68aadf6c233e484a3fad5910


#kernelci issue maestro:1292a5a18d3398e6fbc86c391b6dd3bc3bf00f16

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

