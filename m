Return-Path: <stable+bounces-231387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHCBL8Wiy2kUJwYAu9opvQ
	(envelope-from <stable+bounces-231387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:32:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE7368066
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71B4F30516FF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259B3EF649;
	Tue, 31 Mar 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsmNbSdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56303EF642
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952804; cv=none; b=bbtwbGO6pDS2p22YmIX8MGJTv6guFqAAC6/YxVkigwGpRV8CXq1nAwoOtUBhyGls7/pLl6WuLQUKtKh8CzV15nByrYEhCAOODxYs4p8g5gJlak9bgh7b4kDKiKLKIHane71v5rq933XO0w5WfavqSLdbp6w1Qwde8qzwuKhADJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952804; c=relaxed/simple;
	bh=Sv3MqyMihutIu+Ob7GP9YAi1qZh4VRRUHr99EsL2XnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqmyT2BCOwXhSUryFuRmSfBCsdHrofqP/gamQQu5fk7Hj1GTV8yiLuDROt1jaBpD7tdUPXXdksJ5k605hAK1e+Q2UKQyV3ollueHFj3YELjB4lC9PHqBVyNfSbQJlaKEdx+2GjZv9Lq3tm9sw4fUpN0xf2Bpzd0R3e5CvkTqGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsmNbSdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE859C19423;
	Tue, 31 Mar 2026 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774952803;
	bh=Sv3MqyMihutIu+Ob7GP9YAi1qZh4VRRUHr99EsL2XnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsmNbSdlLT4gXRLtiDab6sPuSVxa/xQ1NyL55FT9Oj6CPDigZe1cEfuO1f7q+K2XD
	 crN8UJqnBXK6FzwzG1kInF68ltDty2Y7vdjlg/Xw2W8QKaj+QrmF2++usq6e7xiqke
	 4PGg+j7BzhsQKNEzMDJBxa9Xpt/SLHeYvWGvKprAG/GIZxrM9nIvSWNlhUKg4t+ptx
	 LvAla9xP0ZTsXrpNTXnJLtwxOb8xnijuJzvubDYVey8ddDXdCRaFHa9CiM63RimGiw
	 Pn7FRL8hNwambLiC5ui9S2rT96cEsK2qNBsSigqW9h4bhHc31OXroNuatpFBpeBVwV
	 BfEQG9fSOglKA==
Date: Tue, 31 Mar 2026 11:26:41 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y] mm/mseal: update VMA end correctly on merge
Message-ID: <f0a83eb8-4a88-4baf-8cb4-59078ef81002@lucifer.local>
References: <2026033044-debug-embargo-40fb@gregkh>
 <20260330110021.56330-1-ljs@kernel.org>
 <2026033151-crinkly-manhunt-7916@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026033151-crinkly-manhunt-7916@gregkh>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231387-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bluedragonsec.com:email,lucifer.local:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 5CFE7368066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 12:22:01PM +0200, Greg KH wrote:
> On Mon, Mar 30, 2026 at 12:00:21PM +0100, Lorenzo Stoakes (Oracle) wrote:
> > Previously we stored the end of the current VMA in curr_end, and then upon
> > iterating to the next VMA updated curr_start to curr_end to advance to the
> > next VMA.
> >
> > However, this doesn't take into account the fact that a VMA might be
> > updated due to a merge by vma_modify_flags(), which can result in curr_end
> > being stale and thus, upon setting curr_start to curr_end, ending up with
> > an incorrect curr_start on the next iteration.
> >
> > Resolve the issue by setting curr_end to vma->vm_end unconditionally to
> > ensure this value remains updated should this occur.
> >
> > While we're here, eliminate this entire class of bug by simply setting
> > const curr_[start/end] to be clamped to the input range and VMAs, which
> > also happens to simplify the logic.
> >
> > Reported-by: Antonius <antonius@bluedragonsec.com>
> > Closes: https://lore.kernel.org/linux-mm/CAK8a0jwWGj9-SgFk0yKFh7i8jMkwKm5b0ao9=kmXWjO54veX2g@mail.gmail.com/
> > Suggested-by: David Hildenbrand (ARM) <david@kernel.org>
> > Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > Fixes: 6c2da14ae1e0 ("mm/mseal: rework mseal apply logic")
> > Cc: <stable@vger.kernel.org>
> > (cherry picked from commit 88995f43fdc2045ff0b030ca054898483004de36)
>
> Not a valid git id :(
>

OK not sure how that happened. Let me try again I guess.

