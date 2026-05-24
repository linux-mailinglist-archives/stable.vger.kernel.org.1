Return-Path: <stable+bounces-253986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLnxFMFiEmpIywYAu9opvQ
	(envelope-from <stable+bounces-253986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D010C5C1218
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A8573012329
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008E487BE;
	Sun, 24 May 2026 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="FUfkyUBr"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F524DD15
	for <stable@vger.kernel.org>; Sun, 24 May 2026 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779589820; cv=none; b=awwjYcOI11xuTUJ0JEQFgWI/u7nwTtAtN5vGpb35ePHjjv8ZsFfWsTFrD3JDP+qzPSXO+qFT4AOHopsxIn6+jrMfXeJ3uVFbKQWoHTO/YMVoeckyDN9F0wRhPWBUJlECuJHXzqmdA7bDr7Sq78qL6BFjuf+1OOrgms52dy/MOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779589820; c=relaxed/simple;
	bh=TkT5HEwpB5bakLtqdBNi2+6Wi8Ee016xqNv+fMGbHNk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=sXe1OnJlaZU4WOiggddgIXU4go9E5NfZuCX0GrPao6zm/jVrdLpXpVS8vBiTEXoAVtee9CFWO8jllGAPRXV0lFFD45+y/Bm3rLMYw3ZTbF4ZKFAdBlvz9W3vGsstM0PBhgt0ncc+fJzJ18ewUI2BsaNB+xpgsQE5hgKr6aZbmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=FUfkyUBr; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3044857f09aso3508298eec.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 19:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1779589818; x=1780194618; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia/CK2mtKgK7rTTzPLJC9NImYGcpuVXuRBt99HzBe7s=;
        b=FUfkyUBr9bpK5U2CRkeQfLJ40zW7jnED8HKNJZZo8h/DdWt4KFJMngPKR73C8mwCdU
         fz3Yc/f2MZPwqQxjRKi3kRJfN6KTzi3hRRpoO8uhtIxO1jKLkOEhR7s9cSS6RPni5kF9
         2Vffjw7XBQJ2pTfrkt8hne0Erjy2TWnqDORyyf7oQT6SXNMLeLXu+kDkec+Yf5MgBhY9
         mDv+H9TB6yzRYyrOkXPLnQFtTG8tqW2n4hV2okgKlutfAcwrLo2wpyhmTekEDogJF8kY
         mdyKCEIMk16GEDW8CLo2ACRAFGtuovHAWOm4xryBhfp9F3+bViD6GoTYXlubzpWmLhAh
         z/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779589818; x=1780194618;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ia/CK2mtKgK7rTTzPLJC9NImYGcpuVXuRBt99HzBe7s=;
        b=cvxd1LCcFuBfY7w+NC22jQeNEqc+3dTLyFSQA+fl+isuCKG3A+RAgye3TG6CvywPDm
         QrQfL3PhTv8gXREvY3aM7QEXJY9uC9weL10gIFUx1lCR+Dp9OwdyG+y907XmDd5aJoYl
         sY99etM/brZF59Cft/2ymcBLRLZ7CXHy3COzcVQaGP+W3+eegtKFzIWsjzTeIcftwj3c
         kojosyv9rCV7QnMKvbYELOFZtY7+/7EVkyBYTpL8XCWBUq408KmknfZLVrFGvh0pijfS
         4X1aRyN8f7Q4toXkWIdqYuaRwhHPcG6J724l+WbjWyk4P7t90X5DXTsdD/EsERgzH+sV
         +UJA==
X-Gm-Message-State: AOJu0Ywhw1BcgHZHLJv2rEXCHcSBQL/UDXOzMEytCC6MYdI9dozbRN5i
	ZOHDKXgKEJ/KOuBatsuxZE5iGHH1kCXobGGeW63/c04L/8QTkABliXhqwpq/afF1onw=
X-Gm-Gg: Acq92OGhKjmtculsAYzYlzc6kNkzBx1Ox5vDklkaLmgRaI+v+Y0qOwG3IVp9boE/EG0
	McTVUa2+98Mza8q1A4E3pLgQtfFFCICmk28ZV0FpXM4QeNaFf5Hkwx4nDswNI/Dq245jjmAqL66
	DxV4T5vJzjsjULtlDURaNSW3SotcMAVSZUzDt7uLGVemmvOjHGVgw/l1TbgjDwU1H3t4O2EF5T+
	szhqoTxRfm5s8YgriJBb/HE6UHGoi3ogqaL+1egBBz4Bsih3dIc52NcfcyGXAC0fWvqhsxr/9Gs
	zsdrRz+b+Ph+iyMRoQoYxsW37/O5Lzh9yrvFWQQXcWv4J5v/AJtr1Kj0FOdejygCXOyb5fn2IgZ
	5v+ubNvRD2MlWP+ektPLJoPJH7M+DKx8DJqbw3nps8BsZRXtbW+1QGSkI58plYWsKLxfki6zt00
	PQRqWjQ8kF17Sd4xym
X-Received: by 2002:a05:7301:fa0f:b0:304:2cc9:2ba3 with SMTP id 5a478bee46e88-3044905b65cmr4564891eec.22.1779589818296;
        Sat, 23 May 2026 19:30:18 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245f4e5sm4834453eec.28.2026.05.23.19.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:30:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 c4ffbe29c40ed851601bce640d5ead48eaaae08d
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 24 May 2026 02:30:17 -0000
Message-ID: <177958981723.4906.2876729639594083549@330cfa3079ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-253986-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,kernelci.org:url,kernelci.org:dkim,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: D010C5C1218
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/c4ffbe29c40ed851601bce640d5ead48eaaae08d/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: c4ffbe29c40ed851601bce640d5ead48eaaae08d
origin: maestro
test start time: 2026-05-23 11:13:22.651000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   78 ✅    0 ❌    6 ⚠️
Tests: 	 9165 ✅  575 ❌ 2822 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: imx8mp-evk
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.device_error_logs
      last run: https://d.kernelci.org/test/maestro:6a119b8e5bf5d05c97448cea
      history:  > ✅  > ❌  
            
      - kselftest.device_error_logs.devices_error_logs_test_device_error_logs_py
      last run: https://d.kernelci.org/test/maestro:6a11c8315bf5d05c974527b0
      history:  > ✅  > ❌  
            
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset
      last run: https://d.kernelci.org/test/maestro:6a1196e95bf5d05c97445f6c
      history:  > ✅  > ❌  
            
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a11984b5bf5d05c97446f79
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: imx8mp-evk
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:6a1199d75bf5d05c97448023
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a119b665bf5d05c97448bd3
      history:  > ✅  > ⚠️  > ✅  > ✅  > ✅  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1194815bf5d05c974443b5
      history:  > ✅  > ✅  > ✅  > ⚠️  > ✅  
            
Hardware: imx6dl-udoo
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1194835bf5d05c974443b8
      history:  > ✅  > ⚠️  > ✅  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1193f15bf5d05c97443af3
      history:  > ✅  > ✅  > ⚠️  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

