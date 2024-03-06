Return-Path: <stable+bounces-26913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7C0873063
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456CD282D18
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480465CDFE;
	Wed,  6 Mar 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="hcmvYpWq"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA285B1EA
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712939; cv=none; b=PUumF4yRE6KxvacDDRWYlmKwkphhotxRbzZnNHJb+CidObOXeZ7H12OfAaFFa9HkfGkQYdh3oVf/4ZVSmcHgwAJkpg3AgI0bRA4M0TcEKX5GvMXH+BpK1gTWA3S3bnHKLJHu9tpZ450CNkoVDSUZW9wiJ+Ipb03kgrHhUiXgwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712939; c=relaxed/simple;
	bh=kuIcTGLwOZErPf8b2yIdBJP+0ZEw/WDW0R9rZ6+4nmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuGOH8VHYBN49ln2Q6PHg2nRRkWr3y9JXkKaWPX+ZOhW1n9H25yAb/C1V5TxrV95+EEdJTkKcWLFCuH3ORgVm0VsgUNXoqIkYQAPRCfWrY7dlPuLwqpFpDt44eoS3JI00eDEFF5L4x0HwWZSFsD1FdWwByxDxKvgxaiJlkkxsFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=hcmvYpWq; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=hcmvYpWq;
	dkim-atps=neutral
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 576D34AA
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 17:15:30 +0900 (JST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e6512d43daso52209b3a.1
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 00:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1709712929; x=1710317729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWN8aeGqlV2ux5okD9VzvqXOF7Q3jr/QQJsicRZ17gQ=;
        b=hcmvYpWqT9o8xVqPxn8ALmPrqim2x/3CG1AVALKVuKbOzqlCO/PlhFAsfkcR5b3n6x
         QrXVH7AHGGfT26PU67ujERF7P8uZHyCcaN6ykEOxN6ZJwHh2BKFLyL37pMKjrY2DYcOE
         HINuPmbQCgchWF7OKa+rRu/66nsWbFBTq9XoL6W1uaRTwEl5yT3Gxl+OnlC6cBoeFuAA
         aXVH0Si8YjgWYXAPSTmqxsyASA2TTSn0SHgx6L3IHNcERTa1rYBNfR2y1QTh8pD9fV8d
         XjN8WY5vtWrnssr/UoXKunBcd1hguASxk6QncqKRX7oOffLRtR7/KPO7EOiIFwSf77Fg
         wUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709712929; x=1710317729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWN8aeGqlV2ux5okD9VzvqXOF7Q3jr/QQJsicRZ17gQ=;
        b=WASF+DSJ4zQEaS2FARoSqACpwokNoIzFs7pjYuN7TiFn4yHLXAlEFPmi5g2XnWpQVi
         FfmV1kETMP8qv9PqBXJG0LF6kzxd3F57j0fReSZPn/87zxv/dHKCHpt8OOEuPXr+7cJq
         fk8XTnmIpNiakSHp6+u9Tg7sECoY7fM7CO2emXeQYVjEi+NKVnuC18Zk2K9hy4FD45BX
         TxCjLS7Yh+fRjiaW2T7TH1ddWsluoCOzzXfhOmq2c0SsP7y/OJbjykBiIpOePQ33knRX
         cNywlpjRstZLwqiBQwIp0H7mkh4JXmfVVZMsOy/iGvtlu2IGEbcUVe1Fs82yOXBBbOKV
         aaUA==
X-Forwarded-Encrypted: i=1; AJvYcCVysHHl7VfoM6SSj8Np3zJ78qCw598WvyOCKlaxzaMIRet62bYFqQulNNoR38pW8pHqZs/iLBG1IB8Eo5vIw9uztUYKlL/p
X-Gm-Message-State: AOJu0YwyqaaVyx4iaP07GTO1McI/mMbcmEtwOsA6L4vcbywLeGEd1jSZ
	N4MsdfocnOf2tzyH1BfgrHUEBcmjArDtA8gWu438Ml+OvVU6Arx4tEJU3jzx9oi3oDsNUXnVRVC
	B2pni7PvWzIicGKchSoRM4ZLJzrLf3d0Pb633E68MrwuYKTnPDxer4po=
X-Received: by 2002:a05:6a21:339c:b0:1a1:4eb3:63ce with SMTP id yy28-20020a056a21339c00b001a14eb363cemr5755556pzb.4.1709712929350;
        Wed, 06 Mar 2024 00:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNjWF7ePYRhNAEoKXtR6DlJ88neTb/+vtcNm81O2YILEL3J+4R7ntYBgxkijCYEjuy/zQbIg==
X-Received: by 2002:a05:6a21:339c:b0:1a1:4eb3:63ce with SMTP id yy28-20020a056a21339c00b001a14eb363cemr5755525pzb.4.1709712928785;
        Wed, 06 Mar 2024 00:15:28 -0800 (PST)
Received: from pc-0182.atmarktech (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b006e583a649b4sm10206885pfn.210.2024.03.06.00.15.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2024 00:15:28 -0800 (PST)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rhmQw-007TIc-1G;
	Wed, 06 Mar 2024 17:15:26 +0900
Date: Wed, 6 Mar 2024 17:15:16 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
Message-ID: <ZegmFOnrLk79Oacf@atmark-techno.com>
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <CACRpkda4pVotd9Fc2Qn0Ae=89sZR7-rXDiZ7OdHE3eDvO=049Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkda4pVotd9Fc2Qn0Ae=89sZR7-rXDiZ7OdHE3eDvO=049Q@mail.gmail.com>

Thanks for the review!

Linus Walleij wrote on Wed, Mar 06, 2024 at 09:03:45AM +0100:
> > A couple of notes:
> > - this doesn't fail on all eMMCs, I can still access gp3 on some models
> >   but it seems to fail reliably with micron's "G1M15L"
> > - I've encountered this on the 5.10 backport (in 5.10.208), so that'll
> >   need to be backported everywhere the fix was taken...
> 
> Which device is this?

Sorry I gave the 'name' as seen in linux, the actual reference is
MTFC32GAZAQHD-IT
(but we're creating the GP manually)

> I have never seen an eMMC using the GP:s in my life.
> 
> Or did you create the GP manually?

Yes, we're creating them on all our devices:
(japanese only, but you might get something out of google translate or
similar if interested: https://armadillo.atmark-techno.com/about )

I'd be hard pressed to explain why other than "it's always been done"
and I've been replicating that pattern, but as far as I understand the
gp partitions are always created in "write reliable" mode so it might
help a bit with lifetime if the main area is left as default.

We're using them for rare, important logs and things like that (minimal
trace of updates, hard reset etc for diagnostic)

-- 
Dominique

