Return-Path: <stable+bounces-115106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00956A338C8
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 08:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6D33A71F6
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE0320969D;
	Thu, 13 Feb 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G02y8nMl"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D5208992;
	Thu, 13 Feb 2025 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431596; cv=none; b=hXY8MMqdMmJXlUecSi+XZeZdKR6NQmd24Uog4VzUhLO/wfEfSKjcqiGX3o9v9sXy/m3CiQwXOAR1j58j3fMZhrqm6xRXliuzdvHWAPrx0wmu4lUnGneYvoB7ug4teHbClBgHWrdYONTPQWUNv5ktum0PIs+Kbrnrtkc8zZG0Zu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431596; c=relaxed/simple;
	bh=OTiYJTw6dWzO6R+bnZPo5eajbZ/LQMlpQREGfDWsYh8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oDMGR0hJFIjIOJO8mXU53gWFL5DyeDJEM7/MRq8q5ivThekoCwF71AfTjFnHhrI7Xxc3VFhZ0EcgyvrEVYxdCWu6aj08Y1RmSGHGiqYW1ljV2bmfyVzllLTwMupqWoYUHubts7lCGxJhG5Kt/ZIexlXs5q4L3AswcJwG/9sBotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G02y8nMl; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739431587; x=1740036387; i=markus.elfring@web.de;
	bh=OTiYJTw6dWzO6R+bnZPo5eajbZ/LQMlpQREGfDWsYh8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G02y8nMl36P0PqPsSbh/94j3hGJZ8voPUGs4Syqukmyz1liCfWDSW5e9W6MynhOk
	 0IAuxhtpJa6pO5i4jwGoR4pUnwRUPXfHLz8PZKiWz/5DBce15tpeI1m/QDew8XaC9
	 rWsUzYcuMcEf61qDLfpfSkJwyRAHk07B2xDWTSWUbQKsjBYKXdpUEJoSTHPFBk5qR
	 3xqEaSmea7W3iFzK2jDCJFK9OmeYyVBfMyMEaBkkp6AE9qCsYsyby7IcB4YkzwLam
	 QyVHs5tJWJ5R/wP4oSf3mJVySvNvrPVYJt/rSIFO0v7rhxCAITcE31/LezKRhQc1a
	 dOurSElu3+Qt6zCqOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.78]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QQD-1tIq7S0kof-00vmXo; Thu, 13
 Feb 2025 08:26:27 +0100
Message-ID: <491e74f2-b503-4486-a8e0-b4eddc16b2be@web.de>
Date: Thu, 13 Feb 2025 08:26:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-sound@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Julia Lawall <Julia.Lawall@inria.fr>,
 Takashi Iwai <tiwai@suse.com>
References: <20250213070546.1572-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ALSA: hda: Add error check for snd_ctl_rename_id() in
 snd_hda_create_dig_out_ctls()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250213070546.1572-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4/AA8rcihgpl6rsOFxSGFatHFrVBRGoijQL0IrZrjwgjadffvq
 S0FidvsMStG9EpfZtYOFtiL+iwZsXpcZBZu7OzXP7rgwUl4LCOIa4djO4IH/ZkeD4mpClTl
 qe54W6/8UBAcvnUZ+z8SiPsIHQ6DikdiOl18VjGVsrRofkMo6A30xXFT/oUT/o4eOFWQxCO
 Ee4CrlVdLkOna1IjKriTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dj6pCAqs3Ks=;XbWPrYIAhujbPECWV0/rzt+UUsY
 R+hCQFFiGkuvLCkdo2lTGMaMyd5tTaRD35SFIRRto61K7Wh3Pmt/LYaIOv07VoVO2KnN+MYxC
 D0DRAxbfLnOxnQDAayhHe/QXgNvxnTyoi1v8OIGu51hv0ZrRiqiTvtZksy5LdtFuMcdABlGST
 tuCnWwxij04KoewGBQKZ9cU8b/MmXX+YuU6+kOn45dqxgLByV0Lh8L8qIHosrrDV1RQl1EcSL
 rAI8UWmqu/VlrTb7LacPH0BhWfyWnPDX4axTK1zDz0DuL/+HcjczYzqzLM5ajED9m+vWxU91V
 KgkIgYOHAGsKaj/75SaU+EhwzqKga2B7MLZGCIyjOqF7ABOSb1IFuQFW29OuvxDvMQVOl4Tmi
 IBmvsStqiKOkMz4/nAg6aAv0y77gQ/0UhA/RULCs/8s1dzH9IDJTxeRSfHaGVhIvQTEpdprfA
 RMTBYgMqRsl+pfZ7/++QfZ6nYX1x5ljdZhxB4EYU9DfDOEmSJ4au8VerTyxDun+nHLR1Cped5
 r5tBlHyYNCFSQF1YAowmjgfj8qy0E6Yi0bz940OSyIVNjNr4GjDJ/aJveHTAb64WAP5830FD/
 zyn3Nu1p7yyvISKoAoXSYqLGSEq89tEy7KObCHgMr011q0y2kJptfsZQmBe1yRLmy429+q2yb
 iurlKfqfNqf2ihll9aU6XhXnkcBQ6+FXzfmDWgEvaTS6B+0lHilQImbi+1GPD11sBTtRv+dBP
 yhF60+Q80NX3cSvW4m/xoP8lpKARKM3bqMhd14OdYOcxjMPrjp3rm6A/CFev/WITautHpcSR1
 AFiD14mKBfyWSuJaq1PE6rKX9nLwfFiWQfOZl1pYgy9B8ESsWvPAIAnFLyHPwuJc3wRIYQd6r
 GICP4Ooud+5jh1tON2ykw244dXN68zG6m182Xlg3d//rTEPIMmipfp2Cmee0rlSfUv7g9AbOG
 DFMSJXYEcJbCiVb6y3iVOeaQWbE8jklthDH+gDGE5Icuq4v7+JqxC+AXwMhB8qCfJ2DueuSIt
 tlPNnnDFysmkLZPdlzZWpPL2lOarfqfDA1N1qNLl92zH3d/RU70T7o6oLiAu8+bPHXH/AQpAv
 vfcH/DWt37hB9BLws7SsRuyT9FhUOlExXL1eznXASLjvZLH35k7CA48JWNnPUIosaAaXMjzNd
 OUy0vx7PwZRsSXYu2TXJqjlJe+s7UO4UWEkFH24O5s78hnsnITyQ+0zZwQye14jN0rhUTnT+x
 ou1NXt8P7lWpZt0fCJPXArqBzlR7RqkgPwdRlAdwaW7B+iBDA2IGGs6OsxJBc/06Yid+J7jaf
 TZg9mKro6TZt4vr9maX5rxZgXJoRIH3DAQfdjuSaUEPh49GFKFE3U9uNPD2I1woEzFWO7W96g
 1RyKNkLWmrzS2QC2dN84cVSmnrkA2eHgkTlxmb/SnbGwrfb+MSSqVrJeLaLOWsQQkvSBrCDSO
 AOfsjicdFL8QuzwoJD1NRb4nOubs=

> Check the return value of snd_ctl_rename_id() in
> snd_hda_create_dig_out_ctls(). Ensure that potential
> failures are properly handled.

I would prefer a change description variant without the word =E2=80=9Cpote=
ntial=E2=80=9D
for this issue.
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus

