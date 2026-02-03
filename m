Return-Path: <stable+bounces-213156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Kx0MeFhgWn6FwMAu9opvQ
	(envelope-from <stable+bounces-213156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:48:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E438CD3DAD
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFB9E300723F
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 02:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D899322527;
	Tue,  3 Feb 2026 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRVd/TcM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C43E31E0FA
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086874; cv=none; b=qksqPZ/X8aRdyRdl+7C23n5Dg5J/t9aW1MhwZXMEF7a7RYb0Qxq3AkFQXrmnA2VhgiW4LeVUDTzbEnUi4lW6cC2SPVS6VRtIc6pKh+yvTvIJzzFhko6gFt/hHVatKkiRESlFhPDrXEGJ+pwOAlg9iIhPodjLN2BqjLI/hJKhPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086874; c=relaxed/simple;
	bh=opVN2Uy5CV1GyOyVv04l4w99A8x7CInPOUJcM14Wc7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubb2Jz+lQMjU0lMaUUmdIsiKbcfj/1aiT73PwhPpSWRKhHOE7osKvbci+Tr5stPDvv+F6MoSHcvn/ltJjy5t56xQh89eOmHECDElTEefO2TZ06IL+GdHJNZJZQaaFhULeW40oZgNqH2XaSFwMX+b2+zHbbhhLonePvmC02Q+nx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRVd/TcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02340C2BC86
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 02:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770086874;
	bh=opVN2Uy5CV1GyOyVv04l4w99A8x7CInPOUJcM14Wc7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YRVd/TcMoUZlvY+H99CsGdndoLhglHsDtgWv7HfE80EuYIBtcCTS3vFznCOKoqJN/
	 3NfCqaxcycvj5SPWAs8sVCr4v6m//exvtJU4BVFhikDMxb9VHCNMtJM8iMXAV9MG8d
	 FKyi7QPHw66JbIyee7LdImDlxqQugbTJrKej8Vmngw/XzdGpzfcSEPrLjYuqDjfW5t
	 Ad+ejtqkYu+VFI1Ym5Bi5QSpz3HHGb+vn4LopccWzBluWsg/tZcz6UAi2Gd3YjMwFq
	 m0ZpQBCHItjUwKNG6MITYDOShjpF81xMcMRW4vQJCGFUtHniRO5cvan9H7JNF1am+q
	 6pka2kOvpCr+g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8845cb5862so806082066b.3
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 18:47:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgnT9ZVC8Ug4ekkrmYOF01+TS8jjFxnwbpcdReuO9pdfZd4Td8dH3MNr5ZzX2OhL6oSr8sMWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywonj8y0L6kZLQjdbjfSm/4t9lWQA0E38jPoBJNiNqENu859wzx
	HYt4SaD1zOIXmv3SlVOwF4YnY0k2nocFfbBWC23eE2Hvv7j0iZrB7STWJJEPLQddeAL+TuP1+bz
	yic4AR9LVQxLBTFkltdN0ayOxAmfqv+E=
X-Received: by 2002:a17:906:478b:b0:b88:7568:26d5 with SMTP id
 a640c23a62f3a-b8dff5bf946mr825230966b.27.1770086872391; Mon, 02 Feb 2026
 18:47:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201023700.366531-1-chenhuacai@loongson.cn> <4d1abb0c-e518-4751-b462-345ed76bb3f1@lunn.ch>
In-Reply-To: <4d1abb0c-e518-4751-b462-345ed76bb3f1@lunn.ch>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 3 Feb 2026 10:47:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7WwZM8Sg_E0Z0-+e6V-NtJA0r8Aiqw30TqH0_pyLKTdA@mail.gmail.com>
X-Gm-Features: AZwV_Qh1O3Zhzst3pqZnN_WRLwJiAXHYLEQSgCfKfN6tjdg68bwOz8eKRTnfKWA
Message-ID: <CAAhV-H7WwZM8Sg_E0Z0-+e6V-NtJA0r8Aiqw30TqH0_pyLKTdA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz
To: Andrew Lunn <andrew@lunn.ch>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yanteng Si <si.yanteng@linux.dev>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Serge Semin <fancer.lancer@gmail.com>, loongarch@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Hongliang Wang <wanghongliang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213156-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[loongson.cn,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,foss.st.com,synopsys.com,gmail.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,mail.gmail.com:mid,loongson.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E438CD3DAD
X-Rspamd-Action: no action

Hi, Andrew,

On Tue, Feb 3, 2026 at 5:42=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Feb 01, 2026 at 10:37:00AM +0800, Huacai Chen wrote:
> > Current clk_csr_i setting of Loongson STMMAC (including LS7A1000/2000
> > and LS2K1000/2000/3000) are copy & paste from other drivers. In fact,
> > Loongson STMMAC use 125MHz clocks and need 62 freq division to within
> > 2.5MHz, meeting most PHY MDC requirement. So fix by setting clk_csr_i
> > to 100-150MHz.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Fixes tag?
OK, will add it.

>
> Does the error mean that MDC is ticking at 9.7Mhz? That is pretty fast
> for PHYs. But i assume it must work for some boards.
Yes, some PHYs work while others don't.

Huacai
>
> Separate to this fix, you might be interested in:
>
>   clock-frequency:
>     description:
>       Desired MDIO bus clock frequency in Hz. Values greater than IEEE 80=
2.3
>       defined 2.5MHz should only be used when all devices on the bus supp=
ort
>       the given clock speed.
>
> So you could allow faster MDC values using this property.
>
>     Andrew
>
> ---
> pw-bot: cr

