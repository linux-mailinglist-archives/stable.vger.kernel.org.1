Return-Path: <stable+bounces-204148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A55CE84DD
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B74430198E9
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 22:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A457A266B67;
	Mon, 29 Dec 2025 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8vVT4vV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEAQPnsJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB72288F7
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767049029; cv=none; b=iz23eQI8T2MfzG9q0n4YAHjbNoa9cnjp/RXPvCiE0qA+MuF9JOBYyacx85y0npmmKrUo6GXCFbh2rP5P0xIffLF+mO0CspN91iglEi9kTx9P/oMLQ8afn6c9aXQ4iUCWWQUC2k0ewY6ttuhVpCy+3wfwMnDxS4+Q0NEhtaf0Hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767049029; c=relaxed/simple;
	bh=rKhMc7moZnucpQRJrp1OiMt9udRoh+GEJbqrJ1mvRrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGrT/ZL06O5FoMBCgU1rVYc2kBSwr+/rTufOa3U2dJCB/3CSh6yhV5hn74xPzB9+zaWUWui4Nziasdhk5Qxf4gH489Uq4zYOQ3sXw4KQqRElkvw+wbvB1p9KY0sVxdgNXAGn+9WpNGrvvdC/1rjDSxKtzTdfX/R/6RP02hktOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8vVT4vV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEAQPnsJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767049026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKhMc7moZnucpQRJrp1OiMt9udRoh+GEJbqrJ1mvRrU=;
	b=H8vVT4vVPmGY0kX+kpEqP49alEJqs39yLXeMJ6XschYOnttPB7a9jhlH176PqzNPy2Ul7U
	XghftcN8YSHQyf5QLRSZM3mWpjtz8XyaGpA3X4fz9lzKO61j1PHMeyUYsCMY2HRQzNfJBo
	+MAuv8EArFHdjTFqWsC/gFG9u1HCDTc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-ZoZ_UZwJO6m4FR7UmWwSbg-1; Mon, 29 Dec 2025 17:57:04 -0500
X-MC-Unique: ZoZ_UZwJO6m4FR7UmWwSbg-1
X-Mimecast-MFC-AGG-ID: ZoZ_UZwJO6m4FR7UmWwSbg_1767049023
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f5dso4653105e9.2
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767049023; x=1767653823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKhMc7moZnucpQRJrp1OiMt9udRoh+GEJbqrJ1mvRrU=;
        b=PEAQPnsJpWbUrc3frrk76T9yIclj7yTcrleCL9kNRJvWn9aw46IStrVFfD0mhjof95
         iaqIbkbDBz3CN6+S47bYf1zx1KS0QAZzP1iXH1PHM7BDl0WIi9zOScbkfRtGLV8dSbkx
         rBNxiWsbNtJcDbwvSyO03SGZDHQ3jSTLLDrjYRlgqua/wU4sTWxVbWt0cAslXcEP0xzp
         5c9RbnBfB5JYUSUGaZkitcoBp+HCKUi/kxkViz642CKl27AbLNLo54GWFtkZsney2yCv
         aVS8+170qwkjJGLp0OiAx59OII07+FXLCVBk7J2Df4VtEoFpwzSIDgAcmde7Vgd0gNKK
         1aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767049023; x=1767653823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rKhMc7moZnucpQRJrp1OiMt9udRoh+GEJbqrJ1mvRrU=;
        b=OAx5B64OwLSZMnZRGRdpo/bVTZ6llDZ1DKr4tV4GHRnxvinUnc+vznoz06gYMwKAF+
         hbPTLnHYbVqFV3IgzKAATdL4qdJ6FpyWFQqTwxBomVf+oZ8jmxWvaf7pcFtuA7EWIW8A
         5W9AftOz6FfOu+hmI4R3ztLBFwtsFxRVRdOQHZA1O3VFjLNpf9cqFoIy2k9cjDCYV+wp
         NcHPceFDeOu8Wi9jZ2k2Upjb4Oytqqz5kMDiE3tCc7YRO3zrlMnKeMVBQb7h5jJA3tJs
         B2Sl2Gor3ku3bwnGVT8Dyt+AwC9FHuAp904iY1IR+nCRKCRFy7iNkp/6RFR3mZ3Us61A
         r8cA==
X-Forwarded-Encrypted: i=1; AJvYcCWVbZMVFolnYZFzqSklE1Kt5G3+hDKHFEjFR78zCVZ3beU1CL1paE2PMX3f20S8/yT2D0NIWdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgydNKU4wRkI9IfJbXKtB3YxJ2oiDbxObw1tyAIHECta4Zow+h
	DMTzHcRVQvi2/UrAcS0jwTUezA3AAnFChrfGsuhky53LvcNNpZ7FeZzP8af8r/FFJWuU/YONR1w
	LJwfsXAt9/UwkcFXsEl4M5ajW8pkVKZU2Co0OEVpKcKlXYDoU4IB5pRTHxDZrbpHKstJywjopOZ
	htdsjyPTLRdHJ7m0qboHxuoLKuTly4qJhd
X-Gm-Gg: AY/fxX5f1y/opGZkTbp6CgUcQIQw6Vx/6lRRDO3Y3lPFLPeadxWDEwvfGomOrCAW7xs
	dD6oaGV6NY7cu01K5gHI30pAdrjZS/p5Ky8M5bFSgAaT7hrPOwOnrosTi7WTKowmNcDjzbXjLYz
	TSRjpKuhrQB+Wgt4v57OUBfwfKF5/JVm1+EmBXA0hQeG3IBL48cdeuBAXpI3oNmAX8uvSYWBbqL
	nvMl2HXtulomuMhK++Y1sKw0glYtNHxUFNKwSGREO3jNVC0kYwSN2IYEZybmtBq9N6EJw==
X-Received: by 2002:a05:6000:26cf:b0:42f:f627:3aa3 with SMTP id ffacd0b85a97d-4324e709b83mr39163569f8f.56.1767049022752;
        Mon, 29 Dec 2025 14:57:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw5RSB9i9zTXlUpMP+KZpiRPOwnZJ2wJjAmCBBZZ7ff+Uvoz6R8351vKYrSi8nEgYFvOVsD55PpP5fV/Elu24=
X-Received: by 2002:a05:6000:26cf:b0:42f:f627:3aa3 with SMTP id
 ffacd0b85a97d-4324e709b83mr39163560f8f.56.1767049022341; Mon, 29 Dec 2025
 14:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224001249.1041934-1-pbonzini@redhat.com> <20251224001249.1041934-2-pbonzini@redhat.com>
 <ub4djdh4iqy5mhl4ea6gpalu2tpv5ymnw63wdkwehldzh477eq@frxtjt3umsqh> <aVKlJ5OBc8yRqjlF@google.com>
In-Reply-To: <aVKlJ5OBc8yRqjlF@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Dec 2025 23:56:50 +0100
X-Gm-Features: AQt7F2rK5-45YoZmx0KzG3pMnmG43xyjViIyK1sveFWiX4C5kwCQkHI9RuRdVsM
Message-ID: <CABgObfbJURq6i1HceOHAsEk0gnOhK1vQfStPZ0-XEEL7qFUFmw@mail.gmail.com>
Subject: Re: [PATCH 1/5] x86, fpu: introduce fpu_load_guest_fpstate()
To: Sean Christopherson <seanjc@google.com>
Cc: Yao Yuan <yaoyuan@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 4:58=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > Do we need make sure the irq is disabled w/ lockdep ?
>
> Yes please

Sure, no objection.

Paolo


