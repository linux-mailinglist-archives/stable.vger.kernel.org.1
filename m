Return-Path: <stable+bounces-236042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP+VCI3k3GkZYAkAu9opvQ
	(envelope-from <stable+bounces-236042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:41:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B833EC17A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8D3730641DE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66833B8D6C;
	Mon, 13 Apr 2026 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfIQKpiA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0B3C344F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083821; cv=none; b=IL1CnJms6XKQoYYuI1B1j3OC9Z829lTUmYut7WwA9XIeHPxL7T2YjBMZEdpshlT7Du0lL8Cc4tX6tPjHTNNulfCbxK07Z0DW1DK4OS6Rxk07Aj/HBYcTZmrsnq2w+5HNaC8LOUZWrBqdiMdCZJZyrdie6x1cJSTTfyTmhtRaQ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083821; c=relaxed/simple;
	bh=mgeEoe6AtB49kywapoFP3GPBJeS2SOQhv89gRBsFD7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prd0ae8z7XSPrY2NsNHbr5l8pBCvGLDavKgGTgdVFap0sgvDfR2k6WparDomHrh8Wu/B7LpGnEFnr05dx11t5JUVhBtdcrB9PJ+wK27CdOnilUcdpwY+MOoJwSTygVPzr7T5sosV1q9nU8KoL7XzEymQpYB062LPhbyuYeUmR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfIQKpiA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so2806424f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083818; x=1776688618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+X/xGhJvuBPL4tYv8hEPxNZ5/GB2yObANZwMOQLBRg=;
        b=YfIQKpiAMYRpoekTXJOt6MGKYr2YUr8BP5kqJjhds1DM6/xAmWvcjj5kp4K/2X3pDM
         tBNy3nmdrjjf+Edt6IajkCEJONqaNA1fqfiLDugk57fRC9gxE+8zdqaW6KUzt9xAwESx
         bLH6kMTWKbDsQbT6+pY1HX64AEPzgKWolRfP9pZ0JyLCtlhZk7qzA72l3+RZLn0bpTc9
         yjGq3rqOyEPuEz2ewd+CoimMXjLGn5T/jFEQstwIePKLrYVDhLkX6C7/kXlGqyR8IzQb
         dh6Xy9qjFWqEzSiMjDOZ6tzh5Be3Z63+SoI0DiGiJNQMcC8ey7/Yh07sA9fRxuMjvwYK
         JrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083818; x=1776688618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+X/xGhJvuBPL4tYv8hEPxNZ5/GB2yObANZwMOQLBRg=;
        b=Dw1NopIwQAJA44CU9P0rxWOmAWwZRDWPW0cKk/wHRqhPFtGbwLgtXl9NUsK1WzpGiK
         SB/ObGCIQDtz3on4HDJBSwvPDLH+uKOL+d0gS3rEfqphw71VvdtYtCXOwHZU+aspWPkI
         /VjYw8zA4Qi65HocYfaatTiofgDNy63rwYRIJqlrJKIYwwGvqQE07VnDjjm+GkiFLcEM
         KC5NKtHOzrvyMDNYI/fo7BlxQwMMjnYKyRrCsCARgtph+oPRPuKwznOJN1HPdEHFf1Yu
         AxyNIJ07N+PdFvAZDuaxepAV3a2eM/pGMNdBM0OlTAHAFR9qA5tnKyVgsOc8MqmFITOG
         mV6A==
X-Forwarded-Encrypted: i=1; AFNElJ9yL62Chr5vKvkVmpsWdM+3FC0VT7ISq9z7hZAB20CGCxt48AgfraDhW86zqaUxarqb4II7uqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+QnoNXTyxxLZkBePENP1xg82JFXlp1DAbAfGsmEMECjGXpFJ
	UAF5jWMRinIJQr7vb3eQn/XVfAa0akYT6jK1kwblTLjaNOfx1SZfvGaX
X-Gm-Gg: AeBDietV93jdxbp77vGfFW0HgjDOoVkUeX4lHSP9p1t0s+ltuDQRkQk0OQpRBDHPtEU
	3Rl5es/NHkt8HzhBhTjBJoSy6RVKR6lYOtBf/5wbS68vYGKEBZi3veIkzTvM6mSnksg+ldxLY7l
	2pgFpg7mkPcL20PfAI0tV0EJhKHfZbameXQUBk9Gt9wy73LkwQwiLHSalC067I1D15+pNrUFLJr
	VXyv0sj8XfkR+HZX3QXxRV/uEExu7ig3go84hcZ0rO4izfrAGy/oi8bUMZE7RGe/nt83yLrDjIM
	8+FQAlu6GrGa7DA0I1coGT1lK9dph1/p4FxUzl+8h48SYzbWSqxB9Fu5JI8goGpVAGAvQCZdsdD
	9iKLHjcz6Q+MBrzBqCmnA9ejIVnkqrfeHqfVpBksjIzJI10F6dNPIw1cTTE0nx/1b9iuXNmUZt5
	DjXPZubRhMxi+jDFD0fns=
X-Received: by 2002:a5d:64e6:0:b0:43d:7887:9f36 with SMTP id ffacd0b85a97d-43d7887a15fmr5464550f8f.2.1776083818336;
        Mon, 13 Apr 2026 05:36:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6a1203b8sm28098391f8f.16.2026.04.13.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:36:57 -0700 (PDT)
Date: Mon, 13 Apr 2026 15:36:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: Fix refcount leak in
 viio_trigger_alloc() error path
Message-ID: <adzjZvCm0enRw5cW@stanley.mountain>
References: <20260413115656.2789049-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413115656.2789049-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236042-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3B833EC17A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 07:56:56PM +0800, Guangshuo Li wrote:
> After device_initialize(), the lifetime of the embedded struct device
> is expected to be managed through the device core reference counting.
> 
> In viio_trigger_alloc(), if irq_alloc_descs() or kvasprintf() fails,
> the error path frees trig directly with kfree() rather than releasing
> the device reference with put_device(). This bypasses the normal device
> lifetime rules and may leave the reference count of the embedded struct
> device unbalanced, resulting in a refcount leak and potentially leading
> to a use-after-free.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fix this by using put_device(&trig->dev) in the failure path and let
> iio_trig_release() handle the final cleanup. Also update the subirq_base
> check in iio_trig_release() to test for >= 0, so that a negative error
> code from irq_alloc_descs() is not treated as a valid IRQ descriptor
> base during cleanup.
> 
> Fixes: 2c99f1a09da3 ("iio: trigger: clean up viio_trigger_alloc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - note that the issue was identified by my static analysis tool
>   - and confirmed by manual review

No, the issue is that you are working against old code.  This bug
was already fixed a different way upstream.

regards,
dan carpenter


