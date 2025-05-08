Return-Path: <stable+bounces-142806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E503BAAF412
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 08:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC851BC6ECC
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 06:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A3321931E;
	Thu,  8 May 2025 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfsGDDSS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D161F8755
	for <stable@vger.kernel.org>; Thu,  8 May 2025 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686921; cv=none; b=uTQw4RTaktcK+vCJ2Oy9g7JBNaeXDeFxVUire/1A9xqgg5tpUuVy09ldJrkvtnDg0AqPtSTCM543u145Oi/fFHB+xQGZ257X2eg/OPHaal01ZL7dLZ+8W+Y7BJx9/d81cXFzHcnNljNz6mDuvuSYhnwe6FtLH3re9gmrR6UX9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686921; c=relaxed/simple;
	bh=J+DaIgmJc2plhSf97aDyRcr9UEcA9j0U/cy24sN24Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXOguASO7hQoQbArGoeQ3GnMXXb/rkA71Ocf+sOJDTjhOHdoiOJQTTjSWCGwYFQ5t6+i7hURa3nBCpGCUQcIqQMOaGgwWtGo6WfqqIykteNaBweN00EsHpWnl4c5xU4zuSRuzuoCxXb5NKT2gQUaSkady1+x2pegS2kE372Cby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BfsGDDSS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0af41faa5so317643f8f.2
        for <stable@vger.kernel.org>; Wed, 07 May 2025 23:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746686918; x=1747291718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oN/u1yOXlCYt4DjjZZ0j855cjiGoWgslKBLO+dZCp3s=;
        b=BfsGDDSSIvF4sf9pj3wrOBnzwCxvnw4Z3tjuMSabkpzOWXHI7xJz1H+7RxuBOTu795
         CopYY/+ooRfrQOSxqR6teIeUtd+CFhyjym0H3Ia3s16qTd7/8ljwlocQ2KgLFtM4YUyH
         UxPrHXGf6kuyR9vp+7/uYd4+98SsObsJd4J/O7YvuTamezH7IUHue3a0Pqpb90zYbOsP
         OoWVWNgQo78pTaC7nItp631zoG+iXjEczMHIEaYZe+LQiVjt+a8AzPju+qOZ/NFi36Xv
         CbG6hFK44mrrytI5Z1k9cxJerYV2twnxV9GyI4my5zqudFIlsDv/wwtDu39zOoEQTiTm
         jF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746686918; x=1747291718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oN/u1yOXlCYt4DjjZZ0j855cjiGoWgslKBLO+dZCp3s=;
        b=s8mqT3rO7sDjy5rz1P4EjQRqFr3krkvAnvlTWEE/EYGFRF5YDB+9MXj9gJeXo09I8y
         M7FiAORNr0ZN4Q3e4fY2DD08LMENy/4bvYaajwgEP11zAIDHe2osNuicqwUhunlM36SX
         oxH/Wjm/IGA9Zd5KUXsv3dlumJn9+rgydDMmSCJrhfHOW+gHERyH7UJx5qMzMWNDF0UP
         YZFRYJy39i9gliKg69m1qglHaTJGTvyZAC14VgpAIXQqRaHObaPZH8ZtwfwGbvylYY+N
         cDxUwQ97IHOLvRPiSQMJH/aw43H4f65q8VSwlE9J1p2HpJenxdcQHJMXxunPD0lILp33
         C+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM27jhRV0+US3zV0wU9pplF9TY2MOkzau2f78yZfT4mVLHyg6BhGiCb7m+pntLbx06k2h3iWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzRoPrh/SsdH2fwc5KPBqIBkEuorpR+v1zdeKGjoPCoNX8aLSF
	uu4U2DVbtUcWZcu2YCaxcVjO6DGEtgqMiBdvaxaP9RIo7wMJsP3a+vRRMTAN+Ok=
X-Gm-Gg: ASbGncuG/geUKwSfHJt8dPHWAAkxvlz6pcZknsXNQcxYsNatpNwjjlHbRTH9LAvTCgE
	qEHuR16luxVkrq6h9OlG7SOh0NH/5Ms1VLZFx4b925OfZEtyP1hj3HHk6oWRjZD566ogvLrTGj8
	swt9vW7jy7mUWuLbeAtEbLGPNwb9hszf9qk+gWzrO52njMrmw5bucX3Nh0maEV3HYST3nwPsxkX
	EaawpYjG+2XD7SI3XSiBjYb1/G4VOePqWiPy+FrA/GbScW8IgAM2z3zJ49hlicK2WgbjmKFo+Kz
	r/XHhcN0gVQsz+yCaXQd/PxHiVW8wwbpPDwKYhmuMp+x1oZPrTmKnral
X-Google-Smtp-Source: AGHT+IGABSvZpPx8hobskr6H9QpVVUUq1xHoj+hrZLygN8wQiQyv3UOkrESVz2X/i1IQ9NOEjwb+4w==
X-Received: by 2002:a5d:64e7:0:b0:39c:2692:4259 with SMTP id ffacd0b85a97d-3a0b4a19281mr4086914f8f.21.1746686917754;
        Wed, 07 May 2025 23:48:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442cd38179csm25448035e9.39.2025.05.07.23.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 23:48:37 -0700 (PDT)
Date: Thu, 8 May 2025 09:48:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	stable@vger.kernel.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Marek Vasut <marex@denx.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] rpmsg: qcom_smd: Fix uninitialized return variable in
 __qcom_smd_send()
Message-ID: <aBxTwhiMelFjvrjP@stanley.mountain>
References: <CA+G9fYs+z4-aCriaGHnrU=5A14cQskg=TMxzQ5MKxvjq_zCX6g@mail.gmail.com>
 <aAkhvV0nSbrsef1P@stanley.mountain>
 <aBxR2nnW1GZ7dN__@stanley.mountain>
 <2025050852-refined-clatter-447a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025050852-refined-clatter-447a@gregkh>

On Thu, May 08, 2025 at 08:46:04AM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 08, 2025 at 09:40:26AM +0300, Dan Carpenter wrote:
> > Hi Greg,
> > 
> > I'm sorry I forgot to add the:
> > 
> > Cc: stable@vger.kernel.org
> > 
> > to this patch.  Could we backport it to stable, please?
> 
> What is the git id of it in Linus's tree?
> 

77feb17c950e ("rpmsg: qcom_smd: Fix uninitialized return variable in __qcom_smd_send()")

regards,
dan carpenter


