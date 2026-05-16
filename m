Return-Path: <stable+bounces-248955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMNQBc6+B2qaGAMAu9opvQ
	(envelope-from <stable+bounces-248955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:48:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C4B5599AA
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D163F3007A46
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BCE24A044;
	Sat, 16 May 2026 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VU6+n2pJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DE2B9B7
	for <stable@vger.kernel.org>; Sat, 16 May 2026 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778892484; cv=none; b=RccPl5d8LFbHxmYux7U/H6ZWd1LKdqtFTkuDFMaHOXxe187uxbeMw0iHG5uyR1llvBxQf8emJF9JO9dlQYOU7snfQ7D1kj0io+U3KLmdZRKnTL6HOOlvezr1kxS+Rp8W6F/+u0AHqUDAXdr+1LVa16RToQ40NU0E3k6N+wBP9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778892484; c=relaxed/simple;
	bh=drDHN4Zg9cOOxdmNA9Mtsco7sGaHjsurCt5kmpxDGDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEAYIJAJwaGnTINOwHq+HCC6g1SxCIojv9mdVYt2kuZK3qynWu37FwozPODp1rKki5zOzsyoI3lx/2cYKdq/5L3J3/yD7Y0RnnXMw2PLHL9LpXc4Q/6ZlZNYDMwHhueVLEpM4yzGngnE0KSxjUEgLB17kXJH5br7dyKQvrn3ZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VU6+n2pJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48909558b3aso3478495e9.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778892481; x=1779497281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktNPJUhtUmCwD/xKtU4wmNTOqF7Ec1I7RC8ZgMrOzLU=;
        b=VU6+n2pJrSekfnBkN5tAGI4vYt71oVxLp3/VB9CDcalyE5tpLQPAcfw1XkwwY3x3pG
         GzOiD07qr6aexSDA+o84E/zraQ/SKmmerN7NqKTUUwIpKn7JN60Z5KpfYjJ6aCYxd7uG
         pV+iL1RYXavJ5vfPakCOPApmxcUoTYtvLLTYF0PL5xYVEY56dYjq/cGSVgrRzuft7DfE
         MZ7OMUh0lizh/clZ/kIyITnpsDq4bMpOuVLCYPtJJNd3csla3wDBDpU1kUac5/nj1JJS
         wukwSFLA8FiC5lI4WYSB83+zXADOJKz1B7U+Ar7iuTGB5gx4zbQXMEpHzj36YiyYx4aN
         DOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778892481; x=1779497281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktNPJUhtUmCwD/xKtU4wmNTOqF7Ec1I7RC8ZgMrOzLU=;
        b=Oxa6cfmvrCcxgWczyQmJj1NNobtT1n4i1CvrIjBmKZuvNrQfV5WsRGkSlyqTfgg5es
         n9aUSPgPOOpmPbkoLwlC1vhVSkjH26vCZO9Mk5jdvWUFNmQMH6ytiq+gj5Ryju72Y5/H
         Gep2EugTTeGkbbIUJbdeSmGLyuxhN6W2itdOPq5KMO2YDsXR5qivSU85BElNaNwN9L1P
         gvjEY9LRAsagzXVVOt39m0E6lWwKY7XgU5dsrem/35L14qE0vINwIoRkI6QMcBnTx+8G
         iPct+3c3ccbmdqih364gZQ6M17bFiub/UWCGrTeVodQQ7wnXzvUuTGF77jv40XYyLKQs
         eRAw==
X-Forwarded-Encrypted: i=1; AFNElJ9P1rwmDMwI4enmkL+KTCfbNATJIAMrxKsAxpkRS272COClAqaaYUAihjDewneJLHbQZKYgT7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNJEMJy7+GyGx3MhyeqG5xbr2gFAb1Hjiqso6zYA3iTpqPm7c
	SLToGu0FsONpl6Jtft+06rpwozAjGRxMOu7rc0kz3jWAW/TL5URruHU=
X-Gm-Gg: Acq92OE0vllkPEMw2jVlhISemz3OlSqf2TLcOwg0XNijs3rlIrhMeEjOKP8NUAntqxB
	7BTCjkSNkBFXjdJOkwc7xB2l1bBK9ofqwhXajHVXTCGOx4rZqorevC/CBplohoamKza4KBuNa5k
	DKKfH49wxSw6t1UVoEGDxi6FWvOSUEsQL2nL585G2h329W2ba7igZbaecXIasPF4skG9s3xKL9c
	IorQUMdVnqR17u4ERqsogd2/GpJ9LH5Y4PjcsC/3VJG/juSTYysLKAqaFwX4YeHso+UOkLWyReT
	vT2JNmI3gMYa1+37wZFFyzOn20OgYYYu6pjpagLs8VFHhd6xGpZQvzSkwP0uVKF9MX7hCONSSrg
	HNZysZPdJ1JyoakebUBTorjObhw10AY5l+NRww9fSgA6fKAAqpXGV/e6GR+4zs8V7E16lWon78A
	SYPqnNA7hG2hFyRbnd3vXeuSau0rIab+JPFtoQ/KTYaymZRmbB79B3tJMmjA8qNZUKrvM96bsKl
	6Y=
X-Received: by 2002:a05:6000:2288:b0:45d:4532:5d98 with SMTP id ffacd0b85a97d-45e5c57d2f2mr8066451f8f.8.1778892481036;
        Fri, 15 May 2026 17:48:01 -0700 (PDT)
Received: from [192.168.1.3] (p5b057eb2.dip0.t-ipconnect.de. [91.5.126.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm19280360f8f.10.2026.05.15.17.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 17:48:00 -0700 (PDT)
Message-ID: <508bf3b7-56c7-4290-b663-7daf8ed4e80d@googlemail.com>
Date: Sat, 16 May 2026 02:48:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 143/188] sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect
 isolcpus= domain isolation
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Andrea Righi <arighi@nvidia.com>,
 Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
References: <20260515154657.309489048@linuxfoundation.org>
 <20260515154700.426346174@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260515154700.426346174@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 21C4B5599AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248955-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,googlemail.com:mid,googlemail.com:dkim,linus:email]
X-Rspamd-Action: no action

Hi Greg,

Am 15.05.2026 um 17:49 schrieb Greg Kroah-Hartman:
> 6.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Andrea Righi <arighi@nvidia.com>
> 
> commit 6ae315d37924435516d697ea7dde0b799a5928e0 upstream.
> 
> scx_enable() refuses to attach a BPF scheduler when isolcpus=domain is
> in effect by comparing housekeeping_cpumask(HK_TYPE_DOMAIN) against
> cpu_possible_mask.
> 
> Since commit 27c3a5967f05 ("sched/isolation: Convert housekeeping
> cpumasks to rcu pointers"), HK_TYPE_DOMAIN's cpumask is RCU protected
> and dereferencing it requires either RCU read lock, the cpu_hotplug
> write lock, or the cpuset lock; scx_enable() holds none of these, so
> booting with isolcpus=domain and attaching any BPF scheduler triggers
> the following lockdep splat:
> 
>    =============================
>    WARNING: suspicious RCU usage
>    -----------------------------
>    kernel/sched/isolation.c:60 suspicious rcu_dereference_check() usage!
> 
>    1 lock held by scx_flash/281:
>     #0: ffffffff8379fce0 (update_mutex){+.+.}-{4:4}, at:
>         bpf_struct_ops_link_create+0x134/0x1c0
> 
>    Call Trace:
>     dump_stack_lvl+0x6f/0xb0
>     lockdep_rcu_suspicious.cold+0x37/0x70
>     housekeeping_cpumask+0xcd/0xe0
>     scx_enable.isra.0+0x17/0x120
>     bpf_scx_reg+0x5e/0x80
>     bpf_struct_ops_link_create+0x151/0x1c0
>     __sys_bpf+0x1e4b/0x33c0
>     __x64_sys_bpf+0x21/0x30
>     do_syscall_64+0x117/0xf80
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> In addition, commit 03ff73510169 ("cpuset: Update HK_TYPE_DOMAIN cpumask
> from cpuset") made HK_TYPE_DOMAIN include cpuset isolated partitions as
> well, which means the current check also rejects BPF schedulers when a
> cpuset partition is active. That contradicts the original intent of
> commit 9f391f94a173 ("sched_ext: Disallow loading BPF scheduler if
> isolcpus= domain isolation is in effect"), which explicitly noted that
> cpuset partitions are honored through per-task cpumasks and should not
> be rejected.
> 
> Switch to housekeeping_enabled(HK_TYPE_DOMAIN_BOOT), which reads only
> the housekeeping flag bit (no RCU dereference) and reflects exactly the
> boot-time isolcpus= configuration that the error message refers to.
> 
> Fixes: 27c3a5967f05 ("sched/isolation: Convert housekeeping cpumasks to rcu pointers")
> Cc: stable@vger.kernel.org # v7.0+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   kernel/sched/ext.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4906,8 +4906,7 @@ static int scx_enable(struct sched_ext_o
>   	static DEFINE_MUTEX(helper_mutex);
>   	struct scx_enable_cmd cmd;
>   
> -	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
> -			   cpu_possible_mask)) {
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
>   		pr_err("sched_ext: Not compatible with \"isolcpus=\" domain isolation\n");
>   		return -EINVAL;
>   	}
> 
> 


This patch causes a build failure for me:

   CC      kernel/sched/build_policy.o
In file included from kernel/sched/build_policy.c:62:
kernel/sched/ext.c: In function ‘scx_enable’:
kernel/sched/ext.c:4924:34: error: ‘HK_TYPE_DOMAIN_BOOT’ undeclared (first use in this function); did you mean 
‘HK_TYPE_DOMAIN’?
  4924 |         if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
       |                                  ^~~~~~~~~~~~~~~~~~~
       |                                  HK_TYPE_DOMAIN
kernel/sched/ext.c:4924:34: note: each undeclared identifier is reported only once for each function it appears in
make[4]: *** [scripts/Makefile.build:287: kernel/sched/build_policy.o] Fehler 1
make[3]: *** [scripts/Makefile.build:544: kernel/sched] Fehler 2
make[2]: *** [scripts/Makefile.build:544: kernel] Fehler 2
make[1]: *** [/usr/src/linux-stable-rc/Makefile:2024: .] Fehler 2
make: *** [Makefile:248: __sub-make] Fehler 2
root@linus:/usr/src/linux-stable-rc#

If I revert this patch, the build succeeds, and the kernel boots and seems to work fine without any observable regressions.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

