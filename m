Return-Path: <stable+bounces-212990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Te9PCj8rf2mhlAIAu9opvQ
	(envelope-from <stable+bounces-212990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 11:30:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9E5C572B
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 11:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D6643011A56
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB82E54A1;
	Sun,  1 Feb 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="N6aId+6x"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD7280317;
	Sun,  1 Feb 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769941819; cv=none; b=U2vdO/bWw5Ko7llys8hLnNYkStQgvexc8VM71Cood/2vTIGVK30mywnXTmplGnqA5UDfzqfJS/eKdKJcmPLxXVrDIhUK3RdUEwqWQdNRLQc1LJnpb1hcNMs/qjsNEZj1KryWePGb8dt3Pm4C2YusIxCXqCEtmBOV+OvVhwVLcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769941819; c=relaxed/simple;
	bh=+kasj8jgbYPe4r1JdJmPUfIuPUZVfGZSX8ow4fFAIR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+f9lyQqUbvsQ4NlXy3H3wjKoKZe5yt54vIVF6ankSFRdBj+TMeoLWogyuiZm3ujtr3DeLUlYI6m/xK4jgA5HAqVwvodHUM0o1Z3QYcI/LCxmgQj1xKxOcSR+jUz2YBm/wdmuXGit8m2aUOQMftqLcBmZO1IoXNxTz3nK1/PRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=N6aId+6x; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=gZDElJ9ZcZR48Aeq9CU/w3Y1HCk2lc3NXhuQunR84Rc=; t=1769941818;
	x=1770373818; b=N6aId+6xpRCN42NpHAZNXp7RL0lM0UwU/1pdsXw8+awe2ikKRxy4nqwjdEm0k
	YjiZ7tXyY1sx0owG0WRtt2UhNx8+SFn1Gy6wUkDBGOuvvgxloKWhJAGIK1XDLx4ZqSO3NpeZtByuo
	bYWhDIFZSTR9a+oGRelYEJbCSPSs9QM9OOVEAt0IILpUZYxmVQHmwzFPx9RtkDDzvfL6hoErvC/lg
	ElzEBNMwOPJmbSVKCKaAfSBmy9p7pqU6GLUiogVe32RiHh3xVFuMjnNw0i7MdqnC9/uUcN21ak1KZ
	5KkGBaS8f0HJEQ9Uz6JZ8kCT9CNLtC4bjpuaOhjCKl9pEEnPbw==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vmUid-00EMA7-04;
	Sun, 01 Feb 2026 11:30:15 +0100
Message-ID: <c9a25ab3-663b-4935-ae11-a750c7bf3aa9@leemhuis.info>
Date: Sun, 1 Feb 2026 11:30:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: CONFIG_ASYNC_KERNEL_PGTABLE_FREE causes memory
 exhaustion and stalls on busy Cascade Lake server (6.18.7 only)
To: Robert Dinse <nanook@eskimo.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <06843c7a-909b-41e5-9359-2be51cf9dffa@eskimo.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <06843c7a-909b-41e5-9359-2be51cf9dffa@eskimo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1769941818;51db4a7a;
X-HE-SMSGID: 1vmUid-00EMA7-04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=he214686];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-212990-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leemhuis.info:mid,leemhuis.info:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A9E5C572B
X-Rspamd-Action: no action

Lo! Top-posting to facilitate processing and CCing the stable list,
maybe someone has heard of a problem.

Thx for the report. The big questions here is: Is that something that is
specific to 6.18.y or does it happen with mainline, too? And does it
still happen with the latest 6.18.y version (there were a few mm fixes)?
Without answers to this question nobody might look into this if we are
unlucky. And a bisection would be ideal, but I understand all that is
not easy if it takes 24h to detect the problem.

Ciao, Thorsten

On 1/29/26 07:10, Robert Dinse wrote:
> 
> Hardware / setup
> ----------------
> - CPU: Intel i9-10980XE (Cascade Lake), all cores overclocked to 4.5 GHz
> - Motherboard: Gigabyte Aorus Master X299
> - PSU: 1200W Seasonic
> - RAM: 256 GB
> - Storage:
>   - MariaDB: RAID1 of two 1 TB NVMe drives
>   - Other storage: RAID1 arrays of spinning disks
> 
> Software
> --------
> - OS: Ubuntu 24.04, with most userland and kernel replaced by self-
> compiled upstream
> - Kernel:
>   - 6.18.6: stable, previously in production
>   - 6.18.7: regression
> - Toolchain: gcc 15.2
> - Services:
>   - Apache 2.4.65 (self-compiled), with modified exec-php to allow per-
> user PHP versions via handlers
>   - MariaDB with ~60 GB of tables
>   - InnoDB buffer pool: ~70 GB
>   - Several social media sites and other complex web hosting workloads
> 
> Baseline behavior (6.18.6)
> --------------------------
> Under 6.18.6, the machine behaves as expected:
> - Roughly half of the 256 GB RAM in use, half available
> - Memory usage stable over time
> - Swap usage negligible
> - Web server and database remain responsive under normal production load
> 
> Regression behavior (6.18.7)
> ----------------------------
> After upgrading from 6.18.6 to 6.18.7, the system initially runs
> normally, but after
> approximately 24 hours of production load:
> - Total memory usage climbs until RAM is fully consumed
> - System goes ~10 GB into swap
> - Web server and database stall intermittently
> - Overall system responsiveness degrades severely
> 
> Reverting to 6.18.6 immediately restores the previous stable behavior.
> 
> Attempt to disable CONFIG_ASYNC_KERNEL_PGTABLE_FREE
> ---------------------------------------------------
> I attempted to disable the new async kernel page table freeing feature:
> 
> - The symbol `CONFIG_ASYNC_KERNEL_PGTABLE_FREE` appears in `.config`
> - However, it does not appear in xconfig or other configuration frontends
> - Manually editing `.config` to disable it works only until the next
> `make`:
>   - As soon as I re-run the build, the option is silently re-enabled
> - I tried to chase the Kconfig dependencies, but the chain was too
> convoluted; it appears to be effectively non-user-selectable and forced
> on by default for my architecture.
> 
> From an operator perspective, this feature as currently implemented is
> not workable on a busy machine like this, and the inability to disable
> it makes it difficult to bisect or run with a known-good configuration.
> 
> Current status
> --------------
> - I have reverted to 6.18.6, which remains functional and stable under
> the same workload.
> - I have attached the '.config' for the affected 6.18.7 kernel.
> - I can also collect additional data (vmstat, /proc/meminfo, slabinfo,
> etc.) if you tell me what would be most useful.
> 
> Request
> -------
> 1. Is this a known issue with CONFIG_ASYNC_KERNEL_PGTABLE_FREE on large-
> memory, high-load systems?
> 2. Is there a supported way to disable this feature on x86_64, or could
> it be made user-selectable for debugging/regression purposes?
> 3. Are there specific traces or statistics you would like me to gather
> when the system is in the "memory maxed + swap in use + stalls" state?
> 
> I’m happy to run test kernels or provide additional inform


