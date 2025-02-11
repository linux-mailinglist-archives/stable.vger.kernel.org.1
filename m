Return-Path: <stable+bounces-114953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91DDA3155D
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 20:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BD1627F0
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 19:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2A326D5A9;
	Tue, 11 Feb 2025 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji8JsRAe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E12690DF;
	Tue, 11 Feb 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302001; cv=none; b=BK1noy9g8OSkyr4Ch8/E66G2VwRTFW28T9K/N/0aBe/q8wpnmFIwRjwQGpmuGQe+DbHup1aQZIvVLcxgZ12IOUv3JDYeyiaN76PjVPyINfH+V86reO9T96knedbASs44j96dYfHJbYoifkIfyARSMCV0MEntCF92EajSCQ2DOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302001; c=relaxed/simple;
	bh=zY11n/8locnzNnbkUCvqokaSEOgtoe+VYyolUrGzvFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6/yQ3lcVT0yl4y1woVNZjLwXjHTSMgedxI3tjT1zU3pvq9b2lqWRHQwZpn10Vpyn4GEjXtti+/zcsOQcPgHESfjua50LD/6zlBMQjOZ4eaVXu7OgpE2F/2+OPOJaQcvcWofEXiVa9CPc76IHe3YtqwD2tawpRhmqizB2nZIruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji8JsRAe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd93ace00so1712376f8f.1;
        Tue, 11 Feb 2025 11:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739301998; x=1739906798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHUiGt2p3SNBSvSE4F77dmu0tTDl367av9kzRSudXp4=;
        b=Ji8JsRAeKf6ee1r8oKkq8W5INpTh0fz1BO5t6uiPEGT1plPxWOVuhSFITnpkbS02rv
         BQocHsGGsTsUzGVRk+wp1Mu6BFaLhECo4W3VAK/J69E9BOJ8+92ocdc+G9qS0vk/UBkl
         nTUoeBBi3EkrWQChWakj+Fw0t1+utVsoUbFbhUYookPyRDxZnj+yWbglt1pBCR7u7eb7
         hbQN38fIBNqXqXjl3k0sFcwosXwLc6EY1oXDNlXOry1mOtFqWSNK5hgykuGcnf1kmUe6
         ZRkxAGxzSl3gwyld/jK6Jn5gpZsWEOJxS/2kzoS3DHlC6xybeXFpNQoNYvs6vvbadDym
         YMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301998; x=1739906798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHUiGt2p3SNBSvSE4F77dmu0tTDl367av9kzRSudXp4=;
        b=ljrFPngoUB0JhXwnTnUsRHEbx/0X5HZ/JNkXP2Xt2nom0lU70aEimBoLGceCi8L2ky
         2C4Vi2aSYnU2hcKMVMrHPXrfCnp4zY6571HWInP7kPx/mVtNm82rGJU935pQhpEABLrP
         CN+4v1/xG0KU0KSF2uvEn94NNcjYBC3hC2WkwcuBFJ52Uqk5opNNOK8Wik85dSieIhCF
         d+lupNsfS/Nz+GuPJcc2yk4r5W+OZ4Md/QZ16WJ997TmMQ507SzFla+MckQkZ3ZviA0I
         B2bdSCyndqSHgln3D5MyyqoOo8jsxB9/1aV2G/8Y3eth1xSw0JwMLZ47i25AzqzgLrPt
         7pnw==
X-Forwarded-Encrypted: i=1; AJvYcCX9+fp5z5WYCmlPlOisqj6+ixE+TszrfKAIHTrsMpBnaKM5eJik4n+L/V7ILSz0BMsauDuGZCX9@vger.kernel.org, AJvYcCXUi/aD9d55kglBlML02KuWflXI6F5OlHZQ8e5Ts2DD8ItoiXNELbhQcvKz2ruweV1430KazxpRhaiBy68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9O5/HdOWjvUTHTkZR1SCxA4SJbz5ZO+n3rVKUa2aiLoTj53e9
	gO8P2VmggajRxjiceSvTb0pachMJQUv9O8r71bVoq3tMC8qVTVZa
X-Gm-Gg: ASbGncv0seKdjuL3klCPfF3Cex7WrbMloKwAGFhjl/25oDHdpUMoPfpuxLupFcxrL4F
	aWD6+yKSOnTIFQWVZO1qBLM2ZZDtEDTRGpTF4nsqbECxmP3qAhhWuAX4xSny1RgMHolTD1Uo4R2
	6GkEnsGfBrVcze+HxMJjm3LjBbeumiW2B524BMN3vGfV1R8T6kBMmfosc1rF3T4RyARWcwSruvB
	iQ8NzhtgsAvxMBIlQHE9PDZyRYwVkBj4yAIteZlR9LUBIPIla6Woh/3eymQgR8rCBAwqX9QgPWE
	Q+NszqlU+ECsDAQ5t/PBpmfxBsbqNXYbZXDIRwQxyF0RwoML
X-Google-Smtp-Source: AGHT+IGyH6u7C+JHOMK24CSqsOZoQFhGFN1iCccM/JmeDZM3j0hw0pWZnQFg6iEPrhN9OMVzP5k3xA==
X-Received: by 2002:adf:cd87:0:b0:38d:cd8f:db00 with SMTP id ffacd0b85a97d-38dea28e259mr153109f8f.32.1739301997477;
        Tue, 11 Feb 2025 11:26:37 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcd0fac67sm12549012f8f.54.2025.02.11.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:26:36 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1230DBE2EE7; Tue, 11 Feb 2025 20:26:36 +0100 (CET)
Date: Tue, 11 Feb 2025 20:26:36 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	Radoslav =?iso-8859-1?Q?Bod=F3?= <radoslav.bodo@igalileo.cz>,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Subject: Re: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add
 alignment check for dma buffers") when booting with Xen and mpt3sas_cm0
 _scsih_probe failures
Message-ID: <Z6ukbNnyQVdw4kh0@eldamar.lan>
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>

Hi Harshit,

On Sun, Feb 09, 2025 at 01:45:38AM +0530, Harshit Mogalapalli wrote:
> Hi Salvatore,
> 
> On 08/02/25 21:26, Salvatore Bonaccorso wrote:
> > Hi Juergen, hi all,
> > 
> > Radoslav Bodó reported in Debian an issue after updating our kernel
> > from 6.1.112 to 6.1.115. His report in full is at:
> > 
> > https://bugs.debian.org/1088159
> > 
> 
> Note:
> We have seen this on 5.4.y kernel: More details here:
> https://lore.kernel.org/all/9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com/

Thanks for the pointer, so looking at that thread I suspect the three
referenced bugs in Debian are in the end all releated. We have one as
well relating to the megasas_sas driver, this one for the mpt3sas
driver and one for the i40e driver).

AFAICS, there is not yet a patch which has landed upstream which I can
redirect to a affected user to test?

Regards,
Salvatore

