Return-Path: <stable+bounces-210581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KecGajVb2mgMQAAu9opvQ
	(envelope-from <stable+bounces-210581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:21:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEBC4A303
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8BB4A44551
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32F540B6CE;
	Tue, 20 Jan 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Tp+SieoN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734AF34E76E;
	Tue, 20 Jan 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930600; cv=none; b=p/LExW79hTwPVi2taJuayxZi932OYeoHsMbfGxdk8cwbzgK3HfqovwkU7sGXwxBbYraFYjyF6r6aVIxaVehkmaaY3BIwwywCbPM26j+EqRNi7AeAxMM+ECSDhl6xBvUik/p2umwUGROGBAD/AY78JVkzTSI+rDUyGnj1M6SwU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930600; c=relaxed/simple;
	bh=K0Ie7KHqcECTWWw6s8cTXnvc3JOQEzzS3gXq7gAGAOk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U9iZbFd5AMLjmrdp7ACbj+WRBfQuU149jMXE1gyiZW623OK+xD0p5n/llZ0OCyfnbHsv+57E4Joy1mJ1Yg14SmfcISDuZOAeRPBNfazMXFLEiV2LrpYguqgJkeBzbLVy9oWJq4FAbN/y8pdbBbRZ1LMmqVTDvMwv4KkQg9viWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Tp+SieoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5158C16AAE;
	Tue, 20 Jan 2026 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768930600;
	bh=K0Ie7KHqcECTWWw6s8cTXnvc3JOQEzzS3gXq7gAGAOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tp+SieoN+0i+MpO2Nt9UdeUBovtRKQ4c7Ozt7m0DAG56ZVjp992bCs1L+M3zd4iHx
	 3j85OK7yhlpwcqQUMqi3QijMos7Wq+haEHVO7emfiSsVvih/Igx86byiRgjUoh8xG/
	 slmk56H9ov0JprGSAPEC2NtI+o10egqt53KXCC2E=
Date: Tue, 20 Jan 2026 09:36:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: mm-commits@vger.kernel.org, surenb@google.com, stable@vger.kernel.org,
 rppt@kernel.org, pasha.tatashin@soleen.com, graf@amazon.com,
 ran.xiaokai@zte.com.cn
Subject: Re: [merged mm-hotfixes-stable]
 kho-init-alloc-tags-when-restoring-pages-from-reserved-memory.patch removed
 from -mm tree
Message-Id: <20260120093639.3d316ff26f802b36bfe7a285@linux-foundation.org>
In-Reply-To: <2vxzqzrke295.fsf@kernel.org>
References: <20260119203054.70AE8C116C6@smtp.kernel.org>
	<2vxzqzrke295.fsf@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210581-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BDEBC4A303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 15:24:06 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:

> > The quilt patch titled
> >      Subject: kho: init alloc tags when restoring pages from reserved memory
> > has been removed from the -mm tree.  Its filename was
> >      kho-init-alloc-tags-when-restoring-pages-from-reserved-memory.patch
> >
> > This patch was dropped because it was merged into the mm-hotfixes-stable branch
> > of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> This patch isn't quite complete. See [0]. It doesn't do anything wrong,
> it just doesn't fix the problem for every case.
> 
> I suggested a re-roll of this patch based on top of my cleanup patches
> [1], since I think with those the end result is a bit nicer.
> 
> I suppose we have 3 options:
> 
> 1. Take this patch in hotfixes and leave kho_restore_pages() path
>    unfixed. The fix the rest next merge window.
> 
> 2. Do a new version of this patch fixing kho_restore_pages() with the
>    current code, and then re-roll the clean up series to fix conflicts
>    for next merge window.
> 
> 3. Pull in the cleanups in hotfixes too, and then do a new revision of
>    this patch on top.
> 
> I don't think the end result of option 2 is too horrible, so I think
> that is probably the best option, but do let me know what you'd prefer.

No probs, I removed this patch from mm-hotfixes-stable and put it back
into mm-hotfixes-unstable, with a note that an updated version is expected.

