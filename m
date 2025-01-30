Return-Path: <stable+bounces-111265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4EA22A95
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 10:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9C01887DDE
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F72B1E4B2;
	Thu, 30 Jan 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASEJ3uLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108C7139B
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738230094; cv=none; b=SjuZlg/XulZ4QUzJUpSY+3r7KwmjiOQgjOj7C4l0tifANaLGq3xxNnx890j727hl1+4tyOkfFX8yzlaA8ymTcpe5W+QZiwhKnZwELeZOpB4sFnFlvX6aHjyNQlVIF7q6j+rLZ217IL3n05eNMJYJJ6mtjhbW4Py2O+NsqxMxNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738230094; c=relaxed/simple;
	bh=zzF1PYDsQ3iyTEkZO60gNn62uSxCoVAsvHA0KntEilY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5fJ5lMBqWqW4dKRiE3A3tq3hRuIgeyrnjOAJdmQiGMZKaTtG4oWT9j+d9TmmF0Gwq8I16XlRMJV3ebm5SB4Rs83VrTy+c5NWDpkjnVDTiSXx5Q+PM5SGImV0uPkuxThsHdlcEund8e1gKJkL+qtTHP5dJWMv7amS9s+liZpeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ASEJ3uLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAD2C4CED2;
	Thu, 30 Jan 2025 09:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738230093;
	bh=zzF1PYDsQ3iyTEkZO60gNn62uSxCoVAsvHA0KntEilY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASEJ3uLEmGwhQFRT1Jz/5uu3FiVFeoyodbvXxMVu8NtKgXV+WevIkp1BKH0/PiND/
	 D9BzO0nOxpW1xe5HEfsDCXzH+kSFvsdls02cEGwAg05/fcEC6AjBaemQj7SAsM/1r8
	 QD7SYgV0SJ2RSBsl2Uf8zLB19A0040e2fHR+OTIw=
Date: Thu, 30 Jan 2025 10:41:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vgiraud.opensource@witekio.com
Cc: stable@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
	Theodore Ts'o <tytso@mit.edu>, stable@kernel.org,
	Bruno VERNAY <bruno.vernay@se.com>
Subject: Re: [PATCH 6.1] ext4: fix access to uninitialised lock in fc replay
 path
Message-ID: <2025013052-nephew-coat-c8b6@gregkh>
References: <20250129101046.105471-1-vgiraud.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129101046.105471-1-vgiraud.opensource@witekio.com>

On Wed, Jan 29, 2025 at 11:10:46AM +0100, vgiraud.opensource@witekio.com wrote:
> From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
> 
> commit 23dfdb56581ad92a9967bcd720c8c23356af74c1 upstream.
> 
> The following kernel trace can be triggered with fstest generic/629 when
> executed against a filesystem with fast-commit feature enabled:
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 0 PID: 866 Comm: mount Not tainted 6.10.0+ #11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0x90
>  register_lock_class+0x759/0x7d0
>  __lock_acquire+0x85/0x2630
>  ? __find_get_block+0xb4/0x380
>  lock_acquire+0xd1/0x2d0
>  ? __ext4_journal_get_write_access+0xd5/0x160
>  _raw_spin_lock+0x33/0x40
>  ? __ext4_journal_get_write_access+0xd5/0x160
>  __ext4_journal_get_write_access+0xd5/0x160
>  ext4_reserve_inode_write+0x61/0xb0
>  __ext4_mark_inode_dirty+0x79/0x270
>  ? ext4_ext_replay_set_iblocks+0x2f8/0x450
>  ext4_ext_replay_set_iblocks+0x330/0x450
>  ext4_fc_replay+0x14c8/0x1540
>  ? jread+0x88/0x2e0
>  ? rcu_is_watching+0x11/0x40
>  do_one_pass+0x447/0xd00
>  jbd2_journal_recover+0x139/0x1b0
>  jbd2_journal_load+0x96/0x390
>  ext4_load_and_init_journal+0x253/0xd40
>  ext4_fill_super+0x2cc6/0x3180
> ...
> 
> In the replay path there's an attempt to lock sbi->s_bdev_wb_lock in
> function ext4_check_bdev_write_error().  Unfortunately, at this point this
> spinlock has not been initialized yet.  Moving it's initialization to an
> earlier point in __ext4_fill_super() fixes this splat.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> Link: https://patch.msgid.link/20240718094356.7863-1-luis.henriques@linux.dev
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: stable@kernel.org
> Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
> Signed-off-by: Victor Giraud <vgiraud.opensource@witekio.com>
> ---
>  fs/ext4/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

You forgot about 6.6.y, please ALWAYS check if a commit is in a newer
kernel or not, because we can't take them if the are not there also.

thanks,

greg k-h

