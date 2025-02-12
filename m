Return-Path: <stable+bounces-115002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A75A31E6F
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 07:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE091884F09
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 06:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB51F9AAB;
	Wed, 12 Feb 2025 06:03:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689B02B9BC;
	Wed, 12 Feb 2025 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340223; cv=none; b=Z1lXfFlkLWSWMRZzMEscT+8TvL6GTr0imct2CkCcF5DSE8dOkeYGwrXg/j8N3+fwXASXKTiYd1XZZLhd3PB5eg7Sx3rv7e+rnIqID7C+//JL/zv8KQnLrmrvXMZIf3sFDKYGnN878lnzvZKqPBrEm699nrhkkstiK7N7Y+zF+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340223; c=relaxed/simple;
	bh=A7bUJ9Tj4Ai/7lw/dplhZEAaZKBpK26vmJNoCkPBTNM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LxJP4Mmljwkv4ZdjLFGRfWBiIukhu8wFnZbPZGB56FL9u69gMqhTnvj+jx+Kr0bv9yRyltmlZxqdpOCBw4m3+kcXXt5sF9olEA3IMJKdpmbOobA97VfTjnJAxydFK60omUcd0I5vIa6XdM4mU37luwh2UdlkxMuSex2NFCpslNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxdXC4OaxnMONyAA--.3417S3;
	Wed, 12 Feb 2025 14:03:36 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxSsS2OaxnsTsNAA--.1048S2;
	Wed, 12 Feb 2025 14:03:35 +0800 (CST)
Subject: Re: [PATCH V2] net: stmmac: dwmac-loongson: Add fix_soc_reset()
 callback
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chenhuacai@kernel.org,
 si.yanteng@linux.dev, fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250212023622.14512-1-zhaoqunqin@loongson.cn>
 <1def2434-9033-4c83-b7de-c6364b7d3003@kernel.org>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <63882ba5-0b19-308c-d3d8-0dca7509c105@loongson.cn>
Date: Wed, 12 Feb 2025 14:04:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1def2434-9033-4c83-b7de-c6364b7d3003@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxSsS2OaxnsTsNAA--.1048S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUPKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxAqzxv262kKe7AKxVWUAVWUtwCF54CYxVCY1x02
	62kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07j83kZUUUUU=


在 2025/2/12 下午1:42, Krzysztof Kozlowski 写道:
> On 12/02/2025 03:36, Qunqin Zhao wrote:
>> Loongson's DWMAC device may take nearly two seconds to complete DMA reset,
>> however, the default waiting time for reset is 200 milliseconds.
>>
>> Fixes: 803fc61df261 ("net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support")
> You still miss cc-stable.
OK, thanks.
>
> Best regards,
> Krzysztof


