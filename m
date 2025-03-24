Return-Path: <stable+bounces-125889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C204A6DA6A
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 13:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED3E3B1E11
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D180261369;
	Mon, 24 Mar 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH3BhXIR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6511953A2;
	Mon, 24 Mar 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820770; cv=none; b=a+aq/KvDYnrtwYsQPSeEvqTiDpwJQIBLNtD8VfGzt0klcQLQWmVySqhNe2weAvC5Ag2chds70/eQF952gZLn1xVVUOcb9cqsENwCrS/mcm/CSyuxNFYVDR8FO/o+RKrd1aSajcrk5C/6QtMidPu+r13D6YI2qmyhb1yL9J8n5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820770; c=relaxed/simple;
	bh=l0GeOJz16oW6SGdnb06/aK2t7USSqgz1qqgSmbO45sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1XJeTZ1ChdQuTrAd3aoD538hjMQClLHdxNuG24qPzoygQOvR0fp91BXedTsbMq9gWWdXG68R/XzzkBuSi5clNaey1QvyScwGoSVUTv41gAbEiPnlI6+Is5zU1AOlG9x9MXi1hLADRf+LK3ZIt73Moc8ANv1jtz6nmCEVPYEVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH3BhXIR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476977848c4so43697601cf.1;
        Mon, 24 Mar 2025 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742820768; x=1743425568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vme9H9wmsAwxUfbsVKtvTuLGOlzu2k2VT8Gp2wTq77Q=;
        b=mH3BhXIRtl1QPfnx97v36SLpDxHOTcYsM0cZOGnQgweIXyRsyY5UHRFLLK0hrXPb8q
         2/Em/SdL83o49UHoYkO+YAsXTRWrfXUEMtrUp+r8lU09AOMnX6APC8uG9MMwPPvhWIus
         pS70mn5A5KNaZFZWTSephL9wUWxovKIPsPzhXr1Y5e28MNk5AHhbevTOWsrCBnabO4Yr
         lYdZ2m2iq7jCdGjm9dNBBiQOTd3gBHGa5G+1rI3oD3sdMeMBazXXXDwRLVXF9By/8WUE
         6gLWbdaFYRIDvMZtqzGs6GuLT4/ul6uqsleVCi1fcFLEbokiPXXZZ+dKOyNnI6B5Zmht
         +KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820768; x=1743425568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vme9H9wmsAwxUfbsVKtvTuLGOlzu2k2VT8Gp2wTq77Q=;
        b=wzKAY9wePM7WCFz1gVLsg4gGRTZjGgt09UBTlkNI3RqH1loscXOsvDxoV8x385Qmym
         g92ah6VN8LSINLR79vDv0bq845Z9CSrE84M4cYvOyJg84+MaDjr++cv1hZ29gTClLeYt
         hRbpkX07jUTsJJW4vi96c9T+hakGkQGytpjojvUpgJQxuMKwLHc64Uz4mScdA//MG4OH
         OjqVSPUEk32xNExfqmgL7Wr5HvZkbUmboPI4O4UyOVSTf+k1Tw1UNEtplsUbdHZlZRfZ
         mmgx/1T+v6QSZzbaB+vTYqdq2Ph036/O+dPU1pJeTqwYEVAjYuvzB2VsZljo9mxBJVvo
         uOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWZsH4tH4bdBdv5QIdDMUKDrI3KrL5MzOk/9Y3cfbgZrrVoGk5mY+3dte2gBlIMddjWydDB60CWXx/1LvgcNQknS1CRw==@vger.kernel.org, AJvYcCXJqZx5joocfEbtJ+E9GUWlgvDDPIJSL60oOPTA98qdKZGQpiGbAg/BWEySQUpZBXgX19fLQufm@vger.kernel.org, AJvYcCXr7e0/gm3/eAz4dBhbF7gCfab3+arHFmM3iw35oARlVNCrIDmR2uRuY9x2+Tk9ot7ltLYL4bPwZyRHQF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6zk6l2psQaNp8QN9V41B3IwO4LguLR9OnaFtzpkr2do2GAFK6
	8+kjTg4MuLvaxPxRkPzbDfGbnVho1mmlxEqwBCJP0g3dS5HiwuT+
X-Gm-Gg: ASbGncs4aDVm0zBtyMVEbhszUEKqccwzVMy9Ri53xgPnXXvUdaH4HBSwSTQ7v+kwRJC
	PLPpVutDBtOOF1dKzCGP/vx48NhK6B3YC8RkuPZHbXE5SnXyjdbXBmsAeLcee/y8h+H97eca7XU
	1FmzAVhA81XqSIJhHmdWMMivokFlV6G3hausVL7cvIfJr19is20b8q4DgWNCUGT/i/5uCuYgOAr
	fHnLycsFlmF3IjiV1c1zu5mqwcajsfmMHoZqcVn3nFMuOAKHqbKFp1UiralNsZR5p6aEqn7Xmhn
	/aze6Ids0k3wDObrpVKL7rRHGtVS7bEraLhgZ65l1eQA/st7BQhVnkr8ajuQstZE3CmCO2HrirD
	C
X-Google-Smtp-Source: AGHT+IFBjEOy7vbR53CK0B/QWpq+o5gZGcznEE5+haT6GVIZen5thERBPa5VSCwyNKU9DrTsad2dHw==
X-Received: by 2002:a05:620a:4556:b0:7c5:61b2:b95 with SMTP id af79cd13be357-7c5ba1840a2mr1757424785a.30.1742820768120;
        Mon, 24 Mar 2025 05:52:48 -0700 (PDT)
Received: from localhost (pat-199-212-65-32.resnet.yorku.ca. [199.212.65.32])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b9348358sm507353785a.71.2025.03.24.05.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:52:47 -0700 (PDT)
Date: Mon, 24 Mar 2025 08:54:21 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>, 
	ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Vlastimil Holer <vlastimil.holer@gmail.com>, crok <crok.bic@gmail.com>, 
	Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>, Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: disable ACPI fan access
 for T495* and E560
Message-ID: <euxpp6zdhlpg3eutc3omspt2exmsyulo5ytbpbqwxovzcy6xey@fuuhsp2agtrx>
References: <20250324012911.68343-1-ImanDevel@gmail.com>
 <f4567e02-8478-682f-0947-765ef9258ab5@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4567e02-8478-682f-0947-765ef9258ab5@linux.intel.com>

Hi,
Thank you for your response.

> > Tested-by: crok <crok.bic@gmail.com>
> > Tested-by: Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
> 
> Did these two person either give you those Tested-by tags or gave 
> you green light to add theirs Tested-by tags? I don't see the tags given 
> in the bugzilla entry. If they didn't yet, please ask if they're fine with 
> you adding their Tested-by tags.
Alireza Elikahi gave me the green light to add his Tested-by tag
after testing on the E560. I haven't reached out to crok yet, but
I'll send PATCH v3 as soon as I hear back from them and get their
permission.

Kindest Regards,
Seyediman

