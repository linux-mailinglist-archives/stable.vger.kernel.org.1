Return-Path: <stable+bounces-133330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19134A9255F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C737B480E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D754258CC0;
	Thu, 17 Apr 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="QZKa4Fgm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42272586E2
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912749; cv=none; b=gjHcI/XXTk3v5ek7jNy/B9eN6/eYOAE7GKouUOzrSAdUBRA8XCIDFRxOJ/O7IJ4qIxMda2JKHFQ53MfNqbeJ4Q/cXgJRLuVyEgBMqS4R84YdHyqRaJnKg0XOACnVWLBjgXzLZF77QvHzgCEryZ2M+tSUoNJBdBVw8WSaB5OOFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912749; c=relaxed/simple;
	bh=9rFyEBwktClDzkdnh3xMeZawBGPcjnC2mHv7u2UrLTI=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=TcC5ke9jXjmN4o/+6e8ek34/RXmAoxZqq9MszunUvP1LgExCIkewFIt+GzVhRjGtlD6l6Xo1aeYJZRjyvWahlpeGp55VZ3yHZD0aKUq2kW48Kf+Oc2c1Tib6As7Jm4+1e0XnQv5TGkNnzvcMipNK3XWAuT28P1dIH5Ng28ZM9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=QZKa4Fgm; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7023843e467so9877857b3.2
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1744912746; x=1745517546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR3krqbkiya3yZsj4FIjF3VhslTMBVaSdPQPlkAvXTM=;
        b=QZKa4FgmjJqDNoCqUue+UWaCclyMY9y2DE5q5HGWukD44UOmb3rK39xXA7sAQtRuMv
         hGqfOrANjoaYc4aTQJ8GogC53c3laZSwuvxhkWbHQspConGLp4Emb5aJImfQQVjMUzKC
         Yl6wiyVk0+Y9PvhA9tqSt+5gHEJ+jI++cIQmaB2G/JK/kEmLxMW8Iu1oOVAMICiUcdSh
         E6r4JTEB97Bjj2oBKGcHt8d/Th7m48fDhupvnYaKVeJEFSVHUP+s72LDQdwagQkgM1vy
         2Uq88RaXarsxgJ5putOTy4RHfRHwdxDfhBkq68mOpu5ZuTajjsDdFbfC+hplutowhlr8
         /20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744912746; x=1745517546;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wR3krqbkiya3yZsj4FIjF3VhslTMBVaSdPQPlkAvXTM=;
        b=b1p90YMvufqb7JR21HYFEEDrwmI1rErXUzYqOETOxL0cbO3rU9XmXeD7eWkowrpNAk
         rutTtNgNA13dvCg06BtSW2/Jz3TNUCGushaLeXPTHF1iYID1PXpnBZswi29JcPtpR/I/
         mxOEpTqF+JJdXZnp8BJ6N6BL1Zgcgt2FCCf9D9VJ7dNwvKdor/IJvXtV8nctToXWJME0
         AGx+4LHsoeEdweiwopCK0Hzf83q1mMEKpGYevriB3JaXalE5kRuOcWKMWKdcfSc4vi2W
         g6e62+/sFDNgLF6Y96vv+YKw7UIemq48WWnMmgoOz1GfPnR7fpz8XRK/bfGQ8wH237Ru
         g/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWYmc70qpjKVSDwXNOTVjcXvsMBAHzDKE518YF+20R18XqNSb2ReM93SrBL+z9yeERi+y/52Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2R0/5ObT5df+smC0SUI0uKr9gMTPSnwXYQzy7W04bQ+CRlezE
	WDAQQN/quGPsmpkQH3BtKWZOVys6o5qN83kSqajXxiZhRR7ZzSxc0avzhsYA3UGS47otYfFXi4n
	8ZqDZstdVeCirh59dnCY7ZHf/Bpp67KnbeiniIXbC2BxIhK3KD6w=
X-Gm-Gg: ASbGncvkIYuqtpgD4+aHVMoiZ0iJcA0pLr7tdkP0eGeVl4qmxb7rSArsEikFlEXh87G
	LLKdRcEav5DkClQEWgmFeVYO9phh0GTbWWzHdIfBhyJc3M17l7fXIUq3vGAQlgcBf40GL3PWOtU
	+iKj6JWjiU2bxg0xvSSDhw
X-Google-Smtp-Source: AGHT+IF638LsHbhAbOtk/Zwja11JiO73ATfSFM6PzoMLRWrFVO9Heltz76hD6YED4UU6saxE3zXfd0JoQNzc3rb25lY=
X-Received: by 2002:a05:690c:670b:b0:6fd:6589:7957 with SMTP id
 00721157ae682-706b339009bmr103564587b3.32.1744912746579; Thu, 17 Apr 2025
 10:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Apr 2025 10:59:05 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Apr 2025 10:59:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Apr 2025 10:59:05 -0700
X-Gm-Features: ATxdqUEU9_8UY9ZhvDhykpR0XWR76Zw_ioaiKUqLf23ulZW2rK2IdxrTzFoQzPM
Message-ID: <CACo-S-0qwzEvJCMr4d4-CrE13VtCCS+X6h_bJ7d3yPicnAV1Kg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) call to undeclared
 function 'devm_of_qcom_ice_get'; ISO C99 and la...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 call to undeclared function 'devm_of_qcom_ice_get'; ISO C99 and later
do not support implicit function declarations
[-Wimplicit-function-declaration] in drivers/ufs/host/ufs-qcom.o
(drivers/ufs/host/ufs-qcom.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:6fedd1ca741e254628f03f43c92b4be51feb9461
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  df633f6429d23d385038890291eca6164975d303


Log excerpt:
=====================================================
drivers/ufs/host/ufs-qcom.c:121:8: error: call to undeclared function
'devm_of_qcom_ice_get'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
  121 |         ice = devm_of_qcom_ice_get(dev);
      |               ^
drivers/ufs/host/ufs-qcom.c:121:8: note: did you mean 'of_qcom_ice_get'?
./include/soc/qcom/ice.h:36:18: note: 'of_qcom_ice_get' declared here
   36 | struct qcom_ice *of_qcom_ice_get(struct device *dev);
      |                  ^
drivers/ufs/host/ufs-qcom.c:121:6: error: incompatible integer to
pointer conversion assigning to 'struct qcom_ice *' from 'int'
[-Wint-conversion]
  121  CC [M]  drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.o
 |         ice = devm_of_qcom_ice_get(dev);
      |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68011e0d69241b2ece0f82cf

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68011ea069241b2ece0f83fb


#kernelci issue maestro:6fedd1ca741e254628f03f43c92b4be51feb9461

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

