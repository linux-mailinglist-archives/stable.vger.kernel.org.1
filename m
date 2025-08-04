Return-Path: <stable+bounces-166482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B786CB1A25C
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7556B188DC0A
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648825E448;
	Mon,  4 Aug 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wVqGW/fH"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3036259CA0;
	Mon,  4 Aug 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311992; cv=none; b=cRCDfNTR4p52pPL6olIV48JW392TVt3SXFp2t2DEFYxFaK7FY3GD5GT7LevYFziDwioZZ6BfJSnoh6JlYYrzjJjqoo4mSyRfV5dTWJSZFkBYGh3R/RGGHyxTfMwxKUA2yGvRMPbrsqe7hKgVdQ9O+L5PNKT7EyRwQ/PcJ9DMAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311992; c=relaxed/simple;
	bh=rlRuHcz7ibCSImwPmNqLXicN3kvo6Esm/sysNX5qbFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nrj1Y7riKDuQRM7yIl0iop30Jk6cA2yCMvmSwxknTrNdJpARrbhH+DClO11jsw0Q05DRxKzBJVoUF0uJb+LAhwf2glwX2BwYuqu3Slf4wxYdOC7Agj7/2daZPcS00EgA4keNbj/xsxHsqvqMZI1UdN1jYovoVEsH+eb+xtnSAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wVqGW/fH; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754311981; x=1754916781; i=markus.elfring@web.de;
	bh=j4rBVom0jXFATUJLzjOFQ3JK6hTNjsZ0iCeddMfFAOY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wVqGW/fHvKW3N6/RoMHSapGAuh7ZkR0A0qCTdbHuaPmW71bz/uYgDNFfDMdFyYWr
	 heGDtr0DD6iJZ1X12TRgoHhxRYMBvVsri+8OMHFz5n+ZcYneU0ItIrWDeLrG/2LsS
	 fVCUxK57jQzxa4QcQBiQBxh9U+wSfPEuXbZg1UFeq/FvxpscFZTsbf89K2AYr+6M7
	 Y7xgxvEUAc/gCTPD1ekjEXpnCxvKfpWMf6H+AJH5rKXk0v/qkyWzFsrdqAhrleAZP
	 EkhmQWpnqoXKkNTiJl3IfUMOmpHEeWa6ZFBj6vtQWowajjMErntyvPMNo3jJsM+/d
	 FuibG1y12nzj46iOWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwJY-1uBE5r1z6c-00ji6J; Mon, 04
 Aug 2025 14:53:01 +0200
Message-ID: <78b0f498-8fa5-43f7-adf8-e31b52fad91b@web.de>
Date: Mon, 4 Aug 2025 14:52:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: clps711x: Fix resource leaks in error
 paths
To: Zhen Ni <zhen.ni@easystack.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250731062331.1041773-1-zhen.ni@easystack.cn>
 <20250804123619.78282-1-zhen.ni@easystack.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250804123619.78282-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bjTA2XxeFAnSNNuU42gHoZ2nXMrQwBv33V5/VX7yLnfzKct8p3E
 QIIIzyHuYQxNqDDf5v9P7krI4cmjOUqwv9fjlObgepRlPC4yxUiR2sc6TUovzqDM0OZUan7
 AE323goSA6O8/irOG9QzQd09ju1qRUQq6Tg1h6Qr62AYe5GxBq2Xx9dSTIqNYSO2EbWzVq4
 cvDZ5nvoCSpPGy1Y9YDdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KoQ4LyrlJhk=;UVW6jHJ4PdBacw//806aNSZ5DaE
 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

> The current implementation of clps711x_timer_init() has multiple error
> paths that directly return without releasing the base I/O memory mapped
> via of_iomap(). Fix of_iomap leaks in err paths.

                                        error?

Regards,
Markus

