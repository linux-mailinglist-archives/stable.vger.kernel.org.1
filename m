Return-Path: <stable+bounces-224806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOYuFPlesmlmMAAAu9opvQ
	(envelope-from <stable+bounces-224806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:36:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B761826DED7
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68CBE3079531
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 06:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECA39EF0A;
	Thu, 12 Mar 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EdTmhb7b"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90631E82D
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297328; cv=none; b=B/tIgd/GIbjNEeKSUBQFUOJ9RU7GPRINRYAb4Xl33AvcCGOahSfhwGcKGRtMr4wjVmvFY+Y7JZIFdKsRaKocqcczWCUmeMcn5h1UgVGoP8sF+avUkb+pgImbmIwZo/2A2TaW2DBd5yJEDLJPWU8U5Z8EfTgr3qoTS8cu4iiM33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297328; c=relaxed/simple;
	bh=AFwlJ0FtBB4TwlvzrimwzLeSt6l6pknXyQyDEH9TIdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3ZxHfsQWO7xQYeGxyNOBiV1hx0ZLAk+iXM6HRTbazsLx7tzZtF1Xk1pEVWTFxlsZfEztscTGq8wztIMpIu3WNJS9L/bR35WWfNVEeH+sVFNTox7fNL7JivfLluvmtkts9SLhoVd+DABBk97uOCIhzBAMJbkZrPUR4LTWEntFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EdTmhb7b; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso4688265e9.0
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 23:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773297325; x=1773902125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cu1K73i+ibewnUAZwwBsDvXv8G6/JQt0pmtZSfjPlGw=;
        b=EdTmhb7be0izPFFV1Y51oXss/2P4L/0iTEl4ZXu45h0dKGdWCTrMRu2P6NwOZyHQnc
         Sple3L2KD8xFyj7mJZmAh8WokUwuLKE6sFqfmsi/jhes0wwd4HEbnidq9ejsHYXhXYVD
         9TP9uUZjrjBqMXpXTTfUnSbV7YFBZJlw+5WCnwgRGWIsMTw9I+x5EakylBlBkaBZkooM
         tQm8z6veisN1OeY54v6XOQ/fBdDjuKzgQzIsWjIMXn+phnGwuql8gtk93DQ9PTeRDEQQ
         yX0dbSFv6kpzXUuTOA41yiNH9rpLUrbFmy5QJhxmz+4obj85gMXm3dnBytZ84fvEh4t9
         /k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773297325; x=1773902125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu1K73i+ibewnUAZwwBsDvXv8G6/JQt0pmtZSfjPlGw=;
        b=gHGLJlLqs+dtzE5aIs70aMngn/Mq2N64jBIYnNzr1lDzku7t3PwHsJx9StuvYW7mic
         yN2i70G0jWXb5Dw0FVE0lST3Rb9goH8+3b9Mu7gmcJ4lEfZtCqsniL0An88hkACONtyI
         6NokJ11dDNYfrAxFnvVcvbGej0A5eX5mlhfS5L7Rn6oWxWrRWPdjW1IqZ+KYijuUvi2d
         wIuWhsboaUwGTe0u9dcmOpUR4riv0K8BMxvkA9IppDtTKnempdJbCKICosZ9kwRTe4OM
         t3oYJ7FPkB6SP/ozpwrMWvRhHh9/Bq69+fnV3M6cxuxq3Eg8cEzY7U376rI9ZbKPcT+H
         0+pA==
X-Forwarded-Encrypted: i=1; AJvYcCX0iMQmupbK4/94yp+CCf3gBR1+Zt4+DAu3Eszy6scvjdF8HUIaN6RMDfDe/XCQh2e4fbiAM20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNumvyW2UF81CfAOS3X8mHmaW9oOBHBDoClqcI55g5CeiC5BwS
	e2fVtUiLCmD8L7orNEtkXuyMRJZnR1NkIfHlLOxuq0d0bZQHw69nlHSDrWvUVfP5GYI=
X-Gm-Gg: ATEYQzyjO1ao5iZpqlSX3ngK4A57XfAaAIo7Pi6imR/HME2aWB5NXy1QY8w34Xz28Xw
	lveGPs4hRj7UxcFQoL06/osrBVHfXWxsOsIwZkjN/2LpaEDAgiRunXc3rUDcr3MkqIwMUQEwIrM
	4TpP6ZyeqLc1MxnKiKrCvOLizwF5SwgUJhyjm1tlm12shuBCAfPPjvUEUfdbGBy31ubIzVTgVwW
	1ItF46Tgf8P0mG5+8ltlD4xIhjyJ9SMwr2JG/Tojcg4O7zxyMnQXnBQrefV+vsKUa+H6sLxMFte
	WLqGThdgLy/HyNNHgPm2oCUrtiK7doKXd637fLeFykE9q8Mm5nrLndC6uExw0lMPglLJXCYwDvm
	3dG0dFyZEcP+1O01fyKCuLcmqCAth2j8rNpF3ZUpTA4XVtBAGk0rLz8K4xk4ftOyXEyFIsZ+e/M
	k1ICqcF/IkNDDeVGny/gU=
X-Received: by 2002:a05:600c:1554:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-4854b12ce27mr80764335e9.30.1773297324473;
        Wed, 11 Mar 2026 23:35:24 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:7358:55be:6563:4437:e6fe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ba23adsm4152361a91.0.2026.03.11.23.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 23:35:23 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:35:11 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/314] 6.18.17-rc1 review
