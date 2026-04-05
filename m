Return-Path: <stable+bounces-233321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SfWpArsW0mktTQcAu9opvQ
	(envelope-from <stable+bounces-233321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 10:00:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D8939DBF9
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 10:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C82363003837
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 08:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A02326D65;
	Sun,  5 Apr 2026 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FL1YUGVh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E2A19995E;
	Sun,  5 Apr 2026 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775376054; cv=none; b=XmSu9pMys+AA9FBbBZg0HaqU9p4fW59p9bcn5ecFaBMu/rTgOPSznbotqujzKQpp2ZlTlY+M/lcJE3KJjAHkGv5m5JemCv/Pl4WrywIGleCQjYC4OoNLuwT9pi929fyKklENUQoAKp5d7lRkIFUt1gB+ILJrPS+L1HvzPywiLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775376054; c=relaxed/simple;
	bh=7xIAbcYM9oTMkPy0h75pkUozA7f6J1HqrYOWbi9C14c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM8SNNQzLI+IpBI+TUCNjoon7n/C4mv3rKViZ2Z4g7v4cOSDSI4IRLiNXWe8OuicC+yVfITfqWgoMEb/AjUL0zejf8flTFP9VpItFBtKMmk6Bt283rwCsuzJCMwKJwMAyoYBcjJ5N3vo+ByChqmd0Cx6GdsfPpYDEY8h+v08yBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FL1YUGVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9EEC116C6;
	Sun,  5 Apr 2026 08:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775376053;
	bh=7xIAbcYM9oTMkPy0h75pkUozA7f6J1HqrYOWbi9C14c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FL1YUGVhloqu1yrBjPSi377eSbEKoTCCZlkHu9sto9OtSisETbj4O4vvLx1KNz/Hr
	 gfU08Slro0DTkB1dJ/2otx8+qgvpqzXS52jezaWTiCNGiNhdC5xVuEOBA0K2TAQqyz
	 3hepmN3PnQY1PQ/i5gJVY+Iam8ErTlpKB0cWMkgo=
Date: Sun, 5 Apr 2026 10:00:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix size_t underflow in
 cap_get_ims_certificate()
Message-ID: <2026040508-portable-natural-47ee@gregkh>
References: <20260404232242.68423-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404232242.68423-1-delenetchior1@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233321-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97D8939DBF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 12:22:42AM +0100, Delene Tchio Romuald wrote:
> In cap_get_ims_certificate(), the certificate size is computed as:
> 
>   *size = op->response->payload_size - sizeof(*response);
> 
> Both operands are size_t (unsigned), so if a malformed Greybus module
> sends a response with payload_size smaller than sizeof(*response),
> the subtraction wraps to a very large value. The subsequent memcpy()
> then causes a heap buffer overflow.

How can you have a "malformed greybus module"?

Please fix your ai tool's threat model to be realistic :)

thanks,

greg k-h

