Return-Path: <stable+bounces-249037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eeDbJJ3RCGoD6wMAu9opvQ
	(envelope-from <stable+bounces-249037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 22:20:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BEF55DA9B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 22:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E6A73006096
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CDC375F8A;
	Sat, 16 May 2026 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DjJm/jU1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943662F60CC
	for <stable@vger.kernel.org>; Sat, 16 May 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962833; cv=none; b=kwMZWkmYJYUkxbuyydnXHBSxEeGkCZWRlTT4rrgBekwISLRWxe6X+BoxlxNMRcSUr0qCZL9/3GQFbn5e7Ptc2Iuz7w253GmjJJssFderrUZ0qyxs5MKJO0AIKhbxwh6vS6x4wxHo0TP44gmqx5qgngdkXrWKZSdEV46AD0Ia/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962833; c=relaxed/simple;
	bh=LglJJ9OIp8+ohVxToRs+s3JszhrdE8G6xx4i5lvqGTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPNvcewIueIbTiXeAdwLZHZL+nQRVE1dIxUkqg/zqhipC+HYrY0gRIYC14G5V+RdOgaFC4oi3XvSv/bE50+PT6hgd8IernU8jEsfgOFiy8IJYKqFL+6p2HIVsOO9vF9C8mJvC8lrXopsK5UFiqZQV14kMlwM4UdSsAyJfSLKcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DjJm/jU1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso5183865e9.0
        for <stable@vger.kernel.org>; Sat, 16 May 2026 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778962829; x=1779567629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFENqpptTunepZjrSFyTPYxIM1W/QMJyOTAEMQ2QQOU=;
        b=DjJm/jU1SH5zqQH8NLnTt98JeVZlnlSVNAAWjZJI2r2DNLvmegSD0PnLCC6+Fxlap7
         dTh7h/KsZRxi5IIMA5yBYP+8fsvlqpDgperpMBq/+DiPuEqL2nHi00MxjcrQW9i3oDAL
         KloIQev9hWjFOvQU7mohEzsL4yERxhMFCv8IdS1cusAesjJTDivnW8LXVFpBEBDc+1wq
         pX32rxqZ9gkM03nyXM0/aQm1LWEuAWojsAmbPAkK7TbEXUFIc6kQ6wPMEGATX7q34KXw
         t3tysoE6gglGbDXB6z5TTtIa3+D0GkGd9az3qfvIqXqa7tglTdJSOPTL2qU/m1vMQgfQ
         NhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778962829; x=1779567629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFENqpptTunepZjrSFyTPYxIM1W/QMJyOTAEMQ2QQOU=;
        b=YVtauCjMZ5T7Y/C/vReCTn6pzvdZ9rpQMQKVi5GwT/2921/I5bVbd2BPdwWCGv8uA7
         qkpeIv0qBop90eHsSuhu7vGqmOFeuXgq4lSSqKZzyWbUC4BTOPXAFLlep4rh3aGh0Tyf
         0w1hKTD0MJ1wdQh9RKFp8sISMlWGAp9F/6+k2GpHAj428ubPMIMcJMdtwDY+EYbrdqmP
         deJd5jQRxfR5Pup2yl7YgjBs1Z5lPwGABzW54Swt6Y7CIxPDwPshB9SMa7WxBgI8c3f5
         LnS0l7/x7JbtYpiD09BrZXcsCeXO6dUlH8ygesujtV190yS8/sWblocZFAI9HXSmj5AS
         +M1w==
X-Forwarded-Encrypted: i=1; AFNElJ/NgznBlfxAZYBHOVvulkj6jQVti2S+j8YTADhXi7zkuTKR5JTFj5QOqURzjz3eNOVapUOhnQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCpAzSl18P82AkNsIOmgPfgVvxhhWw/Wfv+KVfRB93zCGq0Yg
	dUOrn9wEZSvlDoNQrnOL9r3+br0gtdAQNcO0Nmi7QU60aQiIRVSDPBo=
X-Gm-Gg: Acq92OEiTNEZ4aAHLVpS4ngn2LMBdENnekqP9ygajCAMCn9+HlFQ2PR9wyEcgmG3s2p
	R5CuxmqlfDhlepDpNDAMRH82D9lGo7tOIjbDXzAmuHwskNMgifYvApMGtM8ZGdWisqf1+1dkj4s
	Q6N5hX0HxnPNXslMGHXqLE35ktHiQLK2qaYFoOklqKU2VpzvdK2bN70lMgjY7DEiGxeq+GFUx02
	PSLyQSaAMxauPpOBwSXZjJo9q41x+U6J3rO/l+Nk/2K5lZqQkM+PhO8sTRADz1ltTbS6g1tJr2i
	jqQJAJ6nTp01r5kYRmAxxOGdUrEjC0Whmsie0ZmeSZmnLJcXcI58Rbm3Hhsab2Dl45OUu/JiS3i
	ftu9UHmzbz3i8f8/XatTBXpMUkvWpk1BBKAVCT7bujKuy/MZG1j+K4bqxuTBlfU5sk9AA++D2f8
	r8uPdUv/+LPdzOWVXKb0f81WbU1UfaFPSgJkBCWE/r6yBnwT9XCKU7WhgxAb81EuMwzr/7ee9fl
	tU=
X-Received: by 2002:a05:600c:c096:b0:48f:d1b8:9aad with SMTP id 5b1f17b1804b1-48fe5fd5357mr93453995e9.2.1778962828770;
        Sat, 16 May 2026 13:20:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4b92.dip0.t-ipconnect.de. [91.43.75.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm61734025e9.3.2026.05.16.13.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 13:20:28 -0700 (PDT)
Message-ID: <382baa32-8fe2-4c3e-bbb9-87955fb2d0dc@googlemail.com>
Date: Sat, 16 May 2026 22:20:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/144] 6.12.90-rc1 review
To: Wentao Guan <guanwentao@uniontech.com>
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, gregkh@linuxfoundation.org,
 hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org,
 patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
 shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
 sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org
References: <a56911f8-9c02-464e-b61c-0d565a5dbd43@googlemail.com>
 <20260516180941.704379-1-guanwentao@uniontech.com>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260516180941.704379-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 81BEF55DA9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-249037-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Am 16.05.2026 um 20:09 schrieb Wentao Guan:
>> Am 16.05.2026 um 12:09 schrieb Greg KH:
>>> On Sat, May 16, 2026 at 03:07:14AM +0800, Wentao Guan wrote:
>>>> Build failed, you can drop the commit to build ok, same as 6.18.30-rc1:
>>>> git revert 14d9ce90cf4855d638ecbcdb0c208a144d6f991b..
>>>> Revert "sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation"
>>>>
>>>> Tested-by: Wentao Guan <guanwentao@uniontech.com>
>>>>
>>>> BRs
>>>> Wentao Guan
>>>>
>>>> defconfigs:
>>>> https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9
>>>>
>>>> Log:
>>>> In file included from kernel/sched/build_policy.c:63:
>>>> kernel/sched/ext.c: In function ‘scx_ops_enable’:
>>>> kernel/sched/ext.c:5524:34: error: ‘HK_TYPE_DOMAIN_BOOT’ undeclared (first use in this function); did you mean ‘HK_TYPE_DOMAIN’?
>>>>    5524 |         if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
>>>>         |                                  ^~~~~~~~~~~~~~~~~~~
>>>>         |                                  HK_TYPE_DOMAIN
>>>>
>>>> missed HK_TYPE_DOMAIN_BOOT is introduced in this commit:
>>>>
>>>> commit 4fca0e550d506e1c95504c2d9247bc92bf621bf6
>>>> Author: Frederic Weisbecker <frederic@kernel.org>
>>>> Date:   Mon May 26 13:06:21 2025 +0200
>>>>
>>>>       sched/isolation: Save boot defined domain flags
>>>>
>>>>       HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
>>>>       but also cpuset isolated partitions.
>>>>
>>>>       Housekeeping still needs a way to record what was initially passed
>>>>       to isolcpus= in order to keep these CPUs isolated after a cpuset
>>>>       isolated partition is modified or destroyed while containing some of
>>>>       them.
>>>>
>>>>       Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>>>>
>>>>       Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>>       Reviewed-by: Phil Auld <pauld@redhat.com>
>>>>       Reviewed-by: Waiman Long <longman@redhat.com>
>>>>       Cc: Ingo Molnar <mingo@redhat.com>
>>>>       Cc: Marco Crivellari <marco.crivellari@suse.com>
>>>>       Cc: Michal Hocko <mhocko@suse.com>
>>>>       Cc: Peter Zijlstra <peterz@infradead.org>
>>>>       Cc: Tejun Heo <tj@kernel.org>
>>>>       Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>       Cc: Vlastimil Babka <vbabka@suse.cz>
>>>>       Cc: Waiman Long <longman@redhat.com>
>>>>
>>>
>>> Also dropped from here, thanks.  My fault, I should have only backported
>>> this to 7.0.y as the commit itself said to.
>>>
>>> greg k-h
>>
>>
>> Now I really wonder why I didn't hit this build error with that patch included in 6.12.90-rc1...
>> Because I hit it in 6.18.32-rc!
>>
>> Let me check my .config ...
>>
>> Beste Grüße,
>> Peter Schneider
> 
> Hello,
> 
> I thought that 'CONFIG_SCHED_CLASS_EXT' is what you found,
> and it is depends include 'DEBUG_INFO_BTF' which depend pahole (maybe missed).
> 
> BRs
> Wentao Guan


Yes, you are absolutely right!

I do all my tests on one of my Proxmox maschines which by default run some x.y.z-pve Kernel, and I always use the 
.config of the closest PVE kernel as template for the .config of the kernel I want to test.

So for 6.12.90-rc1 I copied config-6.11.11-2-pve and did a "make olddefconfig", and 6.11 did not have 
CONFIG_SCHED_CLASS_EXT yet at all, so I ended up testing with CONFIG_SCHED_CLASS_EXT not set.

While for 6.18.32-rc1, I copied config-6.17.13-9-pve and did "make olddefconfig", and 6.17 already had that 
functionality (I guess since mainline 6.12), and so for that version, I had CONFIG_SCHED_CLASS_EXT=y


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

