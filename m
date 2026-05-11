Return-Path: <stable+bounces-245194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIsKN+bPAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:47:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 514BC50E283
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C69F0306BA90
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E17394471;
	Mon, 11 May 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fnJ7ilhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04AF39E6F0;
	Mon, 11 May 2026 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503339; cv=none; b=RKZprtIZpyzSyrx1F+eMOIXAxRoq0RkMc8YA8jsVv480VU+1mwZo7Mj3dPO00LLtTDd/fnb3AURJZ93Kvv9O0GLa8hvRf1Lic0XN5BKsTQ5KROX2pFyBHom7RZlVJ1ItD2r094YYOA8IGepXNsAGX51yxd/6KPxfcyJMgqOcecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503339; c=relaxed/simple;
	bh=RFGhCYUvJZL88tchva9CVGvhbW+QURAp3QrfH2pvdGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Awp0CmGNs5YXop4qLHdZ9PHp9RxkY1goMKRAc+1wLhaZ1fsCvCjVZAHjENV//rWd8xIhBImgvDU9seUd959HaGorehRrBC7DogbeLvdgq6BlFboajRe5XaVZVkFPodE11lmBp84SsOjReFbZnbGIxflrOWDeDXSRSkF9ykdYdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fnJ7ilhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAB5C2BCF7;
	Mon, 11 May 2026 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778503339;
	bh=RFGhCYUvJZL88tchva9CVGvhbW+QURAp3QrfH2pvdGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnJ7ilhBNM/bghrndc42AZb97lnJXyIFun1NzO9w7/purYcI0CozwE+ZR2PxoyJOQ
	 iflRydUHwj5el3Age33T6uC+QD8AQEc8BOodHFLo1edQq+ab0ZRjqCrlS+ZaG3wYVV
	 Ufl6rPP+WX339MqnFHmiRFVtZS5Zza3GdKM8cs64=
Date: Mon, 11 May 2026 14:42:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	error27@gmail.com, luka.gejak@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/3] staging: rtl8723bs: fix OOB reads and heap
 overflow in IE parsing
Message-ID: <2026051126-clergyman-bright-9ffd@gregkh>
References: <2026050436-italics-clumsy-e83c@gregkh>
 <20260505173818.3674164-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505173818.3674164-1-hossu.alexandru@gmail.com>
X-Rspamd-Queue-Id: 514BC50E283
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245194-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 07:38:15PM +0200, Alexandru Hossu wrote:
> v4, addressing the sashiko review comments on v3.

There are still loads of new sashiko review comments on this series:
	https://sashiko.dev/#/patchset/20260505173818.3674164-1-hossu.alexandru@gmail.com

> Regarding hardware: I do not have rtl8723bs hardware available.  The
> patches in this series are derived from static analysis of the code,
> cross-checking against the 802.11 spec, and reviewing the patterns
> already in use elsewhere in the same driver.

I'll have to defer to the bot here, let's get it to agree that you are
making the needed changes, as you can't test the code.

thanks,

greg k-h

