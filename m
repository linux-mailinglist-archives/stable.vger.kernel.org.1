Return-Path: <stable+bounces-247197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOohIhLGBWrDbAIAu9opvQ
	(envelope-from <stable+bounces-247197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:54:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F098541F72
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABEA63077DE3
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF213959D;
	Thu, 14 May 2026 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YAPOGlfC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A8286D5C
	for <stable@vger.kernel.org>; Thu, 14 May 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763165; cv=none; b=S4nD+GK7BzOH3Q3TwhYnVpYgmOltY1AV89Hkc2kEKtavu4S7xwyKtWcPy8yosmvHOiWk277F7EaXpFV3xcNjpFBkFpUHlJ9LjyR8PaqF2m3w7gsNcJvHHiuLa2LTKhJW++f6xg8phkGvNiJblmzoanjexGzPX22gpEIx/6ruagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763165; c=relaxed/simple;
	bh=sv8SeJWmlqKVkM/+V3A8qiWklVYRKPvd9h+6xShWio4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLeZx6KXMbkTsi6p9lH/3MeSixivmWY2aTS8ly55cbw2d9zmaXg+SHT7D5+1VThxyFAFvUZB/jhXe+7zG5lzCUmyGla8LFac+lfWueosxFTdoJ84LVB2tOKoWvnxEmtvd9ldPyd87/LhUGS+9jD2f4b8JWPwUzBFzVeQz38MEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YAPOGlfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5334EC2BCB3;
	Thu, 14 May 2026 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778763164;
	bh=sv8SeJWmlqKVkM/+V3A8qiWklVYRKPvd9h+6xShWio4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAPOGlfC9LGcxCGK/crC2402APVwbqvST3X7rS0YRNiLMLtSIlFUruZMYdEyaEmrT
	 OfCJ2tZAEqjowokXRJYEazp97m0lK9qDlxxwPYjzkhQtHNX1+esapnAkebYnEajJWv
	 zuCnV9HCfgEwiUosINYHqYAexEbR4goWwa7ZaRsg=
Date: Thu, 14 May 2026 14:52:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: dnaim@cachyos.org, i.r.e.c.c.a.k.u.n+kernel.org@gmail.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clockevents: Add missing resets of the
 next_event_forced flag" failed to apply to 7.0-stable tree
Message-ID: <2026051443-boozy-deity-d70f@gregkh>
References: <2026051258-schedule-parcel-c95c@gregkh>
 <87o6iiz2mf.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6iiz2mf.ffs@tglx>
X-Rspamd-Queue-Id: 2F098541F72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247197-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cachyos.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,kernelorg];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 12:50:32PM +0200, Thomas Gleixner wrote:
> On Tue, May 12 2026 at 15:50, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 7.0-stable tree.
> 
> Obviously not. It's in linux-7.0.y since April 22:
> 
> commit 9401b593fa48218d2667df1610b0ebc518554880
> Author:     Thomas Gleixner <tglx@kernel.org>
> AuthorDate: Tue Apr 21 08:26:19 2026 +0200
> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitDate: Wed Apr 22 13:32:23 2026 +0200
> 
>     clockevents: Add missing resets of the next_event_forced flag
>     
>     commit 4096fd0e8eaea13ebe5206700b33f49635ae18e5 upstream.
> 

Sorry about that, my fault :(

