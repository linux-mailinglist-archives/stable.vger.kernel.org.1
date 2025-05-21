Return-Path: <stable+bounces-145915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B173ABFB92
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 18:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3959E7370
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7076822B8D1;
	Wed, 21 May 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R9qkp0UQ"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B91DB92C;
	Wed, 21 May 2025 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846126; cv=none; b=QdFlVvpsJSepMj+NpM7d39paZWbaK6SuRPiScJlM3QU8lQ3M161sVZKSq1IqC+DE+lgKxSBBW8TYvABJVy2lnuneYJ57L1sskhchptmQGaRwjNecoFfvQbzSA+C1zJkUErHBk/dJ5fBdog4rzUpdopLt4MInqU2E7QHSWGgOKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846126; c=relaxed/simple;
	bh=jg8VCJ/HO8LDROQDP6sTVvwCnSc+47Saf5Fnwnl1m3s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ORGN3m9QlijHcsAAA6vtIuGKsw2qduH9tlq2UIycSYMGeKh0SZamTaXT/9Bqj5/SeOJcilbN/Sm/fjnCTJNey68K+1F5XhkxGIWDccW2JLcpQh3cd4PK3tJkuGA4zQ01TJXqXtSwgp4JnsCHGcp4jlzKFX85FmMZOR/4U90fubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R9qkp0UQ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747846116; x=1748450916; i=markus.elfring@web.de;
	bh=mMmRvxKHUiZ4bzlqiGpD/VkaqONMq2EdgL1Fk7DWEAs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R9qkp0UQLMU4PS8aLGNnM5h9K0LZcxpWp5mQgC7/MZZl4bntVAcJKlRtfX+K+7Nw
	 4Mwuj1MrF+OPYYVgK8wGwQSF+6mL1ik53T5NWdrqiPNfY4otvzjtxvFBOgC3DrGiy
	 qdvJGp3gEW9RagYyq0qwliS8MNeCBWOm0evE6ahV/a3g7ryv4f4TY1D5KKJ9TjO1+
	 XxkrE38w4Q7vs7QB7kRwULrG5cnletAHS+065W+MBe8FsLAVhGVnJxQjTRP0aG8Do
	 YxA7+ZAnAHMVKsy1po7HrWguNDtHKKGnshZBWblNnsJQ2PmBm809PomU25NRANE3i
	 ZvtSYxDXZGFlJuQb/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4N98-1uyN8v3ZQc-016xzv; Wed, 21
 May 2025 18:48:35 +0200
Message-ID: <cc69eb17-d55c-4843-8d90-fd49191c69e2@web.de>
Date: Wed, 21 May 2025 18:48:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-remoteproc@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20250521142404.1077-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] remoteproc: mediatek: Add SCP watchdog handler in IRQ
 processing
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250521142404.1077-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wLDt5/h2QRTkZczjRvRZMrVMnlTt2L1E/AybcnSxYGSgeOhxHsx
 pY0dW2RuIKkKw50MOqmzkYU1gmfRgzf0KeCVJ9tRcIB/a46zQy6/1xqtwscqu4IDSruVwqw
 invgNyZJbcNmqhbEWWGNag6SyqUMwPP4NL2X5wol8nvTr5m4aWu9vh2NxHiY+sEPX8EHPli
 K/yIzGNo46xfQDrIvJCkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7AM6bwFPyJI=;et9l+tuDsrsw4nQb40EaimU/7/O
 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
 NvI9vJhgOf7wasUIpriVeownWfw9OarXeb

> In mt8195_scp_c1_irq_handler(), only the IPC interrupt bit
> (MT8192_SCP_IPC_INT_BIT) was checked., but does not handle
> when this bit is not set. This could lead to unhandled watchdog
> events. This could lead to unhandled watchdog events. A proper
=E2=80=A6

* You may occasionally put more than 63 characters into text lines
  of such a change description.

* Please avoid a duplicate sentence here.


Regards,
Markus

