Return-Path: <stable+bounces-210720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJJJGVKncGlyYgAAu9opvQ
	(envelope-from <stable+bounces-210720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:15:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F09550D9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 385AB6264A4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7FB48164F;
	Wed, 21 Jan 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UJmHLl9Z"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40E34EEF3;
	Wed, 21 Jan 2026 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989804; cv=none; b=REtFhQmCB5bRW4Kk5LVtg1TFmvWK5wRsOMO7s9urGqTw0or5A7X9wfDYFMgFsconYvCnAJvOEZcws5tpN1v6nWQDZZFlNJh8H+5SkaX6hAA1aRu+x0TIsjpVKHH1Fl2gB/xbO5lKXdO2an98HePW4Lh9q99XYH74I465sYvg10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989804; c=relaxed/simple;
	bh=FTO9/uzHNjNuNEN2VtUnN72iAI39TGwpTZSsqmbwvb4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MMRq/g/zDdxFqkobtMPmKyVCaJ5UUHHssZZeZQTJLCeU8dJBze1ZjOvSCgXdy85dtDXkwBU2ovX2dTOM/mmtTmlRhtLyTm9roa17NTacD4mdtyc+Cys4o8Mdpp5/LYl/YGmc+MObtDtz/BRkxNPUYS4eAGH79E6VBcuyuOnSUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UJmHLl9Z; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768989800; x=1769594600; i=markus.elfring@web.de;
	bh=ZsWZBFVJo9bVgvjglTOcPeP7CI265mAlH3UOdBK2uDM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UJmHLl9ZibHgE97NP5IBn1olG6U1vwJChSVUcxzQZnY5Xafzu7eZSnnC77uF9xN0
	 UIE0pV0SoKEYA0QinMgr21Fa/osmoAIj1M3lGJnumqupf7BxlpFDDB2gHYbuSDpCF
	 WubXnZye9PHmbfDt0LpeJw8Hct51E9FNDjhh5FmmHa2415wmGrWkPuCX/jcjjRA97
	 pum3oJIDr0Gd2bIrxU3d/7SepaavKJF+oDHMdVQGrVJjwH0Pk/QvU4DyHNs2Q+Jtu
	 2ZhfoZrY/8Gq3HuGTdFcRkLxXf8E9HlRRz6qCtQdkKUoEYggCPxernt5yEhirRu/3
	 wNFhd/UP6+dDJSPaQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cHJ-1voBZN0RV7-00rG86; Wed, 21
 Jan 2026 11:03:20 +0100
Message-ID: <398b4dab-ee76-44f4-9bfd-4388af954808@web.de>
Date: Wed, 21 Jan 2026 11:03:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, linux-clk@vger.kernel.org,
 Brian Masney <bmasney@redhat.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20260121012223.186199-5-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH v2 4/7] clk: st: clkgen-pll: Add iounmap() in
 clkgen_c32_pll_setup()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260121012223.186199-5-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PBi0TVponyOI0FoKecOdSGrK6m2hflb5zk6sTYt+XLvXsHwKRCN
 A/uhhnw1wUv5pUrGieLCGgW/I9QgNbed37LHVYPQUDeyPoGiaU5eGUNLVgUCD0rq3aWxSK8
 Tho5ILN/IVVia+0BmePnsxOlG0DpKAGFZeCAVXjtbCjKy4dQD/E4lJ1DVtqCrWg0FTQ2T1K
 41Hu8x3yBN2d+8nGz41Tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dxh2jFcCtJg=;XXfBi4TIpFByW6y5cz3bGC0exQt
 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
 V0eYtacHLqfW6Uf+aWtXOkGZ5i5Rh
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[web.de,quarantine];
	TAGGED_FROM(0.00)[bounces-210720-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FREEMAIL_FROM(0.00)[web.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D9F09550D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Add a iounmap() to release the memory allocated by

      an          call?


> clkgen_get_register_base() in error path.

Was such an improvable implementation detail detected by any known source =
code
analysis approaches?


=E2=80=A6
> +++ b/drivers/clk/st/clkgen-pll.c
=E2=80=A6
> @@ -829,6 +829,9 @@ static void __init clkgen_c32_pll_setup(struct devic=
e_node *np,
>  	kfree(pll_name);
>  	kfree(clk_data->clks);
>  	kfree(clk_data);
> +err_unmap:
> +	if (pll_base)
> +		iounmap(pll_base);

* I find this pointer check redundant because of a previous variable check=
.
  https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/clk/st/clkgen-=
pll.c#L771-L773

* I suggest to refine the goto chain a bit more.


>  }
> =20
>  static void __init clkgen_c32_pll0_setup(struct device_node *np)

Regards,
Markus

