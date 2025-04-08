Return-Path: <stable+bounces-131765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6557DA80D30
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 16:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061EF4414FF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D30E1AB52D;
	Tue,  8 Apr 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wIYyiVQT"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F28836
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120749; cv=none; b=awBTz6cXG5k3D6e9M1dVZoDtyk7mevyraxAdVaTvxsl7LXrkqK5Dqe14ZQ9AyiunG17fk2Z6vp5UF+haqE79ZV+7uMurZXKtX/o3a/VRxflV+BOuBzx0auczqUDyYagNurZ9WjbcspHR2lYvYI1kJdSe2DCtb7t0zLEZfwRYido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120749; c=relaxed/simple;
	bh=scShRbWyfHKWHmj/XdexUnBEPQr/1x9JIlHvHiBnILE=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=TafCUD723LPIzywboFMB5kS8agrNJDCxtQWDO6i1GmOjEQ3EAj13sSmPM9P6Z7wgS7KlK3ZLBRG6j12i3u1fdhhzzcdDDJs6aCPAwIoswbf1knm1YlhH3Q/kV0oMTlvIXrI9BQHrOEgh2RrinKc588ixhAWvZHTDfUgXdBvp5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wIYyiVQT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ff07872097so51405907b3.3
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1744120745; x=1744725545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz7I42jtt2TRM/qwZCv+GmdAdIknXYgLeni37j6G3IE=;
        b=wIYyiVQTsM7lDTr4brsXu4X9pl2Iy7s2HL5isDI3I33zPjS5iofpiNkv0DeePlsjd2
         DwSyP0OIsJZqvdnNdpIPmLbthErBqIE8PCD4+WuI2hv1Nbbjp9EB87dtgmvwUYHLH8VH
         EKWlWEOgf9KOlwMJJLnWR1LdrWxtxrR1iCVVYsgwvBu2DyCn4wt8dZiKPf4e+QG8c3ej
         u25qcnD+6HSyzy4Pixn2nJiJBUKfDudAFzE4tT5gnfoYicn0Z3074CUNeR98rBCU1mlF
         D6Jt/Cu8pxPSluaccuIrPPuqaVxtE4GrT9pPhtZn9VMbsx4Uh0PDhDIzccGclOmZCZOj
         ReFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744120745; x=1744725545;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz7I42jtt2TRM/qwZCv+GmdAdIknXYgLeni37j6G3IE=;
        b=X9y4C+ZnYusMvd9r2WUpVZzCiiMNNxIUNG9SBmSgi/3fvA3/J9HOaIQmizRekWgJRe
         MM6TfM/K/F4i6cYOaGv0192d79XC/j7V9s5za4pH9PbUiI1m35myNxV//1E/gxQsDlWZ
         pL9r9Yj8XBqYtjV+WBTXTPnHphWBnuPgduMV4gdbxmun+2brzbN7PuR/GFb6yNOvUSWa
         NoRRDfd+mFsqy0sq95WWYQ7MstJVT52sGU64bIwDlvXQ6X5A/lcJWEZCyEXxpSgJJ+0d
         AYdVVl13nfpLf79OmXaqxV9lV48tOp47tyi29sl8hIg5eV133SJtxomfDt/IJd427+qJ
         1x/w==
X-Forwarded-Encrypted: i=1; AJvYcCW1nPVGXGDQxGsbTV8tmN5VB2Z6ohbQMRkK8Y14ZXiIOl1MqxIb96VN8PkzwzhzjRmi0gZ108A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJq5XiFXMnzTDtj6H609EMAHwU53XTCnYwRonwcw7Q7q6U8M8
	Jkl4teu6r6+2OHTGnHHQ+FT2JuXBmw24+NBCxaMlmg4/Ncyvcp4c7IPhjCFibqoreqUNwwSZy4j
	WKuQQQtZNMHlBA4q693+QVpicoGouZBK+6Ks2DA==
X-Gm-Gg: ASbGncsFaoo5tTiqkimAQcxUnGYCs/mI09PBcwabIAVb4Bu0FrEA6JGXGIUPR40cvTr
	W4IF9pJqXikV+2kw/EiTVctpkQYkhEYtwfmOAkCHvTvuk6O/UsB+z3H2nbuBEBMm+wagcv/B2N5
	ktf2TLalzzuGfF2hHgVvI96Loi0kgfjejXLZA=
