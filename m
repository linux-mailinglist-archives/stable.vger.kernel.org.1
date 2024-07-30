Return-Path: <stable+bounces-62650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E35940BE2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4672A1C23E59
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610C9194157;
	Tue, 30 Jul 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2xEQgme"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1B194087
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328786; cv=none; b=OhXYTPG0q1IO4uerM5ByJKCkosfH5A+2M9gTQCLxZ0ByKnZ15zLYOALQuPSSBI39RwNllp8YTVOuSojPJvpUeOuo3f8ZwtKK9aUPlqTabgG9bIkD/HEgCNfHDxPdkzNdl9PgsasQS8C2tpU71NUicJBFCFgeJBBTTGLSfjhUFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328786; c=relaxed/simple;
	bh=kpdQG6yB98uaLHzj03tYd/l6KR69dRR6ZSb3cvXgUII=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PxHp4x5IRR0Cc5bfKaDTLIeBWX4zvQpxkfQ3/hzjGlkYznuf4YH1eDdCyUIITHQyUD8ApL1sQpv0z4/sV3wcLLhE0KuJ8cRisvzzXG/47pXid+bBjKhDdrZls6cck9w3EpdDZvN/WC9qidHsjqTvsP2MTgBRuJSw7K+E1AHrXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2xEQgme; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428243f928cso3639985e9.3
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722328782; x=1722933582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/mAglCNUGdccjoyEA9UGpBCtWXf2TmguD9tkOS0Mdk4=;
        b=G2xEQgme/6jjeKuVjTWqJKnJkUu8DWsbdCIIzgBQT1QQJV76Q9uobo9ML8Iwu79uhr
         tXTaiL7E9uMpSsTNzz1ZdZHjvDpRJhlhuDQHNfqbxFLXnnmCb+HD5ozDI4zkq4yhBcO1
         uD89gt4Oh1tCo1WJDKrkaH6RQBTtuTxXnRXutvnt5MaRUNPORNpflKqQR/Ef0Tph8NEY
         1vglvvzISGLIGEiLgyXswvoq48FqdBXgX7QnZLLbIAA5XQpX1rQJM3VXWFprGnpzXjNR
         glhiAf3kn/B6Ho7kd0s9gy45hKFpOAMr6B45YH5i0w0Pgw1BgIpWYfVRwsoy0ztB0Bxl
         /6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328782; x=1722933582;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mAglCNUGdccjoyEA9UGpBCtWXf2TmguD9tkOS0Mdk4=;
        b=VzvpVMSwMHHJSPqU1j3vmHuvw2yMtUtGyAjGAf2Mu/Jwj1v9UCsHadurzRF4wckMix
         47sqdAmvzCoB2b8EQlUtM+/YQEkY1PLsQ6SigFsZ6pWuwnG4wHAmeTbC7mZYUvkO1dpX
         BvhDll9ylsfyQ2hBYuJ4fG7mFdDiw2n0vT5DD0zSnSTul/ag7ACG6DAkOt7+I+Fzm8ha
         q1I4xY6yxeATHqFOCl0EmDPgXG6F739G6ip52nrlEtTdsKdx6947Q7U+UXxvsRA+sbOM
         Vf1yAQMqPNWnDO42x/IbHR2xy7jibuMbHHqlBJ+aC+sW4DZg1Dj8Qq9PIaRckTwcd1in
         /09g==
X-Gm-Message-State: AOJu0Ywe8VZs/xscykmb9r6dJCd6sNJij77UjyhdKwZeEay1BKf+y0hk
	m0JN/0VO8ud3FHYMGvHFGipbpMlAr5l0H004v1i95a54rZiSIsZ+pYkMVG6IIys=
X-Google-Smtp-Source: AGHT+IENMcR5jIX/gXj+EPZjFabTgRcbsQcgq6YQWbyvsrf9KC5wqYnfeWPzcHlh/nwwHxI3zHhcMQ==
X-Received: by 2002:a05:600c:458f:b0:428:16a0:1c3d with SMTP id 5b1f17b1804b1-42816a07e88mr61865585e9.19.1722328782375;
        Tue, 30 Jul 2024 01:39:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281c79ea02sm72099245e9.46.2024.07.30.01.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:39:41 -0700 (PDT)
