Return-Path: <stable+bounces-211265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL9tGmRgcmnbjAAAu9opvQ
	(envelope-from <stable+bounces-211265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:37:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52C36B78E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E0F5307055A
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C4530F7E3;
	Thu, 22 Jan 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YytJqkTS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aXwMPHJB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302DD2D77E3
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101936; cv=none; b=s6dZENnGzuJ7eu2QBRcvcb31im6JBiY9uY+QWO2JK/xC7zEqzqQ+IKzCJWQGAoRReOPbio+/+ZaRKVLtYwmwLaRexsR+aneg5MGw9B0oBX3PKLZKSeOIyqRDZ+xTnNxcYCOQlJt/GAHjnYsVbg0Wzj1VxyhwEbeK+lwARYQGAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101936; c=relaxed/simple;
	bh=uZ1SGlCxl1R4gFzNS2I0EgnNLQXTj+DNqllFC8dcKIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWxnpZQgaCzeV8/N9jt9r9Yq0rE5o2n2vCUiWVlXIVAG7LUL0qLI1Eyh1TGvSuENyp/Hc+9si0HTowOD/a+q94oxd0IpiEESZY7XTGsAO+R6F43LqfOPgPmrtRo7vKnmrkoCGizXLwWDk0e4sSkYPGlk8MUyMmFRVkVKhi13B6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YytJqkTS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aXwMPHJB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MH4gln3283130
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZ1SGlCxl1R4gFzNS2I0EgnNLQXTj+DNqllFC8dcKIs=; b=YytJqkTSGqYzvgkE
	ni/n1UNsn7EvI5JbsZxZIJUErXqKfTFtASUWBKN+EClTDHjnr/b2+CnAp40rJJUV
	mYyj/clI80NHMyxb1zaq8e8l0IcE2UlRp/YKv78tjNixbO8U2xOyKAGj3TxeD6va
	X8KGdjJsgn46pUx5iXse5gf9qAv6gaJ71nIC8cyuTMl7kF2V+fXQbGEprhQfTZkJ
	l5jU9sYC5XCFzTbl00zrlOx5qvqWSAed9eH2JaMyUsZIwaQ73vIpiHH3DWb7UeKx
	GTojB36/77tseqapGWJq3kL1I7GR6Za6VHjCtx4K1fdCUsdpr3nPVUfdBB/R4zIS
	J3R2jw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buqyp0159-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:12:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8ba026720eeso367418185a.1
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 09:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769101922; x=1769706722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ1SGlCxl1R4gFzNS2I0EgnNLQXTj+DNqllFC8dcKIs=;
        b=aXwMPHJB6D+AqJpufroJ4IZu9Oyn/O1zjOApfNr5NVUpYsCk4oen+zZLN2FJ5k7u2u
         ejW2vsWPbec24FsBp27gVaxkW3xvJVLi6HpsKtpsSesj1KTPs+vLs3mlzKGxr1wj/lU2
         +xZvvKEQuNmATvEXvL8FiysItIrVIC9jQsxAGMv4Y0bnf4XH1MrLcXBgQgkIV4S7ZHUI
         3a4HL/tchWZKYdWPkJyXLodTUTycb6LB6F8Gi+JURS0NPwiPnbA+4smNQRbB+4BkGP0X
         OCsaOL6kToU7wbZckR5tEZ63uVQctXI2hQ5mKDz+7AG3yVVbQNXuuRnKd/K3Cg0QyIJY
         +WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101922; x=1769706722;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ1SGlCxl1R4gFzNS2I0EgnNLQXTj+DNqllFC8dcKIs=;
        b=d6WStXZD2an4WIt1kBsbmwqK3cPcyG3LQK88O5GE8okQGD4BG/3NMNWyF9ofvBxVZw
         ebYtG/O2z6VwL5t6nVqtK6sdKnUwXPiQ6I2vtDWuACwuzyK8yhqyxa9qM+LVTI/nnhaf
         KZzApBZ/dJpDUh7UHXDn7+7BTsiPxi7TYG+CXf5IDBbo13UxDxaDOeEqWy9tUuTISn9Y
         lbCA99c1wos0C27XAQdCkcsGajOwUhlH87ppUq2YORokWsqjsKYa5vN/L+aYCYqGMM3v
         0sMbZLmDLloRlb9oyJfaN8ujpfvzgIyHKAOSVCv+rMg1Rq1DUNjIqJ1jS2Jgxn/aZPlP
         PiWg==
X-Gm-Message-State: AOJu0YxfBAtxw/R04xfytkICkMMkl6jnUTK+YaQHBgOtQuIC+YqAMO1Q
	ohunENP+C0Mq68/oOyKtcc9txsoDJuFr/c6yWsz3xU1luIQMQ7ruvkYHvYTS0G5c46DhxUnp2yS
	sCOSOaYUN9oKI+8TIxq+j8ykwqxKpOV3Jy2wmlMSa0wIoLrLxOt0MS4kRfpM=
X-Gm-Gg: AZuq6aLa5qLW+W6mLVeLBkYHth/SK0jorDKqLfI0tkgPHIpJJtgVeLUsYe7UMhZmAGz
	iwsGPq2IqjgmxauaY29YjhkaQyLrv5ur8vWB5FMcgmOwMSMAHjYAXWBOeixoIqG5BuY/XFh023S
	O2oNBU5UxsVq72Nt4jGy8ubF0MnquvU0G3KPyVUtkPlVpdi5nUk+0IRis3qKC8UqX1tfrNmgsST
	v+dc/2k4Wkit0pAMqFFYuCVySL4gbNLcaIZeo4Ig/jZK571kULkbdOdB6dolgdLAsiWtakSXmit
	KlxiN5Xw+zyc50XIdY9hmgMS9CFJ5gz/MqnTggP75T1QRfVWCUkeEfImnBttVO+xeAy8kR98XQ5
	CTEhT15dqO4KUCDFlb2nAIwlSuUNRJWJ3SiZ1/Q==
X-Received: by 2002:a05:620a:29d6:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8c6e2e19376mr17705685a.42.1769101922215;
        Thu, 22 Jan 2026 09:12:02 -0800 (PST)
X-Received: by 2002:a05:620a:29d6:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8c6e2e19376mr17701385a.42.1769101921744;
        Thu, 22 Jan 2026 09:12:01 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704b4e6sm81577885e9.7.2026.01.22.09.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 09:12:01 -0800 (PST)
Message-ID: <d86ad878-a125-41c9-a0a3-bc24c926ba55@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:11:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: Fix not set tty->port race condition
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260122170031.433724-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260122170031.433724-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMy+3oi+ c=1 sm=1 tr=0 ts=69725a63 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGW4CxhK6uMy43gILDQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: XYqMXdM3gPv7Um6XO83bm2GrM7jjvu1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyOSBTYWx0ZWRfX3MchmyT10LAs
 K9E9EdZYbuI45vD8xzgAXdMifGDae9C3+adYYKcvozDCn7+JEwIViqAYKRB3smenuqoB63UYmsu
 uTCCjbS2L/1SrfXVm0Y64G9MeAxFwsOanlmb4Iu8fBmMFJve1OCM40ijGZNNgyO72b5Zo72PyjT
 r6CjirUf8hidgxwpD3PXTrrq7tNuSCK2SQZwmWceOn8LhTigT20ZVWePX8oE0POBqtMyVG7tk4B
 2Pi5/jffSRFno716kD7B2Vi33RpOpPUmO3XWH5HGaA83jOq78PGOCPky8mnXpiWGWvaijIVNzNp
 TGmJvRKayr9nrcSzPqqwSXxIpRdxX1tiBzMe+dI4gkkIrPTY5WryFZcNK/QoSEyF8Wlbkp7qa33
 QECXJ+VQ0SDVPkaiZrsVDAPgsJYKuyic23esQH6Q18PqLs3gp1ZxSd0zrunKrG/ioeYidLDtsPv
 f4OnAQxJBvtzhGjJTgA==
X-Proofpoint-GUID: XYqMXdM3gPv7Um6XO83bm2GrM7jjvu1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-211265-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D52C36B78E
X-Rspamd-Action: no action

On 22/01/2026 18:00, Krzysztof Kozlowski wrote:
> Revert commit bfc467db60b7 ("serial: remove redundant
> tty_port_link_device()") because the tty_port_link_device() is not

And grumpy side note because I was looking at this for more than a day
blaming my new hardware:

I really wish commits (e.g. bfc467db60b7) calling something redundant
had that much of message written why something is redundant as the
commit (fb2b90014d78) which introduced that part of code.

If someone wrote one page of text why foo is needed, we should write not
less why it is not needed :)

Best regards,
Krzysztof

