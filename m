Return-Path: <stable+bounces-211355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILDFFE8hc2mUsgAAu9opvQ
	(envelope-from <stable+bounces-211355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:20:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CBD71A0F
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 422FB3150B25
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E68C371068;
	Fri, 23 Jan 2026 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BCZU+8dG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWh3Hp8g"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA59361DA4
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152428; cv=none; b=ObK+XzRe1zx0Qns8MjjZ+AiTpn4afojYM7vZwj/OtM1SL6gu+wWh2civSR+bRdXWQ8KIyukS2q8i+JN8I/jtI+jJ7annekTpfoPh7laVcAgDf68IjCZiwPk6ASDqM9EhpoMKP5BDi1ojRQc+3DXF6DAIMARUR0hbwPG5eKgAepg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152428; c=relaxed/simple;
	bh=rirq/fOyMlM31CQl5MqLEiMKur9U+NTbshL35rfFF8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9oke2YaF7VtC2qgnno2ucLZEyRpcuv+GYGf3zIM22j7tBaGtxf08OvBxSM3VMUQwqgd5dFZOSyc24TLCz9HETXRgk2Cz70n4kTRVfArwpHIanET92MzQX5yoSvDPS3kmxlCz6iObNnNpbHun8s2sD9OY2sSkqJQCL9gm53S+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BCZU+8dG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWh3Hp8g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N6LuNf324395
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 07:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6VcAW3BGRWNZq3yJ8vwvFENkBnsjiKdzsu71g/tYccA=; b=BCZU+8dG8r+EKBwc
	/kBrl+W81aM8cOR30s0OiL5zcTeWxyNv8ZJHlYtYbYx+IjXIsaZyOQwKETCjpkjL
	Lwt+8UvvbjkbqkxS/Y/1DOzvxM35QstAgNCvwdvF0uVqQk0vCavLrNSYXD92ySU4
	Ft2dw5MlOzL9WHUx1BtV8Z0G1B6eFeho9dWeX2sSgEwQ8akpQteuxwFd542bfW6C
	IIXS31wx4EGRqwkrdbysNWh3Ytx338hq4GFZCeNpXnWlN8CkSxscCf5gDPqzYAWq
	vjy/vTHV/p4XDlTSCBQBr5bWT07P/xT5R5k4HuT3nUqrnEhxXTygYGN+mdsDkWrl
	qd01og==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv3mq8518-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 07:13:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52d3be24cso225521785a.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 23:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769152412; x=1769757212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6VcAW3BGRWNZq3yJ8vwvFENkBnsjiKdzsu71g/tYccA=;
        b=fWh3Hp8gOqB7/6behUSts/8PR4Wel+zYxiMwYPyAhamug7DtPg2moOFfvMlV92ghfo
         CG25SbdOPB2WubMNDrXTK7JLGN1UdeD8LOSADWxKSY2//Hs0H116lhmtOfXPyuAZYh/0
         I7IBpmIZaYUY1lf20fcD1xRYWSgiNgbTnnPlqKw9Hs3JUFD4ckNNr//aNCMMPDYtKUyb
         OrIEdT1PSZh6PU4OoLLfksF7cE4dHoMNiayUCO5g/v8q/M2CoeJNU6Pwmu1qiwRoS/K0
         raN7nE/4pyGao9ibxkbZjPvjocX/0noD9+22af4WOupN9d5b8rhTy9CYQEsk6mYDgqnB
         c9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769152412; x=1769757212;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VcAW3BGRWNZq3yJ8vwvFENkBnsjiKdzsu71g/tYccA=;
        b=tTMi5WC6jCRqZVRMbzW+KH0+y9zFBvObX6GsTg041ONjE9wI8t+7yKx7hIxdbGvy7M
         I7LMdUi9U9pLa6k2xtF6JAlvKm77Pgatb2KnJlSn0jBPIiWZpqf/3fZfThY3/EgPoW6k
         Gc/raBSBc6eZV1yPeJ24dJCoJUbIqFONSpGuPBgTyTBFGWs8hbBu1WO2igBR0OzwtnI9
         OicZ/gU0lhamdaYMUx6r/8zSG93JjFWwUl8f9mT5sQJaTGuH6egbL89oeq+HeBA901ET
         oLBai/2XgHoOQre9+mhgtUXlb8O8fp4nG6ViLus4s6OWpJ0JYsK/Jz7OHsNUHGNA4aoL
         0p/g==
X-Gm-Message-State: AOJu0YzoiPvs2dwLXzRXVZaf0kEnRC04NfY183ZvGrkMq+jNeeyn17QQ
	OLOwG9IGaaMpKmqZncWSTeR+7cthI4C+dR2DjWoeDZcTS/SZ/gL2JU8mMrMlx0axFuxm8s9NOR8
	+IER9DrwdcIBaPAKvrN3wpBeby/ROGp1uChjxGaLjFdVpyelVRxSbTkTuLJc=
X-Gm-Gg: AZuq6aIr9Jq36tY7uPNKMahbYF2duN8WzXXWrFXSZhdCkkUvma69GBSK1j4Uk51CDZu
	SyJR40Ir+3fMvArYm6bhlo9nOdXXVw0IQ1ga4ooLOuqLex5H7rJkLzdiYXOE+APlMVZ2rng3V+U
	3oxQkUqptmJY6U9/ihQCtVXQHNKth2n9z+ycwNcAx3VIhkRt/diCGmjvzGiKodpgcDALE8vnjHS
	WDLzUtyPiSbDMw0rWo88f0RJ1RrhMnN0jrlWGnlGEcRUile5zGPmNgr0zW2aXrI8/fyq7v9vKWw
	bsNfyqW0G92U5DAom1CSaqc8grC17Ziil04X///PNRYC3lv7Jgmr/fxzMvEk1R30oZbw1wVaKep
	+ePqZGRlGmb4O4shZJxulmfERdI2swjZGi5mTUw==
X-Received: by 2002:a05:620a:25d4:b0:8b2:ea3f:2fa5 with SMTP id af79cd13be357-8c6e2e3f84bmr234845885a.69.1769152412462;
        Thu, 22 Jan 2026 23:13:32 -0800 (PST)
X-Received: by 2002:a05:620a:25d4:b0:8b2:ea3f:2fa5 with SMTP id af79cd13be357-8c6e2e3f84bmr234844585a.69.1769152412000;
        Thu, 22 Jan 2026 23:13:32 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b41asm4471433f8f.39.2026.01.22.23.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 23:13:31 -0800 (PST)
Message-ID: <b02ce9bb-721c-46cd-9f2d-79d38be0ab4f@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 08:13:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: Fix not set tty->port race condition
To: Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260122170031.433724-2-krzysztof.kozlowski@oss.qualcomm.com>
 <e0ee73fe-2b9e-4976-9648-35a6822b8ad1@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <e0ee73fe-2b9e-4976-9648-35a6822b8ad1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8FFwLrYigZTlQP_BEZPngS0twGCeOZ2V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NCBTYWx0ZWRfXzUGyTd9kKktW
 QjD1SINhyOJ1zlWR0XGTWZJEb+yHTpWzr0r12c+oK7Uiw00iie+pUXnKTSM8mci8KBsW+MkX43+
 aMSA18jkeRvEe+PiePrI8fZrP7ROvwrmba+HsYc1MJyzpQ9B52Z+y/LHle8bqaaI4F9fBDMpzIV
 oJ3EchrBsf8nhkdBAq/WWEFaIkWLmyQBqlKsngtdHZThnfotKNgZX/sm4E7BQmj+JgVqtVYlAPa
 PwLCRAaoLbn09A6WEZxKXjCXMVlB7aCw83Op3nH2Gd1ViSyHQDhFhcPnrfdkFXi/ktSqpfGJD4L
 3mqFietKC6tqLG6vd6WWSvu1R3sqAkmFePKQnBrksrywNzFIbi7pXCS/n0IBCL/vBm/onFYX0Wv
 zODTSWbnFwU4An47XBZanWIGe9adi3tK5w9BS0UHYEDH6wrqRnnQEAUyzZaxPY9TMXW8hWE2Wx+
 b2UO/J9I2TlpcXVwAMg==
X-Authority-Analysis: v=2.4 cv=SMpPlevH c=1 sm=1 tr=0 ts=69731f9d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uvOF9WSbueI31WoPFvgA:9 a=QEXdDO2ut3YA:10
 a=UzISIztuOb4A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 8FFwLrYigZTlQP_BEZPngS0twGCeOZ2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-211355-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C2CBD71A0F
X-Rspamd-Action: no action

On 23/01/2026 06:55, Jiri Slaby wrote:
> On 22. 01. 26, 18:00, Krzysztof Kozlowski wrote:
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 0534b2eb1682..116f33f0643f 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3077,6 +3077,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
>>   	if (uport->cons && uport->dev)
>>   		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
>>   
>> +	tty_port_link_device(port, drv->tty_driver, uport->line);
> 
> Bah, so add a comment or I (or somebody) remove it again eventually :(.
> 

Good point.

Best regards,
Krzysztof

