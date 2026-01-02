Return-Path: <stable+bounces-204465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C15CEE768
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 13:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CECB63019BD5
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3FF30EF92;
	Fri,  2 Jan 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="aWse4Gb6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C62F0C62
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355819; cv=none; b=nOxmhV519mtyKpc4zDNLRrHXaCAAddNVOIzmCgw4C2urM+Vi4efO/eobyCB18m6cLiMLgkWEk+5SuHhAi9WNhX+bKlga0US1mz9ILgI5ydJFz4b5k4CN9xUVAmGHUfvgdEtmJ8Fv8V72fDFvn14yVud4q73hKTK4QcuBcMOml/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355819; c=relaxed/simple;
	bh=D3hz3RlW/hBNIlTvBIru3FX1ozhyNkbv1Ma+Wj+so4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsmH3WjOkplfywXwiUrwDlMphmwpjSJyeaI73OynEpyiniIOUykXhnWLebjrZtG4TGNtV9ew+dki9QjiZpV9LOPbyXP8U4suuiNEVl8bRZ1hQaE5/3foUKRpPLkwQJZIXhOLzN8wawZ8JEHgyq6AIQbFdUFNA/bbiJBJ/IfG1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=aWse4Gb6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso16504193a12.2
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 04:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767355816; x=1767960616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hyAExea92lRqN3+lMIDtFuHcTalaR06svoPNW5R6G2A=;
        b=aWse4Gb6yUVDw1uaPq638k1G8c9WxMtcmi7eBIHQHCyjhM/XOq2LMG9IL+VRjFl+ae
         4i0Pu35cf3599DnqB1xlUUA14fr7I+vyIfgUtar2OyCGJPzUNMldlIOh3FhfDg8VlKGZ
         YVt+oslBEQ5uHl3chDH2E95RBg4BDv4BOJeU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767355816; x=1767960616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyAExea92lRqN3+lMIDtFuHcTalaR06svoPNW5R6G2A=;
        b=sJKgRK4keSzEi2Nogen0NWaezW+W4flSG7blXI70k/qe3fv93QV/2f4p93bHBymeK5
         B6Q+ftJKNYlPd0k0FirUTaHQUOpbL1IpxSnrIgxSvDK+csVWX6T8fAtzaO2hLC8dThuf
         VXe6sc4caq1HpxlPOBa/eeoEuf+4w3UHHqBPUqSq/EnqzUfvoUhIdBM1OODYJc9S/axQ
         YDSpE+ASk0S7xvwCfdlUhrrKRzQMh/z3UZOKTGvMfw2J2gXqOV0ZYdqr1ymqkKrx91VF
         13q+4z5mYtU6uJXVx0mMR4dxlChOrjvRh5D+ScDJo3ok9s8Vn5gSANniN+cg0XOtebQP
         j56A==
X-Forwarded-Encrypted: i=1; AJvYcCV6/kmW9P1wT+VKbXL7s6Y1lTIF0itztQ8V8Y9fbEEb3O2P9UgWVKaLoa6edLA2dTHJTzzrD3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCcNQWyIwfzo2c0+s1+MJcl3RMu3C629bXvOFx+8PtGv+KPbp
	JspUGSRCvd8+cQRVXXAv0zUjHeASCoAL2SW05eNlZuKEsiFXTjxzOCjKEUCtbzBI3Gc=
X-Gm-Gg: AY/fxX6IPZL7qYXIKHpwfFa5uNmGICQAolS3FwfLeOHOC5kLqEZAaRufNVz5JG20L1E
	kD0VFvc68OJHVHUMqtZWhXfdhfAtOGbRCXKdfG6Dd1Aot2AxNSCeNpc/REqBCEjqrdB5g2qObfJ
	wgHh16GJC7GUibWV7AhrdMpOrJkLwFnQaaBObLoTscTu4WqiZw7EhByb3nmnDH6OKAF8x4qxxSp
	DFkoDdVCjK531YBKnS+sZBwFzwY5e5gzLCQu/NUh0Uxe6SrK6wU2yB+Bq6jpQ0+kb9JNlze1KPX
	pbuBzQvxTRdRHewhHS+q0gB2pTTbAg1UEA4k8Mof9Kaiw6KIvrYI7GOsjhGd82NnyaOPpa3L5Ac
	Kfw7NnPp6QCePIjYSL3pQQLXZ/iggmKwMTW5MzU/dBQqC7/JekN5vk0RCKhwpMiLV03qRKVbl9q
	/M/Rj3F/cNIMAncWX1+Q==
X-Google-Smtp-Source: AGHT+IG8H78AqDGUvKh1cti5vZlXZa2v48LQQN927UiarpjJoTYvBWuOyOqu0OgFvo9qewXcWc563Q==
X-Received: by 2002:a05:6402:2787:b0:64d:1f6b:f594 with SMTP id 4fb4d7f45d1cf-64d1f6bf77cmr39880832a12.15.1767355816208;
        Fri, 02 Jan 2026 04:10:16 -0800 (PST)
Received: from carbon.k.g ([85.187.61.220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494ce2sm43342738a12.17.2026.01.02.04.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:10:14 -0800 (PST)
Date: Fri, 2 Jan 2026 14:10:11 +0200
From: Petko Manolov <petko.manolov@konsulko.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb()
 failure
Message-ID: <20260102121011.GA25015@carbon.k.g>
References: <20251216184113.197439-1-petko.manolov@konsulko.com>
 <b3d2a2fa-35cb-48ad-ad2e-de997e9b2395@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d2a2fa-35cb-48ad-ad2e-de997e9b2395@redhat.com>

On 25-12-23 12:44:53, Paolo Abeni wrote:
> On 12/16/25 7:41 PM, Petko Manolov wrote:
> > In update_eth_regs_async() neither the URB nor the request structure are being
> > freed if usb_submit_urb() fails.  The patch fixes this long lurking bug in the
> > error path.
> > 
> > Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
> 
> Please:
> - include the targed tree in the subj prefix ('net' in this case)
> - include a suitable Fixes tag

Sure, will do.  However, my v2 patch makes use of __free() cleanup
functionality, which in turn only applies back to v6.6 stable kernels.

I guess i shall make another version of the patch that is suitable only for v5.4
to v6.1 stable releases, right?  How shall i format the patch so that it targets
only these old versions?


cheers,
Petko

