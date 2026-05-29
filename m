Return-Path: <stable+bounces-256607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHCrEet9GWp9xAgAu9opvQ
	(envelope-from <stable+bounces-256607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:52:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E120B601E29
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E85F3053BEF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFAB3DB31B;
	Fri, 29 May 2026 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JzK94IfB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AAgeHqn/"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791723563D4;
	Fri, 29 May 2026 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055499; cv=none; b=PiHCosajZEUae8n7bxqR/Wee3bxj7w1pMw/nMv3+suAhhvonax+f5VV3+RC1jp3hb3M4zOK3pyjqbQiXz7w6i431/6JcuyEZxmWd6dvqj7NHm8mWIcSLl2fwNaTfZesKqrNJKEP9gJaqgg6fnTj9JFvpZslVvqVAYv0UGEQaFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055499; c=relaxed/simple;
	bh=o4GFlSVWj/+jDlv7S6gEbu7/IKbl9bZZUJr5uBZjW6o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tO27SSOIeBTTsolffppComznRhfGpVGKB6Z8SZkK3Cl1tLvvhhF0SqlDSwEKUIGPR7T4SShVbgKM5d3GVJiqDOXPglO/ETU/dINyfmLfRFvRSOQmYignBhf0w4w0iWYPpQnF1poxxNQUZ1AvtGFLXXUPJdXl0YLKetawOdRVROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JzK94IfB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AAgeHqn/; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D53A7A0028;
	Fri, 29 May 2026 07:51:37 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 29 May 2026 07:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780055497;
	 x=1780141897; bh=VJNx6OZ4qZBVWaiEmcIuYAI1+8fMOknxmxIfY6fAGFg=; b=
	JzK94IfB/Wj10ilbbVhYyhyh9svTwvL/VPr3axqhWsorZkpSNRM2+QRX/L4RHXnY
	WX4A7v74zlzegKv6QOTtrfG9VI7wVPe45ga33NZT3YLkSwtC303gvPEcFAlu1AOH
	dA0omNNhAu0Bg0mdG2/X5RuVEPcsOMXvZ3Ujm0sS/HuqE07h+I16hBDy3QD2KRT+
	Cpe7aSk9JriUzRppyDjy+AZJMGy5weXplGNN3KFGGrS50JFvGB61hnFPoSN6ijUi
	QNpbD9UXz6cCXpUAqvnoO3TDvcGIbCDzj3xWCI7mzoP54Tl7iL6kHfTD3f/D8Omr
	88w6QNFzfZuiUpTFJb0xcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780055497; x=
	1780141897; bh=VJNx6OZ4qZBVWaiEmcIuYAI1+8fMOknxmxIfY6fAGFg=; b=A
	AgeHqn/mT2xRwfZvf2CvM0agLuin4YDkYfsrm8uVAP7ZURkUawQ9kvW77bnK+M2U
	kL0S9/2aNyI6iz+Dfl/oS7OVW36f2FppG8153X8tmjd1z5GDEIS5zdpfa5iuYVsy
	O3O7O1mLn68xX0LkWM2zHgF5jlLKOa40pZCQCQHxgMjWENOhO2MiLKaAmKcupIqc
	SWnwUM6gZ4oL6G2JkZxtC5HQNanPLcUe+mTrWhp5OIeb0uwxnHSz9ZUCvG9qGPwm
	BWcB4FB/pzRXp1tRpMlxwSQQUrgUaIUW0vg2SEDP2ECKABceE/qUthlHvCj7gEev
	cGhvTV8phi4gHij9NmJPQ==
X-ME-Sender: <xms:yH0Zaj8uzgIzXsHnbL_ATZ5ydyrMo5b5lh3Z9NY0dN-6V0rerAoplw>
    <xme:yH0Zaqge-Y4QFanlxyEuqkgMsXcTY1q59SrWXcDZnZnZEae4_RfPidGw1-xkaqHYS
    ZBgE1p6977fZ6NCM2kE0mYejl0-x07L8U4sGL4TTxTnrw73b783efW8>
X-ME-Proxy-Cause: dmFkZTEOqfAht6jnJ7IgGiG0XvEGJZLrz8NegVe6R6sYgAFlTHHQVyPuWoyw17obntFV/+
    JmXJgEYHjgkibZCJ3+Lxg/l7rjD8gUZpJosfJIv2nMg/x0ge5U097tsebjyuIJe3bGxiPt
    ob1c8Tc0E0aIaXn1TH4lpk3//a0mUJ+z0lwRi6lNpFNk1JURc1+o91yU92cMKqagvpKJq1
    RlO1gTD7nZ/gTae1UAMc+mGNZ6dWY6tkzi2hIgcl1fAn6qJ7ffNfaqGRONEtfKrtV7eUy7
    VPw7PmE7O55ed1lxy/8OtG2qGdbfhGQycj5WR/YxPPYDQ4JFQbIqGpYmJ9jJyTguvR/gdu
    mIE/Uch51YcAo1S5P4axzLZRCcjPgXR92Gr1fil61GXfMu/fXufYxYn+pGJFZj6MB90uKJ
    xGfug2+8VuuV7xOsTqg/+58nRcvzWX0Zl4nS2XHksErSIiWj7eGmE4NbeHP1gaolwfDDO+
    bmHuJZIyhbeXCPvk4rBk48v5mZYyml7Y16Uqlrg3rZCzxG+gGqtOQbm8/X1d5tDvGJTnEW
    kUtLXJYyGErkcG5ZJi80Rjsn2ZjPjv/4RUSnh3CuOP70vs6Fju7IB7TfXp6+gYfomFtk3B
    S+3kn46kdRUSDQWZTfNaKryDwEhgoZx2u+Q2vwoheIEguHS2TpknAZqNeFlg
X-ME-Proxy: <xmx:yH0ZahgeYq8R-edrkhDq75gq7jWpnYFls4am1DCKfraYjD9OGctSgg>
    <xmx:yH0ZanmdnpRwmATw7IAFYwYHkravIieLfbDHU1eLT9vfb0PgKl3eoQ>
    <xmx:yH0ZagVZGimS9jIenqF9JaS_UQDt16a9zE2VWBFC8e1FC_LqJNJZnQ>
    <xmx:yH0Zass2zb3P8Sm1Y7I4U6iINRCSKiEYJDWufocHPZoFkKku8LT1hQ>
    <xmx:yX0ZaqgNVdvIz2tJ-dWpbNBH2490ByKefS_2Nf_7mTDo_hZljemtSjpq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B37D5182007E; Fri, 29 May 2026 07:51:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIgwaTVwlN8Z
Date: Fri, 29 May 2026 13:51:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Peter Griffin" <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org
Message-Id: <03dc9ccc-d819-413e-b8fd-23ccd85675ba@app.fastmail.com>
In-Reply-To: 
 <20260505-acpm-fixes-sashiko-reports-v5-3-43b5ee7f1674@linaro.org>
References: 
 <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
 <20260505-acpm-fixes-sashiko-reports-v5-3-43b5ee7f1674@linaro.org>
Subject: Re: [PATCH v5 3/7] firmware: samsung: acpm: Fix dummy stubs to return ERR_PTR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256607-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Queue-Id: E120B601E29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 5, 2026, at 15:13, Tudor Ambarus wrote:
> Sashiko identified a potential NULL pointer dereference [1].
>
> The dummy stub implementation for devm_acpm_get_by_node() returns NULL
> when CONFIG_EXYNOS_ACPM_PROTOCOL is disabled.

I meant to comment on this yesterday as well.

Having stub functions like this return NULL is a common way to
define optional interfaces, where callers still work when the
feature is disabled, though this clearly does not work for
acpm because some callers have a NULL pointer dereference
when compile testing.

My preferred solution to this type of problem would be to
just remove the stub helpers and drop the ||COMPILE_TEST
from the one user that calls them, see below.

The point here is that CONFIG_EXYNOS_ACPM_PROTOCOL already
supports compile-testing itself, and all (both) drivers using
it clearly require the support, so this just simplifies
the option space without losing any build coverage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index 70a8b82a0136..198d8b621289 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -97,7 +97,7 @@ config EXYNOS_CLKOUT
 
 config EXYNOS_ACPM_CLK
 	tristate "Clock driver controlled via ACPM interface"
-	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)
+	depends on EXYNOS_ACPM_PROTOCOL
 	help
 	  This driver provides support for clocks that are controlled by
 	  firmware that implements the ACPM interface.
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 83cbd425b652..c73aea30d960 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -68,22 +68,8 @@ struct acpm_handle {
 
 struct device;
 
-#if IS_ENABLED(CONFIG_EXYNOS_ACPM_PROTOCOL)
 struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 					  struct device_node *np);
 struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev);
-#else
-
-static inline struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
-							struct device_node *np)
-{
-	return ERR_PTR(-ENODEV);
-}
-
-static inline struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev)
-{
-	return ERR_PTR(-ENODEV);
-}
-#endif
 
 #endif /* __EXYNOS_ACPM_PROTOCOL_H */

