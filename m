Return-Path: <stable+bounces-227690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE0DA8M4vmlGJwMAu9opvQ
	(envelope-from <stable+bounces-227690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:20:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9372E39B4
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 127F4304D262
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F178C370D59;
	Sat, 21 Mar 2026 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oTEc9xC6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063336DA0C
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073953; cv=none; b=HUcOwCgCVhz4guXec8cCB7BukALCCF3CPycUzOu1whDTuZi7d5nCAVFEwnBppkanEMVmIx/+Df4rOGiZlfGaCoB6YRIHWdwzxRhxF55YcjZyW5341RRhjSXmj0n2KEgefzzMBG5/lUREGPdCnvTSSKDOQoOLhWeA6Gua6CeWxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073953; c=relaxed/simple;
	bh=X71ADP0/DusaTMDtog/eJbWmX8FOQ7pzH3Y1fE638is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIJuq7IrBoReAMck8quyGEwz9xUxNOBStMXDH8Vqiv5OOpTMqIsCJYK2vvDT15TcwF73tYXwGKJm+k4VeDY9Iwee9lz0BAv56utFeE3BX8JSerdWZZlHrNBiji2TWbOlzVOkz1YQtRloFvBA4BYZhYHUxrvAMOsOBHx1ls24AyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oTEc9xC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFFCC4AF09;
	Sat, 21 Mar 2026 06:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774073953;
	bh=X71ADP0/DusaTMDtog/eJbWmX8FOQ7pzH3Y1fE638is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTEc9xC6lTWejIdcrnhI1dk+Rq3vJ0glOW3lr1FA5K48xLoQs0MBYEcPFmQxhGfKc
	 5Bx2ofQ7Mv3XyFmNLJcWjaHS+NiAZEEJm+iCEVdDqIxG3Db8+Wg4jp0iSv2GDnZ+74
	 ad/WsNuOJP7l1qzcS15PZEsZLbjDpMCMFipKe0a0=
Date: Sat, 21 Mar 2026 07:11:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: francis@malagauche.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: fix multishot recv missing
 EOF on wakeup race" failed to apply to 6.1-stable tree
Message-ID: <2026032137-unstuffed-opium-cfa6@gregkh>
References: <2026032057-septic-boogeyman-daef@gregkh>
 <376a35ee-6a9d-47ef-b4f2-d1e6af5f830d@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376a35ee-6a9d-47ef-b4f2-d1e6af5f830d@kernel.dk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227690-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF9372E39B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:10:43PM -0600, Jens Axboe wrote:
> On 3/20/26 11:33 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Since this only triggers after the AF_UNIX inq addition in 6.17,
> we can drop it for 6.1/6/12. I should've done a better job with
> the Fixes tag.

Not a problem, thanks for letting us know for this, and the other FAILED
patch.

greg k-h

