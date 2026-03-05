Return-Path: <stable+bounces-223178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC7ACt1CqWkt3gAAu9opvQ
	(envelope-from <stable+bounces-223178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 09:46:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8178B20DA98
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 09:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A33D308BF95
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAEA27E05E;
	Thu,  5 Mar 2026 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBHe1YUN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB14A32;
	Thu,  5 Mar 2026 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700270; cv=none; b=NNHcEZfKCh2vckJmKrMsnz/Oxn+83EeWDGHahhEbnlbJzPSzngzrnF1S733/gvjTXpvHDFuEqG+122vZGW4vNg9c9RBzfJE5Ej5fMShoDy0W4uafGZ+TdmxY5GkmQuepI1Fx7clufPG/2BsdYH5DLdevI9BuRo/jk6UalIl+5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700270; c=relaxed/simple;
	bh=bH9cDEIzoCAFMzWyAswOZriFHl7uowmtWVbYD6aUiPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2mjLCrEibSox6AbT6UEDMW7YjIVzkn5Eqicz5gtCtaPCHpcCANUGmNNYXYMdhl126QYYW7U6gh/qYNQqi4oxx3XyCbR67VPha0+Y42WLKw+WqNWQdp+Mad+svOn6h/BkadoblpbTi1ksAnPHPkGJxbNrvtMvqmQOToNjqXtsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBHe1YUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0E2C116C6;
	Thu,  5 Mar 2026 08:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772700269;
	bh=bH9cDEIzoCAFMzWyAswOZriFHl7uowmtWVbYD6aUiPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QBHe1YUNJiQ+6UejpGKx+tebrfGn9jf8j3uuRBXc4sWUkfNMp6Q30TP/qYJik3o2C
	 mEZqPHcxH/xhXBIn9s1P0m1DvEf3k4NuqFGoHaxxW08bu82RbdznjqB3rcvDgpcW4n
	 jDjUUA28aBgVuXGCBUl+kcQgBcXdmpH4k/+9797n97FU+adelLp8mXPsIBvF2Hyrn9
	 IunwyChSXuK7NHkRD3TWzQrTJ7ZyAxBrNZTScxbJ2wksi7s5eWYd5xI/VeACBqXvej
	 iIX+AEkkXe2lx4rGcvaOu6MpUd0MIsWfcXAl+2LAQxri0F6BiuJpT9UEKmPZ4boM5r
	 Deh6yxR+68nuw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: always dirty all folios
In-Reply-To: <aZ65uvOrTDndpic6@kernel.org> (Mike Rapoport's message of "Wed,
	25 Feb 2026 10:58:34 +0200")
References: <20260223173931.2221759-1-pratyush@kernel.org>
	<20260223173931.2221759-3-pratyush@kernel.org>
	<aZ65uvOrTDndpic6@kernel.org>
Date: Thu, 05 Mar 2026 09:44:27 +0100
Message-ID: <2vxzv7fabr84.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 8178B20DA98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223178-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Mike,

On Wed, Feb 25 2026, Mike Rapoport wrote:

> On Mon, Feb 23, 2026 at 06:39:29PM +0100, Pratyush Yadav wrote:
[...]
>> -		if (folio_test_dirty(folio))
>> -			flags |= MEMFD_LUO_FOLIO_DIRTY;
>> +		/*
>> +		 * A dirty folio is one which has been written to. A clean folio
>> +		 * is its opposite. Since a clean folio does not carry user
>> +		 * data, it can be freed by page reclaim under memory pressure.
>> +		 *
>> +		 * Saving the dirty flag at prepare() time doesn't work since it
>> +		 * can change later. Saving it at freeze() also won't work
>> +		 * because the dirty bit is normally synced at unmap and there
>> +		 * might still be a mapping of the file at freeze().
>> +		 *
>> +		 * To see why this is a problem, say a folio is clean at
>> +		 * preserve, but gets dirtied later. The pfolio flags will mark
>> +		 * it as clean. After retrieve, the next kernel might try to
>> +		 * reclaim this folio under memory pressure, losing user data.
>> +		 *
>> +		 * Unconditionally mark it dirty to avoid this problem. This
>> +		 * comes at the cost of making clean folios un-reclaimable after
>> +		 * live update.
>> +		 */
>
> Can we make the comment here shorter to only contain the gist of the issue?

Is this any better? Or should I try to make it shorter still?

	/*
	 * Tracking the dirty flag of the folio is difficult since it is
	 * normally synced at unmap and there might still be mappings of
	 * the file alive.
	 *
	 * Not tracking it correctly can cause a dirty folio to be
	 * restored as clean after KHO. The next kernel might then try
	 * to reclaim it, losing user data.
	 *
	 * Unconditionally mark the folio dirty to avoid this. This
	 * comes at the cost of making clean folios un-reclaimable.
	 */

[...]

-- 
Regards,
Pratyush Yadav

