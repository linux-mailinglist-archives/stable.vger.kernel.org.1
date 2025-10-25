Return-Path: <stable+bounces-189747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F596C09F83
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8323AAD6E
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BA02E426A;
	Sat, 25 Oct 2025 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OCgixwa2"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F027E054;
	Sat, 25 Oct 2025 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761423246; cv=none; b=tY593vlbM3BlmKPG8EufblgM6oU4Kxpv4GpStvh8ENxw008zqO5TwAx1+27t/yDtAlYgbcJIQ7OltJ7Fo4mgZY14Q1LLxRVO66ONReXtvA2Qlp6QVgwvt7JCf57frrC+2pRO+y/iFzYMXswaTTcdPaxGmlWxpWRZd4CWOtRkEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761423246; c=relaxed/simple;
	bh=2FJPHdl8ZPG3ubQOejLn1V/yQqaRIwskjlSJiIOjXHo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Vo+ftC/NeHNlF+BXcXTkvjbMyn4mS2csuWgi50egF0ASXreZKx09oaniVCnPKdLJlIInR0+h6xyZKO3807qd2Lp4KzyZYlJmo5OZY4GHhU7ZHfLy2gQqV0EHdQEiCQ6OXK4iI5VP0n+m5N78GNX2p0Lr3jtejr44w40AGkF3TbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OCgixwa2; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761423235; x=1762028035; i=markus.elfring@web.de;
	bh=2FJPHdl8ZPG3ubQOejLn1V/yQqaRIwskjlSJiIOjXHo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OCgixwa2kOz7YkmVc8LwYq1Ff7zhyhnHXLeQY8Ja99buaXjKVkukQ6f2xbxPprYj
	 iVxTosi3DcUc9R3xrEnkhkwHKBreefq8z9GMglUMCsbnFXQWb41WgFv9/a91Bsbmk
	 hHT/lERnmuApRWM8PVIc6MfNIB+zemjx+QMZDsmBeTiag+Jng6hAXZ4i3/W5inBrF
	 vK/HAvXOe0zQQxtkD3BYP8RvAXnFShdndqi2TRe5zHgrMXTxCgh83xal8lexWzM6Y
	 uGH1uG/yIeaRCtJTZB2VSxdCDaFAh6KWqkqaN3zOVnobqR+Q7CdZMobaWgoEj2JJl
	 UIvOuG8LoMWjJVmV+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6YJ1-1v5ste2Vi5-00DVo3; Sat, 25
 Oct 2025 22:13:55 +0200
Message-ID: <62ab3119-94d8-4d74-abb3-e141c4b85934@web.de>
Date: Sat, 25 Oct 2025 22:13:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, mdf@kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Johan Hovold <johan@kernel.org>,
 Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
 Suzuki Poulouse <suzuki.poulose@arm.com>, Wolfram Sang <wsa@kernel.org>
References: <20251025142352.25475-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] drivers: Fix reference leak in
 altr_sysmgr_regmap_lookup_by_phandle()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251025142352.25475-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6vB/unV3bYx4o/NP4s5A0s3/SxFzZVvHhfWTcBcrWdWSMoyIPkZ
 Ro1egaa5kWsxufY4CWy9bKJID4Wjr7Y7BTJW93okQiEPgDPx/V5PvGTwSDrbLCUC9cr1Bsz
 TMb4R7VwLaJ6fsj0ZDFtMAuHqaajRDrShPn/VQ4dcHO3dIcS+vmn11mEju5OeImrp6o46dy
 LgSnJx0CGQUIsuQxhhmow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:49IG8/0Eiqs=;ow8/2e+55qWscRi9rybllTddn/P
 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

=E2=80=A6
> Found by code review.

See also the commit facd37d3882baad4a38afdd5f33908f6fc145d13
("mfd: altera-sysmgr: Fix device leak on sysmgr regmap lookup") from 2025-=
10-21.

Regards,
Markus

