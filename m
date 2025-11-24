Return-Path: <stable+bounces-196686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C879BC80595
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43C63A587B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CC42FFF8B;
	Mon, 24 Nov 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="irzTKE15"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCB23E320
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763985547; cv=none; b=XjybEIC7qYMGqdWd5fS3GBNE8l0WUYc6X/wKRkBI0RS3ZcCMhbPHvZx4t2Evjx3NrTxu0Zrz8gS79aQcQve6ZtwfIz11SEgG9+M4LmSeDA3YYBIT7aKLhDh2LY2C+IDvOWK5j2P3sv9sXrO3HCk+MLowNDDpqr9y7ccmyTm/SgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763985547; c=relaxed/simple;
	bh=cv39pNx5bwpZPWFe2e/l1kvW+6yH9iBZveDaZM0zgUA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=dWbM8vFv7hnGzqTcIUBIyrWov7Y+/1Nwv0rooMBRuJ/gxuJVpCs9enrqGKPb5/OVR0Gh4Z/gPAbcQ6KgUmYq/HrGv8aKNnJHsLriFLj32OoDBGGYVl+cidoVphNsoUmeR+KJVw5qVUx44pHuhIi2pxAn/a/iVuhSaoocebdM/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=irzTKE15; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso3099266b3a.0
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 03:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1763985544; x=1764590344; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwv09SeR1tqVwZ0dXsfagCOgoMj1bUyBIE6I4D1+gr0=;
        b=irzTKE157JZypuRraQ9gr8oWBeVcmAeuNNVRoB1hjZg7306lgtTgjEqBMrwpx1bPPy
         DZ2wVcLYDT53C442PUFRnbigpYFISiKWWgE/g+f5kuZOtCGVX1t3GKvOuQAvNLPQiLlJ
         0kGPvFmrypIgfSbOKubbVh9Uf6DgecNhBM9Hwb83j3zfzR56s8d5YSF8cmmilQDSB2b3
         FgHDa/J7c8s9TiBvl8hfkn52S3GKo46DTJLTauTG/UTHELOIwgBieO5G6Q5oSqx3QFYh
         ypU+13lvW7Xjcrdpy+XZGYtfnnSPyV7ccGP2yV7yAbHY2uFeXfOOijo41o2S2mIJ9K30
         t+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763985544; x=1764590344;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwv09SeR1tqVwZ0dXsfagCOgoMj1bUyBIE6I4D1+gr0=;
        b=kJ/pZ5cFjCyGSoYkRjA7JF0TgD39hr0YgGwE9dmCeGosKDs81kSt2UO5VmvPNrec29
         smBMHBUdmvn5KhZmpHjME4nrOeoO15Onhyk/37tUgXww2rQs6c3u9FSGkEBoO05uiu7n
         CagE89xZNlZsmQ/q+kyTy24vZbWj1LmM2QEYmTAFMvSQqhGYYDHHMgo6o6jKflOWtmP+
         oPYH63js28MnoJGTcTfEAvHU51+ubcfq1CHCHs1XxqZduHdCJbJ6cc7eVbMkRBcgu9gg
         LF0DgQjl9zQIOrFv6aKbzonfhvJlUwOoL8NWWrWRaRvcelfjWnoMFnxsePWvshXdxGyK
         pdng==
X-Forwarded-Encrypted: i=1; AJvYcCV3Dyncm/eWklBcdfrgxd8nt/uu+rlU+Y+YSI3LsIlwHLmNtnJP9LbO2bnvJw4s/zXbmlrZUvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5r+ln5WpydlEcKh1smS/p3NqD8O/PFUy8j3q19AEVdggj8TOZ
	vLeX0s54XqlFcW+N75rLW2kIaxzlnC+3v/syt6Nq0ohY3mmeX4Qn81kdTDQ1F7lOWBI=
X-Gm-Gg: ASbGncsYaw1ACfbdnvJMqs0CncYHHKh0bc8KERZ3OgdwuFCicqb3WLtmbcT12uZ89BS
	f9VoRFzzSTqoaUUmkbbvaRb/wXmgL3qJamYEHQfhvnBVUdJw9SVix5i6lS3eM2ka7rPnOXKnitf
	pGCpVriirYPWt24KSow4qZog2ynre69KbLInavl5QZ+uibOH1j/xcYiZvqnqCrwF1Fn80SjXCEp
	qbqWSKkpQtG/ydjonIUxAlYRQeN21JngPHbBpT5mXfxoWihoVy/C5M4mTxbrUrUdPG1+tj3tG/H
	UaIgE8s3CslvI//GQ67apXjFuMauU3LVirKU//NLjYXHDnMJjFOPGo7kCmepzyJHp6Kp+yKFoQ6
	Kb7K6rnch/Q/7EN/UdOgyMdU7W/O3q7HgyGqp82UbauhPjljGJnN3BinuegyD4ypcTxRhLjWiCj
	oBtPA+
X-Google-Smtp-Source: AGHT+IF3ByHI72ouZiYSLsxsbygSpuV4tGAt4V6c1gM9J/oPddGcP0kxG6eibU9fqK/SV5oSegR+CQ==
X-Received: by 2002:a05:7022:52b:b0:119:e56b:98b3 with SMTP id a92af1059eb24-11c9d84d449mr7756260c88.26.1763985544583;
        Mon, 24 Nov 2025 03:59:04 -0800 (PST)
Received: from f771fd7c9232 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm73235254c88.7.2025.11.24.03.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) in vmlinux
 (scripts/Makefile.vmlinux:34) [logspec:kbuild,kbuild.ot...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 24 Nov 2025 11:59:03 -0000
Message-ID: <176398554333.70.13778131235511093574@f771fd7c9232>





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 in vmlinux (scripts/Makefile.vmlinux:34) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:35cde1a01734118c6b52274afdf25ae5a8a9dbb2
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  d5dc97879a97b328a89ec092271faa3db9f2bff3
- tags: v6.12.59


Log excerpt:
=====================================================
.lds
Inconsistent kallsyms data
Try "make KALLSYMS_EXTRA_PASS=1" as a workaround

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-kcidebug-69243346f5b8743b1f5e53b5/.config
- dashboard: https://d.kernelci.org/build/maestro:69243346f5b8743b1f5e53b5


#kernelci issue maestro:35cde1a01734118c6b52274afdf25ae5a8a9dbb2

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

