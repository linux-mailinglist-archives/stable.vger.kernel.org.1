Return-Path: <stable+bounces-232986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCoLGMFUzmmEmwYAu9opvQ
	(envelope-from <stable+bounces-232986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:36:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A6388687
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FD41311854D
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6C3DA7D4;
	Thu,  2 Apr 2026 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Vo20PT8O"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA83A4F3B
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129286; cv=none; b=mDBOl2+NY7G8RgUvFZF2DXK59xS5HjI2TIluCo5XOpyMAmbRrcX2BmQ/n6sivOMKaZYXH2qyYyns5B+1OfhnEtR/eEAulks/goXvoLaZgXQbD6cfWncutFvxae99rTta/7ShYDphqWBZ0qSE/luv/Nt+W3i6z1bDjmDBVhSTGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129286; c=relaxed/simple;
	bh=2QvST01jeI2dArOnyrKeF9S+P0YQS952+ojnVv/8HPQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTupkQ6uguh+IV1yd7DSy3hz0vOBUgFFA9WqmWKgS+ooGDJVuvbqamJ85B0l34BFYET7hKcG5xV9kvpK8QHFi0AlboLUyex7i5YNZbD8zXxmBg/vmJyRK9w9xLy/fliSVeOJ15106cTzbgBk4JVdadM8GVU87vJDDcfOutR/mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Vo20PT8O; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uR1Yw8ElCDxJLVLCDUwRcO9xk7fMAzm7aQ38kDdq0QY=;
	b=Vo20PT8O3a+S2VXyoJ4bJ+X+gKGzttYKbAfrBCT43NwJQTdfM6WV2eGCrbeYuXqX5Zxev+2Wl
	8TUXn1JJLmav2rN4dsv8v2xVa4WvBkFGqolzWkDoxo6yBU1ZHu5p471UfpjAVENustGbA6P0b+P
	gAwC1bsIlNJ4aJXRe2MgSNs=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fmfZj1RB3z1T4Fj;
	Thu,  2 Apr 2026 19:22:05 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A16C740538;
	Thu,  2 Apr 2026 19:27:47 +0800 (CST)
Received: from kwepemn100013.china.huawei.com (7.202.194.116) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Apr 2026 19:27:47 +0800
Received: from localhost (10.50.85.155) by kwepemn100013.china.huawei.com
 (7.202.194.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 2 Apr
 2026 19:27:47 +0800
Date: Thu, 2 Apr 2026 19:22:44 +0800
From: Long Li <leo.lilong@huawei.com>
To: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.18.y 3/3] xfs: close crash window in attr dabtree
 inactivation
Message-ID: <ac5RhJ8M7G6tiVnX@localhost.localdomain>
References: <2026033024-poach-sequester-14e1@gregkh>
 <20260402101055.771010-1-sashal@kernel.org>
 <20260402101055.771010-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260402101055.771010-3-sashal@kernel.org>
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100013.china.huawei.com (7.202.194.116)
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-232986-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,localhost.localdomain:mid];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.lilong@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 074A6388687
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 06:10:55AM -0400, Sasha Levin wrote:
> From: Long Li <leo.lilong@huawei.com>
> 
> [ Upstream commit b854e1c4eff3473b6d3a9ae74129ac5c48bc0b61 ]
> 
> When inactivating an inode with node-format extended attributes,
> xfs_attr3_node_inactive() invalidates all child leaf/node blocks via
> xfs_trans_binval(), but intentionally does not remove the corresponding
> entries from their parent node blocks.  The implicit assumption is that
> xfs_attr_inactive() will truncate the entire attr fork to zero extents
> afterwards, so log recovery will never reach the root node and follow
> those stale pointers.
> 
> However, if a log shutdown occurs after the leaf/node block cancellations
> commit but before the attr bmap truncation commits, this assumption
> breaks.  Recovery replays the attr bmap intact (the inode still has
> attr fork extents), but suppresses replay of all cancelled leaf/node
> blocks, maybe leaving them as stale data on disk.  On the next mount,
> xlog_recover_process_iunlinks() retries inactivation and attempts to
> read the root node via the attr bmap. If the root node was not replayed,
> reading the unreplayed root block triggers a metadata verification
> failure immediately; if it was replayed, following its child pointers
> to unreplayed child blocks triggers the same failure:
> 
>  XFS (pmem0): Metadata corruption detected at
>  xfs_da3_node_read_verify+0x53/0x220, xfs_da3_node block 0x78
>  XFS (pmem0): Unmount and run xfs_repair
>  XFS (pmem0): First 128 bytes of corrupted metadata buffer:
>  00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  XFS (pmem0): metadata I/O error in "xfs_da_read_buf+0x104/0x190" at daddr 0x78 len 8 error 117
> 
> Fix this in two places:
> 
> In xfs_attr3_node_inactive(), after calling xfs_trans_binval() on a
> child block, immediately remove the entry that references it from the
> parent node in the same transaction.  This eliminates the window where
> the parent holds a pointer to a cancelled block.  Once all children are
> removed, the now-empty root node is converted to a leaf block within the
> same transaction. This node-to-leaf conversion is necessary for crash
> safety. If the system shutdown after the empty node is written to the
> log but before the second-phase bmap truncation commits, log recovery
> will attempt to verify the root block on disk. xfs_da3_node_verify()
> does not permit a node block with count == 0; such a block will fail
> verification and trigger a metadata corruption shutdown. on the other
> hand, leaf blocks are allowed to have this transient state.
> 
> In xfs_attr_inactive(), split the attr fork truncation into two explicit
> phases.  First, truncate all extents beyond the root block (the child
> extents whose parent references have already been removed above).
> Second, invalidate the root block and truncate the attr bmap to zero in
> a single transaction.  The two operations in the second phase must be
> atomic: as long as the attr bmap has any non-zero length, recovery can
> follow it to the root block, so the root block invalidation must commit
> together with the bmap-to-zero truncation.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi Sasha,

The current patch depends on e942498385bf ("xfs: only assert new size for
datafork during truncate extents"), otherwise it will trigger an assertion.

Thanks,
Long Li

