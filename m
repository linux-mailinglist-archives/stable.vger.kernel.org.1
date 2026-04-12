Return-Path: <stable+bounces-235782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFbEErMD22nX8AgAu9opvQ
	(envelope-from <stable+bounces-235782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 04:30:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FDC3E2861
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 04:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E82C30182B7
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9441DF26E;
	Sun, 12 Apr 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20251104.gappssmtp.com header.i=@kernelci-org.20251104.gappssmtp.com header.b="om2QRVWp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C502877F7
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775961008; cv=none; b=gh2Zd1/33casCt0e+91W2FdwZx5yovJPiv4WkDfeUMrXXDBgkL9GJnbViVimXB+EGlHXeIpvjLUk+onf0tZZbtljtxQbni8b5VfbI/efpsBlSHu9BjFQG91y770ctwyOLg+VapmQX1Y0EEurbFQlayH/B+1D1SaVgpslYb1zaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775961008; c=relaxed/simple;
	bh=oBSb/Wmi8Vz9fKi4Yqi7sa0vnMUCS8NZOb8GP9OH3n0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=rAQTMV2CusoGc70sqEWcLgNnZLT4XYoTU0hU58ccmiiTpudiQhbAZvuRDE9j53HAORXVa5dzjQoiEFXwpEWzbrPjgpVfKUpFm84dlWC8jwuXQrP2hqbDxTy+lTEZISfgdLFvekbh8qWRDLLr5+vK7NRaUxlj+JP0BkBsTNVE50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20251104.gappssmtp.com header.i=@kernelci-org.20251104.gappssmtp.com header.b=om2QRVWp; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d78e5d275aso1502412eec.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20251104.gappssmtp.com; s=20251104; t=1775961006; x=1776565806; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nUEp9GT9PKPwfeeLxMF5JQmgsttEc+6q1nNNFMd/to=;
        b=om2QRVWpAd28WkiupM4U9PWm1snUGmL7eOUgrQeNSLh5ZuSZ5+9nZ8Wm4Zp7Awcv9K
         W36qcjnEn2GQMvFTLzQANNDgVoPp4gG75LIVzXGp05o0xKYkqHWURWKMfRlRs5yKWW4V
         w+VNl8kj8n/CT6MRtiv4NA99KDQfJtrm5C6amdH8kluz6H9iQlRQ40isbQTVWwYbRBTo
         8xmCUOmnljhSqgWb3pz+aGxptdPnXepaEZfTENItnFunGWs2l/G6QELHkylBSt+Yvso9
         Y2nvOV9C61Sa4sjNlSZPj94LYoTd3CbUOWNIOlR6ZTZq3mJrP1uMc2aRuMlh2f8ebOVH
         7uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775961006; x=1776565806;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nUEp9GT9PKPwfeeLxMF5JQmgsttEc+6q1nNNFMd/to=;
        b=huwEA6oTALCXSBteVW9Z0FLJCkR376CUjQPpzvBXcl/Ndoqsgqd7pfgZrQ18c12V+0
         VLc6MaOHjmAQxr0HOCet10DxWBpizhV3L6b3IYB7VGCEHN8aT2vP/jmDxIdsfZMnK1j/
         CXOB1lo/a3CS0mHdIDY0kRxd+Kv2D/p85Rmoc9YPhMgzlQU5mfeSp0491fHMcQWdkT3+
         QXnTtsWAOjdTkVdKk4dyHRVjcQY0TtKBfwH9w0JTemVWj+miaoSBoIcLIzUti1tt3pGj
         NRHfs6nbbnQh0+EzQT24Yun/keWtuA2av2gvKOlcrwqr5aMJDY4y+tMOhmOPrVF8TxT+
         Gvxw==
X-Gm-Message-State: AOJu0YydnSIL2jB2yj66tvInjpUK5n7kow9kInZ3XRKHlErHOY40IaCZ
	9P4YoXvS+VTTm3Bal2aVDnR7W8yBa2ZH72nNJovzBZFFTbpsCe4RjYvlyVFK2COdcrPV7Bh4NyE
	C91Zw
X-Gm-Gg: AeBDiesqVlkSzUU9UQdioCP9/9+yAUcuUQfzBGOMlCvjxI4UEIR2aKnaNWST6xYrHhm
	cHaaBbystrBBTLjAKPoZyi3VpIYdWkIUW84Qg53s6iiAhyNEms9aU5HKzGV3wCTYAYdDS2MYQYV
	c3H1zXiDutNBCEODj5NCXTrJTnZIudKpl1UpkGShYhLIlu68vzPVzNEQzXBhwTCLYyh4c6adk9t
	zG5k5T076frWbqHxGJc1eCqOa1OVySB37aOwL9SlxikYkzCY60uY2ZTbSfyOesoUQHk2qo47JIw
	dPVT4mHSUtfVLZYDyV9QVi29W8qGsAzyBTluJpqz+8pWjSUppp16C6doy8BbhAcMbV023EdVLi0
	QdxYUCOv7a+a7zS5sEgg8owqrFnFCT2qTvZzLTlpuRl8fQt6BgtaNLyRr6vntt7bLg76L2W+X3y
	SSA0YySwxveJidvRNR
X-Received: by 2002:a05:7301:7c0c:b0:2cc:4951:37c5 with SMTP id 5a478bee46e88-2d586380a11mr4718943eec.1.1775961005974;
        Sat, 11 Apr 2026 19:30:05 -0700 (PDT)
Received: from 8692ffc4d55e ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd3138sm10889088eec.14.2026.04.11.19.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 19:30:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 8cee53b8eaeb5d1f7c97b7f2381653ed00ffc26b
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 12 Apr 2026 02:30:05 -0000
Message-ID: <177596100463.4477.6520153664847707881@8692ffc4d55e>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-235782-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci-org.20251104.gappssmtp.com:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,linux.dev:email,kernelci-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 94FDC3E2861
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/8cee53b8eaeb5d1f7c97b7f2381653ed00ffc26b/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 8cee53b8eaeb5d1f7c97b7f2381653ed00ffc26b
origin: maestro
test start time: 2026-04-11 12:41:00.664000+00:00

Builds:	   42 ✅    0 ❌    0 ⚠️
Boots: 	   49 ✅    0 ❌    0 ⚠️
Tests: 	 3874 ✅ 1429 ❌ 1281 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.mm.mm_run_vmtests_sh_split_huge_page_test
      last run: https://d.kernelci.org/test/maestro:69da824f86a2e63970eb7a25
      history:  > ❌  > ✅  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:69da500a86a2e63970eb256b
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.mm.mm_run_vmtests_sh
      last run: https://d.kernelci.org/test/maestro:69da824f86a2e63970eb7a02
      history:  > ❌  > ⚠️  
            
      - kselftest.mm.mm_run_vmtests_sh_khugepaged
      last run: https://d.kernelci.org/test/maestro:69da824f86a2e63970eb7a27
      history:  > ❌  > ⚠️  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

