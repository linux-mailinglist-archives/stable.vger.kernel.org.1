Return-Path: <stable+bounces-225487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAn5E9Q7t2kIOgEAu9opvQ
	(envelope-from <stable+bounces-225487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 00:08:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E24292F46
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 00:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B6D8300AECB
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 23:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA400288517;
	Sun, 15 Mar 2026 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ON3HXg1L"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B2287246;
	Sun, 15 Mar 2026 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773616077; cv=none; b=dUrrD9HOVSbdmFrIfEraXNJya7FPaIPkV7IrwFnRtZHoFemHa68TZyvAgW/mxKoLUXSSUaSpFqV3u0DVSJzAcZ/VFH/4/ECWOJzv85kphZfrgIHtHQIqp0MdQBq8GhyucPznvjszfMoi3p4L7nlf/Zpuw6XFs7ufe/00ALsbMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773616077; c=relaxed/simple;
	bh=uX/BrtmW8jeZBfsMpz031mbVpPze8fSVQMgM+ZisUFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOzHkb3wU5Z2q4k+fw3XL0gT90bBN2dQQ6wKJ/DtrhG/IIwuAixiptPwJV5thElJTEky9l/kj3Wh3rE0hX3OsTKB9oMnEVenO+ZMtuyWAt1GCIDX+Njb9M1DtF5GPvLeyCStvp7n2ZgOI7IYhPNEpenLW44b/k6c3uU2nWhqodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ON3HXg1L; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773616053; x=1774220853; i=wahrenst@gmx.net;
	bh=VMCPSBmKWW117qnhfEXoCMhM6JqsDOVzqEruNBY+32c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ON3HXg1L7ih7TWuitHt6pRyWc2gJ+iSokjz43d4bbkKTMuKdYbmge0R1WUJ3BXSB
	 A9UEx+pL9Pikw+6wSGc5aESZxtIOioXkB6whifPx2G+K4vLQ6DnIXObudZP4Wrbc2
	 RMlrkVrL99/JEbXUCADfKrtEykDdaQguGuWz0GvBZqIATe2PawXcpdy6N5L4bbmoI
	 hKbQD8KmXLvkq2eRuMpddOTst35KUqEdzQEq6Q9T+G6ggfuClk3R6uXTRBA5o/eOp
	 Q6NOtfSj7sgM0PgIU5IQxVJVUQskkeuteY4WMXoBhCRDioszwdU1hkKiK9LRFCyKX
	 JMreomHyo/EVKGuvUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1vd30Q1tL1-011y24; Mon, 16
 Mar 2026 00:07:33 +0100
Message-ID: <bdae424d-f4b5-4181-9421-4393fe3ac8fb@gmx.net>
Date: Mon, 16 Mar 2026 00:07:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] pmdomain: bcm: bcm2835-power: Increase ASB control
 timeout
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>,
 Chema Casanova <jmcasanova@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kernel-dev@igalia.com,
 stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 linux-pm@vger.kernel.org
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
 <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
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
In-Reply-To: <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/TS4HxQY5TivZuoGW+W8HuPijf3g1Y33tGVX19IspPImRfLdS+l
 mGRaX0xQXzL+rTovBJdd9n124GsVHj6yq4fAk0YjfYTt+ihwybN+w5C7yn+2a+ic6wxg0AV
 8WoM01mBRHG83QjzwGQp+8ehdQ12V3BwihkK8qnKaWoO3O63nFhc75hjaBpnF8dAas3X+MY
 NKCG0IaT6VcrZ7Tn47WYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xlCW+9NPf/c=;9NSQeZ/QDaIr9hEogBnBqpDggU7
 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
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
	TAGGED_FROM(0.00)[bounces-225487-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.net];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: 11E24292F46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ma=C3=ADra,

Am 12.03.26 um 22:34 schrieb Ma=C3=ADra Canal:
> The bcm2835_asb_control() function uses a tight polling loop to wait
> for the ASB bridge to acknowledge a request. During intensive workloads,
> this handshake intermittently fails for V3D's master ASB on BCM2711,
> resulting in "Failed to disable ASB master for v3d" errors during
> runtime PM suspend. As a consequence, the failed power-off leaves V3D in
> a broken state, leading to bus faults or system hangs on later accesses.
>
> As the timeout is insufficient in some scenarios, increase the polling
> timeout from 1us to 5us, which is still negligible in the context of a
> power domain transition. Also, move the start timestamp to after the
> MMIO write, as the write latency is counted against the timeout,
> reducing the effective wait time for the hardware to respond.
>
> Cc: stable@vger.kernel.org
I think, a Fixes tag would be helpful here. Also this fix should be the=20
first patch of the series or separate.
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>
> ---
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: Ray Jui <rjui@broadcom.com>
> To: Scott Branden <sbranden@broadcom.com>
> Cc: linux-pm@vger.kernel.org
This looks unusual. Is this intended?

Best regards
> ---
>   drivers/pmdomain/bcm/bcm2835-power.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm=
/bcm2835-power.c
> index 0450202bbee2513c9116a36abaa839b460550935..1815eb4ee69b9b672b5e3144=
02f1cc9897c57dcb 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct bcm2835_power =
*power, u32 reg, bool enable
>   		break;
>   	}
>  =20
> -	start =3D ktime_get_ns();
> -
>   	/* Enable the module's async AXI bridges. */
>   	if (enable) {
>   		val =3D readl(base + reg) & ~ASB_REQ_STOP;
> @@ -176,9 +174,10 @@ static int bcm2835_asb_control(struct bcm2835_power=
 *power, u32 reg, bool enable
>   	}
>   	writel(PM_PASSWORD | val, base + reg);
>  =20
> +	start =3D ktime_get_ns();
>   	while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
>   		cpu_relax();
> -		if (ktime_get_ns() - start >=3D 1000)
> +		if (ktime_get_ns() - start >=3D 5000)
>   			return -ETIMEDOUT;
>   	}
>  =20
>


