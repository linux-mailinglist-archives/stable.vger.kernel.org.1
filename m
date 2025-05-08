Return-Path: <stable+bounces-142781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508AFAAF235
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 06:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B49D1C04BA8
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 04:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7401620C001;
	Thu,  8 May 2025 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jbX4SbYP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050B1F63F9
	for <stable@vger.kernel.org>; Thu,  8 May 2025 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746679891; cv=none; b=iLBRtvALnI4KDG/wog+AMYiUVV3UtOGkMGMKwYSkYoRfWDmlV4BtZ8P+EPy4GIDmTWWyDbLoYU2BDl7x7jaUQKFnK4EKaRywIJgryCeGT1Waq/o9RUldK0wCCc71ojkfThXEoFWxQhlG3e14XjybUlMPxbvnplSWtpwhti/8cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746679891; c=relaxed/simple;
	bh=vH8pZApZwCxXj/zcKr2DuVOpsesqXZ3FpznsuRlEkIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbqdENu8yvcJs/4KUEFk7aAjEDAqBF1JIGQ0v0PIteb7FoClKHubIYqeb9aIVPQ6X+ujelR1g7E0Vum1jN+6W9Fh5IePPvtSXl/Mcet/emRulMfmWNmBBRN8IRZaYOrTT962a09M54fcGQu3PTc3R+uRu/e+OypKrAL0O1QTOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jbX4SbYP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso657162b3a.2
        for <stable@vger.kernel.org>; Wed, 07 May 2025 21:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746679889; x=1747284689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vH8pZApZwCxXj/zcKr2DuVOpsesqXZ3FpznsuRlEkIQ=;
        b=jbX4SbYP2dKr37f14Y4b1v3LuV5fI5CxSwUHxyTAFUoR/dscDaqOjIsBnDFuVttes8
         WD57GxqWxRwA93eV0UziNQWEpZavcBnLY0IgaYZ/qB4bXklkuEbeIWOk2X055xFRHKK0
         ZbsusjWj1zOfSeShT4BFqi5YZUn0OpxaEjieI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746679889; x=1747284689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH8pZApZwCxXj/zcKr2DuVOpsesqXZ3FpznsuRlEkIQ=;
        b=knHjlTtUeJ5YDrOCTJdAHdonwVaM2ByZBWvojK6Z6tzq6sdxIjYCzTtzA9a1a2FXRg
         QOPZ6JjxRWP+ufYsPp8o7IAqWYcYCgxvHxnGFfQhn6U8z2EHeksit/BXey2Q8JucI64v
         KlI0Fk5IG1VuDMzbe+4Sskwxgr5bGK4Jr1jBOWXcRkqYgiG2hEa0VC41DA8/jsQR4ZO2
         7UfihnROg5C/b6gD2B9VOctNhaY5kEHXAe911VGYqLHgpwnaJHCCR26EZCuFmEfpULa0
         4lfRZupJb0GH9u/ALN/cP7oDzecCGwrCZxxPDtoj/YAo2myBQCQvOzQcS2fnm/t4v8Nl
         SqyA==
X-Forwarded-Encrypted: i=1; AJvYcCUOrN8JitKAnDX0b+ZZsGC14LVk2mbkwFkF+6G3ymOe+fVCIfHOaHx7Ze2d/p9JVxAtZWDVr5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYajs9rAflFSkaGwQKsfF9ICzFqBaLldMwZ6E1HMYXNP00Uad
	l5ppeU9+uHfN6q9kLtAmrZqFBKai1oK7QphPWrfYPIOPsGkQqX/hC3RACArtYCkgH6ObS1R4/o6
	bVw==
X-Gm-Gg: ASbGncvJKWwRHTZhgCAX8+Prc0w8FPASNZGqRCSAl4zxCjowl2aKxZpG9IWgOA7xgQz
	XvhwBWjtmvZLqcLixGNPj6lT8zyBsipgjnwAp1GnCUC+VNUF7Xi0q4qjyX8ljDlYSqJXPTl8wtw
	yRSwXcFQIO9t3bWATdPiH9NxVSTEQYyZs3sKbM//5w0WmupLlIWEEhPRK6noQYb9oi0pR1VUYFJ
	O1EAH/rRBzjXDe+1LarFmmUz/Os0a2j0meijGoycUE1JoS/2WXxWYmnPJprtOpI7NthFcvtsfp2
	daxaHjHXIKn7MZywQoop4Ktae9Gl4944L0b5zXF0N0ZM
X-Google-Smtp-Source: AGHT+IHJt3oTtWnZHdDl97ybd6P+Hsv2F0EjcCAUaLYDnkgYwSOPmPUSLh8gTCh3PPuM9rSSslwTKw==
X-Received: by 2002:a05:6a00:1bca:b0:736:5504:e8b4 with SMTP id d2e1a72fcca58-7409cfaf3a7mr7364505b3a.19.1746679889147;
        Wed, 07 May 2025 21:51:29 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c794:38be:3be8:4c26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905ce9fsm12728777b3a.136.2025.05.07.21.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 21:51:28 -0700 (PDT)
Date: Thu, 8 May 2025 13:51:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, Tomasz Figa <tfiga@chromium.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] media: videobuf2: use sgtable-based scatterlist
 wrappers
Message-ID: <ravkxkfx6du2uovpfqwugtmm3ymmuswkusfiry3erslpgnvaz2@2gwxofmdfjye>
References: <20250507160913.2084079-1-m.szyprowski@samsung.com>
 <CGME20250507160921eucas1p2aa77e0930944aadaaa7c090c8d3d0e73@eucas1p2.samsung.com>
 <20250507160913.2084079-2-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507160913.2084079-2-m.szyprowski@samsung.com>

On (25/05/07 18:09), Marek Szyprowski wrote:
> Use common wrappers operating directly on the struct sg_table objects to
> fix incorrect use of scatterlists sync calls. dma_sync_sg_for_*()
> functions have to be called with the number of elements originally passed
> to dma_map_sg_*() function, not the one returned in sgt->nents.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

