Return-Path: <stable+bounces-218043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABLHCOlMnmkfUgQAu9opvQ
	(envelope-from <stable+bounces-218043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:14:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A9018E91C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4EF7303FAED
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E023E35F;
	Wed, 25 Feb 2026 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VBboYMWM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2BE1DB95E;
	Wed, 25 Feb 2026 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982052; cv=none; b=tMiELVdDtzJNznS9AcciqYLdRZ465J5HZaoTtN+osX5UY9WyRi2c8tbjEDyIBkbnFDXyLoCoZNqZKddJf2GxNFzVXyEeL43+ah9Ik8r5H7Qd9ND0IEnr3bGAlSTn5Tnwls38ut++YPQ1R2huZC3hqFPXLTNIRyhX+2Ys+Bi6+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982052; c=relaxed/simple;
	bh=yZcJQ3bdWRi58oPxdmGvsDv2iXPtfZhU1w6KHSLYYSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW/2/SSJIRmmMQJwJhiNL9P1i3dBEDPWsyEMo1CW9CkDrrls0Uz1eqoPRNvwum6l05pTIlD/Bh8x6pPdqC7bnMdx9DfbMxiXr+wZ34bBkLim7yfOQvyCcxPiPq8sPztyurjj+700GcNs/+PDoa5yKCsXMjX3mw8AxUUFhJiqPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VBboYMWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2E4C116D0;
	Wed, 25 Feb 2026 01:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982052;
	bh=yZcJQ3bdWRi58oPxdmGvsDv2iXPtfZhU1w6KHSLYYSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VBboYMWMoYR9PSDW3zGz95pERFrkobRNpRvkz0NpNuKe7O7s2n+mtsqog/3GVQvSO
	 OcKhHTU754z1yOM5pJNeXz2p5Ac1kKNZYOCVMHbwrH/ltQibE4JloOPCK2FjynwcDx
	 MJ+w3fL/pl9jKh65spEUvxP+HVEiZr3ZCRbJNBuU=
Date: Tue, 24 Feb 2026 17:14:05 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: Patch "clk: Respect CLK_OPS_PARENT_ENABLE during recalc" has
 been added to the 6.19-stable tree
Message-ID: <2026022455-kissable-anybody-e386@gregkh>
References: <20260221160309.4048102-1-sashal@kernel.org>
 <2819833.mvXUDI8C0e@workhorse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2819833.mvXUDI8C0e@workhorse>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218043-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 75A9018E91C
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:13:48PM +0100, Nicolas Frattaroli wrote:
> On Saturday, 21 February 2026 17:03:09 Central European Standard Time Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     clk: Respect CLK_OPS_PARENT_ENABLE during recalc
> > 
> > to the 6.19-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      clk-respect-clk_ops_parent_enable-during-recalc.patch
> > and it can be found in the queue-6.19 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Drop this, it introduces a regression and has been reverted in [1]
> 
> Link: https://lore.kernel.org/lkml/20260203002439.1223213-1-sboyd@kernel.org/ [1]

Now dropped, thanks.

greg kh

