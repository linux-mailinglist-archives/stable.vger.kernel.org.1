Return-Path: <stable+bounces-61355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EDF93BD49
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 09:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DB71F223A4
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360AB16E865;
	Thu, 25 Jul 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9J8A8X/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AF3224
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893638; cv=none; b=FREUNg6maoKgwSalqAw4tIBQ2XXlriXRtiTgBsL4Ar31OvJOWylDpnG20lgFRLJ1zddVw+aSFc8XFTf2V/zArZ3RmHOC6ZV1aX/mAj3Q/vNVp8YvZaIHEXEd1AJfOqXG6Q7PnZflI9XPgXwBFQPhOu1vaSe1aPl0GUOURWW1TMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893638; c=relaxed/simple;
	bh=xbNwwU319rkoRLiF5J4L5ECjiSneLZ1X5F5cu9hErGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiqP5WgRrzQ1gpA5mf4btLxdxjxX92wMVOiu+O3Ka8A6sgEDYaGlHsFOarlNMshxtzVPHDH/Cntp6xy5+J2lYq3WUdUPV6Esv1rbezdQHOVwXVpy4/MmpIJRNJ2PhosUFhZ1Fasz/biBm65xA6Xjnq57kzqvllEkDUUQB8V7sQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9J8A8X/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc569440e1so5714805ad.3
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721893636; x=1722498436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KpBq3z07GcYsJy4O1z5Daz2Py/Pecj57NPa35Ml6XIM=;
        b=H9J8A8X/cnLnuixq52Qq8MknbtNeTUkz7WJb0jWO3YxDu4VObkFZOEjXfrJLAwNJQH
         CPVT2nbR4qwmUmbaUKSyGW+U/Do74/TCuLgGI9Ms67UDKS9TeWirqRFSsPcbeZpL0WjA
         vYmNXc8JWjRibQG5Ouc8TrnSSAVTIFxb8URC3ywUP6QZGsETemQcC/XnbCvWVBgezNIE
         zEooNUOS4v0p6gMPoYBRgPaIpeF+9oI6saRMRzf+vcrxKKiJ3qjRzw1rAzD0szAlO8sQ
         dJjU3V0z4F4ODuplWhCFLJh9kqTNW6sBhjFEK962VLkaoHTMHWM405inUYVdcbeefNcW
         qVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721893636; x=1722498436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpBq3z07GcYsJy4O1z5Daz2Py/Pecj57NPa35Ml6XIM=;
        b=p26yQYT8oXbPi7uX72qrhdrsSy04r7iW08TAae9Kdf6GriwMBsWdRXWro6+CVe+Zud
         gj8mBBRUtYd5uGLpnihD58wSZTpuG4rW02kEwMMYBgfsKZrf/tLEPyjt4y9By2V2UsK8
         f5ediHMhm9AlRAqOSRqt90T28cp4WNqpYxrdI1giuY1H/9ap1tq//tika2mPRzSgiFxg
         TNKYUWqOG4p/DQdtRZQdTYxCjimUw3YjZ+H2YFmeaeZ/eaoTGgyvC1sljnnSM+NdMpmE
         RU/jUz9zDSagXuUXDZt/10Rmk8J/4x3tUFphqEOVkV/hR51wJckIliSAqKix9X6rlk12
         2KEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs3FXBMmqKLaigbgBlZ+KXeCaw0kro47i9SWkbRZ1IWajcrRHql8sdgcG0w51V6XfzVug4gketczeQEH4hCyo4R8Z5aAlT
X-Gm-Message-State: AOJu0Yy9jnoYOvEnPqj+9uvrtfwDwZZymmGURFjb4VeceO8Ts52uZy+p
	C+DaE/G0jul/8/KZ0oD6j+LxNXRIwWjVe3WqE4mqvMYK0cs7eT/CBIdeSKc1ug==
X-Google-Smtp-Source: AGHT+IEvPiQ4tXStL2sFA0d8J9F5uD2IHeouCkAncAwEO9kDbAu69BWI3aENx7hEAk7hZ0kx2c3RbA==
X-Received: by 2002:a17:903:2343:b0:1fd:5e91:2b13 with SMTP id d9443c01a7336-1fed3870cdbmr20396675ad.1.1721893635894;
        Thu, 25 Jul 2024 00:47:15 -0700 (PDT)
Received: from thinkpad ([2409:40f4:1015:1102:1950:b07b:3704:5364])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f6dc27sm7688855ad.237.2024.07.25.00.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:47:15 -0700 (PDT)
Date: Thu, 25 Jul 2024 13:17:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240725074708.GB2770@thinkpad>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <69f8c45c-29b4-4090-8034-8c5a19efa4f8@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69f8c45c-29b4-4090-8034-8c5a19efa4f8@ti.com>

On Thu, Jul 25, 2024 at 10:50:13AM +0530, Siddharth Vadapalli wrote:
> On Wed, Jul 24, 2024 at 09:49:16PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> > >   of_irq_parse_pci: failed with rc=-22
> > > due to the absence of Legacy Interrupts in the device-tree.
> > > 
> > 
> > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> > if 'map_irq' is set to NULL.
> 
> While 'swizzle_irq' won't be invoked if 'map_irq' is NULL, having a
> non-NULL 'swizzle_irq' (pci_common_swizzle in this case) with a NULL
> 'map_irq' seems inconsistent to me though the code-path may never invoke
> it. Wouldn't a non-NULL 'swizzle_irq' imply that Legacy Interrupts are
> supported, while a NULL 'map_irq' indicates that they aren't? Since they
> are always described in pairs, whether it is in the initial commit that
> added support for the Cadence PCIe Host controller (used by pci-j721e.c):
> https://github.com/torvalds/linux/commit/1b79c5284439
> OR the commit which moved the shared 'map_irq' and 'swizzle_irq' defaults
> from all the host drivers into the common 'devm_of_pci_bridge_init()'
> function:
> https://github.com/torvalds/linux/commit/b64aa11eb2dd
> I have set both of them to NULL for the sake of consistency.
> 

Since both callbacks are populated in the pci/of driver, this consistency won't
be visible in the controller drivers. From the functionality pov, setting both
callbacks to NULL is *not* required to disable INTx, right?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

