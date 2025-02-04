Return-Path: <stable+bounces-112120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B27A26D29
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 09:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A238B7A3F6F
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448A2066D7;
	Tue,  4 Feb 2025 08:20:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972E70820
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657240; cv=none; b=jQpgvhHk3n19h5NZ82OCbwmZmIjH2YvxcuF4cPpIkiAF5OHw/Avi4EFxhPnNkHWi2zzyxArEMZk8SitNriWxsxgOjdDfWfqlrCpHPtxhplOfaEZBLfIcMXv+LB+SGx4ONdHPiT/Z3ZOA/s/pYBCNAtDCk+HLNnCZZjkv6ZB779I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657240; c=relaxed/simple;
	bh=cEhAqGqVrWG2R2vJJ/gWDDisfX0E/K5jPFt2VxDZV3Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I8SYUBjf3HhtXZASagkhgchhzxydJAoDjsHNA1ER6FCz6AxmA1nfeRgQvJaHi7bRZgZJ3shq90cith+UJ+TvsX02TFEkVHifPXjvHkX8lOQP/me0VcoYnZFQNPEQGKHZiRG91+tqK00tfZ2pzRhrAczHpGXGOpo4ce/U7Upj50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9c69aefdbso407291a91.2
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 00:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738657237; x=1739262037;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmGO8+fYOdM+IBTuSsvc9Yn3mZtNAlbJq6mCi+t8rKU=;
        b=a4mgnJ4SyS8xXkRO21wPLoIk1ygswI9gYOCYeM2n9KXm3O/Jq6Tbgh3o/R3+DzWtzU
         7EXDFWMIolYF6ZJukvHINDxCbHq9pKkXXRJqxa7+LoSqjX1muY2cwiqnIMxxrfxTwnII
         nsOp8zK9NHKTxjB6EQd2sciM26/nHmvW24CbEpDhu/dOJPEth2LTBpzk9qXcM53oWjrR
         3+vhOrlZfk6jVoqaJ+h+OsSpiDRlN0Z5T+UgTGolC5f5zd/ZVCO2eA+us3TPilOJa+qi
         YbnA7B31PzcAvSgffBLoXsROzSeAeezZf3JIuh2Qtgkz2JgNB818sANEXnWUnr7HYx0B
         TLog==
X-Forwarded-Encrypted: i=1; AJvYcCUF3EiHJgqvT8dEMJoYZBPhzZfJqaXf6/QFbqMsgTo2QPOvrhtat3BY+Tdjtm6ZvhbRAYjRqvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLUq5/T0P7WsqSTo3VOqv8cvCHeJRzmr4idqZdYXRkDWn05lXo
	L6poQfLHL0HhYU3+fLrAz0OUnct8Oh4djacN7GvwcAm3qTjEGVrF2LmlCbu1MYCpA7QEjG7ZJ6t
	zLga3YKhN0Huxex2/ycBB7qUbKQQ=
X-Gm-Gg: ASbGncvgXWafpaGOUVRFxe7Rmk0BBcWk7Y5Vl1pg8ASWjpflTb4mM9FEPzNp6rEYlvE
	YZzVZMngWRtjKMkNJ7htFLYEhThzO1990uuo3/iuw8rPJdOgeLLBs4lkgDs33bLVbJW58yE4TX2
	OgMVCLtQwW9yeK6fZfAFaQKZPX09sI
X-Google-Smtp-Source: AGHT+IGQ9hLo3zejKxoQSMLrYXx+ClCpxCb2hxYhLpafIh6IuYFqeqcNwtJeRxmeCed9AUEvgRISqQgSyDkAZSohYcI=
X-Received: by 2002:a17:90b:5485:b0:2ee:70cb:a500 with SMTP id
 98e67ed59e1d1-2f83abb4fa0mr34411762a91.1.1738657237218; Tue, 04 Feb 2025
 00:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Barry K. Nathan" <barryn@pobox.com>
