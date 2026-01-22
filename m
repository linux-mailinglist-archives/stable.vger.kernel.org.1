Return-Path: <stable+bounces-211240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMjkMW80cmmadwAAu9opvQ
	(envelope-from <stable+bounces-211240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:30:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28867F37
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27DCD967A20
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8799331A49;
	Thu, 22 Jan 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrM43KnI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116130ACE5;
	Thu, 22 Jan 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088945; cv=none; b=JQlCX6er30lwBgftTzBE+LhqcmBS7IX70BUa2SW+knv6KYp8Fy0m0+GoDvn5ZuZ2YKpDSBfppzs1qncY0F6uzx9TXJd71+tp1IEOY8s+e+HLu7nS2RuHRKheI0dYMfOrWvixXDT3bLnsi1BBLC28WYpwbB3zrQHdVVspIg5cMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088945; c=relaxed/simple;
	bh=wED3dXV0kHkiBnPWNUBgYlSUdtgP2fArJ/kzjZEMltI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e/EXWOJujFOpxmnJGY3feMK56hHGpAFvQ+YrtxSFHlTExd9S/buznqbJVgsZJniz4nxAk7F1dMkLSYMsvfe1UhqTWZ72BzF+dwHUhV/ILftNGKUVV7KHmUzsCpMRPsnsEp0Jdm+nTed3qdQpxI/0xH4pzE5+H/kCUmH0b28VgBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrM43KnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CE5C116C6;
	Thu, 22 Jan 2026 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088945;
	bh=wED3dXV0kHkiBnPWNUBgYlSUdtgP2fArJ/kzjZEMltI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mrM43KnIhyHDnc8ivUCX5HTrM9Pl42GBN8gXbejQ3Jl7OGoZ6s6TYv7Q9f+Ds41mV
	 +atyWBT9K1XOmZr0pF5xVDisRvZ3G+sA0qlf+8xqzuMhEvZp4UEln1+29gf3zF8UIM
	 hDr0aYGQEDqiPxMYnxspQa3y7BzZqMUsjuoGrP0jIAK+PgK0D2VLGCIn2k5S95TWLs
	 uieNDly2PL9lHs2HFOjsXJgRHIrcw5486a5jYlh+T2wfAUhDov1hXXSAUo6cTbh/uZ
	 yD8mWEN/VEDP5hyMTo/uckvNJclqUK7clMtEpzkS9kYenRw3CDQY2ZRB1Qh1ai61Ql
	 pXhD2DGjTqOBQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: pratyush@kernel.org,  surenb@google.com,  akpm@linux-foundation.org,
  pasha.tatashin@soleen.com,  kent.overstreet@linux.dev,  rppt@kernel.org,
  graf@amazon.com,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  ran.xiaokai@zte.com.cn,
  stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3] kho: init alloc tags when restoring pages
 from reserved memory
In-Reply-To: <20260122132740.176468-1-ranxiaokai627@163.com> (ranxiaokai's
	message of "Thu, 22 Jan 2026 13:27:40 +0000")
References: <20260122132740.176468-1-ranxiaokai627@163.com>
Date: Thu, 22 Jan 2026 14:35:41 +0100
Message-ID: <2vxzcy31bwia.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-211240-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3D28867F37
X-Rspamd-Action: no action

On Thu, Jan 22 2026, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Memblock pages (including reserved memory) should have their allocation
> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> released to the page allocator. When kho restores pages through
> kho_restore_page(), missing this call causes mismatched
> allocation/deallocation tracking and below warning message:
>
> alloc_tag was not set
> WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
> RIP: 0010:___free_pages+0xb8/0x260
>  kho_restore_vmalloc+0x187/0x2e0
>  kho_test_init+0x3c4/0xa30
>  do_one_initcall+0x62/0x2b0
>  kernel_init_freeable+0x25b/0x480
>  kernel_init+0x1a/0x1c0
>  ret_from_fork+0x2d1/0x360
>
> Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> fix this.
>
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>
> v2 -> v3: 
>  - also call clear_page_tag_ref() for non-compound order-0 tail pages
>
>  kernel/liveupdate/kexec_handover.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index d4482b6e3cae..96767b106cac 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -255,6 +255,14 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  	if (is_folio && info.order)
>  		prep_compound_page(page, info.order);
>  
> +	/* Always mark headpage's codetag as empty to avoid accounting mismatch */
> +	clear_page_tag_ref(page);
> +	if (!is_folio) {
> +		/* Also do that for the non-compound tail pages */
> +		for (unsigned int i = 1; i < nr_pages; i++)
> +			clear_page_tag_ref(page + i);
> +	}
> +

I think it would be a little bit better if we just did this in the loop
above instead of looping again. But I think it is fine for now. I can
fix it up in the next release.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>  	adjust_managed_page_count(page, nr_pages);
>  	return page;
>  }

-- 
Regards,
Pratyush Yadav

