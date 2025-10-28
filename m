Return-Path: <stable+bounces-191474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B8EC14C37
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4874D566A48
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C733032B;
	Tue, 28 Oct 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sSmUYYHE"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6111F4C8E;
	Tue, 28 Oct 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656744; cv=none; b=pDVc1EFjDd8ujuc0tvgI9KkpC1pygeXJPqeAUpJ+Ca6T+cMCikLTc/FuYtAMsY5zH15dB5xHe3yB8m1jjfJxGxxcCkY3Xlri1B20y3WBZ3Az64buvZnCxtciCBGsqCXT4XRmSvFcL9m18W/x6zD0eDZ4RZFo1BhsE49Wp6yzP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656744; c=relaxed/simple;
	bh=oblVEJw19kd3V+RC5737pJlRfPFXsR3YSGpz2cE/KRc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bxUi/5fG+380mD3qmUSjIkuFjXqvEdOBbAU2N8l2nXBOt3iaR0vu26pHhlz/89lFDpW7CDiTU4hmgMIzsvNerQ1o8yiKjC1dZm1E/LI97dMh67jpZI7fh5GsUO2Bn+DFSE8oUBalQgtEsQjgA7vKXTVtEHeMuyxA/YFVbJvWIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sSmUYYHE; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761656715; x=1762261515; i=markus.elfring@web.de;
	bh=oblVEJw19kd3V+RC5737pJlRfPFXsR3YSGpz2cE/KRc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sSmUYYHETdxKKRioTgaOfdyqJt/Ui8zDUuTWYUHQB9xjX74DxoNFlpf0jTPVw52/
	 d84uf9+zaJ/QeiwG7iSziRJh1aGMv3XX7lopTXp/nvsu9MvrDWwTyZMxEyWPHTJRa
	 CiZeJoTDU5oZ39yK0ywtw0qcrStJhXkC26kXb2CRgN8IrM1zdDXnQ8TYlfxL0E2hr
	 ayO5sNsgHWp0LU1Wsns3IZn3rKzSolwtXxEfZtQxAAiJRazpAmeDqEHS0RHGE7g+k
	 0kbtg4HpR5xABmVK32PNL/nQC9mzP9/l6TG1VADXhBbZH87W6Ejc2uXZwK9h3Y09V
	 k7x2iNaaJd5yQne+UQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HKG-1vKIxn2S76-00CyKG; Tue, 28
 Oct 2025 14:05:15 +0100
Message-ID: <1ea5b423-365f-46fe-94f1-ee248ad6b307@web.de>
Date: Tue, 28 Oct 2025 14:05:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>, iommu@lists.linux.dev,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Rob Herring
 <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251028063601.71934-1-linmq006@gmail.com>
Subject: Re: [PATCH] iommu/of: Fix device node reference leak in
 of_iommu_get_resv_regions
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251028063601.71934-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:37WBgU3x/ii4dwV8P7dMk91JvIMx9tJjp4DoPc0A2tX8yy5xe9+
 4PIIbXvg8IF3w+cu7J5EQpgT53z7VgssXm07hrNFtTy6ZvXYhXbN9ei2O1CUCBTDwVDxeKS
 oPcd2kr8yA2oYr3d/W6rHK7V1valsiVwthxW+Yw1LI8h36svJBOFz8gZ3YVtgczaxm0LnE2
 gn48+BxzUaTQSBT2sxb9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DxvGRryXlxE=;Bt3yInbtfXawGQ7QEDuuuWsPllV
 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
 kzePM8LHUBAZeuEr61Lf2CQmdVGH07OfCGg=

=E2=80=A6
> Add a call to of_node_put() to release the reference after the usage.
=E2=80=A6

How do you think about to use the attribute =E2=80=9C__free(device_node)=
=E2=80=9D?
https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/of.h#L138
https://elixir.bootlin.com/linux/v6.18-rc3/source/drivers/iommu/of_iommu.c=
#L196-L271

Regards,
Markus

