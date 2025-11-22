Return-Path: <stable+bounces-196605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99155C7D6F0
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 20:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4433AAD9F
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 19:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7273E2C0F68;
	Sat, 22 Nov 2025 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UTHsVaIA"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9D635;
	Sat, 22 Nov 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763841509; cv=none; b=YE1IqNMLQ5pnTcby8fL7vrRmz82t8CwcxZKHYVAXYODERLzc2sSWYn/OXi6N4HtsajFnmGxB+giqq1yvviNPsGg9bI/2aFWtWSNik8ghXQpdRBbgZcyoEXKG4/mst41AabU2d1ZneVXJURezctMV5Bp4cAbbGw4LHIkJ3edLg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763841509; c=relaxed/simple;
	bh=6pVoIPA+FfLtenh5W6uwRDxgg2A/TF0IsaDrMhYU8lA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=a5m0ntLm1QQeR1V/aqrNRIi6IA0VuBEnk9sUrxfnAi80xb1zMBZDZVwTthV2x5kbyRtaac9vmkNefcQbYhYYRFS/MMV+Kb9Y7LmARIMwsYVV/DddML1QWUzSYE/ZaYplqWzSAY+VOCC3TxlECXL4XR+q9yUpFi6MxPAepfQLbCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UTHsVaIA; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763841496; x=1764446296; i=markus.elfring@web.de;
	bh=HG2JO3KSNRe+ua5Uegrz5M35SIsKkSK7HVA3JMOGHgE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UTHsVaIAjbmEansUAtETQvzS+bkeoXxTUbxHh9QUXopObSkYrvd+sNv7PU03feRD
	 5j4XleEsu8RujCpLYN+II8rrvcsEXvx7LPsdiE/HjflS6JmgPjeaqxas4GSZLvAC+
	 sw2oLBGXqlsiXrDO77fUvQgkrGvomPxE7YgOaargVGpES01L3lg7RxacAJC9REQMa
	 6miYl5YGwRw1wbBwINZIyGsyGx50Yng04gzRb0COtRLgdG41o60C0SP6RGwXbw6eh
	 T39O2lQrl9b/c1TSAek7FyGIm+zw+R7EUJSsXt+K60H3+5WS2XQMQJmvk6ctBDQLy
	 /X+LV0hhLlsHXkVpbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.246]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Vsr-1w9n8z1Mm1-00yu9d; Sat, 22
 Nov 2025 20:58:16 +0100
Message-ID: <ca517274-9238-4f76-98c5-2fd31276d64f@web.de>
Date: Sat, 22 Nov 2025 20:58:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Simon Horman <horms@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251121035130.16020-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] net: dsa: Fix error handling in dsa_port_parse_of
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251121035130.16020-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ROE02mSg+IS57LdRW5EPyqoG7HyLDCS2WKosi/1pO5PPzoSrojX
 F29xI2vH10Q7pBF83cT0GmAFxbEaaJ5JXWyebKYHwfyFpsQFoSrIeCc8oXj+2WRMSSYQWVQ
 WrSUq2Jk909whG6DCeXvMK5yhpF8rhMLh+MusrczkB4TBCH8nnDkFnpwCFgQlgpM9vV0Rmn
 PiCCQHiM+bh58JObxMFag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/e5z7l5XzIc=;dTy2L+VRQwui1OnP8+WUaT7vABL
 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
 uvNje/6iLEKXo6YhA=

=E2=80=A6
> returned structure, which should be balanced with a corresponding
> put_device() when the reference is no longer needed.
=E2=80=A6

* Would a corresponding imperative wording become helpful for an improved =
change description?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.18-rc6#n94

* How do you think about to omit an extra check for the variable =E2=80=9C=
err=E2=80=9D
  in the affected if branch because it can always be returned here?

* Would it be helpful to append parentheses to the function name in the su=
mmary phrase?


Regards,
Markus

