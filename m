Return-Path: <stable+bounces-256532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJXAFnI6GWoftggAu9opvQ
	(envelope-from <stable+bounces-256532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:04:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDF25FE46F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E3C73067AEE
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E529A3A872E;
	Fri, 29 May 2026 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ym2KkiJT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QHDxbAiV"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706983AB5B2;
	Fri, 29 May 2026 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038247; cv=none; b=AUg1d0ltoEaLOobf0kMkj4afnhaATFJJr9ZEgQrA8/BHm7/dQ/nV3TqaqAcKY2LVzGYY+9TxeME9QOnQ1ofEyDoCr2C0eywE4PmmMb4TSa4/l7aHBa2fs0yBS+XURi+grcGFPKDrgkox5lZoOoRrr0cUqc9/7OvgoaqPWx+cItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038247; c=relaxed/simple;
	bh=v7sX+ULYT5bCj9o9c0kVdTQQZkubq/TBTjiGXqtMynM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B50aYDZ93moEggTt7ahbb88Q2PQ6KQTO18v+00DCs6gQQA+33z5NpBEZ2dTFO9A5BzwkWyrracxJ8drQMXnz0CznEcUdn3ffGA+9DCt17oJ2zSCFrdbvf7wL7L5oOSzgyD4CifaBI7ebZx6P7Ig8W/aWclUm93UpznvsSJHUspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ym2KkiJT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QHDxbAiV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 May 2026 09:04:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780038244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7sX+ULYT5bCj9o9c0kVdTQQZkubq/TBTjiGXqtMynM=;
	b=ym2KkiJT8yxfe0+7nEzMH2D7BFEsvlBxWuvKUzpj5vquXtXt5AZO6UrKunp3e/FkMDaK0l
	+EYK8QvqoyfnFMwSJi5r8vFXQ4KOGMp/aSlOXdY5uHxHt3xNX7bPYqThVy09B9CqrpWtCt
	7dgapZ78Q5fdAq7fPKqQAz38Ls4bYWUx1Wt97Dmj+WgvArDXoyT0LP5u5ciGWgQ79mfEGy
	aMYg0Q08gDQyNnO/kgttXYWfZaPqgqvRzVggtzlQRzSWf6ZvHNI7+pJXWIKA70eDrmiZC4
	ZaTcN+3Lqkt3EQvECAIwRygIzm45Lx9OVvWjRg14ABoWN/XResx3KZM9fD+BoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780038244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7sX+ULYT5bCj9o9c0kVdTQQZkubq/TBTjiGXqtMynM=;
	b=QHDxbAiV/UdeiPePRE9mQXXZuSv9ahUCAaQXZUJ/Z2D0YuxYo+GW+IEux4PPxDsgPqT9Ph
	RwNBvz075PtTDTBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: ram.vegesna@broadcom.com, James.Bottomley@hansenpartnership.com,
	martin.petersen@oracle.com, kees@kernel.org, tglx@kernel.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
Subject: Re: [PATCH] scsi: elx: efct: fix resource leak in
 efct_xport_initialize()
Message-ID: <20260529070403.yEv7faft@linutronix.de>
References: <20260529040115.2735213-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529040115.2735213-1-dawei.feng@seu.edu.cn>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256532-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CCDF25FE46F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-29 12:01:15 [+0800], Dawei Feng wrote:
> Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

Based on inspection, it looks like the right thing to do.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

