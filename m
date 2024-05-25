Return-Path: <stable+bounces-46124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096C8CEE79
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 12:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35AA1F21839
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657A22EE9;
	Sat, 25 May 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XZqrWqKQ"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164A171CC;
	Sat, 25 May 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716632550; cv=none; b=PYorbGsUeaNUurjErLRYYHBjrr5UO/WGRtXxDhLm99345u7D1cEBfzaFbjO0el8Rll5+FBkVz/Tr2huXdyobXHu86N0x+Sysdrn8GETDeFbnEh2gcUXN/JDmcWpKmzq+PbROoOM/ElEa6safTw21lgKCN6yayQxbJngB+INVpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716632550; c=relaxed/simple;
	bh=YNsy0eiDe4FNlCTPePDFDDRv38WnUx+b+e1glkTNzGQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Z+EwB71w68P+XCtMInZsLZebffy8ixjILPI4JW+WLboQwodDqm6GgMT0u5NJEjndSJ4H4nkVx6Mbqp0CpSb9ocy3fAsSO6owD+j2C2YI9zicXB8ZyOm0EGjtsM+qul4QOUZhaNC+9DHw+K6U1dps27s+505ETRpxgbDaqTJjn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XZqrWqKQ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716632527; x=1717237327; i=markus.elfring@web.de;
	bh=YNsy0eiDe4FNlCTPePDFDDRv38WnUx+b+e1glkTNzGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XZqrWqKQ5I+Rvo192FgMqh9MJRz0NpYsHJo9CcyUFt5ad68a6Ns+fTVVfAItVQCF
	 ILU1VUzBkJkdivvYVZVZ4ShWDFBKrwQuXOs6d6qecu35ffaDxH+aEMVPffhl7xbkQ
	 utoE+ZoGR1U/fSnW2+T96y6NsGiQIy7AsbBbe180VZiqtYfmMmFoiFnBS3dazu4re
	 sm2tD+g4e0GkEX2i7uipMF456QDA2ICM+Dc5YksOnXrM6HqgdCbkITkhmm8NWm07N
	 EbLbSKY6tbn8d+HM8B5hV9fwY7UvKRVVKBpP6r9J8ZBDe6EK+WlUGuek79JSxb2iT
	 8sLC51Q4VIfGNo3wYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1sheFj1ZbU-00qOAP; Sat, 25
 May 2024 12:22:07 +0200
Message-ID: <ea971463-c43b-4524-bf43-ce4d05ec0db3@web.de>
Date: Sat, 25 May 2024 12:22:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dicken.ding@mediatek.com, tip-bot2@linutronix.de,
 linux-tip-commits@vger.kernel.org, x86@kernel.org, stable@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>
References: <171654826399.10875.17851209724801691980.tip-bot2@tip-bot2>
Subject: Re: [tip: irq/urgent] genirq/irqdesc: Prevent use-after-free in
 irq_find_at_or_after()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <171654826399.10875.17851209724801691980.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yZlp2qNBCCyPQtANKc+yVQwq1uB7RafszQ4bA+CLIimc76fvE9j
 byliV4Ex/S8EG3wJFf2YZKIlA6AvmbeBB8sBOSIY7vtmACI7LP2xzX6E3J/NYGcLcUUaUBk
 I/TxkunGsCC+IYoEtXhLhUdy+U6/zy9l+9i335qE7Trq2AviGX1XpZQWDHFVw2W2M2Vv1W7
 pqOfzLvi+dplU/7cMdczw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EAMcd4seoSU=;dhwW3IiT8O+SC9rWgKgYf3rBbFh
 pKdBsFNKDZ+6QSe4xEg6S0wfMKgwD7NkCGTnpgo5Oybrc0FfTMeBzjViO9cIcX8UeFkZ3dley
 NQ/lsf5OK91AZHyrfy4ifkcsXOU9DAX8G7gK8sPuLkBsgxeDBZKmB/qXwsrlycTwGllOYbzc5
 TXP8C40SkZ86iRhJ1LKgmawL+r3BU3RGyFpLYuZznA/B1c+mY+nIe/oNwqsL3/JEJbAjk6cvJ
 /Crp9GSQkRWJ1f7vRaTCb6Pj4DJz0wjRpIlMlmCGbDc7N7RCpQnOrysNoBKZrG31cXhvuOUTJ
 WRKofpxV/0FjoTiYlFQ2YSWbEjKMfayxWurvA1IF6LnZVyQSaUD4+FbkCb/n518wdyA2hs29r
 vlyoUlRyNC7FEN/Jbg+i2cc1MZ73KQenYWecXLLTA5wpyZQAuvKSDxVdXlC6WJ/o7pghQzlWC
 1JpNDYU6YPBoBKMXHoFoHxXnOJXatBlI9KEiYc8CVbmI3bNFr/iytn/km3CU3Mdgg9EEiRfGx
 lkMLcqCuDk4xeXwZJMRpq3HODc1gtNNUvzkuNxZSnvnj4Jr9fi2aKebdC6XeNwZlaeptFU7Tl
 L1vefo04fYmOpKCO4t2ue+jLMO+mOEWoNkKrH/n9EHNQiTRPIcY1yaMsJKIPlVTGj9mm3T4Ww
 r9zDokW+79A9uZ7SoapNSRHQfK7rmPvs3RHMgQ0QQ45/K33nvcyxqmlWTun0kD8DoMCZgeycB
 QFVxwWjq277xyTbD9fo7sjAngEvEcQhzn9pDbH/ncIDVo1qrHM/jHUZKajDxk7C5aEi+afcf7
 fUuU1kqTarFTIDIkGH8UjsResSZn5v8rLux4imuUrMp7Y=

=E2=80=A6
> Fixes: 721255b9826b ("genirq: Use a maple tree for interrupt descriptor =
management")
> Signed-off-by: dicken.ding <dicken.ding@mediatek.com>
=E2=80=A6

Would a slightly different author name be preferred here
according to the Developer's Certificate of Origin?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n438

Regards,
Markus

