Return-Path: <stable+bounces-217224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDkUOgh0lWnDRgIAu9opvQ
	(envelope-from <stable+bounces-217224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:10:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F362153DF8
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55C69301C595
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 08:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F42317704;
	Wed, 18 Feb 2026 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hNSI7C7b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g+E+mWHK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A06311967
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402241; cv=none; b=DaJ077FHZmIyHu8e4ASghC4sqI1/ANrzvy20f85C5hK1dAkXWZ7KzhIwJ+oKzIoBBQFg1SDbOomp7DAy4NYFAuukA/3ua02S+grwOBAsEjhFNmpMgEjAWqUbxj0thcJX2L/4t/+4igQt3iSBDZKdVY1MvwW0vxnFetRvb2f8AXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402241; c=relaxed/simple;
	bh=Err06cI9A8cmp7W/yEr4Eiky0ENIlrafddFO8T8QR60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpM/ky32gI8XX04budPeO3uoPDHTkTT3SK4JU84Y5HYpsva+oLnpZhthUDkCZ1FDQC/ZFOpxCII17D1C6j0FTWpaYh1t4ZRthCqgu+5u8608FiyjGXZ42I0jXpZDafzi4bNi18ILh+IGl6IjAq+xxzwkMxSFE2fMYOu/yoj7z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hNSI7C7b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g+E+mWHK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I5OYTj4025085
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	siPTfIpr0X+b4BPnmwKJXOp0UawvD9fi3Yr1tF/ZDAQ=; b=hNSI7C7bOQTDtqmc
	mF8oeHzIDri/qkGIwp988yIh+EUczdw7qHWHFynZabKC4HBPIf+753p30QkkQ9/L
	48ILzm+IZJinoUGOQUaSzXWXyKyijS6yOezc7cBSVJSaJKus5FMNmb/dOnkBQfqz
	bUtQM1otoMyjNeAsBUb26KqU9TeiwL5ElvxMVmgku3BR9a+eeGjY1ff/d+b14czZ
	oG8yeC6O0efm+QOFog9/eOfFsp69pzY+FseDQ/qJidJRJ1lef+saPWXovMLEQSQ0
	x0xIFi99rC8c+AONVTUE0CBj76aDSYJZd/HngoKaViDQqcKvyWD4vyNOq5Mci6+1
	FnfHVQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd78c0ar3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:10:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso4851637a91.2
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 00:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771402238; x=1772007038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siPTfIpr0X+b4BPnmwKJXOp0UawvD9fi3Yr1tF/ZDAQ=;
        b=g+E+mWHK1iiXE9t9N6f3LY5gNIk192UuaJAbSoh+5ZhmNvVLUjPykHvy/3vA6WpfES
         e0uki60KWWRJMwL1n25da8F5939YSN0WKC0tTOu/Csg+jISszxxwaJbL5R/N68LFprSo
         KrOzZEkXYV7RXYuBfiNVyZYLcpJWqdc8GlvlrJrRqgqi9wKImk4Aok2Ki02uCkfUUDKi
         xt7iD4I0Is1HLZlmS/eMBu2zuTs9TTBRV1MPtrkS/3ZQO3FUsLYgGgM4TpdSsUuOtkMa
         3L9+OSqfc303wqfoPUqEE6vzbjD3cClcRpP4MrVnnsb1/kfzHQTUuopfqSjdsZ42PYbX
         GJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771402238; x=1772007038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siPTfIpr0X+b4BPnmwKJXOp0UawvD9fi3Yr1tF/ZDAQ=;
        b=VakHQEBSvllc87R1CebdSgpMXMzmQZmrSDgUmk1A4eMGXdERHsdsFalZRMXk9bRIol
         hRT6GNEXjHLf1KpTu5/YXeugBc6DGC1YqABRIODba8w4emhtzEmRZ1QTcokl5vRrDWik
         xvqZXlmpsP7ixr3uOrAmOylOAx1e0LV+Ye92v/8HfpyW1StbyEKTolq2jso0ex4Ecl8F
         0ElOhhF+UAri2Lv7pkFMobjBl9xaEUpbExh4gYQvBFwUoobGSDEPdXrymwJVze0ajmWj
         6TnyAzT36h105pxt2JgmwngrrUgYrO3UdlpGJ9B4SK4Cnc4Fq4O0c93l794SnFsQ0VT+
         mWcg==
X-Forwarded-Encrypted: i=1; AJvYcCWYveNJu51xfXr6rFvZIDAHC8ucitBm6Qzp8axfcFedztRnuY7mUtqmT4K4NxrIwNPQTibO7EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSxvqcHXcaT2IMTT54gWcsb/gzMFHnmtM3sM1yvkWU64LdlAd
	9VPcv6XQ169Glm6izMVE4yS56a4Dv6pvMWDd3tMzuH0hbemuw9edkBtP92xo2p2skBwezGVKsZt
	PiRRAUIla1QLVIR3hA0Sv1eU9+KoJ5lQdFjRX8cw/2pBwM8Wi1BbAmH3ovOdexPCld3E=
X-Gm-Gg: AZuq6aL4hxNz7v4kJh9luEuvzAq9YvjxvSSdcQLgirGM3+cu09m7CAWOhghd0UiKy3+
	b2S+wcqnQn+KVt0PCRrj8qOdhD7S2MseTSpAInTIzD73muWIXwxNz913ZASiTOEYvvDoSdUAIbB
	2UvHMrAaNnDTvib+HVTr0tTrQkJJNz9Cd4cs8TubG/AEeIzbEm8DnWhPRX6MXTMJAQcpYzvRHsL
	3/CWDPu6mM+zLPLnykv0TvK0xxttcQRJ6CzAeJlN3d5PxyTUbCdv0OWpp1NomwJcdfUqSDUwUKw
	GBOEMfwaveKLpKZLj+TdnwzvbAjz4fotMsAuf9obEMRluOfgJWrvaKqkichwtjNfbpcBRPDM+X3
	RVlVTy4Ocb6DeGKM4MX58jGfZjVWibsyNdFdopyFaXHEI1EJjaw==
X-Received: by 2002:a17:90b:4cc4:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-35844f9bd19mr11605213a91.21.1771402238402;
        Wed, 18 Feb 2026 00:10:38 -0800 (PST)
X-Received: by 2002:a17:90b:4cc4:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-35844f9bd19mr11605208a91.21.1771402237910;
        Wed, 18 Feb 2026 00:10:37 -0800 (PST)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e6cc17sm25305883a91.5.2026.02.18.00.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 00:10:37 -0800 (PST)
Message-ID: <1dcb4fbc-3b1d-412f-8801-3a25d192401f@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 13:40:31 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk: qcom: dispcc-sdm845: set GENPD_FLAG_NO_STAY_ON
 flag for MDSS domain
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
References: <20260217-sdm845-hdk-v1-0-866f1965fef7@oss.qualcomm.com>
 <20260217-sdm845-hdk-v1-1-866f1965fef7@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20260217-sdm845-hdk-v1-1-866f1965fef7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Wv1en_gfR8UyGvyW2frgdPE6s-lGQb2g
X-Proofpoint-ORIG-GUID: Wv1en_gfR8UyGvyW2frgdPE6s-lGQb2g
X-Authority-Analysis: v=2.4 cv=P5k3RyAu c=1 sm=1 tr=0 ts=699573ff cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=jdCBXw2rLYaCttYT0gUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3MCBTYWx0ZWRfX5oQGHta2UOdZ
 OyiyTdJGba+mBWlVWdbC1vEeIam507wqVHJPa0SJ+BplH7pA30McN8qE9kw2RlMHujyPkOWQVOg
 PNzQinICZag9qhUlZ8eUykhhQlFodiTkJlOnxe52a6CrULacYhVQ9JfTVrjUMQMiIdJJx2lrbvF
 Qv7Aat5PbrWUSw8I7sYDIv74XtItHoAg5olUJv2Ih4eiKlPbuGdGFgpVd58An7PBU5IVEwpTde5
 ZMtmOKNS0LGvk+dfKUnTWHYXb72pkmrMT4WVb7icRFlynsSDOvGIKnD11V6gXc0HKO6O+vTVRGk
 gZdkgXvQbbx3+T0nYwXLziXxjq1KS/lvD3o5LMUDaVbYGAEnPGgbaK6CaZUP6K3Hqqngzd8cCY8
 gs9q1+xivVTqJGYI5UVk05RrGdPoOxndwXKDy6Cj2zJz+pTcDNiAnEvRTymK6DDXk+JaXqh+Lb3
 Q6U2pCI0PkScFXpSa7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180070
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217224-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[taniya.das@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F362153DF8
X-Rspamd-Action: no action



On 2/18/2026 2:50 AM, Dmitry Baryshkov wrote:
> drivers/clk/qcom/dispcc-sdm845.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
> index 78e43f6d7502..468b30497746 100644
> --- a/drivers/clk/qcom/dispcc-sdm845.c
> +++ b/drivers/clk/qcom/dispcc-sdm845.c
> @@ -763,6 +763,7 @@ static struct gdsc mdss_gdsc = {
>  	.en_rest_wait_val = 0x5,
>  	.pd = {
>  		.name = "mdss_gdsc",
> +		.flags = GENPD_FLAG_NO_STAY_ON,
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
>  	.flags = HW_CTRL | POLL_CFG_GDSCR,


Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>

-- 
Thanks,
Taniya Das


