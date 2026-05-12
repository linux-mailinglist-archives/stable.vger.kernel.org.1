Return-Path: <stable+bounces-245809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCaYA1VCA2pV2QEAu9opvQ
	(envelope-from <stable+bounces-245809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:08:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5955E5234EF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D35432CF2CD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24B3C2BA3;
	Tue, 12 May 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1c+R3DcU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC13C2B9C
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596692; cv=none; b=DgG86VtvOR14itcmlDhdxmaR4cgSRZu8b2Irl5TLlHaJP2MF/RsHPy+hTdyp1uQnxCzLub+URwm+Vqw1KyOX5Lqx3NuBFC1iyUzM0SJGJYjSTeiw+ILamd3ldsSK8wbyAKV42ceaVhsSi0e/GwQX1vmDk4w/KGwGYM7pqh5lZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596692; c=relaxed/simple;
	bh=aFZvQqCxbljxCBkUYBX10iv4zGOsUIAEd6s+EP6cWp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDOao+3O/e9TXd42ZHSvP7lU1SfUZcSB5KzkmwUU4+X6TYW9/d6siAmM7yFR/AbUht1Y6gTZY/Ib8geznRlkk/QIzvJtob7LttlXZ/qml9b68jNv8/hYz3sisxe7LNvSAHQMKxeiD5MIopPU2ueqwKIVf5eril8nhtB2V1dz0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1c+R3DcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8A4C2BCF5;
	Tue, 12 May 2026 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778596692;
	bh=aFZvQqCxbljxCBkUYBX10iv4zGOsUIAEd6s+EP6cWp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1c+R3DcUwsZW2oeOacqt43UgDliSvHvVpirMo8o8KU5cHOIDfvQOC6GOLw3LiwI5x
	 KXnMZmCGrdwbsbdoApQBiAZ9v7w0etwtgiXLnJKccmouQA1M6ui2xnKHbnPIb2B0Sg
	 zP2vf/Mk9a2XX0khMW6mcmPf+oxcGq9JFz62Tx6I=
Date: Tue, 12 May 2026 16:35:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: code@mgjm.de, krisman@suse.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: support min length left
 for incremental" failed to apply to 6.18-stable tree
Message-ID: <2026051202-handcuff-groove-5911@gregkh>
References: <2026051232-kindred-spooky-37ac@gregkh>
 <58a8f15e-7a5e-4b8f-9f2d-6493b685e598@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a8f15e-7a5e-4b8f-9f2d-6493b685e598@kernel.dk>
X-Rspamd-Queue-Id: 5955E5234EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245809-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 07:48:12AM -0600, Jens Axboe wrote:
> On 5/12/26 6:41 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.18-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 7deba791ad495ce1d7921683f4f7d1190fa210d1
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051232-kindred-spooky-37ac@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..
> 
> Here's one for 6.18-stable.

Both n ow applied, thanks.

greg k-h

