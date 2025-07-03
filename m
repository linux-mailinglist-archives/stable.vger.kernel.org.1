Return-Path: <stable+bounces-159309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8644AAF74D6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AFE4E6201
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D032E6D2B;
	Thu,  3 Jul 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uB/WcRNo"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590D2E6D2A
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547549; cv=none; b=riiDvUyYfBpywDEacPANxpUVcFY9DWJ6RrOXashlwyWcRgtTnGnBoJRhMN77hHTnNzX6uNvyX0fSfoqNdox1cvpcCd2+7owidIYDsDa9/4AzKMQxeADasMjYL6zEdfuogBh7CdJFgrZeYaMAVlwW7ppyhfAuPDle9clBVvAaxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547549; c=relaxed/simple;
	bh=SZCFb/4cyfSQUryT1xF5pIMTNw4pIlR6Zd7w/jpHNhI=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Egr1doKd/WaglFFWT/0GQIdVYy9pbthwY80AzLYM73h9WOCRkuGc+GihTSq+jQjuqr4xnIfFjfX5BID7jN4mizWUbM7DgsBvi+y2G2t/sYOVxD71i1c/ASdjLwmbnVXcf4bOJuByXSI2bvpejBuvanCgXcYGZlBqKakotG6AhbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=uB/WcRNo; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e73e9e18556so1062435276.0
        for <stable@vger.kernel.org>; Thu, 03 Jul 2025 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751547546; x=1752152346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09lACZYWmvXox7GpxtMCzSO+xuyTP8gPFxVRXnPcXg8=;
        b=uB/WcRNoK6VWrf9BcP9H8j4CUT0oY9CasSNIQ/NTVVAVIuMUCxnCm8xEpttmT+brud
         eeUq6RPJjd1BgO7RbYMFF648SId99769CVRC/3HoLf40pk0sIRAbhUMXhIliq5xo34Pq
         YJfCKRPKz5o/roUw6KhxHUBONFkNwq0ASSTVqmdMkLVNqR32Ct32ZPnf2TUFk2MrPebh
         Vrlb2S8QCFrab5l0TjtTTDqo8AhRsyZQHeKPtMu+p73ubdIH0qC+g9CAPanFdyFu2BEH
         tiAWMlgwjgCl9WFMnMhrAqmcneahb946ikZvSpGlKrbcsYoufeFAYYvEWyrQr892lwdO
         2DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751547546; x=1752152346;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09lACZYWmvXox7GpxtMCzSO+xuyTP8gPFxVRXnPcXg8=;
        b=TNJEUtZybmFBTvrSmvusVwzPdl4IFN3a81X1Hqe+gAGjer15rWlJ7zFXgrdjAchRQ6
         OhpCHC6trWtDNwschSSCMHBm5yx/UVhjncKwDoq4fstJKR8+ZtyuJu5fiCITXak+4pMC
         ks0IK3uPI2iTvqJtWpi6KtczhLrsETX5naxj3sba9pAG/ODgpNGcPlVO3SenG1M0YQq+
         YszVkwGGtVc+Lpoa3pO6OngeiBGTMzzFtoc4C9+9j0lvwfQom3BGPyi/zBYaADnzTfiN
         WQjszTKF5RpDxFO6Tj8FXqpSG9adm+UPbmv7di+Wt+tsrxarxWAR8fzlKu65z9bRXDSO
         A9Gw==
X-Forwarded-Encrypted: i=1; AJvYcCU+OaFxD5sxy4BDqmbjdAbp2JPxCIQuKf18SPc4U7aoEm1szZO6iQK4m+ZvIk5nlSJINAk9Lps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRwc4OAocruYo4lVnyJvGsqZ9lOow1WBPHfHs0K6J3mdbPZOl
	nPQUTrmp/gy2m6P8sVm6wZZDwezvbJxmk6LEtsDZVMM7xYUpZkJwZhQuceKpIZZN/wZy4InwITs
	S9LqHqKWR7OkT+kwDw1On1qRH/55+GRDICAEZEmp903C83hYnpMIA
X-Gm-Gg: ASbGncv3LAomEais/u6fcI5XiSDb47b5NbxPtcADExR7+TUwfMZNOoY9kNOY8+qy4DX
	Pos0RDSLbLlm/pmWNVHlERSq/hWUMjZ8cN7U3kYEt2MypZeq8vSWOTLHYf2PC1pO05obCFqWHp+
	tJuvonYBYROxoIt8ALnhXKr2oyv3xXhQWTw2HY7PL9BDQoSud8JG8u
X-Google-Smtp-Source: AGHT+IFPmgS1Lcp3+1nqQ75GZp6YZ87brzX2IkWJWMFEV5b1M14Low6ut3bK7uk5URiXuXyPzlipi2aWI/4k2pWgVDE=
X-Received: by 2002:a05:6902:91d:b0:e7d:bca7:3629 with SMTP id
 3f1490d57ef6-e8993c4a355mr2266312276.12.1751547545708; Thu, 03 Jul 2025
 05:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jul 2025 05:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Thu, 3 Jul 2025 05:59:04 -0700
X-Gm-Features: Ac12FXw6L_YAPbTpqzPxAson-8-Qj5JwwZ2N4faJt-frxTh2P5-GpVbBXCJr4-k
Message-ID: <CACo-S-0CUb4oYoA3bHHGZzUHcVub7NB=jp_g7eV6Ytj5q=FyAA@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) call to undeclared
 function 'FIELD_GET'; ISO C99 and later do not ...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 call to undeclared function 'FIELD_GET'; ISO C99 and later do not
support implicit function declarations
[-Wimplicit-function-declaration] in
drivers/hwtracing/coresight/coresight-core.o
(drivers/hwtracing/coresight/coresight-core.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:2fc034698881a6df05fcdc7f92bed3f082d370d4
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  fb998e75bacb35a7d11e281ba8732263911ed908


Log excerpt:
=====================================================
drivers/hwtracing/coresight/coresight-core.c:192:9: error: call to
undeclared function 'FIELD_GET'; ISO C99 and later do not support
implicit function declarations [-Wimplicit-function-declaration]
  192 |         return FIELD_GET(CORESIGHT_CLAIM_MASK,
      |                ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6866678b5c2cf25042fae08e


#kernelci issue maestro:2fc034698881a6df05fcdc7f92bed3f082d370d4

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

