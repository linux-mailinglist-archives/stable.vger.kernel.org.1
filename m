Return-Path: <stable+bounces-210190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CBD39237
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 03:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3524D3004EEF
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 02:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18AEB665;
	Sun, 18 Jan 2026 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="JNxwbXN4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70851A41
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703502; cv=none; b=XiL4Ce7FNnt84qV2zIwbIj8fXH77va/iIOl2hhq7q9yb9ahAUsHxP2TWNzNDCGQ41J2/h5bRKOiMWtuwEm0kwoQwGtTHIq/cPeTrbY4tKTLda5JSsNj62VjU2Qcgq7wCLqLtpjCG7n5eCycuNX42xbp9r49Ma4GP5qsEvX5ejhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703502; c=relaxed/simple;
	bh=j/Z4/yzu7lEtAL9fFRtxYBlp3NPujSPHvq+qtB8DPl8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=cwznn7XHQc1BMNlMm3EULTEDWtoTF42k6ObLJUMFDoHqVZmU2fy1CvnQ0IGXNkAUQttrgV9DJH4x18qagmw4k+4GnFlPgZpURKqqtN3WGpP115AjrgGY2tocrBwBwh+J8I8pyprhNK1mhTfhRbydjKg3tgnU3KogG7rfGKYYEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=JNxwbXN4; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-121a0bcd376so1114377c88.0
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 18:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1768703501; x=1769308301; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFNelGVEWg16HmrQR2dd9SNAcJaqH4aEWOH1KUbvtvg=;
        b=JNxwbXN4epgRXCc3vVMty1P5eoGoJZ0V+v+9MuZBj8M2aO4Dao0lr2jABcdvE2nKb0
         /sZeRJ24gM9VnFzteLeMOuO8CPuvOzK2/k36bhcfkfl9ERIYx1bSfYDqoRR3dACafEZ1
         4fWMTs1JgBIIRLxp8X9Lt2KOcMi0qxkb+tIG3AgiwKbhJT82lu8gW56GcESuZYpzqPUX
         0LlWkACv93PYdV9yp1P+niIE2sN27ZEp1xWASUfBYnloVdNUpsZMyYhZAIdBp0a0GNb2
         FOV6/Y+C3QQlQAfIQGWNcewTpfG3+BYCg8AG/odJbD1h9g9Qm085pc86Cbcn8/V9XrPx
         yBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768703501; x=1769308301;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFNelGVEWg16HmrQR2dd9SNAcJaqH4aEWOH1KUbvtvg=;
        b=iGv84A5noiD3vhBWpWGnS6lVdmyuRKRMIPFRPyiH5HlxYXvtfFbkFlL+lHyDoOM59s
         vpQqGccaquym6d/Ej5pRioEoPLWlefukwtpxmUyxL34kBQm0a9x5ZSRc3o0qscyEkXVy
         PLe9kDg1B7dXju1123ZCZn+cjqkWKEKDDhJ1LuJUXV4ojgrXF7cejrGuRw7mgj8vGeNY
         cxCYy1WbvNT2jJgECDWK3ELqC6jSpUFnqAVDj8mgbmYWK9ZaTVS/Lq+B/5jtXGFhH6Pw
         heJGnhmMGVr0v7iPFkpvmen/vqQ4DFPm+TlMY0T15IbXHN4RaYurLuiOa+jJxY9m4p70
         Ar2g==
X-Gm-Message-State: AOJu0YxnMaz3ISVJBLDcxXhNDcWl5tO/MPJV7hpcO91lqkZANX55tjXQ
	4eAao5Mfw2fcZ+kruU0ExTWq7Zu/c5qDdfDRg8+/D85XxtsR3Gk0rlG6iv0dLmG43HDWlwIa0gA
	6t5NgUzQ=
X-Gm-Gg: AY/fxX46fmk8HlolaBTYINS+yNWVP0n9A7D+VVewxPW4dlaDugTo5uhyprWmSMzhTjT
	pX0JZRFHwzg5Hhu9u/btAtjlSgqOK+FneCewGdaepvqDBckIL4jhGc+3cW/fBFnpA/NnFsWtUw3
	aPx3hU1vJtApzjjj48GABQ+0nLR0OY1m7WpmLQOdDtYziLr/cGvTkU0hR2cn4qkyrDS1bQdgkww
	bi4Z3BgDLquKxnXP2FJjnNhMU8kDw/VCP3MClRHHvOCU+Q2Vu6gU53iD0TXSA2aZLpJ9wMdiSdy
	hJzd3ZL4BtQYuUbpnoXgG05rTTBf554vKpRgHTi9LlremTK4K3A2XdwG5n+rQ/m2D235Fqlxsl3
	gBFeCzXEhnSZuzer3leYlB3JHr3g/4RhkJlJD1mOQiE18qdA45U5uPM8zjcGj7DxxK+zvSoxrfI
	4gu0V5
X-Received: by 2002:a05:7022:608a:b0:11e:353:57af with SMTP id a92af1059eb24-1244a75ebadmr8084227c88.49.1768703500488;
        Sat, 17 Jan 2026 18:31:40 -0800 (PST)
Received: from 1c5061884604 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af22aaasm8045131c88.17.2026.01.17.18.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 18:31:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 f6044d1fd846ed1ae457975738267214b538a222
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 18 Jan 2026 02:31:39 -0000
Message-ID: <176870349960.4907.1576057929286477673@1c5061884604>





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/f6044d1fd846ed1ae457975738267214b538a222/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: f6044d1fd846ed1ae457975738267214b538a222
origin: maestro
test start time: 2026-01-17 15:44:07.978000+00:00

Builds:	   40 ✅    0 ❌    0 ⚠️
Boots: 	  200 ✅    0 ❌    0 ⚠️
Tests: 	 9946 ✅  800 ❌ 2551 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:696bc478b2a19cc73ab7710d
      history:  > ✅  > ✅  > ❌  > ❌  > ❌  
            


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

