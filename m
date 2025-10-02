Return-Path: <stable+bounces-183030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A14BB3891
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 12:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F1A32216A
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F22FE073;
	Thu,  2 Oct 2025 10:02:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F02F3C10
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399377; cv=none; b=YSAijh5lFdIkxRWv5VRcHBMhFUZ0bSqb3qYw9KfzQBDm8NM2tMliVgU4LzLxNYGNoX4dqDiyYUWd/W8KJnGasqMp9e124F5xGYEe4F+sBkgcdVs9O3vWxHeplLrzxnRTAgnNOjeS2MnpjaNFJeDndY/4npNmiXFLQTtokuLb/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399377; c=relaxed/simple;
	bh=oKOvZbmQNCWQ//hSnLqE+hNmE/wFXuNJObFRI25KdQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVNC/0d2T7dIUS1GMu5W1oofdbX6HFmlfqoXFzb3jSW+dWRcJPizjpMPizd1lrCDwJ5YwHSaFpi87rbBB/ySK4cEV3ZdPZQPjIut0hLYSsl7zKOlxho5ZqfPQePDrJbf98Px7TUOwNpuaZja8cFp00myvmwCeXYlb+RkC0QEnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3d80891c6cso320121566b.1
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 03:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399374; x=1760004174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ3f0Y8jx/ORdUpe8rUwDsc+LhxkZNLDRVr6mrw2tpc=;
        b=RimYnpXJ0CSADfosF08I18UaGpD3KljQrXebPFvzHMkA582/C5O1ZTIX0vbb1dxFxA
         jHTK6CL7hSc25/zifKurqYVKTR5YrwIfgeT/zCO1T5Fy1vhxIYcJyyp2hS7vGiHqtPEP
         pxuubEXBY0bn2NJz6B2NsTZY/HUROstWbzovAtIwiuhYVtNshMP/H3oKdaTYtzdt+LaM
         5nV/M7Yu1FSTYcxTQwC5n+zo9iI5RNxuYsEe6yqYMhKbCa7a0JeCaHEelAeJ/QZnzs2b
         4FLUlzUzyMCRsRVlasA7wbq+McD5bh86/C0d4SI74Tnd31kJG5udSngfARY0TBVBN/yy
         17NA==
X-Forwarded-Encrypted: i=1; AJvYcCVlIZ4VFm6XTj5y00MMEqVd+3+24fm+L5/cPxGIS76PtvYxK30f2eU/4q6HsEH9ZaEhFA4OhAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWo9e3vPBK2FdywB22YAEi3y4F21y1oVMqkOuTim99fXsCD3/0
	F2XgDYEjc+egbCiJ9ICO+w+Uk+J158gMm/XmzdyowkRdlJ9Lzp0a8CDB
X-Gm-Gg: ASbGncvyEc+tHP4bRP5joUPEHoIBkNdYHJRoviVjcz0Uqd8/qBbr1AsuvqujPCB2nSg
	fEQKmezFpa0Kv0Az4aBqJwicTKywArSZaxpDQuoEtGIcPd2ondnk2WsuyYDepEShEr6asFBLdft
	z55QWrNMladqeoJ/NqJQcl7Epa0B+vsBf4siTE9jykoCKrClpdHK7gNyqdWf59cPE69Qsgb3Z5/
	1u2byR+PBmclOz63YpBOivqVK0gAvV1LzDEjZ20j4FnK9SAlhJO6r3a4Dv6Nicn9e+5eY4dtx7G
	8z+Pc6DPdkivXCNtSj9Xl4lnioBvRM6v4g2hN9KAzFdwMu9pVtGvQWRMg/Dqjdeaf3jSsp/pr96
	8+Cga8685lKU0fLpCC+rxIYlIajj/AKAshDkT
X-Google-Smtp-Source: AGHT+IECt7u/9qQGkVz0M8l72m7XI4NHOj3MUzKdcpcelojvKIeJ3ZA1Crkq5c7f9e4R+Lj32nMt7Q==
X-Received: by 2002:a17:907:3c91:b0:b3d:e757:8c3f with SMTP id a640c23a62f3a-b485becf38dmr356982266b.30.1759399373350;
        Thu, 02 Oct 2025 03:02:53 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83482sm177255966b.26.2025.10.02.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:02:52 -0700 (PDT)
Date: Thu, 2 Oct 2025 03:02:50 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>, 
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH] stable: crypto: sha256 - fix crash at kexec
Message-ID: <vz7xsyrtgg7ss3jlxfykk7frjiwm32nu72pc7pfi244g3ssm77@k7i7t7c3o4lx>
References: <20251001-stable_crash-v1-1-3071c0bd795e@debian.org>
 <20251001162305.GE1592@sol>
 <jm3bk53sqkqv6eg7rekzhn6bgld5byhkmksdjyxmrkifku2dmc@w7xnklqsrpee>
 <20251001165455.GF1592@sol>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001165455.GF1592@sol>

Hello Eric,

On Wed, Oct 01, 2025 at 09:54:55AM -0700, Eric Biggers wrote:
> On Wed, Oct 01, 2025 at 09:45:07AM -0700, Breno Leitao wrote:
> > Hello Eric,
> > 
> > On Wed, Oct 01, 2025 at 09:23:05AM -0700, Eric Biggers wrote:
> > 
> > > This looks fine, but technically 'unsigned int' would be more
> > > appropriate here, given the context.  If we look at the whole function
> > > in 6.12, we can see that it took an 'unsigned int' length:
> > 
> > Ack. Do you want me to send a v2 with `unsigned int` instead?
> > 
> 
> Sure.  Could you also make it clear which kernel version(s) you are
> expecting the patch to be applied to?  Is it everything 5.4 through
> 6.15?  It looks like this bug actually got exposed by f4da7afe07523f
> ("kexec_file: increase maximum file size to 4G") in 6.0.

Good point. I've put my wanna-be-hacker hat and try to crash the host
before commit f4da7afe07523f ("kexec_file: increase maximum file size to
4G"), but no luck at all.

So, I would say we want to limit the backport from v6.0 to 6.16. In
this case, it seems the easiest thing for stable maintainers is to
"Fixes: f4da7afe07523f ("kexec_file: increase maximum file size to
4G")", which will limit the backport into only affected kernels.

Let me send a v2 and we can catch-up there.

Thanks for finding f4da7afe07523f!
--breno

