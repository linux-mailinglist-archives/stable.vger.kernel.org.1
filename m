Return-Path: <stable+bounces-235671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cg7IK512Wn0pwgAu9opvQ
	(envelope-from <stable+bounces-235671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:11:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F33DD1E9
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67491300D4D1
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D93DFC86;
	Fri, 10 Apr 2026 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FRkZ9s2D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQT6KEKP"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A53A962E;
	Fri, 10 Apr 2026 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859112; cv=none; b=jbZWASNq6gwURiQKUuQrHmRV+oEHhDMaBlil996zjdhZ94OPzJaNU2r21zCoTeEK2qqUk4g3t0AM4kqcaf87GqxxFIXthA1TFnFws3/3hStejBRs6QSrp6L37HH+A1tLM5EyomY7XAJRRUQ3zMr3wGso0QQBVTFx4tdV6dOoB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859112; c=relaxed/simple;
	bh=JCEMD+9H0w3blAyuavY0PHxhqcso9ClYozAzPdALnBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BddLKbcj828SB0bXzHOKl3zcX6xQF3SPRJ+nbNDJHhpRqkKXjrwaVJoYX1JN7HZCEJ/AEHImsxzFpYdQFuKANe5gtDpd7mXhELfMaTQxFFUx5gbUaU6D5CZciWUVO9A2xk2TGvLb6+2u/fXtj+fUweMCl8AhKitAnjvuuHrzlyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FRkZ9s2D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KQT6KEKP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AAB081D00090;
	Fri, 10 Apr 2026 18:11:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 10 Apr 2026 18:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775859109;
	 x=1775945509; bh=PLwqITFWn32NgUKe/bzTamCZMQNshGu0OmKi6IxcrJQ=; b=
	FRkZ9s2DKocUJwlH/WHoh73T6d3OoQ7VR5xGXTVwBrkmDdn4+/ml5MZ8ildNO71Y
	peIDV1hdJKNA9Wtc/3D9J0Gbyw0DRPHCILO7gHkN4pT/3g9lD0yEPL6SC1ZT4KSy
	omnBqv2r0VjkZaMKJYYxgPpeZRSyjzW2rGynlI9fijg6GZho5w46mphixuzAgBjJ
	YyDEnTIdgNltwEOVuDALE4GP9ZYRE/C8LUPI9myRpMxZPb2jsJdZ3U/KKxlKE3EK
	3fZJZa7tFTn+2aVf+rex4juhjpsNKpyLdikeFJdjg1fNv+vsiqzXWbt1+Cu/2rVs
	Ed1R4gdQfmcNahj1fgt0XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775859109; x=
	1775945509; bh=PLwqITFWn32NgUKe/bzTamCZMQNshGu0OmKi6IxcrJQ=; b=K
	QT6KEKPA7knD+N2U8qhgPzLd2azgEYAECcQ4Q4VWhLmJbl8YPeAXIUGhj9e4oxAf
	o6ifzwk68DKCcUw9K8ppSkbSzVNHpYANoEAR5b5IXJVFoe5v38+neukOPr4pGoKl
	eUCKxo/O/A2kxwcDo8cHSFQm8e8khzFzYrdaWErhTCdG5nG2u6sxBpzo+v7QxtfW
	h4pnItRZ4nX0EgMGHgrCOPv2gbyksxa0acRokqo20x0F3uXr4Xqc53K94zgHLZD9
	YSkj47Q8qjD/hDInKVyMF2b3xGt2AqrJk5flNkrXezAemSobPK4fBjAIEVuELvCq
	dpb7DZAbfJPch+zwaW/Xw==
X-ME-Sender: <xms:pHXZabl8LN3S-oz-I8pGGO72rE4zhZzNwyZWBso5E0YDaBJgqYozpw>
    <xme:pHXZaaufjmiWiZr_C8WtKagOSXg_ZPXeSAf4VQ2ioPmJjVUnzjyTieSQZAiJgbYQ2
    rYI5lzMuS34GbTwv5PpJocjcrYfN-DhpTnAX-fdgcCgAhCEPDxxXms>
X-ME-Received: <xmr:pHXZadKE5Sw2YkFJVWqA5g_bGCOgzU5olnpltisKT0KQ0NnkELnx_UTmeTd0t1hMOpcp6bmf__qMqKLrXpojvJljcy7OeCGN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepfdeurghrrhih
    ucfmrdcupfgrthhhrghnfdcuoegsrghrrhihnhesphhosghogidrtghomheqnecuggftrf
    grthhtvghrnhepfeelheekheelkeejlefffefhvdeljeetheeltdeiudffveetffelteeg
    gfefhfejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsrghrrhihnhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghttghhvg
    hssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghlughsse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugiesrhhovg
    gtkhdquhhsrdhnvghtpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgrthgthhgvsheskhgvrhhnvghltghirdhorhhg
X-ME-Proxy: <xmx:pHXZaXgjGTTLvxkP3mDzt2CiJ7rrUz2PN8uKdXkXNIA6631JQMXGjA>
    <xmx:pHXZaRujnQLr0jiKrPaO_P6O-DmsR30i1PN_FSs_HsJlABCJzyxmaQ>
    <xmx:pHXZaRhL6EQ3bJ3mR9b-04kVhkse4satdVJkPleokxGgaE1Q0oIcOg>
    <xmx:pHXZaceqSR6x5riJ_wDRe9eEBCdrtgHXbig48vcdqZ-lgTPFVOtQtg>
    <xmx:pXXZaUE54WvgJNI6GfbBIvNMSzT80I5q3TIMrVN1Vl9-3C7aXcG2dpOE>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 18:11:46 -0400 (EDT)
Message-ID: <0af1bd9a-f64a-49da-acf0-a0aa9b058fb1@pobox.com>
Date: Fri, 10 Apr 2026 15:11:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260409091742.514769762@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260409091742.514769762@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-235671-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.com:dkim,pobox.com:email,pobox.com:mid,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 853F33DD1E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 02:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 11 Apr 2026 09:16:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on my amd64 DIY home NAS. Working well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

