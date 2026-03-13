Return-Path: <stable+bounces-225249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uzM7Inahs2mjZAAAu9opvQ
	(envelope-from <stable+bounces-225249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:32:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED4827D72C
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4660F3057698
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A26E282F04;
	Fri, 13 Mar 2026 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jELeQrD0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yf3kcsmo"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B81A6813;
	Fri, 13 Mar 2026 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773379952; cv=none; b=N78i6nrsM3wULgZ3YI47kbsPX3RVkFd23TReQwn3Pavvk+500cMx5b92ovZfNbC5010SSmKhnPvku948/yCI3hiJ6lSR02xqKT0l/M87+J1b0B07uHLOLnrdkss0UeUgO1mMj7mFCDSFLYGpEyOw6jmMf9Ez6n6Ljo+NDXEhedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773379952; c=relaxed/simple;
	bh=apOFUO3H3jkqbxDHDe5W7fbNnTUbtClaKaSZ6Qmlxr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIrfduFJ4qlcU5fttWGnLvDgcMQJBvpDSp/kg66COQJGGT/HwO8s64rrYkME5+vwSCIbSGBH4vBZYJO4ufXG5YW5l6MeN3lCnNblw2alAmNhGJA+P9EHnTST/PwjcQBbXblZVgJ/MupaRJtVjnkhqnzRqjT83vTQsGLY+o1+m1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jELeQrD0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yf3kcsmo; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A0B87A00A6;
	Fri, 13 Mar 2026 01:32:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 01:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773379949;
	 x=1773466349; bh=rZTRBxqephOoWMBkxEMbJgTDhRv/OXNn6PolatqxmzQ=; b=
	jELeQrD0P254Za061WF1Xj47MSogQqshkjAz0y8QxU+StlCxop0msGQsDF+kNiNY
	PzO/7M0EzyEGlwDD6HgSyLp/7h8dVDVdPA55NopoNo9GTsBv+9q6p9qcmOt8ivEv
	DEzkViPNSNTjp72hrxLdugPgDHSt0PG68j5pXotw/8EQVDbu96E1njH9En1em1Xq
	EW9lVOLLQiCp7Rn64Tf+QFt5vTrhKI3MTJ37EG6EI7Qmrz4af9LEI8ggiW4DNb1L
	vRG5iTMMLMDy9TJndkn2eja32bajLuqducvV5/REVpfQv8RzxhBx27b6e70rwKvG
	I7RYANWZi5GZGPwi/RVfsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773379949; x=
	1773466349; bh=rZTRBxqephOoWMBkxEMbJgTDhRv/OXNn6PolatqxmzQ=; b=Y
	f3kcsmoo+wR4lC/wQGJyxnCQYXmPqwnVdK10b+XXG+QIiqtrcKnuZWPuzV2hlR2j
	qOyFOBups4uNKQFg/hcbc8MRURWltbJ+7uX8ql62yp0PrAJQBuez3QQ1NnTtXqNw
	Ma5Mw2QoHztJVagERlOw0vvkQQovyy6vOLB0DqgzOWXTpdZVtJg6iSJSPhDWB3DH
	rSKO9ZOgq+9ceyb90g9eUljeTfDUxXbvHnKHplY4h5fflnBJYVDzTAqhvBg3/dSA
	uuEZp05n9u0Owom5hik8iNv0LtbwgT00i44//dE9Y7ofpwxalPILpjtjAU4mqedU
	xLaPf6k4dfLNhvVQHZuKA==
X-ME-Sender: <xms:bKGzaaWHSldaRWZvcjDLcfLiEQGN-Mj_FHUiXQEM5W7y_LBs7de-9Q>
    <xme:bKGzaSdOuR5y4THkFWMoc19M7CtbH2pJW2zaM1j1_B8wagjnZoq7AGt3rvk26NFqZ
    TQbvdUQhT55JvgeruF-lkKgMTnKy1PI987__mhdQFwMeJDjEWQK3g>
X-ME-Received: <xmr:bKGzaZ43JXgmD7QJvewdfwOn0jpTWeEh8ul_x_7wbp2FPkL85zjACbhj6IuupvJACctua70cI1Zi7RBNa1IEFmTPAcubwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpedfuegrrhhr
    hicumfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtf
    frrghtthgvrhhnpeefleehkeehleekjeelffefhfdvleejteehledtieduffevteffleet
    gefgfefhjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrrhhrhihnsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrthgthh
    gvsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehroh
    gvtghkqdhushdrnhgvthdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehprghttghhvghssehkvghrnhgvlhgtihdrohhrgh
X-ME-Proxy: <xmx:bKGzaVSM6zT1-FIAlTDlewxEJ3jq8PsWaOZOrROw1q2NP2QLwewq4g>
    <xmx:bKGzacfwOdm6QCpshsFAZiMS7zCpyqxFkjrWMEGiEgz_RZVju3E9YA>
    <xmx:bKGzaVTlzdWAH-OdGopFgdUHYRoJYljnKJLwM6CS74AxxCGthpYxdQ>
    <xmx:bKGzaVM-7k9N5crjCEffyELBmMqZfZ6G-jbCXwZCe3mhusJlxALDXw>
    <xmx:baGzaeoeUFSGydiwIp-qK4S6ldm53JW0gak2UItVfigPE84PHtPh21t5>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 01:32:26 -0400 (EDT)
Message-ID: <b4f58774-18d4-4a32-9c85-603f9e2c98fc@pobox.com>
Date: Thu, 12 Mar 2026 22:32:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: freeze during boot regression Re: [PATCH 6.12 000/265] 6.12.77-rc1
 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260312201018.128816016@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-225249-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pobox.com:dkim,pobox.com:email,pobox.com:mid]
