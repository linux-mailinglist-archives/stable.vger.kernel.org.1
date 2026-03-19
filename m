Return-Path: <stable+bounces-227289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM6eLOD3u2koqwIAu9opvQ
	(envelope-from <stable+bounces-227289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:19:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1882CBD31
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8AB30B67C1
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E043D34B7;
	Thu, 19 Mar 2026 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKlmN21x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570B3A1E70;
	Thu, 19 Mar 2026 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926333; cv=none; b=L2oA71FQ9wW0pIbJ6mjkq1Ee7L1DBQKPP//CoAK3RMrIO0M8RJB35g0Zg2DWkv/XAdYsPmyG7/tXQJw+lA0KSpYK9uN6d/gQSsPa0NV0azEctKyFUZtoyvse9Sqp9h3tgWNbapf3Gz/3lxw/wzpj32KQbODB+GXbg2EjlWNhXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926333; c=relaxed/simple;
	bh=DBeq6ynyMBT7SGVxMF7nNxXLpd+5i5Ws71dP8HR4daE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVz6fBQULGO9diqb96sUJllNJ3XnA39Yrf/pBAMhPOfgiMhPFoOJFDXAMEuyJnY6qG/WrZsQCCDhXsHKbQL/3RNTmQA01eXWYV48wHnpRpv4u7OcJpCy7YOiezNg+l27YttYj85aIxgZ8Oudj64l9xd46KVNA9mHde1V2qiu7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKlmN21x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE4DC19424;
	Thu, 19 Mar 2026 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773926332;
	bh=DBeq6ynyMBT7SGVxMF7nNxXLpd+5i5Ws71dP8HR4daE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZKlmN21xzTYbuxpDehDoEyHf4slhheV6fzre8D17e+zmj+nbm6dXD9//rN+rOTWG2
	 9T7UHBnqj7YnFqSeFYXxIeDR7Qyq/hHWZl/RbQVrLWHlZzX3XUa1ie1azTEIHc5GtO
	 6B9SxCO1V2B0ODFWnt/27jJZAH8jdL9i2UViBnnKx99Ul0V/cWBU5l8IJgaL2WFEU0
	 ISYAGNcqJmLc8nCPHG0baUMxvFqi++YOznl/oWtbYSeY8xco3Spwb5UZwIcfjijgBi
	 QezSdk3a4jzBNqAGmjyUWddC2BtuYJLlmr81MRyLix+9oNqrtnhL3aVxNgiMTj1Tvo
	 d7vbbuX9c0OEw==
Message-ID: <45e50068-751c-4e8c-a6b0-62cf8d1e58e6@kernel.org>
Date: Thu, 19 Mar 2026 14:18:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/type1: Retry follow_pfnmap_start() when PFNMAP is
 zapped
To: "Boone, Max" <mboone@akamai.com>, Alex Williamson <alex@shazbot.org>
Cc: Max Boone via B4 Relay <devnull+mboone.akamai.com@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260317-retry-pin-on-reclaimed-pud-v1-1-1f0d0a23f78d@akamai.com>
 <20260318152249.43eb81f6@shazbot.org>
 <3C8F924E-CA2D-4368-83DF-3CCCD4BA49FF@akamai.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <3C8F924E-CA2D-4368-83DF-3CCCD4BA49FF@akamai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227289-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,mboone.akamai.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D1882CBD31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 09:36, Boone, Max wrote:
> 
> 
>> On Mar 18, 2026, at 10:22 PM, Alex Williamson <alex@shazbot.org> wrote:
>>
>> […]
>>
>>> + /*
>>> + * follow_pfnmap_start() returns -EINVAL for
>>> + * invalid parameters and non-present entries.
>>> + * If that happens here after a successful
>>> + * fixup_user_fault(), it is likely that the
>>> + * pfnmap has been zapped. Retry instead of
>>> + * failing.
>>> + */
>>
>> It's a little stronger than that, right?  We're betting that the only
>> remaining non-zero return is due to a race and we can introduce what
>> appears to be potential for an infinite loop here because -EAGAIN will
>> get kicked out to redo the vma_lookup() and fixup_user_fault() should
>> return a genuine error if we're completely in the weeds.  Should we
>> make this a little stronger and more specific?  Thanks,
> 
> I’d say that the best case would be to have follow_pfnmap_start() return
> -EINVAL or -ENOENT w.r.t. which of the two return values it is. But then
> again, we could theoretically run into an infinite loop I guess - as the zap
> and faulting could run in lockstep (the race window is extremely small
> though).

Well, in theory :) To hit that race repeatedly, you'd really have to be
quite lucky I guess.

But the real question is: if user space triggered the pinning, and user
space keeps hurting itself to make progress, is that a real problem?

I guess the crucial part would be to

a) Have some cond_resched(() in there?
b) Checking for fatal signals somewhere?
c) Possibly drop locks (mmap lock?) every now and then?

For GUP, a) and b) are in place in __get_user_pages().

c) might be done, but I think it's less deterministic.

> 
> We could make the retry above bounded, and bubble up a -EBUSY such
> that users of the ioctl can decide to retry instead of fail?

Would that be a possible ABI break? You'd really have to only do that in
a case where user space does stupid things, I guess.

> 
> David, you mentioned that gup already has retry logic that we don’t have
> with follow_fault_pfn() -> follow_pfnmap_start(). Would we potentially run
> into an infinite loop with this change?

GUP triggers page faults through faultin_page(). If handle_mm_fault()
returns

* VM_FAULT_COMPLETED we return -EAGAIN
* VM_FAULT_ERROR we return the error
* VM_FAULT_RETRY we return -EBUSY
* Otherwise 0

In the caller __get_user_pages(), we
* Retry immediately with ret == 0
* Return to the GUP caller (letting it retry) with -EBUSY/-EAGAIN

Having at least a) and b) sounds reasonable. Not sure about having c),
might be tricky if we are not allowed to drop the lock.

-- 
Cheers,

David

