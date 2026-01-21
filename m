Return-Path: <stable+bounces-210721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCe8JhKqcGnwYwAAu9opvQ
	(envelope-from <stable+bounces-210721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:27:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B607552FD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E1640A55
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71FD43C066;
	Wed, 21 Jan 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlmVHIUh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C533793B1;
	Wed, 21 Jan 2026 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990019; cv=none; b=gjsLuRNsHRhU+eh1x/JGfpQuQWFhWuxpGhQ2hfcWDIIZ4+uxf71Z7i1H+n/34z34d37wpCYH1vV4GhX5RG3gTwRddd89Yao4ewS1UkonVtowKum9i7DSPl4VrVeHcHLVZHU8YCZ8Gna/iQb6Heb6O+EcGZxwULj0TAgFzeUbimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990019; c=relaxed/simple;
	bh=Y3Xnh8IHQll1vIPX9JZT1N6XFXrjN3/oUfoUJ2R/Wms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=deCKKz3M7NY+FPAs0Y7CBSH1OC+u/y9H5eVv/KcilK1OO5B6H5A8TGt0sDX+lxGbeJMEx/bus4o+Tmfbafpa4hQ8WW/0yQADa9KExSaOxkt724GjWL5JUeddWH+GWrJBxKwtnMRFi28n5DKKi1gj8xNSlj++sjVVTDW+hinw1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlmVHIUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AE9C116D0;
	Wed, 21 Jan 2026 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768990018;
	bh=Y3Xnh8IHQll1vIPX9JZT1N6XFXrjN3/oUfoUJ2R/Wms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WlmVHIUhzZmqNUem6lxGt5HS/vxCpXGhW9/eZR1YnBJ/2DXEvBX0ghI5xwj9SGubB
	 rSXSSjh6l1zgUBZaWMbT1Kj5gmDVjgOLz6BDDNPF1YEe7DggYi7Py+UQ8PaxZlqPfz
	 nxE5W5IV3Gp/B1CsCSxqId8uS3azGlPhegFyniT6CB25Puxqo3y0Cq/CerYUv280FB
	 oLjFASARGAu2fcRx4lbI7UH0YlWBxABYIh3mhC8O/usdzbCrm5qybJS4aTFfs0Ssjd
	 +teR8Hmj3mYr8ylX5CnrLQDCzR5ATlbQqN41foXTYiNp/WjEgGf9qygogFkcMjKys7
	 pWuLCyIoQqtpQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  mm-commits@vger.kernel.org,
  surenb@google.com,  stable@vger.kernel.org,  rppt@kernel.org,
  pasha.tatashin@soleen.com,  graf@amazon.com,  ran.xiaokai@zte.com.cn
Subject: Re: [merged mm-hotfixes-stable]
 kho-init-alloc-tags-when-restoring-pages-from-reserved-memory.patch
 removed from -mm tree
In-Reply-To: <20260120093639.3d316ff26f802b36bfe7a285@linux-foundation.org>
	(Andrew Morton's message of "Tue, 20 Jan 2026 09:36:39 -0800")
References: <20260119203054.70AE8C116C6@smtp.kernel.org>
	<2vxzqzrke295.fsf@kernel.org>
	<20260120093639.3d316ff26f802b36bfe7a285@linux-foundation.org>
Date: Wed, 21 Jan 2026 10:06:55 +0000
Message-ID: <2vxzy0lrb7pc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210721-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5B607552FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20 2026, Andrew Morton wrote:

> On Tue, 20 Jan 2026 15:24:06 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:
>
>> > The quilt patch titled
>> >      Subject: kho: init alloc tags when restoring pages from reserved memory
>> > has been removed from the -mm tree.  Its filename was
>> >      kho-init-alloc-tags-when-restoring-pages-from-reserved-memory.patch
>> >
>> > This patch was dropped because it was merged into the mm-hotfixes-stable branch
>> > of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> 
>> This patch isn't quite complete. See [0]. It doesn't do anything wrong,
>> it just doesn't fix the problem for every case.
>> 
>> I suggested a re-roll of this patch based on top of my cleanup patches
>> [1], since I think with those the end result is a bit nicer.
>> 
>> I suppose we have 3 options:
>> 
>> 1. Take this patch in hotfixes and leave kho_restore_pages() path
>>    unfixed. The fix the rest next merge window.
>> 
>> 2. Do a new version of this patch fixing kho_restore_pages() with the
>>    current code, and then re-roll the clean up series to fix conflicts
>>    for next merge window.
>> 
>> 3. Pull in the cleanups in hotfixes too, and then do a new revision of
>>    this patch on top.
>> 
>> I don't think the end result of option 2 is too horrible, so I think
>> that is probably the best option, but do let me know what you'd prefer.
>
> No probs, I removed this patch from mm-hotfixes-stable and put it back
> into mm-hotfixes-unstable, with a note that an updated version is expected.

Thanks.

Ran, would you be able to send a fixup soon? We are at -rc6 and it would
be great if this can land in 6.19. If not, then I can take it up.

-- 
Regards,
Pratyush Yadav

