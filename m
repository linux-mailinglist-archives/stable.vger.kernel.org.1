Return-Path: <stable+bounces-240400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE4oOm2E6WlMcAIAu9opvQ
	(envelope-from <stable+bounces-240400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 04:31:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32744C489
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 04:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 733943031B23
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201A30C637;
	Thu, 23 Apr 2026 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="J8MBo0Z5"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735A23D28C
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776911447; cv=none; b=FemsNvOCCG+ax/NtCofRCIc+nHB/htM5oBBe69Iij/4ppCSI02n46NG07fh0gZnWFKdkLb9U9IzjQPFnUTfs5GYA43r6X/T1lMQZvdKdga/Im4o+VL+vN46+yriYOEB6K5K+JQTwlJWBRGa2azvPFDbAt9vI5TmbRAjsNXGANl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776911447; c=relaxed/simple;
	bh=8AWACIIdw+nhHlJCpwwB/QrBA3V3uZ8RiUmvuVgaCas=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=cf3/cgc19U67MOnIg+ISZDW/5vTS9S/KVP8ug0LdAbhOnScQInPtdSZ+vfggIwL8kUt4Al3ewwqwdbLMcJ9utSAOt/Jpr6uIKdbwMyPgk6M4WBBo6QRmugaAzUkLZcCUx7AJm9wTNHWXFX6Ae3D5+kHHIkUwnJjatYMpEC5qRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=J8MBo0Z5; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c726f46baso7611842c88.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1776911445; x=1777516245; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEyRhgeTJATbXPMHfukMI+GeAxxAiI6T/Win7Pckn+c=;
        b=J8MBo0Z54xBOed1C4mTi1QX7SCH59axt7RUOrRKSW/s2+fEE600KrTlu9fq85tDTdz
         JVrWbrVxPobykYvxLLo2V2SzT647jmcRfBLtSJlbxrIUW0VpD6HezD/k4p9pc9fa+qod
         zclTXPsYQZb3EWEQSM25Mf0luulN/AAPNpWqzirGwHOoYbb93Oe6TpP0IRsSx0mfJV8h
         +XlgxaF1b8mIo7ZvV00omigeDgZPl7e2i6yQpHESpkwACj0hncSSGSn0KP9U8uq9azZK
         DqMhHzwpkqeyWM7Re9YfvqjbvrQSdpD4IvYwkRqnAJ/ZxrNJ2yO/R9yLRe5eO2Y8laPe
         sf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776911445; x=1777516245;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEyRhgeTJATbXPMHfukMI+GeAxxAiI6T/Win7Pckn+c=;
        b=s+X095vBXso6laIFD2w3Fgr8nqcJZ0MBd6wnvhdNMcKk25F2kpmyMgm4fJSAR2JxDd
         xxNUjXmeEKBH33ScC6RWUOXRKHqwf7Dot0zs/4kynH+H2ntR3w0jtbZIwd3IlMohrw4K
         ydW9hCvavtw4R3b/zjEGzXSESpJfCrc/3dc3jZyH2bUXSxJpVPUTkeYMXc+2xfAMwmVN
         AW4v7bkHTvUDQqgwU+Fu7G7h/U4cYnKUyhzSdMmt1+ItMyNMw6Y2smKjXBAUPWXItB/E
         7Qi0j2qgc89t6GbZLU0rc5nmYC2Ja0frPayLr+8AevPbq9ou7Tu5y7vDJgmMCLsiG6Qe
         lLSw==
X-Gm-Message-State: AOJu0YxoYD2lBKSxvB2RX6CuVxUfw9HYBWoSCOVUcz11Gh0+hVkGHXBp
	mJ4YcJGAuE6uZhdkNaRnWW8caWR0b7KbO3pPfxfiYbrjVqE4lZ9x5BiOr3E0l6qXcZY=
X-Gm-Gg: AeBDietxvXGibHWWlllpjcS6+veJKTyUGvrbuU1UYXKOpsPSy7mrQG0fjR88/TuNm4J
	JaGnDj+vJS9r1KAVqzCmIwLxQgO/WNGDcaHx4iBDuEFzv5y9nxcTqaHOU4oq3pessfhAtIUbOcm
	dfHHfaLkf7rfsyhCBBNH27BXFI7XUYn1RPzOzksYIVRmlLym75fLZ/Y7g3SB0aderZrFhi7c435
	HJnHkTDfvn3gK3Y1HaGws9ndCMNMiKwmUoO5buV8yaWbBPmNw8I/G9SWuVmk0L/Ua8NcL2XHifC
	WcJwlbKyif9vYr/Ql67k1B5t/zbUWB6I6mcMtoDifwyw2cRf3aDxA+IkjZn23JurX0RssU2wWBI
	lX4djhG1Fjx0Tr7XuoV1n+q18ygSW1jezINdqdEp+5dI840P3V16OpyuohInpxABNP8/G4zFwSb
	KedzWL97p74Hf3KaLEw1p0PHRXUtc=
X-Received: by 2002:a05:7022:4395:b0:128:d24a:a5ba with SMTP id a92af1059eb24-12c73f90c45mr12876291c88.20.1776911445377;
        Wed, 22 Apr 2026 19:30:45 -0700 (PDT)
Received: from ab39070dab57 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12da8b8fbc4sm17305011c88.4.2026.04.22.19.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 19:30:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 eefc95626b5cb02ea6268d1ae58237768004a60d
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 23 Apr 2026 02:30:44 -0000
Message-ID: <177691144437.1164.8832087116366260339@ab39070dab57>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-240400-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernelci.org:dkim,kernelci.org:url,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 1B32744C489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/eefc95626b5cb02ea6268d1ae58237768004a60d/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: eefc95626b5cb02ea6268d1ae58237768004a60d
origin: maestro
test start time: 2026-04-22 11:39:16.053000+00:00

Builds:	   42 ✅    0 ❌    0 ⚠️
Boots: 	   76 ✅    0 ❌    0 ⚠️
Tests: 	 8375 ✅  518 ❌ 2498 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: imx8mp-evk
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:69e9025d9b5a968309f5075e
      history:  > ✅  > ❌  
            
Hardware: imx8mp-verdin-nonwifi-dahlia
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:69e8f1df9b5a968309f4e024
      history:  > ✅  > ❌  
            
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:69e90ad19b5a968309f51852
      history:  > ✅  > ❌  
            
Hardware: sun50i-h5-libretech-all-h3-cc
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.uevent
      last run: https://d.kernelci.org/test/maestro:69e8c4689b5a968309f3fd44
      history:  > ✅  > ❌  
            
      - kselftest.uevent.uevent_uevent_filtering
      last run: https://d.kernelci.org/test/maestro:69e8dc779b5a968309f43a01
      history:  > ✅  > ❌  
            
      - kselftest.uevent.uevent_uevent_filtering_global_uevent_filtering
      last run: https://d.kernelci.org/test/maestro:69e8dc779b5a968309f43a02
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:69e8c7089b5a968309f408a3
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

