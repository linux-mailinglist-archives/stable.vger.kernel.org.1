Return-Path: <stable+bounces-241416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNhoJJKZ72nQDAEAu9opvQ
	(envelope-from <stable+bounces-241416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:14:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD1476EF0
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D50B03007229
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3A63E1CF0;
	Mon, 27 Apr 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEXFDEYg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAAB3E123F;
	Mon, 27 Apr 2026 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310090; cv=none; b=MLZkg/uLQSCDEEAc6Bz5dT9817q+6lAJxvsO5pUN/ddwf9m/W0sMHBz5FJXoSeclPDd5fIBSfAxfMLJjWVYiGHW/YWj5c5bXaP9We+/d5rhbjpMS7NteoTP5xdz2kqtBTNycPZNTPazK1Wsd0gdb0a6gZqpZNJ2OX+hv2LYSJQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310090; c=relaxed/simple;
	bh=uaNpaS0Ev7DdtKYnDFjWD2fgInIt4Y0PNPyJr08na+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRHpmOCcZaXaAqS43/B4X985piJQT806Bl94xkGKFh60+gzDr51gVB/U16gQikLk3GWcHMHyJa+JG8DOByxR580QY6dppY1IXhDqF5ZpdVHwTIjCdoapjjlYPwBRIuCuARgUGe4gbMhO+/hiwuNZiYWMcLVx3P9jgkJc6ihaQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEXFDEYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E7FC2BCB4;
	Mon, 27 Apr 2026 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310089;
	bh=uaNpaS0Ev7DdtKYnDFjWD2fgInIt4Y0PNPyJr08na+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEXFDEYg1zyfKOErLSrTOcO+HrjJ1m6qS8zMcLuTAo09znx6bINUj84Q5FuCQ2FOC
	 G/D8v/iLUt/DijiFuj4/werNQ9oPoRXAn2Mp2REnmML1oC2NWlwB1nAr56/caND2PB
	 w5Rf+smW34sleGsgS7rTpnfIjoNEI7MIZPvAOSrXsQZXayE36ew5W/vVrEr/ce3O6D
	 d+V2gPEYQ863JzSJAn1Wzkx73l6qpUvALXFwBuc83dthtPTrhiUwZL+AAcDtBSEe4W
	 ocrL/4m4cJWUq2vEd0ORVmGCuUcCSK2lMjToPXuY9ns2W+TMvdO+Izedxtx0Ove9dr
	 l+5GQZNVDAe4A==
Date: Mon, 27 Apr 2026 07:14:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Ravineet Singh <ravineet.a.singh@est.tech>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, stable <stable@kernel.org>,
	David =?iso-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>
Subject: Re: [PATCH] kernfs: protect of->kn access in fop_read_iter/fop_mmap
Message-ID: <ae-ZiHku9wRYqfyo@slm.duckdns.org>
References: <20260427133521.62793-1-ravineet.a.singh@est.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427133521.62793-1-ravineet.a.singh@est.tech>
X-Rspamd-Queue-Id: C8DD1476EF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241416-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello,

On Mon, Apr 27, 2026 at 03:35:21PM +0200, Ravineet Singh wrote:
> kernfs_fop_read_iter() and kernfs_fop_mmap() dereference of->kn->flags
> without holding an active reference on the kernfs node. If the node is
> removed concurrently, this leads to a use-after-free:
> 
> [  448.037888] Unable to handle kernel paging request at virtual address ffffff821d8cedf0
> [  448.093213] Mem abort info:
> [  448.104535]   ESR = 0x0000000096000005
> [  448.113391]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  448.126411]   SET = 0, FnV = 0
> [  448.130758]   EA = 0, S1PTW = 0
> [  448.134268]   FSC = 0x05: level 1 translation fault
> [  448.140335] Data abort info:
> [  448.143275]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [  448.150223]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  448.155668]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  448.161233] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000afab8000
> [  448.168835] [ffffff821d8cedf0] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [  448.178817] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> [  448.284717] pc : kernfs_fop_read_iter+0x1c/0x1ac
> [  448.289416] lr : vfs_read+0x1c0/0x2a0
> [  448.368374] Call trace:
> [  448.370855]  kernfs_fop_read_iter+0x1c/0x1ac
> [  448.375156]  vfs_read+0x1c0/0x2a0
> [  448.378508]  ksys_read+0x6c/0x100
> [  448.381901]  __arm64_sys_read+0x18/0x20
> [  448.385768]  invoke_syscall.constprop.0+0x4c/0xe0
> [  448.390502]  do_el0_svc+0x3c/0xb8
> [  448.393898]  el0_svc+0x18/0x4c
> [  448.396990]  el0t_64_sync_handler+0x118/0x124
> [  448.401377]  el0t_64_sync+0x14c/0x150

Do you have a repro for this?

> Use kernfs_get_active_of() to obtain an active reference that also
> checks the released flag, consistent with other of->kn accesses in
> fs/kernfs/file.c. These paths were not covered when
> kernfs_get_active_of() was introduced in commit 3c9ba2777d6c8
> ("kernfs: Fix UAF in polling when open file is released").

My memory is hazy but of->kn should be valid as long as of is alive. inode
holds the pin to its kn until inode is released and open files pin their
inodes. Active ref is something different - it's used to implement revoke
semantics so that the backend kernfs implementation can disconnect from
lingering open files, but that's not what controls the object lifetimes.

Thanks.

-- 
tejun

