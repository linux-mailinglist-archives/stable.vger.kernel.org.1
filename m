Return-Path: <stable+bounces-207855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D72D0A5BE
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 151BE30B0A04
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66235A94E;
	Fri,  9 Jan 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Y2kjmFmE"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDBF359712
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963550; cv=none; b=H2NvpHxFvXBflxq8yS3AEZlgW/3TCi2HMSSqmcbww0CMIg/uWLRZ4S5dCNenKswM0gxo/B8n2CgfvHU9kwuUgp047N+rkzUSJhjI5bmwQTKb0ypA9Iea44qrTE/p2tRjjZPCdjnOiKX4oi5tPc8HL424+f6Pn+mMHH+3MD9nGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963550; c=relaxed/simple;
	bh=Lj7FW/Ss02uEjzkvInMPwccOzjdFOllU0vpLKFIoNh8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=FjfG28VK7LJm1+MzpEfzd7riYxWzlJ0T5SoKmQlRX3QPgLRf8aKGS+sKTLT5ZvO6DD49t8fpMAPR1lvxhnlhhKa4SVBSl23Wrnxni8h8ys9R2icgdkYgcSsKQ1MS9TLvxZfBY7F7jcXLXWk8uGLOeazYphMLEHWUsj7vw4G+Teg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Y2kjmFmE; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-122008d4054so1051617c88.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 04:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1767963548; x=1768568348; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01UM7TA6QZjuSwMA6LlWuRLm/8SHAKfUzElv9tU3Nwc=;
        b=Y2kjmFmE4PJF3IdfuiwONpS0A2/gLmymM+yf7phdCHEsMYm4iCkOwnzXh+3hudWL0O
         MKt/H2fQA2B9EJnxigXH5NkCplTLz0Rdt+5jT1U8/KfXQ3BucZ6zwJS9+pyDe72TU4Bg
         wnYQmVvss0n64RgJBdzqaR6Kcdsrm2AcZNDFHu133gBZXf32rd4KVDIa3igcSQ/svRDW
         heD+Wq3sTTvpu48QG4FUa4fYSFYj2hyRkgwUT5QsjWVRUVxPdj8exzveEm3R20RTZ29F
         2WJDrrDjCyAGSoTREUDNsEmGKNQCMV/rh7iIyTrMV+iXmXOKh0D2OcPeb587wZNu/n9i
         9FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963548; x=1768568348;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01UM7TA6QZjuSwMA6LlWuRLm/8SHAKfUzElv9tU3Nwc=;
        b=BCGJaGvkK1enagH/lMok7EiIUscyLNNGdhIel3Y5RkykD/XE9kN4WzOiIQlRJ0kupE
         0GKzUXk0QnbQg5uOG+NU1T92eX4nRGwsd4FnjxKW4a7PmmN16fPXgK+kz1ib9QSANd27
         QynE2RCFig7laKjDanyQgY+WNYtNn+dVBUUuvmBoIyRqaj1vdFUTkxoj94oGJhHeP8R8
         LZGctZvx2m+ggehjiK7shwqsVZSk654h+BdCduhvnXkRroJGtkc0/IatPWBYVQw3x+7x
         peMU2Llxw97H0q+ENWigvnW7Bx2R7z2Tg9m72f6LrPrQxp1NLxm+xOnDu8vlZIycg+mC
         7cSg==
X-Forwarded-Encrypted: i=1; AJvYcCX0G+7x2uYKJCWVey/wlaHDxLkZ0nH8n59pm3vAZtU6z6lPrKDlk3gMAPku5OxxsT4rpgIYNgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxeXM3OcjxJfCF39oTW0MakNfu1g+TfxDemU9dz85TlcRPHBC+
	+oDc6hxp3ahgr7/eep0Wck4jPjvy88a2nQURQsK+iBwNBIpUNKz2B37jbFWOJtoCXkc=
X-Gm-Gg: AY/fxX4pAEohj0bNpnRCRTJa/stGvPnYZr4VW8qNvhm5ZPU68bjVNWSI0SGUfBmnNVA
	NpZXYKnPIWCk2irR46uVVXLGSdfzCYojLOKCYi6XEtfdM8+B4z6QEGTLI02H73+1V5VDM5K36mz
	WAz7U3dXNYy4hAOTF0n0zF4r65XYjMSe3C6B6cn7RSlulq5OoyMhvFuPqkjzBpO1DfgtHnxfaiy
	9wlCNWFcZIxaQQu9i/r9CUOKHdR4bu3D59tAy08hOlfWnT29JPorjcWAAlV0j9jPoEcsCQQKiJf
	AaAY20jg44BlWIty1IYjnQ39vjykKIrWTEBKKR+yTbRzpT01VNi94EmwjJbDjT2RKc3Z+ODcE/i
	hpp7rT0GLEtUKvWrMW+O7p+osZZPozPq86OEfyFr8pX+tjz/4/td75T0fUsa6DKDXBBj9DymILY
	pZvEWktNSNy+XhEg8=
X-Google-Smtp-Source: AGHT+IGaacjZ6NfjCKP1WrWU792hZU1DdxVpSJPvGN2H8rzUyR/Cv//8ViJ9mi6it3KejMosoEmnMA==
X-Received: by 2002:a05:7022:43a3:b0:11a:468a:cf9b with SMTP id a92af1059eb24-121f1adaecdmr11891270c88.9.1767963548283;
        Fri, 09 Jan 2026 04:59:08 -0800 (PST)
Received: from 1c5061884604 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243f384sm16566991c88.6.2026.01.09.04.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:59:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) cleanup argument not a
 function
 in drivers/soc/imx/gpc.o (drivers/...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 09 Jan 2026 12:59:07 -0000
Message-ID: <176796354712.952.12790348360913442147@1c5061884604>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 cleanup argument not a function in drivers/soc/imx/gpc.o (drivers/soc/imx/gpc.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:bea6505e24b1cadfc26a9e61cdc705523ba4153d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c4fc4bf97778e67ad01a3ca95dd8fbb05f226590


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/soc/imx/gpc.c:409:17: error: cleanup argument not a function
  409 |                 = of_get_child_by_name(pdev->dev.of_node, "pgc");
      |                 ^

=====================================================


# Builds where the incident occurred:

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-imx_v6_v7_defconfig-6960eef8cbfd84c3cde53de3/.config
- dashboard: https://d.kernelci.org/build/maestro:6960eef8cbfd84c3cde53de3

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-multi_v7_defconfig-6960eeffcbfd84c3cde53de9/.config
- dashboard: https://d.kernelci.org/build/maestro:6960eeffcbfd84c3cde53de9


#kernelci issue maestro:bea6505e24b1cadfc26a9e61cdc705523ba4153d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

