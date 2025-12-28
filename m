Return-Path: <stable+bounces-203443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC364CE4BBE
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 13:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 509B7300B903
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608E326FA77;
	Sun, 28 Dec 2025 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ri4oH2/k"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3F296BCC;
	Sun, 28 Dec 2025 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766925159; cv=none; b=lbH9sF8IuoM+UShUSYoMFyB0HdB7gPUaPP5DMiVgoa5Y1wshEEYQArn6kjqN3KknVJ7DGlUxtFbeD9d78J6ug0usIfDsdIJWgsePygExrhW5DF7yeO00jrMqgwMZzik5bcaE7iTVBdbt2I70ZuJkuQYdg/mgx6Ytm7OIacN+OW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766925159; c=relaxed/simple;
	bh=r1jxyQ4SU6GZzFNNKhdGCJtchcbuEbIXu8zrprykYbw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=AJ7Y5pW8Ru9vZuS9C718PxvDjqpa0COT8gyH6Z2Z4E1//O/X9WMsIyb6jjflTjnx/TchaZoVSZPkFGtT6otlTVZGrXOAfZVBDbdCbMqWcErk76BpjVSmKoyAKsK+ZTwd9z56eUMvH8nBIZWWK0Rdii1ewPokyUDw5XZMbySuIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ri4oH2/k; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766925126; x=1767529926; i=markus.elfring@web.de;
	bh=r1jxyQ4SU6GZzFNNKhdGCJtchcbuEbIXu8zrprykYbw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ri4oH2/kBwV/+cVymsFZnUg2HYVjoH1y6HPsNHGZ3o4gEJJ9ODQiV3JQfdP9XBvo
	 B+BbMT5ELLSSVoRrIBdUdG+nxh4ZvWOZCt5Jdr/aMlIS/23VRLmzNNThbgabRLycv
	 YHJ9BqswaBaPFBHCBLloX5wCDc5DlRS8lH/RZDhOR92KpYJl+PbAah8Hie50MpMKN
	 qoFpv4xuXzB73wiw+bZ8MUNXR0QEDvB3zlwmmpJ1XoEyqGTqLlVuoO4oDdF3ylkZZ
	 zPYuWu+9Aht2199tLsW3z5seKnHdYGhEbDo0FBJZTvaCG52+10yWS0TQ8XfaX5UJt
	 acpcL67/WxTDUH9Zzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl4x-1wGal92wKD-00gZu0; Sun, 28
 Dec 2025 13:32:06 +0100
Message-ID: <0108245e-1979-4eba-97e1-eb2056294c0e@web.de>
Date: Sun, 28 Dec 2025 13:31:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251226041711.2369638-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] phy: rockchip: inno-usb2: Fix a double free bug in
 rockchip_usb2phy_probe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251226041711.2369638-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x2NOzwbOqRnCZjFxVpC9RUpwv3T3EqVFouVdlpcHpIQkz7yeYl8
 YGWL5nGMZtRhukJzX5ttmBkNEXc27cvhIlpX49Cjd4zB0/b1WMBLWPaaGU1bIRwvau95a1t
 8BP9jqOdiwFcM4+iAFTEBf030fragoXiFiPusQLA2ahHDQpxDXY3JMXeXYf3gLyfpMxQbOg
 HqeVoL9fMkqnY4tXojBOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ED2r6XYBs1Q=;d6NFeeS9QfiKKY9uB5ShZKjle8E
 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
 6381pcdQ=

=E2=80=A6
> Fix by using a separate label to avoid the duplicate of_node_put().

May you return directly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.19-rc2#n532


See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc2#n659

Regards,
Markus


