Return-Path: <stable+bounces-210793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNKkHXAecWmodQAAu9opvQ
	(envelope-from <stable+bounces-210793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:44:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C85B718
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77C428021EF
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 16:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829B34CFD4;
	Wed, 21 Jan 2026 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcXFwZSY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EE24337B
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012810; cv=none; b=ohOsL6/kcwLcdWJhNY6YjZxc7vkaD+lx6GqYRJzB9Hvb2TymglCGokpUmYb/D4fqT7t62sfMEvjx7CnXR+Z29hST8I7+0SscWw2dsLpnKqNcdQr0U5ENeW8VsrTpPt2G7E4zOim114LRlnogVuPJyPvTar1rsu22X4sFBaZbPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012810; c=relaxed/simple;
	bh=LA1ylA0m6oz8qEVUY2AglwnTjlAT/nD9JFf53WiQRgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3E2GbivHZwIHl91CPZW/+uUK//s4e6W0Hgfzfrye7IKRLnznnFgJrEx8XAoUPkLNMetzBCYjbMKn/JXqy7DNrT2HNrwJiNp7XwewbuVE0NYGlb57XPMxho7YAgjFjxrhHiMsmHR2WyKvaDxJNUa+2d0s1M3fBY8DYwFtMa5eYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcXFwZSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7369EC4CEF1;
	Wed, 21 Jan 2026 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769012808;
	bh=LA1ylA0m6oz8qEVUY2AglwnTjlAT/nD9JFf53WiQRgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcXFwZSYTyMUTL2joJgHJamGF3fdouI64zcwEL528GTH0H9ypjHz3AQ04/62M7CLB
	 +DyWkL4OzMrExNLS6qYTTzd29IAyXLVD/m6lWOAryj2ep2KOn6EhJYOS765Fiwr/YC
	 6UxcT/sWWB2kAHakBndwB4ORxTB4H+JPkxHg5foQG6WoR28IhQReO0pElUivN+GXca
	 Hqz7DYEy4MoBZgKzKv3eXO9B/Pi2X5PrOV58RwcdLXUDrCPrOI8pjuQaed1P06ypyY
	 KsW2rtK2kcj8g01oX1saGWK05FuJSpI3Q0H4tB5kf46VGtJ6LAJKxmKVuZB//ibEQE
	 iMfiAQjgrXy4A==
Date: Wed, 21 Jan 2026 11:26:47 -0500
From: Sasha Levin <sashal@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.6.y] xfs: set max_agbno to allow sparse alloc of last
 full inode chunk
Message-ID: <aXD-R217E5nndaAl@laps>
References: <2026012007-legal-directly-ad82@gregkh>
 <20260121021329.1126671-1-sashal@kernel.org>
 <aXDdwtuJYYLmIex1@bfoster>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aXDdwtuJYYLmIex1@bfoster>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210793-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 499C85B718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 09:08:02AM -0500, Brian Foster wrote:
>On Tue, Jan 20, 2026 at 09:13:29PM -0500, Sasha Levin wrote:
>> From: Brian Foster <bfoster@redhat.com>
>>
>> [ Upstream commit c360004c0160dbe345870f59f24595519008926f ]
>>
>> Sparse inode cluster allocation sets min/max agbno values to avoid
>> allocating an inode cluster that might map to an invalid inode
>> chunk. For example, we can't have an inode record mapped to agbno 0
>> or that extends past the end of a runt AG of misaligned size.
>>
>> The initial calculation of max_agbno is unnecessarily conservative,
>> however. This has triggered a corner case allocation failure where a
>> small runt AG (i.e. 2063 blocks) is mostly full save for an extent
>> to the EOFS boundary: [2050,13]. max_agbno is set to 2048 in this
>> case, which happens to be the offset of the last possible valid
>> inode chunk in the AG. In practice, we should be able to allocate
>> the 4-block cluster at agbno 2052 to map to the parent inode record
>> at agbno 2048, but the max_agbno value precludes it.
>>
>> Note that this can result in filesystem shutdown via dirty trans
>> cancel on stable kernels prior to commit 9eb775968b68 ("xfs: walk
>> all AGs if TRYLOCK passed to xfs_alloc_vextent_iterate_ags") because
>> the tail AG selection by the allocator sets t_highest_agno on the
>> transaction. If the inode allocator spins around and finds an inode
>> chunk with free inodes in an earlier AG, the subsequent dir name
>> creation path may still fail to allocate due to the AG restriction
>> and cancel.
>>
>> To avoid this problem, update the max_agbno calculation to the agbno
>> prior to the last chunk aligned agbno in the AG. This is not
>> necessarily the last valid allocation target for a sparse chunk, but
>> since inode chunks (i.e. records) are chunk aligned and sparse
>> allocs are cluster sized/aligned, this allows the sb_spino_align
>> alignment restriction to take over and round down the max effective
>> agbno to within the last valid inode chunk in the AG.
>>
>> Note that even though the allocator improvements in the
>> aforementioned commit seem to avoid this particular dirty trans
>> cancel situation, the max_agbno logic improvement still applies as
>> we should be able to allocate from an AG that has been appropriately
>> selected. The more important target for this patch however are
>> older/stable kernels prior to this allocator rework/improvement.
>>
>> Cc: stable@vger.kernel.org # v4.2
>> Fixes: 56d1115c9bc7 ("xfs: allocate sparse inode chunks on full chunk allocation failure")
>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>> Signed-off-by: Carlos Maiolino <cem@kernel.org>
>> [ xfs_ag_block_count(args.mp, pag_agno(pag)) => args.mp->m_sb.sb_agblocks ]
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>
>Hi Sasha,
>
>Thanks for sending out the rest of these. I think there's actually been
>a mixup on the stable targeting for this one. It's true that this fixes
>the commit tagged in the description above, but it really only matters
>in practice for codebases that also include upstream commit
>13325333582d4 ("xfs: fix sparse inode limits on runt AG").
>
>The latter is the commit that fixes the calculation to properly bound on
>the small runt AG case, where both of the associated problems are
>reproduced. This is also the commit that adds the xfs_ag_block_count()
>usage that these backports are working around.
>
>I didn't realize this commit wasn't in these repos when the patch was
>posted, so that is my mistake, but that is why I only went as far as
>resolving the conflict in v6.12. In any event, I think there are three
>options here for remaining stable versions:
>
>1. Disregard this subtlety and proceed with these backports as a safety
>for future inclusion of commit 13325333582d4. I think this is harmless,
>but doesn't effectively fix anything either (JFYI).
>
>2. Also include upstream commit 13325333582d4 as a dependency in these
>repos. This effectively fixes both issues (invalid post-eof inode
>records and allocation failure shutdowns).
>
>3. Drop this backport for repos that don't already have reason to
>include commit 13325333582d4.

Let's just go with option 3 :)

Thanks for the report!

-- 
Thanks,
Sasha

