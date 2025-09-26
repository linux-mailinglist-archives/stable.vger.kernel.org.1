Return-Path: <stable+bounces-181790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D9BA4F61
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 21:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FEE3AD79D
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB7F27B500;
	Fri, 26 Sep 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fxNclzh+"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7A202976;
	Fri, 26 Sep 2025 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758914939; cv=none; b=q18JeJoASOqTnynCczAfVHkZkTxgU4EdWrcFPcypxJwGZFIjvHtXCdu/dYngGG8i2G2pPScG/ZvuIjB7xleShG+4/HRLjwrq5VU59v2mVZKb2uFuF4/u+UZ8mCoHhkdEkNjTwKIkYAqMsrLcMYKlhNgmuASCG4+XQFyHGb0+MnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758914939; c=relaxed/simple;
	bh=1X9v78ltgesidpof57mWkDrgYu9W3wMXPNpxjX5pCYM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ORvVnn4TlsaecXcpoYmkc9TC7SSsbjLAi0Y1NyNhxUQAre7nKVsjfQ8/FIITnrbNBaoGXpkLwhcAs8yVNVI2w0IsoaUUk+QA26MeoFMcfCYUYhOTn/F9Hnm9G4Z9CAsXdCam/gC+LkUIEKLYYNDL9A5BhuEpNbhyclFABgLBJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fxNclzh+; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758914931; x=1759519731; i=markus.elfring@web.de;
	bh=1X9v78ltgesidpof57mWkDrgYu9W3wMXPNpxjX5pCYM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fxNclzh+TsDRFi9gQSbq6Tbr5lv7LD3kO6xz8lkrNNR8QZKNk1wDMugpYf0K1Za0
	 zAInZWIgdW7wYYqddPbUQ9YNKYkUkK9NJ/E+2GiMyo01vR8b2S1OBcCl9/aSfBbRr
	 +cjAcnpZAxehIXXyEiLiQko6CpcRaw9s6v63UT2BLiU6/NhVQ7UPiwKyG55kOzcfm
	 r4106B0nsuBsY0V6Ns94HYXoXlmQEbyVmBYHLN7PXUP1b/1AxS59tAjnllJrrJ2gQ
	 UAkq4yWEuTT0hgpHGbAQmnRUNvXlgpaZ+L8ZP/6x5cl9qy54QFxQxS5OGAxEtt1vP
	 6JGUAYo7FHW8QkBCDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mcpuy-1uSLPF0Gws-00o09T; Fri, 26
 Sep 2025 21:28:51 +0200
Message-ID: <28ac4cf6-f6e3-4c02-b4d5-8cba6d867318@web.de>
Date: Fri, 26 Sep 2025 21:28:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan@kernel.org>, Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250925150219.24361-1-johan@kernel.org>
Subject: Re: [PATCH] mfd: altera-sysmgr: fix device leak on sysmgr regmap
 lookup
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250925150219.24361-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LeenfAnobQB/BiT+p3A12FzTELDy6qMO8hlFJ9bKUVRlqMCEq19
 dQDJs1MUI9TrT/Bcp+D3hSRhMifa6m48oK+bXVRWmMaujEHltdGQynPtKuA6rvolwhr83+1
 kU89lCNLYUb7sReYql3ZfzmmzT6JbpvPz4leyIpAgXD3Scuk8neN8RiHW6WZkgbj1U5rjbC
 znstWJ44+uFutya7edIvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cv3FhLB5lgs=;OosAEUO2EN4F6x+/DBEEZ20b4fW
 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
 X

> Make sure to drop the reference taken to the sysmgr platform device when
> retrieving its driver data.
=E2=80=A6

How do you think about to increase the application of scope-based resource=
 management?
https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/device.h#L=
1180

Regards,
Markus

