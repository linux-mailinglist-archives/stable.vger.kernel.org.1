Return-Path: <stable+bounces-198038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE1C99E15
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 03:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AB63A3EA5
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376E242D78;
	Tue,  2 Dec 2025 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gPtXDAXc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD726CE04
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642656; cv=none; b=TQ/PFyH3/38+MV89g3Tplh5ctOC1pyGw+Jme0HpQkv6AFf6ePkBCB/4CA6AV/S7w9SpaV4KaawLV36B1jUriexwoT9q3tRqrXZRvItofsUAL6lWgfcIqndYQJs8Y0tZZl/tuCHnIm37wzrvHw6/KypHjXypSTEUlfHV4n5oC1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642656; c=relaxed/simple;
	bh=9eFI+b0ur0cMjgCX1gRj+cpGwx1xvjJG7nc01gKTR+o=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=O8llGR249zFK9jItP+++Y0fspdwpu+Fayclkp8dykyCVtkv01wmK20V9t2RFmAMWg4GECYUKUgO1UiE4WneBDoUJM5x2pEO1nbp9RGdVD8k65VUsu79aCnsbgB1p6FDOXyCQZwVuCk3NF9eFt/7T0LYL2aCWSY0l3QOYHMoxUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gPtXDAXc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso3920910b3a.1
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 18:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764642655; x=1765247455; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMsLv+Ja1+aDLBEGpTFeEcb/IKhHJrb92HEtcbILthw=;
        b=gPtXDAXchZoGq5uWLaMM+2DHT9Zy0rSleZS3yfD0baw98FXu1FYeavm7+PULIxFayN
         9cn5A3QZiRJXR2YaKWMg6cLo7iS0o+ZAavx0uMD1NUkJ10ydoGDTsZSf6cxYzA082+Qp
         HQqbzHlX7Jz6m8VaTfl9iClfsnRhRu7e5PGqkjcz0q1EVU2Y/AGKBdAW2Uteif33aRqk
         cfRczyJavSmrwxMcBIIol0hFO4UhCaSuYn/MYLfCUazdAFqENm7zzHYnA5SoROwIZ6ov
         cJsG2ijg30VpYgZdeJTJ5AQgSG9E/I7z207RgR29MsCzwnWVP3bQl7mf82HV4Lf7fYW/
         Nx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764642655; x=1765247455;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMsLv+Ja1+aDLBEGpTFeEcb/IKhHJrb92HEtcbILthw=;
        b=b2s1XprdoFS1KQ2LzkyMxH6mCJXCR0WMQjAvN38WNYHTEFQDRVW5dwCXPJULh2T0s0
         C6jeEN9J3c+JAqOa31paS2nY2OwTHewYsIkMOGfrJq5yC1rtUYfKqrbSXAMY9Ubt+zkc
         L6V9WVBjGqmSiVnMUAFmu1g2tE+4l+4sV+xNBXevZbwQQw40HVYL3lbjW9xWGGL+pdvN
         oF5o77rrTm05wKZBbm3n1pyy8OulvsPivbGycZvMgvWkEbWi4uHaKPpVWdKbWyKTmLgX
         HOMDSUllQvejZDNKx/ATQN/BMFXBh+E0VZKvJn94QaWkT7sCPHf7LHRbdXGXhhgY/8QH
         ylVg==
X-Gm-Message-State: AOJu0YwKTfWlEkNm8LS7dDwGUctLj1+VchXaE7zmfYsPzj5Dd8VCmher
	FcLeCJiHytwn/xyMRnj5whqQ9R3uh68XN97gQL9lMuNxgKuQ06dkVmAaI4HBDQmTSEe/vZYQTwq
	UxZbLVsM=
X-Gm-Gg: ASbGncst6ufNrVUdH3oqmSnFzxS4wIqmAkvIVk7GMttYoOKTGISMVMJXCKt9m/zhdf6
	9cBPPT5QpGMbZnIx2ensEg6JxU06ak7ZGdfoRa4ha3S0PTG7CJGtDNxNtjCu1F/NxSJJRZnhatF
	HaUzri94MaGkAfxTRLHzCzxeuiLKv40qhPS27U8hMiAKQ/pBdj+oUSAC7Ie/peBC3ELcaLXwRsu
	B57P8Wwp2ly3IauiJziYOlelzpRedylzap2rINpMev47XF2w7A0RHo901Iq91MwOpK+EEi/Rray
	LJrMKWNf0Ym9A0QCh1E62bKmfPc90Ms8nGaxDGwbGvpNZGg8Bd5aqwlFJ+2jI+FLZoCAqqmQ6//
	eUPB9MlTw91ajXMhbHdFwbZ7Puy7JmfDiT0qJv2NXo5ATV8LV6AhqxnACrJbRWfIc47pPSRk3Bg
	C59gBP
X-Google-Smtp-Source: AGHT+IHENP686PK3Z+OjXMcdSFPiKk8hakXF3P4nGF1S+zTTNp6g0lninUDz1/VLuXMPIlgrDyBDqg==
X-Received: by 2002:a05:7022:ebc7:b0:11c:fe15:f66d with SMTP id a92af1059eb24-11cfe15f6a3mr17543047c88.17.1764642654542;
        Mon, 01 Dec 2025 18:30:54 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm64958694c88.6.2025.12.01.18.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:30:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 4791134e4aebe300af2b409dc550610ef69fae3e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 02 Dec 2025 02:30:53 -0000
Message-ID: <176464265340.3080.660590713344800402@1ece3ece63ba>





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/4791134e4aebe300af2b409dc550610ef69fae3e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 4791134e4aebe300af2b409dc550610ef69fae3e
origin: maestro
test start time: 2025-12-01 11:00:03.299000+00:00

Builds:	   35 ✅    4 ❌    0 ⚠️
Boots: 	   94 ✅    0 ❌    0 ⚠️
Tests: 	 3919 ✅  364 ❌ 1563 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:692ddc5ef5b8743b1f6f8407
      history:  > ❌  > ❌  > ✅  > ✅  > ❌  
            



This branch has 4 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

