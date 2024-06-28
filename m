Return-Path: <stable+bounces-56094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC991C650
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 21:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817EE286045
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 19:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C971B54662;
	Fri, 28 Jun 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LtaATfW9"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BF6F2E2;
	Fri, 28 Jun 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601403; cv=none; b=QJAL2jJ+NhNyraiRisRnPVWLqzrAJ/4uxkFl7k4LZg6a3YgwL00ma5ttkpKb9lYubxz5vSoa4umteFq80lHHAHFSCxm9S0XEetuc/Wf9nl0ZJ8vKLqX2OjIWhATAto634VTqE8eTfQc6SkgyLojHk+K/nWf+PINvdtGTuU3sGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601403; c=relaxed/simple;
	bh=0uICK04EcBkilneERG6wnrmIvJb2XbKZRvZwWeRJhBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qA8l1WZp5sT0NHiNaPrYUP06iJEZgncoouK0nu6z80U61AKiAa9ZvMYXImbBSoori6L5rZvXfnVbq5wxWUfloulE4dOWCxXfn/zstotFa4XiEP2nNBrrsj2uofIeKiTFe/IDp9blsgF7Pe1UDCOiDmF+VRF4qzD8jcNH1CdAvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LtaATfW9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719601374; x=1720206174; i=markus.elfring@web.de;
	bh=ADjl6HYwPE4fmEIQRqZxfeS3MwMxTa4HLg75Y0SxIFQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LtaATfW9wk4gLt6AZc8vHwCfOgU6s3zVo4STy7h3Y3tsOzAPevLTAmIzrQr035WT
	 Cfm1OdKUjmhYC2Ue8b9XYuq6wiCewCb8f0pzrIvF3OTKW8Cy4dZwd5Qxd9KlWgdOc
	 I8uHIs1P/RRog0nb1RVbqqM9uTJ9b7wU8TODdjU0H1/Zm+txlFANPOsHPrBFcfO+Y
	 9z9TSJ96Y28xhZk/aCOH6TdSHyh8hIRoQa4KHRUaV0iSOqjOgpe895KvcQaCTDjmN
	 Rlj16sCmD3dnIdHT65DC3GJW/JaEDcBkq0X59wIf1Filnk09/uU7vEcbt4CsMcV4q
	 8Dw0phVkG2t9tRiFkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBSB3-1sANdp0e6R-006WI1; Fri, 28
 Jun 2024 21:02:54 +0200
Message-ID: <c41b19ac-6bf9-4f30-8c00-0cf63246d825@web.de>
Date: Fri, 28 Jun 2024 21:02:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] drm/nouveau: fix null pointer dereference in
 nouveau_connector_get_modes
To: Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Danilo Krummrich <dakr@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Karol Herbst <kherbst@redhat.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 David Airlie <airlied@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Julia Lawall <julia.lawall@inria.fr>
References: <20240627074204.3023776-1-make24@iscas.ac.cn>
 <d0bef439-5e1d-4ce0-9a24-da74ddc29755@web.de>
 <790dbe8aee621b58ec0ef8d029106cb1c1830a31.camel@redhat.com>
 <a91bbb5f-8980-420b-b465-97691203347e@web.de>
 <eab9d109981bae8a443649bc4a2c1a08870590c7.camel@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <eab9d109981bae8a443649bc4a2c1a08870590c7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fNjEYGC1kGG0cm10RiO9/XQQ9wQYz9pp73x93aPWF/5vpTm2dxu
 Z37o/+6CdBZor0CYYoxPRzNdzOGjsFWfOIEZyFaU+FnWqDFs6aGw0ZiSHj3rtCMDFh6FS+D
 +3bLFoj6RTUIF3Ud4Ol0fz77ZNr/Gq1sEOIcthHm3VXkQ2RMoGxWBmX3FbfqemcZ2Yqnbnq
 wnBUevXfqGIFrkM2aw2rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mlv8LWiymOc=;rEVPoNl4k/tPhkPXY7S3RXvPTAV
 95mFDZ5dxJeItnSc2SPxs8FQL07nWI7/E/XXy3/bL/jyUUajobe+g0TPZS939tzv2nwut5FzR
 hqmuJlG+chYGovLStb5X2g1939vehPF5RvqCrhB2FFCCg9jpptYxcrQopR3+dYbaSVIRIkTlf
 VuPGKznOjJ9K1V7QIC+DZoSi8Rbn0qvsL0q4MMLOwaMi0Xs53lTp7kQmL8kYZCmsYUtGW2+Q8
 zR0FaVIq94eyzjmCqb3NE+rLmQ9+IFuTwgEHQM82xrdqRmc70pyN/xWuZFAHPdDsgeCkhCWaR
 Z8nLm1mzun5FlgEOrDQZF6u/8GGfo1u98QJwvzjq4zysmgMX396/jv3SKrNSL27vyqyUN1IhH
 c48D4SkHE2eDQESRtIGOGDpdY9o5m6zPb894MRpkKW/TksY7Ro6r7aIdxQryrHe6aQPADnQIi
 jpp6t1ju4xVKTLzclUc2W46j80f1+AW4QjDsZF+9xAMEyA7G84z1CK+xRSvIEy73mytPw53uo
 WHZ9Niu6ynFxWHJdBppZEu5/g7Y+AdH4wqwfCHDAnXX2sWGGpQiTLdPwu4h2D27rTRefl5I9n
 2eVUTNUTbzBmToGUNALfImfjbSvVOGI8xIgIULAhjy49xqqu4+6u7eqOCm6itW/GRDxQ/P5AV
 jbtNDHIS150dLkJ29YErJEWKhOAnvvhngKqSy1qn4JzBDmKGq+tE+q4NrfIvRSvIt0P+IYhEC
 Gtowg+yvSSPpSjawlqe7UwrI+bUxXkTbnaXYj+x4ZSDjWIpF47LiysjxonTX+4EeFvRT1svZU
 9p4I2Iwb4GKo6tgpAx8W+pDefiomkcsOZIfQSA96Tfw2s=

> Because the responses you have been given read like a bot,

I find it interesting that you interpret provided information
in such a direction.


>                                                            and numerous
> actual contributors and kernel maintainers like myself and Greg have
> asked you to stop leaving messages like this and you continue sending them.

I hope still that further information can be handled in constructive ways.


>       I promise you, maintainers are more then capable of being able to
> tell a contributor when they need to improve the summary they've
> provided in a git commit.

There are usual possibilities.
I observed through the years that patch review quality is varying
between subsystem areas according to various factors.

Regards,
Markus

