Return-Path: <stable+bounces-148309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F02AC91C4
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B5A3A5BA9
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB144166F1A;
	Fri, 30 May 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b="A0n46T8R"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000321891A9
	for <stable@vger.kernel.org>; Fri, 30 May 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616325; cv=none; b=ZBCypHeGzskFFSx8a13k7jYndSz6VY77hw2bIwuvG73YINhGIH+1EgZYokzvyyZK1QX7lxyD8FkkF5Wr9pL+qMRJUrOJhU2eqi4eWnC6XiQ8djMMNHfUZxtYV+GRSYXimdM3ivSV6dH9cEUrLe7CQ3sbwEKBe5Zo0W80a+DzqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616325; c=relaxed/simple;
	bh=hQE/WmdulvbMWe/nhW+LGtCrqnP/1QfB+vTgPucE/5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnXH2xBq1DFLIwOFqOuAMzvjorJd/hhq3Wkpju3vfIVAuPMhx7lzTQeLZDnf3XzBUxrfie5JIv4D9vQq0ci+vPWOmrrYTIkOE2FAatePNDZrPxtaZzCaNLyvOHv4jjPNrIY0BoRaPIU/ChhvpS9d+VAWMrPRRVjDmwrggMpwBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b=A0n46T8R; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748616314; x=1749221114; i=jvpeetz@web.de;
	bh=U1r6MYLbVa2Bw+/tDTp6j28/u7buRC00NGk3naK0ezY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A0n46T8Royy8t3RWzfLXQyIYuAdpUgM5vBo3n8/xYq4xT5RJca1WplPaIoDQDoTh
	 juV8RSXoxEA9tcK2KCdU0MmvzvPfQ0j9beo5g76340qrYQkHPkYgDA8unPeIR83X+
	 JRCLRG5HxbittOEjP4jKyK/j23A+3E6jCuoyY+UobonvYATqAobiTiNIGx0HKAuZE
	 IcEp85TUGhWnzm/SS97JVErDgkE3cfcbS+2Qww5LV0IGzjr1ASmVj/JfHu3EwtvIF
	 DTpkCOfDkF5AU082xrF3O3gkLhyYU/u/wFrLsPCpBlyekIejD3+WDtaJogehEenbM
	 odlXTzFrceETnP7OsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from uruz.dynato.kyma ([84.132.145.192]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N45xt-1v2ZB52NRB-00sUgq; Fri, 30
 May 2025 16:45:14 +0200
Received: from [127.0.0.1]
	by uruz.dynato.kyma with esmtp (Exim 4.98.2)
	(envelope-from <jvpeetz@web.de>)
	id 1uL0yv-000000000Hc-3Kj1;
	Fri, 30 May 2025 16:45:13 +0200
Message-ID: <f2e2eb44-ea55-46ef-83b4-207b5906f887@web.de>
Date: Fri, 30 May 2025 16:45:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 645/783] HID: Kconfig: Add LEDS_CLASS_MULTICOLOR
 dependency to HID_LOGITECH
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 kernel test robot <lkp@intel.com>, Kate Hsuan <hpa@redhat.com>,
 Jiri Kosina <jkosina@suse.com>, Sasha Levin <sashal@kernel.org>
Newsgroups: gmane.linux.kernel.stable
References: <20250527162513.035720581@linuxfoundation.org>
 <20250527162539.405868106@linuxfoundation.org>
 <27b9765e-c757-41c7-9cbe-fe1c915fdf2b@web.de>
 <2025053022-crudeness-coasting-4a35@gregkh>
 <2025053000-theatrics-sleep-5c2e@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
In-Reply-To: <2025053000-theatrics-sleep-5c2e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oJBBarJ5Kxi4XEQwm6mwGX782fOPKMtJ3YWRKtc6V3/Z7owpfSp
 59WSIiy82LTza2FNsIf+5opegiPtpLsjmk8YXnyr3nmCtmNVymjbTLfExo+yz/n+gx80Vbv
 P3OuCNKo0Y1/BzYesqyZD8gj4E0ugjoPREhUSP6FtKzPSyluM0IE/4y9Op8Y/vqxz1quffg
 rhVqYdFlChQ295KRM3HhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lPb/2kzlThc=;DLos3Mio4IVugylmUKGKW3Lm2Af
 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
 11O1AItdQ44AwQvfE1+FTrvTOZhgENZ/a9Yv7Q==

Thanks for looking into this.
I should have asked more specific:

Greg Kroah-Hartman wrote on 30/05/2025 16:09:
> On Fri, May 30, 2025 at 04:08:40PM +0200, Greg Kroah-Hartman wrote:
>> On Fri, May 30, 2025 at 03:44:22PM +0200, J=C3=B6rg-Volker Peetz wrote:
>>> With 6.14.9 (maybe patch "HID: Kconfig: Add LEDS_CLASS_MULTICOLOR depe=
ndency
>>> to HID_LOGITECH") something with the configuration of "Special HID dri=
vers"
>>> for "Logitech devices" goes wrong:
>>>
>>> using the attached kernel config from 6.14.8 an doing a `make oldconfi=
g` all
>>> configuration for Logitech devices is removed from the new `.config`. =
Also,
>>> in `make nconfig` the entry "Logitech devices" vanished from `Device D=
rivers
>>> -> HID bus support -> Special HID drivers`.
>>
>> Did you enable LEDS_CLASS and LEDS_CLASS_MULTICOLOR?
>=20
> To answer my own question, based on the .config file, no:
> 	# CONFIG_LEDS_CLASS_MULTICOLOR is not set
>=20
> Try changing that.

Yes, enabling these makes the "Logitech devices" entry appear again.

My concern is more about the selection logic. The "Logitech devices" entry=
=20
should not vanish.
How would one know that "LEDS_CLASS_MULTICOLOR" is required to configure=
=20
Logitech devices, e.g., a wireless keyboard?
I think, it should be possible to select a Logitech device which in turn=
=20
automatically selects LEDS_CLASS_MULTICOLOR.

Regards,
J=C3=B6rg.
>=20
> thanks,
>=20
> greg k-h
>=20
>=20


