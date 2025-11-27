Return-Path: <stable+bounces-197511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969FC8F6B9
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE833AD355
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAD63375D1;
	Thu, 27 Nov 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZRMR2azm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B74337B9C
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259149; cv=none; b=oMTOTHo2UR9EOEUnRFP4iuIW3i2yaIrnvxVlWxoWyBYbs0D8pmoN37ye/1roCICEY5jZxtI8qZtEkFdOA8kzpeXeBo/GvYrg7HvHXZ1kqUSOdF05iJWz3vhnhi26AX9Cj51+0VDdQuP1po+F0w6nGXynReJDHl8UMAFgVRSfROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259149; c=relaxed/simple;
	bh=/Ri59t52ilmZBe8IgNnyQgriYpVmJsjor578OwV8HR0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=YPK79OKRIbhf5BRHw3jysYQ5v2sFOZClj/l6QJOVe9SRsj/5HggYtugkoiBkN6CIcNvYCBK+oI4jfKGEXcYdQbYm5iGckDiEVupzK7tr8/cVQAqqAbiNqEwFnNvGBz4UJYYbbuOMoPKvF/Yy1OUP/EYVsakgUgCQAbd9c3rDRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ZRMR2azm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b98983bae8eso839681a12.0
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 07:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764259148; x=1764863948; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcpoHVst4w2i/aKZTl7adhtfdNZreXBo1+WxD2yE1aI=;
        b=ZRMR2azmSqXPzx3enTWkjrdnLeDpOcc82McuqCtLbwWwM2j0ClrGl+BYhQCfwmuuSu
         6CZRCKEjN0zKjLd8zm8Gc6k2J/yMSSUA1pmd7dKWrTzzopwwtvA3Se9f6jnyJxfeJUXN
         O4ExjIOzQTxD8BZ/NHpNe03nqnt2KOWGWgEOvv2EM8Fl2A8gRuzJ81W73UmbE0mCBipE
         0mGpOi8oGzuvnrEB4haU5UY7fBVFHjmqlz4cG7CbGi4Q674dxvg4pTqeD3bClhfZ7SBr
         mXVDwy4ZRrIcNFhis404mVpfjStIbsEseuGdRSOW1zPdy00y2cI6C/YAlI/DRehpi235
         JzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259148; x=1764863948;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcpoHVst4w2i/aKZTl7adhtfdNZreXBo1+WxD2yE1aI=;
        b=NoImHCW1CBxnVnrn6+aZmQ/EBahVlVLp2FKrYH+GwTbMX0YGuqR7bghDV88yxf09O3
         gswodVDeY52R8mvjllAxTMDbBHdF50GfSB9uLfvo7V/BMb7KMo/vBPiiw34WkMzXMYcL
         cgBviO+JxVZntfgLn5++BDRWhaRqSOYXYaJWlTHZXkl6dSQxPnOMCBnYxKM/b2worRRH
         nG6s3UEo+lFfIlALAFkmFmw4IfqlsaKDVA4AkW/bnr1ZDekaGDxI1BuJIfIjkMf6kV1K
         YXB4RLKeqKaxnGIWqAnRiBrK70Ax8Z6u441pMVJKfQ6Q93EJ2ucWbdXJ9nWtDZ2AegFa
         I7TA==
X-Forwarded-Encrypted: i=1; AJvYcCUA2+Sbggpna/T0r0lYxQAl6Dct/AlRLlrljwSnKPfVn4phM8lysmrtXbncrv77Yg0E5WWrYlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9d0hE5viw6ZXGRh1Tr7oC3wGeWnAV7Ck1R1FQTvTSS2P8RchW
	KzdzKy6eSzl0wYw7sJY5LFw71L+isK7qknwK/31WfFMxOmkB8K//kRl6Ion9Dq2AdZs=
