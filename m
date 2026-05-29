Return-Path: <stable+bounces-256634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKkONNiXGWrVxggAu9opvQ
	(envelope-from <stable+bounces-256634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:42:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69324602FF5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B2B23160AAE
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBFC3385B2;
	Fri, 29 May 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Lo9E5V+A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4e7HwEX"
X-Original-To: stable@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304130E84E;
	Fri, 29 May 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061960; cv=none; b=Z1BsWw1RhG96P2QrLY1Qy0mH9aPzY02Sh8/XqEZWTSzxNz7X/RUqd4U4oqraKW5lD9bBjEtV/1yJo0sgyYeL/tAoNOTRxIKK8Pt54+MIik/D/RJ2QDttKqMtOAK0iuSBhxP9fayVEMMLBaWKAL5ZdADn6Y0Tm4TE7vuPXk6wEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061960; c=relaxed/simple;
	bh=y8t00ur7uXmiajJe2YfDx54F9I+lF1FFYTdJA+RSpiY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=THO05Fih34iZ5y9CfcsrgpBm/7x3c1NGNdhhlhXsZjTuYhjnh2+Xf47li5q3W0y1rFTICaoVlCcb7dqNUj3XuHs4ShWELlVi5tJvgafMU3GOPyEFNPcR4m/X2nV90tNSni+DP+h+POIwPlnsqS8ETs/Yf4dMqsvATIWEu3SUg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Lo9E5V+A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4e7HwEX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AB2111D0012F;
	Fri, 29 May 2026 09:39:17 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 29 May 2026 09:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780061957;
	 x=1780148357; bh=dijpLU+OU7oGppfwXWO2pPWD4SaRJOSfT1ZxhEnI80s=; b=
	Lo9E5V+AZL+GiAHP4+j8owKk2lO0iOlOEcfTYsz4aXEz8bL7ZnY4EPL6cuyhJuKF
	Y6b1sBPh6Ghrk5t6ZoK4vnpaf6lMlrBCL175Kq8Uc8VKotoIWt7Bl1mzYMO5avEm
	7l9EA+oKCsdohu0ntJigWmz0jTuYK5LakwTUhhNtIrNFY7Ncc6Yaio8H9/WySJDz
	K9CAzp0DpcTiXz+ltW0A3bWhFG8Ghjdi88yaiSsTCfYbBmQVshOvi8Ed8+xKu8y0
	cskhNLOvTb6qescVEiTwk6qGfg5f9QRjTMUvY5f+J8RSd21lMALfqF0E5Mxhdi73
	HdwkUCM2RUuPLb8/Q1ufxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780061957; x=
	1780148357; bh=dijpLU+OU7oGppfwXWO2pPWD4SaRJOSfT1ZxhEnI80s=; b=k
	4e7HwEXRVNh6dH900tHVwoL7ogfzg7KG3xdLfAFyAiYv3GRBwARAIMCTAfyG+bCF
	tpoEr921JcUq1xlDloncqsLNJ6AGH7Qp/MRcYe+t4RLBlmLk1QdrVDrTbjOgwCdU
	bW4JhmJSVGnfuHp6LzrNkODwJt6bmcfhF86OA0ui0QrTgOGOKSqAT0sDeEhZOdmr
	aBhrJim3pno17MpxdAsdPMQ+4D47mPk4AhkLCa449FgkG6qCa9QJOo6hvsc2xUC8
	UIP8ubjbMfa6kebQ2RyWL7yyVtptJPwrQCEboNDG4usYYlTaVI2XhbbGJduxQnFu
	JRFtmbEyONFtVZB8CS47w==
X-ME-Sender: <xms:BJcZalCWshej6AmMmJXaY_6zBVacFwUK7u4zefuHmr_Mz1Jiqi4iRw>
    <xme:BJcZauWzZFebLRwx6O8-trkwKe91XRP7xKJnCB_qZWbosiuRkIjqJbywp-etEJLd3
    55UrTOTDfAfa9cncsrmPNaEDXkWzn5atnQhem9hdrR5LKchUbpkizk>
X-ME-Proxy-Cause: dmFkZTGyRrIgFgQ6qfer+Y4a1h2hQq6z7xkQeot4goKpuHSqMIzgKw47he6xTaYx2ppKRa
    VqvD1CTTOrF9lbkxxeuSc1JZk3o6VnpMitGIIDR/YC3t8SVtOqJyFHkHw5x3fk8hu4gw4z
    FOGLeRY21OB6MM/Gufhtmf5TbvS8+zZvhpro4mmVIbzRBstlAYcH4RKIEQduH7m89NY66z
    5l4IPLL2B38MOxmhI/2RVQQRxFkJfsM1cCWOQJlTz6yfu1CFqgWrqqQvf0BYGjr80yIv2Q
    ZByDnlVnbFzNzAP6QRxmyyX2lSVWFBYkykG62xXXsUcBdPeYs7q5bJ6EKHzlrvnRdEfvKv
    iW7rxVF0SWC3/HI545Y1U4SwZ3bpvqA+YfBS9FnD0s/5xCYVx2kRh/5eNbm0ccCeJiFFNl
    g+WDJciGwQWuioJVW0i/8uWhWk+xYxe8hvTEsWhD2xWpO2ECT9SusERqhWOUd93qDRZMX1
    +p+d6PDvYHyOrIvDZdRBQNOkwEkwdqRWVgvvoIvk7KLliPVvf3D1OZ59RzVs4kZu1j/2ed
    nhmiU+WICvO97G1nWX8KCbVDYgNAngwT3+BthY8yLHGNyS1vbQjurA2IxStDiOWJSFDpO/
    SBKHkpUcHhl8Z3HasfHDtpvtk3rISL2zRhGJ1Re0nkZFed8Rhwp+4A7uyRsg
X-ME-Proxy: <xmx:BJcZalmCK4e3Ic54lPmbCwKLn9HE1cZbVaecAebrT12EKo987ihSGw>
    <xmx:BJcZaiazXC_cC6W9gQDrNLB0dNNsaYKrtAj8Q31zqVGysp5V4qF53A>
    <xmx:BJcZaq4B_9TqZn9TAgDUPRx40h8zrarbk5xtL6NvK0r2igI0B69ZPQ>
    <xmx:BJcZasDcfGcxG8N1ipfTYGLyhCuAisAuM2QLcPpM8eCruxUOe7S-Kw>
    <xmx:BZcZasHvx4WBlV5jYiCc9RHyNL1NH40bZL6NS_ZGrXwXXp3nwRj3mZQp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9E60B182007A; Fri, 29 May 2026 09:39:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIgwaTVwlN8Z
Date: Fri, 29 May 2026 15:38:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Peter Griffin" <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org
Message-Id: <d6663bd0-178e-46d6-af3a-69b8be197375@app.fastmail.com>
In-Reply-To: <a7994860-24a3-4f87-84bf-109ed653dda4@linaro.org>
References: 
 <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
 <20260505-acpm-fixes-sashiko-reports-v5-3-43b5ee7f1674@linaro.org>
 <03dc9ccc-d819-413e-b8fd-23ccd85675ba@app.fastmail.com>
 <6c77d706-5944-4e7d-8a4a-b3a6cac6a83b@kernel.org>
 <a7994860-24a3-4f87-84bf-109ed653dda4@linaro.org>
Subject: Re: [PATCH v5 3/7] firmware: samsung: acpm: Fix dummy stubs to return ERR_PTR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256634-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,app.fastmail.com:mid,arndb.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 69324602FF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026, at 14:37, Tudor Ambarus wrote:
> On 5/29/26 3:09 PM, Krzysztof Kozlowski wrote:
>> On 29/05/2026 13:51, Arnd Bergmann wrote:
>
> I confirm that the ACPM protocol is mandatory for the clients to
> work, thanks!
>
>>> the option space without losing any build coverage.
>
> nice, I didn't know this. I guess it's a "greedy" algorithm in
> allmodconfig, if the dependency is met the dependents are enabled too.

It's not even that interesting I think: the way I understand it,
the values (=m for allmodconfig, random for randconfig) are
assigned first and then adjusted if dependencies are not
met. This means with my change, anything that would have
CONFIG_EXYNOS_ACPM_PROTOCOL=n and CONFIG_EXYNOS_ACPM_CLK=m now
turns off EXYNOS_ACPM_CLK as well, rather than turning on
CONFIG_EXYNOS_ACPM_PROTOCOL, but this still covers all
the combinations we need to test.

>> Sure, I am fine with it. I'll take your patch with a bit adjusted commit
>> msg.
>> 
>
> Thank you! I need to drop the devm_acpm_get_by_phandle dummy stub from:
> https://lore.kernel.org/linux-samsung-soc/a59c6e3a-6092-4114-8961-c2a71a812959@kernel.org/T/#m0ac077507129c37b84443513eecadd70b5eaf8b8
>
> Shall I send again the entire set?

I'll just send my change on top of your 8ad2c29d53e6 ("firmware:
samsung: acpm: Add devm_acpm_get_by_phandle helper"). Since there
is no way to hit the actual bug on a running kernel, it can wait for
the merge window, and that way we don't need a rebase.

     Arnd

