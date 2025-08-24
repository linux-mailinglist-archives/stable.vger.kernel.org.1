Return-Path: <stable+bounces-172713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F353B32EE3
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDCC3BE74A
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA8C26A0DD;
	Sun, 24 Aug 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZEDLwbro"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249026A08C
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756029548; cv=none; b=HCjhJjlYVoZT+6/VYm9mOJNTff0KFQSV2Z3f+h0D9hViZ8PE1BbPhKN0rsfaDn3F/Hib7jUDU8s4HRbc5OpIX4WutYShobgtTQMkmIHOoPbxDTkbqPS8SuYZpM3ofWsxc3iJnJsNx4vihZICyNXNj1YjaRLY75qRDq3evdCLo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756029548; c=relaxed/simple;
	bh=Htln4i7wIXDDEc/zFD685rTQK1Ktku3cBDF0VgN5J1g=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=SGhoSB/HXN+Kg7dnMl6CQTxGLmQ3xS86wL6hZdFGZsOC6IWVr0cnD5UG2ZHp9m/oD9wsLX8YImF3D5YwDDlF4ot7shfetI/1eqxGWC93UD1txFrgEy7ixAKfj5/ZCVhgbCK2JFluQcxb/yKUZAuq3oTFK47rBeznxXhLyspsL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ZEDLwbro; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77040e2e6e1so1492881b3a.1
        for <stable@vger.kernel.org>; Sun, 24 Aug 2025 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1756029545; x=1756634345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l694NHp6FtfwwljjE4+mBzqOhyFMbLNXvzsC5AdtcIc=;
        b=ZEDLwbrotAfQ4lHCVduQ8QQmVHoH8UdkRhPg2KSY0rqnCQr9X3aY/87S7mi5EoJSB1
         3FF3lQ44yLeojCbm/CIXi8ENoo66dIzMCdFvR5SZ2zt7QLBW/oIGBxe3xFSIUh3qRu4I
         Dgu8HGrPrkuDnXcNVrmn0bcOagDqgKrZvGbRvDJgUUpz3QdjAlbfJSb5O9u/mzsx/CHu
         UkfS93USDZ3KmZJpUNK2cf8NK6sw8agXGXvNSjXhYqSGuzUTjBrtZ1EBIFcpQ0zDCbGR
         5ImIK9KbdpV59rre6QWqpxZoQbHtooYkHXQjCGmAcDijhwtdiYpClAcGRh+FDsvheqtx
         vlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756029545; x=1756634345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l694NHp6FtfwwljjE4+mBzqOhyFMbLNXvzsC5AdtcIc=;
        b=A6YuHwEhdW9FRR8tMujCCxRT0d8PZaprHgCnd8O+DCr5jDo6PSj/0OTi28gk2Vuqny
         poJegE6cQpZrqWAAqfh2Bwuv/ctcTTjeEe5JySV9pYOALA0YQovGG4ThjEIevsCn299J
         FFP6Fws1JxuE3HCPexBigVPkL0KTns+MkJqrWNBvLge6V5a+dDzx6rPVV7dv5pBuzpO2
         6HyQf0uhtTxBMU0rcMFGGjE7ZxMiYsy1t9e9/WkirvLlfRrT03dqz55QgUHocFVjA+Ab
         mcwuqRv8Bdprs19E929XSiziLOkdib/kzaWXypjrrLr7COX5a3arTd+9sWkoKs1k7VKY
         yIUw==
X-Forwarded-Encrypted: i=1; AJvYcCXOrmbdUXuKUHQqqkc4mNmpfeDoazKUQf+1doNT01Kq2Kv+Yce8vO0jedQuT/Sy0hzd13Pa82A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0eJKlGJYOuhpnxr2oP8thKa4NGknxxBm0KnWKqem21jg4ey66
	vy/Nwa8iWxOA0Xb4jgxxLNrXgk9eLdkvoBSfwIDYSTOjFFoXnzheXy9Ge0ucI0QV4vM=
X-Gm-Gg: ASbGnctQKohjUbbCiUDB1iOmPvGksH76KBtz1kyO81S/SN+vGkLUNe8Ychc8b0wFM4p
	6qgy6BpHWzikL0eg8JucXx5tsBExa5ac3OV/yVpRFQwRxQMu+n13eV4kCDGiCkrX5ld2eR+3/H1
	IDv2ry6O9ZOxj6ZDHs4henWKnOzyeOr01jWMoFsUfvvwUHRENPC6E+gGULJ2FxKCpI1udlAkDif
	YHfLPdDXG/OgjeJH5hy+2jBSW3EmsGVawjlv4meMk6RuwG9URNJIT7hl7ipJXnmp0uNab8uTuph
	ToIP/2iM2KSsT7FGBg+9DSkbqxUKAzZ+1lWJND4n/ku5urHsuamnBWNL+bucDJq5t208JQiyezR
	pi/cno9Sth1JNGCPcY/ZQqymWc3w=
X-Google-Smtp-Source: AGHT+IE3X8uvDVOQKEvqUKytkP+pDN5zq2+IZMh9Pzq32ztK3uifSu6nZ5SUuwi+GVZFZKAB+zYu0g==
X-Received: by 2002:a05:6a20:734a:b0:243:15b9:7659 with SMTP id adf61e73a8af0-24340d2b8f5mr12065786637.51.1756029545370;
        Sun, 24 Aug 2025 02:59:05 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb88fab9sm4047716a12.4.2025.08.24.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjEwLnk6IChidWlsZCkg4oCY?=
 =?utf-8?b?c3RydWN0IHBsYXRmb3JtX2RyaXZlcuKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIA==?=
 =?utf-8?b?4oCYcmVtb3ZlX25ld+KAmTsgZGlkIHlvdS4uLg==?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 24 Aug 2025 09:59:04 -0000
Message-ID: <175602954397.567.6885813720011678446@16ad3c994827>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 ‘struct platform_driver’ has no member named ‘remove_new’; did you mean ‘remove’? in drivers/usb/musb/omap2430.o (drivers/usb/musb/omap2430.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:67bf95f2502a816345830c2bfb96f4a8950ce208
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  10b6e479487675365bd106d20fb7dbeec6fb4f60



Log excerpt:
=====================================================
drivers/usb/musb/omap2430.c:514:10: error: ‘struct platform_driver’ has no member named ‘remove_new’; did you mean ‘remove’?
  514 |         .remove_new     = omap2430_remove,
      |          ^~~~~~~~~~
      |          remove
drivers/usb/musb/omap2430.c:514:27: error: initialization of ‘int (*)(struct platform_device *)’ from incompatible pointer type ‘void (*)(struct platform_device *)’ [-Werror=incompatible-pointer-types]
  514 |         .remove_new     = omap2430_remove,
      |                           ^~~~~~~~~~~~~~~
drivers/usb/musb/omap2430.c:514:27: note: (near initialization for ‘omap2430_driver.remove’)
cc1: some warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68aadff1233e484a3fad599c


#kernelci issue maestro:67bf95f2502a816345830c2bfb96f4a8950ce208

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

