Return-Path: <stable+bounces-225514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEg8OSTNt2kRVQEAu9opvQ
	(envelope-from <stable+bounces-225514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 10:28:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFE7296F94
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2E2B300DDE1
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A13387340;
	Mon, 16 Mar 2026 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="War0LXQ2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="foGdJz9I"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61108386C04
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653240; cv=none; b=Siy1aEXskeYks8h6xMxXHXmltYR1A1LQk3Rt+Ub+Knjz1pIwdCj7cATA6OMNlmrIfUi1nsQdePUnl16YWiMt9buXBm2ZczCtWtXDaGh6XM5V6rm4ty21YEdm9o27oeJfxZ5ztVlQ2b7tU0YeiMuQOV5yjl7eInKZ4sXxOstOmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653240; c=relaxed/simple;
	bh=m20NV7YPDGEPnyJy9guKx8ra6fkNvm2ZBvh8TyLifBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaSJ6rusEJjQBdPWhax21Fv0dgJyggc5nGK2TF50OwrhnR8ePENmXSBZP6zHrhAePEM2oprULv8+jRcghFcEyzS99ZcNTRsGWktpUwyQV7KVzwjXFeSiEoe9mBFHxFWxHA7Ou+IJ/TL61bV78O6KzxF+qfwwvdZDrzbkNXUlPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=War0LXQ2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=foGdJz9I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G7n3qc042138
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 09:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yea+5C9HO2jmK24J3rUgeOWtF9taHgrTpJT6HV5pjcA=; b=War0LXQ2OqmTETeK
	oQrDwMJd97kxbD3kyQrxIlvZE9o5Dw9buSyVBGDL3YuphUJ/5gT0VKLjllWG/Wzd
	05eGYwiJMnSf/G7NyisFpo1rJAbG7dHvmXbS3fQDsFeEHDauDTqwbxI2FT9g/1aA
	J+PfXZTxkwATAE8hydHvIx21GZPTLhTRYuJX3ZouQzfoACtFddB1+lENaUOV+Uvo
	gQUxgCry8Rk4GqMQUccGOUQkEWFbOiqVx12nDslIdnX98TzS+7lul9Gc+SqlEmK4
	zFus/YJ4nu2JwTP4GYO0gudC/YEw+XWAEHmYq2aRuCc4f7/eJJOV/PbAJlDi9lbA
	IpL/lA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxdt80bc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 09:27:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb485c686cso278111785a.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773653237; x=1774258037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yea+5C9HO2jmK24J3rUgeOWtF9taHgrTpJT6HV5pjcA=;
        b=foGdJz9IhjZWbPp/5pFwAkJD93G4oJFCW6pupwCTybh0SzF9rR07rlbzLoUABuRT8l
         +LSI+idzpB8zAOfh8ItHx/rZkdzVNA5ZB4D9J5a0s7hSUl65xsyYlTKIVGi1Mj+BuGmb
         hQ81GrQAKEu8+7CJoPzinhJebSMISwmuTTthNZZLcYcDPKSFqQjsCRRZiSe1ejQV3BXE
         /38n+8lAX1ox5FsNU81wzWtv5NtwT2Qy+QyyiyrShwE7CYfoni/165K+w1yg/jtylwHM
         QUKyd2xzHZHY6Wp1VrAIZzYC4GBuz5aA6eg9QRllr5FLpE6J80e4QOqka5sQX7wBtX31
         8VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653237; x=1774258037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yea+5C9HO2jmK24J3rUgeOWtF9taHgrTpJT6HV5pjcA=;
        b=e3kfVPfq8KWqx/9v7jZZ+C4G86E34LBIslBeanMiQXu+NNfvGGdPehIIGFzx7TUe8C
         zLF7aZn8UJjSfh8n6X0jYErJmLeueCqQGNisagftINmUhpJ4osOjbssefbrhgsTYIQYi
         O6haxojtn6VkQU4EF2wLeR98zL2RpmLhbX2T5H5g68ajLAW3iz7aIxdDYYAaJRHD5J99
         gOR56rcPg2VH1PfBTQ9V1axsddZ5Gql38j1HxcMJuH5SuBmC3/gdax643+C2fWYaEdWa
         /R089l6kTltKcL86d2ptLi+SVWSq2jOHeE9UY661+eBiQWUW89gNnXIVPK5rK+YVAHDt
         aKTg==
X-Forwarded-Encrypted: i=1; AJvYcCWuDqQkW2HHdGiQHMZHD57JMhxLPaxy+oVSNUVY1eLtnm7qxat6F81HTIK4nVt/IRccAeEsZ6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV96wTqMs8wygPSaOR02QOYO2ObdEd0CC4ym4oEmxLfVeB5Lbx
	JG9+55Spm2T4PbxNLNll7Lgbazd3CxVoih8QlTFhQo9plqKDfizJ4KPJcmBCqpjH5mcloeolyLY
	Bxnp6rlco+aa8o2U6PWhB6A26KPJ9yRqtKlkW3WvefXSplT6Nk5Q/wRWgxelWCrexyRU=
X-Gm-Gg: ATEYQzzXndYJRPVoMlJxSpCly1N0Vlr4gi3UPJnE2NzWtL8DuN2gToAeG4vD6tFCb90
	99sOmkzDz7ZCjOXxlEieZCVj7h0LHd2LQeaAJSHNxSsXUKA1bXluqpEH4w+KSFzZX44n3OShbJW
	2ErDsPZ07i1j8LtFCEeSM4/kLi58YkkwDCwtfOC/cFi72q7hBbWBCex0bDfNlzPiZmAUiDvoLyt
	jwwbp/Pj8DN8UbTJ4mw24xmDmmeVVoIL41+0rtXghn1WhE7fLHk5QICd679nnWYQ1mh6UzHxkqI
	elxb5PYqHrpbn/bBuzUp+A7mWPAVyfbyHIkcDQtHhhaEh5RXOawEo/i11ReSYWFSl91FWuP7bpH
	NEIjLPUr6Z3IekKnYMY7eQ5c0zWUXUTHRKAD7jQaFtshqcZPXxGjY60KD/VtC3dl7hz+727YmkF
	pE4cg=
X-Received: by 2002:a05:620a:4113:b0:8cd:9828:a7b4 with SMTP id af79cd13be357-8cdb5baac4amr1099346385a.9.1773653237646;
        Mon, 16 Mar 2026 02:27:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4113:b0:8cd:9828:a7b4 with SMTP id af79cd13be357-8cdb5baac4amr1099342785a.9.1773653237104;
        Mon, 16 Mar 2026 02:27:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66350d6fe24sm4815442a12.29.2026.03.16.02.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:27:15 -0700 (PDT)
Message-ID: <7d8211c5-7b12-4349-a329-cfb51a918a1c@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:27:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com>
 <2f4e4cc7-2600-482e-88d9-d4b20d328a72@oss.qualcomm.com>
 <drcot4oxpea5lnpa5htrrl2n6tcc4ocxmb5vsho3ocouvajwlo@6ueabivtjy4h>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <drcot4oxpea5lnpa5htrrl2n6tcc4ocxmb5vsho3ocouvajwlo@6ueabivtjy4h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6oScTWSO-k-sbogPirUeOrPDbhOQFCc9
X-Authority-Analysis: v=2.4 cv=CKInnBrD c=1 sm=1 tr=0 ts=69b7ccf6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=i3U1ZhqbavsoaJQYhn0A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 6oScTWSO-k-sbogPirUeOrPDbhOQFCc9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MiBTYWx0ZWRfXxv1WY/jBoEiM
 4U2kW4GV5t3M+wxHPCr5nWVSO4f0gfrfDpOeQ7W6jpKIdzUilViHHTb3AxtmVp3GKLOf1IjkMW7
 JGbVMoQWz25MTZr2zViSCwi7dZ264ND/vBm5KdwzbXQgzysTVPtpBsC9nmyJanB0j4oEplfi8tF
 XqEWX9olmwLD703BndQaYfAR7DJY9+O5/j4ZQ8lpzcBDsar4lF2tg1khY/xEzX4AgjPMuvI7/Bp
 OiS9Qx5gglom7YcfHpiyyzKfHibRLggyL0vozMlIJvz83CLrj1QdHa5aSVCBq28NhWe3ycARvh0
 iIaAHzEvfP9L90JS6XjKJQm9DbQG6UhOuRm1rB3jqfHQRiNV8K16XWem2p15QTgZiel5OjF1DNH
 HK0BPHmvl0QoAyA+tO2cYhWdYUfUZwWjg0cw9YDjtFiwEmcWHaYqN5IxI4azoOhsGXRTw7BoW2P
 rMtN45v4K8k3kivMMWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160072
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-225514-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4DFE7296F94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 6:39 PM, Dmitry Baryshkov wrote:
> On Tue, Mar 10, 2026 at 11:36:26AM +0100, Konrad Dybcio wrote:
>> On 3/9/26 3:44 PM, Abel Vesa wrote:
>>> According to internal documentation, the corners specific for each rate
>>> from the DP link clock are:
>>>  - LOWSVS_D1 -> 19.2 MHz
>>>  - LOWSVS    -> 270 MHz
>>>  - SVS       -> 540 MHz (594 MHz in case of DP3)
>>
>> This discrepancy sounds a little odd.. can we get some confirmation
>> that it's intended and not an internal copypasta? (+Jagadeesh, Taniya)
>> FWIW DP3 is not USB4- or MST-capable so it may as well be
> 
> DP3 link_clock is sourced from the eDP PHY. I assume there might some 
> 
>>
>>>  - SVS_L1    -> 594 MHz
>>>  - NOM       -> 810 MHz
>>>  - NOM_L1    -> 810 MHz
>>>  - TURBO     -> 810 MHz
>>>
>>> So fix all tables for each of the four controllers according to the
>>> documentation.
>>
>> It sounds like a good move to instead keep only a single table for
>> DP012 and a separate one for DP3 if it's really different
>>
>>> The 19.2 @ LOWSVS_D1 isn't needed as the controller will select 162 MHz
>>> for RBR, which falls under the 270 MHz and it will vote for that LOWSVS
>>> in that case.
>>
>> Even though the Linux OPP framework agrees with that sentiment today (it
>> will set the correct rate via clk APIs and the correct rpmh vote for a rate
>> that's >= 162), I have mixed feelings about relying on that
> 
> Why? 19.2 isn't an actual working frequency, as far as I can understand
> anything. Or is it a working OPP for running "shared" clocks?

No, I meant removing the 162 case and relying on OPP to pick up the
required-opps value from the next entry

Konrad

