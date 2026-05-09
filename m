Return-Path: <stable+bounces-244889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PlfEzac/mnItwAAu9opvQ
	(envelope-from <stable+bounces-244889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:30:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C34FDA62
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50934301F78D
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424D2D0603;
	Sat,  9 May 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="A3XYy4Rd"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1F2C3252
	for <stable@vger.kernel.org>; Sat,  9 May 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293811; cv=none; b=BEZNAgkenBDErHtUiEASeqxz5j736dXnsuyR1X0GknTketczsX5Y8PE6XJdtw7U+/83T7ckV4Bm9sM2qAOUuEa1VT07dc2ODzLvm8AgsoLKAL0g/H3jQl80VQ1ENGMPdfbOgfFQRcUmIdXQB3JWM4ics9t4dUoF97FMZ4aJMiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293811; c=relaxed/simple;
	bh=fAgTWNAI0aq2QqApA+sP6K9mCXMb+SJUe0dsd30nwzc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=eEcm4oTMdIE+4upHHFzY8vQVF8hAwEUNqcd91LSHnUiB6Sst/gRW/MB7+7NwQRZOv/VBVdoycsXOKVSLd58MSn2Y0Ac0MQYu6c56gvzm7fgiYm86x/ZxBriHT6dQG/pIU672cbzhFCXVYhlWyy+4jSaYyEK5IeTdkpJ1VG/3oFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=A3XYy4Rd; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c1a170a50so3712708c88.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778293808; x=1778898608; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5h2pqsdCImcOSYOSE72O2wcGe7vIe5zG6FVGoyu1TE=;
        b=A3XYy4RdVaHnoF+LlQx7QxUTDw7n6nhP7MZMr6TJvDn1ZZLgjACdonH3HLMa48v+mz
         GQZQ1GjfkQjTSpyOs9S2WgL0cfCW+y8J9VGg/J5MMJpahyeB21Jpj5rvybnIUjk7xC+k
         15qknTBuTpkU3TgMJjW7k2zDKIEdMehYmQJufproib37w72wk3D5RutAFOlCxtdYRfkf
         QI8pQWBN2nguS3FrYUnpYvqIAUEgMYIlFal1l0LbP7Lru6AHN7xgaLK1Z3cRhMrtNYjv
         sQfCT8kzof3BItXx2Nbh3efuGz8Ub1p3dsqZZ/G31TCAx9rXcPSduc6EqAgsqE2XlI6X
         wFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293808; x=1778898608;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5h2pqsdCImcOSYOSE72O2wcGe7vIe5zG6FVGoyu1TE=;
        b=eULvDz/kvydNKkg8igq0vWIZ34NDUay+NL4ReY6Ob+/PVrfbTuMJeZQcYmnCJjfY8I
         Qzd/gLuleTZfNsbufNgBynyWWYguIOv3cSC90crVXGKAeDyoeUlQoGdvbhAmJ4AbD4YK
         8PeV4rooiDNox/VhwFlCVGDPhsaUXLWkKczR64Itx4dcJPmqKkku1c7EE3EeFoZ6i/nn
         BpS3Sjwp8Ls5VlLU+2CIYc6wTSFc0/c5KS7adBRCOZXQs8jsQfQp4DMxj/zlu3ptDy/y
         J1uT1M1R9yHZgp2vQRbEaCZvoS42fhGaLDHejQargnFTw1W07NkBTfdb6kknhXGHA6dL
         FFrw==
X-Gm-Message-State: AOJu0YxxjFpbqZWNoiJiWlvs2i9K3Qg3yGNGEgsoROc0wfJxjIathN00
	vJAA8Q1GVevp19CzgTQmwj48XeiZRXcCKBLPQdNO/c4GHRZ7tHnlv438fd97lDRGyws=
X-Gm-Gg: AeBDievmuE08/6qtI1uyjsil0l6NTEUCheHiKRf6S/YZg7bDTSJIub9KftC/CJqiJCk
	U0stKM9DHfWVDk6cmhgdZMHVLd6vld0UVK3dgBQ2+zY6USRtJaf4AdIkkm5CdvMTeXpHeASfuKK
	fYbbc/Lif05XAjJCmg6eKbPvft3W6pnnXrUtcU/fIFCMEeZCob/SxklDSaGUZmNi6NbsUZ/pDvD
	3sLdAY1zmWzVca/CmQ+PKUmHmkknLrE/YIyU0sx/2ftRu7WygYFlgYiVm0hDvQTHO1WfNtVZ8CX
	3LF3I63uNfnyfSXJkUaiD3yMIn1GBIIyloJ8mTj7ml3ro3VwlccQVEMQTD6ZU07mdxuiZ0LGt06
	x1yjGTASWLlyMGYV6Dhzfb3XIJSlX7lvsecIqgF515wi0JC/hRR9H+e2zuNQKZ0KBwlNzJ9WHFl
	KKgnJ5/L+x17yS9a/O
X-Received: by 2002:a05:7022:f102:b0:12d:b396:eaed with SMTP id a92af1059eb24-131967d523fmr6843655c88.9.1778293808165;
        Fri, 08 May 2026 19:30:08 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm5946241c88.15.2026.05.08.19.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:30:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 8bf2f55ef536982e44802d99340119dac6f50636
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 09 May 2026 02:30:07 -0000
Message-ID: <177829380679.4454.8855415511670222041@997d03828cfd>
X-Rspamd-Queue-Id: BC8C34FDA62
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-244889-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,linux.dev:email]
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/8bf2f55ef536982e44802d99340119dac6f50636/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 8bf2f55ef536982e44802d99340119dac6f50636
origin: maestro
test start time: 2026-05-08 07:34:14.874000+00:00

Builds:	   43 ✅    0 ❌    0 ⚠️
Boots: 	   73 ✅    0 ❌    0 ⚠️
Tests: 	 9012 ✅  590 ❌ 2836 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: imx8mp-evk
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.device_error_logs
      last run: https://d.kernelci.org/test/maestro:69fda06d0e4ee292cbed7490
      history:  > ✅  > ❌  
            
      - kselftest.device_error_logs.devices_error_logs_test_device_error_logs_py
      last run: https://d.kernelci.org/test/maestro:69fdbcee0e4ee292cbee546c
      history:  > ✅  > ❌  
            
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:69fdaf660e4ee292cbedecd2
      history:  > ✅  > ❌  
            
      - kselftest.kvm.kvm_memslot_perf_test
      last run: https://d.kernelci.org/test/maestro:69fdaf660e4ee292cbedec83
      history:  > ✅  > ❌  
            
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:69fdac700e4ee292cbedea00
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: asus-CX3402CVA-brya
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:69fdcb150e4ee292cbeeef09
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

