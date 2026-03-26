Return-Path: <stable+bounces-230510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF6WJ5p3xWnw+QQAu9opvQ
	(envelope-from <stable+bounces-230510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:14:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C54C2339DD2
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B493302AC07
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E547F2DCBF4;
	Thu, 26 Mar 2026 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp0YNqv9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893B3191D0;
	Thu, 26 Mar 2026 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548159; cv=none; b=EnDsArtqq1my+BFCe1DYRT4Dw08HICs7MgSVHrgluSgLYsZODf5b6JPz0q76WFX8yGP2hFJQU36mw62lCiLyiN+INI1YgM6Y+Nlo3jrgw7ov1+ROUYewAEOZv7N+J/x+SVulxEHnGgQyaq4RbAvL3hmNthApQthISUwDLaaYIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548159; c=relaxed/simple;
	bh=bSuW3X51OVUnXY3zSVnuPaTJM5PvnCVTaQghTt7QA2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8EKT3eQBq5jOh2SS11g9/8aZDxP/2/0qUMi3CfaHZ8BazkPxKzExBcGZoSMVR4TWn4W05SUveRD4DlKtWHzeWdIBMbGDtrVw+WFF6G3WnAL0b4EAAYnwPeueW86zuOqQEBKbklwKb+4CMSP3sW7jRZxf5N9XOp8lmQaqlkohdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp0YNqv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4FBC116C6;
	Thu, 26 Mar 2026 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774548159;
	bh=bSuW3X51OVUnXY3zSVnuPaTJM5PvnCVTaQghTt7QA2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xp0YNqv9Tu+RZdFoza1JJ9gdW+buS/kPhz94Cu9y3UkzJPjIH3QKzGjyft3PfAsKB
	 0ieUtZBURzk6yO0r+z36mdVq+dSaDnjsrw8HgGdk9Wmcs4LBgdVEcFgDxvIiQTjpSI
	 jxlUpTNxFGosace/G9Vk+I9xRB/LObqlzpwCRtCXTWsyZFneRDY1KO99ErM4BxcMcg
	 eYOHH/vklIKX2drwgSAD0Fqf+wzXyGmnoS1/7IcSZjOmHp/FWhdc/d1v8U3zeUtGHr
	 Y0L/lM4024oGKKTP+5ThFIRSiH4plpKZ8uR7vbOjapt4rtR3rZS6ux8YB3XPWe40uX
	 B4sjvnXXhjqSA==
Message-ID: <cfbe0037-00a0-4837-9a70-575010c201de@kernel.org>
Date: Thu, 26 Mar 2026 19:02:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/maple_tree: fix swapped arguments in
 mas_safe_pivot() call
Content-Language: en-US
To: Josh Law <hlcj1234567@gmail.com>, Liam Howlett <liam.howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josh Law <objecting@objecting.org>
References: <20260306225849.2824409-1-objecting@objecting.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260306225849.2824409-1-objecting@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230510-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,linux-foundation.org,vger.kernel.org,objecting.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,objecting.org:email,oracle.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: C54C2339DD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/6/26 23:58, Josh Law wrote:
> From: Josh Law <objecting@objecting.org>
> 
> The call to mas_safe_pivot() in mas_wr_extend_null() has the pivot index

The function is actually mas_extend_spanning_null() ?

> and maple type arguments swapped. The function signature expects
> (mas, pivots, piv, type) but the call passes (mas, pivots, type, piv).
> 
> This causes the pivot index to be interpreted as a maple node type and
> vice versa, leading to incorrect pivot lookups. In practice, this means
> a null-extending store into a maple tree node can read the wrong pivot
> value, potentially corrupting the range tracked by the maple state. For
> a VMA maple tree, this could cause an incorrect vm_area_struct range to
> be returned during operations like mmap or munmap, leading to silent
> memory mapping corruption.
> 
> Every other mas_safe_pivot() call site in the file passes the arguments
> in the correct (piv, type) order; this is the only one with them
> reversed.
> 
> Link: https://lkml.kernel.org/r/20260306200820.2819999-1-objecting@objecting.org
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Josh Law <objecting@objecting.org>
> Cc: stable@vger.kernel.org
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andrew Ballance <andrewjballance@gmail.com>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

I'm not a maple tree expert but this looks obviously correct enough. So I
won't speculate on the impact of this bug, but:

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

I guess since it's old and not in mm-hotfixes, we can afford to wait for
Liam who should be back before the merge window. I'm not sure how to
handle the fact that this patch has been withdrawn [1] however.

[1] https://lore.kernel.org/all/E1A667AB-DCE4-4034-A36B-DAA458780A81@objecting.org/

> ---
> Changes in v3:
> - Included a changelog detailing modifications since v1.
> 
> Changes in v2:
> - Added Link, Fixes, and Cc tags (including stable@vger.kernel.org) to the commit message.
> - Appended Andrew Morton's Signed-off-by to expedite merging.

No!

> 
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 5aa4c9500018..f82000821293 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3279,7 +3279,7 @@ static inline void mas_extend_spanning_null(struct ma_wr_state *l_wr_mas,
>  	    (r_mas->last < r_mas->max) &&
>  	    !mas_slot_locked(r_mas, r_wr_mas->slots, r_mas->offset + 1)) {
>  		r_mas->last = mas_safe_pivot(r_mas, r_wr_mas->pivots,
> -					     r_wr_mas->type, r_mas->offset + 1);
> +					     r_mas->offset + 1, r_wr_mas->type);
>  		r_mas->offset++;
>  	}
>  }


