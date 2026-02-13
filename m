Return-Path: <stable+bounces-216013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XY2JD86MjmntCwEAu9opvQ
	(envelope-from <stable+bounces-216013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 03:30:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7166A13265E
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 03:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C80E306EE5B
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C4EEADC;
	Fri, 13 Feb 2026 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="aF3tXKaN"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E23EBF1F
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770949834; cv=none; b=d2DS1uFvl0OnEpmKCzJ5t/62xoAy0DwgEX6cva9lSrVYHHMZAPS6RQe9dJTTuTLuxYHc3KEtL8WslEX8Oim+htXggxaZ3CiMYCkvU0XIhXMYjjx3coXcVBH0xZWrxDKrcfZ3vRU7SsD/rAezRY6VimvZ2SLtFutv5BIpGgQGxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770949834; c=relaxed/simple;
	bh=r4kuJIXNRe1KTzGlBB5Ndieq1xaJ0s0bp8Q6gqzjshg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=DY3EqH1S2d/iRRl1DKHB7HgfR07VmZtPRoP6aR9niCGLS+CzJHjwamvEj+iXOAb/qIhnG3R1NRwLhUR3JFXL/vYbFqiTRO717TTcPZqSuh2nU1nwIZq9yzwAuSkIzViUYhouAzhjZfyKIlCFN0MQ5EzHrx644Wf3aiob9p+KQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=aF3tXKaN; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-124a95e592fso1556789c88.0
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 18:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1770949832; x=1771554632; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWqZ0gDegdl1pbZHMxaPttEWHIvGKZjRE0Uyxtykopw=;
        b=aF3tXKaNXpbPK16Hff7ywffuYCT/ugzlLmGovvIBJaY8ej+STrljJNbITMkzr4uhfj
         aEO/E2eyl93dZ3xeHspaSC7hYVqcXCH7IBw4Iewqavnk3SeitGGbbHHxl9WNXWJIGJaH
         C2jZu18Lp3fmwuwsoqeYZpv+GRIm5cCqJ/Ne9UgEQnLlmuV21uxkovZLcGk3+vS8BSMh
         OeSzw5KhcSFEpKW89PD6wvJWDu8tBpwrMmIoqE2C4wTJ0ynQ6Sepa8MvpV3DdnfcXcC0
         lh5A2WYky7ie5Q4XP9hcf0sY5R1s4NkGsrQw3DFOsXQrMjgk2Pj9/MyABhZmzUShWM6F
         SLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770949832; x=1771554632;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWqZ0gDegdl1pbZHMxaPttEWHIvGKZjRE0Uyxtykopw=;
        b=Lsuyi++WWXTrrpiWi7amYq2lvf0psiQ7TOTOH2R2bNBPjQd+z66d4Ejkdc9EwtxtXk
         EG0jGyGjSUPtcD9VcZS1onSefmvS6heUELtLumeYpLvLt/WJP2GbW7qWo99ZfPtB03pb
         pRL/YA3gwfvwxm5fJqO9X7w3wKJjURFreJht/SzUjuQS65FE06Bibo/kL9mXtrnk5CZa
         rBPyhHI2qdAaJqxCjV3KmsPavh3zVk+40mjX3x8U1+l1CtG7AL7sZx3GRqKF4xWQq2IE
         pKMEsWQU+yejV4HAtD2lYQfaUi8Li4QcQ2XeNOV+Xt6fcSlUSsg1NeoYJOBlVzYXJQ3f
         Xb4A==
X-Gm-Message-State: AOJu0YztRtwgNm7sHt3n9a5SwEoG1mch/yIn0y9nU7YRX2epBfMTflOA
	X1KDFU5AHiMBSTqwpnUnmpiGQK/eouCafez1GEmwZfyI8Mt45gmjiJUjRnLIot9TI7g=
X-Gm-Gg: AZuq6aK1FPTME1Pmk0dN4Suq15BLGNVPqQzKzoY9ujmVWndCTTFfgd4uwKRJXu5qpRj
	trVBJ0TeQU/VZ5ZAQvk8MX1E0NX6GKk3IXAyg+dO17z9i2lCDc096FuYbsYG7ajwXWvSiLRShBX
	FZb4qEQ3rkcfcDyAV2D5dGaCMd6JLJn4FnjDba+WxxJXYZBnYZeocHC1eek1hcABzDSif8ceUoN
	wdYw3yPOlThd+mjqTWftmDNV5dWu8xQ3TfAXzU9V6c2BT1kPbMrKGi7vBbhGQ2lSi7us84ixRMY
	P2KsIpW4ab800btXjK5HRcUN8tAdNDd72ckzC1o7cS0LLaZ6VgrysH24HW/cpKk1gMZDxE8UP/6
	u0/Y8+KzqK45P/N6AYVIUYXptukIJEjmKJH0UyqQyEkPSrwmEYYB4S1JjPmf9kyPzOgyyv49edX
	vtITb44xGmY8WB0l4DzDLja0M1Q9A=
X-Received: by 2002:a05:7022:2393:b0:119:e569:fbb3 with SMTP id a92af1059eb24-1273ae4735cmr98396c88.34.1770949831678;
        Thu, 12 Feb 2026 18:30:31 -0800 (PST)
Received: from f55b40a4666e ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6e9966sm7530859c88.10.2026.02.12.18.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 18:30:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 ae591174b1f2e6b81ffe182fb621bba910bfb44e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 13 Feb 2026 02:30:31 -0000
Message-ID: <177094983070.1089.17359132364552177115@f55b40a4666e>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216013-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernelci.org:url,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 7166A13265E
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/ae591174b1f2e6b81ffe182fb621bba910bfb44e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: ae591174b1f2e6b81ffe182fb621bba910bfb44e
origin: maestro
test start time: 2026-02-12 12:20:18.603000+00:00

Builds:	   40 ✅    0 ❌    0 ⚠️
Boots: 	   60 ✅    0 ❌    0 ⚠️
Tests: 	 3849 ✅  443 ❌ 1281 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:698dd189a1ae387ffbd0f516
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:698ddebea1ae387ffbd14982
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:698dd18da1ae387ffbd0f53b
      history:  > ❌  > ✅  
            
Hardware: qcs6490-rb3gen2
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.proc.proc_read
      last run: https://d.kernelci.org/test/maestro:698dd50aa1ae387ffbd10109
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

