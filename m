Return-Path: <stable+bounces-237604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC/sMDsm3WlkaQkAu9opvQ
	(envelope-from <stable+bounces-237604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:22:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF33F1422
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9E2F301CAA8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D05347BA7;
	Mon, 13 Apr 2026 17:22:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639C111CAF
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100921; cv=none; b=a5vMjPvMwW/tE+gXlC0qmpjK4xBbozYj3uu0fdS0SYCzp0C4ygBliVBEv1e/qgCLUWEVeQRRSonq3snfR5gDBSf4gox4TADT4aCmRQVSTZ55glEau3OW10bmeMBpa+AicpGfLA3RLohwAfB/V5rjqks+oYChm0kgyaDCtQZhZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100921; c=relaxed/simple;
	bh=n/eJPg2n6QzlgR1Bp4T5PSpPDrj3VgutDHeQb3wpcpA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=caetbzVoDXgWxS8kc/fLzCIiSuIcFOvlr+jCAguUa0cAnR/4fZJ0M6m0UUWEMcLmF7s28o2vQzusT59LOYt07DW29RnqYoXEMu3bIdtB8DIJM/7484iekes0kfDY0Jk1Fu266fVowLt1GD+cm92PIrfyXT3qCW22zD6MnHzUZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7AC1B92009C; Mon, 13 Apr 2026 19:21:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 748BD92009B;
	Mon, 13 Apr 2026 18:21:59 +0100 (BST)
Date: Mon, 13 Apr 2026 18:21:59 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sasha Levin <sashal@kernel.org>
cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: FAILED: patch "MIPS: mm: Rewrite TLB uniquification for the
 hidden bit feature" failed to apply
In-Reply-To: <alpine.DEB.2.21.2604131308370.29980@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2604131711230.29980@angie.orcam.me.uk>
References: <2026040730-expend-maimed-dc2a@gregkh> <20260412120103.mips-tlb-failed@kernel.org> <alpine.DEB.2.21.2604131308370.29980@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-237604-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DDF33F1422
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026, Maciej W. Rozycki wrote:

> > The 5.15 and 5.10 series fail to build due to memblock_free() API
> > differences and need to be reworked.
> 
>  Weird, those versions *booted* just fine with the backports here:
> 
> Linux version 5.15.202+ (macro@angie) (mips-linux-gnu-gcc-real (GCC) 13.2.0, GNU ld (GNU Binutils) 2.46.50.20260311) #5 SMP Wed Apr 8 02:35:17 BST 2026
> printk: bootconsole [early0] enabled
> CPU0 revision is: 01040102 (SiByte SB1)
> FPU revision is: 000f0102
> Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
> Board type: SiByte BCM91250A (SWARM)
> [...]
> 
> and likewise:
> 
> Linux version 5.10.252+ (macro@angie) (mips-linux-gnu-gcc-real (GCC) 13.2.0, GNU ld (GNU Binutils) 2.46.50.20260311) #6 SMP Wed Apr 8 02:52:08 BST 2026
> printk: bootconsole [early0] enabled
> [...]
> 
> I'll figure out what's happened and repost.  Thank you for the guidelines.

 There you go:

arch/mips/mm/tlb-r4k.c:765:31: warning: passing argument 1 of 'memblock_free' makes integer from pointer without a cast [-Wint-conversion]
  765 |                 memblock_free(tlb_vpns, tlb_vpn_size);
      |                               ^~~~~~~~
      |                               |
      |                               struct tlbent *
In file included from arch/mips/mm/tlb-r4k.c:15:
./include/linux/memblock.h:106:31: note: expected 'phys_addr_t' {aka 'long long unsigned int'} but argument is of type 'struct tlbent *'
  106 | int memblock_free(phys_addr_t base, phys_addr_t size);
      |                   ~~~~~~~~~~~~^~~~

(and I have -Werror temporarily disabled due to piles of benign warnings 
such as "no previous prototype for [...]" for things we've had since 1990s 
that have kept distracting me from higher priority issues, and then forgot 
to double-check the compilation log).  I've posted v2 for both branches 
now.

  Maciej

