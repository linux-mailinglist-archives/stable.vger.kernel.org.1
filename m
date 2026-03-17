Return-Path: <stable+bounces-226101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIptEwp0uWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:32:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F02AD16F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54CC73042683
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435B3EB813;
	Tue, 17 Mar 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDknNQqi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB03E867E;
	Tue, 17 Mar 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761077; cv=none; b=beNN0U4I3aRVn6nMsMVv2Zp9hK9g20E2kXu/d0WHoJrwDn1o5ewDcZzAMDogHS6JLH5QMQfAROc+AkRbMl1V1wBHcCr1ieUx0CzjbY8OTmwVK1UUAOJFe/jIEQUS4xdF5OiZDjVZqDoNiDm73Q7DU+fMwRNidIlAqb4L6oEiqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761077; c=relaxed/simple;
	bh=q78CQUqg7XC9sFYTe+9DYc6gzhlB2b3166x+jpYQ+/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObFICEE9VzQRc0jiLdV5XMniEENqOpMl0ywBPX1stAwj2N/F4zL/jW4xFVZpaWpnWw2XdY3vgnrSvvOeOQQttyeFonyf7p5HwlT8S06PQeAsuI7pRcfDiL+vrU0RS4UUrh4fpYhnAnL6pDquqh465DPvnqAe2sMZKL8WJETOTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDknNQqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA4FC4CEF7;
	Tue, 17 Mar 2026 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773761077;
	bh=q78CQUqg7XC9sFYTe+9DYc6gzhlB2b3166x+jpYQ+/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDknNQqiPh4LM1xsNELDvSEQrcjKPF88tNMfHgmDEQSGJvmAGpDQQdbXXKBUBToVx
	 hZ9+3PrLP1i5ZiD95vCYrHMe6B3TFYqK+ncnvX5NZ7JOe//dmGSbC4iulZC3xkh7uO
	 7qJWNKpF4QNFq2DqE8WnWlKrdNvtjC3PSS+VXKRjFcq4bdhWjYocb+HE228ytoW/Ok
	 O3Xt/jG/nUDcOwjPB06bV4ZyzbRUq25xjHwSFyLQadnh/xyqxOxSg2NWSJWIRZXuWJ
	 DE1N+7SJO16cSZqLLPcD4kq8MwljdEYcDkdd4w1X7ilT0E3JcAxxCfxEQVvqT8nAOr
	 Y8mzbW8qOgXuA==
Date: Tue, 17 Mar 2026 16:24:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0fd9ea308d049c4e0b9@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs: fix use-after-free in peer group traversal during
 mount release
Message-ID: <20260317-flugtauglich-zieht-fbf41690387a@brauner>
References: <20260314184421.47303-2-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314184421.47303-2-ytohnuki@amazon.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226101-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c0fd9ea308d049c4e0b9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 511F02AD16F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 06:44:22PM +0000, Yuto Ohnuki wrote:
> mntput_no_expire_slowpath() does not remove a mount from its peer group
> (mnt_share list) or slave list before sending it to the free path. If a
> mount that was added to a peer group by clone_mnt() is freed through
> mntput() without going through umount_tree()/bulk_make_private(), it
> remains linked in the peer group's circular list after the slab object
> is freed.
> 
> When another mount namespace is later torn down, umount_tree() calls
> bulk_make_private() -> trace_transfers(), which walks the peer group via
> next_peer(). This dereferences the freed mount's mnt_share field,
> causing use-after-free:
> 
>   BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report
>   Read of size 8 at addr ffff88807d533af8
> 
>   Call Trace:
>    __list_del_entry_valid_or_report
>    bulk_make_private
>    umount_tree
>    put_mnt_ns
>    do_exit
> 
>   Allocated by:
>    alloc_vfsmnt
>    clone_mnt
>    vfs_open_tree
> 
>   Freed by:
>    kmem_cache_free
>    rcu_core
> 
> Fix this by calling change_mnt_propagation(mnt, MS_PRIVATE) in
> mntput_no_expire_slowpath() after mnt_del_instance(), while holding
> lock_mount_hash(). This removes the mount from both the peer group and
> any slave list before it enters the cleanup path.
> 
> This is safe without namespace_sem: the mount has MNT_DOOMED set and has
> been removed from the instance list by mnt_del_instance(), making it
> unreachable through normal lookup paths. lock_mount_hash() prevents
> concurrent peer group traversal. This call is also idempotent: mounts
> already made private by bulk_make_private() have IS_MNT_SHARED() and
> IS_MNT_SLAVE() both false, so the condition is skipped.
> 
> Reported-by: syzbot+c0fd9ea308d049c4e0b9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c0fd9ea308d049c4e0b9
> Fixes: 75db7fd99075b ("umount_tree(): take all victims out of propagation graph at once")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---

The last time this reproduced upstream was on:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

which is v7.0-rc1. At which point the question should be "why?" :)

Fixed by: a41dbf5e004e ("mount: hold namespace_sem across copy in create_new_namespace()")

In any case, thanks for the proposed fix but it is already fixed
upstream and the fix you suggested indicates another bug that is the
real cause.

