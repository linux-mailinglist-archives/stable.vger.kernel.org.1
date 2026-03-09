Return-Path: <stable+bounces-223720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDriBHIZr2nHNgIAu9opvQ
	(envelope-from <stable+bounces-223720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 20:03:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D3423F1DB
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 20:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1A4F30164BD
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 19:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011C733F8BC;
	Mon,  9 Mar 2026 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eYFNuoYY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC0285C9D;
	Mon,  9 Mar 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082971; cv=none; b=tng3Z0Y+aFOAe/T0dYyiZLqeXkS6GksOB3P6+RpU2bV3948UOmCgl0EVtqy9Wp9UCWh3oWyUKi+LsxnLidryB6UqxA9fw8viPXxyzRXqFT0yIMNapOGI0TPBRo93GBjgzY69LlmJEgJplHcnSLNj9qrJhK8w0s70mLF38I6vwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082971; c=relaxed/simple;
	bh=ZJxuHaqVupo1aiRjhDHga7VJlJZFRrftyuA8Ijw/LHk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cIXvxiXGVYf3iLJMHXlm0+8wsvwLFKi4PyEXQIFUIiEcm+7u1nD/peTtE9hfoGkb2ecpcLHyw7R8IXlmkkoam+eYM1gpsFZkX18SQegW7q+Gq3QXi/kFpuXXHPWpWBLWwIoRbvSkmtMjSOBI4k++NcLupoCIMRc6GWnoL+l3LH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eYFNuoYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D01CC4CEF7;
	Mon,  9 Mar 2026 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773082971;
	bh=ZJxuHaqVupo1aiRjhDHga7VJlJZFRrftyuA8Ijw/LHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eYFNuoYYj/ejfzWlXnnQJy9tdaG1EVkoadvdUf3hJjsNG2lWgS25mHqLVrFFj1yGO
	 KXciY1yvZ30BefcKo4Un3tGrg31Ou+z/LiwYE3q6RSeb1cgc9oRaDFksw97tHLmuff
	 Udw1ZVa907dbbm1xYXCHSQz8nn2r6EXPBXWKED60=
Date: Mon, 9 Mar 2026 12:02:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: steven chen <chenste@linux.microsoft.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, Baoquan He
 <bhe@redhat.com>
Subject: Re: Patch "kexec: define functions to map and unmap segments" has
 been added to the 6.12-stable tree
Message-Id: <20260309120251.a7bd8ac9c2161c0b90fb1c0e@linux-foundation.org>
In-Reply-To: <dc1de7c4-4ff9-4c12-89ae-dee1e76017f2@linux.microsoft.com>
References: <20260308164105.18682-1-sashal@kernel.org>
	<dc1de7c4-4ff9-4c12-89ae-dee1e76017f2@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 97D3423F1DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223720-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026 11:20:49 -0700 steven chen <chenste@linux.microsoft.com> wrote:

> > +void *kimage_map_segment(struct kimage *image,
> > +			 unsigned long addr, unsigned long size)
> > +{
> 
> please consider the following patch applicable or not:
> 
> [PATCH 1/2] kernel/kexec: Change the prototype of kimage_map_segment() - 
> Pingfan Liu 
> <https://lore.kernel.org/linux-integrity/20251105130922.13321-1-piliu@redhat.com/>

That series was upstreamed in December.

