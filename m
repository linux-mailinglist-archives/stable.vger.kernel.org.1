Return-Path: <stable+bounces-254694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Is/GUGKF2qUIggAu9opvQ
	(envelope-from <stable+bounces-254694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:20:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EB45EB358
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA497305AD5C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364F38635D;
	Thu, 28 May 2026 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pfuxs5+8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2134389F
	for <stable@vger.kernel.org>; Thu, 28 May 2026 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927614; cv=none; b=YB/QFTN+wLgxvF6DVoIt2v9qpPpxRnPF5OHGcjPQefyrBJPWiLUPOYrIujFSBv7DTdRd0V0YtLNcRMNChBx6Imm+haeCSSgIqPjvbPqhIgNYlsw16gIRgtuFyLpp/iG3qUlvbzgWTMbTJkUiqTqETvq72W2U2GNT/LG7TkLN0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927614; c=relaxed/simple;
	bh=8FZlAMS3cExGTDwkl7f0tVVEFp4NVeiA85IZ3PrwM7o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qVaAS0T+idlH/Sdkpn3U/Q/3SUT+aB4EXxje0DS1JhFvg9fv1eLiZ9SK3vSWzOsDo+Mvx84QkTSJHEwLvaqTlfKWjeG7zYa0KmvmgkNXq8zy6MAjv28uPFYfH1fwqESj/mzWDtJh4AOJ0lz1+takmSjnBCsolNceAfRcID8fmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pfuxs5+8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABBD1F000E9;
	Thu, 28 May 2026 00:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779927612;
	bh=WwwxV04ucNWP/tbOhyJJVXjgJC8Fz+ra97PBKv7ZdNw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Pfuxs5+8QC5Cq7qioyxBl1g5TmeXmzeGqR4deuf/Yr6m7fqHjyaeIey0DaiDws7da
	 aWaYz/Nv0zdxV+PGz4Lj1JMJGh9B7XynaBDexpV9wQZ7cCF/phi94iecTVICs9twjD
	 hrgYDLQTUfSvd4zpxc8sCPyzrhYjjYO3X3Ejr8Sbs8PeAYF2HIrzxzBYKPuxvE7E67
	 vIWBHYj6ZBAjVhbdVOtxhL9lgwbBPYJquBShSpjTI3JXPRviWbLtDx4vxs2TqFbWk1
	 4XW6/5fjouKi7vWFxL/HXfJZGEbtd5Kbt5p2fPQRK5JEyBcqDn6eE6xq6myJ1E/216
	 4A943bmfn+JyA==
Date: Wed, 27 May 2026 18:20:07 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com, 
    aou@eecs.berkeley.edu, alex@ghiti.fr, vincent.chen@sifive.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH] riscv: kgdb: Fix a missing irq restore issue on an
 early-return path
In-Reply-To: <20260526113829.115007-1-hui.wang@canonical.com>
Message-ID: <994d9b89-b1d9-e642-0ef0-66a8cad538d5@kernel.org>
References: <20260526113829.115007-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254694-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 06EB45EB358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, 26 May 2026, Hui Wang wrote:

> If kgdb_handle_exception() fails, the local_irq_restore() is not
> called and the function returns to the caller with interrupts still
> disabled. To fix it, add the missing irq restore here.
> 
> Fixes: fe89bd2be866 ("riscv: Add KGDB support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Wang <hui.wang@canonical.com>

Was this found using an LLM or some other static analysis tool?  If so, 
please add an Assisted-by: tag, according to the directions documented 
here:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n637 

and here:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-assistants.rst


- Paul




