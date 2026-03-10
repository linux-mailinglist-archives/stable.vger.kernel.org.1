Return-Path: <stable+bounces-223859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GneN0H0r2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:36:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B96249766
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 069983021C33
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B80F37187B;
	Tue, 10 Mar 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYHXCAYQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U0Dp+68x"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3F36F412
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138993; cv=none; b=gBKiw2J0xD45vnpsAuHHyI1oYpeygC0HROk0HthNc31hCnqI7Yddsh0L8RpD3BGGTyEsD+D4oDkDoRodTuAzsHpM8eqC6RkLrELB2bB57gXbGK3oFwR4jxYS9hb1+pUu2rlLxNUm3pt6irgSYHF3I/Ikj/TpEge9QPyuIVJiCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138993; c=relaxed/simple;
	bh=5gPUc+ReZ6qTYu7jb5bZeSyiHhNiGzrTTNowU76wE+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWdZMPyn8Oh6k8ym9YvYpdUT4lWpaUr3Ktb11MpYALf7RnXIthbQ1SkGcRS/6K+OJsotsw7WDWmXx54nfXMV3wTxx/S8wn84Ty5PY/85a6M8s8QB+7CDWk2etML4bJEk+wxGJkfLfvYO3kSnOxUoUs+TsVTE19VnsqP3YZGV/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fYHXCAYQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U0Dp+68x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A7wRph3124648
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ec6eXrocN5r99z8UdbN39kTGog2RVtn0dkLGm0Fq7qs=; b=fYHXCAYQv0nvDvat
	jDswVYS3SfN8BravcOcX7YrZxwxjNYz2V2rA17//1eCgMDzv/VrNTzAQmpa7yLbb
	xix3zrgKB5V/hXyHdHbmonCLT5UmfqfzZf4lveb73zljVfUuxsWiclMrziZTD2oI
	S1/9m/RwtastuXLqc4VxJ8PfU0E9om2GKTbalgXIFglBF4BmDqfJd375YYBplXvl
	dbznzj/E1fX0ZZMj2UjNvsCjpugOK/rOZll9IjXO86IEh5liszvijq2twwBUFNFA
	rjNjKty9ivp0rwC1/gZxP3rusemYlgwTeKPDtc2QT7TluWoy3U4UDVMD8SY1joB2
	MYlc/A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctfcj0kxs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:36:31 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ff04e26bd9so162148137.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773138991; x=1773743791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ec6eXrocN5r99z8UdbN39kTGog2RVtn0dkLGm0Fq7qs=;
        b=U0Dp+68x7Dbyp5GqX9o198opfFmasiTC/ss9gJt3etyqamE63FffI4FJgSsrtHnHKd
         0IjAiLLeXGObujFZHaM2j5VFpYEkksFMJBXUKF+ti96jPm0EZODuwYOSn6ytutj/UOa6
         E3zgc8LIutZv+k3vPxQiH35jliwLgfIsDpz35EkI3T3Ss1nfWVQOjpeKOjgpiGdIr2g/
         waP30kibs8AtGB2U7mkQDPfvdhLUwK3k/cxnkFmPnK3j1BYhGpvSPxNeYacuiinsgebf
         k+SnCiJJwKGFFXTExkoo+puhGT2Oyf8/HqxD2j00B89kJoi6b9/3u4lb36C/DJAm2Utt
         JKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138991; x=1773743791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ec6eXrocN5r99z8UdbN39kTGog2RVtn0dkLGm0Fq7qs=;
        b=MWV8ly2Sn/NXd3HRDpodP/2caCKsloyIVdx7aMHoNlLWbo30ABeqELDfJl1ep+M7rP
         ELf6/98v72rti19opJV7pxocJ3jmJ2KEv+/tlF4dbU2n54ZQ3Um1ARm+wesh4P1QX20U
         cJ8SGi8rHj5kZ8AnA3yPrEWEL/X1nQyCz0lFHJ714ordZ/2f9bDVBT6VqQXFTWV5VwAJ
         kEWnmhOmeVu2gou+CfQqlIb/OGgsC1mWQjbQQYC0eRlq4JD9+d0zOPVEEKNihHnsl6Ku
         AQ0OQeNBHv4DfXmP5rRUJrcg1zAbWw5/+HICIMKaQFMrYugO42vrHyLcFjZxxKtVJ+U9
         jKUw==
X-Forwarded-Encrypted: i=1; AJvYcCVujc48eV8X7Aozy4B2uCyEMO5n+uV5sCxLCbHnikRYFxTQ0NHo5YYH1FHI9LB8UZcq1lf1VU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJIf8ijMl85R4w59okCBPYl9WypCIqAP5+4Ns4DGUC48WIESh0
	MXSRyYKhHqQbxeNOsnS8Vz5S9mr4lVkAdCXu+QkaIAKzQ80J0gTWy3NY6iakRrfI745jh6rqwro
	/fCYhLdeSfOBjGYXuaR3V+30I6c/QqAS1kL/nQzwjkX8yViR8AZlIM+msTDM=
