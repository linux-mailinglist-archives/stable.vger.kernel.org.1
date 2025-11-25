Return-Path: <stable+bounces-196842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0FC8328C
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E0524E24B8
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 02:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E091E5018;
	Tue, 25 Nov 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="oz8k4Sk2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBD1E2614
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039548; cv=none; b=OpzMupDmo8GgUwQr89yB0dk9vZnYJkCpED1HkE2CzB31vdfBb5g2g6rrOA5vNm2ZzBJc3P+p2g0hJSB/r0H4p6kO4++jd6xdfZCdb2MyHpdqGUgRdbstlf4EhvXl7ay3FlZ6rgW6rh7rCH0apbQcMErZLawSumqV/oa/tWMrmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039548; c=relaxed/simple;
	bh=iVYPzH7P13LBBgbKfRT66tGblf1ow+nT6Y4LcnKstPE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=syjMA9ooYb9jLE6xtSalg78yoQXOSW3gqe5ialCi8BXbsmqWqtc1PHZpBjBNarnItBh9dfEADZlt2wOmPHC/jW/qXyhRRr49RAnp0QBk/MhO+NoaBMXaWatTlTr96A+gnc32ygJiByNUkox1/yFKhFRhvJahlcvN0X2i4U07ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=oz8k4Sk2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297ef378069so45442545ad.3
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 18:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764039546; x=1764644346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLoSaLYRqAmW/3a9qYm8KKzV6VAcjYNAAIQNh2tJZ6g=;
        b=oz8k4Sk2XS1HiQmY7o2BINFZYtrqLtXp1IX5fmO3hTiXQ+EixW2vLWLMfCOVUAnUkP
         SFkxx2XxkkRmTw8dsNdJKZUmZ8aYKjD7nq6/9BtUJwzXV8DqXO0Oq/UF18PM3hxg2qzX
         b+PCBTrxkv51cAzTwyuJZqmr71IX43xp9wOW/6ab0MievR784Nkho2MaiC3aLxiV2U1D
         M45RyfPN1EZolf6Q5Ir5+Lose4CEHTrTh+AIS2R+zyBpdNJZB3YQHVspfiN/1dA04Oqy
         o7mQeB/5hGoFvNEsyHWFVTDPvgWhKvSIDBam5b57YtpNkGEVE2WB7R6lIfvyzoVtUkvf
         j8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039546; x=1764644346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLoSaLYRqAmW/3a9qYm8KKzV6VAcjYNAAIQNh2tJZ6g=;
        b=YXGq/tAx1slGyweeX05dVt5+nUaD/+g0Rcv3eLUJUAyHKS/IkrtdTq+kaVeZi/0X6M
         Au3ByYh71Ye2s5bJ8xzrpIAfE9/fYS/Wzt0iH+aBlxJ2MG4ziW18w/fdbp98QuPqogyR
         NyPTMSyQ2AgM/EcLe6WIQEfexuGT6vt5FhofMr0bS3I2Oces9hkIYQO5RSn2XVTG58n8
         roK7YjazS5UPf1WFgRRzAeLXAt7Bq2jz1ZHW9mEjWo/BrQ7NmsY8A6DtdJyuRRUYICBN
         LUy9IGHbTS9Ek97gqR3csGWWLavXWbPwX9hnmDC1O6MHp29z+tc9btkRLQMLSRdnkuKB
         wr+g==
X-Forwarded-Encrypted: i=1; AJvYcCW2dVjwUbl3IB6bSv0xFawcoRfEExlu/qqqdXcA8HR/eX+QMGiW31bDW0JHjB4N+wGVBp4VA+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYOMETSYaBdUyyWF9cN3D9XNW9DtLtDv21KLbYk+Ga+9C8Fh6
	KeTRtX0+XPafCt/SViISs9XV0KmtjzQiqlfoqAQcJkziW3BvW5p+VjzSog19qpjqrL/LI2D2p7y
	X0v1AENY=
X-Gm-Gg: ASbGncuu9jvijR2ExXs9e/G7J3ZapwpCSwyJa9mI2NSwxccVli43S1YjQNERE43RoKj
	tf62BbuVvqLumOuzpNnARKOy/envz6CrIecdIzUixi5Mkg+ziYyyNqbC1a8Kug91Mj8sixp0Ish
	Cgm4tYtvtQy3YtN14uudzorDiNvwjFjNPxmvulLE5gWqk1HciimFGSquoE+gKHEqNi6ZedPniVB
	ILRc6yV68Bq8k7chrIHc+WuOAZk16VxajIs07yveXUov6CuObxouWbgdnUt0buOVDVv82ezjs5d
	eUXiWAug3bTldPrRABDT4TWz2lvvK+AIvLFiX5hzjaIPlNZEC62jgifR1UNfQF5JtngSPDStLNo
	OPHtK9Pl8cYYtgBxWZBKE/Bya8peJ3COFbWY+vZEpqmH4Qqm3gv48aj9fn9/yIujJzNqsGpaQtH
	9iCzgC
X-Google-Smtp-Source: AGHT+IGHr65Du2rrjdpQRSLDqa3jCmpDTcOpD+moJsoaE+EIttLPao9vHRThfRkP+TQCXryMiMurwQ==
X-Received: by 2002:a05:7022:92a:b0:119:e55a:9bfa with SMTP id a92af1059eb24-11cbba53610mr905521c88.22.1764039545896;
        Mon, 24 Nov 2025 18:59:05 -0800 (PST)
Received: from f771fd7c9232 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11cc631c236sm4359095c88.7.2025.11.24.18.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:59:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.10.y: (build) the frame size of 1192
 bytes is
 larger than 1024 bytes [-Werror=fr...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 25 Nov 2025 02:59:04 -0000
Message-ID: <176403954456.358.2751425113470671350@f771fd7c9232>





Hello,

New build issue found on stable-rc/linux-6.10.y:

---
 the frame size of 1192 bytes is larger than 1024 bytes [-Werror=frame-larger-than=] in drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.o (drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:2fa2a6ca830cbfb7c388f6da90bf40ae58e3185b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  47c2f92131c47a37ea0e3d8e1a4e4c82a9b473d4
- tags: v6.10.14


Log excerpt:
=====================================================
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:219:1: error: the frame size of 1192 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  219 | }
      | ^
  CC      drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_reg.o
  CC      drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn20.o
  CC      drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn21.o
  CC      drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn30.o
  CC      drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn301.o
  CC      drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn302.o
cc1: all warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## defconfig+kcidebug+x86-board on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-kcidebug-6924fef4f5b8743b1f5fac6f/.config
- dashboard: https://d.kernelci.org/build/maestro:6924fef4f5b8743b1f5fac6f


#kernelci issue maestro:2fa2a6ca830cbfb7c388f6da90bf40ae58e3185b

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

