Return-Path: <stable+bounces-116444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C3A365BF
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 19:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A5A1894E25
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248715CD74;
	Fri, 14 Feb 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PJeY04CD"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63651607B4;
	Fri, 14 Feb 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557943; cv=none; b=Oo1/WeqlOBu9EckK+oIP89eZVRI7P2nyHimhJ4rZME2fBqR4NxGvvy/BG6IN+qTf8W8MR0rMR83jFZpUtAnAtA9ED5e2SscHWJ6bIeoOWOb4rc4zclR6gv4y3G9u6BjVBZPZ76OI7Y/d9HHCW+Rxkh/AtpdXhP/nY8o4fV0dFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557943; c=relaxed/simple;
	bh=Ez2WPdB7sbcrGoEMPpxjCiPVXJYs+4fxoqkCiiIfhko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTlq9zrHchjEknG69fsY7uOvdRuRmx0tJ7bGNlGpt9z7VrWBjaBybY8Rm/uf7pbJJqN+Fas5+29JLnoUuTuFiclVjihEyYBIq/mskBqIzcOWQ3GkH35trMFDTsDxWOpls4FutQscJ4UQOcengUFAcseb8VvearvGz91JdgunndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PJeY04CD; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF1D443147;
	Fri, 14 Feb 2025 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739557934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/LVaNtaF6lM1ysdLnJydaXHpyn1kIjoK7UiOQfCmaWY=;
	b=PJeY04CDbX3dy9gEg2lL2dLUTVXQvkK/dLHnSOzoxVI/p3NpOIiJUIuNFBW4c5pvYXuRj4
	xgFKfsqsLcv2P8e0sW/FJeTqfO+idxcGzc5wnW837qfMhV9BOkf4XnvY01h/ob2iqKwOl1
	7V7dymut0kzp5mobiI00A68nF220THUpFuqicyP3PA7Xw2f/xu/GF22fezNYCLYoN4MvZR
	MDK0rSnM7F8fu2FjkOJ8udyJI12eeapr81zf3LM/zgKdf4t7O/KwiM+Fbzqc8ZeVXgcuRU
	Lq+RnzPo0pfLE831/QRXs0tIrzasLafSMizSVw+Pfcg+lRQacr37a70A/xYV6A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <richard@nod.at>,  <vigneshr@ti.com>,  <quic_sridsn@quicinc.com>,
  <quic_mdalam@quicinc.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <p-mantena@ti.com>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spinand: winbond: Fix oob_layout for W25N01JW
In-Reply-To: <20250213060018.2664518-1-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Thu, 13 Feb 2025 11:30:18 +0530")
References: <20250213060018.2664518-1-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 14 Feb 2025 19:32:12 +0100
Message-ID: <87wmdsml77.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvteeffedtffeiveefueevjedtledufeduvedvkeetudeftddtfeehtdevhfdtgfenucffohhmrghinhepfihinhgsohhnugdrtghomhdpkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepledvrddukeegrdelkedrudeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedrleekrdduieejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepshdqkheisehtihdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhiughsnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrt
 ghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpqdhmrghnthgvnhgrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On 13/02/2025 at 11:30:18 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Fix the W25N01JW's oob_layout according to the datasheet. [1]
>
> [1] https://www.winbond.com/hq/product/code-storage-flash-memory/qspinand=
-flash/?__locale=3Den&partNo=3DW25N01JW
>
> Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND =
flash")
> Cc: Sridharan S N <quic_sridsn@quicinc.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>
> Changes in v2:
>  - Detach patch 3/3 from v1
>  - Rebase on next
>  - Link to v1: https://lore.kernel.org/linux-mtd/20250102115110.1402440-1=
-s-k6@ti.com/
>=20=20
> Repo: https://github.com/santhosh21/linux/tree/uL_next
> Test results: https://gist.github.com/santhosh21/71ab6646dccc238a0b3c47c0=
382f219a
>
> ---
>  drivers/mtd/nand/spi/winbond.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbon=
d.c
> index ea11ae12423f..41cd0a51e450 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -134,6 +134,30 @@ static int w25n02kv_ooblayout_free(struct mtd_info *=
mtd, int section,
>  	return 0;
>  }
>=20=20
> +static int w25n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	region->offset =3D (16 * section) + 12;
> +	region->length =3D 4;
> +
> +	return 0;
> +}
> +
> +static int w25n01jw_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	region->offset =3D (16 * section) + 2;

This is actually wrong i believe. Only the first section needs + 2.

You can probably have the following condition:

if (section > 3) {
     offset +=3D 2;
     length -=3D 2;
}

Thanks,
Miqu=C3=A8l

