Return-Path: <stable+bounces-253983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN7QErRiEmpIywYAu9opvQ
	(envelope-from <stable+bounces-253983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9320E5C1202
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE13300EF4C
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3724A06D;
	Sun, 24 May 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="SdgCZOCt"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7DE265623
	for <stable@vger.kernel.org>; Sun, 24 May 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779589808; cv=none; b=bzMrRJDoaYqN0kGCi6ulTN1tocDlN2lXyZhxv5ZDv4UGiLPg4AejmuIrem5Bjwm8WJIPvh0fUDUMLQh+UcX92DbbdhUquKBF1V154RSc8xm9RA/iRSjw+Qq8U9oVfRwOT/Nv8AhZrIOhhgBZMsr8CjG9aw3fG8ylk26XBYLaLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779589808; c=relaxed/simple;
	bh=cCfgAcwljrGDcHoggWVRnNfh5h4n6lDcXuWbxKUxwbc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gjsQFDjqAliZH/yuC6i5MUiAyPl3Zic8DefJGA5vcPmLIMXAbewJNRO2AnvUy0UJV8zEYK9hs62Og4Nw6Jt4XN/fIvBhyyp5vZbYxUlMXw8Dr3sVbS+PiPhI2nlmryZ4zzBmHyUaPmSz5PZzhaQoLzMXlTGXGDOnGrXzuQRHMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=SdgCZOCt; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f33ae12f97so4090589eec.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1779589805; x=1780194605; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lluPgUWqZjxGi8jy3Vj326DD8A12bMVD+l5hUr9FKhQ=;
        b=SdgCZOCtwmfCxnbLrxcZiNHZPiAbb9MUflZ+KwjeyEhV4CHZCMreoF3UmkDY0yXe1q
         0Ul9mh4KU5Y64HtYr6HxhqBwyQirD1sijPRGgGqFP2/uBZbrf13orW8rGGM5X1xEu00g
         zf7BVkPL1dAjZBE182apHmS62iAE0Jsqr3JRut3DU2yM7yqP6EWKLnqJgkJwyoOqs2+c
         2nGCVPF4sQbZozifcvwoDL2ENAVmKPZtoYVmRPZSur6zj251DFwvTHrvP26Fna7zPAv5
         9B2k8JTKchqcT4lWep6v9zrq70IMNToasx8xtKWv3pvCj26WpUa1Le2JXVrkp+Ev5Qqj
         BTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779589805; x=1780194605;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lluPgUWqZjxGi8jy3Vj326DD8A12bMVD+l5hUr9FKhQ=;
        b=lYRBjgVHaxaU6Ff+GeH64SL02YnryYKRRHr5/DXLozfepBFkcBmLqzPt7e3ZMskmFl
         wXMEsm0t+boV1WR5PFSWdOocV4VtJRYXqT+pHUlvn9FqhcCqPICvG4FsxecPhPNtc01e
         kFOp2W7bPCstKEzz2pmKj0tVKFls3rGME7yOLvB7zOcvIitPqPU3SfyoJ5qmju3kSOTI
         j4+yfR9yXfnQxpTdjBTs1ZvI0KLRCqW3K3DDzRopCyelT7B/5FrWXbH0Zc7zPjoBOT3C
         3Q9KrPvuVL2RTeqH4ODFeG1NZWTWLZmCfzJaP+WlwpySODv20y9hVWKLxrHPD+OKyG5y
         MaDg==
X-Gm-Message-State: AOJu0YxBQ6S6sOXcKbdQRijSr8qcnPCkEk/D3Sra+QOw94DqpFErH3qj
	Fzr6jmFG3MEfr8pYfMpIi/2nmXhYeHp3U1ZaQYFKncfcr04ddueFq2EDdPy7VO6aXww=
X-Gm-Gg: Acq92OFuSupNaUMOSVpV64U0xyWtrD8/DLLNUACtzHDC2pCmqUL87Rh8gNhYgBK+vxw
	9C7spGTvnYz8FUh5f4UQ1GvI3r2Y0OdARfJ6rkfPqLAN7++/nhJuOfCIQxoVQSLBMn81TYkR3eg
	x5aQI3Ebc60r+xYo3z4F5VDUeRNlg9fhCgtK4CPP1UUKgd6e68TZNEsH2pvnew8xHf9drTxj9eW
	verfhOq8YlluIJADNEyjphahPpXlYKQPeHEdOWr1GtvcQpcAB2THk4ue9cSBZHlOYAI7ttZ9Kxb
	bH3pB4IL7jCzoXnAKysR86bsKl7WlgwZTZp3RZ/qsMx+RiwvDnCzeL15jE3bspmMQPzwlob9VT6
	VbVxxs81NF1ZMc6utFTHjhhVcH3poFKK8BJh290geym2Uo2uQevyHtDosd8ooSsA7h1H/sd49cg
	zUIfCDfJcE8tS767Gu
X-Received: by 2002:a05:693c:20cb:20b0:304:4f23:4826 with SMTP id 5a478bee46e88-3044f23c4f2mr2244410eec.28.1779589805475;
        Sat, 23 May 2026 19:30:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef4719sm4631771eec.1.2026.05.23.19.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:30:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 0a40c6fbd105802fbbcaadca249e0948fbf8095a
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 24 May 2026 02:30:03 -0000
Message-ID: <177958980336.4906.17943924835672907538@330cfa3079ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-253983-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 9320E5C1202
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/0a40c6fbd105802fbbcaadca249e0948fbf8095a/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 0a40c6fbd105802fbbcaadca249e0948fbf8095a
origin: maestro
test start time: 2026-05-23 11:13:22.220000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   63 ✅    0 ❌    6 ⚠️
Tests: 	 4653 ✅ 1611 ❌ 1469 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a1196635bf5d05c97445d26
      history:  > ✅  > ❌  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a1196065bf5d05c97445a1b
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: asus-CX3402CVA-brya
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_sleep
      last run: https://d.kernelci.org/test/maestro:6a11932a5bf5d05c97442f68
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11963c5bf5d05c97445c17
      history:  > ✅  > ⚠️  > ✅  > ✅  > ✅  
            
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.mm.mm_run_vmtests_sh_khugepaged
      last run: https://d.kernelci.org/test/maestro:6a1198ac5bf5d05c97447823
      history:  > ⚠️  > ❌  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11921e5bf5d05c97442ceb
      history:  > ✅  > ✅  > ⚠️  > ✅  
            
Hardware: imx6dl-udoo
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11921f5bf5d05c97442cee
      history:  > ✅  > ⚠️  > ✅  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1193265bf5d05c97442f62
      history:  > ✅  > ✅  > ⚠️  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

