Return-Path: <stable+bounces-225526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK8cOAPjt2mzWwEAu9opvQ
	(envelope-from <stable+bounces-225526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:01:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FD629866F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3468300372F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F3257844;
	Mon, 16 Mar 2026 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="r0VpyXrC"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108241E1DFC;
	Mon, 16 Mar 2026 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658841; cv=none; b=DABndRnGnzNpqTDUcfZB5SEU9NnlZme/fO2lNrCukubiH0enEkmjO+5fAwfqdcyNQxFjP4gky5bl/o4AQCAzcyC2HSZkHLtd3eahmKeG6Mmr5q9SYERTvN53KK832BbHzbbDZ9KWqhNndU/G7L6LIOzytjwr5ND0sG8pSTJu8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658841; c=relaxed/simple;
	bh=1KCKFidAcyl4mC5/35dIaNGWDMLT5fmLZIORjQ9sMkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0+/yWDnN2TFYfAvToQP78UbpWBqqZLYVyNN2N9YHgUlggWucP+9/iiS/W3rJbpZ6DpY9qVB5TUvf1QCuWNr/9K2mrB9Rl8jQLBjFVyowbcbpEsovmEeb8PV1F0aXuRt3mzIo/6Udhnh/c7ZMoW3ZSuqmqn4BxSR4SZqPowGscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=r0VpyXrC; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773658831; x=1774263631; i=markus.elfring@web.de;
	bh=b+kIpuqtFhF4ktUbbMXDmhvxNc54LV/P/ourahO5+54=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r0VpyXrCEG9iWRi0u4YJGTi+rFMvVhsqWpDw8sHjuKCnmkyEiJ0cI+EMXZqLwuCA
	 eIeM1CbHzng1Jl6uuFnSgzJ3/sckzvGbBwylgjLJhPfAcLzB6ldqgnukuvlqN5Wkm
	 A9KWIB0VDrpbp6cRx1dKHG/odjlE2mWzH2UC9o6qYkNbAtyWY+TlSeWn58bp1w3AC
	 94q8TXCCIpR1EOc3cs6m7L325+WiAO7y4USOz4qEdkl3m9CTHkbho2E/WgkCSNqfD
	 zOZKQeuKXjSOc6qittgRrqgC0Knv49IxfxenZtkR2HpVyfrjmwMXTRlv2Lzmh+5I2
	 O1wQfWsea3MSNaIxcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq1CA-1vEzEb0fCc-00f9o1; Mon, 16
 Mar 2026 12:00:31 +0100
Message-ID: <33c8a45a-3548-4ee7-8e32-4b401f4feeb4@web.de>
Date: Mon, 16 Mar 2026 12:00:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
To: Junrui Luo <moonafterrain@outlook.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Prike Liang <Prike.Liang@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>
References: <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <PH7PR12MB6000A8C0694949AA83702AE2FB40A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <F21AC290-0B53-40AF-A0A0-0647B86AD2C3@outlook.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <F21AC290-0B53-40AF-A0A0-0647B86AD2C3@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T8JWasfNIb5srH1jqhZuRlGNT60te624dgFuEr0Ur+06BV1XGbf
 C2weWIJflQfYbLIi697C92ts0H/QN9bDSmLwBPqpLzLE0wFcWZtVWke1tde8t62nu5XupKO
 4kQEAtLIj9iBg1EEXS8sDpYjisYVQcDeU5j2YGkmorf2GZwrDpFdJV1qS9fMvH5vm4XRDKL
 dyMW++Dcc65VMMrAhHoWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M3qFDmLmVTs=;mI8iGdb5SRIeI5660iB1GAyZ8rM
 Cl26qUArduuiwMaKCR2lYnMn9iZGqeDkeba+b2NNXw1Fjpm1OyfI1OayhUCsuFMcPt4Ptko2t
 ao1yuAGr+/UasTGt0XxQ5nA+HZIFXRB4/62InxPP4etzLq7Igk6SMr7C83XGf9VGieboT3AQ9
 uBS794oPej4hIs/MWVbPzgVaQ3r/7aBAam+TSgRN1DifzZUv7gt79FF7gJAZrP+LBy4vCzVCx
 spY/6uXZ/YYl3j/4rtuV3+bjRcj6mG2E28Q7VCwzWusABSr0fiUqG9yE0SRE0+jBEPAIcCNwY
 hRJOVCHloIcRVXJf2dzgFKeJ+Ip/6r4UEsnMaZMFzYa16eKSPlFL652fdVklvyTM23JetkRQs
 6Smdl2i6hY12gDZ1n/QV/IRH7eJkan28L1SfwJUCAsXUoDHjgrl0bIgfH+BEelz3IYteXtM5f
 9Ndx0KyCZW+Dh/EhbyF6fK3XlntTXwc/vcTe01dJElfFk7QbB+w6ZApXQ829S75VpclkuX72b
 bK7kjzAg6nk912W97GCm40RvVbUcJKkPyT8zuHDrn/XJmV7bcjdTWjTL2h5dN7l/bgUSf0oez
 HU17vM61X45KM6/dZ+Xh+8IOc67cszRG16ipSfdBt4/CXdPJ0SOojb+bEkph0gfbGOqDW20Q9
 +HdkyGvahoKTh05uxI9hAounxuu2RqM97EQ+tE46o52TcV1rJv8Eqo5q4ablwh6H/5k5LWEOr
 /j0kCcAYCYyTXVga6Sm8RnPp67XyoNVCYXX/394drKBxqEIPQAUIX+gUa88z/xfwD5MoEClX+
 RcBCRA8+7pKDy93xpFrlceXtLLGGe9EL1OCfH2m3QPIALRVOSkOV1+vi321vRQLkY7eLSSdEA
 pcFizQ1lrgTW4+DzX6VgMnRJ9uaMwAkbn3XeupGbdei09o7EFlHOOQPYt1ypHaWUtVkfAP6Wg
 hjBhdBN+H54Mcki1SicWrcSrUoGYaLVme13/heNM2UUYgR5SNlelgId3qNf1N9wlmaLIpqWq0
 ycWALFHt09ZaxDbopaW/C9P6GeqXNSdbMxT4U1+L/tA2osnwWtZRjIA+4pzNim3gt32IFT3N5
 AcUZ5sXmzAqWIc9b34giDccO/fmUKjq2ghLeoUOsZJm8lxc3iBM+fsjVddhORl5cCR80vQOiG
 ugvFrrNVYegnFTV5OWus5atrpioRblY6k7Ol2I8Gh0gMsMIV7Kk8lp0L6NxYW4tvzuVixnSpx
 6E0kAo/WSRepvZBtTOzv3Qe8l6DlGNUjaxkBA0AK5fwppxJsP5Lj9fbFbZQCtO7U0cZ94/yU4
 CF5yDQxbD+pzReO0yfg6q3OfVDhG210pARFJ9rzPU+GlwQ6UrUnb6Bj16mfJXyjjRvQGEpuuV
 buq9Lwgwd6bsdGdF7U2rorJ0wpGwGuPPe13gl5PLHs256HZPklH/uJcJzpVuXFgmtcvF2S7p9
 BYmycPmFzsDqm97nsTVkF22IKV426bTZUcOmORU2/UOEmDFg7UvcE9w8vRBPvIDRlQyR0O92D
 kaD8av1CTA6jCvOSWyv3mbDLt0WPJLFci1LrHAsHztD6atppwBzC+qsLKjP55q9L0/6+qC+nv
 f8fTta6nzY+aBsQOh7T7b+KCdDQFLwzb80Vvcrx0Y5RY+vRIbSxfju+wlpU47CdThX6u7o74Q
 a3hK+GIwHJDbqaAlciUzsRsOuLvTZ8gGVD5pR8Ho9RyoiJT7Bb7kNi/k02/UohKyrY0Oa7rJP
 lh7XDnwW9ORYvtBfZldIhXbndTplMdaant7OuWV0DUCYgkjcz24Fgd0fZQaGrBl21/nxxPWbM
 CcYIB/yKHewK/V/TBGXsjGXfJRN64Li4DzE5VM6/xfxrkM/uUs41m4h41nF14LMleSfElrs7N
 2fO4rbwHvFCj5CQktT+dArAMtEWew1bFeSOCz6Gyn2w+KI50E0ZswS9+LdutGc8IzzTrmw2Kr
 90L4eOdsVxvyxwpawR3IZKei4NnJ4Ezt+IXWSgTszEzLLYsUXc7Q48CsNeIXZw6zO0k5AHa2w
 Wz1GQaz0ZLkafeZZ2tRZe6RsJKFNTYjDtOH69un67p81bpZ3UaMSlw3OhVlwkR72/nxfk+kGz
 GRvO6jm/YxZSKDF+5jd3g1XUy62npB79E0rTxlnWjqG4Mfz0iNM16ib4DnuuDCY5R/D5q9KXr
 LVoP+cNFaZyZy/Ddr84fhElNOFbCS996RpY9QZj+zdn1GCI8SoZK1KS2eaDWNnKYgAwLjnWdF
 meegN3igHclTRnHed9iM9/cVAsGZdzkv32sxqG1fBc7jbfIALcTL++QXdiBp7vFoEXb5p6p7Y
 pUJeX5qZ55IjBv1MI43gouZZFbxGVN++Hg6owxUDRSRLsZZLb2Fn3+H05fPIpbm3NAnMnu+Lu
 GTcQU4eqBm8585G5a5gqXO6AevbyVujFxbXN8nHQEsQw/ZfLGhCzaYWYY8eF05h9hqTaIVua7
 QMyF6opTJWICQjubbRKfpIDc2DXw5BVCeln1Gt7vhbQksr9I1ufCtiD5HtzE0qfwtiLPwJbTh
 Sjeqq/KzqJdNkSXnhlbAftNWgSvYcaJHBHV6sMoxgciKjgHdqTkiC192ZtehFhsOtqqOHTdJ+
 iWCK6NRhBOLjPKakt7JDgqTIywy8mcxJ+6BOthIEk1DVE8PlJ45MjCtGOjJ9lLtRC6kRuuKox
 4XBtC6Pck1WR57VDNRfU3Dainpmt35UYqSUiC3tK+qTgS+g3Y0C+AXJPWpVJXVPQuA3ZLOhJg
 49PTzDplfc7KRSQ/aDUBwMNQ2A418yYi9vgAHxLSmfcyU0ZgSxrGAav0ccRVVhOtXqfGYp0ez
 9oYsVT10jbEorPx5Qx/SuPkl89N7Ep7QOO/w8bWJXx1HEOlxzSdoEHo6kq5/P8Yhw49Y7y2Sq
 y6PH8f459t++RdY7APnyEoZzxej0rK58l88GoGE3zJkam/P3sZ3fRj6rzI1Oqd/uF0P08lQNH
 fCQ8WHj+JsUb7UFq/SJ6rDgLSg1diaWNX8+Y4fouGDaIEm104Am+hE6tYEq5TUvA1z4mFFgTn
 D88F4YwnnVbhRKsKhBy+qjYtebMkLC1rdt5Pp5BeosN7JeMe935O2zHk1Q5PJwkY6QM3I6tM+
 1Qt8J5+/AMiraJ0EBTvWrfhG07ZoQy3wa40puaaMlTVCWK3aL30DV/eJPO41fDpCD6ki8+guU
 TqKaYhXLZWJmAVeOBLTRJuqO62erdoQaafieV3zNJ8mFzvDZlnULp4OkIWqzbP2ka0TDtYqgF
 2qtajES9/aDNHQrBkbVlTuGMFx+ELNy27mzcFBW6NDQ6+QPZ88QaOPzIRq4t3i7JVZQo80uOu
 YookhJ+Xw4VTRPUiFATbq+07k0ZkySnXQUpMaERJ6sYCYrjh9oIxm/GV2xTJsabOWX12CDwbB
 HXpc1p3PMc3bh5zUJd/ih4lBhxK0+aoHXmIczclqXQRp8ZpmGBp35536T/aVIYf1wLYY5e/Ki
 w7lUIGD1HCSnFVqR7zeWgc2+FxywMmKjLRKjXeqZTXYMT7kYvT//ngCFrmrfOU4esy1Knq72X
 kd0ZBLfGrb1n6PQgklWwPVsh977dWNU8F9FVin+TDmLHTai4MYFFt6Jm18vMeVZ85VTIy6isy
 ONZHju7r1nL5nIURkTCHEjRBhrvcTts7+i9JwK/cyRpuz87qSLOEFTbeU9PNBNZI8LNafthzq
 eH5CGUFwUml8lmrHBco4IonEiUKNU3HhTEdH1akJWTw5UomlEVMrH9qgzCkXCElJrW2T+Mnhu
 XMw0i6+TUKwUpToP4VxkD83pZtS3WQipTsHtRHRjWdXRvPtzpgYaQjO/e/S/TgpyZsK2PGpVv
 IDKlbbMLWdBbsSpUnMaU95BnNDKnm3rJSybFNQxEnBcjI1sf3Kwrz+dTkraw4Dd8Can760Y7P
 E1/pUnqBG7YhnfTPd5x6GYDTtCYyadiavbaDcAE8CYYfnml2/M7qecOB4SiwkPjKCzGosSpXI
 5Cf+4vk6nG9NXibun0DparCe81YIYD1l84K0Ng2dfLAx53mY7oM5vCSsPgc4OWdzDHslj7c4J
 ZXA2x7l7PdH43WUtzVLhPbJhb7yRaNBBdL5MlQfVVgH9lde322YNuWeF4puvrLbfonCD++9AK
 VlgsLlYht28MCMWFYxCLDFHsQL2gEFk7r0T0QzH/IbGkBYE30glTYX0wiEeT6SkCo/P5xm7bW
 7NM085/K04QfC2S7PDLsDrKOXDTSZ4Tnks2cfEO1rn/IcQjOsw0V39SJ5fxs9brOITQqcH/Eg
 z0qbwZ8aaYEy4VSHtWrgqOQ9hjZFuvzdI/WnbEl+f6Jjv7d5LEh3Osil8AdL2yUTJC0iW8+dB
 CRNTED7De6yAMvAHF6+dnIzDbHHHZ8GEpfjSgq7g6GE84ir8KM2vHMm1KpkXTqaOHebtirMby
 CWaCFwkKSTdB2ripbI8ztIsg6FkHVAtkOHNNgUDwgWCq9w4bObCaWgolvqfwoYJp8rEqwessH
 wOdf13PWIz79vbzErrbqH+isq/IyyqZSYN1Y+i7rkruhoOihRpPyupsaO3X6JtOUSUDuHoia+
 EbhadXpQkjPFDFnSpGf8+CKouGYUYeD2W2vlPMYExmGA/zZ/wF2hqOtVZvjCRKUHRkYZ/xVnl
 JaFz4989F0+MDwggKgxjo3rK0+refX0GfoGL8CVlS4RUYbSuUY1kDv+bXDwgSXSRJW9t+sApG
 wreJSe5fVIbw+gbYKrH3gr7926s6eMVYx+hPG12S+VtVv86BcPEWH8IL8+QBCulMIBqgqxmSN
 Cad1MCmmpH6TPZeZujHfpSDKY8OkFuPEgzE2CTwwOjGYUMeX1QNRW0XqPVQ9XouGQ8VabyDcQ
 AVe+NeFut8+So6w61OOmO9i8ygylyc3nkEqq7oZgTG6XiGjkghPUGpS7QjbURYKgf6FqzPiL9
 l2Ar1tgm+b5QvfzE+9VCyXBWFfWDhmzs0Nul6gemOk5/LTx8Qxbwo9Si+XkWXnJznxcKbjOka
 tv+nkwPDgcJ1S1ueez9deE2qRjqohrzoHKDXEswE2CgHwK5k++FuNJa5ZDcg/P/BWnZOwCRFw
 J4Cjtf+sPW+KCt8A8h3DPUxSgjw0PyU68FKCkOY4hMiczuHnJpH39WnMQjOkHbtq4lmx0B15Q
 IPd65H8O5kjZMsTms3eQ8y32YaCpymOh7gsIaTrsZz33uvlAfwXmNfKbLojhZQS09WTZNNje5
 btpkEwKkivxwEsuk2H2LlITO7kyhaAi5R9LXBM/IZ+++j1IRleSP5xh3JjWs18dT3WNzdpQTw
 WwikqCczuggPZMCPNGFrRqBnK4pRG2LcGM6FnbzP/hcS7JWnxDVmAViuY8su6o/rBczwxO5EL
 KMHl+YyLDwFH+f/j/xYEIInJbzoCjWG1A==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225526-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com,lists.freedesktop.org,amd.com,gmail.com,ffwll.ch];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01FD629866F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E2=80=A6
> static int mes_userq_mqd_init_compute(struct amdgpu_device *adev,
> 				      struct amdgpu_usermode_queue *queue,
> 				      struct drm_amdgpu_userq_in *mqd_user,
> 				      struct amdgpu_mqd_prop *userq_props)
> {
> 	struct drm_amdgpu_userq_mqd_compute_gfx11 *mqd __free(kfree) =3D NULL;
=E2=80=A6

How do you think about to use a direct assignment without the variable ini=
tialisation =E2=80=9CNULL=E2=80=9D?

Regards,
Markus

