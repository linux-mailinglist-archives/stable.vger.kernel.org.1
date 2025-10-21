Return-Path: <stable+bounces-188414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D923BF82D9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D850918C1F46
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE1F3502B3;
	Tue, 21 Oct 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Lie1doHY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B634E751
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073149; cv=none; b=h3hQXDNACaFZuPRj9yBqqkY51ioQbaEDyHWETTDywQ9uwG2nch+no5mln1DL7BHVVzl3/CqRVrqI//rUaRqfJw/BxmDwjmydUKkbnC0GOrJbXjRXg2EuBIDUr2pBZKQdA6kODY2yS0TIKoA0QvvleOszB7UxBbfJixkOj04yWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073149; c=relaxed/simple;
	bh=VK4uFuKeL1jQjhwhET5OamktbLThHddjP4Lo+W2yrek=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=KwQZpGbJSz/S2/GYQAeFD4LSEJU9izOfU6fNMHf25llgo6ZSMjtzK3HPU2l+owlV4BgRNkKVwrOIUaJlui7lVZ6zu2FeGv80uFAwYe2PhDZra/pdUPwe46cyaCiNn7BVpnT4prltYTYUbVTFXYJBmat9/+mRiqSz5aw3Dr3EgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Lie1doHY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781251eec51so4730728b3a.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1761073144; x=1761677944; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWC8hVDWUNSz93bUAzIR5RNAl4fES/0l4NlkL98L2Zc=;
        b=Lie1doHYYXUvcef3qUrqeaiY3UAE1N1SCGHpS4+Qzg6EnuvrGaMZgFZUne5ZQRu/p8
         arAnXmx9hs/r4Snb9RKZ8zciaWrbci++eQemIEUNm+vlXTiFyk9tgDr6hwWoGxHYBNlF
         muN4qMXd+I3AWYSC4PhKjtzPktnZtw4O7c+9Pza24bu2XlFZ4PZ4HbWCW1jsifaXJdLi
         4OXvQgQBL+FB6jLB6KG1xe4eTuTDry44pswWQf0lN7O0da048Spe1akmN0zU8khuEF4B
         c6qM2d8Fk67+QzsXFSc2ysnK1R/mnqZGkOgnF4a6FdclLS4kqzTiekCvtZIWxbf2oa3m
         5gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073144; x=1761677944;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWC8hVDWUNSz93bUAzIR5RNAl4fES/0l4NlkL98L2Zc=;
        b=EBusOUq0Gn5w+jxuCQlHQxL9x8VUnw+9xe0uSm/1ywLXlYpljeCd4G61Ghfu2AMfPt
         7IN8LVxpSX7jU3bNIoS48aaiqCZM+1+e3IMeOdEoBZDVycF2WLFMp/2vZu3kDxfzq+yW
         bBiZzJDiHr3tHsTWNTC6w0fa8Nw8k8bgBO35+w7sXKfj2GZBDOdYKZXz7B4Z9Mg14IVt
         EDzguMCCQatHk2FHBJAMyYT2I6YGG4zJViYkOS4M7L3QUGqs7O3AxyCI9hM+SNGRRBJU
         RH1qdGYNRFiQ4ChO2qSnMhdix2JvfMz83Gm+zwTF/X0XrF1q3LG50sBvPfePThhjeddn
         Dh6w==
X-Forwarded-Encrypted: i=1; AJvYcCVNgs7TQ8hYP1XXFHW/dXLsuv/ma+ngfxZeIbEoO2ytKey+6lvv/anVoOAnNabAn036RaiaJoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP43GnWqE4rtQjXFN2Dbc3XvhiGgeFDkTR2lQm4rP3OH5MVWM5
	RkfI9OUn57BdtKb1GA77+onID1/xSRPoC9yqBMAULVelhCLUXnNAY16ZIrwv5BQn1dHgVRvQkbJ
	uryK/
X-Gm-Gg: ASbGncuQlJ+CkuxriQMJVzfRSbPXOj3qMCqDT4nZT1CR2dzoCr1cwcUhavxzqsnHuCE
	CpxkExay5CJixnMXryFW3qaKl7QNB7TbHaMi++qZZz+eUMdO7o3hP5N08IOfNhPnvX31vNpdYbm
	UHkYwSpd/YDWdcVQjk0YQ1leR0JePo6DeZLx0iSlx3fiASbD+eTY02ESFWojWqB8aOZFq73GibD
	RNG6CWitiw1AtraZ+Vcr5kx4Dn1WL27Q2JVdOEwMu4oxOsGQdRem+7Ersc7BxOFR2qQF0Dk1+mA
	+H+suwD+OK/5N/3AYTObAIDnSbHiStgGh/timDEz4gxbzJPsp/fNRCCRGxX0Q+kvJHXj1fArwla
	LeTGl3ZYDXXXUoYUTrAYxD2ZcdCXvP+rnKr9WAJDX27MHqDMHDKTifn1rtPnaSeZYLflNuiANGv
	6J1Jif
X-Google-Smtp-Source: AGHT+IFX9qXN4re39RTgTtFl2yEe86cMESEZ3lEYPhA9ZFh8XNYJRli5iWajGptWw7VF14jSsOD50A==
X-Received: by 2002:a05:6a20:4311:b0:334:9b03:7bbb with SMTP id adf61e73a8af0-334a8621752mr22680271637.41.1761073144610;
        Tue, 21 Oct 2025 11:59:04 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6ac0bsm10954376a12.37.2025.10.21.11.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) passing 'const struct
 iomap *' to
 parameter of type 'struct iomap ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 21 Oct 2025 18:59:03 -0000
Message-ID: <176107314334.5116.11694860086926357376@15dd6324cc71>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 passing 'const struct iomap *' to parameter of type 'struct iomap *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers] in fs/dax.o (fs/dax.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:568e928648fdbc507b4cfc190ad338a93fe02440
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  63caad8a89c150b298b2e95d18ca60cd904d3183



Log excerpt:
=====================================================
fs/dax.c:1147:44: error: passing 'const struct iomap *' to parameter of type 'struct iomap *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
 1147 |                 const sector_t sector = dax_iomap_sector(iomap, pos);
      |                                                          ^~~~~
fs/dax.c:1009:48: note: passing argument to parameter 'iomap' here
 1009 | static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
      |                                                ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-arm64-allmodconfig-68f7d39c9533132a1895417c/.config
- dashboard: https://d.kernelci.org/build/maestro:68f7d39c9533132a1895417c


#kernelci issue maestro:568e928648fdbc507b4cfc190ad338a93fe02440

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

