Return-Path: <stable+bounces-17786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F6D847E2B
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 02:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C461F29CCE
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 01:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8A1369;
	Sat,  3 Feb 2024 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qbfL61y5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122F4411
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706923820; cv=none; b=eHL2WfMDWDI2kqNcbZI0EN3D5XJIPOsghqAdaAmqFuETxtx/4yfDb2YhUJ6EDVz45EOP2Er8Jf1fPg4bX815JJ27MVXq1h+VNJ9DlXuxwNvU8/FXgJ7IKBUWCkBhMHefTss62UoqLS7ubnTTEXQMWePYZiv8hsS9RTQ8yIpMk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706923820; c=relaxed/simple;
	bh=ThmDMPyoPNfOW7fgjmzJaHqYwyjrIALgA6Y80a7+bDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnDbvXxU7JFe3B8bllccvIVdrEaBVA35kGHC2LyA779o/0NHFj3eiPrf6gbwD6THLdQxv+4tWRRinutdMORtCUcIxt3GvdR8lT4umR3WeT2qwThdyDpsgqbRRPU9ynysmwxJeYQK3tKBwOoMOV0Lkt5ZBS/17MbtfCC2QyWhDKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qbfL61y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33489C433F1;
	Sat,  3 Feb 2024 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706923820;
	bh=ThmDMPyoPNfOW7fgjmzJaHqYwyjrIALgA6Y80a7+bDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbfL61y5ySlglYHW4GV9px9X9m71rnNn7o/egsyMz6s37cgvghcsV2p8RchgedWbR
	 NRe/YS7NOP5oHvFukMd+KWUVqEqGqv/EsjgU7rxUuPx7mg899jKdfVsA6m23r3xzMM
	 U4Avp2MbPvNmw1mrsWSrjjk/KG6vO1Vvug3+Sj+s=
Date: Fri, 2 Feb 2024 17:30:19 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: stable@vger.kernel.org, Bailey Forrest <bcf@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Kevin DeCabooter <decabooter@google.com>
Subject: Re: [PATCH 5.15 6.1] gve: Fix use-after-free vulnerability
Message-ID: <2024020210-navigate-oaf-b2be@gregkh>
References: <20240130214507.3391252-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130214507.3391252-1-pkaligineedi@google.com>

On Tue, Jan 30, 2024 at 01:45:07PM -0800, Praveen Kaligineedi wrote:
> From: Bailey Forrest <bcf@google.com>
> 
> Call skb_shinfo() after gve_prep_tso() on DQO TX path.
> gve_prep_tso() calls skb_cow_head(), which may reallocate
> shinfo causing a use after free.
> 
> This bug was unintentionally fixed by 'a6fb8d5a8b69
> ("gve: Tx path for DQO-QPL")' while adding DQO-QPL format
> support in 6.6. That patch is not appropriate for stable releases.
> 
> Fixes: a57e5de476be ("gve: DQO: Add TX path")
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Bailey Forrest <bcf@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jeroen de Borst <jeroendb@google.com>
> Reviewed-by: Kevin DeCabooter <decabooter@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h

