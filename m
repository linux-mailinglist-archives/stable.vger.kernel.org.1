Return-Path: <stable+bounces-115085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7070A334B2
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 02:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4086F3A6D64
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 01:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88B132117;
	Thu, 13 Feb 2025 01:29:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259A04A29;
	Thu, 13 Feb 2025 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410190; cv=none; b=a/y3zoYjjESwCuXRf+TFSrY73PfbFAHmHeCVZZJmYbIfJTeF/LLRU8FxUZtuK22sjA/4a6R385HtBj5XADkOJI34aHy+90GD7rs1HOiDg7W1iKPIWdfeSVrSJDA2WDPq0DkVnDIdL5gwVqS2MwXzJFBLT/7JyURxfBBYMXIFpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410190; c=relaxed/simple;
	bh=BwGNN0WPDjQPlX+dzowQ2wyxG7TkR/Wr2GU26NweXTE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AxawC6ayHBm7FvzWsGxdSrlkPV9kZZmBiVeHMCzOMy0mxMTaug845QjCWZ459xG/i/HTM37bB0erKANhgmtDpv8f1Iccx6MmUG3iDDXuTmkw+GHPm3paBDiDCjMVJCyh7HeOwVjrIA+SdSyaY9tYCiRdCHIlgBAdL/WmvRcLlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxqmoGS61nHLRzAA--.4783S3;
	Thu, 13 Feb 2025 09:29:42 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMBxrMYCS61n6_wOAA--.3807S2;
	Thu, 13 Feb 2025 09:29:40 +0800 (CST)
Subject: Re: [PATCH V2] net: stmmac: dwmac-loongson: Add fix_soc_reset()
 callback
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, si.yanteng@linux.dev, fancer.lancer@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20250212023622.14512-1-zhaoqunqin@loongson.cn>
 <1def2434-9033-4c83-b7de-c6364b7d3003@kernel.org>
 <63882ba5-0b19-308c-d3d8-0dca7509c105@loongson.cn>
 <CAAhV-H5207Mf5QCHfT-Of-e=66snNrC9F-3T24JUaTGMf1xdcA@mail.gmail.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <9d2de420-7cc6-855d-1f1f-c787e68c8fbf@loongson.cn>
Date: Thu, 13 Feb 2025 09:30:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5207Mf5QCHfT-Of-e=66snNrC9F-3T24JUaTGMf1xdcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxrMYCS61n6_wOAA--.3807S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw1UJw17KFWUtFy5WFWDJrc_yoW3Jwc_Xr
	ZFvwn7Cr93XasF9wnrKan29rnagayDG347G3y5Xr40q34IyryDur1Dur97u3ZIq3ykXF15
	ur4kua4rCr4fWosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1l
	Yx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2025/2/12 下午2:13, Huacai Chen 写道:
> On Wed, Feb 12, 2025 at 2:03 PM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>>
>> 在 2025/2/12 下午1:42, Krzysztof Kozlowski 写道:
>>> On 12/02/2025 03:36, Qunqin Zhao wrote:
>>>> Loongson's DWMAC device may take nearly two seconds to complete DMA reset,
>>>> however, the default waiting time for reset is 200 milliseconds.
>>>>
>>>> Fixes: 803fc61df261 ("net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support")
>>> You still miss cc-stable.
>> OK, thanks.
> You can copy-paste the error message to commit message since you need
> V3, and the title should begin with [PATCH net V3].
OK, thanks.
>
> Huacai
>
>>> Best regards,
>>> Krzysztof


