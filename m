Return-Path: <stable+bounces-222677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGcLEXPepWkvHgAAu9opvQ
	(envelope-from <stable+bounces-222677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 20:01:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 902971DE8F3
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 20:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D9F63078393
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B1233F36B;
	Mon,  2 Mar 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="I/OwAVBF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7AA3112AD
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477946; cv=none; b=AOL1Bc2YXT7wYFDcTZqQwD2liynBVp2azow1U4p19rnVbl5Mg+HlS/kg37viEP+tfTml7q1VoNVyJs1fXqUCDi+25NvEkHEDx7/bvmoH6lJmXPreoo6eQvJkl7AWYgbTqEI1h8BlpEg5DAZJXvbDEp/JCKL81TSJSJR3Pf5trSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477946; c=relaxed/simple;
	bh=s5EKg+1yE3wOM7QCpwJWxpcAZxhHOu8IU6N8y9zKZ3s=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=El5wuozJsT7419buG5fYs61QeTW06M4xilS4Qy+YS5yL/MpIB8xudqPkBIE7ANsdcsb9i6MgK1PLlNJkPyL7Frn6s3pCEx5396IIMo+M2TsrJoyeP7cpPLY5sdz80thkkYZO2JvY7mU/m5XV8G8WorBxY+CiLq5hzRZ6NCOJuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=I/OwAVBF; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12732e6a123so6709302c88.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1772477944; x=1773082744; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrwVy3YII9Wwn21t12F/haJHhROvNIT0daDtZY95fOA=;
        b=I/OwAVBFPEJNqTpFNwRDdVkafefzWaXG9D256KHvERKDpaIs7beXcNnbAQnMtaugRZ
         vXYyNWjXfuTBoF+FaP8xcHLiuqFWPUV8YrIvxw12qoAxanD2dxNP/Ha1a1xiXbnpYWIa
         t0McQ6iy3aFt5RXmypfK0a0jDTiftBgICN7l8Cf+M359rIR6ju5DyhFYhetdFqvO/nqp
         DQFLtF4MoblIo6xxysMCVAWh5UrBkLmA23NR9h9cHzR4Rsdx3bGOLJOVMNtlFitts8FX
         ZfXq3bvhsPjPTID9vRk0yHD7ogcgLqyhYkK39/RLZpojInEaaReq3+YipJ+izPzeRSoX
         wtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477944; x=1773082744;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WrwVy3YII9Wwn21t12F/haJHhROvNIT0daDtZY95fOA=;
        b=cmxs+PnAKpzTc9PrE7R2gRnbPN81rTOnRD9upUw2hNKjNsuCX0Jza24mAkzrd5mCyX
         7kMtOThv7tBwap0/aLQNbMLUfrBaz9kDqBwjQa4Xm5T5CDKnzZ4iBPol1bnRWYKKtDP0
         ZKenVgc21P3PoWjYFNRTRwLTDNVvcR0khtU6x6k1/p7vMH7NnraLRudXit/yxFhSuYes
         4YwYI6c7bhSUunzYTKyLVea2HFhZ0NTXfhObULLT7VznVOGEDkFzag5k80sq+XfUeUM3
         mZ2Rv8DbCUMx4Hk8nf5mJ1uBbivDWKDnknCUWUWJnMYigqkQDpZd7eoFy5NyEBZUuSg+
         O3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeg8pTFd3z0JU6n6np7rlQl16mQ0s7xdRtpOpNQc24YFmaA7BFLcpAhY9tf9hAy5M1c+8NVro=@vger.kernel.org
X-Gm-Message-State: AOJu0YziEXYlFLzvJ6/1aS6v9NIRkLyKn1vjoGyVaSwcFmjxMa/XPi2e
	bAebicLd35ClxB4/gHw2hAKrE5pDRY4eiHInktFDMTqQ1UmsSezGkwU80Ik1uPTW12Y/zz6jRJq
	qlHkZ
X-Gm-Gg: ATEYQzxvbpsmu/6VvZcXcP0xR5kFuWqDYGvpvgUxi6kHbuj8c2NLP61qWyNcwoshnB1
	1OEjRqBWNpubPX2U82mCqDOSNASg10d70TWSSQtTVXby1ilWLWcsg+z9yrH3s8YcpIjmbA6sxeA
	vJ6ug1OLvAkTw4hiwdFUv7FeI5GGLUTFTc10sTn5WifcrDVTA5KAJZE7Kv0zet+Gvlgy2YbEuCg
	Gd1nra/FLq+HbnQnO/pyf7u2u6jjhDt6ywOW/GJNbkLZlJts+Du5woZRuWf0euMdRM28ityJMzC
	v/fyQI1HORXUTm5EoOry7n0YT7XDhDqxQg5/iuPEteJ8jmDpfyCyH/0Hy9KbzQCR9cB1YptT+m5
	+JAiAyFvI+ah4OCTrjmhDqbRk27xkGje4Ev/+8JSyp/AgBJb3Wzmj5LNrJGN0y1851RCYX6Ej/W
	2KqCnGxiOW2GQ3Moj+dj4yFFWN0EM=
X-Received: by 2002:a05:7022:238d:b0:124:9e46:82d6 with SMTP id a92af1059eb24-1278fd44677mr5362811c88.25.1772477944491;
        Mon, 02 Mar 2026 10:59:04 -0800 (PST)
Received: from c9e0f4cb7c74 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a52ab0sm19474421c88.15.2026.03.02.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) variable 'link' is
 uninitialized
 when used here [-Werror,-Wuniniti...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 02 Mar 2026 18:59:03 -0000
Message-ID: <177247794302.54.10729798312271632115@c9e0f4cb7c74>
X-Rspamd-Queue-Id: 902971DE8F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-x86-kselftest-69a5bdcc7136242fe39183a8/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222677-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,kernelci.org:url,kernelci.org:email,kernelci-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 variable 'link' is uninitialized when used here [-Werror,-Wuninitialized] in drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn31/dcn31_hwseq.o (drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn31/dcn31_hwseq.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:cd9264dd300837f09031feeef4bdd834c69924a5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  fac02d83d8b6fcecda7507122864f61a79894f17


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn31/dcn31_hwseq.c:534:3: error: variable 'link' is uninitialized when used here [-Werror,-Wuninitialized]
  534 |                 link->phy_state.symclk_ref_cnts.otg = 0;
      |                 ^~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn31/dcn31_hwseq.c:509:22: note: initialize the variable 'link' to silence this warning
  509 |         struct dc_link *link;
      |                             ^
      |                              = NULL
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-kselftest-69a5bdcc7136242fe39183a8/.config
- dashboard: https://d.kernelci.org/build/maestro:69a5bdcc7136242fe39183a8


#kernelci issue maestro:cd9264dd300837f09031feeef4bdd834c69924a5

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