X-Rspamd-Queue-Id: AED4827D72C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 13:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.77 release.
> There are 265 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Mar 2026 20:09:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.77-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Intermittently, but significantly greater than 50% of the time,
6.12.77-rc1 fails to boot on my Lenovo ThinkPad T14 Gen 1 running Debian
12 bookworm. When boot fails, the last couple lines of console output
(retyped from a photo) are:

Loading, please wait...
Starting systemd-udevd version 252.39-1~deb12u1

I will begin bisection shortly. I happen to have also previously
compiled 6.12.76 + stable-queue as of
commit 4b2b2b5cf3cd78f4de4646687a4efecbd21643af, and that shows the same
boot failures. That means the following patches are *not* to blame for
the problem:

net-sched-only-allow-act_ct-to-bind-to-clsact-ingress-qdiscs-and-shared-blocks.patch
apparmor-validate-dfa-start-states-are-in-bounds-in-unpack_pdb.patch
apparmor-fix-memory-leak-in-verify_header.patch
apparmor-replace-recursive-profile-removal-with-iterative-approach.patch
apparmor-fix-limit-the-number-of-levels-of-policy-namespaces.patch
apparmor-fix-side-effect-bug-in-match_char-macro-usage.patch
apparmor-fix-missing-bounds-check-on-default-table-in-verify_dfa.patch
apparmor-fix-double-free-of-ns_name-in-aa_replace_profiles.patch
apparmor-fix-unprivileged-local-user-can-do-privileged-policy-management.patch
apparmor-fix-differential-encoding-verification.patch
apparmor-fix-race-on-rawdata-dereference.patch
apparmor-fix-race-between-freeing-data-and-fs-accessing-it.patch
ext4-fix-potential-null-deref-in-ext4_mb_init.patch
ata-libata-core-fix-cancellation-of-a-port-deferred-qc-work.patch
ata-libata-eh-correctly-handle-deferred-qc-timeouts.patch
ata-libata-cancel-pending-work-after-clearing-deferred_qc.patch
ata-libata-eh-fix-detection-of-deferred-qc-timeouts.patch

-- 
-Barry K. Nathan  <barryn@pobox.com>

