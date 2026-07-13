Return-Path: <stable+bounces-273859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4wk8KvEBVWo9iwAAu9opvQ
	(envelope-from <stable+bounces-273859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:19:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B13374CEF4
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:19:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="a9xF0d/2";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273859-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273859-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98F4347E4AF
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72542439000;
	Mon, 13 Jul 2026 15:09:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA2437465
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:09:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955342; cv=none; b=JBWV/hGH8uEbIkVDwIm0EDSSn1IlzcAhdP4WQQFa02Iwzkn8pTYsq58EWYM4pVvjDUaXTUo0rt8lQRIUw3zZEBBO+/tT1x8sN5SUeUSMhacmIbD6yItis/SiKzmSf1jOsE8o/1a28DOvEAupi3Q6TJVjypryp0b5gEQ+tmEvuOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955342; c=relaxed/simple;
	bh=iBCTBITROoFtlNKDjrunQPxWWHqiU3SOrFt93K5iEuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFSUF116nLjjmZjCyEnY1YBggp7kysHnbwJ2VWOV3ON/F/xyOVJUm/KWAuStoazQl9tOrLj+Lk/WSGSK5z/nZKa9jr/Gh46bw5lxuts7BJ0uovp2ts9WMOZLFxn41dtLVRTK3rQJp3vp4kjshA81k1TTDM0wNrewWasLAylp/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a9xF0d/2; arc=none smtp.client-ip=95.215.58.171
Date: Mon, 13 Jul 2026 17:08:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783955338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+M1zr9rTUgQMNlUXBESdweoGf9U7X+OYDnRmO6YXH1M=;
	b=a9xF0d/2L71ONYPVPsefz3XZSfE3ZamyNJyyyZjrgNziQQUb/Ozdcat8yaN8Sx4s0lz75g
	QLt3rFlj1NCfC7V+n2SdodAEZULM4owumuDrhIRpdxnMki8Kp/jw5NRdoH0OUJNWOD/Nc6
	hZYkn0mKy11XwwDe/1Bb79Xwt/TZwbI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	MOKUNO Masakazu <mokuno@sm.sony.co.jp>, stable@vger.kernel.org,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
Message-ID: <alT_fEu9AtQT9PxU@linux.dev>
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
 <ik6jukrj.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ik6jukrj.ritesh.list@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-273859-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:ritesh.list@gmail.com,m:geoff@infradead.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:Geert.Uytterhoeven@sonycom.com,m:paulus@ozlabs.org,m:mokuno@sm.sony.co.jp,m:stable@vger.kernel.org,m:geoffrey.levand@am.sony.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,sonycom.com,ozlabs.org,sm.sony.co.jp,vger.kernel.org,am.sony.com,lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B13374CEF4

On Mon, Jul 13, 2026 at 06:08:56PM +0530, Ritesh Harjani wrote:
> Thorsten Blum <thorsten.blum@linux.dev> writes:
> 
> > If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> > decrements iopage but keeps using the failed mapping's offset. As a
> > result, it repeatedly tries to invalidate the failed IOPTE slot and
> > leaves the already installed IOPTEs valid.
> >
> > Recompute offset and invalidate the installed IOPTEs instead.
> >
> 
> Nice catch! I wonder how did you catch this?
> Do you have ps3 console where you somehow ran into this ;)
> Or was it a manual inspection?

I do have a PS3 somewhere, but I stumbled upon this while reading and
trying to understand the code.

> I wonder whether PS3 consoles are still being used?

Not sure.

> > Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")
> 
> Looks like this was from 2007.
> 
> However, the change looks good to me. So:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks,
Thorsten

