Return-Path: <stable+bounces-240409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EVO1Elam6WmzgQIAu9opvQ
	(envelope-from <stable+bounces-240409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:55:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6644D197
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF74301410D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 04:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10970244687;
	Thu, 23 Apr 2026 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHnBtarR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B55611E
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920118; cv=none; b=MAZGuSUxaLYWmSkAnmuxBkgvYgbz22PoMGnCfvgxcK2kqTB8Xa1YGt/ubjJoS3dEvl4ypftVEWbebrk6alFAXoveyxneS2VO+Dcu6DN9j/4rnrVGRHwbagkJehG8fELzRBfzQfGSypHIcCYz7j8H6hLvRT7IzAR3ZiRSeBPLtCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920118; c=relaxed/simple;
	bh=hRT8ZYcRyFjaFI/y9ahOaT0sVTHYZkkVF++4Yq6plRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7o7ILi4pqJDpEFn6SyfcEbCgf0kWxI8XOvUzp1xC18IOjyZw57XxBNLKmOJB8FXvh5FENaU8V4zfm4jkkzaIf5BbVmqnBz/73SpiXlXeAYSyRa1XJru/KKlka+werhwNcK+S/bQdI+mLsr4tKCsuVDIYhrml7a8J7CXZBZ0x0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHnBtarR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199CDC2BCB2;
	Thu, 23 Apr 2026 04:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776920118;
	bh=hRT8ZYcRyFjaFI/y9ahOaT0sVTHYZkkVF++4Yq6plRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHnBtarRmFlr21e/jAIGfNgV8m7CnmdyBhTnbXMyvsTJarDXaCr/PDzm7oWk/UMxe
	 wiUIXG7T4I/SFiMrccKopFw99CXpyQA09//y92fiN27QjqOiNX57N+Ceh1XKfL3xzL
	 FEEDcjQANZlVLZkSragNFQ8+Izs4InrVimT09Xsw=
Date: Thu, 23 Apr 2026 06:55:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Josh Law <joshlaw48@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Backport request
Message-ID: <2026042325-backhand-vanish-f69d@gregkh>
References: <C9577A36-B531-4480-BEA5-42F660C184CA@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9577A36-B531-4480-BEA5-42F660C184CA@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-240409-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFA6644D197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 06:04:50PM +0100, Josh Law wrote:
> Hello, I would like backports for 
> 
> Mainline hashes:
> 
> https://github.com/torvalds/linux/commit/8cdf30813ea8ce881cecc08664144416dbdb3e16
> 
> https://github.com/torvalds/linux/commit/9003ec6f7f394943880618737d797a9f257e6e1e

None of those have showed up in an actual release yet, so why should
they be included "early"?

thanks,

gregk -h

