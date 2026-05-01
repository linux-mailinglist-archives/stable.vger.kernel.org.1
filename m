Return-Path: <stable+bounces-242230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LOkHEUQ9Gmq+AEAu9opvQ
	(envelope-from <stable+bounces-242230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 04:30:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FDD4A9CF8
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 04:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4DB430180B0
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 02:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317CF40DFBD;
	Fri,  1 May 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="MB+iq9k3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E118FC97
	for <stable@vger.kernel.org>; Fri,  1 May 2026 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777602626; cv=none; b=Ehu+UcmdXjYpXxnervDGOM3THTo+EjrY0cA9jlS5w9mNWBAJsEm7UddSAv1YxFdjlnU6XVD1/vw+LqnMTbsgBKsvRZks+82WH9qGFurG8lB+eflrHI2bTrnK+2qbupqL3wS0HymaiFdVLjZuRM2NxLJSZBGEZSKtr3kNK1zvIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777602626; c=relaxed/simple;
	bh=ujV1/+W3d0Avk1rfo+XWjvT+HUrlGKxa5v/k98vifG4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Zj90nnM2DVZFZy2QXvaFMRG4T6wCItJ0m+Hq/a3YZPKgwrs7g+M5nYv/ltZ9FjFlFjDwVYun6uDYujNi/Wo74ZQHE3Mj4cMcXRIC6fU+LcrD7CjIpL7M+0jotw032+bEJbI1+gOeh4W3F6/dMJZM3bQlgpf+eVTqeXONEsFEWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=MB+iq9k3; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12dbd0f8063so1673434c88.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777602624; x=1778207424; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTSdjJ9zv9tcj2JumPiT+jG+yGk1t5Ot68pACPZSgWI=;
        b=MB+iq9k3rILQEdyIKkeP+MEOWqWBCopaVV+Po52cv6uDC3Z30kPdj5vy855EiNTdxo
         X32cDv+6FRVDfP442k+oHcsuJEka9jASL3laroIzEQSFB1uS1u2fk3rE+YJ/4Q/qqVf6
         vA3M2Jb3VQynsS7WOQ3a4pMJ3ahWVFfb8mAqkALtGQZmJdnXvHBTi8K33RU/ii96aGJ5
         szl0NLL9hjjASLEdlc05M24Fh9Mle4jWLtoRTKaVffr/jKbUyy9seRtXZc+sapdNwqnN
         GHa0vSrLLGw+vt4zjw4RGXO5SGTYf3xWYrfaYH4fYipq5hPcJ8wD1ZM1Jf/84GDZglZw
         Ng/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777602624; x=1778207424;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DTSdjJ9zv9tcj2JumPiT+jG+yGk1t5Ot68pACPZSgWI=;
        b=R05iZVcFLgo01sVUlydf1OSVv3Qtry/FVWpai5EhkNJRv9yGM16MrjefNCktUnVH0d
         9lMoNvnu+2VADECJXzDq2Ui5Hc8/WluwYIEv6iuXD3pXhsnj51pnXGT50kHnZf87LYS/
         8uSds1vsXjVZhmtQ58kNkcocvcT0tT4lIm45PmFyH1djPJ87c8l3JXq/xFYQsHxsVdG3
         7O/Wv1xgypWuKddpMjajMEs256ZHh8d2U2WLCNY+HDQWQw7uv2481iqktPJW+bJF4w4g
         sSGhFrmbah32z1ioaVcK8Z+SEEg6wYoFKZGQuMl07ynxhT1ggjOs5oYhzKNHaNYPdIAj
         rwEw==
X-Gm-Message-State: AOJu0YxOd0aQF93hsfXWVWJGtWxZW8PRC2PQ1pNyLfh5saNhjC8gqIkm
	aOZEZLqw3mq2tScjjh/5G9DTDiQjlSwInWQg3uttuLYkId2giz/6I5dtBuZbrba8S6s=
X-Gm-Gg: AeBDies31HcTsjajmzj4LnlvpT/MnrwkQOHoKlr0Y1uPpDOTbvG//Nwr9RcmxI6umWI
	JPm3d1gRidFBz0wEW5tUAJz7bxGbUtm/Cb8gfrhaf54IrNFTkA8rUnvfgWx7NGbA3oKBGXKmT8v
	jFI1Gek6Ql6FdHQ9Bmq1lNa8F3dm0g1pMYgJaCsc99URdnE858/JghsmEjrQfGAkuvu9k0i2Igw
	Ku4FJLXxF6OvbJ32FwjzEAy0eviVtwSkwvFlVbsJCIDrFbdXzrb36V5GpZZmJEJ3FAZsgQ1cNN3
	hq13KOi4yXqLmUBE69ctO+Rt1kXJHU/Krii2+M4L9T1ENp5YQYg7FKBXAkPIaIoXUSZ9WVKPeMG
	QdD0mTWd58bDr8mHXQVwzoAHaeAN7b14TNcSBC90qZ4Tfnf+2Q5IcQCNP4pK8hOUzNQ6TxVp6Ab
	zFkS6ExHamRrNZTXdWLTgGboKSe/c=
X-Received: by 2002:a05:7300:a28d:b0:2d9:b466:5e19 with SMTP id 5a478bee46e88-2ee88254faamr567059eec.21.1777602618384;
        Thu, 30 Apr 2026 19:30:18 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf67a3dsm2826461eec.27.2026.04.30.19.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 19:30:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 18cd79ce247a35c2938698145d1834a09b5f7777
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 01 May 2026 02:30:17 -0000
Message-ID: <177760261716.770.11735837420275527449@997d03828cfd>
X-Rspamd-Queue-Id: E6FDD4A9CF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-242230-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernelci.org:dkim,kernelci.org:url,lists.linux.dev:replyto]





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/18cd79ce247a35c2938698145d1834a09b5f7777/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 18cd79ce247a35c2938698145d1834a09b5f7777
origin: maestro
test start time: 2026-04-30 10:07:26.846000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   77 ✅    0 ❌    0 ⚠️
Tests: 	 9517 ✅  598 ❌ 2930 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.landlock.landlock_net_test_protocol_no_sandbox_with_ipv4_mptcp_bind
      last run: https://d.kernelci.org/test/maestro:69f350c0800b539063ea90c1
      history:  > ✅  > ❌  
            
      - kselftest.landlock.landlock_net_test_protocol_no_sandbox_with_ipv4_mptcp_bind_unspec
      last run: https://d.kernelci.org/test/maestro:69f350c0800b539063ea90c3
      history:  > ✅  > ❌  
            
      - kselftest.landlock.landlock_net_test_protocol_no_sandbox_with_ipv4_mptcp_connect
      last run: https://d.kernelci.org/test/maestro:69f350c0800b539063ea90c2
      history:  > ✅  > ❌  
            
      - kselftest.landlock.landlock_net_test_protocol_no_sandbox_with_ipv4_mptcp_connect_unspec
      last run: https://d.kernelci.org/test/maestro:69f350c0800b539063ea90c4
      history:  > ✅  > ❌  
            
      - kselftest.landlock.landlock_net_test_protocol_no_sandbox_with_ipv6_mptcp_bind
      last run: https://d.kernelci.org/test/maestro:69f350c0800b539063ea90b5
      history:  > ✅  > ❌  
            
      - kselftest.landlock.landlock_net_test_protocol_no_sandbox_with_ipv6_mptcp_bind_unspec
      last run: https://d.kernelci.org/test/maestro:69f350c0800b539063ea90b7
      history:  > ✅  > ❌  
            
      - kselftest.landlock.landlock_net_test_protocol_no_sandbox_with_ipv6_mptcp_connect
      last run: https://d.kernelci.org/test/maestro:69f350c0800b539063ea90b6
      history:  > ✅  > ❌  
            
      - kselftest.landlock.landlock_net_test_protocol_no_sandbox_with_ipv6_mptcp_connect_unspec
      last run: https://d.kernelci.org/test/maestro:69f350c0800b539063ea90b8
      history:  > ✅  > ❌  
            
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:69f33c85800b539063e9bc1a
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: imx8mp-evk
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.device_error_logs
      last run: https://d.kernelci.org/test/maestro:69f34255800b539063ea1cf3
      history:  > ❌  > ✅  
            
      - kselftest.device_error_logs.devices_error_logs_test_device_error_logs_py
      last run: https://d.kernelci.org/test/maestro:69f35c7f800b539063eb9280
      history:  > ❌  > ✅  
            
Hardware: imx8mp-verdin-nonwifi-dahlia
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:69f338f6800b539063e9955b
      history:  > ❌  > ✅  
            
      - kselftest.kvm.kvm_memslot_perf_test
      last run: https://d.kernelci.org/test/maestro:69f338f6800b539063e99509
      history:  > ❌  > ✅  
            
Hardware: sun50i-h5-libretech-all-h3-cc
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.uevent
      last run: https://d.kernelci.org/test/maestro:69f336f4800b539063e987d8
      history:  > ❌  > ✅  
            
      - kselftest.uevent.uevent_uevent_filtering
      last run: https://d.kernelci.org/test/maestro:69f33840800b539063e98d1e
      history:  > ❌  > ✅  
            
      - kselftest.uevent.uevent_uevent_filtering_global_uevent_filtering
      last run: https://d.kernelci.org/test/maestro:69f33840800b539063e98d1f
      history:  > ❌  > ✅  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset
      last run: https://d.kernelci.org/test/maestro:69f33740800b539063e988e5
      history:  > ❌  > ✅  
            
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:69f33884800b539063e98f96
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