Message-ID: <xbjybmha7fdnnm5gn6p6jyppf4ud2r72rfabvej6egg545ozsu@a4qj43d3iu36>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224806-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: B761826DED7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sasha,

On Tue, Mar 10, 2026 at 07:19:29AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.18.17 release.
> There are 314 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

BPF selftest is failing due to backported commit efc11a667878 ("bpf:
Improve bounds when tnum has a single possible value"). The fix is
commit 024cea2d647e ("selftests/bpf: Avoid simplification of crafted
bounds test"). Can you pick that up for both 6.18 and 6.19?

FWIW this failure does not point to actual issue of the codebase, just
that the selftest's expectation not aligning with the kernel.

Full log below:

  /var/git/linux-stable-6.18$ vng --user=root --cwd=tools/testing/selftests/bpf/ -- ./test_progs -n 295
  #295/1   reg_bounds_crafted/(u64)[0; 4294967295] (u64)<op> 0:OK
  #295/2   reg_bounds_crafted/(u64)0 (u64)<op> [0; 4294967295]:OK
  #295/3   reg_bounds_crafted/(u64)[0; 2147483648] (u64)<op> 0:OK
  #295/4   reg_bounds_crafted/(u64)0 (u64)<op> [0; 2147483648]:OK
  #295/5   reg_bounds_crafted/(u64)[0x100000000; 0x100000100] (u64)<op> 0:OK
  #295/6   reg_bounds_crafted/(u64)0 (u64)<op> [0x100000000; 0x100000100]:OK
  #295/7   reg_bounds_crafted/(u64)[0x100000000; 0x180000000] (u64)<op> 0:OK
  #295/8   reg_bounds_crafted/(u64)0 (u64)<op> [0x100000000; 0x180000000]:OK
  #295/9   reg_bounds_crafted/(u64)[0x100000000; 0x1ffffff00] (u64)<op> 0:OK
  #295/10  reg_bounds_crafted/(u64)0 (u64)<op> [0x100000000; 0x1ffffff00]:OK
  #295/11  reg_bounds_crafted/(u64)[0x100000000; 0x1ffffff01] (u64)<op> 0:OK
  #295/12  reg_bounds_crafted/(u64)0 (u64)<op> [0x100000000; 0x1ffffff01]:OK
  #295/13  reg_bounds_crafted/(u64)[0x100000000; 0x1fffffffe] (u64)<op> 0:OK
  #295/14  reg_bounds_crafted/(u64)0 (u64)<op> [0x100000000; 0x1fffffffe]:OK
  #295/15  reg_bounds_crafted/(u64)[0x100000001; 0x1000000ff] (u64)<op> 0:OK
  #295/16  reg_bounds_crafted/(u64)0 (u64)<op> [0x100000001; 0x1000000ff]:OK
  #295/17  reg_bounds_crafted/(u64)[0; 1] (u64)<op> [1; 2147483648]:OK
  #295/18  reg_bounds_crafted/(u64)[1; 2147483648] (u64)<op> [0; 1]:OK
  #295/19  reg_bounds_crafted/(u64)[0; 1] (s64)<op> [1; 2147483648]:OK
  #295/20  reg_bounds_crafted/(u64)[1; 2147483648] (s64)<op> [0; 1]:OK
  #295/21  reg_bounds_crafted/(u64)[0; 1] (u32)<op> [1; 2147483648]:OK
  #295/22  reg_bounds_crafted/(u64)[1; 2147483648] (u32)<op> [0; 1]:OK
  #295/23  reg_bounds_crafted/(u64)[0; 1] (s32)<op> [1; 2147483648]:OK
  #295/24  reg_bounds_crafted/(u64)[1; 2147483648] (s32)<op> [0; 1]:OK
  #295/25  reg_bounds_crafted/(u64)[0; 0xffffffff00000000] (s64)<op> 0:OK
  #295/26  reg_bounds_crafted/(u64)0 (s64)<op> [0; 0xffffffff00000000]:OK
  #295/27  reg_bounds_crafted/(u64)[0x7fffffffffffffff; 0xffffffff00000000] (s64)<op> 0:OK
  #295/28  reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffffffffffff; 0xffffffff00000000]:OK
  #295/29  reg_bounds_crafted/(u64)[0x7fffffff00000001; 0xffffffff00000000] (s64)<op> 0:OK
  #295/30  reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffff00000001; 0xffffffff00000000]:OK
  #295/31  reg_bounds_crafted/(u64)[0; 4294967295] (s64)<op> 1:OK
  #295/32  reg_bounds_crafted/(u64)1 (s64)<op> [0; 4294967295]:OK
  #295/33  reg_bounds_crafted/(u64)[0; 4294967295] (s64)<op> 2147483647:OK
  #295/34  reg_bounds_crafted/(u64)2147483647 (s64)<op> [0; 4294967295]:OK
  #295/35  reg_bounds_crafted/(u64)[0; 0x100000000] (u32)<op> 0:OK
  #295/36  reg_bounds_crafted/(u64)0 (u32)<op> [0; 0x100000000]:OK
  MISMATCH true_reg1.u64: 0x100000000 != [4294967294; 0x100000000]
  MISMATCH true_reg1.s64: 0x100000000 != [0xfffffffe; 0x100000000]
  VERIFIER LOG:
  ========================
  func#0 @0
  Live regs before insn:
        0: .......... (05) goto pc+2
        1: .......... (b7) r0 = 0
        2: 0......... (95) exit
        3: .......... (85) call bpf_get_current_pid_tgid#14
        4: 0......... (bf) r6 = r0
        5: ......6... (85) call bpf_get_current_pid_tgid#14
        6: 0.....6... (bf) r7 = r0
        7: ......67.. (18) r1 = 0xfffffffe
        9: .1....67.. (18) r2 = 0x100000000
       11: .12...67.. (ad) if r6 < r1 goto pc-11
       12: ..2...67.. (2d) if r6 > r2 goto pc-12
       13: ......67.. (18) r1 = 0x80000000
       15: .1....67.. (18) r2 = 0x80000000
       17: .12...67.. (ad) if r7 < r1 goto pc-17
       18: ..2...67.. (2d) if r7 > r2 goto pc-18
       19: ......67.. (bc) w0 = w6
       20: ......67.. (bc) w0 = w7
       21: ......67.. (ae) if w6 < w7 goto pc+3
       22: ......67.. (bc) w0 = w6
       23: .......7.. (bc) w0 = w7
       24: 0......... (95) exit
       25: ......67.. (bc) w0 = w6
       26: .......7.. (bc) w0 = w7
       27: 0......... (95) exit
  0: R1=ctx() R10=fp0
  0: (05) goto pc+2
  3: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
  4: (bf) r6 = r0                       ; R0=scalar(id=1) R6=scalar(id=1)
  5: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
  6: (bf) r7 = r0                       ; R0=scalar(id=2) R7=scalar(id=2)
  7: (18) r1 = 0xfffffffe               ; R1=0xfffffffe
  9: (18) r2 = 0x100000000              ; R2=0x100000000
  11: (ad) if r6 < r1 goto pc-11        ; R1=0xfffffffe R6=scalar(id=1,umin=0xfffffffe)
  12: (2d) if r6 > r2 goto pc-12        ; R2=0x100000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  13: (18) r1 = 0x80000000              ; R1=0x80000000
  15: (18) r2 = 0x80000000              ; R2=0x80000000
  17: (ad) if r7 < r1 goto pc-17        ; R1=0x80000000 R7=scalar(id=2,umin=0x80000000)
  18: (2d) if r7 > r2 goto pc-18        ; R2=0x80000000 R7=0x80000000
  19: (bc) w0 = w6                      ; R0=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff)) R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  20: (bc) w0 = w7                      ; R0=0x80000000 R7=0x80000000
  21: (ae) if w6 < w7 goto pc+3         ; R6=scalar(id=1,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001)) R7=0x80000000
  22: (bc) w0 = w6                      ; R0=scalar(smin=umin=umin32=0xfffffffe,smax=umax=0xffffffff,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x1)) R6=scalar(id=1,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001))
  23: (bc) w0 = w7                      ; R0=0x80000000 R7=0x80000000
  24: (95) exit
  
  from 21 to 25: R0=0x80000000 R1=0x80000000 R2=0x80000000 R6=0x100000000 R7=0x80000000 R10=fp0
  25: R0=0x80000000 R1=0x80000000 R2=0x80000000 R6=0x100000000 R7=0x80000000 R10=fp0
  25: (bc) w0 = w6                      ; R0=0 R6=0x100000000
  26: (bc) w0 = w7                      ; R0=0x80000000 R7=0x80000000
  27: (95) exit
  
  from 18 to 1: R0=scalar(id=2) R1=0x80000000 R2=0x80000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff)) R7=scalar(id=2,umin=0x80000001) R10=fp0
  1: R0=scalar(id=2) R1=0x80000000 R2=0x80000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff)) R7=scalar(id=2,umin=0x80000001) R10=fp0
  1: (b7) r0 = 0                        ; R0=0
  2: (95) exit
  
  from 17 to 1: R0=scalar(id=2) R1=0x80000000 R2=0x80000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff)) R7=scalar(id=2,smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff)) R10=fp0
  1: R0=scalar(id=2) R1=0x80000000 R2=0x80000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff)) R7=scalar(id=2,smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff)) R10=fp0
  1: (b7) r0 = 0                        ; R0=0
  2: (95) exit
  
  from 12 to 1: safe
  
  from 11 to 1: safe
  processed 28 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 0
  =====================
  ACTUAL   FALSE1: scalar(u64=[4294967294; 0x100000000],u32=[4294967294; 4294967295],s64=[0xfffffffe; 0x100000000],s32=[0xfffffffe; 0xffffffff])
  EXPECTED FALSE1: scalar(u64=[4294967294; 0x100000000],u32=[4294967294; 4294967295],s64=[0xfffffffe; 0x100000000],s32=[0xfffffffe; 0xffffffff])
  ACTUAL   FALSE2: scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  EXPECTED FALSE2: scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  ACTUAL   TRUE1:  scalar(u64=0x100000000,u32=0,s64=0x100000000,s32=0)
  EXPECTED TRUE1:  scalar(u64=[4294967294; 0x100000000],u32=0,s64=[0xfffffffe; 0x100000000],s32=0)
  ACTUAL   TRUE2:  scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  EXPECTED TRUE2:  scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  verify_case_opt:FAIL:(u64)[4294967294; 0x100000000] (u32)< 2147483648 unexpected error: -22 (errno 22)
  #295/37  reg_bounds_crafted/(u64)[4294967294; 0x100000000] (u32)<op> 2147483648:FAIL
  MISMATCH false_reg2.u64: 0x100000000 != [4294967294; 0x100000000]
  MISMATCH false_reg2.s64: 0x100000000 != [0xfffffffe; 0x100000000]
  VERIFIER LOG:
  ========================
  func#0 @0
  Live regs before insn:
        0: .......... (05) goto pc+2
        1: .......... (b7) r0 = 0
        2: 0......... (95) exit
        3: .......... (85) call bpf_get_current_pid_tgid#14
        4: 0......... (bf) r6 = r0
        5: ......6... (85) call bpf_get_current_pid_tgid#14
        6: 0.....6... (bf) r7 = r0
        7: ......67.. (18) r1 = 0x80000000
        9: .1....67.. (18) r2 = 0x80000000
       11: .12...67.. (ad) if r6 < r1 goto pc-11
       12: ..2...67.. (2d) if r6 > r2 goto pc-12
       13: ......67.. (18) r1 = 0xfffffffe
       15: .1....67.. (18) r2 = 0x100000000
       17: .12...67.. (ad) if r7 < r1 goto pc-17
       18: ..2...67.. (2d) if r7 > r2 goto pc-18
       19: ......67.. (bc) w0 = w6
       20: ......67.. (bc) w0 = w7
       21: ......67.. (be) if w6 <= w7 goto pc+3
       22: ......67.. (bc) w0 = w6
       23: .......7.. (bc) w0 = w7
       24: 0......... (95) exit
       25: ......67.. (bc) w0 = w6
       26: .......7.. (bc) w0 = w7
       27: 0......... (95) exit
  0: R1=ctx() R10=fp0
  0: (05) goto pc+2
  3: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
  4: (bf) r6 = r0                       ; R0=scalar(id=1) R6=scalar(id=1)
  5: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
  6: (bf) r7 = r0                       ; R0=scalar(id=2) R7=scalar(id=2)
  7: (18) r1 = 0x80000000               ; R1=0x80000000
  9: (18) r2 = 0x80000000               ; R2=0x80000000
  11: (ad) if r6 < r1 goto pc-11        ; R1=0x80000000 R6=scalar(id=1,umin=0x80000000)
  12: (2d) if r6 > r2 goto pc-12        ; R2=0x80000000 R6=0x80000000
  13: (18) r1 = 0xfffffffe              ; R1=0xfffffffe
  15: (18) r2 = 0x100000000             ; R2=0x100000000
  17: (ad) if r7 < r1 goto pc-17        ; R1=0xfffffffe R7=scalar(id=2,umin=0xfffffffe)
  18: (2d) if r7 > r2 goto pc-18        ; R2=0x100000000 R7=scalar(id=2,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  19: (bc) w0 = w6                      ; R0=0x80000000 R6=0x80000000
  20: (bc) w0 = w7                      ; R0=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff)) R7=scalar(id=2,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  21: (be) if w6 <= w7 goto pc+3        ; R6=0x80000000 R7=0x100000000
  22: (bc) w0 = w6                      ; R0=0x80000000 R6=0x80000000
  23: (bc) w0 = w7                      ; R0=0 R7=0x100000000
  24: (95) exit
  
  from 21 to 25: R0=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff)) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001)) R10=fp0
  25: R0=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff)) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001)) R10=fp0
  25: (bc) w0 = w6                      ; R0=0x80000000 R6=0x80000000
  26: (bc) w0 = w7                      ; R0=scalar(smin=umin=umin32=0xfffffffe,smax=umax=0xffffffff,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x1)) R7=scalar(id=2,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001))
  27: (95) exit
  
  from 18 to 1: R0=scalar(id=2) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,umin=0x100000001) R10=fp0
  1: R0=scalar(id=2) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,umin=0x100000001) R10=fp0
  1: (b7) r0 = 0                        ; R0=0
  2: (95) exit
  
  from 17 to 1: R0=scalar(id=2) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,smin=0,smax=umax=umax32=0xfffffffd,var_off=(0x0; 0xffffffff)) R10=fp0
  1: R0=scalar(id=2) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,smin=0,smax=umax=umax32=0xfffffffd,var_off=(0x0; 0xffffffff)) R10=fp0
  1: (b7) r0 = 0                        ; R0=0
  2: (95) exit
  
  from 12 to 1: safe
  
  from 11 to 1: safe
  processed 28 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 0
  =====================
  ACTUAL   FALSE1: scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  EXPECTED FALSE1: scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  ACTUAL   FALSE2: scalar(u64=0x100000000,u32=0,s64=0x100000000,s32=0)
  EXPECTED FALSE2: scalar(u64=[4294967294; 0x100000000],u32=0,s64=[0xfffffffe; 0x100000000],s32=0)
  ACTUAL   TRUE1:  scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  EXPECTED TRUE1:  scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  ACTUAL   TRUE2:  scalar(u64=[4294967294; 0x100000000],u32=[4294967294; 4294967295],s64=[0xfffffffe; 0x100000000],s32=[0xfffffffe; 0xffffffff])
  EXPECTED TRUE2:  scalar(u64=[4294967294; 0x100000000],u32=[4294967294; 4294967295],s64=[0xfffffffe; 0x100000000],s32=[0xfffffffe; 0xffffffff])
  verify_case_opt:FAIL:(u64)2147483648 (u32)<= [4294967294; 0x100000000] unexpected error: -22 (errno 22)
  #295/38  reg_bounds_crafted/(u64)2147483648 (u32)<op> [4294967294; 0x100000000]:FAIL
  #295/39  reg_bounds_crafted/(u64)[0; 0xffffffff00000000] (s32)<op> 0:OK
  #295/40  reg_bounds_crafted/(u64)0 (s32)<op> [0; 0xffffffff00000000]:OK
  #295/41  reg_bounds_crafted/(u64)[0; 4294967295] (s32)<op> 0:OK
  #295/42  reg_bounds_crafted/(u64)0 (s32)<op> [0; 4294967295]:OK
  #295/43  reg_bounds_crafted/(u64)[0; 0x100000000] (s32)<op> 0:OK
  #295/44  reg_bounds_crafted/(u64)0 (s32)<op> [0; 0x100000000]:OK
  #295/45  reg_bounds_crafted/(u64)[0; 0x100000001] (s32)<op> 0:OK
  #295/46  reg_bounds_crafted/(u64)0 (s32)<op> [0; 0x100000001]:OK
  #295/47  reg_bounds_crafted/(u64)[0; 0x180000000] (s32)<op> 0:OK
  #295/48  reg_bounds_crafted/(u64)0 (s32)<op> [0; 0x180000000]:OK
  #295/49  reg_bounds_crafted/(u64)[0; 0x17fffffff] (s32)<op> 0:OK
  #295/50  reg_bounds_crafted/(u64)0 (s32)<op> [0; 0x17fffffff]:OK
  #295/51  reg_bounds_crafted/(u64)[0; 0x180000001] (s32)<op> 0:OK
  #295/52  reg_bounds_crafted/(u64)0 (s32)<op> [0; 0x180000001]:OK
  #295/53  reg_bounds_crafted/(s64)[0xffffffffffffffff; 0] (s64)<op> 0xffffffff00000000:OK
  #295/54  reg_bounds_crafted/(s64)0xffffffff00000000 (s64)<op> [0xffffffffffffffff; 0]:OK
  #295/55  reg_bounds_crafted/(u64)[4294967295; 0x100000000] (u64)<op> 0:OK
  #295/56  reg_bounds_crafted/(u64)0 (u64)<op> [4294967295; 0x100000000]:OK
  #295/57  reg_bounds_crafted/(u64)[4294967295; 0x100000001] (u64)<op> 0:OK
  #295/58  reg_bounds_crafted/(u64)0 (u64)<op> [4294967295; 0x100000001]:OK
  #295/59  reg_bounds_crafted/(s64)[0xffffffff00000001; 0] (u64)<op> 0xffffffff00000000:OK
  #295/60  reg_bounds_crafted/(s64)0xffffffff00000000 (u64)<op> [0xffffffff00000001; 0]:OK
  #295/61  reg_bounds_crafted/(u32)[1; 4294967295] (u32)<op> 0:OK
  #295/62  reg_bounds_crafted/(u32)0 (u32)<op> [1; 4294967295]:OK
  #295/63  reg_bounds_crafted/(u32)[0; 4294967295] (s32)<op> 4294967295:OK
  #295/64  reg_bounds_crafted/(u32)4294967295 (s32)<op> [0; 4294967295]:OK
  #295/65  reg_bounds_crafted/(s32)S32_MIN (u64)<op> [0xffffff01; 0]:OK
  #295/66  reg_bounds_crafted/(s32)[0xffffff01; 0] (u64)<op> S32_MIN:OK
  #295/67  reg_bounds_crafted/(s32)[S32_MIN; 0xffffff01] (s64)<op> [0xfffffffe; 0]:OK
  #295/68  reg_bounds_crafted/(s32)[0xfffffffe; 0] (s64)<op> [S32_MIN; 0xffffff01]:OK
  #295/69  reg_bounds_crafted/(s32)[0; 0x1] (s64)<op> S32_MIN:OK
  #295/70  reg_bounds_crafted/(s32)S32_MIN (s64)<op> [0; 0x1]:OK
  #295/71  reg_bounds_crafted/(s32)S32_MIN (u32)<op> S32_MIN:OK
  #295/72  reg_bounds_crafted/(s32)S32_MIN (u32)<op> S32_MIN:OK
  #295/73  reg_bounds_crafted/(u64)[0; U64_MAX] (u64)<op> U64_MAX:OK
  #295/74  reg_bounds_crafted/(u64)U64_MAX (u64)<op> [0; U64_MAX]:OK
  #295/75  reg_bounds_crafted/(u64)[0; U64_MAX] (u64)<op> 0:OK
  #295/76  reg_bounds_crafted/(u64)0 (u64)<op> [0; U64_MAX]:OK
  #295/77  reg_bounds_crafted/(s64)[S64_MIN; 0] (u64)<op> S64_MIN:OK
  #295/78  reg_bounds_crafted/(s64)S64_MIN (u64)<op> [S64_MIN; 0]:OK
  #295/79  reg_bounds_crafted/(s64)[S64_MIN; 0] (u64)<op> 0:OK
  #295/80  reg_bounds_crafted/(s64)0 (u64)<op> [S64_MIN; 0]:OK
  #295/81  reg_bounds_crafted/(s64)[S64_MIN; S64_MAX] (u64)<op> S64_MAX:OK
  #295/82  reg_bounds_crafted/(s64)S64_MAX (u64)<op> [S64_MIN; S64_MAX]:OK
  #295/83  reg_bounds_crafted/(u32)[0; 4294967295] (u32)<op> 0:OK
  #295/84  reg_bounds_crafted/(u32)0 (u32)<op> [0; 4294967295]:OK
  #295/85  reg_bounds_crafted/(u32)[0; 4294967295] (u32)<op> 4294967295:OK
  #295/86  reg_bounds_crafted/(u32)4294967295 (u32)<op> [0; 4294967295]:OK
  #295/87  reg_bounds_crafted/(s32)[S32_MIN; 0] (u32)<op> 0:OK
  #295/88  reg_bounds_crafted/(s32)0 (u32)<op> [S32_MIN; 0]:OK
  #295/89  reg_bounds_crafted/(s32)[S32_MIN; 0] (u32)<op> S32_MIN:OK
  #295/90  reg_bounds_crafted/(s32)S32_MIN (u32)<op> [S32_MIN; 0]:OK
  #295/91  reg_bounds_crafted/(s32)[S32_MIN; S32_MAX] (u32)<op> S32_MAX:OK
  #295/92  reg_bounds_crafted/(s32)S32_MAX (u32)<op> [S32_MIN; S32_MAX]:OK
  #295/93  reg_bounds_crafted/(s64)[0; 0x1f] (u32)<op> [0xffffffff80000000; 0x7fffffff]:OK
  #295/94  reg_bounds_crafted/(s64)[0xffffffff80000000; 0x7fffffff] (u32)<op> [0; 0x1f]:OK
  #295/95  reg_bounds_crafted/(s64)[0; 0x1f] (u32)<op> [0xffffffffffff8000; 0x7fff]:OK
  #295/96  reg_bounds_crafted/(s64)[0xffffffffffff8000; 0x7fff] (u32)<op> [0; 0x1f]:OK
  #295/97  reg_bounds_crafted/(s64)[0; 0x1f] (u32)<op> [0xffffffffffffff80; 0x7f]:OK
  #295/98  reg_bounds_crafted/(s64)[0xffffffffffffff80; 0x7f] (u32)<op> [0; 0x1f]:OK
  #295     reg_bounds_crafted:FAIL
  
  All error logs:
  MISMATCH true_reg1.u64: 0x100000000 != [4294967294; 0x100000000]
  MISMATCH true_reg1.s64: 0x100000000 != [0xfffffffe; 0x100000000]
  VERIFIER LOG:
  ========================
  func#0 @0
  Live regs before insn:
        0: .......... (05) goto pc+2
        1: .......... (b7) r0 = 0
        2: 0......... (95) exit
        3: .......... (85) call bpf_get_current_pid_tgid#14
        4: 0......... (bf) r6 = r0
        5: ......6... (85) call bpf_get_current_pid_tgid#14
        6: 0.....6... (bf) r7 = r0
        7: ......67.. (18) r1 = 0xfffffffe
        9: .1....67.. (18) r2 = 0x100000000
       11: .12...67.. (ad) if r6 < r1 goto pc-11
       12: ..2...67.. (2d) if r6 > r2 goto pc-12
       13: ......67.. (18) r1 = 0x80000000
       15: .1....67.. (18) r2 = 0x80000000
       17: .12...67.. (ad) if r7 < r1 goto pc-17
       18: ..2...67.. (2d) if r7 > r2 goto pc-18
       19: ......67.. (bc) w0 = w6
       20: ......67.. (bc) w0 = w7
       21: ......67.. (ae) if w6 < w7 goto pc+3
       22: ......67.. (bc) w0 = w6
       23: .......7.. (bc) w0 = w7
       24: 0......... (95) exit
       25: ......67.. (bc) w0 = w6
       26: .......7.. (bc) w0 = w7
       27: 0......... (95) exit
  0: R1=ctx() R10=fp0
  0: (05) goto pc+2
  3: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
  4: (bf) r6 = r0                       ; R0=scalar(id=1) R6=scalar(id=1)
  5: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
  6: (bf) r7 = r0                       ; R0=scalar(id=2) R7=scalar(id=2)
  7: (18) r1 = 0xfffffffe               ; R1=0xfffffffe
  9: (18) r2 = 0x100000000              ; R2=0x100000000
  11: (ad) if r6 < r1 goto pc-11        ; R1=0xfffffffe R6=scalar(id=1,umin=0xfffffffe)
  12: (2d) if r6 > r2 goto pc-12        ; R2=0x100000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  13: (18) r1 = 0x80000000              ; R1=0x80000000
  15: (18) r2 = 0x80000000              ; R2=0x80000000
  17: (ad) if r7 < r1 goto pc-17        ; R1=0x80000000 R7=scalar(id=2,umin=0x80000000)
  18: (2d) if r7 > r2 goto pc-18        ; R2=0x80000000 R7=0x80000000
  19: (bc) w0 = w6                      ; R0=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff)) R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  20: (bc) w0 = w7                      ; R0=0x80000000 R7=0x80000000
  21: (ae) if w6 < w7 goto pc+3         ; R6=scalar(id=1,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001)) R7=0x80000000
  22: (bc) w0 = w6                      ; R0=scalar(smin=umin=umin32=0xfffffffe,smax=umax=0xffffffff,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x1)) R6=scalar(id=1,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001))
  23: (bc) w0 = w7                      ; R0=0x80000000 R7=0x80000000
  24: (95) exit
  
  from 21 to 25: R0=0x80000000 R1=0x80000000 R2=0x80000000 R6=0x100000000 R7=0x80000000 R10=fp0
  25: R0=0x80000000 R1=0x80000000 R2=0x80000000 R6=0x100000000 R7=0x80000000 R10=fp0
  25: (bc) w0 = w6                      ; R0=0 R6=0x100000000
  26: (bc) w0 = w7                      ; R0=0x80000000 R7=0x80000000
  27: (95) exit
  
  from 18 to 1: R0=scalar(id=2) R1=0x80000000 R2=0x80000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff)) R7=scalar(id=2,umin=0x80000001) R10=fp0
  1: R0=scalar(id=2) R1=0x80000000 R2=0x80000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff)) R7=scalar(id=2,umin=0x80000001) R10=fp0
  1: (b7) r0 = 0                        ; R0=0
  2: (95) exit
  
  from 17 to 1: R0=scalar(id=2) R1=0x80000000 R2=0x80000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff)) R7=scalar(id=2,smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff)) R10=fp0
  1: R0=scalar(id=2) R1=0x80000000 R2=0x80000000 R6=scalar(id=1,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff)) R7=scalar(id=2,smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff)) R10=fp0
  1: (b7) r0 = 0                        ; R0=0
  2: (95) exit
  
  from 12 to 1: safe
  
  from 11 to 1: safe
  processed 28 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 0
  =====================
  ACTUAL   FALSE1: scalar(u64=[4294967294; 0x100000000],u32=[4294967294; 4294967295],s64=[0xfffffffe; 0x100000000],s32=[0xfffffffe; 0xffffffff])
  EXPECTED FALSE1: scalar(u64=[4294967294; 0x100000000],u32=[4294967294; 4294967295],s64=[0xfffffffe; 0x100000000],s32=[0xfffffffe; 0xffffffff])
  ACTUAL   FALSE2: scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  EXPECTED FALSE2: scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  ACTUAL   TRUE1:  scalar(u64=0x100000000,u32=0,s64=0x100000000,s32=0)
  EXPECTED TRUE1:  scalar(u64=[4294967294; 0x100000000],u32=0,s64=[0xfffffffe; 0x100000000],s32=0)
  ACTUAL   TRUE2:  scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  EXPECTED TRUE2:  scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  verify_case_opt:FAIL:(u64)[4294967294; 0x100000000] (u32)< 2147483648 unexpected error: -22 (errno 22)
  #295/37  reg_bounds_crafted/(u64)[4294967294; 0x100000000] (u32)<op> 2147483648:FAIL
  MISMATCH false_reg2.u64: 0x100000000 != [4294967294; 0x100000000]
  MISMATCH false_reg2.s64: 0x100000000 != [0xfffffffe; 0x100000000]
  VERIFIER LOG:
  ========================
  func#0 @0
  Live regs before insn:
        0: .......... (05) goto pc+2
        1: .......... (b7) r0 = 0
        2: 0......... (95) exit
        3: .......... (85) call bpf_get_current_pid_tgid#14
        4: 0......... (bf) r6 = r0
        5: ......6... (85) call bpf_get_current_pid_tgid#14
        6: 0.....6... (bf) r7 = r0
        7: ......67.. (18) r1 = 0x80000000
        9: .1....67.. (18) r2 = 0x80000000
       11: .12...67.. (ad) if r6 < r1 goto pc-11
       12: ..2...67.. (2d) if r6 > r2 goto pc-12
       13: ......67.. (18) r1 = 0xfffffffe
       15: .1....67.. (18) r2 = 0x100000000
       17: .12...67.. (ad) if r7 < r1 goto pc-17
       18: ..2...67.. (2d) if r7 > r2 goto pc-18
       19: ......67.. (bc) w0 = w6
       20: ......67.. (bc) w0 = w7
       21: ......67.. (be) if w6 <= w7 goto pc+3
       22: ......67.. (bc) w0 = w6
       23: .......7.. (bc) w0 = w7
       24: 0......... (95) exit
       25: ......67.. (bc) w0 = w6
       26: .......7.. (bc) w0 = w7
       27: 0......... (95) exit
  0: R1=ctx() R10=fp0
  0: (05) goto pc+2
  3: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
  4: (bf) r6 = r0                       ; R0=scalar(id=1) R6=scalar(id=1)
  5: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
  6: (bf) r7 = r0                       ; R0=scalar(id=2) R7=scalar(id=2)
  7: (18) r1 = 0x80000000               ; R1=0x80000000
  9: (18) r2 = 0x80000000               ; R2=0x80000000
  11: (ad) if r6 < r1 goto pc-11        ; R1=0x80000000 R6=scalar(id=1,umin=0x80000000)
  12: (2d) if r6 > r2 goto pc-12        ; R2=0x80000000 R6=0x80000000
  13: (18) r1 = 0xfffffffe              ; R1=0xfffffffe
  15: (18) r2 = 0x100000000             ; R2=0x100000000
  17: (ad) if r7 < r1 goto pc-17        ; R1=0xfffffffe R7=scalar(id=2,umin=0xfffffffe)
  18: (2d) if r7 > r2 goto pc-18        ; R2=0x100000000 R7=scalar(id=2,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  19: (bc) w0 = w6                      ; R0=0x80000000 R6=0x80000000
  20: (bc) w0 = w7                      ; R0=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff)) R7=scalar(id=2,smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  21: (be) if w6 <= w7 goto pc+3        ; R6=0x80000000 R7=0x100000000
  22: (bc) w0 = w6                      ; R0=0x80000000 R6=0x80000000
  23: (bc) w0 = w7                      ; R0=0 R7=0x100000000
  24: (95) exit
  
  from 21 to 25: R0=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff)) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001)) R10=fp0
  25: R0=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff)) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001)) R10=fp0
  25: (bc) w0 = w6                      ; R0=0x80000000 R6=0x80000000
  26: (bc) w0 = w7                      ; R0=scalar(smin=umin=umin32=0xfffffffe,smax=umax=0xffffffff,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x1)) R7=scalar(id=2,smin=umin=umin32=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=-1,var_off=(0xfffffffe; 0x100000001))
  27: (95) exit
  
  from 18 to 1: R0=scalar(id=2) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,umin=0x100000001) R10=fp0
  1: R0=scalar(id=2) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,umin=0x100000001) R10=fp0
  1: (b7) r0 = 0                        ; R0=0
  2: (95) exit
  
  from 17 to 1: R0=scalar(id=2) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,smin=0,smax=umax=umax32=0xfffffffd,var_off=(0x0; 0xffffffff)) R10=fp0
  1: R0=scalar(id=2) R1=0xfffffffe R2=0x100000000 R6=0x80000000 R7=scalar(id=2,smin=0,smax=umax=umax32=0xfffffffd,var_off=(0x0; 0xffffffff)) R10=fp0
  1: (b7) r0 = 0                        ; R0=0
  2: (95) exit
  
  from 12 to 1: safe
  
  from 11 to 1: safe
  processed 28 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 0
  =====================
  ACTUAL   FALSE1: scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  EXPECTED FALSE1: scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  ACTUAL   FALSE2: scalar(u64=0x100000000,u32=0,s64=0x100000000,s32=0)
  EXPECTED FALSE2: scalar(u64=[4294967294; 0x100000000],u32=0,s64=[0xfffffffe; 0x100000000],s32=0)
  ACTUAL   TRUE1:  scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  EXPECTED TRUE1:  scalar(u64=2147483648,u32=2147483648,s64=0x80000000,s32=S32_MIN)
  ACTUAL   TRUE2:  scalar(u64=[4294967294; 0x100000000],u32=[4294967294; 4294967295],s64=[0xfffffffe; 0x100000000],s32=[0xfffffffe; 0xffffffff])
  EXPECTED TRUE2:  scalar(u64=[4294967294; 0x100000000],u32=[4294967294; 4294967295],s64=[0xfffffffe; 0x100000000],s32=[0xfffffffe; 0xffffffff])
  verify_case_opt:FAIL:(u64)2147483648 (u32)<= [4294967294; 0x100000000] unexpected error: -22 (errno 22)
  #295/38  reg_bounds_crafted/(u64)2147483648 (u32)<op> [4294967294; 0x100000000]:FAIL
  #295     reg_bounds_crafted:FAIL
  Summary: 0/96 PASSED, 0 SKIPPED, 1 FAILED

