Return-Path: <stable+bounces-59351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F099D931589
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8FC2825C3
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30D18D4B3;
	Mon, 15 Jul 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qG+JJCdr"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80AA189F59;
	Mon, 15 Jul 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049578; cv=none; b=iT6wSWQoLwMrZIXjiMhJMx7RW6gXXKGNSTanqjkW2oQoXwlVkYg/Gr65PBaPeVI1YQh17vpuQnq8jtWShZZeDa7BtcXaGaa44o+5ccHIxq9wI84/OrrNkNUghlive8Dq/FrJk1+j+N6Kogyf3dmyqxdSDeRu9YHYTsQCN2qqjWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049578; c=relaxed/simple;
	bh=vPG94mdyUfScDU9XjxT9wJHj1nF1OhhTm8LfdKYGKyU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dv5Y2bLFLkrvN0+hlv7DybIE8V/mS2qzl0l+unuujZsQM+ac7TPVvgaFMAj04PgFeK7hfGFmvYxXCN+mdvc/j/gJDvZuE480QUQSHuhx2qTEOleT4wVTPMHhTSjh153QSknvDyIv++5sFYRjXU2aJ0e12vIvVHuGcALst52I2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qG+JJCdr; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721049540; x=1721654340; i=markus.elfring@web.de;
	bh=vPG94mdyUfScDU9XjxT9wJHj1nF1OhhTm8LfdKYGKyU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qG+JJCdrVFKUMJy5ceJT8hntkrkhkXkHlZ6hlrGWBwS2fyMgXfdUJqnU33WrLFTB
	 t50JYaF5OFIKjzhs14wJIHHw+IsL/DwBR9d0oCjuxzq/CTlPIE1uKdkpXdUzO6ZEK
	 sOKT3hRskQNqSsxKmTroR1UNBdvgUnDTQ4AqSC1Wa/kg+CAEeGI/bpdn/fY4Ah9O5
	 4AqO6kMoT2l2RHrdfLIiSw4OM2I6iw5BzoydhAqSkDJyrImZ79Jf7BYHMPZcHf0fm
	 bQn8WnlYPtNrLMAOetuIP6iAj4jtGZ9j9YDGQIx0bIZyUfQxmOQyjg9W3zkpLkLoK
	 z7l6LtplhOMGpbzbgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Icn-1s6kgV12v9-00xrqD; Mon, 15
 Jul 2024 15:19:00 +0200
Message-ID: <6c50de6d-7f35-4427-bd11-5f02f5e90c08@web.de>
Date: Mon, 15 Jul 2024 15:18:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Aleksandr Mishin <amishin@t-argos.ru>, Andrew Donnellan <ajd@linux.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Maxime Ripard <mripard@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>,
 Wei Liu <wei.liu@kernel.org>
References: <20240715025442.3229209-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v4] cxl: Fix possible null pointer dereference in
 read_handle()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240715025442.3229209-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:60AT5T8BRZHQ6Gfv9u427isOzaT1ol9JQSTUXVRY8R+RWiR+wlg
 uOOY0ka3OvtSIcX6lXp4OgDSPrJFLe03Ofze5Hs3wM9Z9IePcr3uBn+DZP1YpGcBh3A49id
 zatBnGaU1zQtqqXMksLXbjlMe4ZRKgt2qtbHowpg44jp0okSPQESB/hzUIbO43MhyUft7NK
 S3n1WF9VfhlErESXakadA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:viLqW/CObXo=;0l1lBepkdtz8vogJ+28NR/ACuF1
 orJWguKXGfvjM4ndYEQhEBoyIbZYVTbZH4X1Cqxb/x01Utdj3CvDfE5wT2jmbFKkCWdblPM8a
 cjAmiD+2zhYJvPABeiLM7gy/DtyL3PmpuOxIFV/zozqKwTpNwQx2pMRhGkllRwoM/Nps+La8W
 cjAjmITuRSge2ykwpRHJ+7+cPiIKkvKtUvuDp7GJYlL3jMwMMgpxLyTjgcUIDx3peD5lU463P
 JOdpKWLzZ+WuQKI2BYPFXPrxRO3quZqrrhx5EWXsmUQdVM0t8DsliOp4NnCQdMbUinmUi5QUN
 ZY9ZvajK6GAUozrTrAtQ5l0ULyYjHMCDqYrQ2vtFkL5T6hWhyuESPpg+tRSNnnfWWze1gQS6f
 mi5dLB+sZugZ6K1zTYXaq1me90EBn3G6KmNbw/IAr7XI0Vf0aqmGVDOQ0Rxr7X10ICsAuGTDo
 4sUlUiiGNv43NEP25qFrZktinKTimy6tMFm/rlc0ki/nP5uvCQ8R0Pcuhs607n1fOunsrkzxh
 A3KkhwczFYgOqLoHJBMpw6l+5P5p3bcVIR0AgqqIdzt7m+TGZH8MJyc85CJRZMGXkwoS6o5mG
 BqS3stnqgZc5iX9g6xBU0n7NaF8qwr+NirvNsgimUQMesbMValrBB1HYRg7UsvNKKDkzpteAV
 WGUSDaLt72FP+m5Pdap3cf0cX+XpeVz7dSILoZRZ2NnUoIWiry9bED1b8qLQLsgRUKWYheKlH
 2wMek/9d295pYAzNuUYG0oDUE/g9ThlXKOO2E/FzceIJxXZxk5Mc7o0UFt9KreO9u7XX3NVp/
 0KkwSfS6nZJ0c3pc6uu8Ldig==

> In read_handle(), of_get_address() may return NULL if getting address an=
d
> size of the node failed. When of_read_number() uses prop to handle
> conversions between different byte orders, it could lead to a null point=
er
> dereference. Add NULL check to fix potential issue.
>
> Found by static analysis.
>
> Cc: stable@vger.kernel.org
> Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

How will interests evolve for caring more according to known research
and development processes?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10#n398
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/researcher-guidelines.rst?h=3Dv6.10#n5


> ---
> Changes in v4:
> - modified vulnerability description according to suggestions, making th=
e
> process of static analysis of vulnerabilities clearer. No active researc=
h
> on developer behavior.
=E2=80=A6

Does such information indicate any communication difficulties?

Regards,
Markus

