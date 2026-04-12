Return-Path: <stable+bounces-235783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id boIDMC0E22kH8QgAu9opvQ
	(envelope-from <stable+bounces-235783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 04:32:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B14033E286B
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 04:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5638B3009398
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7A1DFFB;
	Sun, 12 Apr 2026 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20251104.gappssmtp.com header.i=@kernelci-org.20251104.gappssmtp.com header.b="iF4DBxvp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CD184
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775961030; cv=none; b=S/YZ3uEVk7CYWVSadDc7POA+1UmNQvak/DVFLbVEGrRfJIuAE7ShUCvjDeye4o6h17+iz/uYwK6YvqSaMb7dSZs5khLhNjDDLGLmaZpLEd1+kTu/KyKBekxg85sMKvIoPdyoG5EhSHqjSZBhnYViyNY998z2tWTVxF7337oD2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775961030; c=relaxed/simple;
	bh=nS5zRJMabMfsmq1NUE6NgUOQYnndPWOsojm3w6yXdNk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fDd5FAQXgSpP8SvNSWgSXXcYplIEPyyAeHdSg5SmOG5KH79TdzKgSKTk0FrrgseiHz+m0x9uiuiW9afUlHd5rZitFalF7j+v4LBzjREYWXNCic0MzmTW723icAxPdOfp2L3iq89GMfvDWF4RLbea4xfF67/5lU3H0ohSBWnWQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20251104.gappssmtp.com header.i=@kernelci-org.20251104.gappssmtp.com header.b=iF4DBxvp; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c156c4a9efso4634879eec.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 19:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20251104.gappssmtp.com; s=20251104; t=1775961029; x=1776565829; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98JnSqJxHTwy1khdOQl6v+2LTyLTwCYAJXcb4s/vDTo=;
        b=iF4DBxvpj1XKgaWzlnzvVA5NNMCHv+xvcRx0V2ZEme8/gfx4YDp1/0XW7OAZygwxuP
         T0VulN/tDOf+RbxR8TNny4D8Nz+5DKwCeNezbYpDpVjqd5Eg2uYmKKN2Hm8XjbEEwz1Q
         vDZREUWaT3/PEixfJQZMpS5qGWOaNfeeIXcG6vGzhUQjjOxK3qMfJdPC4Ren3CMgoH0P
         xzDuoPYp534MBIqHx5+xbNgphO+moWS39qUbkxnM2ocUKhrrYGEFLxs5oailoYy6jI60
         cZ/ZVrw3xP2+S3cVLhpkeTZ9tzdjAjEtiVWGmphLtUAYwxjQEvaopqD3XgybUL9C6nNh
         JF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775961029; x=1776565829;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98JnSqJxHTwy1khdOQl6v+2LTyLTwCYAJXcb4s/vDTo=;
        b=InlpBeu/wFbCAdecAhApr8JsA7PJ/GHc2L7Er40WDSB6J0jltc9QrmBla5XN+qhsb5
         n73my/0uYCRBvvtSGqQb2TUGsJXZWcVn7MZJ7l4MuZwFSOPL50zY4ZAMZtetEog2G0x5
         tFErzpoAVtwoNBpqo2lqcO75hVVnNCRgDP2CpcgeXw1kly7WO01RK8QRnMJr1hQkpNYI
         4+wP6iPyIuSNRlNYwRpVgBUBhw32UP1moCXx/gaMZwbVYmK7OzyrI5/l6WCFcG30NYDL
         oSv+8xiw57cRESmDbdE1n/e2S+GqFv/KhpjCMw0evJzd1c5zt7rhd4rI+hjscPNEDNo/
         pHdg==
X-Gm-Message-State: AOJu0YxNt5M3SpPiCJ0nO7+8nfobaBkLZxLGfTNwg/P9qK3d/lhMe4xr
	pZprHe8rTC9m2BpJX9mWDyVGoyIcfuQTFO9LWbEo/KVCcOde3Hzo7a8HmjbqxKADgUCiXj25NC1
	FUzEN
X-Gm-Gg: AeBDiesvDUljrhzt2FQOhFWOX6J7xdupuoVY8O3yKvGCqYUu6c8tlCb+gcGOBZ3Nl+I
	BfUCzlDkFH+UY7y9ka+u8m9pGiOQNn4aWpJrXCjizQUQ2yCgEmSHKjss1Qmn6Sgvl/tcOaExirf
	oigWiLpRvIKLI/+uc/j24d5qMdYQz0mN8fSRHUTIIq+ymX7mAKsJY4fq/E6dQ/E3rdiPF1l6Z1/
	k+D3Ph4mz+DctQ9vsYoFeRW7LoCRfniC1zsz8fylxfYVC6Up1vLWBw3OWq6hL42iDh2RRqtd+Tk
	T+ZunUx3E8bAqHvKHVJ/vjEBa2rbiTZQgMWBOI+D/8+0TxRILAg1rjaJwwFS3dTZFmsyRk5kNF4
	lR0ReovL1Wrjkp9xXM8ot2Ti1dNv2+1wroSVmOAV8/ZzAnTE//P1kOzlE0iRtG794WAuvrdUBue
	Bo+nOVLK2iQiQZcKxk
X-Received: by 2002:a05:7300:d704:b0:2b7:fdb6:ccf6 with SMTP id 5a478bee46e88-2d5890795cfmr4820512eec.14.1775961028754;
        Sat, 11 Apr 2026 19:30:28 -0700 (PDT)
Received: from 8692ffc4d55e ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69casm12859015eec.2.2026.04.11.19.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 19:30:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 e7a3953084a7050ca349010deb22546834c2e196
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 12 Apr 2026 02:30:27 -0000
Message-ID: <177596102765.4477.3664166145768650370@8692ffc4d55e>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-235783-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernelci-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,kernelci.org:url,lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernelci-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B14033E286B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/e7a3953084a7050ca349010deb22546834c2e196/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: e7a3953084a7050ca349010deb22546834c2e196
origin: maestro
test start time: 2026-04-11 12:41:01.118000+00:00

Builds:	   42 ✅    0 ❌    0 ⚠️
Boots: 	   73 ✅    0 ❌    0 ⚠️
Tests: 	 7130 ✅  523 ❌ 1957 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: sun50i-a64-pine64-plus
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_memslot_perf_test
      last run: https://d.kernelci.org/test/maestro:69da748e86a2e63970eb687f
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: imx8mp-evk
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.device_error_logs
      last run: https://d.kernelci.org/test/maestro:69da4d9486a2e63970eb1ad0
      history:  > ❌  > ✅  
            
      - kselftest.device_error_logs.devices_error_logs_test_device_error_logs_py
      last run: https://d.kernelci.org/test/maestro:69da840786a2e63970eb8048
      history:  > ❌  > ✅  
            
Hardware: imx8mp-verdin-nonwifi-dahlia
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:69da751a86a2e63970eb69c7
      history:  > ❌  > ✅  
            
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:69da710786a2e63970eb60fc
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

