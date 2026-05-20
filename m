Return-Path: <stable+bounces-253395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDIpE7FDDmrV9QUAu9opvQ
	(envelope-from <stable+bounces-253395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:28:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A225059CBFC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2977234070C0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15983806DA;
	Wed, 20 May 2026 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIyln670"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB2348C5C
	for <stable@vger.kernel.org>; Wed, 20 May 2026 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313613; cv=none; b=NSOTTqemwyJJ8ul1xLP2qgzmoWSisKFzhDas0xypRxKQDtKln9LC0X9s4HeMpIPAXbic1Ex5FQwPBT6s+M33kMwnuJ5+d3TTT6soPQQMXfLMedL2ngOGsfEGvu+5hB4kyvuTwszT3AFAZgonwI09N4EbwnDJdCrGQuY9XVtBE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313613; c=relaxed/simple;
	bh=UXjrHToxSQU9FpY3EynRDNHR+WYdXBKMEWN9piIrWws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hd6t4fLtL4A4LLObt62dEao+57kXAoPpDn1tt7BrYbC5+TxmJg5T/ZZlQZXRMUEUsziDVVbQ4UVGc9othYDaB+E6JfrkqMGTrDCajdefI7rEuQslbQM9poTAhOrQ6uJFsjP3LLYGPu8dR/9EjWjSeSzRa3Vj7+oIwCjSpeP+2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIyln670; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-303f2fb7225so3653687eec.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 14:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779313611; x=1779918411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amUvCdBE0GwzwMhCPkPPp5DXmMOrBh3zemY8l9WgYno=;
        b=sIyln670c8dOTl30EQRdQoKTPBh8qdTfzMZKejXEElbDfmX8uB26QA8xsmNu7n/3gk
         AldoUeg6wcEL+qf07iPBCDnc/JvetGKjji1ipc+vxwJie1uCeIO83HgQUTVCv0u6SL/H
         BfI+irDVsdOcfNwk7KexMoDAH1em5V0PYwdXT+0eVg9ywAezheXC0qZRh1Q7EwKWQS7i
         iauGBHQz51qx7lt44Aii8/as556jZrfErkWVGWJkSzMNLdByfQJXM1FBzLAycqWEwmYg
         IpeGYQqcNPNRvgan+hZus5uLdq9tam6d0pyktjyutbEHGG1hOXAnIv7ofTDyJaM0y4GY
         xeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313611; x=1779918411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amUvCdBE0GwzwMhCPkPPp5DXmMOrBh3zemY8l9WgYno=;
        b=cSg6GgIrrf5tGGp8Fslf4Sq9GXidZ0TO+SAj5/yJ7ygcgimOF+zSfowmOER2t6QZxX
         mDHnYjSS9R084alJFXouT5sh3uP7tk0cdmhzPdlx7t8gGsJqYITfIks/4+CUVPXS13ER
         eXQUqaheySJWpAW+xZanAOCpe/IzCZx0V54wyZRtTQ2p0aIMWk7ynJnVU29ivmaZPY2p
         IWeVh/omM7IBXbsYMAb3sBCs+F62oBhVpvqbXFneYI4+bxTK7iMT/7p/dwzSrPDxd90f
         b24BYvjeffNXdw92n22zUpFyNh1hk2wLkgm5amAjDxieevorgyE3MtrdGMjFgdDZ7dvf
         8prw==
X-Forwarded-Encrypted: i=1; AFNElJ+Q9fSdkYPaZa1fl2IT2LVZtMJrpE/CxAai9Ml7lbb8C79/HGZP1h2zds1ro8XTt6kROw7WIW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+v9G9C4oi7mxDYd0bpA4RmI/oyAwbE++YsLZZhIcc4bouYOu
	LJ7ZRHBYxFHQROBH+s+TPph+qjBk0Sr9HuadNXTtRWnKzHDdSxVS52pdCeqapg==
X-Gm-Gg: Acq92OF+HcFEKEWwCBwhJEtlzZVxKtMIcP00OKd1+4RkrNFHZPuHBzfwCu19Ge5H8/q
	1Qo/mkRMy0iipmXCBAXDd9lnrn9WXm0Jpi5NAGAAduNQaXuI6VHh/fSvSyfe2FpD5fwAvILsidc
	Bsj7v7TZB7y0GFyIJbGhEWHHghgsYcnl0nHZY1NPfkRWa7s7D6+sUTGJrjAc/C59R8mTqe+9UnV
	Q4gRdGLRWbz3NKe7SAGI7CijYJh94Kk1zXANGpibsvqzXLWmx4R/rbvqlOsnYjkbbTtYO+1FA7u
	Q5Ub7Ez3TclDuIVJHMVfU2IO0FIlJsqZ998vAxspyUWzaM7/gds/RZhcd0rbbZw3kr9raT6vfnc
	7LimIektM88/kPy678eQxShPaYARLGF+4x7g9RHG17q+vF8hiWqN3k5jgZM54b/dh4saCFLILdq
	59b3q9EJxNWlIQRtmbw/YYUPXjyI+rlYqg2wyvdlrTHo2LVRhHCPqqRue/53Ik
X-Received: by 2002:a05:7301:eaa:b0:2ff:c611:82c7 with SMTP id 5a478bee46e88-3042f595735mr294810eec.12.1779313611280;
        Wed, 20 May 2026 14:46:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm23595618eec.5.2026.05.20.14.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 14:46:50 -0700 (PDT)
Message-ID: <54f12da1-32e2-48dc-bf84-3bdaf8ef0f6a@gmail.com>
Date: Wed, 20 May 2026 14:46:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/666] 6.12.91-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260520162111.222830634@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253395-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A225059CBFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 09:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.91 release.
> There are 666 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.91-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build on ARM/ARM64/MIPS with:

In file included from libbpf.c:54:
libbpf.c: In function 'bpf_object__elf_init':
libbpf.c:1538:76: error: implicit declaration of function 'errstr'; did 
you mean 'strstr'? [-Werror=implicit-function-declaration]
  1538 |                         pr_warn("elf: failed to open %s: %s\n", 
obj->path, errstr(err));
       | 
            ^~~~~~
libbpf_internal.h:167:47: note: in definition of macro '__pr'
   167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
       |                                               ^~~~~~~~~~~

this is due to commit 2e81d08459c32c57d037ad160e755bcfe6d5003b
Author: Mykyta Yatsenko <yatsenko@meta.com>
Date:   Mon Nov 11 21:29:17 2024 +0000

     libbpf: Stringify errno in log messages in libbpf.c

     [ Upstream commit 271abf041cb354ce99df33ce1f99db79faf90477 ]


we would need to backport the below commit, but it does not apply 
cleanly to 6.12.y:

commit c68b6fdc3600466e3c265bad34d099eb8c5280f1
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Wed Oct 1 10:13:24 2025 -0700

     libbpf: move libbpf_errstr() into libbpf_utils.c
-- 
Florian

