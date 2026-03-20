Return-Path: <stable+bounces-227453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bd2A4QBvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:12:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7819F2D6FD4
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5104D30162B8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6636EAB1;
	Fri, 20 Mar 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azx31kU0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7636E495;
	Fri, 20 Mar 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994365; cv=none; b=S/mbC6bhykpQlN+QexwozhBx4dzfjiAqNnhYZQ/LvB4I74/deNUUS7CMtb8siIZLFq7/qwTTGB30O4tjXUE7V4EQ+hBmS5g1n7c3sE32fQoWOe2NDdL++Cr/jPWcYZPEf0mJ9LC0nkEiLvwOBCYg+N9M25xG2VhZWFH+1p/fPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994365; c=relaxed/simple;
	bh=bKDVCqTM4J91R7IvMYDkjFY61oGEb/tt+7PlrQhX1HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVTCgBpvmvRMaphJp5gYlHMDGmvt0Dc9+7EHOula1IajuktLDlDg9cNXsKJSSMIHEkSclNwPogJAg8BxTPs6KK/GJgvQuymgTn91MJViR9DVp4mY5HiSTa0TkukZTQHpjEnmNqsYSTQXoOs+SuX4UBFCZB64IA6+ryFiQFn1y+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azx31kU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15121C4CEF7;
	Fri, 20 Mar 2026 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773994365;
	bh=bKDVCqTM4J91R7IvMYDkjFY61oGEb/tt+7PlrQhX1HY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=azx31kU0gP1cqkljdCivld5BsJa95qVMQh0lUqLWpwrSMVzC2J72H2av1f4l4OroJ
	 hESw43ZLGLNK27gM/HGW5NMGekELE+7CjOhCzhW4/IBAqijq0LSdY1IHr25cHLGwSu
	 OdBveZ6tjzl+f1RPJGO1Lc1jO7cvjxLgQlc1yr6F/3/hFfN0BR48timtKsoUK+5t2I
	 MGL2a4XEStrkdCzdfDbbpaDERiYXjoofeBzC+TVzIwWwMwELdPSaQMAZNmzUYMGRg0
	 MCvP+/YXSeYMFwyh+Q8bh36GXV2N4Unra84tj2POH4z8zr53zG4kZ0jsZO/refPOlV
	 UUSDh6J4oKC5w==
Message-ID: <ec90f34e-1f99-4ded-ba65-6d4345552ab3@kernel.org>
Date: Fri, 20 Mar 2026 09:12:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] writeback: don't block sync for filesystems with
 no data integrity guarantees
To: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, miklos@szeredi.hu,
 therealgraysky@proton.me, linux-pm@vger.kernel.org, stable@vger.kernel.org
References: <20260320005145.2483161-1-joannelkoong@gmail.com>
 <20260320005145.2483161-2-joannelkoong@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260320005145.2483161-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227453-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7819F2D6FD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 01:51, Joanne Koong wrote:
> Add a SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
> guarantee data persistence on sync (eg fuse). For superblocks with this
> flag set, sync kicks off writeback of dirty inodes but does not wait
> for the flusher threads to complete the writeback.
> 
> This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
> commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
> in wait_sb_inodes()"). The flag belongs at the superblock level because
> data integrity is a filesystem-wide property, not a per-inode one.
> Having this flag at the superblock level also allows us to skip having
> to iterate every dirty inode in wait_sb_inodes() only to skip each inode
> individually.
> 
> Prior to this commit, mappings with no data integrity guarantees skipped
> waiting on writeback completion but still waited on the flusher threads
> to finish initiating the writeback. Waiting on the flusher threads is
> unnecessary. This commit kicks off writeback but does not wait on the
> flusher threads. This change properly addresses a recent report [1] for
> a suspend-to-RAM hang seen on fuse-overlayfs that was caused by waiting
> on the flusher threads to finish:
> 
> Workqueue: pm_fs_sync pm_fs_sync_work_fn
> Call Trace:
>  <TASK>
>  __schedule+0x457/0x1720
>  schedule+0x27/0xd0
>  wb_wait_for_completion+0x97/0xe0
>  sync_inodes_sb+0xf8/0x2e0
>  __iterate_supers+0xdc/0x160
>  ksys_sync+0x43/0xb0
>  pm_fs_sync_work_fn+0x17/0xa0
>  process_one_work+0x193/0x350
>  worker_thread+0x1a1/0x310
>  kthread+0xfc/0x240
>  ret_from_fork+0x243/0x280
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> On fuse this is problematic because there are paths that may cause the
> flusher thread to block (eg if systemd freezes the user session cgroups
> first, which freezes the fuse daemon, before invoking the kernel
> suspend. The kernel suspend triggers ->write_node() which on fuse issues
> a synchronous setattr request, which cannot be processed since the
> daemon is frozen. Or if the daemon is buggy and cannot properly complete
> writeback, initiating writeback on a dirty folio already under writeback
> leads to writeback_get_folio() -> folio_prepare_writeback() ->
> unconditional wait on writeback to finish, which will cause a hang).
> This commit restores fuse to its prior behavior before tmp folios were
> removed, where sync was essentially a no-op.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880ac6c5c1
> 
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
> Reported-by: John <therealgraysky@proton.me>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Looks reasonable to me. With my little experience in fs land:

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