Message-ID: <dc66cd0d-6807-4613-89a8-296ce5dd2daf@linaro.org>
Date: Tue, 30 Jul 2024 10:39:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
 <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
 <22b20ad7-8a25-4cb2-a24e-d6841b219977@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <22b20ad7-8a25-4cb2-a24e-d6841b219977@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 10:23, Krzysztof Kozlowski wrote:
> On 29/07/2024 16:25, Pierre-Louis Bossart wrote:
>>
>>
>> On 7/29/24 16:01, Krzysztof Kozlowski wrote:
>>> Two bitmasks in 'struct sdw_slave_prop' - 'source_ports' and
>>> 'sink_ports' - define which ports to program in
>>> sdw_program_slave_port_params().  The masks are used to get the
>>> appropriate data port properties ('struct sdw_get_slave_dpn_prop') from
>>> an array.
>>>
>>> Bitmasks can be non-continuous or can start from index different than 0,
>>> thus when looking for matching port property for given port, we must
>>> iterate over mask bits, not from 0 up to number of ports.
>>>
>>> This fixes allocation and programming slave ports, when a source or sink
>>> masks start from further index.
>>>
>>> Fixes: f8101c74aa54 ("soundwire: Add Master and Slave port programming")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> This is a valid change to optimize how the port are accessed.
>>
>> But the commit message is not completely clear, the allocation in
>> mipi_disco.c is not modified and I don't think there's anything that
>> would crash. If there are non-contiguous ports, we will still allocate
>> space that will not be initialized/used.
>>
>> 	/* Allocate memory for set bits in port lists */
>> 	nval = hweight32(prop->source_ports);
>> 	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>> 					  sizeof(*prop->src_dpn_prop),
>> 					  GFP_KERNEL);
>> 	if (!prop->src_dpn_prop)
>> 		return -ENOMEM;
>>
>> 	/* Read dpn properties for source port(s) */
>> 	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
>> 			   prop->source_ports, "source");
>>
>> IOW, this is a valid change, but it's an optimization, not a fix in the
>> usual sense of 'kernel oops otherwise'.
>>
>> Am I missing something?
>>
>> BTW, the notion of DPn is that n > 0. DP0 is a special case with
>> different properties, BIT(0) cannot be set for either of the sink/source
>> port bitmask.
> 
> I think we speak about two different things. port num > 1, that's
> correct. But index for src_dpn_prop array is something different. Look
> at mipi-disco sdw_slave_read_dpn():
> 
> 173         u32 bit, i = 0;
> ...
> 178         addr = ports;
> 179         /* valid ports are 1 to 14 so apply mask */
> 180         addr &= GENMASK(14, 1);
> 181
> 182         for_each_set_bit(bit, &addr, 32) {
> ...
> 186                 dpn[i].num = bit;
> 
> 
> so dpn[0..i] = 1..n
> where i is also the bit in the mask.
> 
> Similar implementation was done in Qualcomm wsa and wcd codecs like:
> array indexed from 0:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wcd938x-sdw.c?h=v6.11-rc1#n51
> 
> genmask from 0, with a mistake:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wcd938x-sdw.c?h=v6.11-rc1#n1255
> 
> The mistake I corrected here:
> https://lore.kernel.org/all/20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org/
> 
> To summarize, the mask does not denote port numbers (1...14) but indices
> of the dpn array which are from 0..whatever (usually -1 from port number).
> 

Let me also complete this with a real life example of my work in
progress. I want to use same dpn_prop array for sink and source ports
and use different masks. The code in progress is:

https://git.codelinaro.org/krzysztof.kozlowski/linux/-/commit/ef709a0e8ab2498751305367e945df18d7a05c78#6f965d7b74e712a5cfcbc1cca407b85443a66bac_2147_2157

Without this patch, I get -EINVAL from sdw_get_slave_dpn_prop():
  soundwire sdw-master-1-0: Program transport params failed: -22

Best regards,
Krzysztof


