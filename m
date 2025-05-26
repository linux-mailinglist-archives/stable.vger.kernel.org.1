Return-Path: <stable+bounces-146328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B6AC3B3B
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4951748D5
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 08:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDECE1E633C;
	Mon, 26 May 2025 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VALR+SSJ"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275481DF97C;
	Mon, 26 May 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247136; cv=none; b=NHBO4XGJR7PPMHfXf9PEy0zcS65mi7suG/leSm9isCleO0MVPoIUpRRwBWAq0GpyVjvrsOSQ+Lf3K1Va39EeNN4Q1LbFHa7XgTG+ZluInIGMAVUDM1JauH4Q+yBNPs0f7tFOtlJDX/UGBaU3H/OQPrS3O8tN6IMYTNXsOwWU8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247136; c=relaxed/simple;
	bh=M7T0+D011hV6QFHPETqMmfJ9yU1LxuHKmv+N2IRha8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OE0HMYLtOmiMexGuwtGhG7Ci//xgZcgN0wU31H2fxZUVelRp3mJQLVEyP0vqAGG2fNMn6oYnPz5slCG97CHA/UbSU0lsTEED8+rsvhObpYtQ1/NohcrLt5kvKoJXgIUjE57hgItpcsIhB0sT6QUVllpLRJeD2Z6x1OcObaL/zuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VALR+SSJ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B610342DFF;
	Mon, 26 May 2025 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748247132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5ar1+ii+EEJg36aGo+is3ncJ1EKGEqq8suROqpajvc=;
	b=VALR+SSJ/mrK8uubAwfd02c0E4HinwQa3Fr7aSxh2mvFGRSNLT7oirBd3JBdl0XvI/I3ve
	2evkgdxzo/ok6EblNKPz8JAivojF0jfEoOaHHvsMM6gZ153NrNmis2Ih6WYiek0TF5Obk+
	9Osx6wN9VUphURRJ1Y0YBs+5kC2/gCXZyT5BVBSyqp1uqRTk0iB4Ix+CzG46DN6W6+1InP
	O/E8XOVgCJHzfMfIRQJvTkNMbod2JDgssODpznMUBg0438gMUwyOx5HZpNRqEXcs45lSht
	A4OsIziIr6c12taUyHJIck7wOISnWiIipl9sk0JfPb9p5UghhjUj5t2KZkckcA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: richard@nod.at,  vigneshr@ti.com,  wens@csie.org,
  jernej.skrabec@gmail.com,  samuel@sholland.org,  ruanjinjie@huawei.com,
  u.kleine-koenig@baylibre.com,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: sunxi: Add randomizer configuration in
 sunxi_nfc_hw_ecc_write_chunk
In-Reply-To: <20250526034344.517-1-vulab@iscas.ac.cn> (Wentao Liang's message
	of "Mon, 26 May 2025 11:43:44 +0800")
References: <20250526034344.517-1-vulab@iscas.ac.cn>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 26 May 2025 10:12:09 +0200
Message-ID: <8734cr3i5i.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujedttdculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehvuhhlrggssehishgtrghsrdgrtgdrtghnpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopeifvghnshestghsihgvrdhorhhgpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhhuvghlsehshhholhhlrghnugdrohhrghdprhgtphhtthhop
 ehruhgrnhhjihhnjhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Liang,

On 26/05/2025 at 11:43:44 +08, Wentao Liang <vulab@iscas.ac.cn> wrote:

> The function sunxi_nfc_hw_ecc_write_chunk() calls the
> sunxi_nfc_hw_ecc_write_chunk(), but does not call the configuration
> function sunxi_nfc_randomizer_config(). Consequently, the randomization
> might not conduct correctly, which will affect the lifespan of NAND flash.
> A proper implementation can be found in sunxi_nfc_hw_ecc_write_page_dma().
>
> Add the sunxi_nfc_randomizer_config() to config randomizer.
>
> Fixes: 4be4e03efc7f ("mtd: nand: sunxi: add randomizer support")
> Cc: stable@vger.kernel.org # v4.6
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 9179719f639e..162cd5f4f234 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -1050,6 +1050,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand=
_chip *nand,
>  	if (ret)
>  		return ret;
>=20=20
> +	sunxi_nfc_randomizer_config(nand, page, false);
>  	sunxi_nfc_randomizer_enable(nand);
>  	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, 0, bbm, page);

Please next time send all these "identical" changes in a single patch.

Cheers,
Miqu=C3=A8l


