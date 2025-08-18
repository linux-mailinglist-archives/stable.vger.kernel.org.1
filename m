Return-Path: <stable+bounces-171625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3CAB2AD9B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B1C564A3A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C902337680;
	Mon, 18 Aug 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="RmLEvwMK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310DB3375B2
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532748; cv=none; b=l+jTiueJD/ZuMg6ED1/c0uEjXM1F+QYIYSWKlOCQyDPHS/NpvjCZJNh4sdmyIK8Jll3EQPvlg+72OXsuaSSmVjAZle9VPwTnf2dGxnVY3A/jG/8mP0MrtOmXrLtEsj+l9bHxAXIxHan5UWj9s9NPB4umHUs3WgkuzqdpVS1Rqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532748; c=relaxed/simple;
	bh=1pm9rmoiFoewruXVo3NeSxB7By7KzxAJCoMudOD3JF0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=AUKRa5WVv+CVBu8Grv721OAKHOj+W3W/v3TxrS8VeToMdkHnrxUxkdv0IfJ8wJPcVZ3nlVZs9UcR74yvVdzjF7YiluCg1Q06LPEQ4lDOCnisLkm92zU0h+C8FzY9x3dKp3X2+hAbVtquFBXTs0Bcc3ghDjaCq0hxlc1DmyO2flk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=RmLEvwMK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e43ee62b8so1931046b3a.2
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755532745; x=1756137545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgSx5sCZJj0oNIq0DeqiabF7sWFImgYgDC4jOCK3Z84=;
        b=RmLEvwMKKXW0cGNVMg8Vq1jzG/+PHFQMiZzmaXZzX2GzJSc5ChYp4o9eCPmiIdjbu4
         GB8xiPEzhM1MmGNLZQWqKB0moc7FuxJQIkm9aXYxK9SRfRQGYQcMxliROQK9q6Oh7Mj7
         Y+NprqI0iN3OUT+69PwgoRbnfLbJrOGW+Zs1sZEJwrOpQ0kc4H4uoDWyOgduk1cYZWmJ
         T2qjyYSYUBFkOLYewfbIq1FrUcypISOjWorbFZRULrt5VreSP42N0Tpij2p82HnivJzd
         URI/CEqxKsfhL4gGHlwzK0edsQwZjKTOnEEODf0ec8YWyjTo162v4Uty5w8Cz7MfZXHu
         XJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755532745; x=1756137545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UgSx5sCZJj0oNIq0DeqiabF7sWFImgYgDC4jOCK3Z84=;
        b=YmZXzN3vhEZp6G7A+qREXlQ8fFqvlbXgQsJ1OAzzFbCjZqoiBYFREVkhHBNGWrKkVm
         ijaLLX7Um0Gm1BhX/HGXP3GqcCO4eTRY1TH8nkh+2EJZt5knT4+KsoEHHnT6RW1Xybdr
         Mxqbd4JE3dMLoR7IjMBJ3AzmG5eElaP9tWigfJjxgiph5hYIVKTyekBL0PZRD8kQJcZ9
         Og73DH3sV9auRCMXz1PwbJa2WFGNSkdP+JR36wJTTm9HyRyZV75WLE7Cw54rVOMssYaO
         W9tVsSKfmEJjGyOXZRmCc3DTLuFz4Pl+YHDpS4yo7uJBLHzC7VZvy64RVj3dje2GFLuw
         dx5A==
X-Forwarded-Encrypted: i=1; AJvYcCWd/KDZoi5XL7YZ+V8IchgoxA1pBEdAzoEgcrA7gEFPRLSYlhfsySdtWf0prqOUgryXiloqjCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk29cNqoXklIDJ4/8lvNQDr9gLHyWaHOU9/uDzWIeFN80WDTCP
	M4Suqcad6HYAboVgI20o200P+NVuXQkTj5a6G2ZSTyXvOsgmJcNbBxv9ZvrUAUz5i0s=
X-Gm-Gg: ASbGncv9/qjZzMjxvK22fYKm8vRDrzUoLSoPgt7ldllPLivUY9CK8w/8hYnoF8f8exs
	FnogaHEHjXwuQp5ESVQODY8qUeUMmvHcks0hpCDbx8q7Z54zfAjZIxgCQnAkymO9FR/ZRv8pThj
	ODG1SEYQZIocihirD3u3cYI91GmJkmynBfH57Mrt9Wt3LSO8ftSPdanNzE+YIqqrv1J/hGkM04Y
	ASOg4lHkuRgnmP4VZLhxU4cE1Fg8feTUF8VGz0DqlqhxjNc/wzY3MShtYC+haKcG4gCT2WHfM9f
	sNd+PxbFWktghUkZv9gIg3FPtG4+/QRCjk7xVeto/PIFGy0qN9dAGwo88aKTeWRpvP1LFbwJ+V3
	jaqjUcN/IMsd5qswiBVB3ZE+B3L8=
X-Google-Smtp-Source: AGHT+IFSiOKjXhTLeu4D6BmIANd6mHr6JCjC1t9wG4nUE1lNXERQ9rFDWcVwitN5hj2qfjgBSTdVjQ==
X-Received: by 2002:a05:6a20:1611:b0:240:1dca:d112 with SMTP id adf61e73a8af0-240d2e69ad8mr18046572637.17.1755532745498;
        Mon, 18 Aug 2025 08:59:05 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237bae67e5sm1004230a91.0.2025.08.18.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 08:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) call to undeclared
 function
 'BIT_U32'; ISO C99 and later do not su...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 18 Aug 2025 15:59:04 -0000
Message-ID: <175553274409.66.18299252091625035767@16ad3c994827>





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 call to undeclared function 'BIT_U32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in drivers/net/can/ti_hecc.o (drivers/net/can/ti_hecc.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:8fd2dd605b4f4e3fdfb2bb48ed2965f305259b0d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  de81846a25749c1fa21ba68cf4938d4309cfbcef



Log excerpt:
=====================================================
drivers/net/can/ti_hecc.c:387:14: error: call to undeclared function 'BIT_U32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  387 |         mbx_mask = ~BIT_U32(HECC_RX_LAST_MBOX);
      |                     ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68a32682233e484a3f9ea0aa


#kernelci issue maestro:8fd2dd605b4f4e3fdfb2bb48ed2965f305259b0d

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

