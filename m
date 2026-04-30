Return-Path: <stable+bounces-241991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC+bKf/t8mkovwEAu9opvQ
	(envelope-from <stable+bounces-241991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:51:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25849DBE1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F88C3004C81
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 05:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0B371072;
	Thu, 30 Apr 2026 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIoFDF00";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="STjD+HeI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7834750A
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528307; cv=none; b=X9LH/Tc+MduMh6ojZgvtYXzoyv6suatG9lc6iNsyMay/sW0tkf829qAGqfk73JWV5e0HMHSwHHnNKjiWDhPkoGyJOkXehiZieCP3hTzuniD/c0BmizFH0OzwiwVm/ofsxF+oy3y90tXS5c981mBUI5ZktV+OBrfU9ZFdUdC6wPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528307; c=relaxed/simple;
	bh=CgsL9lPVU9qlSBepqHiQxE4D3Owbkt5paVOqB8gMMOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4A+owXgFpCFyZ3TH49bB52ByCawporKA5nJml90qbawBIOEBPQ8XM7xv/cqpY9BDa5HrAyD7mp2DqTBbvMgFpxJNQT+sZrJFTSYqzZFU34fc4YNWEYlLQmbUhvDy8JjJV2ghSxR6MPeAVo+QFIyHrf7PEqpPZ0CeozJ00zko6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SIoFDF00; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=STjD+HeI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNuJCM3636534
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GBo8ysA1qyB2SNrMg3M4cw+4GiEHzW7353RLYSNaXxk=; b=SIoFDF00jacDCQNv
	i3fu10f9ds0/OtMoHPEFVd/6Qx39sk0UphPrlu07uST1WAn7xgnhza6bHQIxF8wA
	Okq2HyKddErlj0Xj/6dcN1RJi8Y6CjgImTd49bB7GbR7/qiksoB6G3C0xvJ3cR9X
	y76UzzksFCsIXLCXYAm48Ui1GELWl0NyictWSXXP71am1DKRt/QMWJkP976JgwzB
	5ekHsdoajKWjMOHtNlpkEHblVHwH0g2d6KhfdRupL2agjCUJlNR7HAILigz1CrTe
	tiBX91nNXxzT7PdtdSYvPteLEYR5COA01DCvM/mgC4W3OfIiJCkikmuTCrO9zJAf
	NtIPJA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q119c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:51:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso526831a91.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 22:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777528303; x=1778133103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBo8ysA1qyB2SNrMg3M4cw+4GiEHzW7353RLYSNaXxk=;
        b=STjD+HeIJUgtNq+hBQVDZgpi4Gb6iHMXiqIeT8mLVNcJP2TJPhCy5o5LLX67JsBAMZ
         Ud2GAsYqeLqpjlG/gr6Oif9SSikPJMQduZwaXdK73r1lgWtHR7KH7ox482+d9oPl/kcN
         XmIDKAArHsn1S3zfkGWRV27t2LEA2/oRec2PvCn17q0xEef4rvaKDp7OsfA77fbMEvIg
         OgaVqOrpUiqX409SbWG9uzmtCsldunEKTkHCEgfgX1meMTiC/fSneVWN+v0960mT6y1m
         qxmv9bq6rG/pwmELu7I0Hh+mrosqepauQZdSBCWTJKzGInda156X07pCeJBiNL1CCVaB
         AHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777528303; x=1778133103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBo8ysA1qyB2SNrMg3M4cw+4GiEHzW7353RLYSNaXxk=;
        b=RyB9UIFd/VnAiIyn+69PHRZdmvZo0ChEWDQbK/2X2/Lz4S1O00sYEuFvjdHLW63Olq
         q7r0hcsGe+N40cVBNY0gTvHJ343e7T0jCz/9/qALzBEPxveY4GkFfBNqKtjfAz9nPyR4
         eYwMeUpjFu1qgbQehtJlX+iPOCubhtz72Umnnpz4BekWvHvP9S5AE4tYhG00QrvAxpf9
         HmaV2xCgURGZklmCOlbbBNMFfqkc8CN4nGwJNOoPxUd8taat1ElSHJslxAAws/F1EHR+
         z/zhU9mQHo4bcsDPHr2xIJ7/84AL+fCpdkUFbZ+YrIJYGpCsj3PhnFF/mmM4dDz0Bc+T
         ykLA==
X-Forwarded-Encrypted: i=1; AFNElJ8hIN/wDkgO49ByVz2UnvPuOC2uz3K4B/dFiWET+gaqp9pPZRGRgg7EWcOAVHWgXprbXO6SvTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSxzZBL4Uy33c45FR2fsvY4aBElYGa5oyQbTeLSw5yQ5PaGDd
	NCbgHhQ5Tlh902ilAyQ9L/KVQVn0cda1L6goMiDQ+NGc11O/OJMUjiMruXcgCzqCu1qarC9jSOK
	a5zbKCvHwKAGLH87CFZn1gN/vU3wj9fHeSBqgxWEL3IVwDgdu48yEnCUm8VA=
X-Gm-Gg: AeBDiesJk799M8a0Wy9vu+fy5+e+IKh7N19hQieonZUfuJR1TokeMLgG+7FTZFJ4Wji
	O2+FHIY7roHK0giNAyjtqNRCUMyvzB3OdbrR8jiVJ3MWz5veedfdWpdC804LUTw9RN69ls6w20Q
	SZNI+vFOWAkUvbgJz3ZSFHB98CRoRkpiGl7hvzb/CpUwlk81ZlYgff0h7+X12CfsJeZfP463YF5
	kHIpexbHZl7XfqypwIRkBlvAeymZNKStq5SuLZU6h/Cp2HRabTeuatgHcCvSWjB13DUVlOzV9nY
	rYN5/4satkMM545iNRWm+etR4nq5gTo/xUcGSCpp2XK38/6t3xeP3/1ERwjw1B+eXqeHlCpKfym
	9+BwBZNOnCSq2IsIb3ZTLlfU0uUwQxXFxor5mzR0ohSpMLObmp7N+ptHZofBcL+qP
X-Received: by 2002:a17:90b:2ecd:b0:35b:e550:e68a with SMTP id 98e67ed59e1d1-364c2f8cf70mr1346445a91.3.1777528302983;
        Wed, 29 Apr 2026 22:51:42 -0700 (PDT)
X-Received: by 2002:a17:90b:2ecd:b0:35b:e550:e68a with SMTP id 98e67ed59e1d1-364c2f8cf70mr1346420a91.3.1777528302532;
        Wed, 29 Apr 2026 22:51:42 -0700 (PDT)
Received: from [10.217.216.47] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364c3fa0240sm361576a91.5.2026.04.29.22.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 22:51:41 -0700 (PDT)
Message-ID: <a4825fa6-bdeb-4d2f-b7d3-050bb37ff7ad@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 11:21:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk: qcom: dispcc-sdm845: set GENPD_FLAG_NO_STAY_ON
 flag for MDSS domain
To: David Heidelberg <david@ixit.cz>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260217-sdm845-hdk-v1-0-866f1965fef7@oss.qualcomm.com>
 <20260217-sdm845-hdk-v1-1-866f1965fef7@oss.qualcomm.com>
 <vbmo6qvepw5sjmtrffkdiaqulgqrhxlo3lrlzxhjz6i252efvg@uyhzdskc3jut>
 <wiztxwsea2aojcxmcs2q4vskooli7lrw3oio75bij54273mrbr@ody4vonry2qr>
 <857f0582-8b46-4bfa-8c62-5ca6f3d0aec5@oss.qualcomm.com>
 <mgsigotfsu7xbquwgsrrm2rctx2e5xjmaijg6b7nzaedqerefi@oxvufd72novr>
 <c8425943-850e-4665-8d23-f5257473b793@ixit.cz>
Content-Language: en-US
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
In-Reply-To: <c8425943-850e-4665-8d23-f5257473b793@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -SnfuDW01e8ONuvhqZBYivxWD2Zsd1uk
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f2edef cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=MnzUK-aiO01mxYzieDsA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX8X5/zDZylAqf
 vicAqmHp1SbqwwstOpDPtftTR08cx152+EA3LNIRe5B/xpS9hOaXMLTzWv9ZIkC3fwFeZ8DHAsg
 G2Fk4ujx/fcOm+zQpBRJkrQMaWDHKkYHzpj7Xjsqx61nGzCYDJOOrNtEnxf/5KB84tulbxX7Xh1
 MQ4YR7VS8b2ePik90X8OUQFjpcHCrt7pjq0DAlbTnlhmCoZD/8oQagCF3vq4UrcmXDpY/4SH6ZA
 dXdeWIJFbXDGq/eeyKvE5AlMIedHSKdR5iFquypXNS4PPov8U0fb4KgtdeSrtZpoFLIyif2BRDU
 vR7k84ILRNSFvgWOCWNUgsd8+6pXaWqf+VNaGTX36OyJ5I88MJstETRV1Ib2Z7ZN0sPOhimxahx
 fEC7Gp3vTDh1l9rnb7VXoCONSe+Gh6KmhBUNRd+4WTF974OOevoceON9CVCyJtIUN92MzxgzgYh
 MDN8AhAfOGHcV6QlFVg==
X-Proofpoint-ORIG-GUID: -SnfuDW01e8ONuvhqZBYivxWD2Zsd1uk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055
X-Rspamd-Queue-Id: AE25849DBE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241991-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jagadeesh.kona@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/29/2026 8:52 PM, David Heidelberg wrote:
> On 23/02/2026 02:27, Dmitry Baryshkov wrote:
>> On Thu, Feb 19, 2026 at 11:41:06PM +0530, Jagadeesh Kona wrote:
>>>
>>>
>>> On 2/18/2026 9:28 PM, Dmitry Baryshkov wrote:
>>>> On Wed, Feb 18, 2026 at 08:49:34AM -0600, Bjorn Andersson wrote:
>>>>> On Tue, Feb 17, 2026 at 11:20:42PM +0200, Dmitry Baryshkov wrote:
>>>>>> Since the commit 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds
>>>>>> on until late_initcall_sync") setting of the display clocks is partially
>>>>>> broken. For example, when on SDM845-HDK the bootloader leaves display
>>>>>> enabled, later the kernel can't set up DSI clocks, ending up with the
>>>>>> broken display, blinking blue.
>>>>>
>>>>> This describes how the problem manifest itself. Can you please document
>>>>> why clocks are partially broken and how that relate to the GDSC state,
>>>>> and why setting GENPD_FLAG_NO_STAY_ON solves this?
>>>>
>>>> Probably the best answer (for the second part of the question): I don't
>>>> know (yet).
>>>>
>>>
>>> RCG update typically gets stuck if the new/old source is OFF while the RCG is ON; but
>>> if the RCG is already OFF, the update proceeds safely even if new/old source is OFF.
>>>
>>> A possible theory is that if the GDSC is in OFF state, the branch clocks will be OFF,
>>> due to this RCG also will be in OFF state, preventing the update stuck issue even if
>>> the new/old source is OFF. But, if the GDSC remains on until sync_state, the branches
>>> and RCG likely stays ON, leading to update stuck issue if the new/old source is OFF.
>>>
>>> Ideally, if both old and new RCG sources are ON during the update configuration, the
>>> update should succeed regardless of the GDSC status.
>>
>> Both pclkN_clk_src clocks have CLK_OPS_PARENT_ENABLE set, so the parents
>> must be on.
> 
> Should this patch go in as is then?

Yes, this change keeps the display GDSC behavior similar to earlier code(i.e prior to
commit 13a4b7fb6260), so can be mainlined.

Thanks,
Jagadeesh

