Return-Path: <stable+bounces-222517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMBPNU8upWmj5AUAu9opvQ
	(envelope-from <stable+bounces-222517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 07:29:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B951D3721
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 07:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2973E3008A7E
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C453164D6;
	Mon,  2 Mar 2026 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FEKqQ67r"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802D21B905
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772432971; cv=none; b=cz0GuKL410poWy2ILio5k+wyIi94ujpR+tFchPW3ruRNok0oEOyfd/0vealwHzyb1nPAKd9WYEVebjSzL3c9woQN16rkZgqOphhx2Qe7gN0KzZkCZi5KY4XSbDeGUXFuYcD8sqH6Y0btoikacZgpeKC0e9ogIqbTAJ3V2xFDImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772432971; c=relaxed/simple;
	bh=Q2EOswIlTT65Gw+A24Wdnw+0KorL9qBvjn+K5S/m6oc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JgtMMoXtuKkuvGNqBCf2aRwEqsvrJkqy9m7/EJEqYmNzASiRzU7l6Yri6GSGDcbYzfeTY9Fy4iK6nZaFdfPe72ag23YOtQmRZGboSxTojlRencPRJ0+WEcmHeArUVr12F75qdRQh/JRpx0YBEtfxTuKZz7TnG6aQeli7OR6oRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FEKqQ67r; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772432966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Rym3aUWuenq1lQZSGDfzIxn3F9KxsbvCY1oHj0DwIM=;
	b=FEKqQ67rTWOAjWtHeWhw+xjcu/h0GspbFI1MhnO/kCHpG/e6GRQDcq90EQFErEsXZ2SxbX
	ol5CJUYmFpR6wlsWGgYcQTO3IO7dVr6CpsRGiYvagmtti2jMcWRag5REwc/MFWjyB7+tMt
	6T/w1smcvdWXJEs/LLYEfanKAnEZTbg=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.1\))
