Return-Path: <stable+bounces-194428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD52C4B622
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 04:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045FF3B5B99
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 03:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF55631282E;
	Tue, 11 Nov 2025 03:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="QiKm5/TQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E43128BA
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833549; cv=none; b=FS2XbO+P3CTkd0EyQRpU7OloTOyNzKViZ+EWbOtGRx6gwbnqVBt2kp3ZBblZ3EJMyPPJlvUC29D3YP9o6kmQM+j+9mnVtediehsn0Z2m4LG1cQaedGk4nCwRypOPApc+378CfaEzu8AjtF35VrNKJfX1y0+L51bU5t3MWz7pQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833549; c=relaxed/simple;
	bh=1+Ug2Q69EOYHJPAgGjyoxM6GFLVJ3bLwPDVqeoT4HLc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Mv6Duv0VONmePHYB09fYf+g6lHPZDJ7ZPD2a0tenU0HUD+8qkqQ9rhBZOMJ+lh2HOBjSQBcrh1Y0Eku7744+Tz7j4J1ObCMAE2WpZh4Y6pY2eECCPwxQAzSeeNSQeS+CbCjhquMlwOD9xieP0V+35Eg1J3l5Rt+A2gWqMz5Gsbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=QiKm5/TQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso3137393b3a.3
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 19:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1762833545; x=1763438345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDbyDqVlSaOe9pQR3/46i0820Q1XpiNprzlDRf7Kip8=;
        b=QiKm5/TQzqsF1QYJaz2EwzOqmAFSXQhrvWTil2d05XOTPrcH8epDmS3hftDeQF05mv
         OAoZqGtuqdhmpY9RCSowV9dNDwy7CE7BOBYmIFpkCJy8DP4ffvmo1B6MXd2FuDwkzo/y
         LJJjgP4GceoBIEQqlknm6sG5yHDfp2YF5COiJfkEqDoEW/6eEnPd/93ZSwcbIbEDjj/1
         EMZ8VGXB7f69aNthVxYRIJNP6LrpfGiwx0nhbnxvvUE/wxQFz42/Z7VAAY6HIDhonKu8
         xplIUMBx+Q2hzt7sFBuXUBY3quMbvRVQp4blcLp3DTGRn0fDV/kbTlTV2pE+J0ccax94
         2tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833545; x=1763438345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDbyDqVlSaOe9pQR3/46i0820Q1XpiNprzlDRf7Kip8=;
        b=h7JMRH0r2gemOxVgDK0gwUJFFkLjjJ27o5NEMgYQJcex+qf/2ldZcpSY2XlFvRBnW/
         juDAuF9fhjZO+M2yqoMWr7QxRHfXVBFDUNz0LIc/xS729Q+Xb7L2BbBmLTlQDEAEN5l2
         IuutNrPwEg6pUnYYkHY9tQ5ZSBVaGrEeklpLgrnxYwaR+kIFSU7tWDweodleRtLXfMHD
         b9phslAz5wIU4eMc69xT9G3iyuuim+FXM3ual8xvOjInglRNn3mrT3j1kKVIiJ2OgjaL
         vB65fCnSvt54Lev3E6QcA3PfLlpjkx0ML0BbyotymXOdtLoVuFFV7MmN4CWowzpTRs/T
         siuA==
X-Forwarded-Encrypted: i=1; AJvYcCUbk1i70kiQbgFhiFuiLfIeCv/PUPVk/jIFx22Zi53h227uMo2OT4DyTL5DqsAnknBSK9F3dQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+P0nh5dJgQ2GO8R5pnlJnYSUeAmWN0ZLCIlNcPAO9Gol4Xz7
	HfZkB4mOHB/Y4Qe+vh87LIOJlQFsJH4V2UjKrNRgBDksIJaKnrTMuW2QvQ4psBXcCAE=
X-Gm-Gg: ASbGncvCqPmaGr2jFk99+sGl9qUru97QDq+WW9eMZms7cSU7fMmyL/mo6jLmg7tbpLP
	4uPCtzXPAsIwOoH7+0PicQ6gmu+T1MKxeAmy4U6HLpdM75oajlgl3iOg9j/uZccZF4E6KtEUldT
	AVlQar2puANJMLttU2G5ugQyDBBxY3nDCTfEJIWH/Dv++ZFN6uOQLjyeeobcYoVwO/rK/khcBmU
	GZEUK6S7wkMYE9j2wmatGrqQBqJB8Zhqk/un3B4zJiwXRUAqQcPQ7usl9dmbtlJrHtZEDmCzmwL
	kC1QKaVLzLWJP/Mg5lg/0XGNb0UEScMLO4UyJS5EUHZtqZmTEnBtewGeeiX0ekJ0L6+xhX4xyvg
	uTIRmIDHh4PnNlxuqcUkL5Echvw0bjadJQtcDgXinZ9MlwobogpcPlTJbd1tGlF1Ua9vZvQ==
X-Google-Smtp-Source: AGHT+IFIyui3dAYvuDqioGOGW0cNCh8Di7RtkyzD481E47Dw0AnD6ECVEO1h/Pr/GJ3FIvU14N5nhA==
X-Received: by 2002:a17:903:40c9:b0:295:56da:62a4 with SMTP id d9443c01a7336-297e56caea4mr135473125ad.45.1762833544985;
        Mon, 10 Nov 2025 19:59:04 -0800 (PST)
Received: from efdf33580483 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94ac5sm162617515ad.92.2025.11.10.19.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 19:59:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) clang: error: linker
 command
 failed with exit code 1 (use -v to se...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 11 Nov 2025 03:59:03 -0000
Message-ID: <176283354336.6732.15126013707916076951@efdf33580483>





Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 clang: error: linker command failed with exit code 1 (use -v to see invocation) in samples/seccomp/bpf-fancy (scripts/Makefile.host:116) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:9b282409ffe9399386349927812ed439dcc91837
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  350bc296cce9fcac34ec525a838f99ac76e33550



Log excerpt:
=====================================================
.o
/usr/bin/ld: cannot find crtbeginS.o: No such file or directory
/usr/bin/ld: cannot find -lgcc: No such file or directory
/usr/bin/ld: cannot find -lgcc_s: No such file or directory
clang: error: linker command failed with exit code 1 (use -v to see invocation)

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-i386-allmodconfig-69128f652fd2377ea99535c5/.config
- dashboard: https://d.kernelci.org/build/maestro:69128f652fd2377ea99535c5


#kernelci issue maestro:9b282409ffe9399386349927812ed439dcc91837

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

