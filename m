Return-Path: <stable+bounces-125791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698B0A6C361
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A343B87EC
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 19:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA102225A20;
	Fri, 21 Mar 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="ssRnq50W"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA21E5B6D;
	Fri, 21 Mar 2025 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585593; cv=none; b=E8PJ/3hOZdPFrZlKW/aJaaLNU5hHoQScixhunl2pfC0w2CqGltWjzQQnA4KNRbikHcvD/MkTam8d9cHrZfb/DvQxy9NDN74W9ZEZZoxRg6t/fK9VO5RzkT+rp+g0vVryBJf0FvVA42n3KHvETg2Fo5kNZm9w81mcBrb1IvgnZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585593; c=relaxed/simple;
	bh=No278/BwGKzimlmVAXabPdx3Lp9HAwXEy+j7FH5iTWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+8SnxlhQUQSbBRm2G5wsYxNTALOhhhWJpvR5Umam7B/YQnn78BVFEtT7U6OmOW4Vm9NY0v5i+9dxBkscZr9G7zA8djRVZ8q8N6ItK3t3zl79GQTxN04qv59Li1T7uqgzGUiDGnT12O6NhESqCEzo/vFQ8FYjWnv6RZR6BCfUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=ssRnq50W; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1742585574; x=1743190374;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=o5KuILFsArzDnml8ZNWsQJ8DsMl/xcUsw5dgf52brGo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ssRnq50Waqu++4rsD1QVb9Hh2w++MwWnBXJCPKxYR/dKX5DJJRwGIOVjb8ffoKXp
	 9LZwI1WP4F8eM3S5hwdAbS4cueUxQcw9y39HjZiksORrqRO9Cn1tpCmj3oJv+7P6w
	 7L6PN5jz7ILt2rG5cVTGJR1DHx+LNQ2OaBcpZ7ayI+DKxd3i5mjG8tVG7BJ/uFv3v
	 aw4agaHO08rjjTQYftU5Z032vILOxD48zSoWu1Nc9hhE2P6cSC1373W7qjILZy2BY
	 1eS7/qsHrFPPpI4qd/j9GM/aIvMkopEwabj1l97erqrfT2HpgrpjOOWu9S0YUsaLV
	 lVzsYzq6pXwX0uxEzw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.174] ([91.64.229.215]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MzhWp-1t09Nw2NdJ-00uqaa; Fri, 21 Mar 2025 20:27:13 +0100
Message-ID: <a2b2d743-42eb-4eb2-ac41-93d2ab0af939@oldschoolsolutions.biz>
Date: Fri, 21 Mar 2025 20:27:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
 Steev Klimaszewski <steev@kali.org>, Clayton Craft <clayton@craftyguy.net>,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250321094916.19098-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <20250321094916.19098-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4dfKNF8HgT0iUPiS0YLMuHQtP46Vjd5JnvB0drE83CaG3D+6MJ+
 Ity7CaC7MozQZQGLs5J33TTjO/+4CH/npxqtytEHAaXop+U+aoqo2ziHThoj4CmRCfcJnHK
 jkymob2jwwi+dFnWSEI1I8QsE3EX6qb4cdhSPxj+bM0sslfsIrcdXysf0IF4sr8de5x8qNP
 yMiNsDTi7QFMzj6Vfb4+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HAXqntq0MjA=;lAZo7T553Ap6eSU8RLKZIYxgVME
 5ZvVouoLWqW590S2G/8ChERT6iEBRY36npu4n82K5Td7SUh56z3NbG/yPf9VZmiATluhHLHEp
 L30rPbKsS5+vfxU531X0cM3zaGU0C0uxSUbf9CCN5xpux2tnyyOJrGghjJ/dyBOmQZpO3tOao
 /fLhoeHlGVcQIUfrxk8OsrhQDu/o7PykNNfyAB+oSotl/DwM6oauEUnr5bswOaCXEWa8j3vGt
 Db/YW57zS+Zni9GkVQpcibY89T1IP5Lue7l3vH6nlQGpUFv/QFaTeZ7LVrgHfWOdAyosqSMtX
 uGzt7Ukxw54tYA9hCxvtAeK7nnCpyO+XxGRKkEvCDEkijaYERREvehnP4FaXQi5jGGEo5TtJW
 uI7Wu+p2xOOBriz49m3jK96V2WYZzBP2V1lTZjT090w7P4YFz72m+ox3UZirkfBjV56YPjXqs
 DeqzYrfJMcSuo00KL1TFsFhtB9UOelcrnRX1w3o3iSEPjaWc1HTFE4NNqSriy60C7WGWU3Xj8
 9Bhs3fqq0E8SEHwb/SqkMRvOq8kLGzYM0k0LT5HAJ72FaWJDVVmX04yzQM0rD7ukyc5zOCBHd
 PbipUFvb43zot9SRzYmfxFqGVf46GbYp6fP8kX1LS7EXmbWWpcKQD+WY9JtS6pGfcTT+oM7HV
 NQhh2VZA2etVjay3BG4+ihuB4xgo2s7fWiVZxjJaAeqX3TknFh6v3yVmZjEMMOtce2UPIXrs6
 FwFFLmuDxa3cp+VeF29Ohirz1WYkoVlVBrqz4KFZEuStlJzGog3AfqniL2cibSsqmmClu7LqI
 r8vf8cWGivV5Urt03pP7diMXl5RIik+e7PLD2rQG53qI/GIGjrWfrh7ajRlaHaH26jaIapdf4
 wOIADVG51qSP/L7jEy9dfA7AySwPAwXX8h5OV5CWLMf0jJduMm025x4LTRTCX+9qIYakxoG06
 jcxsc7eeqDaSCPv6CCjqHRNCswfaIGl6Tabn6v00QSTBax0FeLxXOjFy68fU6rFHU75tyVKe/
 j7DPRlOBPajyOut0zbfBYFQeM+Yaq+XGsfHCXBzngF00picK9f0AGVEHbz+uPldCC6VJRyEuV
 NEJ+uPmKkjaVPBPg/miHNwLT7BX3fYThepRr/GoQWTFD+19Y6pPBkHOSL/9CR3QpNPNwGf89l
 MkrpEBSz+zXxJkJzXKJb/mxSM3XDyeyJXpg+kNU9jCs8DnOrzUAZQtEYHAhsI6BwC0jwGBHq0
 hfJx+ykC1Z+9/kAk48szAsbaEHQlrAjQ9a23pClBNVB4aQA1uQx9GItD9ZIgp453udfjQ1+Mx
 vj8t6PHE/jBtVTvP51NEKnslEdSg0PoeXTNcX6Ha/YabsgrxQ069uKloJook2DaMDi4ONZqW+
 LAarNRk8j8kSF9PPBH/VCeSXWa0pBYLPKKz2o=

On 3/21/25 10:49, Johan Hovold wrote:
> Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> breaks and the log fills up with errors like:
>
>      ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, exp=
ected 1492
>      ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, exp=
ected 1484
>
> which based on a quick look at the driver seemed to indicate some kind
> of ring-buffer corruption.
>
I had this issue on the Windows Dev Kit 2023 and X13s, interestingly
never on the HP Omnibook X14. With this patch there have been no
occurrences.

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

with best regards

Jens


