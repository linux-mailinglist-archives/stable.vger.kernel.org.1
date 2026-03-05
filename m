Return-Path: <stable+bounces-223264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH4tGt7MqWl+FQEAu9opvQ
	(envelope-from <stable+bounces-223264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 19:35:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4386217028
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 19:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 413E9303FDC9
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AEF3BA256;
	Thu,  5 Mar 2026 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BDvc7V7F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DB1F4174
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735644; cv=none; b=CJ5xSduDbhESjm0V0oz3TluE9G76SyiuIIuXnIsDWfRNUhXcGjCQz9Fs1QgyjDKPRUf/tlvnNZ5qU7O5CqdPx1Njri3yZ8skSJQMDQAoxqkyRKuoPM+O6ksItZkitKRByr8tyqD1s2snfA+E/aEJ5V86b6SFXN6+vX5+17DcS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735644; c=relaxed/simple;
	bh=J0HP+5ENR1QV+1ZGCLvC4TEmiIlsE8QUrfYZkIKos3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fbs17tSIGXpRLuqsMVhoGG1Gh+0ae+OND6cy7dp/q7w0U6gMKXMUO831oQgxOrwtH9ocltpig4YCQ6HOEcXzuY3yQRHs4HwF3nJimkNkeazhvumxfGNN8exm9Gk7T6bvjWiwUMmB2jQXSFuEOU9tgB+2VUK0XK2HMAE918saEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BDvc7V7F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso56170465e9.0
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 10:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772735641; x=1773340441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mqPAOzOysho/ezOz12+BB7MvdXX3s0v3na6yaX6VKaE=;
        b=BDvc7V7F/a34NC+5RD4WUFrOffhHnaa/z7dUncienTXC2E3//UKasDpIgiHdZtSwMA
         uklgb0nY2Uf9+zLzOoRSXS76nnf8n11tBfJuT1R6Jgd314vARzBmQCDvbvCubdANmU7q
         i/pz7aoSyPPh4TOZIr2T+6104j2m8K/h+CsLK01mQJBf+ZUZu2d7LG2cIxfde+k5G7x3
         NiRIvH1sNNw4g9ldjOO+LGYsBI8c7AwQ4HGjxXx3gMedHuBnXLT2PgqtSCuVtW8svnG8
         3FJ8ovmifPiJbcT/I/JdyyoJcM0SsE7BpFDSuc/ZeW+UnL0t5RjuP4kzf5a9WWt6UByY
         yOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735641; x=1773340441;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqPAOzOysho/ezOz12+BB7MvdXX3s0v3na6yaX6VKaE=;
        b=SZKk18P8qcBOeE9qQyMnCHV+bXMKcCZIZPmZic2dDXVliSs0lemCMtX3SmJK5XczRq
         BIClDyDsBncfCcJVkHj/70GkYEnYSb7MPUPol54a/Iz+K9qVmliod8X4qz7QxKIoD9wq
         vbjYZZmz9HomwvDLprtvwrNvVEtPZRfGD/clkd7/09Fp665KzGMwbHD/X8o9zkhpErtB
         fRlKjJEz56yTxg4Q153GtIIRcdPD3jB905EFpjtQgVndHgRnXeKgGy6hzXAbFV8oy9c4
         YdT82E6LpW6flecOWKvpAoJT+JJxQ2pQXHLDNU6k0zs+KY31/BuUYgM84dod6iJG1EMp
         7Zew==
X-Forwarded-Encrypted: i=1; AJvYcCWCF04/7LXEVCePOC7VeXM0kq7/bGD5VSThAq8kL84C46UEfy8My0ASinOEfh+hFGJeVyfd++U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZPt0g3T1sRr+vJ4LktTERgzP3ak8V/HEZypCrYdMqjZCPkTw
	qbiZMJp6r19Eck7xWjOtdTif7FQPUngy2l9fUxjLU+8x5YfRBErmE7srGiqoi5aHYdo=
X-Gm-Gg: ATEYQzzexS6Cp5hUJcELx5b5Rxof9JWXHby4O3XrTlJVQ5UDNV4FzG3VhwY70az+DrF
	727Iy8Yiw9U0GwTFr4rTUzAML6K/FXNoCETVgz5p6OXz2e5P1CdwqMovODsXfCGy590YPrlPOHu
	A05q9Lr0z1MiB2wfpKbmnucSHotCQ8sfj02mR2XwMRKw8omvRucCalMkB/BqdqzaNI8Au1NhQp1
	UYTFa5aiqDYSBvlp0gaTy8qZvUscle4/j75P6A7VJqXWjOn9khXfTOlnrjvHfmkfxW/yKv972oE
	n0EhFriQhfrFU2JQQKzawaRau7mHibKCPpEtbx0U6y8+J6dMPo+CoeCqgTAiLwpaHmz2eOqX2SL
	YnHU5vE4gtRbVgoO6M4Xf+ex95og9hNpId074bHm05angJwOopvn6tYzOkoo1Y4rt4/oS3KO6Bx
	6FVVHeg7Fh5g+fp3v9skpk4lKznTDuE9IQVFb92CSucKeYqyor
X-Received: by 2002:a05:600c:a08b:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4851eea3fd6mr49362165e9.15.1772735641149;
        Thu, 05 Mar 2026 10:34:01 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.67.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485237f330bsm1145215e9.17.2026.03.05.10.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 10:34:00 -0800 (PST)
Message-ID: <4a15470a-5a10-4742-9faf-f66a88105d58@suse.com>
Date: Thu, 5 Mar 2026 20:33:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
To: Kai Huang <kai.huang@intel.com>, dave.hansen@linux.intel.com,
 pbonzini@redhat.com, seanjc@google.com, kas@kernel.org
Cc: rick.p.edgecombe@intel.com, tglx@kernel.org, bp@alien8.de,
 mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
 <20260302102226.7459-2-kai.huang@intel.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260302102226.7459-2-kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4386217028
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-223264-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nik.borisov@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 2.03.26 г. 12:22 ч., Kai Huang wrote:
> TDX can leave the cache in an incoherent state for the memory it uses.
> During kexec the kernel does a WBINVD for each CPU before memory gets
> reused in the second kernel.
> 
> There were two considerations for where this WBINVD should happen.  In
> order to handle cases where the cache might get into an incoherent state
> while the kexec is in the initial stages, it is needed to do this later
> in the kexec path, when the kexecing CPU stops all remote CPUs.  However,
> the later kexec process is sensitive to existing races.  So to avoid
> perturbing that operation, it is better to do it earlier.
> 
> The existing solution is to track the need for the kexec time WBINVD
> generically (i.e., not just for TDX) in a per-cpu var.  The late
> invocation only happens if the earlier TDX specific logic in
> tdx_cpu_flush_cache_for_kexec() didn’t take care of the work.  This
> earlier WBINVD logic was built into KVM’s existing syscore ops shutdown()
> handler, which is called earlier in the kexec path.
> 
> However, this accidentally added it to KVM’s unload path as well (also
> the "error path" when bringing up TDX during KVM module load), which
> uses the same internal functions.  This makes some sense too, though,
> because if KVM is getting unloaded, TDX cache affecting operations will
> likely cease.  So it is a good point to do the work before KVM is
> unloaded and won't have a chance to handle the shutdown operation in the
> future.
> 
> Unfortunately this KVM unload invocation triggers a lockdep warning in
> tdx_cpu_flush_cache_for_kexec().  Since tdx_cpu_flush_cache_for_kexec()
> is doing WBINVD on a specific CPU, it has an assert for preemption being
> disabled.  This works fine for the kexec time invocation, but the KVM
> unload path calls this as part of a CPUHP callback for which, despite
> always executing on the target CPU, preemption is not disabled.
> 
> It might be better to add the earlier invocation logic to a dedicated
> arch/x86 TDX syscore shutdown() handler, but to make the fix more
> backport friendly just adjust the lockdep assert in the
> tdx_cpu_flush_cache_for_kexec().
> 
> The real requirement is tdx_cpu_flush_cache_for_kexec() must be done on
> the same CPU.  It's OK that it can be preempted in the middle as long as
> it won't be rescheduled to another CPU.

TLDR: It wants migration disabled.

> 
> Remove the too strong lockdep_assert_preemption_disabled(), and change
> this_cpu_{read|write}() to __this_cpu_{read|write}() which provide the more
> proper check (when CONFIG_DEBUG_PREEMPT is true), which checks all
> conditions that the context cannot be moved to another CPU to run in the
> middle.
> 
> Fixes: 61221d07e815 ("KVM/TDX: Explicitly do WBINVD when no more TDX SEAMCALLs")
> Cc: stable@vger.kernel.org
> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>


So how exactly does this patch prevent the BUG: printk in 
check_preemption_disabled from triggering, if the lockdep assert was 
triggering?

