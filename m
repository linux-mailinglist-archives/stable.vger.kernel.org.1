Return-Path: <stable+bounces-210189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8FD39235
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 03:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2713E3004EE3
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C65BFC0A;
	Sun, 18 Jan 2026 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Mm667aBv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF63A41
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703446; cv=none; b=gTZLI/xluOkdpi/efHwBM6D3tTBbzGEw5RMOob3mNw0DxHSIOe8LCCkM2XGHND7WVSbC5jMbXnAFgXywWsxY++44Yn41Uqikgcb4JtP5+FL/CJ1vJe2Rh8NHdnjA3kpqIIvUl3fWGONSL3ltMSDDk8UT7iai8Td3+HZayraZZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703446; c=relaxed/simple;
	bh=oWXY41CGub6auulSXFFCZutvPc6mJEeDQvBQPAOfXRY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Sawca93Rb3b3mAwDt/AMkRFifQb6bgAxv1M1+0z/CbgSUFsHqmYaYLiCBsM2erEjx1CO5bC/Kw7bOFRYpnbyc3MECj+LOSLn8sCwb2PQ4uCqB3547jmyqmbHeJpL02TcHQW75/lhaEy94XnMkpulaCHi4Y1TbiUVA7amXu56yOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Mm667aBv; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1233bb90317so2592582c88.1
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 18:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1768703445; x=1769308245; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCiXyUVceaIheBAentoRz8SxRkS/v840K64qdyG1JQo=;
        b=Mm667aBv8PP2QnVZ0T/ak103xZI0wTAtF3yIP/CcKoYZ233xhN9wuT8HKovJfn0Org
         Xu7Ew7KDWCeVRAeAZjOhd6hTwaS/JdDchhVYEI5448wbHSXwadt4jiLWk4ALnq8tDU9Z
         65x1aZ33rVXpopzsw/nL9CuCE/ZURHTG0hjxUba+N9qO0tpbet0944CYPEkBJZ6dPvW2
         uGKFrtoZwfVVft8teJzuxs0OLe3MKcyOBvrffY07yFfovfg2NYZzRKfd79Tyy/XbcIsq
         tqgLq8JxLDiOcMUlXLymItCvDtNgwaF33tY/6ILTbD0fZofvLiYjwVzjP4OWEH6BFH84
         mTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768703445; x=1769308245;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCiXyUVceaIheBAentoRz8SxRkS/v840K64qdyG1JQo=;
        b=f2fhv0PL4jCY+YmQYej6UaNAJRL5j6j/q5jFVBSNeOZlCtmuO89AYlSGJ+9Pa/UP6S
         XMMUYa5u1zCoGOPIo9GsgXRSPthrco+uI3NtGv7hsRrEloPgkTiCL/UfJzmTOC7zO4Ii
         udYQvttwIDIfkLEuHUClZAPzBFz2AYlgzodWVGffLvwgZiWcTGmiyE8eL+O2eQWx5ZqO
         DBeJ/OIbNVvQgUmAgoLkiTbZtXuGta1GKWxg+8BUbZtS7iBEbMLw5XqnDuDPTLLEL09/
         nTFC1/Ex1ZIShFT2nxBo0TckfeLXtYc+yHiSF/kCzQ7ZF6jebm2HiwjsD80aT249WZDh
         IWUg==
X-Gm-Message-State: AOJu0YybHalH9m26ZaNzLme/VfqdcqMSraOgZlBvkSY3Vi0+fFi9EiUS
	E3RAsB5yj04lnAh2AySJxIFz5nz3xm5GfYVjYBv27V8/sLSEkN6rKCL/A1C1Wpd3x3k=
X-Gm-Gg: AY/fxX4IBNxERlWHC9IELMsMHaqjqOxMXwjoYW5KegoHDKbEzaF+yQvMWIy9LwUV5os
	prCPdO7dehWAUuUrwPjJhCaeU1KqqpaUt0/zUjlHLJumVjeGwvGg1vRm3/d6zRSFPxF8sNIy6Rp
	H7oL6g5wyP+JjQoCNjGRVi12EtuEdkNBhCxlqDp9gxOeOz39ANOgXoFhKxOinLEdQ/2gRm9yiOp
	WvcHbFOl03OgtKTSDTY4kSBeF2CjagpY8j7ylVFSZ0L7WYOza2T9bPYqDVs3h6+jvd4VpszQ0jp
	XzxpDR5vIaV4Y56FVM8tUyU/eJepVSpqNnFuklneuTnKQOaymm80NNHAhdNHuM9yFJ3dDvnMe6R
	Jge25v+C4IgKg5YNOjLw22v2Tv1jG/feAZzR2gOX9YfwjwS2ILzeXzbZOA/L1VI2vB+HpcC2ISR
	3877wm
X-Received: by 2002:a05:7022:438a:b0:11d:fd41:62c8 with SMTP id a92af1059eb24-1244ae84a60mr5415018c88.13.1768703444618;
        Sat, 17 Jan 2026 18:30:44 -0800 (PST)
Received: from 1c5061884604 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10736sm9411340c88.14.2026.01.17.18.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 18:30:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 cbb31f77b879f2c1aeb5e9e69823982ef2e88efc
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 18 Jan 2026 02:30:44 -0000
Message-ID: <176870344370.4907.364491736634734027@1c5061884604>





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/cbb31f77b879f2c1aeb5e9e69823982ef2e88efc/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: cbb31f77b879f2c1aeb5e9e69823982ef2e88efc
origin: maestro
test start time: 2026-01-17 15:44:07.501000+00:00

Builds:	   40 ✅    0 ❌    0 ⚠️
Boots: 	  105 ✅    0 ❌    0 ⚠️
Tests: 	 4439 ✅  397 ❌ 1704 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:696bc41fb2a19cc73ab770ea
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

