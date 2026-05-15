Return-Path: <stable+bounces-247708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL/lHZgKB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:59:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F7A54EF0D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37400301221D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B7480348;
	Fri, 15 May 2026 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDJe5+ss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1348033A
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845940; cv=none; b=Ucb6gAIoZVUKwBnG8he++MjQS1EpJoBRcHBsNCfJorAXt2Rqh6phHHh0fjzQdtDOhsySlV0NrfMOT1pObpdTbnk6g61udbZMa55mh2tVn0uhRmEKGrF8EXq7L4pjOj5PCHo3NS74UDM0hwojgydbbn3Y2AS7aKsb0KgO2fGABiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845940; c=relaxed/simple;
	bh=8PaiCWf8AUezg7he7iC2b47fmtUb+20mIJPeEv7U/Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agKYBU2n+f+A/8AMysNzwR8iEWoWtJg5qDvpKb3VxUnPdddSY9VTMT+endXGgzAbCmESyydkdf4cp3kXyKthe/vwpalGbcs6XXmEJyyosCy9W36tVTsYnqIwRQNIMyUhW2XpuR83zqQ9ugKYIvCP5PtA47CMwjUZNk/ClbILwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDJe5+ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B668DC2BCB0;
	Fri, 15 May 2026 11:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778845940;
	bh=8PaiCWf8AUezg7he7iC2b47fmtUb+20mIJPeEv7U/Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDJe5+sso7hd35pmgzbRec8EJdYFSAwXcWDHIULo7DbPrsDAl6hsi5m0Tws7hwLeq
	 nWZpRus0U9ISk9umHlTdCNb+ibfhrhUAoXMAlFkw6TeLMgFmhxcv+LAspg3ZcUFjN8
	 FZsCkn35Rt0VEoc00wFmuhNtBeWH4h2CjnsZ+tukSsz5wrgZ4CntgmHLEqsJCEwGgz
	 qHApvhZmrQ5QX/FiKlCSUyuA6kMPIFs9pE9dHXdTR6qDLdaoDPIqkuc0ZT13XVeEOP
	 yb6hTSsP+gEYH+VGqakcdb0IiJIbaGhnKtyUVGHiBv2xYKeDHScSELnkDzyD6ifWD/
	 OR01yP1WM1yIA==
Date: Fri, 15 May 2026 12:52:17 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ahmed Elaidy <elaidya225@gmail.com>, Andrei Vagin <avagin@gmail.com>, 
	stable@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH 6.18.y v3] mm: fix VM_SOFTDIRTY propagation on VMA merge
Message-ID: <agcH4ve5jrc0iQWN@lucifer>
References: <CANaxB-xFcF7U=wJv8EqKy=j=-P3SN+sLQ9ytH8Ej69h03tqL8Q@mail.gmail.com>
 <20260504195447.31794-1-elaidya225@gmail.com>
 <2026051531-failing-nectar-83bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026051531-failing-nectar-83bf@gregkh>
X-Rspamd-Queue-Id: 21F7A54EF0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247708-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux-foundation.org,kvack.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:22:02AM +0200, Greg KH wrote:
> On Mon, May 04, 2026 at 10:54:47PM +0300, Ahmed Elaidy wrote:
> > During VMA merging, such as through mprotect(), VM_SOFTDIRTY flags could be
> > lost. This breaks tools relying on soft-dirty tracking, such as CRIU
> > incremental dump/restore.
> >
> > Upstream resolved this using a broader VM_STICKY infrastructure (commit
> > bf14d4a05387 "mm: propagate VM_SOFTDIRTY on merge"). To minimize churn and
> > risk in the stable 6.18.y tree, this patch skips backporting the entire
> > VM_STICKY series (9 patches). Instead, it introduces a minimal standalone fix.
>
> 9 patches is nothing.  Please just backport the whole thing, especially
> as we will be maintaining this kernel for a long time.  We want what is
> upstream for future issues/fixes, right?

FWIW, agreed!

>
> thanks,
>
> greg k-h

Cheers, Lorenzo

