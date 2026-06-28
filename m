Return-Path: <stable+bounces-269465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EVq4N7ycQGqnggkAu9opvQ
	(envelope-from <stable+bounces-269465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 06:02:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466F6D31C1
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 06:02:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269465-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269465-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B98C303DD60
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0831E822;
	Sun, 28 Jun 2026 03:58:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15C31A81C;
	Sun, 28 Jun 2026 03:58:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619130; cv=none; b=SHkR7zAtAOb7wyWAWIjh277D+m9e3rbUG4PCgKMf9oMxEw6XIX3g/k5oCeFvOH4KH8F53Qp7axZ/8H5aOv9sHidsUoS8z1gyn9BaBAcBEzgUSvfyNEd310nT8OOgsWlDUBpyvXLoMy+U+eEEdDj40rjWI9dZmDmgCJKku7mobok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619130; c=relaxed/simple;
	bh=xc0MBYg0Y/spYENyLmebqeOhHNNc2N+29iJjmFn5eBc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YELLoQIaNqiGPNt0LIw0MVWvX175LgCpbgi0/KwvWKS1aH8JaZdSyshamP5FJifezuMJIB2GS7N+dVsMrcToKTgC06EUeU5ylUotNAtyj19F/lAvvxwHbJPJzsN2mU59Y3Oh5EsnhY3dJDXH5XA3VO7iEqFhaV2PCUowzOg1Wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAAnztbpm0BqfUqqAw--.7329S2;
	Sun, 28 Jun 2026 11:58:33 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: mtd: mtd_device_parse_register: fix refcount
 imbalance on   add_mtd_device failure and multi-call scenarios
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626151349.50859-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:58:22 +0800
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <52A2B858-B071-4644-8939-62BF8C292AA7@iscas.ac.cn>
References: <20260626151349.50859-1-vulab@iscas.ac.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAAnztbpm0BqfUqqAw--.7329S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4UKFyxKrWxCFWDJr17Awb_yoW5Gr45pr
	Z8Wa9Yy3y3Kr429wsrWF1qgFWUKasay34rur47Gw12kws3G34YqFZ8KFy7Ww18t34xGF4j
	qr4xXan5Cw4UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkCb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHGQDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIMA2pAixEbZQAAsE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vigneshr@ti.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:linux-mtd@lists.infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269465-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5466F6D31C1



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:13=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> add_mtd_device initializes mtd->refcnt via kref_init unconditionally. =
The
>  cleanup in the out label only calls del_mtd_device when
>  device_is_registered is true. When add_mtd_device fails before
>  device_register, the refcnt is left at 1 (leak). Conversely, when
>  CONFIG_MTD_PARTITIONED_MASTER is disabled and the device was already
>  registered by a prior call, the error path incorrectly calls
>  del_mtd_device without a matching add_mtd_device in this invocation,
>  causing a refcount underflow.
>=20
> Track whether add_mtd_device succeeded in this invocation with a
>  registered flag, and only call del_mtd_device on error when =
registered is
>  true.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1c4c215cbdcb ("mtd: add new API for handling MTD registration")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/mtd/mtdcore.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 576537774628..59d8a6c61f55 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1108,6 +1108,7 @@ int mtd_device_parse_register(struct mtd_info =
*mtd, const char * const *types,
> 			      int nr_parts)
> {
> 	int ret, err;
> +	bool registered =3D false;
>=20
> 	mtd_set_dev_defaults(mtd);
>=20
> @@ -1119,6 +1120,7 @@ int mtd_device_parse_register(struct mtd_info =
*mtd, const char * const *types,
> 		ret =3D add_mtd_device(mtd);
> 		if (ret)
> 			goto out;
> +		registered =3D true;
> 	}
>=20
> 	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT)) {
> @@ -1136,9 +1138,11 @@ int mtd_device_parse_register(struct mtd_info =
*mtd, const char * const *types,
> 		ret =3D 0;
> 	else if (nr_parts)
> 		ret =3D add_mtd_partitions(mtd, parts, nr_parts);
> -	else if (!device_is_registered(&mtd->dev))
> +	else if (!device_is_registered(&mtd->dev)) {
> 		ret =3D add_mtd_device(mtd);
> -	else
> +		if (!ret)
> +			registered =3D true;
> +	} else
> 		ret =3D 0;
>=20
> 	if (ret)
> @@ -1170,7 +1174,7 @@ int mtd_device_parse_register(struct mtd_info =
*mtd, const char * const *types,
> 		nvmem_unregister(mtd->otp_factory_nvmem);
> 	}
>=20
> -	if (ret && device_is_registered(&mtd->dev)) {
> +	if (ret && registered) {
> 		err =3D del_mtd_device(mtd);
> 		if (err)
> 			pr_err("Error when deleting MTD device (%d)\n", =
err);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang


