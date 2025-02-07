Return-Path: <stable+bounces-114263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6642A2C694
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 16:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57D17A12C1
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D581DD529;
	Fri,  7 Feb 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MrEzHuiC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC1238D29;
	Fri,  7 Feb 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941031; cv=none; b=Kd+KtKosn5sboYDeup07QY9KaSPvLNgxGl9PhKhGNfFnv9tarbSdWSLxREmEk1VVwturVW3U2LWLEwN4yZ/jArglC8mxUUNJjIFwbC4cjVARndnGnclFNcAzJwb8aI42T979l2vmXCJK8G66onmWmQIjg3PdvgFR20mwv+mFXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941031; c=relaxed/simple;
	bh=82Hn5Vv9+moRLz5/ytKgYhAzHehuPFQCaFbwqbElOfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knXherULmu8c65GKT70UEOwx070mDra83KAURVac/u6ytJQmbfgB7iwbZtisWlkfptae1tB6Du2QnFazAzf7578nkFLMBTfbntmMmI9NxxdjJ7gs2aavSWti28ouDGBrXVMofKcuWsxm74lVnPiQMKU3kH4hOvHD7KmC4gXi8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MrEzHuiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F34C4CED1;
	Fri,  7 Feb 2025 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738941031;
	bh=82Hn5Vv9+moRLz5/ytKgYhAzHehuPFQCaFbwqbElOfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrEzHuiC4XmPMEX/55C6UUY4OkcAhWwVpv5qLHhib5L9zeyBbxOzDdvY+Er82ur7g
	 jf22Qfq+bVq2eXWI7cWN5ZchyR2BAQqgKzigs85G9ERMwMEwC1VTIwAvntoDAJFAiD
	 fkw7oXWRkIP3wP99CE1JBt4ZGXK/xS3ASiNNYC1E=
Date: Fri, 7 Feb 2025 16:10:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: rafael@kernel.org, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: queue-5.10: Panic on shutdown at platform_shutdown+0x9
Message-ID: <2025020722-joyfully-viewless-4b03@gregkh>
References: <231c0362-f03e-4cef-8045-0787bca05d25@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <231c0362-f03e-4cef-8045-0787bca05d25@oracle.com>

On Thu, Feb 06, 2025 at 01:31:42PM -0500, Chuck Lever wrote:
> Hi -
> 
> For the past 3-4 days, NFSD CI runs on queue-5.10.y have been failing. I
> looked into it today, and the test guest fails to reboot because it
> panics during a reboot shutdown:
> 
> [  146.793087] BUG: unable to handle page fault for address:
> ffffffffffffffe8
> [  146.793918] #PF: supervisor read access in kernel mode
> [  146.794544] #PF: error_code(0x0000) - not-present page
> [  146.795172] PGD 3d5c14067 P4D 3d5c15067 PUD 3d5c17067 PMD 0
> [  146.795865] Oops: 0000 [#1] SMP NOPTI
> [  146.796326] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted
> 5.10.234-g99349f441fe1 #1
> [  146.797256] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.3-2.fc40 04/01/2014
> [  146.798267] RIP: 0010:platform_shutdown+0x9/0x20
> [  146.798838] Code: b7 46 08 c3 cc cc cc cc 31 c0 83 bf a8 02 00 00 ff
> 75 ec c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47
> 68 <48> 8b 40 e8 48 85 c0 74 09 48 83 ef 10 ff e0 0f 1f 00 c3 cc cc cc
> [  146.801012] RSP: 0018:ff7f86f440013de0 EFLAGS: 00010246
> [  146.801651] RAX: 0000000000000000 RBX: ff4f0637469df418 RCX:
> 0000000000000000
> [  146.802500] RDX: 0000000000000001 RSI: ff4f0637469df418 RDI:
> ff4f0637469df410
> [  146.803350] RBP: ffffffffb2e79220 R08: ff4f0637469dd808 R09:
> ffffffffb2c5c698
> [  146.804203] R10: 0000000000000000 R11: 0000000000000000 R12:
> ff4f0637469df410
> [  146.805059] R13: ff4f0637469df490 R14: 00000000fee1dead R15:
> 0000000000000000
> [  146.805909] FS:  00007f4e7ecc6b80(0000) GS:ff4f063aafd80000(0000)
> knlGS:0000000000000000
> [  146.806866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  146.807558] CR2: ffffffffffffffe8 CR3: 000000010ecb2001 CR4:
> 0000000000771ee0
> [  146.808412] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  146.809262] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [  146.810109] PKRU: 55555554
> [  146.810460] Call Trace:
> [  146.810791]  ? __die_body.cold+0x1a/0x1f
> [  146.811282]  ? no_context.constprop.0+0xf8/0x2f0
> [  146.811854]  ? exc_page_fault+0xc5/0x150
> [  146.812342]  ? asm_exc_page_fault+0x1e/0x30
> [  146.812862]  ? platform_shutdown+0x9/0x20
> [  146.813362]  device_shutdown+0x158/0x1c0
> [  146.813853]  __do_sys_reboot.cold+0x2f/0x5b
> [  146.814370]  ? vfs_writev+0x9b/0x110
> [  146.814824]  ? do_writev+0x57/0xf0
> [  146.815254]  do_syscall_64+0x30/0x40
> [  146.815708]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> 
> Let me know how to further assist.

Bisect?

