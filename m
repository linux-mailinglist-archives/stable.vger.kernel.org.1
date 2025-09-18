Return-Path: <stable+bounces-180538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD1B8530A
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B543B897B
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B624887E;
	Thu, 18 Sep 2025 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jv5JSEvt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975130E85C
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204667; cv=none; b=iX9cA7GyyJ7JvyGhIL6Mo3uDyWBH8bPQSkRNqLGngKxT4DZ5NZ+bd35j0/4QVtkxw1rocBULDYQWo9dsCWMiAQK6QvY9UmGhA+WSe/mNPjqTZwQoSwzaaP+yvg16Aj0r7MTrj/lgVXZxHDLFavQF1jQscZ93PM8jyefSdf7t+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204667; c=relaxed/simple;
	bh=x7jb8JfGQsSR4XtTJ8eBWd6uBi74hSXtB25C9NcBMXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlVMdqPJ4XyOf53bXCdwY3zQuzatMw01x8NlGFatrdhmkRAF2QBhAB+wYY1klFayQDm66FZvv46O+RaK83aEOq/vB21Zq//lv6YmTyioCuJBuwDHO+hJHooHg8BfUKDoBxY5Vr3jZgdD/Qic3Cde6VnTHkR+VhHnJcX8HMtgsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Jv5JSEvt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8275237837fso85076385a.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758204664; x=1758809464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7jb8JfGQsSR4XtTJ8eBWd6uBi74hSXtB25C9NcBMXU=;
        b=Jv5JSEvt90Fa9tbW7z3hoHOvmlNlKEagQOh6WrcP01HKdI0sZIqM7xCK5+8ZnqbRMD
         fAzcx9rQ+TbZ8zunCIkVM8BqI9D97/uKbeWaMzMpM3+ziHP69ifZzRPsj4iuUBg7FkFh
         ze1I+tVXnLL4I55H5+Yjz8nzSGGS3LFrYI2RtKxnJ0glqLk8cLGwYN80fdqtNI6ZDk1o
         8cwZnd1IjEV+ffSwf7mzQ1S+/ozk4yIz3/zo8TXZKrymfxHAcsr5xrah24eO4mcVNeNc
         Jf6YKv3WS4K0UdFj+UnbL6WOsqayPzmLbQHSpdqdprdFyxEHnjpc6bKaFSocruMTkSTa
         7rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204664; x=1758809464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7jb8JfGQsSR4XtTJ8eBWd6uBi74hSXtB25C9NcBMXU=;
        b=AsQ1X3qKFgWoCE+Tps/Yw9ip/5+djWv0qfYqmuCFvKe24CZqgUjgbfg/3Gp6zWF7rP
         VOfH/eTbgmSrHgHPxwgrbhaADnkqNwcUbkY7AcJmnaQKN6YC8ZINQbVD1VhS5f8aQfeM
         1RGsLwlJVxUwKUJEZ/vrILctGpt34A0ibY+xCr+jrAY98lWgYTfC4LM40RBeCMWlsq4H
         2grLrjXKid9Bo/IyLS3u0v7bWh9Fz7xaSJhFjYL4Y67ta+7l2PciNWiY0hi1gkH7pefr
         v/G6RpclWNaPp+156I0qcyWoiTttheFCIm1gDf346Mw2HN9u2rthqlVHMFL2WKYmTvJO
         MEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Z9V9TCZ7yodDGOUbYj/Ohb5jFcShFKtOVzvN30p6AnBhUZGTyIKYaVvIoFn0Q8AYubSLsrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GXeIz3tXDU46rkscQW5mjQpPrFrROhFy9mzrCOZLanZ6D5YR
	LLaOSbQkb8ez6VF/TpwHWKDUKoIebYn2Qif7OuxIAaAHNW/ksrutIR/p8RWYsMasL/M=
X-Gm-Gg: ASbGnctypKz1WpMR0O1eH9NrEPhhjCF2pRPYBiLPXwtnKtp74zg0/AY9eAR43ig67kc
	TVlQBaerR0f09rM5WOLaid4Z7jPiuHtmoJXiq2hOt2Y9nE13DjDZ3y2BvMVEpfET+tPGbCS4YYX
	9YfE4Jpn0bdBAYhbfozGnSaO+8VtphWubMKQGSrDTGa5Nwph5ra3JWN8GCSSqH1vQ7+9gZ+YlB0
	noopRV9+mPn6KFDXtaUPsHPjgJeaBM4X9XxcbN3pIwg5k+Xhb/sdR0loU6E+Jy4Qpi8OHMsvq+G
	cQ5SlsbsTQcoCjZn8MV4s6NfehBhwKSpA1qK0DwnnNGLdPjDpyMq5VCoJqHa6mc+eAe/1Nl7V9y
	4fG/sb7vy37+SrDefMajuFMQ+Y8EEgy5+/8OfKfIf8OPW5swGqCBF+rqz0F/ETltHIjrfIt5LPp
	Okp2n8gGI/tj8=
X-Google-Smtp-Source: AGHT+IFcG0Z3ZK5/PQ6vJav0eqkeBfwJrYJnuhkwdniJkW36no16Dw8WiAtdmBAplhwPvdJpSRD8qA==
X-Received: by 2002:a05:620a:462c:b0:812:be4:670e with SMTP id af79cd13be357-831109114e7mr656127185a.43.1758204663628;
        Thu, 18 Sep 2025 07:11:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83627d7dd01sm169419185a.27.2025.09.18.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:11:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzFLi-00000008vyr-1Vsu;
	Thu, 18 Sep 2025 11:11:02 -0300
Date: Thu, 18 Sep 2025 11:11:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <20250918141102.GO1326709@ziepe.ca>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>

On Wed, Sep 10, 2025 at 11:09:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> This issue was already found and addressed with a quirk for a different device
> from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> Source Validation erratum")'. Apparently, this issue seems to be documented in
> the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.

This is a pretty broken device! I'm not sure this fix is good enough
though.

For instance if you reset a downstream device it should loose its RID
and then the config cycles waiting for reset to complete will trigger SV
and reset will fail?

Maybe a better answer is to say these switches don't support SV and
prevent the kernel from enabling it in the first place?

Jason