X-Gm-Gg: ASbGncvX3I7zDtu9wxe397KOnAK2uarSVWkwCtIkA6UU4/Rr88arKEfd0a/upUSpDWs
	WZwU/ZUo/MdQOBUQKabN5R4ecfybU9yLqj7AN6vOBH9GYazGD/kr9/xa+wvQ+GyY0XKhpBxcIPD
	BAt+LaOvCs59U/e5+leqE2jgks4S14EDNlraawEWPbvY02PbExED34+XluhzboDBb+YFuHw7jqq
	I2S3Qj9jrXHAFO3/Pppq65Vo+Zo9ipKmouzxzA6CbFiJSZ/jWuvlmy6irYZAUJiuzxdCzAKqOL8
	iZag0hpKme9Y5G+XR6zb+UtXB3JWzccB4ZeZk8K3t41CkcH6fjncyEgl0d7xfN+rCvZLJ1D3JL/
	QuX6dV55W9sL8bGJxQScLfHG2V7DPeHLZ5wgua7LTSh63MCaXVwfID1IZg+O/F+nnqyjOWes5br
	05qYFJ
X-Google-Smtp-Source: AGHT+IEeXSMM4qcZQyMeY34oUpcYk9ZHnm3wZMvSvIXsj2wa4Uu4k0MkdKuBjXU9QuO8XI4M6d8Fkw==
X-Received: by 2002:a05:7300:dc15:b0:2a4:3592:cf81 with SMTP id 5a478bee46e88-2a9418c3d2fmr6776598eec.37.1764259147488;
        Thu, 27 Nov 2025 07:59:07 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9655ceb04sm6896932eec.1.2025.11.27.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:59:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) GCC does not allow
 variable
 declarations in for loop initializers ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 27 Nov 2025 15:59:06 -0000
Message-ID: <176425914649.933.8738107773277797835@1ece3ece63ba>





Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 GCC does not allow variable declarations in for loop initializers before C99 [-Wgcc-compat] in mm/mempool.o (mm/mempool.c) [logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:d414057925e4dea9704ce677eef188319c8610a4
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  b11ac6e8f913ac67f9424a5cdd4158b283c0e3cb


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
mm/mempool.c:69:8: warning: GCC does not allow variable declarations in for loop initializers before C99 [-Wgcc-compat]
   69 |                 for (int i = 0; i < (1 << order); i++) {
      |                      ^
  CC      arch/arm/mach-imx/mach-vpr200.o
mm/mempool.c:71:17: error: implicit declaration of function 'kmap_local_page' [-Werror,-Wimplicit-function-declaration]
   71 |                         void *addr = kmap_local_page(page + i);
      |                                      ^
mm/mempool.c:71:17: note: did you mean 'kmap_to_page'?
./include/linux/highmem.h:67:14: note: 'kmap_to_page' declared here
   67 | struct page *kmap_to_page(void *addr);
      |              ^
mm/mempool.c:71:10: error: incompatible integer to pointer conversion initializing 'void *' with an expression of type 'int' [-Wint-conversion]
   71 |                         void *addr = kmap_local_page(page + i);
      |                               ^      ~~~~~~~~~~~~~~~~~~~~~~~~~
mm/mempool.c:74:4: error: implicit declaration of function 'kunmap_local' [-Werror,-Wimplicit-function-declaration]
   74 |                         kunmap_local(addr);
      |                         ^
mm/mempool.c:103:8: warning: GCC does not allow variable declarations in for loop initializers before C99 [-Wgcc-compat]
  103 |                 for (int i = 0; i < (1 << order); i++) {
      |                      ^
mm/mempool.c:105:17: error: implicit declaration of function 'kmap_local_page' [-Werror,-Wimplicit-function-declaration]
  105 |                         void *addr = kmap_local_page(page + i);
      |                                      ^
mm/mempool.c:105:10: error: incompatible integer to pointer conversion initializing 'void *' with an expression of type 'int' [-Wint-conversion]
  105 |                         void *addr = kmap_local_page(page + i);
      |                               ^      ~~~~~~~~~~~~~~~~~~~~~~~~~
mm/mempool.c:108:4: error: implicit declaration of function 'kunmap_local' [-Werror,-Wimplicit-function-declaration]
  108 |                         kunmap_local(addr);
      |                         ^
2 warnings and 6 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-69286c4df5b8743b1f65f308/.config
- dashboard: https://d.kernelci.org/build/maestro:69286c4df5b8743b1f65f308


#kernelci issue maestro:d414057925e4dea9704ce677eef188319c8610a4

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

