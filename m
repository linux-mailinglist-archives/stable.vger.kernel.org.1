Return-Path: <stable+bounces-144712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E32ABAEDF
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 10:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F17A7A189B
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA6212B3A;
	Sun, 18 May 2025 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cWjZY+Pd"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C9211706
	for <stable@vger.kernel.org>; Sun, 18 May 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747558748; cv=none; b=fGGtGQXvuXSZsZNWiH5/FHCfrXglk9b0++NfKFyLQU8TUg4HmTwRYPt6pSHihzdPnpZywgCcCVnBt1EOwzukRmx4N+XxV33+YaSl/1cbJab8OxIVMHjFNZ+0j58T3xBe54F7bQAaP56XatCAEpaUf1AXkOBuumGs88jYGw2S2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747558748; c=relaxed/simple;
	bh=pWcHn51RSP8Xq2iVG7EQpRgkIfbdmc+nsIZday7XUN4=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=cAiMdN3FHmvIt5wObxc9OycDgjfeWHUyZhyIwtmQK6exO2f6MS9bFTugxO9SejO/83pDVUestHvBTi/cAjVRZgkWwwyP4g8lhinR3iO5Z3DGHPuF8/YPPikFbNfDBUVPE84UzOZK8jXxDTbiay56mzctdVcktVzSSPNB3v0ejyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=cWjZY+Pd; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e73e9e18556so3210470276.0
        for <stable@vger.kernel.org>; Sun, 18 May 2025 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1747558744; x=1748163544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WCcpo6Kf6zotlSuX5AALF22gOQIZhUCkcvj/9Q89Ow=;
        b=cWjZY+PdOzPTRpieFbPLZ4oLXedlQa1oXTKfMdQaVtV165uFwsVrNS343ye14fV1r0
         slspXuhHnsQc0pBjm7aVvUX94Ko0mTss1ZOA+vrHl78zJSSjqiT0rcUsBh4MMovzxC2c
         PDpD8Uh6SHa1+XG/DBK3JdAbcDZDWqyc04Evb1CkTihOhWeILMHOvkgYVFQvVNauWmyH
         W9jB6b7t+CbEAw9N9qOK9lQNIu1rcDShR1F8C/8/BmHkCcLUXLxdLpLWuzU7M02cXYMy
         K2BTZgbU69eP7syQTfNysLSopa/+bV4za0jDVhxSjL2/dA7PrBi3R0EZ08t3nKBM0J7x
         P7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747558744; x=1748163544;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WCcpo6Kf6zotlSuX5AALF22gOQIZhUCkcvj/9Q89Ow=;
        b=mnkltjhRZhsy3vpoc4lNcd7MhQUiK4zSkU26yvoPlWE/il0wgUf34zkDzrfxpkTewy
         LLejQRNQ7qhxYWOM+PZNufGcb31h9OB4N9K2zP1m8YCJd9jhw8Hti3PpG3ehBEYoYrfo
         JCXhFBrmf51b4Hy3sS0lpzHsQBECzon0y3wxkim2pEW9iDu2Cg+limBxgzupGp5ZF5Jg
         SXKy7IwwUBr2X83h/3GRXaD5DgSfWuMviz55s1PhrPHMMG7FrRhXsiNiRzFGLUzS++kb
         xkWpX7UIfiOA5U4HY6VUW+l57YLHURm7+xy5G3771uNCDmh2T6iigzafT6inYP9o/uL0
         ZtZw==
X-Forwarded-Encrypted: i=1; AJvYcCXH9FihsWL4vscVphZlUpCvqQd/6xghbi2jTfojWRdPISqa2CuaFFpCfNLfoOGp8z+b1gPXIjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+19eSp6+NLSJdUFFVIjfA0dZonHLdTkR1mcKY049mQxjBtKlr
	bwyq9za/zRKw1gYsOn/bRtpJbKJf3IUq+fbHXY8t9lCTkhcZtBdD+46g7H9230XTMVC7iuTo++U
	xugr32jnqFL7JuoL2k1BDTK1ZV4rmSi+tnhmchskX+plG110ggTUz
X-Gm-Gg: ASbGnctyFhmTMFdGdY7sT3NQWWOitx90d1PlUkE52iQ9vwv59kPer2qno6ndDvZehvf
	cfl+4lZdxW8u8atwQtwOO+1ZNEiFUyOuBeyH+iCtNBCeg9M1KbhKzD05BRu0YnytJ1G36U4BzIL
	2+7FQhD5EMEn/Gf7dbzrw920GEhSFeZhMfF/HQcbthNQ==
X-Google-Smtp-Source: AGHT+IGdUCLabxxr91T3kXzsiu/GPxp8zOP7KTG2cVu5qpaLecYzeCmGjlb0eugQjcz0JDgNNNj41U6PIKUYfJdzBd0=
X-Received: by 2002:a05:6902:1891:b0:e7b:9efc:1155 with SMTP id
 3f1490d57ef6-e7b9efc128dmr566340276.14.1747558744469; Sun, 18 May 2025
 01:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 04:59:03 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 04:59:03 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Sun, 18 May 2025 04:59:03 -0400
X-Gm-Features: AX0GCFvA4Ls-H1D6TarpnY94vBfa09lmXlfXDjMrhDQ8Cw9CBwwkwJ0AgZybtVY
Message-ID: <CACo-S-16Lm-ncHFLUKzJ3DieDZnMZGSw-3g1XPA=u8M8h_uqOw@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) redefinition of
 'its_static_thunk' in arch/x86/kernel/alternative....
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 redefinition of 'its_static_thunk' in arch/x86/kernel/alternative.o
(arch/x86/kernel/alternative.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:4e3244fcbf4c807ca7a60afea944a81fb0547730
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  615b9e10e3377467ced8f50592a1b5ba8ce053d8


Log excerpt:
=====================================================
arch/x86/kernel/alternative.c:1452:5: error: redefinition of 'its_static_thunk'
 1452 | u8 *its_static_thunk(int reg)
      |     ^
./arch/x86/include/asm/alternative.h:143:19: note: previous definition is here
  143 | static inline u8 *its_static_thunk(int reg)
      |                   ^
  CC      drivers/pinctrl/bcm/pinctrl-bcm6318.o
1 error generated.

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68298753fef071f536c11059


#kernelci issue maestro:4e3244fcbf4c807ca7a60afea944a81fb0547730

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

