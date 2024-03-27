Return-Path: <stable+bounces-33033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0988F1AF
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 23:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4B91F29BCA
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1601153576;
	Wed, 27 Mar 2024 22:15:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 3.mo576.mail-out.ovh.net (3.mo576.mail-out.ovh.net [188.165.52.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815D150982
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.52.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577718; cv=none; b=IKP91zpBBY6xwzCdG7ik68AfNlJ4cf4jU5MOVXrhu2TJcYtFY2g88jctai9Vb1g25dusxirBZWkgqwfqLfa1FzBcdmUIv3JIIAQVWmhy4LgBwBgwOjn+VNj5Z5g1/VGfxHuu5F6asjtdR4wQhfmTc52UWixdxtuOn2Z2DBnGm5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577718; c=relaxed/simple;
	bh=uubMJfEGsx1wHMfNv8O85cjpX0Z4oxTc9ge4GrdhcKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QH/2UeOcJ29K4R7LQBOeivo2inlWvRxkkp+4uiwhvIn070EPHLxzfbhwyYRva2ImlFnKy0pIGa8u55+r9DFSAwwugFJe0kydjn2H0VXFLmWcRM2oyjjvrVgjV4YEFBXJPPb+Q/dbvowIeCLQOM2xnUpKmETErzIg9ok93E5+vFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; arc=none smtp.client-ip=188.165.52.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.139.191])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4V4gvv0xdcz1j6G
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 22:15:07 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-xfkn4 (unknown [10.110.178.52])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E1CF91FD2C;
	Wed, 27 Mar 2024 22:15:03 +0000 (UTC)
Received: from milecki.pl ([37.59.142.107])
	by ghost-submission-6684bf9d7b-xfkn4 with ESMTPSA
	id gjE7MWeaBGY6QxIAbVqslg
	(envelope-from <rafal@milecki.pl>); Wed, 27 Mar 2024 22:15:03 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-107S0012491a7f4-335c-4194-8bbd-5f1ada98fd90,
                    AD8588E3BB83D84E59DEA8CE8674EAB20989D6B2) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:31.11.218.106
Message-ID: <30bc0d38-b610-4397-ba42-46819d5507fc@milecki.pl>
Date: Wed, 27 Mar 2024 23:15:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240322040951.16680-1-ansuelsmth@gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <20240322040951.16680-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11126987304968301369
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepgeekvdfgleeuteeludfghfduvdffjeekhfehteefvefggeelheeludeuiedvueejnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipdefjedrheelrddugedvrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht

On 22.03.2024 05:09, Christian Marangi wrote:
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 5887feb347a4..0de87bc63840 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
>   	config.name = compatible;
>   	config.id = NVMEM_DEVID_AUTO;
>   	config.owner = THIS_MODULE;
> -	config.add_legacy_fixed_of_cells = true;
> +	config.add_legacy_fixed_of_cells = !mtd_type_is_nand(mtd);
>   	config.type = NVMEM_TYPE_OTP;
>   	config.root_only = true;
>   	config.ignore_wp = true;

I think there may be even more unwanted behaviour here. If
mtd_otp_nvmem_register() fails to find node with "user-otp" /
"factory-otp" compatible then it sets "config.of_node" to NULL but that
means NVMEM core still looks for NVMEM cells in device's "of_node".

I believe we should not look for OTP NVMEM cells out of the "user-otp" /
"factory-otp" compatible nodes.

So maybe what we need in the first place is just:
config.add_legacy_fixed_of_cells = !!np;
?

Any extra limitation of .add_legacy_fixed_of_cells should probably be
used only if we want to prevent new users of the legacy syntax. The
problem is that mtd.yaml binding allowed "user-otp" and "factory-otp"
with old syntax cells. It means every MTD device was allowed to have
them.

No in-kernel DTS even used "user-otp" or "factory-otp" with NVMEM legacy
cells but I'm not sure about downstream DTS files. Ideally we would do
config.add_legacy_fixed_of_cells = false;
but that could break compatibility with some downstream DTS files.

