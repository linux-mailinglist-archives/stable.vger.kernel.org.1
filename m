Return-Path: <stable+bounces-247628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EUHIjPqBmpKowIAu9opvQ
	(envelope-from <stable+bounces-247628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:41:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F1754C9AB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07522308C890
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE41443CEE4;
	Fri, 15 May 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZtU9Dt5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914143DA2B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836918; cv=none; b=e0W+T5yZ9L36ZShCODEWoBjXuDD/wsXADwAFZSasbpIb6YMc4315GhKay79aYuoPsPnXVbchjouRo3EWVVAz9MvITnvoiAapq5eCB42lnhCnO6IFO4iRWJTHD+pfvShwTT5o+4ZreLOfwzVtPCsOom0Nkj1ivJHshYeP9trZNdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836918; c=relaxed/simple;
	bh=krDixN9cImzUINNa6Us33zC5coP7rdNz9y3siAFvjPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlH0I1E2Rrl3DYYxlPDvCZTf7RnujqvZAVlDRjHXvkzONTh/w9lLUOBn4IWdA0KQgXWba7FZi2QpX3xumldXW9vhsBrKAT58ZfS6EzyAtCKnide7VV0EQOxx9yeSE47opnFRc2Vb94eJG2Peg9a/oMiuxKZjCZvpP1uzD+1oFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZtU9Dt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F51FC2BCB0;
	Fri, 15 May 2026 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778836918;
	bh=krDixN9cImzUINNa6Us33zC5coP7rdNz9y3siAFvjPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vZtU9Dt5WIVq0BK/9r6wJhbJ52OVVUzbQN24aCI1+8o4UcoYz09Gg2mVSu8du25RI
	 NdNOI4J7J/JnyAJaYL01s5DEJNQJAEYLuOmkQHmaKMFk80eZ3IxDz3Nkqm6TjYCoXz
	 NEHhXCwNI+hLozBES6iWNJXIJZPYzGyqpYWHNRcU=
Date: Fri, 15 May 2026 11:22:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ahmed Elaidy <elaidya225@gmail.com>
Cc: Andrei Vagin <avagin@gmail.com>, stable@vger.kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.18.y v3] mm: fix VM_SOFTDIRTY propagation on VMA merge
Message-ID: <2026051531-failing-nectar-83bf@gregkh>
References: <CANaxB-xFcF7U=wJv8EqKy=j=-P3SN+sLQ9ytH8Ej69h03tqL8Q@mail.gmail.com>
 <20260504195447.31794-1-elaidya225@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504195447.31794-1-elaidya225@gmail.com>
X-Rspamd-Queue-Id: 80F1754C9AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247628-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,oracle.com,linux-foundation.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 10:54:47PM +0300, Ahmed Elaidy wrote:
> During VMA merging, such as through mprotect(), VM_SOFTDIRTY flags could be
> lost. This breaks tools relying on soft-dirty tracking, such as CRIU
> incremental dump/restore.
> 
> Upstream resolved this using a broader VM_STICKY infrastructure (commit
> bf14d4a05387 "mm: propagate VM_SOFTDIRTY on merge"). To minimize churn and
> risk in the stable 6.18.y tree, this patch skips backporting the entire
> VM_STICKY series (9 patches). Instead, it introduces a minimal standalone fix.

9 patches is nothing.  Please just backport the whole thing, especially
as we will be maintaining this kernel for a long time.  We want what is
upstream for future issues/fixes, right?

thanks,

greg k-h

