Return-Path: <stable+bounces-198037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D16C99E12
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 03:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCFB44E20A9
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 02:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73B268C42;
	Tue,  2 Dec 2025 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0tIiaSHw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6618BC3D
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642653; cv=none; b=RqXMg8ZkGjPgsxkQTlkwGJXowXPT9y1o93w0J/ZfyA5nbwWD/LJ6qcMyXBqvHeqiV9Ksj+9cMFoes0zgC9kSfxsMokClCQVj7c9QZSr/Qh50yknXKx1GBnS+D/jWU5aaNzdh3ximRFIJukcvII1HzrrBzWx5vJdIeWiVekYUTm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642653; c=relaxed/simple;
	bh=t8wkMNJ67h6APOUnmIgWljJmnbu5Gr/K3rJaloHPvtM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=J7yzMElwFAs1JmAAVfTEEe1sTF8OfdDPsnvSm/TwR/oj78N+Gu9JJzQs/cnuzCMtBgiua6dy7UtecGlMpWcbB+KZMorce1+oiPn/grx4pQahrk+htnu/L7Unq42KyQqCfQjJb+fQKrPjZUJzws81c8GMeV7KUoOEy1RA0p7lZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=0tIiaSHw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso4212897a91.2
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 18:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764642651; x=1765247451; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wfkbIs5cT1xI/hsSuyRy4Z3+tt12GdZzTRx+CCDKkE=;
        b=0tIiaSHwoMfklse+AitcDwujTJ2TQZlIZDGUdtpppvRrj4l3KwmoPsaorF09b53sFx
         ycwI6VGyi9SoXaB5bwGDY8F4nXP4pL4J5F/OIs0qdJKuEkRGR3BZg4okVEqgsJjz7kV7
         OAZlrv0UbFNVaxE4gBtUvC8/7YBVdikv3zdXjpPXZRLzwk2oE7h8W+mVncewwBAZPUR1
         rTn59NCfVHSMfqgJyJOBs4Z/LzSJAqJYy3MJg+dUnZRykrfMpFZPb74BHTR/J/GBl6Bc
         pCYC38EVq88swg+SKqC0Nm19lTAmpac5pckWKmzM29XNfeTOikybDIxhcJdVtW6D4sSJ
         /BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764642651; x=1765247451;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wfkbIs5cT1xI/hsSuyRy4Z3+tt12GdZzTRx+CCDKkE=;
        b=LbGfmnMjytYPkyYnhX9eOQY+h+7PONO/eXfOclDv0MC45nMX0qC0yk9TpBDFWqeKNJ
         03uGPptq63X2hX1l1lt8+M+tcbnstU0krHrrza4nOdf9R/TzhfpJmTz/PhoSHNfQd29F
         oes03SbiDR6uQkiuqPP0kjs983lfNtlbUa8NcWJgYQ4pYVuiq8hEhdpDsabuWAauNKNy
         NdIDTDIhqkNKY1uQZP/ZLtaQDqFv/qIs4/WxeMMCVUT/VXi2qRS+ncXsrLoMM/djEFLv
         jFZsFy0pQ3i7dytoez3OkIMvp+ig78/3memvxHm5a8jGAvBBWXmK6FC7PufOxwjR/UVu
         sMcw==
X-Gm-Message-State: AOJu0Yx/O0ZWVhHqOzawYO1Vy2xqpWLNar7zxmYpAN0cUknrW4EDlGzh
	8HI9GqZEbV7a7hJI6U05ILWo2uddnl1SoYjfdOILI6jscsV1T3pFi2+WEv8txX1Yw84BA0MXn+S
	e/Yri4xw=
X-Gm-Gg: ASbGncv7uMftr3l6mhkD34vW78eVWnxSUE2rhdxnz0VptyFC8f5ZnYui3azWXO0ncdO
	fIYdghBscld2vMGd0gqWSPKW3ufgvzKMqVCUtlFXaHelh/eF4xcjeLJYbrfHxeMtC6/fRhkrOcL
	TByRK3qChUEcZD9unS3mYxffNDZcuzDC0cCYYrXrtDsjVNOcEe6sGeUsF5jI9TczJvtMNGgUQ90
	sR7CFE310fL3Yvv7TVpFd+rqDKy4CN2C6iUP+WS3ulGQlvPMEJwJntQ8FCSfgwCejEpX/lXzTSp
	1dwcQ51tOAuFWKOUIH/t9f21pOHIjmyb/jcLGU12RjGwVadQShSqvjY6Cykw0OVKdpvM1cllDlu
	SjCOOcbzdYpRBT96HgYgnou72K3ew3VivjG2UR5xr2HWbG7VCLSs79PMn607glawG8qsqte06LZ
	/ogOBW
X-Google-Smtp-Source: AGHT+IE5/nC0wuYGYu96nK5tLfLjUPB3kmg2GBHU5a85VE5hgoEfusI57J/O+328Yq+62SnjXr/gpg==
X-Received: by 2002:a05:7022:688:b0:11d:e6ee:47ba with SMTP id a92af1059eb24-11de6ee4bc0mr1685958c88.35.1764642650665;
        Mon, 01 Dec 2025 18:30:50 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb049cdesm68110766c88.8.2025.12.01.18.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:30:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 318a47068f7b88de838518897500d7509e3fe205
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 02 Dec 2025 02:30:49 -0000
Message-ID: <176464264962.3080.13897173542734512796@1ece3ece63ba>





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/318a47068f7b88de838518897500d7509e3fe205/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 318a47068f7b88de838518897500d7509e3fe205
origin: maestro
test start time: 2025-12-01 11:00:03.719000+00:00

Builds:	   34 ✅    5 ❌    0 ⚠️
Boots: 	  189 ✅    0 ❌    0 ⚠️
Tests: 	11205 ✅  810 ❌ 2936 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:692d842ef5b8743b1f6ef8d2
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 5 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

