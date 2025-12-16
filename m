Return-Path: <stable+bounces-201955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A029FCC29D5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD7BC3006D9F
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7334167B;
	Tue, 16 Dec 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2BK0eDa6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964782D2483
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886348; cv=none; b=qevFPdTlAN2Rxj3tzvzezGhbU7x8WKh3FDDhrun1e5Z+FJIrrSSVhKn/tyBNfZOqXczyZAJLTy+lMxXVXX5acqu6bD5ExZIxMNgyDmpW6RdY0kkYbWIbWCds8UMzXH1M3t4Yeu9MWUvZmMHtm3XZMu7aVQVvCw/gPFeEs6CDJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886348; c=relaxed/simple;
	bh=iG3dxdozNK1FpE/bpCmiQNBQfzk5BJefAHiY384MqWI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=YnO/iN8PCufQjtWbRYf/PckNrcEIg3lebSQTpMB2DhFlLRNOr1lDZSJGRf/EX6OJtgU+lUFfyIm87AIOmrKpNeIwNjmlcrJ8tAFjQSMm+KCwKRXCgy6MW4o325M51VT+POpuvBcJy265nqakYS6ZJHFqAkU6b3+ptmyfHrNheRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=2BK0eDa6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c868b197eso2306361a91.2
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 03:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1765886346; x=1766491146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/shaBReMS7AhiqEpadYEfBReTeQrp/PN/TftuSF/aA=;
        b=2BK0eDa6JipJSwgUVR/FcBXkO5Cf63V9zUfl+4xygfEwsxoKQtJcgtESjKDds+lDRQ
         r8UVwLOEsq0m0Nl34HT8etPNsIgcW+oAKTzbBHNSAjaxTiwyM6eSh9eAqMRNOEB2Px9d
         lzjqkjvTyOXbL4JqVb/ecWch/NN8NqqATvaxnuDfYHOkJxiF/BfWkDrGhyt0EVTYsrhH
         3hlDIu1BsxnEKS7yG+hgOJ829wKjZeJe2mfTu9SmaRzorBOEkRCr8SaE+pmsx2L/thmr
         X5f0Rnov6mYkYhmRB/rMVjyjmt6DlmCkckWHGskYJRNxCIJRW4AcaYjexC3M7xrvq20a
         vT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886346; x=1766491146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/shaBReMS7AhiqEpadYEfBReTeQrp/PN/TftuSF/aA=;
        b=Igb7GlR6itGkjwlCHxpLoK7qikksQBdQrMqiR23piYn3qlxo1j6vXCyk5LsngfMkdG
         5FsGlAzs9YEoqorv4G7g05Yx8yvWeo5D8VpU1AVknlTRqRob+j9EO4FS8S0/5UM7nyUk
         6odlzB/DQfqj1GykMkTX1iJRFfEAsHn8kzjMSha9WZbqa92OoxNlMBjSBBDoM20AJ92m
         OF65fFxh7uW3b9vT8IWG+ybMXVzUcrRi5NDpffmMHtsvZ7SA/QA3m0h2zRNIkd5JPDlU
         EK25lE28MBrCkAEXZdYVj1HKhoXHNAzOS7UXhyHcwicVZk2bJ7WIYxNfISPJaB2tUAuv
         H6qw==
X-Forwarded-Encrypted: i=1; AJvYcCWnWCk0YdeDKxIiCIRbnsm3uOexgglT/v9YSEPaY/jfJY7/ssp2/boJIbFtZ0SnGeaXYfBPhyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77cxGKu2uI21wM4ZSRPc4A8oSwQq6HL7k9/f4ulzKOteuVaZS
	0BuVp11+mIFgBN6f0Zd/c8adPofrRPyXo1yacI5fegwjTTmEODUV6dukKcOOEp+kLac=
X-Gm-Gg: AY/fxX75k9tnlP1Wl5WE37pKhVr4j9cXUUcI2LoaCdUL4LxX+ntB6jwHkoBu75OrPJc
	tb0SdaZJRhrdi2HNtWT1/MHgB23I4x2kqjq6EcDClcNztcrAXgn+gbE1HEZ343i1gsrF3sb+E/S
	WAr41P3sM1twSDKohkMea7DYTaWRbH/FW7kHIgAQSGajGzNtaufoPMtgMjCVuUkQfzQiVacocRC
	UXyjg4ujW/IqDudj0wf3GPAIEOzAZH0OC57lzNKUM3Nm1AHKswFtvsiaN/1OwdpRGuRTA7LIHpq
	EyqYi21Ig7xNVv6ReO7VxyC5nvxDnjPYiJ4n/E+4La6QG7I95eJfoTobH1YfQaGaZebmoy91IyK
	8rzKaf1JbO8JQXd2Hc2DOZ5SNi0oWkxLdLhIPv0ObxI4Hg6szJVF+qh18u4aVJEnEKMj9brA9j1
	bcVkXR
X-Google-Smtp-Source: AGHT+IHC9DnZcQawmQfqQKhQFYXfKrOmo8kLGXpUQCHa9OHxfJ1HGxDENrXD+qnspTJgPHamaVXH/Q==
X-Received: by 2002:a05:7022:f316:b0:11b:9386:a37e with SMTP id a92af1059eb24-11f34c49e5emr9890652c88.45.1765886345615;
        Tue, 16 Dec 2025 03:59:05 -0800 (PST)
Received: from 77bfb67944a2 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f461a0ad4sm12384295c88.14.2025.12.16.03.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:59:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) in vmlinux
 (Makefile:1228)
 [logspec:kbuild,kbuild.other]
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 16 Dec 2025 11:59:04 -0000
Message-ID: <176588634445.2781.4924651812680498301@77bfb67944a2>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 in vmlinux (Makefile:1228) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:4a7e49227ad67aca6aecc527660a789651350429
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  d63899c4b641db97b203729e38c17d606f60404b


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
.lds
FAILED unresolved symbol filp_close

=====================================================


# Builds where the incident occurred:

## cros://chromeos-5.10/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-chromeos-amd-69413abbcbfd84c3cdbb92a1/.config
- dashboard: https://d.kernelci.org/build/maestro:69413abbcbfd84c3cdbb92a1

## cros://chromeos-5.10/x86_64/chromeos-intel-pineview.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-chromeos-intel-69413abecbfd84c3cdbb92a4/.config
- dashboard: https://d.kernelci.org/build/maestro:69413abecbfd84c3cdbb92a4


#kernelci issue maestro:4a7e49227ad67aca6aecc527660a789651350429

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

