Return-Path: <stable+bounces-56008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDE91B267
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 00:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62861C2211F
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 22:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC68E1A0B1A;
	Thu, 27 Jun 2024 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1f+ja6sy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98633131E41;
	Thu, 27 Jun 2024 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528866; cv=none; b=gH4i5rwPanuj7PtD3VBGBMTK7hTLd3JqUmwRnmME9kxdA8zzHBf0jJ8Cpu2gUkckoSkhWo/XcAfXIkw+C9EpHVGLG4jdFMpcUcXPjSiNBMNLj2Uo0xeO8EJeh6qhM64l0Q2m07ETtBgXiUTWlN8vILATNZoXBRzZ3lNckxnLqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528866; c=relaxed/simple;
	bh=+qEPYpz8xtAY3td5Z6Cp6xlrXoZsas6tJ0SWNWrPBrE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OVDkxpPm2JtAp70Nxydl5CfAVLjKpakal9D6JuLpsYBIiOt+fv2MURHooaDcY+acIEBZEROw21JcuWtOgmDg2nxvDwb5Vb2gY+fhjEOlX/A7x3fyX9jTzc8+Np+0UqgKLeYtXxZwmtmbtuNeFQqo3FZwiNMWh54uMXQXSsdaki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1f+ja6sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056ABC2BBFC;
	Thu, 27 Jun 2024 22:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719528866;
	bh=+qEPYpz8xtAY3td5Z6Cp6xlrXoZsas6tJ0SWNWrPBrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1f+ja6syF1eHjxkjAo9/tlTkfg97XktIheL7Mj0c0QPK3G2R5zsF3qwIHDYEK6zU2
	 X+b68C3cQ8uToCehyGamUMQv5hiWgQCeG411Lmq1XzJaIUoa65M0gCHk2lQRDMuIRS
	 Hk9VPY3PcVUpXSzppOP2+FlJ1I5VW7mg1e7+fxiw=
Date: Thu, 27 Jun 2024 15:54:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: peterx@redhat.com, yangge1116@126.com, david@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
Message-Id: <20240627155425.a31792e7c4709facfcbd417c@linux-foundation.org>
In-Reply-To: <20240627221413.671680-1-yang@os.amperecomputing.com>
References: <20240627221413.671680-1-yang@os.amperecomputing.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 15:14:13 -0700 Yang Shi <yang@os.amperecomputing.com> wrote:

> The try_grab_folio() is supposed to be used in fast path and it elevates
> folio refcount by using add ref unless zero.  We are guaranteed to have
> at least one stable reference in slow path, so the simple atomic add
> could be used.  The performance difference should be trivial, but the
> misuse may be confusing and misleading.
> 
> In another thread [1] a kernel warning was reported when pinning folio
> in CMA memory when launching SEV virtual machine.  The splat looks like:
> 
> [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_pages+0x423/0x520
> [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not tainted 6.6.33+ #6
> [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
> [  464.325515] Call Trace:
> [  464.325520]  <TASK>
> [  464.325523]  ? __get_user_pages+0x423/0x520
> [  464.325528]  ? __warn+0x81/0x130
> [  464.325536]  ? __get_user_pages+0x423/0x520
> [  464.325541]  ? report_bug+0x171/0x1a0
> [  464.325549]  ? handle_bug+0x3c/0x70
> [  464.325554]  ? exc_invalid_op+0x17/0x70
> [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
> [  464.325567]  ? __get_user_pages+0x423/0x520
> [  464.325575]  __gup_longterm_locked+0x212/0x7a0
> [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
> [  464.325590]  pin_user_pages_fast+0x47/0x60
> [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
> [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
> 
> ...
>
> Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
> Cc: <stable@vger.kernel.org> [6.6+]

So we want something against Linus mainline for backporting ease.

>    3. Rebased onto the latest mm-unstable

mm-unstable is quite different - memfd_pin_folios() doesn't exist in
mainline!

So can you please prepare the fix against current -linus?  I'll hang
onto this patch to guide myself when I redo Vivek's "mm/gup: Introduce
memfd_pin_folios() for pinning memfd folios" series on top.



