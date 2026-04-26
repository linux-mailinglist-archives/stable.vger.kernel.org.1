Return-Path: <stable+bounces-241159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHYMHc+87WkInAAAu9opvQ
	(envelope-from <stable+bounces-241159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 09:20:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD36468F4D
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2739830160E5
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83842BEC5F;
	Sun, 26 Apr 2026 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="M/i2nYK5"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDEB7083C;
	Sun, 26 Apr 2026 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777188040; cv=none; b=J1wwhsipNLs4zTkkI/vhJeJXosu23bFQsLFURn1iEgwcWlkIFP2mNewg8BuuG6pwfHQYyDZHa6fxewLy/wr8cDC1xIzl/eEadCw+pcg6jh7eIAqy4g5zKUyBufXsnMZDuQIrOh+K0pizB0tobQUNTEukPmz3F+9D3Ixo+5AwfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777188040; c=relaxed/simple;
	bh=4/pLqUd06AAde45L6yuzg4t69PYAl2sWshOwgERbD+w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kWM2n7I8H3hxWPOXpMTU2NLcXv16Gf83PN6xvqysaLWItEshjaI49Iysqw5GshcqTFlNvTOl60anU1zXtwysxYOLd6Ce6C3HEju1OEZwqlOwzdEMAGq3rJvOdh8gFibpv9YmJmA66Q9p1goZTtceXOoNdEDP2Pe4ByiLSQBBp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=M/i2nYK5; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777188035; x=1777792835; i=markus.elfring@web.de;
	bh=1J7QaMP0mZ3aZ8Q7RosVs43+dysGw9YCcECBDq5aN5M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M/i2nYK5RJ8STuTRvbqRv6hlWQ5ek8mE69rx3YIJI1r2qhezP9TOWDE8NeLn0jYh
	 MtEDZ3eWLkCOKQRxeBN0eSYA4cIaiv7BT71ZuMusQma/LMDX0vW61AVvJSVwnVXwb
	 ToGjGC5d+i52FkHmDJ57HcSwTTvVxhyjVm/z8tj3u2JNNxB6nczji7hOvxqIv79Nb
	 8mb0GE/alp8w320Sl3R1a8Z9nWwaSk6U4WaeyEBB8FEmGhz27SzI7KFM09Nc2Tnap
	 ommgdkEQoejXhNoxezt4C5Rjyk+CvUKBFpcHHZbetTnthYtof5ddf6cx+DbOAqFLG
	 QAH2v0VUJB5f1qymgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8C09-1wLYlE1kQN-00CgZx; Sun, 26
 Apr 2026 09:20:35 +0200
Message-ID: <0d7be98e-ab66-46ab-a729-b344500356a6@web.de>
Date: Sun, 26 Apr 2026 09:20:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Li <Frank.Li@nxp.com>, vulab@iscas.ac.cn, imx@lists.linux.dev,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Georgi Djakov <djakov@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
References: <adceUA7PkOLjgyOt@lizhi-Precision-Tower-5810>
Subject: Re: [v2] interconnect: imx: fix use-after-free in
 imx_icc_node_init_qos()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <adceUA7PkOLjgyOt@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N/4aGxbZaLhQPHDsNJDRc9fAJLd2rnfZaqh6cCek3W6t7UqtXI2
 71Yupdo9R/76uUwcYO0axILb1yzXnh4omLaAnh2xBKzE5wh/zKaBMANKRkT85lXs4aKXDvR
 dXXYWgtRYIY8NMWe/sfS6Sbj/i9TXul+FruoSeqJy9XQJeYHzX8LFcvqj0LwiNVtattsWZ9
 zmmxMJNeJkifPbJkvHE6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V08j8qviItc=;gVl/wHb8+mccE1Qmw1FD3z/j3Ew
 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
 hc258dp8IxouseA==
X-Rspamd-Queue-Id: 1FD36468F4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241159-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[web.de];
	TO_DN_SOME(0.00)[]


=E2=80=A6
> > use dn after the put, leading to use-after-free. Convert to automatic
> > cleanup using __free(device_node) to ensure the reference is always
> > released when dn goes out of scope.
=E2=80=A6
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

> >  drivers/interconnect/imx/imx.c | 6 ++----
=E2=80=A6
> @@ -120,7 +120,8 @@ static int imx_icc_node_init_qos(struct icc_provider=
 *provider,
>  	struct imx_icc_node *node_data =3D node->data;
>  	const struct imx_icc_node_adj_desc *adj =3D node_data->desc->adj;
>  	struct device *dev =3D provider->dev;
> -	struct device_node *dn =3D NULL;
> +	struct device_node *__free(device_nod) dn =3D of_parse_phandle(dev->of=
_node,
> +			adj->phandle_name, 0);

=E2=80=A6

A typo was overlooked somehow.

Regards,
Markus