X-Google-Smtp-Source: AGHT+IHxHc7NGV9tS8sdqlPEo4L1oIfqsdyAYpNmO/P6UuL5QJIyhvRW6uGouHRlCCNXhUtqVvndcqcX5lCmORlq8SQ=
X-Received: by 2002:a05:690c:9a86:b0:6f9:a75f:f220 with SMTP id
 00721157ae682-703e15fc484mr283622807b3.25.1744120745211; Tue, 08 Apr 2025
 06:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 06:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 06:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Apr 2025 06:59:04 -0700
X-Gm-Features: ATxdqUHdaH418-qkjMvntJAIMBXffmCz1BuAYC3y0og3_6SgCB_rbNSgBW3BUGE
Message-ID: <CACo-S-297JUFPCNaeSoA0WHSP=sC+QquSZaX=rQto=JZzi1PUA@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) variable 'base_clk' is
 used uninitialized whenever 'if' condition ...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 variable 'base_clk' is used uninitialized whenever 'if' condition is
true [-Werror,-Wsometimes-uninitialized] in
drivers/mmc/host/sdhci-brcmstb.o (drivers/mmc/host/sdhci-brcmstb.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:eb9b0da83cc077e6176b9903d98f0f78704ac17f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0b4857306c618d2052f6455b90747ef1df364ecd


Log excerpt:
=====================================================
drivers/mmc/host/sdhci-brcmstb.c:303:6: error: variable 'base_clk' is
used uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  303 |         if (res)
      |             ^~~
drivers/mmc/host/sdhci-brcmstb.c:377:24: note: uninitialized use occurs here
  377 |         clk_disable_unprepare(base_clk);
      |                               ^~~~~~~~
drivers/mmc/host/sdhci-brcmstb.c:303:2: note: remove the 'if' if its
condition is always false
  303 |         if (res)
      |         ^~~~~~~~
  304 |                 goto err;
      |                 ~~~~~~~~
drivers/mmc/host/sdhci-brcmstb.c:296:6: error: variable 'base_clk' is
used uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  296 |         if (IS_ERR(priv->cfg_regs)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-brcmstb.c:377:24: note: uninitialized use occurs here
  377 |         clk_disable_unprepare(base_clk);
      |                               ^~~~~~~~
drivers/mmc/host/sdhci-brcmstb.c:296:2: note: remove the 'if' if its
condition is always false
  296 |         if (IS_ERR(priv->cfg_regs)) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  297 |                 res = PTR_ERR(priv->cfg_regs);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  298 |                 goto err;
      |                 ~~~~~~~~~
  299 |         }
      |         ~
drivers/mmc/host/sdhci-brcmstb.c:281:6: error: variable 'base_clk' is
used uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  281 |         if (IS_ERR(host)) {
      |             ^~~~~~~~~~~~
drivers/mmc/host/sdhci-brcmstb.c:377:24: note: uninitialized use occurs here
  377 |         clk_disable_unprepare(base_clk);
      |                               ^~~~~~~~
drivers/mmc/host/sdhci-brcmstb.c:281:2: note: remove the 'if' if its
condition is always false
  281 |         if (IS_ERR(host)) {
      |         ^~~~~~~~~~~~~~~~~~~
  282 |                 res = PTR_ERR(host);
      |                 ~~~~~~~~~~~~~~~~~~~~
  283 |                 goto err_clk;
      |                 ~~~~~~~~~~~~~
  284 |         }
      |         ~
drivers/mmc/host/sdhci-brcmstb.c:260:22: note: initialize the variable
'base_clk' to silence this warning
  260 |         struct clk *base_clk;
      |                             ^
      |                              = NULL
3 errors generated.
  CC [M]  drivers/gpu/drm/drm_gem.o
  CC [M]  drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.o
  CC [M]  drivers/net/ethernet/rocker/rocker_tlv.o
  CC [M]  drivers/staging/nvec/nvec.o
  CC [M]  drivers/staging/media/zoran/zoran_card.o

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67f509a66fa43d168f278a2b


#kernelci issue maestro:eb9b0da83cc077e6176b9903d98f0f78704ac17f

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

