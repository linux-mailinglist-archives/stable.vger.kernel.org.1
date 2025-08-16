Return-Path: <stable+bounces-169838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D38B28A0F
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 04:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98A2724555
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2282419F130;
	Sat, 16 Aug 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="jcdBCznT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C89478
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311406; cv=none; b=glejVHOIWgkakWVcgmyuqtK2tYXf4+4BEfveL0s8rYdQBHcBaEXPCd+JqFfTtHkDeXV//mt2Q5lL7R/NKzTx9QKNhHPbOVk/Z8XWnYUXVGwEdaRFqJ3wzQ37kIxtuK6wQVpj37aMJj3qvj4A0ZsepHFfqbkHUXCEuGYabbJNX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311406; c=relaxed/simple;
	bh=zkpl3RvYW9vZIhF1QcMRakKzIZJ/eReyzMijSotpE/M=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=IKc7nDg+C9Q5FP3St9uRNot4iwG88M7+odZZEz2W6QpPKQhX3Uyt30pjIKoFRB5h4xGfSQJ1BGNc15RlRzU6XzzClhioDjvWeli5we8K31lZ64kEqI29ofqNJwiWN0cR066gy7xSEmSr8fhud6vPPQZY6UpiQuBSxks4HAsDkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=jcdBCznT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4716f92a0aso1779972a12.0
        for <stable@vger.kernel.org>; Fri, 15 Aug 2025 19:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755311404; x=1755916204; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSr3W3ICBMR9CG+/IR5QdxrX7PAISa7cPI4b3E3vUII=;
        b=jcdBCznTaV2O37F8umDFKo2ZZFrgxp8gOEBywCkcjdJVjvwYFdDZmlSMo+axKX6sh1
         QfCVarICx/mKH3cVVxrseZENKSsEPSL0rKt9h73yB89VJlhaIjHUdZz16fqHSmOEzmtD
         81ik5yDkvVqnZkF5aF5+qx+SuRGUBdynR31/RGrj8yTar2VoqXwwuBvIIUj16xIrZtdq
         l5P1MOlmX72wx2ydQvbdnsPkqKm+a2K4PY+tImKK7ZUo7sFEXKuUxDSl8F1GDU6yTuND
         03H8p4+bqtXYfEbroaiuEHZvpPH04iRZ6vMlj2FxMGitovVHHXWDP/S4dqwpo4MVTXJa
         BWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755311404; x=1755916204;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FSr3W3ICBMR9CG+/IR5QdxrX7PAISa7cPI4b3E3vUII=;
        b=Oaxm8sAUthgPUtrZgs6iL/FA07D9UYyHbG8qINSmZwohftBXXkOaUt4E6N9PxoxCw0
         7Or521qTdNNoeD/WvBGoyn7iqfldhI53MWEHPsKsqLM6RzGnOIPcqUFnWNgtXiruwN/F
         RzK8PdbyxcZ+cGCXrg694siFctMmZgTEfzWmpbqKg4Lp9vnNk4bPzK/cp8DYn4IHeu3Z
         lBro7RSASeJFI3o6g0CyAEg2B6CQ10EBgIZH3+IkBXdknblySPJFX01aNlyKuGrRaPS6
         j47TaVfr4rZVUanwHX7GmyG55jy5eKqHrWQL97A80Dugxdrda6aXbosVR+7tB3w0IK/0
         yfog==
X-Forwarded-Encrypted: i=1; AJvYcCXHHwTM485SOgTtPIWYXfvvh3axH/GhxadIPlQXTwduXdrEMTvhV2Ec+U8Jh3griGj+W2tlbTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDW31zHpvirYKKhGmHoPsGGxPN1lM2TnsRNq0XXDbhrmO9qFxW
	5YivzDkpTQXsJ4r9jH664n+Y4ON277KwBuokTnK8e/az4mM64T4ZeSMFoBX7jOCIunBkp99tFSq
	geynC
X-Gm-Gg: ASbGncuNxZz0/eCorVRSvlzb920djkGRVTw0hDHXhQ7wYbJCdmdME7nz2hrDUoJNS+t
	M9i1Wy0kn2WDX1/gKXLuBAXwR8oUy7RX/dhJaj3i9Dz2roGzW2yZMYjjKMMIgkGZRIhkdU/WWSu
	hBba9cnoPG3JqPVHL5Dh29K3WEYnVPb6nswiU1iBEctwloljkdAauOEuGhHGvUT/MOj48QrvJ/o
	MW6hRi2cQtF8GtyjMCT68S97Urm2s0lDRkV6e8fjQPMbUkZarUcUtyG6TzhR/3Z1QS+Ft6VHn3E
	LgcbgLYj19RSfMDsnihaL7gT1eMfoKhggb8wZz1G6/pYGTfU3mjX4AV+tIyPNOByy3w2lNbwcYM
	vrG+AmTzTWmdu243X
X-Google-Smtp-Source: AGHT+IHWlnokVy46f0XMkdCmSn0bZpHhcg8H/zli3q1iDxgw1fPfd93MgWJa5jFssArebLq+aRtSyA==
X-Received: by 2002:a17:903:24e:b0:240:3c0e:e8c3 with SMTP id d9443c01a7336-2446d95208dmr64388815ad.51.1755311404425;
        Fri, 15 Aug 2025 19:30:04 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57e140sm24740285ad.156.2025.08.15.19.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:30:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.1.y -
 0bc96de781b4da716c8dbd248af4b26d8d8341f5
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 16 Aug 2025 02:30:03 -0000
Message-ID: <175531140304.276.9848729835889583253@16ad3c994827>





Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/0bc96de781b4da716c8dbd248af4b26d8d8341f5/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: 0bc96de781b4da716c8dbd248af4b26d8d8341f5
origin: maestro
test start time: 2025-08-15 10:52:19.284000+00:00

Builds:	   44 ✅    1 ❌    0 ⚠️
Boots: 	   35 ✅    0 ❌   24 ⚠️
Tests: 	 1994 ✅  166 ❌ 1054 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
- boot (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:689f28a2233e484a3f98e9a8
  history:  > ✅  > ✅  > ⚠️  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

