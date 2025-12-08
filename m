Return-Path: <stable+bounces-200361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98113CAD88C
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 16:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 713E5301F264
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663724677A;
	Mon,  8 Dec 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ifC3SRLX"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598C15CD7E;
	Mon,  8 Dec 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765206732; cv=none; b=nekcz6M6wsCjH7eHAOZMKVQgrgCmq6P5zmYLSF31KDp5t7AUNdP+TbhfLmbhwaFMPWxapoHH4MfLaGiVqnyVDoRlK3pYwOQ6aU7aDiKNpPXjZi1TeNRphmPA5juDl/Hexz2wp6nquGHAfjDvnpOBbRFPF8zzukeDMStb2/HBhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765206732; c=relaxed/simple;
	bh=9fd8on0sWsR+/Mz32IvXebQnxgwGaosrWmNNbbTqvlg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pt1ZXEUElThxjmTNOcJWZnweKTLd9GXk733xYYZNMQN6bRWyq8lujLvHqm5+blNFNEyLFbq4UKslEV2cZ9+SGKjXTWxmX5BKyfl6OLjPGtTvtGzWbBp3YR1EEg1gVJgqIg7OkN/FHhsmW6Zs6qYF7TzSLAxbc6njftmeCI1SrUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ifC3SRLX; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765206674; x=1765811474; i=markus.elfring@web.de;
	bh=giF+OBbi8CXEOWJ01FRk++G4kAEFRu+LoLGT8bUfVa8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ifC3SRLXvKOklUrvKeAD1uWad2lfBqnpuRfnIl7S3bcb6PkECDwDFAYrcDY6MvqU
	 BwpY0WfP8hBI7ukn1OI2RP4z4lpuXGUpBBI00XBNsr1RW7bMOApmisemNdarF/o8Y
	 br8eME2o/tjWTCCSRKutFhrEEq2JV8ya7lTulcX9VD6o9kfW4wYzW87NHL3bv1poI
	 kouo6sfec6TR1KCVODfeQl3k7EHB/pZ4Z0TNLm3Di5DD01+5oeQQ5rU89+I9MPDK7
	 r9Hg9c+YN//E+cj9YDUg7lQ4iZ6mU65kjUVVM+TS13shNfPjzyVcwm1SxcXxqlxOc
	 9swfdH6d6iqYbd7pgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.237]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1veg7y2Lw4-00Qjbo; Mon, 08
 Dec 2025 16:11:14 +0100
Message-ID: <2c9af5ae-c250-4760-a9bb-aeec61c61eb1@web.de>
Date: Mon, 8 Dec 2025 16:10:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-fsi@lists.ozlabs.org,
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251208033606.10647-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] fsi: master-gpio: Fix reference count leak in probe error
 path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251208033606.10647-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0bdjpkgo1gEiDS1P1PFvr9pGURFq7p3D4lL3KY/8W4EUGm4+rQi
 DyBpQt2pGicM4NynwS6TeGPW5dngtNV0ZjHuRwtGsyOoYl72gOCK/WLGCmcxnEkzufHMRa4
 agf1hm6BgG5HL6mosZBW6+pYgyLgMQdjVT8SBSiO07LT5Xwxcz4V/EWD2kGEUYbtcl5evEA
 ziqqhlkZSMhDYcL31z9vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X5qp+wK+Zag=;kmzH+0kRelzwu2k/fXZ/ypDAY/9
 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
 Nph6VEa9VFlHCsnZj/2rvtm3bOssyGxOMB2apP

=E2=80=A6
> Add the missing of_node_put() in the error handling path to properly
> release the device tree node reference.
=E2=80=A6
> +++ b/drivers/fsi/fsi-master-gpio.c
> @@ -861,6 +861,7 @@ static int fsi_master_gpio_probe(struct platform_dev=
ice *pdev)
>  	}
>  	return 0;
>   err_free:
> +	of_node_put(master->master.dev.of_node);

Is there a need to rename the label accordingly?


>  	kfree(master);

Can it be helpful to move the statement =E2=80=9Crc =3D PTR_ERR(gpio);=E2=
=80=9D
also into the exception handling of this function implementation?


>  	return rc;
>  }
=E2=80=A6


Regards,
Markus

