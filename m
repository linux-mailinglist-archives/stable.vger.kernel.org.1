Return-Path: <stable+bounces-177029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E7B4014C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 14:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F444E01EC
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B732D4811;
	Tue,  2 Sep 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mj2j8lo/"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1B2D3A83;
	Tue,  2 Sep 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817539; cv=none; b=n7wBUm1ARM7QCKC3Uwp4e2JbboYvd2u2BYcgm7MxzMUMDj6ZKlayZZ85RN0t3X086DwQqV76IT+7EYUDR30Cji9Zw2sTKXplGQZEJ5mQQVh4GZlXOjABYELZA6n+ak2fmnjy1nDhC/UXnnZlERi1UVQQ5SxSL/FVqdU9x+2z9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817539; c=relaxed/simple;
	bh=reexSCc7FzfzCalgvYtcU8RoHVEWzx64fO4D1kUpOyI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IMEuCYEpjfdSZnKbJU1b2mjveLlCsuFXR0YtRqtYRPVgHcth0NBeIErAEa6rOz69dvfp8/NzJM+gpDc1XMMUDbXG6dChjknz6DZsc69a/jSLrDMSmOozafleBJcb+Y0uT/Vs+B8fZH+Og8gAPmWMMDzKWJvj1a3DSgolwluXNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mj2j8lo/; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756817534; x=1757422334; i=markus.elfring@web.de;
	bh=aIqtaMgsw2kVJtZdIDJ/J2T/6eEj7qhR42RKHrVIvmY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mj2j8lo/BxhY3hoUGU2wFHTrjFhLaM9Bya6qNOkberOZSoGTo0EDwLX7xq+hVeJR
	 PSpt9+lO57icF8tj3cJA/7QsjMSEkTqy+WzbC5CLOdAF8o64L8AFLMdfbu9xv4Re3
	 HP5w3Quvy0dfWNQgp+vl9W/b05xSeLFyVfndIUOHFaRcw1+ydZnRhtE9dxYm+4wFp
	 zpG0pLp6xAmfCKaClJvM5OGfiGQ/c4j/plt8k5b50Ke0IcgBmiHDv5pyVbpEe9kNO
	 TcdZhFbxEjimww6VbBVCNPwkpkbySnDoYOvorsQLzSiVkWxLztNnfaPuAkvzYuJBz
	 wX+06lkp97ZcztOfzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1uNaLz0kHV-00xN5P; Tue, 02
 Sep 2025 14:52:14 +0200
Message-ID: <71a7712a-7a1f-427a-80dc-906e968c3583@web.de>
Date: Tue, 2 Sep 2025 14:52:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>
References: <20250901073224.2273103-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: Fix fwnode reference leaks in
 mv88e6xxx_port_setup_leds
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250901073224.2273103-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lv2Vp4zoFMIurQXXYmpPYWOK1eqfT7sg0JHGl8cu3ExnL+86EAc
 Se4sh+rLQBY2BBg4xRIz+29NhnES06/GGeSoZY9NdmMLgw/F0AcT9UYPd7CrJVlxqx2vJFv
 p6H05dVnG21PFaPjiJyytqirIxHFa1gIRaLi23O0NoExGQtmBzHkXdsF7itPUjRX5sr7uN8
 NuyCZ86zKnC4nbUwoWKGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q6afCw85rhE=;bqG/IYRDIoFhqzUFiJjadtLV+Kw
 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

> Fix multiple fwnode reference leaks:
=E2=80=A6

* How do you think about to complete the object clean-up by using a better=
 goto chain?

* Would it be helpful to append parentheses to the function name
  in the summary phrase?


Regards,
Markus

