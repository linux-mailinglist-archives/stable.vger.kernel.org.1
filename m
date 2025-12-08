Return-Path: <stable+bounces-200307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A122CABD94
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 03:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C95E3006F54
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 02:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0FE2727EE;
	Mon,  8 Dec 2025 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PMQ/5SMP"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C12257844
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161008; cv=none; b=MTP+G4U2AquCcLtFuCqqCKD3jXzy93fGHxRhRiROIzxjYvGOMXb3UD7MQaYh0Ei8Jv7Y+JalU9VY4c69fHtwr01lhnLUyC4LWB+6MwDuVovCZRVGSqNCh0v0uRx78MxTTz2VPE2Ge2TRoGXYks9m89YIDV88Lgdfr0Tv+lNgxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161008; c=relaxed/simple;
	bh=u0mRaKs1I2lHnNAOENXeXd3nXeWnmIoy1+mZdAUJrdU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=m9t8eCROjZxJvdo8glx7uZlceVKGaMDwRZyx6vCcbYHCc0ogit2ck3q0Km9Tw3PTsfpVZmqRC/lK6G1QoULg/Uw+K8wYnNYqfviysUripgreRRVIa38Q/zoZ0eJe6ZJkhDPqxgZlUBmI63x2rB2ad9V86DS7zb1obELhEQ9+j+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=PMQ/5SMP; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2a45877bd5eso6085172eec.0
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 18:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1765161005; x=1765765805; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwk5EKq/m+wkf3Lsn3Io60KCeysrkd0YtBb0WbZlb1Q=;
        b=PMQ/5SMPRn/d5NXAbo3+xL43hZuRjBvRt52miDL55RVSqd5drLoRa47IiiTSSNTVHU
         3mnw7d0CeMSJfKz2R0drnkW6hj83e4iDg8BbyFsr311S7FsmSX05fhyvZkq07U/kdTB0
         ASpOr20EPSUirbXvRP+duBH8dVRux582YLIt61h8QOXqLtAbkuFpAcKLGRYqAc38OiCn
         9YFSvjsMvtVw0PM4l/XGL7KdyPZqLCx3MpundflVCCZ+ZplkvKwE4ux5Ax1AgyZo8VUo
         s73Maq/YS1aVn8A4HkK/NCWHn6TiPCc6mLolTE6MCoS+SJa7aBzZwnZ5nCBWJOStFpQa
         YKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765161005; x=1765765805;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwk5EKq/m+wkf3Lsn3Io60KCeysrkd0YtBb0WbZlb1Q=;
        b=a/qgDKmJ9aaiCyi/sQ4zLMNOggXAXXUjyr0wAkbrNWhdRXDaJi+gTPMshC6noZn9fg
         ihDznsmECs4fArb3erDHHwCuGn18st6RKy9ssYu9MydVdTk9Ww2WwOfpojwpU/h+gOOI
         xOxYoeb3SbfBdGsjcIZ5u9C9wP9czBuHSf5H1CkPI/+h9gBr9+xWRVDMdrDcTPuq0yaD
         FZQWofsSQpNp7uqChwlF4IsmKhRK/ysLc4Ayz/Vr+mZWievV1H30f8uVlhqMQLPuobHP
         bRpIktJatn/zrx4nl2c2Y9htDYPvH51BWQwhuT36LlDLgZr5yrTvXosNtSTyAYvbhPY+
         ww+A==
X-Gm-Message-State: AOJu0Yx02TobQNIQAfGRSRfyky5NqiKJpAJPSAspaQarE/TtbfHhxTEr
	w7iAqcAbCTqF0yn4RXrXVSDQ/md8qCjj3jU6hcbO7ANAsiuqD6pp5HP6uWMlIF14Y3PRwsCg/Kq
	O/9zpywQ=
X-Gm-Gg: ASbGncu42MHAc5qdBJmrDnC5a5iKJzF+FikfGaCVrV5F3bJ16Ek0cZa3Hp3pLph4I0a
	7/Dy4t8J8Wk766rP/1t71ngzbgbeFWDXNnv1tRu+0R7u8EIGLDopuKDMtO/gVrtFHKIHSBC1k3c
	WscAOIifiCrtkrf9pkh+e8ScZQvzu9QXWMIQjIKLT77iAGpulNwk1j5oeRR7/GjH4QDu2IRcJUg
	7k/OMBklCdp7h5TmiEjmGPiIMiXVWZjsceSjHWGhcDW+xjD/yDr1ZFZ7e+IhxaQTyQvg4psu7Xg
	eZoPnKNxHloJGgsivhSlqXdPfTFdXigTEFGXiyvkkkTj3sAVZU/JLlRgIp19GJjSRYOKZ6Vsipq
	9VeTzzNrd6HOj0YcxUat1JAUHpr7tA+vnPFClbVqWYSZGG925GN833gM2QV9ELcDXrbne/9RwFq
	ZEJusc
X-Google-Smtp-Source: AGHT+IEnOFva5+wGIc7xNMWzY81xxodqTgH02Tvm8n7WZF0G8pl2jd4Mg0N/hhuDvY8Rx3wMadOb0g==
X-Received: by 2002:a05:693c:2181:b0:2a4:646c:e096 with SMTP id 5a478bee46e88-2aba316e26fmr6624629eec.0.1765161004966;
        Sun, 07 Dec 2025 18:30:04 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87d7b9dsm43329246eec.4.2025.12.07.18.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:30:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 5fa4793a2d2d70ad08b85387b41020f1fcc2d19e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 08 Dec 2025 02:30:04 -0000
Message-ID: <176516100399.6076.9654441713029194097@1ece3ece63ba>





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/5fa4793a2d2d70ad08b85387b41020f1fcc2d19e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 5fa4793a2d2d70ad08b85387b41020f1fcc2d19e
origin: maestro
test start time: 2025-12-06 22:05:24.119000+00:00

Builds:	   35 ✅    4 ❌    0 ⚠️
Boots: 	   92 ✅    0 ❌    0 ⚠️
Tests: 	 4404 ✅  350 ❌ 1689 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6934b2071ca5bf9d0fd63f8f
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 4 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

