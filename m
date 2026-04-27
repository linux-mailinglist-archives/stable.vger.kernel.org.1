Return-Path: <stable+bounces-241413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIYCNfeW72mLDAEAu9opvQ
	(envelope-from <stable+bounces-241413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:03:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4BF476CD0
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D6B6305272D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316873DBD5F;
	Mon, 27 Apr 2026 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="AxA1O8gz"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86823112AB
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309272; cv=none; b=O8gTqNgbepk42xQOrqROasiHCz57qHl/b5zxIMJdZCzqgsrMSd0LgiNjs4Std0SpdQZtAhLnHqJyC5eLzSkNTXlJn6f92WBFYAg0wLwkqucoBlBfn5JY5ZIPaVWlYaEirLbM7rXdw5Jl9bXu1uhpUzPaNTpjwSbZiwcpNf4hTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309272; c=relaxed/simple;
	bh=pacyqXrJb+QD6vWxFL2HI6p/62pewGR8xTCIDlVEmKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmCTubm70Ye8gLM4ZEfE57lBnQ9c354srN7+jWkPocItp81CoBOZthA0mCUpg2TeDHiZrLJDDLS+9hAYVL1u5eMzQ27/4JY5uzZMikJ+nhXtg0lFg75DLo7ocIbVEpsSDe3f3RtDiWpIcnVqFPacBDUA0aa+Yu06OZCrrW2W0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=AxA1O8gz; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-61316792e42so5932895137.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1777309269; x=1777914069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdmGrxzHwwSFvziMDFmAGnpnOEmYArtlK4bqqD+AiPk=;
        b=AxA1O8gzEUmOaCFzjhTqhuJt3o5F0DWexLor9n3fCHyjDnuEcsu8okf2AaYUAPXFKU
         XQHg0CJxNWnA2i1DRhAjVfVVYjlgObM6YssYXPRcB80TFlS+x5GeXxIsePyOjbEl5+nK
         ZvWDPxoGjlOSrBQccEdPouXTYbcR0/8I0l7IfJNaaehceQP3/s0xYtPYZ5+nCe4RXxy6
         mIDrbmkGrHHmnIhkZqkCu0GuQ3oYOg8n2S/Zr/ZhRPUFlRKxQgocDpS99FuH9iZlMeLo
         Pmoa7DDHCCTbyah2il1h6JeH07W+RLqwXLlll7NvjFZppAzSyqEAxDZWjSfY941pWaKU
         paYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309269; x=1777914069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdmGrxzHwwSFvziMDFmAGnpnOEmYArtlK4bqqD+AiPk=;
        b=lN0NdXoPivcOvuBFr6gDfycsYmCSzGte21LvZB/emVfNnQqyTtTswwVrezFfAxsPt3
         uyY7KmHHnxFf8LBsjLVWtqLvjJQSkr8kLPeh3QF8vAUadm+IEE/sA0/jZcKq3z96Wbdy
         fSlOyuWol5LBzsXFBXL7G0dWMa3HpipQs44lsRSu+nqfH4yHBK9r6hRBQm2y1f6yZR/V
         tG7NocwAfI4AsQWtcWbjHHCO6gbyKhHeHUdavT1Hpttuod/sCth20uGg76M18Aye812E
         8GslZf/2ssaRWLHt80/+NAkaXZgsbtdqMDO8fi1tDt02qPenpLFLtz2jqougxnLhliG5
         AR9g==
X-Forwarded-Encrypted: i=1; AFNElJ/E0rmyYH5pXjpaDqysxTQx43nXN+mhg0+9jOlG0kcaQDTkB1zJnFBcw4wogPNRK6VJeH7BEds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWrNy8jeqwhll+lSDwF3lYGQ6WfiBfWxbahrl7DSOXzXcguph
	y60uT6WuRoXiOnqGdNJuuvPM1Yjp1urfQX78nWxs9CwT+wx8vKJ2g/G8q9A6/XVXHw==
X-Gm-Gg: AeBDieshqmoKJ5SKw8q+N+ShtX48wFlQZJoQZr8WV3+h0g+eFQyBa6SL3nQ7ds5dfYC
	+xzaYdMp3TUIbzT9D1Rb4IZKCDYnZq5JdUtwNVJX1Es64o1ItQkQdi54ZEpG0aGHWgZwXM94kt0
	2pzxPUlnrO+JlbvKEvHwRywp2rD3H2Jb9Q40wa7QzIFePthdqMAPBoq7ASsll1bMvamBlJ9zqLW
	KOiWwRANvlU/3aA6zRK1HxEoyrWZaI0ZmLx5amGziHVYpINbL3RJA8LGW/XsOlh525TQDoAVTzI
	6wJt0TTeK2UlMw/x4CsQLLsXOl2NylTniR+0tBGD0kUVdEle45yby0dK/QRGkWceJxFHI4oA3jq
	eF+woy9Q+iZXea4Dh6TlEQvnf/oDT6U57P9urt6WFrVwEIKr6FMDgGqPeE1dRGAs1fk9VyNBWfa
	FVngNwCgKE0qgaMYL8MnR6Nru9o2uyg78tWljJo3uZuU1ZKAyGbcC2piyO2eDK7rCl9ZnUd9hFb
	PoE6A==
X-Received: by 2002:a05:6102:dcd:b0:610:6e69:5235 with SMTP id ada2fe7eead31-627d55c69efmr111775137.22.1777309260365;
        Mon, 27 Apr 2026 10:01:00 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d9abce59sm3155409985a.46.2026.04.27.10.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:00:59 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:00:57 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Chen Ni <nichen@iscas.ac.cn>,
	Felipe Balbi <balbi@kernel.org>, Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: net2280: Fix double free in probe error
 path
Message-ID: <8d5e84a2-326d-4586-8802-553503f940da@rowland.harvard.edu>
References: <20260427153651.337846-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427153651.337846-1-lgs201920130244@gmail.com>
X-Rspamd-Queue-Id: 4A4BF476CD0
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
	TAGGED_FROM(0.00)[bounces-241413-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,harvard.edu:email,rowland.harvard.edu:dkim,rowland.harvard.edu:mid]

On Mon, Apr 27, 2026 at 11:36:51PM +0800, Guangshuo Li wrote:
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
> handle the final free.  This issue was found by a static analysis tool
> I am developing.
> 
> Fixes: f770fbec4165 ("USB: UDC: net2280: Fix memory leaks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> v2:
>   - Remove the unnecessary braces around the single-statement if block.
>   - Correct the Fixes tag to f770fbec4165.
> 
>  drivers/usb/gadget/udc/net2280.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
> index d02765bd49ce..7c5f30cfd24d 100644
> --- a/drivers/usb/gadget/udc/net2280.c
> +++ b/drivers/usb/gadget/udc/net2280.c
> @@ -3790,10 +3790,8 @@ static int net2280_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return 0;
>  
>  done:
> -	if (dev) {
> +	if (dev)
>  		net2280_remove(pdev);
> -		kfree(dev);
> -	}
>  	return retval;
>  }
>  
> -- 
> 2.43.0
> 