Subject: Re: [PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <TYZPR01MB42609CF11A0C011930B4C067D77EA@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
Date: Sun, 1 Mar 2026 22:28:55 -0800
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <240846BF-3951-4B14-925C-1FA324161C0F@linux.dev>
References: <20260227075909.3860183-1-matthew.schwartz@linux.dev>
 <1e71a22b-48d5-4a5f-87d5-860a6cb9a04d@intel.com>
 <752b26fc-45e2-4c4b-aa9b-48a1112b837a@linux.dev>
 <TYZPR01MB42609CF11A0C011930B4C067D77EA@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
To: =?utf-8?B?IkJlbkNodWFuZ1vojormmbrph49dIg==?= <Ben.Chuang@genesyslogic.com.tw>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222517-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.schwartz@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,genesyslogic.com.tw:email,linaro.org:email,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 37B951D3721
X-Rspamd-Action: no action



> On Mar 1, 2026, at 6:54=E2=80=AFPM, BenChuang[=E8=8E=8A=E6=99=BA=E9=87=8F=
] <Ben.Chuang@genesyslogic.com.tw> wrote:
>=20
> Hi Matthew,
>=20
>> -----Original Message-----
>> From: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Sent: Saturday, February 28, 2026 9:27 AM
>> To: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson =
<ulf.hansson@linaro.org>; BenChuang[=E8=8E=8A=E6=99=BA=E9=87=8F]
>> <Ben.Chuang@genesyslogic.com.tw>
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; =
stable@vger.kernel.org
>> Subject: Re: [PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write =
corruption
>>=20
>> On 2/27/26 1:16 AM, Adrian Hunter wrote:
>>> On 27/02/2026 09:59, Matthew Schwartz wrote:
>>>> The GL9750 SD host controller has intermittent data corruption =
during
>>>> DMA write operations. The GM_BURST register's R_OSRC_Lmt field
>>>> (bits 17:16), which limits outstanding DMA read requests from =
system
>>>> memory, is not being cleared during initialization. The Windows =
driver
>>>> sets R_OSRC_Lmt to zero, limiting requests to the smallest unit.
>>>>=20
>>>> Clear R_OSRC_Lmt to match the Windows driver behavior. This =
eliminates
>>>> write corruption verified with f3write/f3read tests while =
maintaining
>>>> DMA performance.
>>>>=20
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic =
GL975x support")
>>>> Closes:
>> https://lore.kernel.org/linux-mmc/33d12807-5c72-41c
>> =
e-8679-57aa11831fad%40linux.dev%2F&data=3D05%7C02%7Cben.chuang%40genesyslo=
gic.com.tw%7Cf7d89cd3b9ef4ee8f58
>> =
208de76687497%7C4e753840bf6b40a19645185818deeb52%7C0%7C0%7C639078388197698=
028%7CUnknown%7CTWFpb
>> =
GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjo=
iTWFpbCIsIldUIjoyfQ%3D%3D%7C0%
>> =
7C%7C%7C&sdata=3DxdnJIB74XZ4LQYBgHseMZWvDSwO1mg4x0jCNxqMMoco%3D&reserved=3D=
0
>>>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>=20
>>> Ben wrote "So I think your patch setting R_OSRC_Lmt to zero is =
reasonable."
>>> Can be have a Reviewed-by tag also?
>>=20
>> Wasn't sure about the etiquette of adding a Reviewed-by without an =
explicit tag in an email,
>> but happy to re-spin a v2 and add that if it's wanted.
>>=20
>>>=20
>>> Nevertheless:
>>>=20
>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>=20
>>>> ---
>>>> Link to RFC:
>> https://lore.kernel.org/all/20260117234800.931664-1
>> =
-matthew.schwartz%40linux.dev%2F&data=3D05%7C02%7Cben.chuang%40genesyslogi=
c.com.tw%7Cf7d89cd3b9ef4ee8f58208
>> =
de76687497%7C4e753840bf6b40a19645185818deeb52%7C0%7C0%7C639078388197757693=
%7CUnknown%7CTWFpbGZsb
>> =
3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWF=
pbCIsIldUIjoyfQ%3D%3D%7C0%7C%
>> =
7C%7C&sdata=3DhG%2FsvJa9fEfEPXIcB81%2FG33pbxg54SxC2SX5WuKxCZw%3D&reserved=3D=
0
>>>> Changes from RFC -> v1: use the proper name for the register field
>>>> ---
>>>> drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
>>>> 1 file changed, 8 insertions(+)
>>>>=20
>>>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c =
b/drivers/mmc/host/sdhci-pci-gli.c
>>>> index b0f91cc9e40e4..7a7be3f7bee6b 100644
>>>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>>>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>>>> @@ -26,6 +26,9 @@
>>>> #define   GLI_9750_WT_EN_ON           0x1
>>>> #define   GLI_9750_WT_EN_OFF          0x0
>>>>=20
>>>> +#define SDHCI_GLI_9750_GM_BURST_SIZE                0x510
>>>> +#define   SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT     GENMASK(17, =
16)
>>>> +
>=20
> Please move the definition of 0x510 register before the definition of =
0x540 register.

Sure, I can move it.

> i.e.
>=20
> #define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
> #define   SDHCI_GLI_9750_MISC_SSC_OFF    BIT(26)
>=20
> +#define        SDHCI_GLI_9750_GM_BURST_SIZE              0x510
> +#define          SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT   =
GENMASK(17, 16)
> +
> #define SDHCI_GLI_9750_TUNING_CONTROL            0x540
> #define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
> #define   GLI_9750_TUNING_CONTROL_EN_ON             0x1
>=20
>>>> #define SDHCI_GLI_9750_CFG2          0x848
>>>> #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>>>> #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
>>>> @@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct =
sdhci_host *host)
>>>>=20
>>>>   gl9750_wt_on(host);
>>>>=20
>>>> +  /* clear R_OSRC_Lmt to avoid DMA write corruption */
>>>> +  value =3D sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
>>>> +  value &=3D ~SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT;
>>>> +  sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
>>>> +
>=20
> I recall that sdhci_reset() resets the 0x510 register to its default =
value.
> So please test this by removing the card and reinserting the card =
again, and
> see if the value still matches expectations. If not, perhaps the above =
code
> can be added to gli_set_9750().

I will double check this before sending out a V2 that addresses your =
earlier comment.

Thanks for the review,
Matt

>=20
> Best regards,
> Ben Chuang
>=20
>>>>   value =3D sdhci_readl(host, SDHCI_GLI_9750_CFG2);
>>>>   value &=3D ~SDHCI_GLI_9750_CFG2_L1DLY;
>>>>   /* set ASPM L1 entry delay to 7.9us */
>>>=20
>=20
> ________________________________
>=20
> Genesys Logic Email Confidentiality Notice:
> This mail and any attachments may contain information that is =
confidential, proprietary, privileged or otherwise protected by law. The =
mail is intended solely for the named addressee (or a person responsible =
for delivering it to the addressee). If you are not the intended =
recipient of this mail, you are not authorized to read, print, copy or =
disseminate this mail.
>=20
> If you have received this email in error, please notify us immediately =
by reply email and immediately delete this message and any attachments =
from your system. Please be noted that any unauthorized use, =
dissemination, distribution or copying of this email is strictly =
prohibited.
> ________________________________