X-Gm-Gg: ATEYQzyrZKNyFIjO4LOpE6hUHh4o+GIOkF0dkJoFA15aoUdG82upnCCQFRWz2jNbZg2
	JMHEd9g5EzwPVjkiJdmo1mvVwiu6AfxCtCKJe2x+ceI3zjABERdw2CUunEdvkQXYo9/ZKv/f3bJ
	5A/QfqncAeLz/yHhmiIekBEOUrPTabon7yjRMDQoIXEr2XVuZbBAaq2ZEu5VuzGn0tboYxIKyfg
	8FV7Xq4SJ/MPo9J5IG20Fx20cjlZSrhQjlUT1Kz1y0bcWWtjijKsvJEnL3yiL3TNoingMJOh2go
	3d1MOYr9Yd5joDo4JmhJvrmIEClUstDRUew5DXbcbykYrVGJ9BoQH3V2bRB41miR1E4jwbieRn1
	wZau2VgwiZ6KIRXi3Y1Cqu5UKTRg43CmGf13Y1HuTtakYKywj4c74KlUR5tJIuAujzlRC5kkjHb
	2fQrg=
X-Received: by 2002:a05:6122:1d48:b0:567:4293:8d38 with SMTP id 71dfb90a1353d-56b07aafd0bmr2563862e0c.0.1773138990882;
        Tue, 10 Mar 2026 03:36:30 -0700 (PDT)
X-Received: by 2002:a05:6122:1d48:b0:567:4293:8d38 with SMTP id 71dfb90a1353d-56b07aafd0bmr2563853e0c.0.1773138990369;
        Tue, 10 Mar 2026 03:36:30 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a5d0726fbsm4218881fa.41.2026.03.10.03.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:36:29 -0700 (PDT)
Message-ID: <2f4e4cc7-2600-482e-88d9-d4b20d328a72@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:36:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
To: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7fWAuYi c=1 sm=1 tr=0 ts=69aff42f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=eVDm5Lje-WuPLjdxqx0A:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: 0xPs71rf5kJ9kJKc3TS5HkTC8W6TcmIf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5MCBTYWx0ZWRfX3QsZhysQnsPv
 6XIDixkCMxt0AgK0qurA/56dcopAktN8L+QpMIgybYn1/cedHcAipMt2tvCZaiSWGmswARW3OZM
 lUTycii11bVCTnk4EbF51uutLL8G7QBQeyvZuK2WA9M/xq3+qPL+9JRaZS55S3BbgCch8Vwwd6r
 jOVp6iZ3hskWxFAxxPZ+FhQp4zzcwjlSEFhB5z4AnPlFFLhN4OXBXzmlwlNlZ3ro5iHGRf6vbir
 +xkOwNdgEUKW6o7+87x3vPOPDnozAJzWWi+oL9avlPyFLwOkKfBoj2r4u67xiYspMVfiZfuw6+i
 G7Jta1fx2R1mEoyglBE6sdCWni1TQIzY0KhtB9E/6MqUJrJuWI++QNPmDFoVWg48buTS3nEp6cO
 R1HWJa84NJSiEZ/KqP7GrOk9ZRhWvTZWvbtJmsdB1hNAQku7PSyNJA3wEG8vDKAd4mFxEMiTiVn
 1/a8Ne4F3LYcNOW6Rng==
X-Proofpoint-ORIG-GUID: 0xPs71rf5kJ9kJKc3TS5HkTC8W6TcmIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100090
X-Rspamd-Queue-Id: E2B96249766
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-223859-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/9/26 3:44 PM, Abel Vesa wrote:
> According to internal documentation, the corners specific for each rate
> from the DP link clock are:
>  - LOWSVS_D1 -> 19.2 MHz
>  - LOWSVS    -> 270 MHz
>  - SVS       -> 540 MHz (594 MHz in case of DP3)

This discrepancy sounds a little odd.. can we get some confirmation
that it's intended and not an internal copypasta? (+Jagadeesh, Taniya)
FWIW DP3 is not USB4- or MST-capable so it may as well be

>  - SVS_L1    -> 594 MHz
>  - NOM       -> 810 MHz
>  - NOM_L1    -> 810 MHz
>  - TURBO     -> 810 MHz
> 
> So fix all tables for each of the four controllers according to the
> documentation.

It sounds like a good move to instead keep only a single table for
DP012 and a separate one for DP3 if it's really different

> The 19.2 @ LOWSVS_D1 isn't needed as the controller will select 162 MHz
> for RBR, which falls under the 270 MHz and it will vote for that LOWSVS
> in that case.

Even though the Linux OPP framework agrees with that sentiment today (it
will set the correct rate via clk APIs and the correct rpmh vote for a rate
that's >= 162), I have mixed feelings about relying on that

Konrad

