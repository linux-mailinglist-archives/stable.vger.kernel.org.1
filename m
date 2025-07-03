Return-Path: <stable+bounces-160093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C4AF7E4B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CD84E843E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E29255E53;
	Thu,  3 Jul 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pVpnga+I"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0224C09E
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561950; cv=none; b=hS3Jihb5JOt8yr5UTBdxJBLNBUZleN56KzK4QFSjIiUtzlM7Iy4rbqZgFe+g37Pl0BKtidZpwWekaSuslKhiEb6IrU21V9w7fRjuvjgXcyogZJ+YUZ3AYVRjqo7yjyWJk0ildl90zLGr/LN2xF27KS7pfKH6qDnAu7+leMgpajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561950; c=relaxed/simple;
	bh=8YknIxUtgPeZrOR7D4UyUPZ3duTcKePZ9vCHZ4ZtgZE=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=rUll6F5SUTF8rB0LQGgA5IHTIXA3nU/xcRIEnCbVcWQkbDpq+UujqXuapgSdZRcbdyhJi/56GApZ20Fcq2LYP4ZFAM0vRagaGh/pLtvBxmy/FdDAIxqDAExrnl4kwCFn0IfYuokxXJNLXAsA65LbvLFq/tJiqbjnofSPDQuTK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=pVpnga+I; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e4043c5b7so128977b3.1
        for <stable@vger.kernel.org>; Thu, 03 Jul 2025 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751561948; x=1752166748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+mQPT2kN+PotSbOLeuGIe8LfC3H8wtevOLuuCrgwNw=;
        b=pVpnga+I5CF6f8qoiNeC5bzRV2lruD0Tnd/RFOG3IiWIycfRMKy0YMJ7z8k8f0Hl3N
         ea3sQ1NNuOesKrmOFtjl0ozsQbe3rtnno382G/4vK+XOPv4layDPzgNPQ6lTiULRhxKd
         zEgTsJDxSujNg4+LEjwOcSIoZup9zYDrj/vhStvos90Llkc69NUrN/RS6hrKjaJxTDYW
         ZcCv+w5UVQwt95AU/EaGQIjnOQM3rcyzvfqc0PhcLeM/yMyt4hcCZJCZq8o5jGq+LnYg
         FbnqQKFoOPL5pdYqMeqnFvnB/1JJmv4bPCgpTj0SriHA8qVlvi/gdVxDROTUwo3PcPbq
         AZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561948; x=1752166748;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+mQPT2kN+PotSbOLeuGIe8LfC3H8wtevOLuuCrgwNw=;
        b=YJE0FdQlYq+8WrIptJtgLGINoEzM7GAK2JBN53r/ZMFH658SKD2T4YWGhlEcAIUrrj
         B5s/jmS50Pne67kNKn2EsMoDaDAiUwvzZHm839txrt4q0KsOl06mu+blSsxwzFot5mco
         /duzsCEwpoUlH3dx+bPJ+xzg8fhN0L9Gxo1AEnKQ9s1fTMFy9R2DQ3hhFwfDdyi1LtC7
         EnIEZ14aJYvD5awPQTQTrTdjsDWrzLnBVZRoktp3bj+HOvKAZg8tlho6P+LMAuq1bnn/
         gmUHr9yFz/2GYZSu8219dawE4qZWH1sQAk7sPF3x+roIglFv76QPIsOdhD3rW3OW6S9z
         qlgA==
X-Forwarded-Encrypted: i=1; AJvYcCVGGldnwnejsgyVTDdGfrcUiARVG+GLoB8vg3I8IDH0J5m10TWLHGIIFrtk0P/KJNafhCHb4SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+w18SSLNMBKNTutcfSd57icXxGhGmkg+z64qeieSMvN/v0eW
	PZXltP8dQOvt4W8Rw+EOa/KKhEa66DZGC96Ay9oRDb9aK/KtV5NOlXzvyvBdLXQyHDXQMteeRaf
	WQ2/haQkppUQMffv2hDgQdMZCELq8f6Dhuh53bUI6Pg==
X-Gm-Gg: ASbGncsb9wwy9YHL4jcVSh5d+tOIEr6BAjA8cd9BFKoKrVjM7Mt6PiXQdqgk2eK2azt
	UOlVqn6Doeie7KYMVI+/5Vt0oN7mgCUPwJD0I4FtRuFHktnnHrCafHAZcJtWeyl5KtapudyCMoU
	CXRE0WNLwOnx1gNVa0DfzT7BSYbFcGEdxN3LRMDkrKhshWeILom71e
X-Google-Smtp-Source: AGHT+IEzpETxE3htp9+euT00swJJDt1DVPrs+4Q7/c/Rog0sdQqChb6dDwu1QZSCRHBdea6T37KNV31ksAnn8MrC90s=
X-Received: by 2002:a05:690c:f16:b0:70d:f15d:b18f with SMTP id
 00721157ae682-7164d46ab19mr114240527b3.26.1751561947652; Thu, 03 Jul 2025
 09:59:07 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jul 2025 09:59:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Thu, 3 Jul 2025 09:59:06 -0700
X-Gm-Features: Ac12FXzkYhbvJUwSa9kzD32Q6RpAH71aeDZirFpVcYu09J3kLEh09pnPyIV7kDQ
Message-ID: <CACo-S-1XByzavdEiqbx5EQrSE9zWEdYEF4an5cZNr7ggWvvkpQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) call to undeclared
 function 'FIELD_GET'; ISO C99 and later do not ...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 call to undeclared function 'FIELD_GET'; ISO C99 and later do not
support implicit function declarations
[-Wimplicit-function-declaration] in
drivers/hwtracing/coresight/coresight-core.o
(drivers/hwtracing/coresight/coresight-core.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:82b0ad35fbcaafb1583fddab63ee2110454491ce
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cd39aa2833d237e301befa5db1902e33872ba3c7


Log excerpt:
=====================================================
drivers/hwtracing/coresight/coresight-core.c:138:9: error: call to
undeclared function 'FIELD_GET'; ISO C99 and later do not support
implicit function declarations [-Wimplicit-function-declaration]
  138 |         return FIELD_GET(CORESIGHT_CLAIM_MASK,
      |                ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6866682c5c2cf25042fae1f6


#kernelci issue maestro:82b0ad35fbcaafb1583fddab63ee2110454491ce

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