Date: Tue, 4 Feb 2025 00:20:25 -0800
X-Gm-Features: AWEUYZmNEQ2Kl3Zr9lbaVgOVpcZkX4DDz4ITTWDJQQv9WdvvpTAzs0uCP95WDI4
Message-ID: <CANhx2CheUATGPiONHRp9Nm15wRBdF5FUux9U7SWJoLxx0MHMvg@mail.gmail.com>
Subject: Linux 6.6.76-rc1 regression due to crypto-api-fix-boot-up-self-test-race
To: herbert@gondor.apana.org.au, sashal@kernel.org, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Compared to 6.6.75, 6.6.76-rc1 freezes up for roughly one minute
during boot, and I think the log messages are indicating a crypto
self-test failure afterward. I have tried it on two different
computers (a Core 2 Duo-based PC and a Haswell-based 2015 15" MacBook
Pro) and it happens 100% of the time on both. I bisected it down to
crypto-api-fix-boot-up-self-test-race ("crypto: api - Fix boot-up
self-test race"). Reverting that one patch from 6.6.76-rc1 fixes the
regression for me.

By the way, I also tested 6.13.2-rc1 and 6.12.13-rc1, and this bug did
not reproduce on either.

Log excerpt:

[    4.523861] ima: No TPM chip found, activating TPM-bypass!
[    4.534858] ima: Allocated hash algorithm: sha256
[    4.544294] ima: No architecture policies found
[    4.553384] evm: Initialising EVM extended attributes:
[    4.563682] evm: security.selinux
[    4.570339] evm: security.SMACK64 (disabled)
[    4.578900] evm: security.SMACK64EXEC (disabled)
[    4.588156] evm: security.SMACK64TRANSMUTE (disabled)
[    4.598279] evm: security.SMACK64MMAP (disabled)
[    4.607534] evm: security.apparmor
[    4.614363] evm: security.ima
[    4.620326] evm: security.capability
[    4.627502] evm: HMAC attrs: 0x1
[   65.685967] random: crng init done
[   68.452968] DRBG: could not allocate digest TFM handle: hmac(sha512)
[   68.465701] alg: drbg: Failed to reset rng
[   68.473914] alg: drbg: Test 0 failed for drbg_nopr_hmac_sha512
[   68.485595] alg: self-tests for stdrng using drbg_nopr_hmac_sha512
failed (rc=-22)
[   68.485597] ------------[ cut here ]------------
[   68.510017] alg: self-tests for stdrng using drbg_nopr_hmac_sha512
failed (rc=-22)
[   68.510035] WARNING: CPU: 1 PID: 78 at crypto/testmgr.c:5936
alg_test+0x49e/0x610
[   68.540198] Modules linked in:
[   68.546332] CPU: 1 PID: 78 Comm: cryptomgr_test Not tainted 6.6.76-rc1 #1
[   68.559920] Hardware name: Gigabyte Technology Co., Ltd.
G41MT-S2PT/G41MT-S2PT, BIOS F2 12/06/2011
[   68.579005] RIP: 0010:alg_test+0x49e/0x610
[   68.587220] Code: de 48 89 df 89 04 24 e8 70 ed fe ff 44 8b 0c 24
e9 bc fc ff ff 44 89 c9 48 89 ea 4c 89 ee 48 c7 c7 80 9a ed ad e8 f2
74 b2 ff <0f> 0b 44 8b 0c 24 e9 a1 fe ff ff 8b 05 21 04 c2 01 85 c0 74
56 83
[   68.624782] RSP: 0018:ffffbc8380307e10 EFLAGS: 00010286
[   68.635252] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: c0000000ffffefff
[   68.649534] RDX: 0000000000000000 RSI: 00000000ffffefff RDI: 0000000000000001
[   68.663816] RBP: ffffa01c47be0200 R08: 0000000000000000 R09: ffffbc8380307c98
[   68.678100] R10: 0000000000000003 R11: ffffffffae0d1368 R12: 0000000000000058
[   68.692384] R13: ffffa01c47be0280 R14: 0000000000000058 R15: 0000000000000058
[   68.706665] FS:  0000000000000000(0000) GS:ffffa01d37c80000(0000)
knlGS:0000000000000000
[   68.722871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   68.734381] CR2: 00007ff2f64622e0 CR3: 0000000146c20000 CR4: 00000000000406e0
[   68.748664] Call Trace:
[   68.753588]  <TASK>
[   68.757817]  ? alg_test+0x49e/0x610
[   68.764817]  ? __warn+0x81/0x130
[   68.771301]  ? alg_test+0x49e/0x610
[   68.778304]  ? report_bug+0x171/0x1a0
[   68.785652]  ? console_unlock+0x78/0x120
[   68.793521]  ? handle_bug+0x58/0x90
[   68.800525]  ? exc_invalid_op+0x17/0x70
[   68.808221]  ? asm_exc_invalid_op+0x1a/0x20
[   68.816611]  ? alg_test+0x49e/0x610
[   68.823614]  ? finish_task_switch.isra.0+0x90/0x2d0
[   68.833390]  ? __schedule+0x3c8/0xb00
[   68.840739]  ? __pfx_cryptomgr_test+0x10/0x10
[   68.849473]  cryptomgr_test+0x24/0x40
[   68.856824]  kthread+0xe5/0x120
[   68.863133]  ? __pfx_kthread+0x10/0x10
[   68.870656]  ret_from_fork+0x31/0x50
[   68.877832]  ? __pfx_kthread+0x10/0x10
[   68.885354]  ret_from_fork_asm+0x1b/0x30
[   68.893226]  </TASK>
[   68.897626] ---[ end trace 0000000000000000 ]---


-- 
-Barry K. Nathan  <barryn@pobox.com>

