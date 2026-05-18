Return-Path: <stable+bounces-249171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IcwHj96Cmqe1wQAu9opvQ
	(envelope-from <stable+bounces-249171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:32:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A15651C2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E8B53020AA7
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7362A1CF;
	Mon, 18 May 2026 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="SQdbqlGN"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA91405C49
	for <stable@vger.kernel.org>; Mon, 18 May 2026 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071426; cv=none; b=BDz0bnoQlfCYdIs2giLjRJ3MfCkqm26NeIaZQ96Z4X1pd5Iu283lm02IP/9pnwLg1TmCZ3UYbls4KveyKhnfFJHT8HZ7UaiSpq8lB0iR7Fi1dmw5L8dxF9r0TNn2JiJPshlqDzw+TMFJbyRWJ9vQ5E9OAaCAZj3K058gM9Oym2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071426; c=relaxed/simple;
	bh=W1h4Sjyko+nVGWBjrxveOtuvFawZHnjTxlmvraCjkMg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=BTL/jDlDZuJ3tYPqC6jmMwg/v4xx2ON3mOgsqJ5iydqkolPm5XsLjIM6/oermDrE3uE4uQqKDTNRBv/KCJXyW9upbw0PUB+zhkyuu4qXBevsT89IZdxLEl/uOC+piKw47x8QQlXm5ITKjNK9B2asAAyjo7Y0TYQuitn0n4M2urI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=SQdbqlGN; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f33ae12f97so6924391eec.1
        for <stable@vger.kernel.org>; Sun, 17 May 2026 19:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1779071421; x=1779676221; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3W9nRsi6NsBy28wDHHiBB7H/eQWVSIS/nDdEFJ9h6I=;
        b=SQdbqlGN3qkTgTanf2RbX2bZDEL0CGGE+G7LPzn0KcBvRLAFU7F1cn9SekuXM+1i6y
         XlsEeRh7VozbHKqd0Ucu6EgiPiZ/bvqgxVZ8yzUfy/RpyyIH4zvuOQOe4f40l7aW58e2
         jNcdaDYelwO6NmzYFYVXmUpGVTQK9S0E6s3DKxNWgfWNj2PlbGTFkkBlefePked8f0st
         y5joVWjrM7IpoUuLjNxWBTiaeOd64ltf5Uyc3d8Avw7awCFCp1lM998kwf5By5FyXkBI
         yEsej9rxffszs052nET6MpK0c8trTi9kSBoiuZBw5oW04PJzAhg9tkD43cY+9Z0LZjmX
         E87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779071421; x=1779676221;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3W9nRsi6NsBy28wDHHiBB7H/eQWVSIS/nDdEFJ9h6I=;
        b=nLIAdst/XQVutafxkcODdVJf6a7OBrmzs53mYi+HURY/bSH01dK8VAuCNRWCJXcvxK
         +VjIbnpEm53yoDmpl6PzM9AMTm2E2NaAIxYww2IB4V19BXnOytlNx8KGpCOSh9HMuOmG
         DZA3wMUlW8BBwea+VCu1CRWFRLpWvL907vzU1ovWxt33Ij6LZQW7d00Tq60414/vrZEG
         Q1jP4VR6PInA+HdIMU9VtU4X2iFUAJ7PTTcGfvzdXvpLHNKZ7+LU5iofvGtkVC2e2DMQ
         ytSWkSqdzi6d/Eg6vaa83o0ezcguVKA4R3lbOXNGo6SgQsD353R28Xk+ymcWXyvJxhf0
         34cg==
X-Gm-Message-State: AOJu0YyF1+e1oOt1gZ0ZSTIEzEOeGv7E17kCZ++Cpw/OqVtyHOHq4NY+
	xaDSSD5jhddQFgkkmil4O7xsVGJWHBoLP8yHlnkaEXJ5CUEIz+FLcjan1g4hOvaW9nTlfywlVdB
	S/4JZ
X-Gm-Gg: Acq92OEmu1jTfb1qJ0V1dCLIZGHkNrRT5cC8UVnXNb6lQSKFcTHk17LpWE7u/FQgSJ8
	y6fccMTeGF3keY3pw80TecUdIVPXQtVlpZgI63SlxzR7DRk1sq8JjirVQFSKpgw7+efHMeLAXGX
	/pG/8Lw5QbJasWgB2RbGE2JUMgQFDKGEhHy9v0+UY8OnUvzD/kQqM8ENSpbcHmtegIXM2iqcklo
	XRuaPgi+/KmNW5y/1CcAlBatea7GrVy/Gy8ROAkNT8I0XriaY86OBmdSgNWVbXFGOhj54C3DYOu
	zQmiBx4Dk9Pe5tM7nZl1g0+BwfuildVJCYcBM0oRND1SqwArnqHR0u4pinosN7SBUwqfVkr9tjc
	rZ3Gc4/4i1vXhZKJv+P3lY0dilVdARQ5I2wgClPOqK3NfAsQmts3KtbAffu39vqJrbjCzaaeDwk
	BAdkzcSp1eEVRvLyullPQ4BGRJt6w=
X-Received: by 2002:a05:7022:4183:b0:132:1e01:8737 with SMTP id a92af1059eb24-1350542e5a3mr6415623c88.26.1779071420993;
        Sun, 17 May 2026 19:30:20 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2352f2sm18616328c88.10.2026.05.17.19.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 19:30:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 eac8889a3a1c81d7113cc4656b9420e84c379cf5
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 18 May 2026 02:30:20 -0000
Message-ID: <177907142006.2148.8872427316148195023@330cfa3079ca>
X-Rspamd-Queue-Id: CF8A15651C2
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
	TAGGED_FROM(0.00)[bounces-249171-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/eac8889a3a1c81d7113cc4656b9420e84c379cf5/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: eac8889a3a1c81d7113cc4656b9420e84c379cf5
origin: maestro
test start time: 2026-05-17 15:54:38.766000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   57 ✅    0 ❌    0 ⚠️
Tests: 	 4575 ✅ 1468 ❌ 1462 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: asus-CX3402CVA-brya
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_sleep
      last run: https://d.kernelci.org/test/maestro:6a09ebb00ed99f002e996d72
      history:  > ✅  > ❌  
            
Hardware: sun50i-a64-pine64-plus
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.device_error_logs
      last run: https://d.kernelci.org/test/maestro:6a09ece10ed99f002e9970f1
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a09eb7c0ed99f002e996d3e
      history:  > ❌  > ✅  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a09ec400ed99f002e996db8
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

