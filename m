Return-Path: <stable+bounces-269448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dDKhEqGaQGpAggkAu9opvQ
	(envelope-from <stable+bounces-269448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:53:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE046D30B7
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:53:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269448-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269448-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D112C301F48C
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027852690F9;
	Sun, 28 Jun 2026 03:52:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B717BA6;
	Sun, 28 Jun 2026 03:52:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618752; cv=none; b=NWxIXNaEPrMx2124wmpWefbftWdrgan6YAGjTjDgUi7XPkcIk0mfPjoicz9ksVJzd5qDtai1Ga+NQPreLpxnAG7l9fi4YElTgj6iiil6/Qp2pU1P6C1mjTy4zCfM57MKfaiDwwL89OHHQTWFdLfPfuLIbGvavFTcclbc+dHaD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618752; c=relaxed/simple;
	bh=GomhzOhZVAiJldy3T0DatO4rFyt1Q1Y1fzp7Sr2RAeQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ukuPcJuoX2T0BwOP/fxXDMSTD4PrfsOsuLCBavoZ4k8SZup6T/D5nWrGurOWvDrEac7bomBSBQ9A5i9v2ckpHwpjMHkWsygkkagGfvmAZ99ZA5jZA4z/kXJLU8YGwZOmIRJ2XkMc5eMWDmU0+ROOkee3i3XFRQi5C/wPFqHcYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAA33NRbmkBqExKqAw--.34181S3;
	Sun, 28 Jun 2026 11:52:16 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: accel/habanalabs:
 hl_cs_signal_sob_wraparound_handler: missing   hw_sob_get when need_reset is
 true and encaps_sig is false
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626104453.32301-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:52:05 +0800
Cc: kees@kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <20710ACB-AEAB-473B-A9E5-EE3116A46ACB@iscas.ac.cn>
References: <20260626104453.32301-1-vulab@iscas.ac.cn>
To: koby.elbaz@intel.com,
 konstantin.sinyuk@intel.com,
 ogabbay@kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAA33NRbmkBqExKqAw--.34181S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4UZrWUCFWkArWxKr18AFb_yoW8Ar1kpa
	s8GF4rJF9xXF9rAF12kw45ZFyrW398KryDua1xG395urn8Ga4xJ34Y9anY9rWUurs3WF48
	XF9FqayDC3Z0ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
	6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU07rc3UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2pAixEZHQAAs7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269448-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:koby.elbaz@intel.com,m:konstantin.sinyuk@intel.com,m:ogabbay@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABE046D30B7



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 18:44=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> When other_sob->need_reset is true and encaps_sig is false,
>  hw_sob_put(other_sob) decrements the kref to 0, but the matching
>  hw_sob_get(other_sob) is skipped because it is inside the encaps_sig
>  block. The function returns other_sob with kref=3D0, causing a =
subsequent
>  kref_put to underflow. Fix by adding hw_sob_get(other_sob) in the =
else
>  branch.
>=20
> Cc: stable@vger.kernel.org
> Fixes: dadf17abb724 ("habanalabs: add support for encapsulated signals =
reservation")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/accel/habanalabs/common/command_submission.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/accel/habanalabs/common/command_submission.c =
b/drivers/accel/habanalabs/common/command_submission.c
> index ba4257bda77b..675301dfc0ef 100644
> --- a/drivers/accel/habanalabs/common/command_submission.c
> +++ b/drivers/accel/habanalabs/common/command_submission.c
> @@ -1860,11 +1860,10 @@ int hl_cs_signal_sob_wraparound_handler(struct =
hl_device *hdev, u32 q_idx,
> 		if (other_sob->need_reset)
> 			hw_sob_put(other_sob);
>=20
> -		if (encaps_sig) {
> +		if (encaps_sig)
> 			/* set reset indication for the sob */
> 			sob->need_reset =3D true;
> -			hw_sob_get(other_sob);
> -		}
> +		hw_sob_get(other_sob);
>=20
> 		dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
> 				prop->curr_sob_offset, q_idx);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=


