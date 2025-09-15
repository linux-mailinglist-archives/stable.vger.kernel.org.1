Return-Path: <stable+bounces-179638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A795B58160
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76226482A81
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD80237707;
	Mon, 15 Sep 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dBIFRP9B"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EA23027C;
	Mon, 15 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951754; cv=none; b=D9oH0HHoAE1xgCi9a/dFoUoBm/a8Jqd7/4cR4j/3ZkDn1e2Q5QWhV1SXGaVIkM4mZ8lMTXfeeo7ydtA+ddV3uyUlHIgQ8klxLn9g+jC8wvbW0IIUMNdGY4IrWYhuRmdQORVKPJ2WH/vy5Bh2OL3cgXXNxQ/6smltohyBOSA3JcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951754; c=relaxed/simple;
	bh=9Ylj+KzTH9vTDRBTmEGMdif4jpb2P9stolja9VHdGxI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=K2xc6h+05jXBnRf7T0SALk+yYenlzXATqaor1Jhm20vHZYRz+0HNQKbGv9vbDrmMN+RdZC7iltjgsaJOl7/5KDOSqNxc4r5WUTsf8FibVSi2VSpi2ep4ymHwTNUJhq0pqcWUjuiY5ekY4mE2UztV6f1FL7yeMEcueViSIRlF7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dBIFRP9B; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757951724; x=1758556524; i=markus.elfring@web.de;
	bh=9Ylj+KzTH9vTDRBTmEGMdif4jpb2P9stolja9VHdGxI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dBIFRP9B735OIez3xrROTWXCxxzp6Qibi1UySlPXHi2vZBV0pV3Tl6HsV6g8k6aO
	 1NvIFp9LUwO4xwD/mVQ/eUxKQPyCaUwGn6BRiySK2vBsPW62ZNZ+zk8RGvdBVM+Cu
	 TJOdCsNwHPNExHv53LSIjJ/Op0MycfXtkdYKWB6jiABNzMrURJDRqa1H1z7H+AAQq
	 oXOEVyKI+qcYzeQSXJQehTk36pIa3hMP/2NQ8Sf8BUUHBccB6t1Xc/9YnY1xyoa67
	 +iYHmIh9fJ/bqBa7qwNVjd33aZqWt5wuG3PEWNyHE5KTHupcic2Vmuh8+hqDyLHgG
	 OeqiF93mQC7xeqgcYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.188]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7WH-1up9Ep2pe3-00QpFi; Mon, 15
 Sep 2025 17:55:24 +0200
Message-ID: <d6cb8ec6-daeb-4e27-8c86-c49bfc69f718@web.de>
Date: Mon, 15 Sep 2025 17:55:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <haoxiang_li2024@163.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Miaoqian Lin <linmq006@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
References: <20250915114629.174472-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] clk: tegra: tegra124-emc: Fix a reference leak in
 emc_ensure_emc_driver()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250915114629.174472-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NGoJZBwXzmpInjV8+j/CIO9plWGkQ8VHe58XZtLKd3oOK64DsOB
 FK294vS8790AZBYP95ep4WzGMkx94MiK0gk9PdAVISLXpeby5qpV7x+NJDfz81aQpD3sMqk
 vwhPN09JBimpeTTvdyskBV1vhEE+zY7B69025qGraZGf2V5bBe8ysbxIa8EcxXhfHfuioMM
 DOkpNxBrmbpFJRdaasAwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4C00tcoXtlk=;/UX1/228cBz3ODBTfR+2ZPbaYCL
 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

> put_device() is only called on the error path, causing a reference leak
> on the success path. Fix this by calling put_device() once pdev is no
> longer needed.

How do you think about to increase the application of scope-based resource management?
https://elixir.bootlin.com/linux/v6.17-rc6/source/include/linux/device.h#L1180
https://elixir.bootlin.com/linux/v6.17-rc6/source/include/linux/of.h#L138

Regards,
Markus

