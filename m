Return-Path: <stable+bounces-204822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E4DCF44F5
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE8830B65DE
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78914280CE5;
	Mon,  5 Jan 2026 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bV4/2Mgi"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B572D7D41
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624806; cv=none; b=Wysivfn1JHPeqW9F9IY+TJVLG/8moP3iM3KM+d4atZP6cJWvQM6eUFkk4sttFROOLPvtxdd2ewNCA18GPWBwzRzke5duXipUwJdL2DVBPwJP2YmpzNjjdwGa0Ue9GiwNNnnJFyEteIsNfG9nrT4ZYJGOTxs54sUH5Z9C0e/uyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624806; c=relaxed/simple;
	bh=0VJAy1LxeO1DoMMmQqr6qf7GwbBJdW99Z0xb4rwj9wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7FlUSOpMeiZaF0MyDO8vFxksKS5r4AsqfyjN9LaSGiSkyRqtuHzu7/ldr6iQCAcWafF3WPZr2omKce5Nxv5E1zIyYbtii40ZO5uvbLq9k4af05Usjg1JdZUmR0z2uBtBHqqgqMsInlnb7+TvPJtuAFcU7jVFQCGExoLMeZjglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bV4/2Mgi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2148ca40eso2278590585a.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767624803; x=1768229603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0VJAy1LxeO1DoMMmQqr6qf7GwbBJdW99Z0xb4rwj9wE=;
        b=bV4/2MgikgXprMJ2j0430LwJLfgPNePxG71j/FosCi921Jf/s+2kE263Shgu2wUJ2G
         ZU31EA6BhMX5zGSZ0F0+wUYVNPbFcC4cq/agByDrdATBjGeEUrXVpIgGI4B73CyhJHGF
         cEgH+nOTt6YAjl/HrKSwfa6wFHumgZoxCEq9UCvZ/HP2QIaDkiATgadZg0hGNEePBB8B
         rTtk/Va+sPVgWwM7Tgtjf+gD+iDrnJmJchTypWUbNB+uMqbLqKjFoF7YU2fCAn8s4hgU
         uUkipGPs0aiaa9YoiuUT1saayDC5ku3ap9ZPFLmnhIlh9ednRqwPxL3mtHLbfMUqff0E
         4bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767624803; x=1768229603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VJAy1LxeO1DoMMmQqr6qf7GwbBJdW99Z0xb4rwj9wE=;
        b=UwRF3ZeYn7tBOl5DFEQntypo6qd3kqKIXNJBFXiqNZRHywbpSYoroUm2gxcQUViGSP
         Ce0CBcouXycIqoI96m3IypXoB/ae2RE24scV0+AAf4Zyt/ch6h9WrIYHhN26HW7oq6Z7
         vP6btMevK4B3B53GDqnq+KQ428arIAhwlw2nhpyPF8/RYoxVHftkkPie3tvj3YNjUD5U
         oX2KYG+KUQ9ToHI/qNO8AHXvek1eDWjC5C2iDKj1+zCjxjxTn+68Ar5fVFhbx+X+Kdna
         RhPLDTy6XNSruJupH+bmlInYXYIVj3v5oJ87lrRWkUOojjuC3U1qvkNEIubsHlgnXOfd
         PWYw==
X-Forwarded-Encrypted: i=1; AJvYcCUSFNVZLgKJg+yrqu4548r8iug7//F4ZnXEmRyysrbXsOMkMnT2LZCyOVRvDczrYLGeMLyOOwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjeYq/Jw/Mp6kx+HrTdpRmv/kNRK7iq4gZ6SPWJ7tHJUcTCkh
	1SjkNbS6dkvvUeMoVwvx2C/Yhn1hrDOkHOMYr4ApUW88gIYNCWdP0ouBgswmuzvocmd+l3u3wNm
	9USZa
X-Gm-Gg: AY/fxX5lhqLJLbXVdpklNMWsN8VATl/BeopZmydK1H1eUA5QVLgTRmbEkVTNDL6bupR
	FfWzrRcMmKPKEoOIUtg3THmof10WRsTigtAFn1yBtB2I5JuN7IhNI7Rqpy3co7zr8qu4DuWtwkj
	XY9IIQ/el8Mem/oD1xXJf41R1hi9R2X7fnbEIWQOODOdrQhTy2UkfqXj2C8HdxCRZBxoP0sPmK0
	PH53p9iuf1u0yIPhUDhbEOXFCU9EtdzlOdUwDGpSP7Ek/7UXuwYYrQFFXRblTEJRy5lzak2bEcB
	XXpzkhEqCIeZpvKZo72Zu9QLR2rFUO7Ej3hrvX/NazrjQxRk3ZYPUIj9h6JT3NGKyPZEb5SDJJr
	a5f8kdd1mzs/GmiyEcgeWrOhosTQOVGKvNYMjjeuPvqG6tUSF2wm9SRi+3m6twdu2dKv3IGAwyp
	ANvLh6emsuYw++jICVYxBL6vNyu1q4uRDGRUGEl7n5S/Rg9yvpCDk52KyX+yx2H2Na6Y4=
X-Google-Smtp-Source: AGHT+IFUt6wPvI9u2rR/xi8Np2VLLWZzGxeI/Po3U8DHhN0nYQEKldceIemvjTqj2Iro8b99/psoBA==
X-Received: by 2002:a05:620a:4611:b0:89f:19e:46fa with SMTP id af79cd13be357-8c08fab5a22mr6994767385a.20.1767624803162;
        Mon, 05 Jan 2026 06:53:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f28e3sm3963769885a.45.2026.01.05.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:53:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vclxR-00000001ANB-23EY;
	Mon, 05 Jan 2026 10:53:21 -0400
Date: Mon, 5 Jan 2026 10:53:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Dawei Li <dawei.li@linux.dev>, will@kernel.org, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260105145321.GD125261@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>

On Mon, Jan 05, 2026 at 01:33:34PM +0000, Robin Murphy wrote:
> The assumption is that if the SMMU is not I/O-coherent, then the Normal
> Cacheable attribute will inherently degrade to a non-snooping (and thus
> effectively Normal Non-Cacheable) one, as that's essentially what AXI will
> do in practice, and thus the attribute doesn't actually matter all that much
> in terms of functional correctness. If the SMMU _is_ capable of snooping but
> is not described as such then frankly firmware is wrong.

Sadly I am aware of people doing this.. Either a HW bug or some other
weird issue forces the FW to set a non-coherent FW attribute even
though the HW is partially or fully able to process cachable AXI
attributes.

It is reasonable that Linux will set the attributes properly based on
what it is doing. Setting the wrong attributes and expecting the HW to
ignore them seems like a hacky direction.

I didn't see anything in the spec that says COHACC means the memory
attributes are ignored and forced to non-coherent, even though that is
the current assumption of the driver.

> If prople have a good reason for wanting to use a coherent SMMU
> non-coherently (and/or control of allocation hints), then that should really
> be some kind of driver-level option - it would need a bit of additional DMA
> API work (which has been low down my to-do list for a few years now...), but
> it's perfectly achievable, and I think it's still preferable to abusing the
> COHACC override in firmware.

IMHO, this is a different topic, and something that will probably
become interesting this year. I'm aware of some HW/drivers that needs
optional non-coherent mappings for isochronous flows - but it is not
the DMA API that is the main issue but the page table walks :\

Jason

