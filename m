Return-Path: <stable+bounces-192287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F043BC2E7C4
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 00:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 992674E3121
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB1730100B;
	Mon,  3 Nov 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G/Vcf6HC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D837126F0A;
	Mon,  3 Nov 2025 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213981; cv=none; b=VV3xBNWuWlJ8zo8kieK5A67W4XjhZAenwmgBjpXKZNbhBQJtWz6saSdQ37btDESPZuvToyyg0G9oslu5Tf0n5jOhaDipuZUUr2bQwiIpLAHyVyDS+wAF24+DQkVA2a4WQvO+A/CQgM+iF6exWu1V44AROj1URon7VqOWI+lccTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213981; c=relaxed/simple;
	bh=tGzK9R2ZDq3iZefSxigTk0vifeKf2tE7fUT5zVytAJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsOsdF6egBLDxcJwL2iwgYpwZeTLCU8fxZ0fF/c0phxa3PXZfuYf1dSYlc5Sb7LVFGz2gBCt2RXOy8Ujt3Hlntajxprpip5tWiQ9V60shMsgwWkmw2Tu/IJm7ORtb/u67AuBdI59TH3ChsLSxZTnfqjtPDFbG7AeIuu4ylyQJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G/Vcf6HC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063BCC4CEE7;
	Mon,  3 Nov 2025 23:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762213980;
	bh=tGzK9R2ZDq3iZefSxigTk0vifeKf2tE7fUT5zVytAJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/Vcf6HC42/jFWtXxuhcG/54fWnN4AgMX+XM2VuPc2LxTZkS6fIrlX4E2kUI6ufYD
	 EGIKYntR7Le9M20XLK09yZCayV0pneBY7cxYK/buDPaFZthyavMkaMOBnCihhWcM6g
	 L+p6ciKfo2Wp73Sz19YcuqFunWR8EKt1pkedZDs8=
Date: Tue, 4 Nov 2025 08:52:57 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: kuba@kernel.org, martineau@kernel.org, pabeni@redhat.com,
	sashal@kernel.org, stable-commits@vger.kernel.org,
	MPTCP Linux <mptcp@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Patch "mptcp: move the whole rx path under msk socket lock
 protection" has been added to the 6.12-stable tree
Message-ID: <2025110444-rendering-exhale-0bd8@gregkh>
References: <2025110351-praising-bounce-a06b@gregkh>
 <bbe84711-95b2-4257-9f01-560b4473a3da@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe84711-95b2-4257-9f01-560b4473a3da@kernel.org>

On Mon, Nov 03, 2025 at 08:13:30PM +0100, Matthieu Baerts wrote:
> Hi Greg, Sasha,
> 
> On 03/11/2025 02:29, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     mptcp: move the whole rx path under msk socket lock protection
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      mptcp-move-the-whole-rx-path-under-msk-socket-lock-protection.patch
> > and it can be found in the queue-6.12 subdirectory.
> 
> Thank you for the backport!
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please drop this patch from the 6.12-stable tree: it causes troubles in
> the MPTCP selftests: MPTCP to TCP connections timeout when MSG_PEEK is
> used. Likely a dependence is missing, and it might be better to keep
> only the last patch, and resolve conflicts. I will check that ASAP.
> 
> In the meantime, can you then drop this patch and the ones that are
> linked to it please?
> 
> queue-6.12/mptcp-cleanup-mem-accounting.patch
> queue-6.12/mptcp-fix-msg_peek-stream-corruption.patch
> queue-6.12/mptcp-move-the-whole-rx-path-under-msk-socket-lock-protection.patch
> queue-6.12/mptcp-leverage-skb-deferral-free.patch

all now dropped, thanks.

greg k-h

