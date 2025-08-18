Return-Path: <stable+bounces-171616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487BB2AC13
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8061E18A3630
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D0B239591;
	Mon, 18 Aug 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BpuaEkcQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558F1FF7D7
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529149; cv=none; b=bVsxJ2jjS7Owuom7jhAxG6RSx7BiKMbQ91FmRuTFwvKlcoj9OStjxIQRB+myj0fx0zVcKKWhYZOR2cYINPxN7/iRCbrNZSHosFRtFeL52uBGwdpBoy0yaQf7/IaalMq70eLosDN8IOOKDTYnjPH2edZqFc5uDZes4lvHelWUfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529149; c=relaxed/simple;
	bh=x3x2Axm/vg84U6A/QXRSVurUbA2OgAMZC8U9+0QEYwU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Ig/pG7/Smjm3f0ibAjmse8jiAX1q1oRoeTd2Fh0bROUZzt+z/VA8rv0/OKnTlCrfp+OXJv5bO60rKe/uGb6uVidVaVE4Je9Hs4ZbeCa+cd2C2NsMF/NhhVF2WuqeX1OMmNqtP/QlQMJVHN3BBRQEqqiYo9/HUwRf+KpzecOWigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=BpuaEkcQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-244580523a0so36902025ad.1
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755529147; x=1756133947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imihs9UdVJ+cu8dbhC8IcPh+Tx1B+im9KIGEWng20gg=;
        b=BpuaEkcQ+uFTtAvOTRmAQeNrQ3qToCe7+sNmbAEfkv03KHK+rbafQOgR05RJ7UigDk
         UI6iWpkdPZeREVdWp8YPHrUDMwnQnbB9AtQ+4iiAPuJcrFf+DZ6CChG+Lry/twD/jZAN
         kuRvE5gSdmzbylxGtryc6z4xRKbZhjRTrO4ww2F0zekPssI0s7j0/O2k7JCmeOifwm7R
         w4rIgg2zl807MwHlwUiprX8h8tiWqVbtTcTfkhgsR8yjfyQmXCC8mJMsLfJiUWs01C1t
         qDRxXzS+qTIyRcjRwULqQUQ+ZnUY1D7tLIzLzFMqPeYb3p3odic3MnWfWsYCCr23UqAu
         FIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529147; x=1756133947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=imihs9UdVJ+cu8dbhC8IcPh+Tx1B+im9KIGEWng20gg=;
        b=vFkmTB7iPz4mqGLoAJHo7goaJRcG3yxvzdmu8Bcd4gpP9zySSJ+atVbBPF/VCc3s8U
         nRDKY8F+UCEU3ibeOpfOrOLtffRw+rXt5T9zikzPFW5qvzQiqs2xPa1nYKGZGAbd2akU
         I2hSL887/613XjLIUo8cN137ABUcghJpiGkbwb6XCALH0REPbCZseoZlnkQgkOHgYdFH
         a4uRKmwyEeD6nZTghNaZ0EJfKcuq15mfuJ4ZUKhcL9qazlp62dtlnNbKeKZO/UWNhsCc
         h4v4vYFuaDyhbalqc5XURxmPdN9yKglkHfBmZco0kVHyPy3/ztEVHPMac4s+cm1pHGnF
         LqYw==
X-Forwarded-Encrypted: i=1; AJvYcCWtU1KFTRgiUer1y7S3d+oozITQlw7wx4Zutd/t0BOdzWIWmzYZKL4GeK+aVREEei84+r+wDik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSO1QrwpOQhL/f3JsFW9l2tdZ0fnNc/32LekUulqxwicL8Hde
	fWIwQi/V/0SNxTpZpl+nrErhPjq4xTdBgf5lEFGQzHGJtg4Oihp6QHnq6I2WI33TTpImmRp2gkq
	jslLy
X-Gm-Gg: ASbGncsHsU9nsN95y7HXFCTF1kgztWZpq86Pu09F3kle/rd8zg6lz3QAshl5COSfYhH
	yJeggOaM4gPVx/AETvyWIKc6tRdKQkWdfR/72pkt+bmOazXv1wbGiwMG61aC1jrhgnmbNSieIHP
	3A4oM5jRth4V5EuuNvdNMfk9Do0tnWpu3ezlf85UOfz+D4gRvG8rTRYeJVgAWK4RkempQePIBID
	4LJjQWS2Mpx8dJIX9e2rfSbMegODXVu/I0f/Tnzo23SON8wm3eFAx6uMH0I+V7ONBAbzbEXrsjq
	FZsKFCN+iS2+fE0fMCb4hPrJC3WODdAF2N6l7X0rZ/JAwz9RVwIkR1+k+OBIuNf96vE6TobXC5G
	Vn7Wlr5hxZzUwnD/nAeyxuT21kts=
X-Google-Smtp-Source: AGHT+IFGfsQFUqTsmYKdx37zAeKh/Nwqwb6+bAIVlwj5hdxkOCI8/wmkGgVkaubdMjpNuyeOJCUc5g==
X-Received: by 2002:a17:903:1967:b0:242:a0b0:3c12 with SMTP id d9443c01a7336-2446d9c534amr164418595ad.52.1755529147575;
        Mon, 18 Aug 2025 07:59:07 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0dba2sm82938645ad.68.2025.08.18.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) call to undeclared
 function
 'BIT_U32'; ISO C99 and later do not su...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 18 Aug 2025 14:59:06 -0000
Message-ID: <175552914619.59.17895621905537693562@16ad3c994827>





Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 call to undeclared function 'BIT_U32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in drivers/net/can/ti_hecc.o (drivers/net/can/ti_hecc.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:8ace23e7f8ec64c36de1851f3a96cbd024dbc75a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  243d4807be1704fef446934001535d37afafd8d7



Log excerpt:
=====================================================
drivers/net/can/ti_hecc.c:386:14: error: call to undeclared function 'BIT_U32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  386 |         mbx_mask = ~BIT_U32(HECC_RX_LAST_MBOX);
      |                     ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68a3271d233e484a3f9ea12f


#kernelci issue maestro:8ace23e7f8ec64c36de1851f3a96cbd024dbc75a

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

