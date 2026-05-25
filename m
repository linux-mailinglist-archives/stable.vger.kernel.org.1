Return-Path: <stable+bounces-254194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zYOnIIOgFGo/PAcAu9opvQ
	(envelope-from <stable+bounces-254194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:18:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B25CDFBD
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F3D63010160
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC46B18050;
	Mon, 25 May 2026 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1Y5Sujb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FA33EF
	for <stable@vger.kernel.org>; Mon, 25 May 2026 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779736704; cv=none; b=BWjX2fS4+X2Ksp9+UPxg9KMIJ9ZBV9iZXgTlYZbFTvBIQAbPG1HOLhqDZaZCZ9ZHm5ZH0iPO2PByrHxGNgzs/KWNNjY86cfM5CCyE/axRiPLyiOS+bMCgVa8H/8XNzTYyRBcl7OedXUM2XeAiWFdxiupgDvJKRx7lbRB0R6QJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779736704; c=relaxed/simple;
	bh=2420p5tfgGevOlTjHnHHvO1QGoZA6fOT4v0uM9ZDEgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct9gZbPw/GYTrpqj6sTWPIdmGM03DJB1cG0LTEAwGPIe6+69kS0QZe04N5rZaaaJDTaX/MqQEHhHtsarzv/mki3Luoj4MhG4sCOddRsZiOjKSciM70dv2WqH9BEHGU/QAUWUn4c8mPpS8KfdivoHatj9JlQyEzh3mQC+d6Gz82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W1Y5Sujb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A54E1F000E9;
	Mon, 25 May 2026 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779736703;
	bh=LjupaKksMoAaVEF000hB/D/PygZG6i1FyBC69pRCRQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W1Y5SujbjOnEatucqeLHMzP/rM5mNpgwlERR3NS2PS/sTbpgbgTo8scbB66Pl1chX
	 UVNTT5DG2L21OKjZWSf7Q7LzgOUo/Rxh40aqNlRsf3krBr6NUkt5yKUBn0D/EhJ0bO
	 +RRK19ZIgv4z1JUtQyXw7ReVA1BO4WMIUWw00iRY=
Date: Mon, 25 May 2026 21:17:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: IM <grayhat@foxmail.com>
Cc: security <security@kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: [SECURITY] userfaultfd ioctl bypass and ksmbd FSCTL permission
 bypass
Message-ID: <2026052526-cacti-twiddle-53f3@gregkh>
References: <tencent_DEF21A96480ED4822654DC73A74623394C09@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DEF21A96480ED4822654DC73A74623394C09@qq.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254194-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.954];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 030B25CDFBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 05:23:04PM +0800, IM wrote:
> Hi,
> 
> 
> We identified two vulnerabilities in the Linux kernel during a recent
> security audit. Neither has been fixed in any released version. Details
> and patches are below.

Nice, but why send this to a public list?  Please just resend your
patches properly, to the correct maintainers and lists for the different
subsystems, so they can be applied.

thanks,

greg k-h

