Return-Path: <stable+bounces-191731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C523C203B5
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACC0934EF1E
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164B30F94D;
	Thu, 30 Oct 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZlJ9h0L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB141238C1A;
	Thu, 30 Oct 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830821; cv=none; b=Q1625/SRbNHK+gk/raDbqY5IuCwvQB1+wKoqraezUnPfj/0gzWugxej9cK1US8OT+K42EsnHegnCrT5CQjgqTLsjIChoz9bKqs+YZazPpV16GoBzlEfz4xEn55OXc9PgpdZkvLkcxBTiEFzZw0Y9y2bdczPTO8PqfXjyEiO2o+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830821; c=relaxed/simple;
	bh=wuqYJBVJRiUnYGIPXIejUYot6rERgXlNuvZlxEyVQjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWVK69MqRFiYN1LmFCmps74zEc9UWBZgqN7ZuS+4BBAlp2y9a1rREpdMwtM0Q013jEiDtZ+U2YlmyuAgwjsRPZ8OZCmKtxFqMNrrNQ+lfgael+nXYkGOnP2r5wXZxzfPiLCiFEKxubuQOPxfOiNVi92dsz3gnVhYkwnaAMWAFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZlJ9h0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75789C4CEF1;
	Thu, 30 Oct 2025 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761830820;
	bh=wuqYJBVJRiUnYGIPXIejUYot6rERgXlNuvZlxEyVQjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZlJ9h0LyHK6xEv6R/ox87rJyzdYA4NjW2nnbQj5Kk4dhb3DTz/MousDYa/J1Lk8P
	 rNIe9vtBIfJM878Uy3FeVWxbIMgJ76ZxhW/0tdJwZudlPLhCGFYG3pquZqabospcJ8
	 bzwT/9e4lbYf9hsYJzpEoYAcKY3VcHP6zR/Sm2cCIWIbP1BgtcMyvEMR2nFL4mGwLo
	 6g33cwszTdJyCp+ZcepJVCYe7LoGUO60O5wsH9lQ1/WKpTZ2UdIlzr2QEsldv6FRqa
	 EiDtcMGcHnJKXKwPu4m5dvsUkrmq1mlswWYD6/WkitiuBg7ayPyNuKAzMgnc03DGcZ
	 G88Xd51uooEBQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vESgF-000000002HF-3A3C;
	Thu, 30 Oct 2025 14:27:07 +0100
Date: Thu, 30 Oct 2025 14:27:07 +0100
From: Johan Hovold <johan@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: rfcomm: fix modem control handling
Message-ID: <aQNnq02qzD3rPh2b@hovoldconsulting.com>
References: <20251023120530.5685-1-johan@kernel.org>
 <9778a6a1-ffb0-4972-a2e7-893128a51e52@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9778a6a1-ffb0-4972-a2e7-893128a51e52@molgen.mpg.de>

On Wed, Oct 29, 2025 at 09:15:28PM +0100, Paul Menzel wrote:

> Am 23.10.25 um 14:05 schrieb Johan Hovold:
> > The RFCOMM driver confuses the local and remote modem control signals,
> > which specifically means that the reported DTR and RTS state will
> > instead reflect the remote end (i.e. DSR and CTS).
> > 
> > This issue dates back to the original driver (and a follow-on update)
> > merged in 2002, which resulted in a non-standard implementation of
> > TIOCMSET that allowed controlling also the TS07.10 IC and DV signals by
> > mapping them to the RI and DCD input flags, while TIOCMGET failed to
> > return the actual state of DTR and RTS.
> > 
> > Note that the bogus control of input signals in tiocmset() is just
> > dead code as those flags will have been masked out by the tty layer
> > since 2003.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> There is a linux-history git archive [1], if somebody wants dig further. 
> But not relevant for the tag used by the stable folks.

Yeah, that's tree I use.

> Is there any way to test your change, to read DTR and RTS state?

This can be tested using the TIOCMGET and TIOCMSET (or
TIOCMBIS/TIOCMBIC) ioctls. I use a custom c application, and I'm not
aware of any particular application you can you use for testing if
that's what you were after.

Johan

