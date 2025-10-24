Return-Path: <stable+bounces-189188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B6C041E1
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 04:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEC51AA4775
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 02:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD271D47B4;
	Fri, 24 Oct 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="26BB4JSE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991D132117
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273041; cv=none; b=eANsZM7NKucFOF1/rwQIa+9w7xEO2LkWiqwM4yunT9fddeCgJMCIrfMDjxLkZZZOfnz0mkLbLG14PrusqAE9wTwiZ+0r+nP/07oShiYaDJbBHhTHuZO8kt7hj5rFSaoUnHDENa6Ugi/8ttiN/nikf/4s24UgAbHoSrlKeD69Dag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273041; c=relaxed/simple;
	bh=RvE7skZEGFvyhqQpzvekgaJr96gSgTG0kT6teYgzwkQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=qW7u98d9aP06sXmeOUe+Yg+VK/fWzwDDUQ1cNzo2WSVUR4rTNHpvjYkn3BtjVeF+aBzuGI0VB/aG9Lvs8yj0VVeirOU9y2Bt5LAlR1id+yLwlMHhGhFg+q18aahGiCLu0+Ww9hRLl1TcaaqBYhF8YCFHek9r+rG95yRkLGwzp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=26BB4JSE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1303065a91.2
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 19:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1761273038; x=1761877838; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhtrGQY7fzR4f0eHkODEED5Bp8SSeOBsRrLa+QxZdHY=;
        b=26BB4JSEHgMmUzpWpaXSKUdZN+2AdRZwXl+sipKIih8Xqx0p3hXjvD/vz1UEX7QrSJ
         fqhEmCAfR7GoOie2Nod/1jyiHICCOei0eIdtr2inN0Md9BgmyvetBV/vhxi9JKaeh5hE
         iuPjh6T60e0jz5czZ5qyS6SuWhV6uGKzkCz7A80FsKpJOsEooUkw7ZYK/eoG0uOeruDY
         ZOi1px2xIKlawMciEgkqqyrKihPtf0n7KlQG/nNdj4/74dM5SA++LMzg03am8AkFscCj
         EDNzz+HOzvYajz9+MI8y493C58g3rOCtK/YCt+C1/6JdpwTKWD959seDpNw/It/+H+yE
         b5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761273038; x=1761877838;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GhtrGQY7fzR4f0eHkODEED5Bp8SSeOBsRrLa+QxZdHY=;
        b=H+bOp5lIcqXviOwKTtzor15wXUMRMLn8p1OMth3nYKQnGTfaMUnpcQRfGF9nFFxQv+
         dgLsQ8XUrIU+SvBDfluulTNGJEq9jTj/w2QEchpIhs4DsbW2qRb00I+/Xwf+k4oWj83+
         3ygYeS/FPkqxq1nfuS5o95FXbughMHY+3ncvTaw5Lj3fjoMV+fDTWP+/w8SKZ3dudx9z
         zgq3bBST5YwJPEh+aNHYxHO/5fF4A7122flz1wi1nvSHpjov4x/7Oe2l/xO+N4z8FoeX
         3UqbGKzmIkUnqKeuNbpCGMCcsEW7w1YnR1g8KmRUiImhEH3lKen9qi+o3DHZNZbBqVgV
         iqKg==
X-Gm-Message-State: AOJu0YyEeBD+RI2F6NNHYeJ3Kv9v24x49hS86wTZm9VJ8E5Ffpi8J+zf
	65S50Wy95t1d4oN9FpOsXn+3zcfTclRwfmL3aHBziPg0CkVdqscy5Wp9GaUEsJkKESEfFcEvV/u
	zv9XvmIM=
X-Gm-Gg: ASbGncubFZQTZgxGOZXmHvWs5KUPE7fFIycofWkTSCBtd5jTzHNLQOfvjSl4LWoJszr
	keif2mq+yVbqpSuv+NxhwOs6klnvoO0hwAs2+WGEBbQvgiDlnxoDQAnd9uzwSaGaWm03OoAWi4d
	9uHoOIC2N17fyndGa88aVcyvS0NtuFhUd6fD0L1kbOBZYxp8U1vYfJI+iHBmlgWi6V95YwsV5E8
	oXHTgbwBmR1qOLN6Z+Y5bI2Ev65OWR1WFdSizn/6kQey2RIKini8mrUypNkdl79Vol2WVMRVJSk
	E/sTRrwRm+ya4p27LZ4a55+4xXoTKpHX6juNqirm9B8nQDfHCIDa1ZvQJ9Kv7nBR1K/VUYK8vEz
	KDf9OiAZp2F/COHEZ68AA1vM9iCiQP6ImWNdAO9mUt1YO9a47moAaql0s2qlKZb6D3BigZg==
X-Google-Smtp-Source: AGHT+IFp97wHGUZQQTCDqi7JV9+gOo2NN0TpG34hmWkyeSJb27xvp4I3qnOQjEozAQVs/hHZdKuJYQ==
X-Received: by 2002:a17:90b:5111:b0:33b:c5ce:3cb0 with SMTP id 98e67ed59e1d1-33bcf8e4560mr36723399a91.20.1761273038389;
        Thu, 23 Oct 2025 19:30:38 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37b0csm3990595a91.3.2025.10.23.19.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 19:30:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 4a243110dc884d8e1fe69eecbc2daef10d8e75d7
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 24 Oct 2025 02:30:37 -0000
Message-ID: <176127303726.6187.8432386376299563136@15dd6324cc71>





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/4a243110dc884d8e1fe69eecbc2daef10d8e75d7/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 4a243110dc884d8e1fe69eecbc2daef10d8e75d7
origin: maestro
test start time: 2025-10-23 14:29:15.250000+00:00

Builds:	   38 ✅    0 ❌    0 ⚠️
Boots: 	   87 ✅    0 ❌    0 ⚠️
Tests: 	 3955 ✅ 1454 ❌ 1053 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: bcm2837-rpi-3-b-plus
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-12
      - kselftest.ptrace
      last run: https://d.kernelci.org/test/maestro:68fa5f798a79c348aff889c4
      history:  > ✅  > ❌  > ❌  
            


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

