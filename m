Return-Path: <stable+bounces-58755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC54592BBDA
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A89282376
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252618E74E;
	Tue,  9 Jul 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WkltUh1i"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033218E76F;
	Tue,  9 Jul 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532977; cv=none; b=Tt04o8b7UWF0G3AXlU0AW2PJZZyR0S4itcOKgPzuN154iOvdI/ad5oGB5N7U7dHUVn7ERQswRqvkVVV9CJAa+teZWOE4lvhx4g3fcHwDGnclt+Dx4CpVetmov9z5gZuzkD2tG1XpduqA9eWc6GgbpaH4gVXcjJ7Sm93GAWG6Pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532977; c=relaxed/simple;
	bh=a015ZC5r03ehNw73sIJe/WiI2A13WN9tv5vZoYkZ0RU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rT+GtkKarEdc07u6yIeahtKKiIr1ktAhnAMoLqDRaMRKrfKVG9m3C/gjy+0ww/SaI39aTMUxb81eLXgNOPgJFfkl+iUCLkL758ZTddtMfZsp4G6wsG7QRVcei72o999FTqOPIegYypteT4478q9PfI8THu6UoWvd8TPKFJULki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WkltUh1i; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720532947; x=1721137747; i=markus.elfring@web.de;
	bh=a015ZC5r03ehNw73sIJe/WiI2A13WN9tv5vZoYkZ0RU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WkltUh1iEhfoZNCT8KIZzUNg0zksVJFjJ//b7xvaMKPZYWZzqaql+V44Zp7pOk5I
	 2QZqvsbiNHMN9zmFympsFgqukqxmprSUZk2LSLxIJNzsZU9jWLefhYUyn9ppEUNTM
	 nvJmckHQmcuwW13RKU7MUWzx7rdnzu7pdcjOGKxFXtCkHC3Zl8geeA9jqnQjawtpZ
	 i4iCh67n2gH7f8kPpMXd3vbELVHT5EHgYgmqSXdullP+YqkB2uopSLdPi7Ekkqa03
	 cux55NxZK0qaSInTsYavVTpxt57EAFMFB9cVdI8l+DZ2sNmPLKtZhOlyAgvavZj4R
	 ykjxJpkJIoVN0ZwzLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOm0r-1skBlk0bNv-00Lgme; Tue, 09
 Jul 2024 15:49:07 +0200
Message-ID: <a10b0d71-2e1c-47d6-9c7a-4086035fc6ec@web.de>
Date: Tue, 9 Jul 2024 15:48:57 +0200
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
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ian Munsie <imunsie@au1.ibm.com>, "Manoj N. Kumar" <manoj@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Wei Liu <wei.liu@kernel.org>
References: <20240709131754.855144-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] cxl: Fix possible null pointer dereference in
 read_handle()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240709131754.855144-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wD8tpFNoCW581VFsOPGKJF66fFjx15l+bwepghLJM6uHTOaEEIV
 S+CYjNw6rH2wZ4TwvNgnSQP8vBlD/7iuiRLjicS9hxBOLD8V1kU2vdnDrofiv4uP6k9Fh63
 tqjoNqMkBduPCI8cZMTSYsHsjI2ttQfQTSuaquQ1HtekCs1jJFF+FNrDUy0EF/ZT3bBSY5l
 XIyBXWpEoWS9T6Vfr42qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MqjwUJAwWmA=;d33iWjaAIjULA24pEscPLGP8YoJ
 nnxs35QjcOFAwZUZOS/fchXGW2rVCJTqaBwzJC3otBl2Nku7qfiw0wV6Xvlf8W+rr2JpjG7oW
 Ax0SjwWa5i85kIiemtwn+/qUrpNio9Wltl1QXbrFRSLOgFmTW+6m3RT25od+kA4JTuGJJrhE1
 +V72jE+WfgmWe8buVOkeJQzlA6witivjXSsni+spk7rD9X2QkMB2uQe9oEyW4pT48zsAEkpLT
 l+n7kL9Ju8MPN/aPKOaeD2naiXWuTVVbdJomjnS45Eyu+dT1hi1zyLwBO0+FeiP/uwGOe/v3W
 WdnK72SAHW1OcK0pfs9EpWk/OBk6rUSXDzH9lG3ADFodCCmeRHNm6pxyAVdvtUz827ZOahdCd
 T47sLWT3wNR19SCzdd6PrLkFWJQpmfgmBRkj16Zam7hl1JacP2KwMmFZKgz0FFvEVauFWB524
 HMqyJobNi4lnigHkg7pJ+VZxtMpdAPI9i3gsivCR+VGYueYpbjQq2N1Gz3gWSkj6OUp+dkV9v
 KOL6OHmzv2b/ntdMOaxRMo7DyqK+rvZku2hJgxYXpNlqsb86S3qfaeTpms4gnW7NpfFoFvEoB
 pP1MAyVx1cegla6iWuJpFte1lg1SLidWLzXp8u7tfK1bpfk66Xohy9JZNjScdTsGERdqiG5KT
 cbBUs/wiXNzkl9AbNVsJxDBF2sGWkEqxlstxPnpdxGZFKrZRE11RZ73T5vYSbzDFffSLHq5kQ
 BZi2xY6kJksgnRBYPyzNtbDHWj6BdSWycz1xAFr6ShVATEdztfpHEhAkODEpsA+atYGhMG5Ol
 ux7Myq0mUUuINiM7gvwKns6m8TXTYbqM4bfj1DdUbAxWY=

=E2=80=A6
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Under which circumstances will this information be corrected anyhow?

The usage of mailing list addresses is probably undesirable for
the Developer's Certificate of Origin, isn't it?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc7#n398

Regards,
Markus

