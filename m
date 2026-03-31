Return-Path: <stable+bounces-231385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFuZKPKhy2lHJwYAu9opvQ
	(envelope-from <stable+bounces-231385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:29:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B965367F76
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2CBD3081361
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD573EDAC6;
	Tue, 31 Mar 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5C4LiL3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BB3EDAB2
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952524; cv=none; b=fcN6IAYsSM2bR4enpnuL2t0zUdtcoUTgogCldcRhSuXXUazaw1b/eEAo/Z88mY3nDwTUOXNDm//9ndYiTZtKMOC6yzQ6HK0MxODUKVSZqvvERLC8ZGTWSIYaQuqpSuicuSjQ6ndIccvFxtL+K4Q7WdVtcqUeu9+TM3zLd/1wVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952524; c=relaxed/simple;
	bh=DdS5P9Em7i6NU0h74P/W9ImTzQ5Z9jul/Vm9Is3XGGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAMmGw4b7nf56GcGh/Fhld6PcNaWzZN5urPejZHiqGEXHP3IQ3Y+rrMnQdd61VGWirmv7ZDhZLe+jANxPj+9Ks0x1lV2iYyDnO/WXhrjU/BEsjHpemPCQsc3RFbpmZieNz33al7y1UeXhh4G7upLpsDkrnQOeCMDFh0KW4V5SOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5C4LiL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3CDC2BCB3;
	Tue, 31 Mar 2026 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774952524;
	bh=DdS5P9Em7i6NU0h74P/W9ImTzQ5Z9jul/Vm9Is3XGGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y5C4LiL3Sq4GSdakxLXvYrR9JkhcEhUQ1UfK//1qaKXIMTqhfue1IpTpCt+IRjmlA
	 LU6I03oimALaue8w49yjLf3Cf5B/Jzrx1zs0RditFuhqlQZaLAyJB/TKuTw6k+6urO
	 eyKFa8QlRabM9P5L1l7zw79CoIWZkLX1wbLqda+8=
Date: Tue, 31 Mar 2026 12:22:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y] mm/mseal: update VMA end correctly on merge
Message-ID: <2026033151-crinkly-manhunt-7916@gregkh>
References: <2026033044-debug-embargo-40fb@gregkh>
 <20260330110021.56330-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330110021.56330-1-ljs@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-231385-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.861];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bluedragonsec.com:email]
X-Rspamd-Queue-Id: 0B965367F76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 12:00:21PM +0100, Lorenzo Stoakes (Oracle) wrote:
> Previously we stored the end of the current VMA in curr_end, and then upon
> iterating to the next VMA updated curr_start to curr_end to advance to the
> next VMA.
> 
> However, this doesn't take into account the fact that a VMA might be
> updated due to a merge by vma_modify_flags(), which can result in curr_end
> being stale and thus, upon setting curr_start to curr_end, ending up with
> an incorrect curr_start on the next iteration.
> 
> Resolve the issue by setting curr_end to vma->vm_end unconditionally to
> ensure this value remains updated should this occur.
> 
> While we're here, eliminate this entire class of bug by simply setting
> const curr_[start/end] to be clamped to the input range and VMAs, which
> also happens to simplify the logic.
> 
> Reported-by: Antonius <antonius@bluedragonsec.com>
> Closes: https://lore.kernel.org/linux-mm/CAK8a0jwWGj9-SgFk0yKFh7i8jMkwKm5b0ao9=kmXWjO54veX2g@mail.gmail.com/
> Suggested-by: David Hildenbrand (ARM) <david@kernel.org>
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Fixes: 6c2da14ae1e0 ("mm/mseal: rework mseal apply logic")
> Cc: <stable@vger.kernel.org>
> (cherry picked from commit 88995f43fdc2045ff0b030ca054898483004de36)

Not a valid git id :(


