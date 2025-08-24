Return-Path: <stable+bounces-172714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AACEB32EE2
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 11:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5161F2042D8
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8426A09F;
	Sun, 24 Aug 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XLZtOUS6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA72641E3
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756029549; cv=none; b=bNYlNbHuRg91vg6SYXdMvOq6+swqtY6sZcdcPi5SV+VOGdHmQAcIiaZ54dd+yoGx3iObP9dMfQvf0B9AnFran9ti8KnBKHEHZgnYAq6FXGv5k3BbOBDf0wwjrA3uRKzOk5nE+3g4wsjiGgHGs9j3YX6054K8k6Bok7WHVGQo2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756029549; c=relaxed/simple;
	bh=Sjo67XT8idV4JA/abux+zmOJxPxWKuysEl91qxvZE8Q=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=XlUH1/vC7+UZx0GDH0lzG/J1aRKQ0gLGuqu1MeF3lOTvO5yEODAFBxXCxWoDcLC/vRvHM69bHg68TFgA1yWl7qZnU2bVb7R3RFzAO4cddMkAID89C/+IHLoI5zqHjQ+eCTRoXK7CFaB2ROPa05FSUeqwE6FClVHyY9VMk8zRIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=XLZtOUS6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-245fd2b63f8so32366095ad.3
        for <stable@vger.kernel.org>; Sun, 24 Aug 2025 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1756029547; x=1756634347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92fRArJQpJho3SWGfHpXJkPqcN21S3VSUzJ+R5CIVwg=;
        b=XLZtOUS6roOdxo/wBB4oqfKS2GWo6bNBHlmJarNzt9QpvL/yyX9eCTiOg/T8wB7fEb
         krknYJOZGJRrC6Zr+V/HgLauJZy7C+9Pp36rX93TH8O82uLAOe0PveQuBDWUJeU0C59w
         zJtpY2JwleRsjshoeFeZeA+VrlmaN34Xr6LuZwy7ZyAOQ/i2nWTlZkf7l9y6HJbIi+UA
         zvrC2RJkm9mdkoBjrUV+UMUaCc3ky8EKNRf1jJPnqwQCKxgMI9p2+j2+g9A9pz8cdmOX
         +b6FUyh1+AlV4pZjVIv4W7Mw3BYH6XhqC4HyanHCyJpvAeiP5Bb/gN5GD5z1MvICIvkK
         2QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756029547; x=1756634347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=92fRArJQpJho3SWGfHpXJkPqcN21S3VSUzJ+R5CIVwg=;
        b=MRWLmtKaB2tp8a2j5ugUBkB5Yjb8pzALwu5Gr4bPrBUzDsp/lYrtaby/rfovo9JPtM
         jyvQzLROfiE39nuLSn4CfejFmuSo6bQUenrIgKu5IgT5tbDe+rOolwgnFgY0qIH8IZMH
         fcbWzmXXaY70F26d/6mpeSrqT5IxzS7hdx/34JAB9QmLSl3qLcmHTLHlWUCCLLJAJwuY
         933MzOYYDtumHKbzRr1WO49LZLqw73RetBxwxtmZ0ZyZFA5XEyzSHx6v0zvY3MZ9sqfQ
         eAzAzc4bRjDR3i8DQBBweawdFFr1P2oDzGX2gLxyZeC57Z+HgrQNTr0e5vZAg7fA8EVn
         eseg==
X-Forwarded-Encrypted: i=1; AJvYcCUleUcY0tGje9r6tmEqKiubRge1uPnIiBTxGsab/SWE7MJXneQ/zrCz/kYpBB+e/mpgKx9OU60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUrTtquATTnYXMIsbH2Nae9jabTRWbv2alupTsJo2D1tBQW+Y
	0iVJd6DRlhCfDSk9tru8h+37RGK6o72kZghknVgWRWrnWQt48Ac/putJdaGozTZJdaqiw29aCiD
	qIz7X
X-Gm-Gg: ASbGncvHeu+pak/dvmOVpAqfIV1+f+mBaTksTMbtt0x2q/Zu/JEh5RLf03Otw71eTJM
	apAR/sVq9Vffy44+9NQzddsFZeECQiulAHctV0hiDpwubBVKTW03cRZmr9tXIHyzCmVQmiPrsU9
	zHbRRLN52+4MrH9Ki3nNUb2Iud19JFlk8Rot3IV1ntkQ5JLQbaV1kGWxqfAh05eph1P3R67HyeR
	DtD9uAoEx6bWSjX/v0YGfpqQPaeKfhqp2+3BeRvkNJeDH1ZS3MSomUFgSDbGKYXQyE+BIjQR8Jz
	9bqDFmQdsEpq04s2RZ7aMXSnCYUEuSPZq6wbyzKAw5zaJifnnKNq6swS3b2rrt0MuNzVtGqyZax
	v2qDnlBVN+Y/qWRLD
X-Google-Smtp-Source: AGHT+IHUjmuJ/JyAF60LvnsZE3d8LhGx8qcPHGa/lNnEhNJOEJJ0uwp2kfIekgTR6uDTkdmuso+w+w==
X-Received: by 2002:a17:902:d488:b0:246:a4ec:c3a5 with SMTP id d9443c01a7336-246a4ecc618mr29275735ad.25.1756029546929;
        Sun, 24 Aug 2025 02:59:06 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889de90sm40117405ad.156.2025.08.24.02.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjQueTogKGJ1aWxkKSDigJhz?=
 =?utf-8?b?dHJ1Y3QgcGxhdGZvcm1fZHJpdmVy4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCY?=
 =?utf-8?b?cmVtb3ZlX25ld+KAmTsgZGlkIHlvdS4uLg==?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 24 Aug 2025 09:59:06 -0000
Message-ID: <175602954568.567.14966095635313758088@16ad3c994827>





Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 ‘struct platform_driver’ has no member named ‘remove_new’; did you mean ‘remove’? in drivers/usb/musb/omap2430.o (drivers/usb/musb/omap2430.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:543018f88c601ef4b92585dc650f6478f6dbf5b1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  6aaf3ebf041044bb47bc81d4166cc33c00ed75f5



Log excerpt:
=====================================================
drivers/usb/musb/omap2430.c:584:10: error: ‘struct platform_driver’ has no member named ‘remove_new’; did you mean ‘remove’?
  584 |         .remove_new     = omap2430_remove,
      |          ^~~~~~~~~~
      |          remove
drivers/usb/musb/omap2430.c:584:27: error: initialization of ‘int (*)(struct platform_device *)’ from incompatible pointer type ‘void (*)(struct platform_device *)’ [-Werror=incompatible-pointer-types]
  584 |         .remove_new     = omap2430_remove,
      |                           ^~~~~~~~~~~~~~~
drivers/usb/musb/omap2430.c:584:27: note: (near initialization for ‘omap2430_driver.remove’)
cc1: some warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68aadf80233e484a3fad5928


#kernelci issue maestro:543018f88c601ef4b92585dc650f6478f6dbf5b1

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

