Return-Path: <stable+bounces-227102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBIWMeTCumkGbgIAu9opvQ
	(envelope-from <stable+bounces-227102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:21:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7312BE165
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E864306B591
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191625EFBE;
	Wed, 18 Mar 2026 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="lNrJ2/bq"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E72472AA;
	Wed, 18 Mar 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847050; cv=none; b=VdJAc53zfgf+uWdTyCPnRP9l4HacRCrj2aLXi5drgVt7bHl8PJeSoM4rbjoCbE/60eZelMQAk9P85IxyXEnS9aNiPa7IBrpeAti6/ZDJYKN53H1/1h2sa+mfuCDhFdJSaqnwBeM2d1eySOqf40EQJZxa9xgemmPz9aWIymNNjAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847050; c=relaxed/simple;
	bh=WKOUIMFtcG9WVn/U0eFxKYk8JhKUxMVr/3n22RatHew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+GYUtq8oOLCTQZ7xljh1f7yZic951Gmc/rw0xgFeIgqFZ98G+pgYd4U3BCm1tIXhN2f3QzUgdALGRH4OhJya/dmSiV1G/SHKaCPUz5Kycfzgg1YfmXxY8TOzaFSM/FoQ77Aqlsgd/gwLtlVx8+/CHKNop0UElZX+sCy2yTS51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=lNrJ2/bq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773847046; x=1774451846; i=wahrenst@gmx.net;
	bh=WKOUIMFtcG9WVn/U0eFxKYk8JhKUxMVr/3n22RatHew=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lNrJ2/bqJcFBZg1CQOnbqgug4sJNitlM7HC58kL58eefI5DUfCfHiTPtblnYVtB1
	 Bib4XqBfGdnbWphHbZgv6jVMN0Gd7dRtcUacWeP3xH+yh5lDX+UCUQW4WVrsuJk8J
	 iLewB9xsA+n0XO8NcgqKrnsy/VwPqJI2AcrPInhNtXnmauA4DvZcydXZ5YKKg05ld
	 aH2W56e7CZOWbOD8TBt8KMQBE3GmuRMd0gGOIqZNGqS5dlgJH2WLMe0UXYvb17s7+
	 Q80W64mVDDMv1dAhJDdjAei6hLfD9zVk+IKdLtagAAuZ8ZsQ7LGw8UhDsBuYgGExr
	 3xtxGUcFedaGwTUbPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1va7V0397g-00xRmp; Wed, 18
 Mar 2026 16:17:26 +0100
Message-ID: <dcfc3a65-75fe-4a02-bf31-9c48fb30fb57@gmx.net>
Date: Wed, 18 Mar 2026 16:17:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pmdomain: bcm: bcm2835-power: Increase ASB control
 timeout
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com>
 <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
 <c803299f-709b-4b57-b7fc-46ef3bb4c9ee@gmx.net>
 <5fe9332f-fbce-469e-8f19-dd3d7ef54c5f@igalia.com>
 <CAPDyKFoooZbU9W_Y1aSx+HuCfjHZGn9XR4_CB8YgDmCBWTB-Tg@mail.gmail.com>
 <455b46d5-435a-40ae-991f-6735ff041849@igalia.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <455b46d5-435a-40ae-991f-6735ff041849@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q9I/OY9tHJQwnJmtaTpHJo+Aq/pLMpqp2fs1XzQSGcgcCF7ZtWO
 c3Dx6wPVg8GEjnASNg2Xa81tK3/wuCsjs+l+HYUvNedoddR6v6xSl5txzX1IANN+hcCKlFS
 xUngdr15jxv55eEQFrKImvXrBIeojECLcPY3Uc8bKtEPiVYSiPSn197VJZSejlgCLNLi6ya
 sKDHQxRl7kqMfr+fZoJ7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gatTzqxwQBI=;f2m1Yw5jqlO6MAzqS3XMdKLd2UU
 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
 uw3lAaf8CBA2V/ioDvkjk8N8CvT8wylLg==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227102-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C7312BE165
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 18.03.26 um 14:21 schrieb Ma=C3=ADra Canal:
> Hi Ulf,
>
> On 18/03/26 10:06, Ulf Hansson wrote:
>> On Wed, 18 Mar 2026 at 13:54, Ma=C3=ADra Canal <mcanal@igalia.com> wrot=
e:
>>>
>>> Hi Stefan,
>>>
>>> On 18/03/26 08:51, Stefan Wahren wrote:
>>>> Hi Ma=C3=ADra,
>>>>
>>>> Am 17.03.26 um 23:41 schrieb Ma=C3=ADra Canal:
>>>>> The bcm2835_asb_control() function uses a tight polling loop to wait
>>>>> for the ASB bridge to acknowledge a request. During intensive=20
>>>>> workloads,
>>>>> this handshake intermittently fails for V3D's master ASB on BCM2711,
>>>>> resulting in "Failed to disable ASB master for v3d" errors during
>>>>> runtime PM suspend. As a consequence, the failed power-off leaves=20
>>>>> V3D in
>>>>> a broken state, leading to bus faults or system hangs on later=20
>>>>> accesses.
>>>>>
>>>>> As the timeout is insufficient in some scenarios, increase the=20
>>>>> polling
>>>>> timeout from 1us to 5us, which is still negligible in the context=20
>>>>> of a
>>>>> power domain transition. Also, replace the open-coded ktime_get_ns()=
/
>>>>> cpu_relax() polling loop with readl_poll_timeout_atomic().
>>>> personally I would have moved all readl_poll_timeout_atomic changes i=
n
>>>> the second patch, to avoid possible conflicts in stable. But no stron=
g
>>>> opinion about this.
>>>>
>>>
>>> TBH personally, I also agree. But, as I don't have a strong opinion
>>> about it, I prioritized addressing Ulf's feedback in the last version
>>> [1].
>>
>> The first version of the patch moved the call to ktime_get_ns(), so I
>> thought we might as well use readl_poll_timeout_atomic() directly,
>> instead of fixing up the open-coded loop.
>>
>
> Yeah, it makes sense. I'm okay with both options, so if Stefan agrees
> with it, I'm fine in moving forward with this approach.
As I said, I've no strong opinion about this. So please go ahead.
>
> Best regards,
> - Ma=C3=ADra
>
>> Kind regards
>> Uffe
>>
>>>
>>> [1]
>>> https://lore.kernel.org/dri-devel/20260312-v3d-power-management-v7-0-9=
f006a1d4c55@igalia.com/T/#mf96146960ec7ffeea32e732c95ccf9548af21748=20
>>>
>>>
>>> Best regards,
>>> - Ma=C3=ADra
>>>
>>>> Best regards
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power
>>>>> domains under a new binding.")
>>>>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 drivers/pmdomain/bcm/bcm2835-power.c | 12 ++++--------
>>>>> =C2=A0=C2=A0 1 file changed, 4 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain=
/
>>>>> bcm/bcm2835-power.c
>>>>> index
>>>>> 0450202bbee2513c9116a36abaa839b460550935..eee87a3005325848547ce1f5fd=
729b168a641460=20
>>>>> 100644
>>>>> --- a/drivers/pmdomain/bcm/bcm2835-power.c
>>>>> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
>>>>> @@ -9,6 +9,7 @@
>>>>> =C2=A0=C2=A0 #include <linux/clk.h>
>>>>> =C2=A0=C2=A0 #include <linux/delay.h>
>>>>> =C2=A0=C2=A0 #include <linux/io.h>
>>>>> +#include <linux/iopoll.h>
>>>>> =C2=A0=C2=A0 #include <linux/mfd/bcm2835-pm.h>
>>>>> =C2=A0=C2=A0 #include <linux/module.h>
>>>>> =C2=A0=C2=A0 #include <linux/platform_device.h>
>>>>> @@ -153,7 +154,6 @@ struct bcm2835_power {
>>>>> =C2=A0=C2=A0 static int bcm2835_asb_control(struct bcm2835_power *po=
wer, u32=20
>>>>> reg,
>>>>> bool enable)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __iomem *base =3D power->a=
sb;
>>>>> -=C2=A0=C2=A0=C2=A0 u64 start;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 val;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (reg) {
>>>>> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct
>>>>> bcm2835_power *power, u32 reg, bool enable
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 start =3D ktime_get_ns();
>>>>> -
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Enable the module's async AX=
I bridges. */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (enable) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D=
 readl(base + reg) & ~ASB_REQ_STOP;
>>>>> @@ -176,11 +174,9 @@ static int bcm2835_asb_control(struct
>>>>> bcm2835_power *power, u32 reg, bool enable
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(PM_PASSWORD | val, base =
+ reg);
>>>>> -=C2=A0=C2=A0=C2=A0 while (!!(readl(base + reg) & ASB_ACK) =3D=3D en=
able) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_relax();
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ktime_get_ns() - sta=
rt >=3D 1000)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return -ETIMEDOUT;
>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 if (readl_poll_timeout_atomic(base + reg, val,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !!(val & ASB_=
ACK) !=3D enable, 0, 5))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ETIMEDOUT;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>
>>>
>


