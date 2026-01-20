Return-Path: <stable+bounces-210420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CED3BD83
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 03:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F58E3001CAC
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 02:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C840855;
	Tue, 20 Jan 2026 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="tBL5B+gx"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5161367
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768876249; cv=none; b=b8NdE6nghV/7b65GxrOLu/KtoUjk9LZUtxgO85ZAf9q4Rnc5Jh38vdTF/YodfZ8i0AFOjIVaMBLIRO1rJL1NkfE0NNo84yBSsDQ9WIq2p94zSyYa67UUDh/c7nmKIm7QJ1zof+rifIXTZkLoE45gOM6aYvEoz6gkjDr1woNa9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768876249; c=relaxed/simple;
	bh=b4eQnGNk7ZCBJjcxvrmNQO9sbYuokbFdBWMpMj3uoMg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ILmrGWFcfkRuy7KB1brpQaA1vaZlNUwqtqsQY6FCb5R7It3TXa4N72WF2P9FnJELoLaTpuOq+cnnpH2b30J5sSAdCR2zvClYCdLQ7g/WGpRdtm3X/Xt0KicEhlKiKwWPRioQzaEt3RLZesh/a+CyA4BELq41VBZoh4Sqb58NzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=tBL5B+gx; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-121a0bcd364so6029682c88.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 18:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1768876247; x=1769481047; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOi0WhAwtDCp28yZfKM40mEnXTcYCBIipsDMWZ3s/Bk=;
        b=tBL5B+gxLGh5CXrKHEt2Lvqp2o283fDz1+7o8I3+t+NnoZgXa/FpH4kYBOTn92yr7H
         xu4LnDIMbl3CHvvX5p/ppLbsWh5VR2fwWcLJDdPN1LYgKDFnUsslySHIQPT6O4Rta0e3
         GnOgbAZR/UpzTT8ejcgtnVURUu/dMSSfHCW92+h5BokEokAsU9LJKdvAuL/Xx0jz7oZ9
         qlob5YybTQN/IzJW7AQtEEmS1JPzFuuK9T3XsToyXrSIVnbwi6tinFarHA7m238wMusa
         nyLqPiU4xwb9hVFStDLs3LhTHm8ogyNAKwE0xy3WUuNJ0Pv8MaivaWNeoeoL2ovWWAvL
         zVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768876247; x=1769481047;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOi0WhAwtDCp28yZfKM40mEnXTcYCBIipsDMWZ3s/Bk=;
        b=uHySBbP7oXWsX7h0M8ANDBRuchfL68duO8Ifw8+XjqV3YivfwfqpclWTt/Wr2+od2o
         W2h/zPgqbttujZniqBVl5yT8R3+C1Uh4pZN+0QvI+9rW7+BnVKWiz4uTjF2x/raFQdgq
         LAqD5EllOXM/KF2i+YfB89lDe+tz1x/zgCnhPN5NB2L9Doq+dIRyzPdXqu2/yGR+a3qv
         EMaLzcUewvPBf5UFyovWamdYizabjUq3btKRFKWKYQbBwlewLqdB2NNZHrCE6owtPIsD
         w9MZ7ApEFk//1+D/jvgIMdxRBvgAZlsn527sbmlZNN12Sb8dhhkf8gQinheixYPW8+//
         CkYg==
X-Gm-Message-State: AOJu0Yxrw0wNaPCf1Of29Fd52KPoXTwck+z/t+4EUC+llRGM0aWdwVKU
	zshLunBty5XduJo8ANqIFJmdEAMMgigLAOVk7BCjaiGRxo2wSuWNgZ49gbsJIWXC8/5sQmnDTuo
	SInXSs0E=
X-Gm-Gg: AY/fxX54sCObyqYe53I0xr6bn5/BX1Wa/saNdQVmviBGJdkcvOuFOGeMKOPjxu6TJ6J
	kBpklWA1mnh8ftund4WeOqoHCDLCdpo560c8ChiNBk9+qZTFmA/kF3eUfeo7UDJ0ImcHAhULUii
	mCd9A7JQNawAvmAxuvuyXiIHEZIGgwF6FIAPUZqHEArREk34rySzuxHYWK12SUAyDn7ACOxfCkT
	Ho/q76QQ3gRR3qHrlrsrT1gmC1SKOInkES+mep10QGH1bEpXdjAQmO4FWvcK2i2phDiH4cTK/wl
	C1OXVEZz9Ys4OyFH0JmvhrfWtMPTszZ6ZN4jXTAM6EZ2V0f3hmuKb1L6tKrOs0iSOZAenVVwyqN
	jTRezrsVQK7FBbgEEjgseUvI+jnXxwC+Bwem3GwZiZkbvko4CeZuK44iHDTCZISWfPc2FZugVFu
	/ZslV5
X-Received: by 2002:a05:7022:2208:b0:11b:ca88:c4f5 with SMTP id a92af1059eb24-1244a776fd6mr9329195c88.35.1768876247430;
        Mon, 19 Jan 2026 18:30:47 -0800 (PST)
Received: from 1c5061884604 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244a8938ddsm16298090c88.0.2026.01.19.18.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 18:30:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 9260a632f76e4743a6209992c5c22919e749ffd3
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 20 Jan 2026 02:30:46 -0000
Message-ID: <176887624635.5829.15800107825979483522@1c5061884604>





Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/9260a632f76e4743a6209992c5c22919e749ffd3/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 9260a632f76e4743a6209992c5c22919e749ffd3
origin: maestro
test start time: 2026-01-19 12:41:33.123000+00:00

Builds:	   37 ✅    2 ❌    0 ⚠️
Boots: 	   63 ✅    0 ❌    0 ⚠️
Tests: 	  960 ✅  262 ❌  532 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:696e3048b2a19cc73abab41f
      history:  > ❌  > ❌  > ❌  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 2 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

