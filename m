Return-Path: <stable+bounces-241336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CFDJ51172mZBgEAu9opvQ
	(envelope-from <stable+bounces-241336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:41:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F36474933
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F4029302293A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE062D1907;
	Mon, 27 Apr 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="E/OPxEhK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203E2D9EC4
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300587; cv=none; b=O2RWBRieFK7XX5Ef1RgqDSQoAqRaaFVv/3Wgbn78Kzlkq566GjmTKIAPPBEvy1W8Lmab/Yc0OULuYwko+mLfRaH+y7LR0kRLGpmgbd8bITC1Oj8GjMCOUac+UA5Y7Sk7FV18bsyaY7bdMQ1o8vo1KCURzHxd5bwXbZz6bKDwMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300587; c=relaxed/simple;
	bh=8//6NPFnjh4H4o3zdbbVLkb5+Iunr/ti5Imm7MYh1tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emj3JXl+Xrhi8IqSmePbQDfRDSH9fCjuokrHhQPukqjnYP5+KpX/CSQcANIsJgsKpP6Zane2RydVAP+r0rYpqfwsbfvslYAS2qJy3Qus5lXGY+e0hfqsrxyZc+tp38Zg58lpQzm6RoU5psTfQYNTGOYiuVLt0BKtaB4W9AVpix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=E/OPxEhK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d6ab4476eso101929061cf.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1777300585; x=1777905385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dLnBOTCAZ7xV404FwbIR9B2+lXb6V426C0j5Ho9Zf4=;
        b=E/OPxEhKCRN9senT0etJ2+knW5VkivD/W+NcGtm0eUyAam+ERYrEw0l9MaJDFQ22gi
         PK4QBGJv6JTPjeQXA5WHQNbzVHNacozTzlLJcWXb39dmzuLGovWEmJracu0nJg8zDKP3
         AKUISGRg7vmyjlqPGk6dWd8QPz2CbEYBLMOSKvj+9P8Pi8NwdUN77jLxa+VZrx+kxU6s
         KZ3Qx2sYfptxCW3V9D6oRjFS7OgGyrnAkQE07Inr/u+Hmcy9LXOHyBk1gP/THfO3S05N
         d0dMURIBNVRFTBfxrOAHH5r/Ld3tberk1mMfPpUnzmpPjHUXqRAYEkjdZSS2JeOng4ax
         UQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777300585; x=1777905385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dLnBOTCAZ7xV404FwbIR9B2+lXb6V426C0j5Ho9Zf4=;
        b=U+CA2Ul1srZ22jyhkZA1nECLv9jKalcgUA86lIzuch1uRbfW+K0upXXHwi6M6ehgCg
         0DcK8a7yhUEWzLoVoOVJ+atlt0/QxrtrWSaoD7jPM8PNrXpMcpgsHyHZdrYxA9kDhWXG
         OCOvxVKlSDLK9dbewaAB24uw+KEDE9ngfoD3Qq7RkrV5M5nHOJ/W3WM6xNV5tJbIux4o
         Qj+g4kHUOtaaekKVohO6i95Pb2RgZdi5N1ntuv25mDl6g8E6GlYe3Grvp84CTLfNpXvk
         pfX410yHUK759GOJNYlvbWOB84BZKmrjw1xC5hQlsM4BO46nnL0f2/2fYNn9sRgWfBeP
         wFAA==
X-Forwarded-Encrypted: i=1; AFNElJ8/vI+2RjcLlptY9lvmtQjl78waerqzRnUBbEZ4kzsCuWspJqZX1ItN666NzIM9mJrZGW05irI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhsCbVEdF6abdRA327Ba493y5V334jZG9cJjC8QU/+T3iU8LY
	L3x06bDB+qJcQ3vHVxinyRQzsBYY5DjL2xuEL+WM13gS2kdcv158TlxZ9op5exX/AA==
X-Gm-Gg: AeBDievfh8UTOr4nR+rLl5GvMN80s6nsmoVG/5ph4QaCnA7m1OgJN1xHnEny25QnK/d
	UUwj11Bf/+jT1T48x9JIHzrc9KVjFabgXiqWrDyczfuc5ZvG32/rDlfBFQWOpA6wHHxPZpwUHjO
	mlpOojdI1ljaFZ/JZWoaM5nVNmVtUIGkuKs2b/pttMOXSgcS/UfLkx9imbKPoEJO2Om1Kf03b93
	yyp1YaIZCd5Saxa/Laq0mm/58CPz/GMCxItbiJ7u3CgiX3TkmMkr/VBcwd+t756id8G4OM9Rji/
	IwfVNu1f1ZmvuIWOoBTW6MqvsIBzSdTk4YJYaQI2rPXvClLGGviL1la+S9AY1oWPpI7MSL+rcoN
	2kiBs+OK4H1Oc4aDKt6Ukq8D/JwdcU0kUVnMNAy1JIbTWR4t63QTWqkyMLwjzvRV8Ssxwo5LrfT
	Oui+DRYlGfUFulq0qujK8KWflMFjINh4TlUvKR70qxOFm4jmWPiKMk
X-Received: by 2002:ac8:5ac8:0:b0:50f:b4c0:6300 with SMTP id d75a77b69052e-50fb4c0694cmr408401941cf.56.1777300585216;
        Mon, 27 Apr 2026 07:36:25 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392e4db4sm257870421cf.11.2026.04.27.07.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:36:24 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:36:19 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Chen Ni <nichen@iscas.ac.cn>,
	Evgeny Novikov <novikov@ispras.ru>, Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: net2280: Fix double free in probe error path
Message-ID: <982f5452-36be-4401-acac-c9f8ba8ff83a@rowland.harvard.edu>
References: <20260427133107.334429-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427133107.334429-1-lgs201920130244@gmail.com>
X-Rspamd-Queue-Id: E6F36474933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241336-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rowland.harvard.edu:dkim,rowland.harvard.edu:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 09:31:07PM +0800, Guangshuo Li wrote:
> usb_initialize_gadget() installs gadget_release() as the release
> callback for the embedded gadget device.  The struct net2280 instance is
> therefore released through gadget_release() when the gadget device's last
> reference is dropped.
> 
> The probe error path calls net2280_remove(), which tears down the
> partially initialized device and drops the gadget reference with
> usb_put_gadget().  Calling kfree(dev) afterwards can free the same object
> again.
> 
> Drop the explicit kfree() and let the gadget device release callback
> handle the final free. This issue was found by a static analysis tool
> I am developing.
> 
> Fixes: 2468c877da42 ("usb: gadget: net2280: fix memory leak on probe error handling paths")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> 
>  drivers/usb/gadget/udc/net2280.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
> index d02765bd49ce..90d678e6714f 100644
> --- a/drivers/usb/gadget/udc/net2280.c
> +++ b/drivers/usb/gadget/udc/net2280.c
> @@ -3792,7 +3792,6 @@ static int net2280_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  done:
>  	if (dev) {
>  		net2280_remove(pdev);
> -		kfree(dev);
>  	}
>  	return retval;
>  }

You should remove the braces in the "if" statement as they are now 
unnecessary.  Also, the Fixes: tag is wrong; it should say:

Fixes: f770fbec4165 ("USB: UDC: net2280: Fix memory leaks")

The code before that commit was okay.

Alan Stern

