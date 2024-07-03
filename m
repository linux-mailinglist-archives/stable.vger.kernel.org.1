Return-Path: <stable+bounces-57915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B98B92604E
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222031F260B7
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406031741D2;
	Wed,  3 Jul 2024 12:28:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807D16F84E
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009730; cv=none; b=r7hQne32+cSRgznP+PfW4GAN75PRB4DHT+rI5GivLO7tuofapafu+Y5Ze2hkCPerVhhyvCsnOyE89uCj4lo/49PblYPPeXAm3TrfWQvPFljafHkmSxCHK/ScAta1G3a3EcohugCfSDICplScYHjC5+4rlDejgnq1wEY5jqexDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009730; c=relaxed/simple;
	bh=+gU8vko3tCI5EL05iSQsogVikFmj4gq7DBuivXzc1iQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZCL/MUyPvK8ZwQAYQI3ewy06k9lpMz7jFJDfX3BKxnFmEzUCzaxFenTrmyfq1ZoQWU3pjwg8+232+9E2L2iUuxDUsqFb+LTsLdnU68rpfS2jFQYPmB8ZwbKGl246CLQsVJn68/KqSOjG8fk6e+ei0UdVnerAh7H1cw4FHCa5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 242AE1C147A;
	Wed,  3 Jul 2024 11:10:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 8FD8420025;
	Wed,  3 Jul 2024 11:10:45 +0000 (UTC)
Message-ID: <f054ce9050f20e99afbed174c07f67efc61ef906.camel@perches.com>
Subject: Re: [PATCH 4.19 093/139] scsi: mpt3sas: Add ioc_<level> logging
 macros
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Suganath Prabu
	 <suganath-prabu.subramani@broadcom.com>, "Martin K. Petersen"
	 <martin.petersen@oracle.com>, Sasha Levin <sashal@kernel.org>
Date: Wed, 03 Jul 2024 04:10:43 -0700
In-Reply-To: <20240703102833.952003952@linuxfoundation.org>
References: <20240703102830.432293640@linuxfoundation.org>
	 <20240703102833.952003952@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: kdb6pa719dimdr9zw1xihyk3hz8ix369
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8FD8420025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/HYm4rJvVGx/zv3pUswF6VqhkAvIMR20U=
X-HE-Tag: 1720005045-459816
X-HE-Meta: U2FsdGVkX1/o/+alroJJKcTonsCF/3HPd2KVuNF4rNejycWsTfYIQu8BTDriu1DHjiO0fg0s+veXyWSWEoHhJnuL4CQ6Yy/Db1efIOMPvxi6iOx7twl1e97k4T1Obd5nhI/10k3WAA8bB9Otdo+VMYELTafVtIFpN37Qe9Q0E1n+gFoEkyZzeV9B6nxd6mL5xqXxn7iALvF1yDxyNPAPFOKIIWhJLg9+/gc/9gS2T+rx/6TRUCrxuli1qPM93DP0Quh+7/Z6NUzXOCy8k9lJq8wI2xZAfg2oRz/NCy3hKcETtUgaOTHXx66TrXXXlPeeMym3hMePzZJEA/mCzSUYWjjUpAyGB6jP/qKyGkqaWvkLnYYjS2FsFIS34xWuNy1EGxGQ9BU9upQ5l0mns0b/GfsDlVcxt3OjHNy/Kd6FMkpS7J2S28RmNdkaT9SQlf+9BrsYojlZSHRmt78IdG4GUOCdR4TXGXSv6wGvwkpV1PXGE8TBXkmhcLbxOPKFQj8pM+UAsosTzk0=

On Wed, 2024-07-03 at 12:39 +0200, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me kn=
ow.

Still think this isn't necessary.

see: https://lore.kernel.org/stable/Zn25eTIrGAKneEm_@sashalap/

>=20
> ------------------
>=20
> From: Joe Perches <joe@perches.com>
>=20
> [ Upstream commit 645a20c6821cd1ab58af8a1f99659e619c216efd ]
>=20
> These macros can help identify specific logging uses and eventually perha=
ps
> reduce object sizes.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Stable-dep-of: 4254dfeda82f ("scsi: mpt3sas: Avoid test/set_bit() operati=
ng in non-allocated memory")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/m=
pt3sas_base.h
> index 96dc15e90bd83..941a4faf20be0 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.h
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
> @@ -160,6 +160,15 @@ struct mpt3sas_nvme_cmd {
>   */
>  #define MPT3SAS_FMT			"%s: "
> =20
> +#define ioc_err(ioc, fmt, ...)						\
> +	pr_err("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +#define ioc_notice(ioc, fmt, ...)					\
> +	pr_notice("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +#define ioc_warn(ioc, fmt, ...)						\
> +	pr_warn("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +#define ioc_info(ioc, fmt, ...)						\
> +	pr_info("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +
>  /*
>   *  WarpDrive Specific Log codes
>   */


