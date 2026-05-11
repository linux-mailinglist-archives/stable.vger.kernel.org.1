Return-Path: <stable+bounces-245177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPG9F7mrAWqdhwEAu9opvQ
	(envelope-from <stable+bounces-245177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:13:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D3A50BAB6
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF1EB307C2AB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674823C2761;
	Mon, 11 May 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/6Il5pn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D02236FD
	for <stable@vger.kernel.org>; Mon, 11 May 2026 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494174; cv=none; b=tku2ZOKsjS+c/9m7vBB+9qTYvqjLpwWXHtSwouMb/uY7HSs04IzypplXXA12Dl785uuscDp0kCJJAiVg3VhcDxdeLTvgB8z9+ibyhjGbshx/BQwPBzqtgWTOf+PdPn1B71Hk+aX2MJ5z/MIm37Eg3EF9liSI0pJ/fCBB9pqZXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494174; c=relaxed/simple;
	bh=zQhoOizndaIcnuVjyYY3FFDLyRgLzanPIVukGi6IcYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BanqybmCyk3VCAD2py6BkPfmg3TFtaQ+1gFaJ2xuzXhZtNAKPxca+jDVEUhSbWbG8tm0P+uUgulh1AH8zvbTBS0XMQiA+L+MT8frRpZBmoY3l6qY+lzhus/fv1SVG7V13w3yLcndpprhcq9yCCOnoMzzgKC7ZjIsAh2gnCyim5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/6Il5pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B10CC2BCB0;
	Mon, 11 May 2026 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778494173;
	bh=zQhoOizndaIcnuVjyYY3FFDLyRgLzanPIVukGi6IcYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/6Il5pnT79BkxuSDoQmfDQ+37GleFvW6NP+zW/GGujfXbfrHx67c3J6OmgWbzUV0
	 uIvrjcFupUchvOwmZHzP45vQ/wZdgcusBcktg5keRY6x1kXnqmFo/mzKGLhUZgPOfx
	 kLeMrAUSIbtoZP5+BbiGa3BGkicotG4YUuPt0N3A=
Date: Mon, 11 May 2026 12:09:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Nagamani PV <nagamani@linux.ibm.com>, aswin@linux.ibm.com,
	sidraya@linux.ibm.com, hidayath@linux.ibm.com, pasic@linux.ibm.com,
	mjambigi@linux.ibm.com, dk@linux.ibm.com, twinkler@linux.ibm.com,
	jaka@linux.ibm.com, wenjia@linux.ibm.com, gbayer@linux.ibm.com,
	linux390-list@tuxmaker.boeblingen.de.ibm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next V2] net/iucv: fix UAF in afiucv_netdev_event()
Message-ID: <2026051159-juicy-freehand-c715@gregkh>
References: <20260508170534.2208812-1-nagamani@linux.ibm.com>
 <db4a5413-4844-4336-aa6c-5e7a29bb16ea@linux.ibm.com>
 <9c08d526-e909-4c17-be0b-7fe99f43a007@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c08d526-e909-4c17-be0b-7fe99f43a007@linux.ibm.com>
X-Rspamd-Queue-Id: D7D3A50BAB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245177-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:14:41AM +0200, Alexandra Winter wrote:
> stable@vger.kernel.org: Please ignore this is still in internal review!!
> 
> IBMers: be careful when replying to this mail, Thunderbird automatically added stable@vger.kernel.org
> because of the Cc: tag !!
> We should not add this tag, while patches are still in internal review.

then perhaps use stable@kernel.org instead as the documentation states
you can use for "internal" stuff?

Please consider this issue now public.

thanks,

greg k-h

