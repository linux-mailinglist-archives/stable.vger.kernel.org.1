Return-Path: <stable+bounces-171615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED3BB2AC12
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134A018A346C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C83217722;
	Mon, 18 Aug 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="11VI1JT6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768135A2AC
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529148; cv=none; b=HMlS1KKB6v0MIfpm3aT6rmbOWO/jx+SZY6CQB62scoyjUPfdke4CC8syw7GMUh0EM5IfQs0bVXpsRSncHMu4RW/aowierhY2SH3JK+JjN2PKMMkGsV/Q02nZAXHOXBCVkfuh3tDOGH0mT2bsPYW0PDi+DdkvSU2xerQTwwCqZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529148; c=relaxed/simple;
	bh=1CZPBKqu/7ZEFyHu1MfsM16dI4vs+nPGNqiZH7AXJaE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=BWWLSvMsZX3qZnHvjpgi8Cu4M3dTCbzzsjlgPKKZmlKYzf78cRt3xGj73hGIS1+qsZxGdLhm4LBro7nkvNkyM9YWZvMaR1AB7LocI8WYrpwAotKe0m8IFvCrjuB3SnjI3BRR1hwLahl3pmpfgRplRSxb4onWIOenxv7S7v33J18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=11VI1JT6; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4717390ad7so2880291a12.1
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755529146; x=1756133946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3+nrQMZjyoe7skqNxCYdyCCPFjgYbnRaHd/eT4wOxE=;
        b=11VI1JT6qgg5I9z4pgCaPU4DBb+ACExR++XJs3tqrxZFwEFEYN2t4YL3P+p4pPCf0K
         47hN043L7nyiBjfbbpeQM61mIrU4kZ3o+5BRAS4lNpoqryNEX7wsK5ypBMhM/iVtmsTd
         jBBDrQ61aaVckiXdK9DYj3xLyiBaamsoOrFcBzY3OHDb33GxDRItfyRC6RUMrJBfqrLp
         8YJaOP/SnLL6vYuPX9tRBwRL55CjOmQ5eHOb1gPb0ESvEpSk9+fvl5/umRWc6gYgCa8X
         8nhmndsCA8DQEi++T6Olieop4PUDgLAxQpJnDYVXPxIXHtnNy4TQqNkoiAXy2DlCm2zB
         lZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529146; x=1756133946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C3+nrQMZjyoe7skqNxCYdyCCPFjgYbnRaHd/eT4wOxE=;
        b=rVVf22hKdBEFaExxUXqBgzbhN6raGSlwfVrgxUjR8X3fQUANn3TwfuP6T+milk8OR8
         x17G35+Sro+nQoIIbIe+cbAmR5tjEpMgQXXz1qmGVETTWXMf/uBD/Y7zK5v/gn9SCR1C
         1pOp4xVDOypna9ZIlL1B93E79Csn34ZKjaFGF+3tC+DfPSfPvNHfJFvha/iNFMCAFA2I
         2Xxeyklkj1AYLqw/vScEp2nN9iK4wBi15Lr5fFYqqTq+EFv7beD9u+GeMKdFYWJjICyv
         h177kYdaUlClEOCtYz2aB1XyEjz3TghEGLz2ezOqd6DmJYN+TQqGzhPfRTH8UIRWdHNT
         LYjA==
X-Forwarded-Encrypted: i=1; AJvYcCVySd7/fuoVOBsJ7rKd/UohtoJlunHsOyN8GZ0tc+1sQZ6ZIWtLrDBgcRYA+ih7W9t7TFyo3xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwnLpyFR0/P0Nf3w0QrnANUTNN6lMzn4M2LxGm0N1b8ER6AWM
	XxePBb3clXLXTvt/i0bEpnkY6y27aV8IH7/4beHZT2+NY+XdJZcJRH+FnmLIEkjfMQGbuSnSBrM
	JD4ES
X-Gm-Gg: ASbGnctS/K/+HlbOx0dJ07W0uZtEs6Vkw8U8b9aKoJytW4n1q1gKSYjsZ2mlRVrLRTd
	6HF+UVKD8ebFnRWMOxR/2xylCzsxTGVMCrOxUYSTS6S9QEH82eywW3dqTJsXolPimm6DBsF8TDx
	NPqdqLy480PzWq1b8lry19BMCRV/j6HJLq2fXd0uhj8FYSBssJLQrLZWf/+ICYVqhTtp5eQNqSI
	xgz/GZtj6JS86cPM2C0/KRDSUYF/5DCVgFLsIzBxOVpTgmXmXXWaGzF9XKru4iPSF+z91xlG2Qf
	391vGSDuuRWp2V8IAd27/Sp6SjvTH3AYgQjtc8Z5yEINYRGc5hoLdb2cofF/JH9jlcPTQnWCvBH
	dJy0sa24ZqOkOg7Ql
X-Google-Smtp-Source: AGHT+IFC3FkzVDlcxxqXEgE7DRm2nKyiD5IBM/KjGv8CKvjsbEXdN31MJPLb6WNYmSeP3qjdjRmzBg==
X-Received: by 2002:a17:902:f647:b0:234:bca7:2920 with SMTP id d9443c01a7336-2446d744f72mr214803235ad.24.1755529145853;
        Mon, 18 Aug 2025 07:59:05 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9e063sm82876215ad.34.2025.08.18.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) implicit declaration of
 function
 'BIT_U32' [-Werror,-Wimplicit-fun...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 18 Aug 2025 14:59:04 -0000
Message-ID: <175552914431.59.14848574391579704496@16ad3c994827>





Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 implicit declaration of function 'BIT_U32' [-Werror,-Wimplicit-function-declaration] in drivers/net/can/ti_hecc.o (drivers/net/can/ti_hecc.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:d43992843dddea5eb6d0e618759db726469a7b6a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a6319f2fe27b8fefe40757d3797cfca30d43ce3c



Log excerpt:
=====================================================
drivers/net/can/ti_hecc.c:396:14: error: implicit declaration of function 'BIT_U32' [-Werror,-Wimplicit-function-declaration]
  396 |         mbx_mask = ~BIT_U32(HECC_RX_LAST_MBOX);
      |                     ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68a325ed233e484a3f9ea033


#kernelci issue maestro:d43992843dddea5eb6d0e618759db726469a7b6a

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

