Return-Path: <stable+bounces-238404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wei6OrnF4Wk5yAAAu9opvQ
	(envelope-from <stable+bounces-238404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:31:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F084171C5
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A637D3053779
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD1032BF5C;
	Fri, 17 Apr 2026 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHYgLsuC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6641E1DE5
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403888; cv=none; b=cRzUd5shz1f9CsIh9oxoQcJm4e9C0btGocWB90wOuSyBNM+pL2cebIhSsSBoKKNoGfJe8WdqoZWJKlO/jnQRm8o2pANyMbNAjJALcCZNdAAwlpdanDD4qr9UooWAzVbxjU2VnTCX74MFICZhk81TwN9Ag4skuUNdMbzozBUaGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403888; c=relaxed/simple;
	bh=VBthgw/rXhzMzxt0DW8aGzOx9zKnhpte4eoRC/Xt5BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9v/H9e8INpmYzdUZFdHYIjtp7KMQXS7ytw+v2EPnH6SCt1OfD9+ldDd2zGr3KEGlyffF0/7mvgYJ7KMqAC20MeVFBcVGbrni+lVV8P8yraD4PU/LOP3meE4XRJAgON4W6IkT7FjwTYswtVDmT3FjtM12b+i5cDI8TpeqMdA8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHYgLsuC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so1856275e9.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 22:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776403885; x=1777008685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8zdt2mI8kuppL/SwhLD4Wp0h0xn8IbXpXHR5LOgv/0=;
        b=iHYgLsuC9hrkFgg1IZ+Pakrguh2JIM5KGr1H5N4qPEH0xVReiW3HubghqTjsWP0Fzf
         B/BXQI/MmKk/vSh7JzgwVkfJZSGky7mm3Ihf4nd6PQzCoX4bOKY9JiJloJIQDTbCC+gC
         Y5H80x1tsVgtPY6Muz4cePcMv0ghkKW7c0npgOLTl4msVCDLPrhadN3/H5kqeQDRmhB3
         ci7aB4I7do/FGLNqoXq9ZOl8QdX93t6x4/Lm1360xzWQL9xGfIAGX/LPGQStHjdJ+/Fw
         R+ycLU+uQu/b56PG2mH03ttVzefZrE9hayBwE6pd7fd3PVgqC1t4exqfuMN5yla5OUa7
         27Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776403885; x=1777008685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8zdt2mI8kuppL/SwhLD4Wp0h0xn8IbXpXHR5LOgv/0=;
        b=q8nn+YpKiJeIek2i4FaQjlxNGSVQE0FPl4aFtVnCwqtpJPJPiTL0L2IAu6xslJ0y+w
         zTS2o6a0MjdoMzdFnKdyAu/F4hip7hMs/SK+BOjpfONO5ax2Fdwh0uACKyZ26ZbieWeC
         o//fMzlQs5ZIjEgtnq21KCmbioRNKO53IQKtRJJi6E3TSHy+JL974IClwCoaWVL+W7Jt
         IUXKWRBAHM8fDmzfIuKkyIWlQuLeQfW5vUXMgIUVoB+dBalspbWabxFS2xuUr28oAHe7
         fbaVMqdU0mdZjJKXCXyzi7K97Ih8nmFokC/bCfdL83uN8xkyWflnAYtFYn9JJH24qMtt
         W7nQ==
X-Forwarded-Encrypted: i=1; AFNElJ/i3AXzv5wla35zfM6BvpQ1otpSaqFQHw5evX8/YWMJybvmA8EJP65qN0ahyveBSz0Nb3icQ0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPSsAKx9KztfngT5VnVA8jFBwiiCT80BdtYsgHrvzC+XUPtMh
	m3t+x4naysT0ycIORZ1+kzTE4qhVrRMR1MzgU6XWE6kS37bIPEf1HYIi
X-Gm-Gg: AeBDietOq9NLkGzEOnKW7tMkBkVmN8ilPt4wUc3Fm4zChvmxDEK7xjRow8+uNuNSlI6
	zJ/s2NWUAJ4IHQ2UqA8QhQMmEDe/SaGvUVNvVPD9/38Fdv8Vjf/8BKKuEk9OC9ucYmXHzhOqaUV
	mRrIrxbxXckZHoFiHxzZQkQpY+VOKNuigpJe7ZdZHe85ADkOHUMEOVmvXFlPeSQjjajRdC3mHzw
	yEP9xc988+LG2Qo6Jn7gueqBDqafDQOQzY81FHxJ6w7YNevKgKThL+PaPPNzOTRKHuRw+9er6en
	Ola5H8+xLgKskndDWdaimFPA3UO55Fh3miFjwboZGT+dzYhh/eVxZ975FZL9IbwmoxFHxBtdJl+
	Xsv89E0HXbGaKU2R5y286+aMfFukSnXtKlzq9l7H8xs+ZuVZkVvMpQXrogA0lAQsurYWxYRsPjS
	0jQbmxI+r9WLmi4ohWtgwMWRMpKqvqLyG600mShuo8
X-Received: by 2002:a05:600c:4749:b0:488:c6e9:1e0c with SMTP id 5b1f17b1804b1-488fb889385mr13785665e9.5.1776403885540;
        Thu, 16 Apr 2026 22:31:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm1499375f8f.31.2026.04.16.22.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 22:31:24 -0700 (PDT)
Date: Fri, 17 Apr 2026 08:31:21 +0300
From: Dan Carpenter <error27@gmail.com>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: gregkh@linuxfoundation.org, luka.gejak@linux.dev, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 1/5] staging: rtl8723bs: fix heap buffer overflow in
 recvframe_defrag()
Message-ID: <aeHFqf65VfuzkXiE@stanley.mountain>
References: <20260417030110.42991-1-delenetchior1@gmail.com>
 <20260417030110.42991-2-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417030110.42991-2-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238404-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: 50F084171C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 04:01:06AM +0100, Delene Tchio Romuald wrote:
> +		/* Verify the receiving buffer has enough space for the fragment */
> +		if (pnfhdr->len > pfhdr->rx_end - pfhdr->rx_tail)
> +			goto out_err;
>  
> -		/* memcpy */

I wasn't going to mention this, but since you're going to need to
resend anyway...  Yes, this comment is useless but don't delete it
as part of a security fix.  It's unrelated.

regards,
dan carpenter

>  		memcpy(pfhdr->rx_tail, pnfhdr->rx_data, pnfhdr->len);
>  
>  		recvframe_put(prframe, pnfhdr->len);


