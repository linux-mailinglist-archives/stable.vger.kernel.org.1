Return-Path: <stable+bounces-217821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EFyHNiqnGklJwQAu9opvQ
	(envelope-from <stable+bounces-217821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 20:30:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8517C651
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18CD4314F99C
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6836AB60;
	Mon, 23 Feb 2026 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwBFTi+j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67300369220;
	Mon, 23 Feb 2026 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874568; cv=none; b=JCJKFXKQXU0KsTdNfurO+DfGR8KcJhA/ozWeRGnb/4H1J4Dxz9CLvAmvCRr/w4oj0qtcHRJISEyZn7BiHaC1fzv+Ag5Rca9mHP4y23UDHJ57TZilTyH2DJsLM02qwcCuFHG/FquwuFkKDWRXMJwDhHpu1ANimchPfxPvdu6Pr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874568; c=relaxed/simple;
	bh=plKh0vhFAV1CCQloPBtJoWRXH/4QhMTAJJiapz7xUko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aydNKxzFZg7LcJ4tyecZvxzo1ZgnIV5mVqgJnmE69En7RDtjAUJDHibZNDqOpAfFpbI+BAvRs6X2+p5T3Kg3td+e0LedFgByrRaxsD77S9BqDUmmgLLwdiWOszGAo3AAxtSmmZWWW0MsHSDTRfCQe6Goxnu1gd0dmZcWq0eDfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwBFTi+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843F0C116C6;
	Mon, 23 Feb 2026 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771874567;
	bh=plKh0vhFAV1CCQloPBtJoWRXH/4QhMTAJJiapz7xUko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwBFTi+jI6nIYpVkv9cQlf5P2O5/P+1Tk8AMRTUDLQSOLMJfVOy2KY/998ZZFFmfz
	 5p+CiMJ6fE4uY01XvY+UowrspICfehHGm1OkjbdKryflIvr9jkgjELzjmLnB1oMNaO
	 b06u9UP03YaNhYOCJpgqRxyir/EpQkQQ1LUbEmjk3DYrGCCM2HIOWA+c9ieExfxEHo
	 TvRRaQ6vrXYjEB0N2NrWFGzMV1U0UvZfTlVP5B8z3txbPU5SwNZdF/cZ/nfn94zSk2
	 0WO2Yox0Los7yi8uTEtTN70uIIiOpPpo83w9jq22dUMVa5vKgfZu4/aPE2EVmbzfPP
	 DwRc3ZD+MAsnw==
Date: Mon, 23 Feb 2026 14:22:45 -0500
From: Sasha Levin <sashal@kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Patch "s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP" has
 been added to the 6.1-stable tree
Message-ID: <aZypBeeZP3NAvQu4@laps>
References: <20260222235114.1339059-1-sashal@kernel.org>
 <20260223155255.41342222@thinkpad-T15>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260223155255.41342222@thinkpad-T15>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217821-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDF8517C651
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:52:55PM +0100, Gerald Schaefer wrote:
>On Sun, 22 Feb 2026 18:51:14 -0500
>Sasha Levin <sashal@kernel.org> wrote:
>
>> This is a note to let you know that I've just added the patch titled
>>
>>     s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>>
>> to the 6.1-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      s390-select-arch_want_hugetlb_page_optimize_vmemmap.patch
>> and it can be found in the queue-6.1 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Please don't add this to any stable tree. This feature is broken on s390,
>and it recently was removed upstream via commit 64e2f60f355e ("s390:
>Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP"), which also had a Cc: stable
>and Fixes: 00a34d5a99c0.
>
>So we'd rather want commit 64e2f60f355e added to stable v6.2+, than
>adding the original commit 00a34d5a99c0 to older trees.

I'll drop the entire series from 6.1.

-- 
Thanks,
Sasha

