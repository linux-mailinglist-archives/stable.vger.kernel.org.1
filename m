Return-Path: <stable+bounces-223180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAMCCh9EqWlV3gAAu9opvQ
	(envelope-from <stable+bounces-223180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 09:51:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA920DC18
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 09:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AF6F304D1DE
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF5366802;
	Thu,  5 Mar 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McJ1vp32"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331033B6E1;
	Thu,  5 Mar 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700621; cv=none; b=taON+BmBDB0lnwjE2NIM+0lRqJqDyRrBLF/qVq8qTsFGJYeXBI9wLs6jKkkedAeLa+CojjM+8VMo1/V38gUtpPTGP+Ml5yHrS9SFZwPkO17yo0fOVB2mpHAd1kcO134CwfsgnOeq8lbs/+1z+7pUffw+z1fp92lcIBPduKFXKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700621; c=relaxed/simple;
	bh=zevslGUjKCVfBPbqMd+wo0pOgUpRHhdePe8oIhAfglM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bh5s2IwQiB6078UQDU4FDLgoIVfLMJUWVpIe81q/r92+PaJhP/rhBHDDoa2UEk7A8qeu3M5OHwk8D1riutZC9+63gFJWPvMlxwrHoldWZ7ilS24PubT0uKTmvckgyqDks9A4iTNK7Ol5/1zPfJ+X/arpXwsSfgIXi0J5KCcFhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McJ1vp32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B79C116C6;
	Thu,  5 Mar 2026 08:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772700621;
	bh=zevslGUjKCVfBPbqMd+wo0pOgUpRHhdePe8oIhAfglM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=McJ1vp32QXe9xyBY23YUYPFogGoBVy/82ac1XL5PM6v0WtDEP6fZJMyj4G+3m1dcM
	 M8Mg9aWMQgjvNShH83Jl/da4+akt8v10TLkbKooVpo9iajU9jeWER2ZLHWiIHetOqo
	 QjhhOfTxaZLcl9fqfOnPFJh0nKU3+Dx4yQWVyVNKnC+6S4nIQuLJlIFZ8MxdVos3qJ
	 4uYlGQWvP6+GJzvWi2WkAWg9ktm0BFb4f777Mdcuv+mCLOfS493+WGsoGZS0lJU0kb
	 iXvkOPqUdmb84Ed30xiPSXpuxCRB2zbHKavO4hkrCWaYCFccZYnp5sN5hMlGs0Go26
	 Cr3cq/BOefBIw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: memfd_luo: always make all folios uptodate
In-Reply-To: <aZ64ikDtz8tF_rFU@kernel.org> (Mike Rapoport's message of "Wed,
	25 Feb 2026 10:53:30 +0200")
References: <20260223173931.2221759-1-pratyush@kernel.org>
	<20260223173931.2221759-2-pratyush@kernel.org>
	<aZ64ikDtz8tF_rFU@kernel.org>
Date: Thu, 05 Mar 2026 09:50:18 +0100
Message-ID: <2vxzqzpybqyd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 96DA920DC18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223180-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Feb 25 2026, Mike Rapoport wrote:

> On Mon, Feb 23, 2026 at 06:39:28PM +0100, Pratyush Yadav wrote:
[...]
>> +
>> +		/*
>> +		 * If the folio is not uptodate, it was fallocated but never
>> +		 * used. Saving this flag at prepare() doesn't work since it
>> +		 * might change later when someone uses the folio.
>> +		 *
>> +		 * Since we have taken the performance penalty of allocating,
>> +		 * zeroing, and pinning all the folios in the holes, take a bit
>> +		 * more and zero all non-uptodate folios too.
>> +		 *
>> +		 * NOTE: For someone looking to improve preserve performance,
>> +		 * this is a good place to look.
>
> I'd add a larger comment above memfd_luo_preserve_folios() that says that
> it allocates, pins etc and fold the last two paragraphs of this comment
> there.

How about this:

	/*
	 * If the folio is not uptodate, it was fallocated but never
	 * used. Saving this flag at prepare() doesn't work since it
	 * might change later when the folio is used. Make it uptodate
	 * now to avoid this problem.
	 */
	if (!folio_test_uptodate(folio)) {

And the comment above memfd_pin_folios() gets this:

	 * NOTE: For someone looking to improve preserve performance, this is a
	 * good place to look. Also look at the folio zeroing below.

[...]

-- 
Regards,
Pratyush Yadav

