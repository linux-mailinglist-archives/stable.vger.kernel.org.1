Return-Path: <stable+bounces-230109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMwEHnxpwmlScwQAu9opvQ
	(envelope-from <stable+bounces-230109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:37:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F4306876
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8EFF30F48AC
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917493E4C7D;
	Tue, 24 Mar 2026 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MZPyxOOU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jwo+HL6S"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203D3E3C5E
	for <Stable@vger.kernel.org>; Tue, 24 Mar 2026 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348317; cv=none; b=HHLH0W2E+InrGI5wu5IMl11FkO7iC3AkW4Vi7B7vOryG5eMYffe0mcpk2924JksvYlyvhtOOIAhNALR8EnMeTsopaSUnxSiVnR5ExVi04U1B0YeMHoF9f5zWdVVPSH34k5yqmIAPtUZ1I5hXjiLrtbc9MDUnXr0Td1npFVREHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348317; c=relaxed/simple;
	bh=q5MNvdyGof+PjgbQGTJDKus9MlV95ZIEerPWexkQdGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUuZg+Efk+/Gep981B3BNgYNQ8thG41CE656Qya4fgFTt7ZLPTTTt0oyNlsvkyZGCB8MbQyXbNJU+vSFYPalhwqYgh6IVSJn9/9NPsRqf2EfK1+NxeCsXl0gOlH/EO7faY+tyv4bUCFOJ9cOd5UJEaj8ufm2p83CYsZLh3nUCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MZPyxOOU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jwo+HL6S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OAIWOq1909072
	for <Stable@vger.kernel.org>; Tue, 24 Mar 2026 10:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SiWFOK9mWzHDxiJjk5j95Lv1zx07DFZIAdgSugZSXis=; b=MZPyxOOUn8hOM0B1
	JByls7/LCUOotk6160wVYQ/t8SRnSyqylXAFR6UBxA5BKfgNeIAeSsOmdbzLRWXa
	hYAbofdkPOCUSOWhaF1e2i5XBYAjRbVJsSYNB8daw4cAvH7ZbqI3Xbi6GtQMuqQU
	lS48akay303qBvhDRUJ7f4diPispBLiecP7QZrhODOA9C0Hep/SARkIufSaquaAS
	AkuCPRG0TkpzziahH9qkv+7Su8D0omiO5qKnKtF7h0U4sJrlRw3shtBbgQIWI/Ka
	jHZppmmB42wFo3BZiSf/VLfSEGj6kfEd2UcDM+yy+rMHDuiVmOUii3rpOtWQnHCe
	GijCmQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3awyu07h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Tue, 24 Mar 2026 10:31:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cfc4ba4de0so332401485a.3
        for <Stable@vger.kernel.org>; Tue, 24 Mar 2026 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774348312; x=1774953112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SiWFOK9mWzHDxiJjk5j95Lv1zx07DFZIAdgSugZSXis=;
        b=Jwo+HL6SEihxLOwKC+O9x1SPEiWNjR9zRS9ew3vewNEWDNqNu9spuZek2P0XuVbJQX
         puCT7aLLhvJdbDhjZ7YLuv9tURa/biQJQ+VhEqELk4GNAU7XP0vaYw+s4HDFLL7YMmct
         Dq7FIZ1U7PQI3gEsq3NfviuRIH/BwYIufZr/WDYCrFlNqVEv/EI+VPWVPd/CzRvMWCiu
         8HRmsnOK810hSPdsQDn6cAE1bFe3BSuBVsiz72kvb0ixl8spJiMR/AJP2ysQDK/EBp0V
         iUDFOqCM4kiRDNIbuHCJNiCga8AcBB+cq+FwCdEIYZo1ayzTfNAlaF7OnQe4ms0rSGsJ
         ZCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774348312; x=1774953112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiWFOK9mWzHDxiJjk5j95Lv1zx07DFZIAdgSugZSXis=;
        b=q4TLWVdJ5hv7FH6QIgMZRT53JogVH+Tuz/F/LyfdmTK+LdTw1W1Pv+9EgNDjMCY/Gk
         e+CYDTSnodvIaHOmQD+yBibQ7UAsO2jYjueacs/5WD2askYmXNfrJ/5feWrRbvEp9/R1
         Snhoer9TOW8JXHpnR349Rg3bvbifdL9zYqxwBQy8uUzl7FxFz6iXUGdSBWGy0yNRgcDr
         bP6+fX5gGQT673bpTNPMDtk49CksE8HK3eAqZKBHG5ka9FgrgMSx2N2iasWp6hR1naMo
         LDQEimmvpY5IUWhIhTWd2DItJauiIPh808Tkx7zZbiYc5iHKGKPIKVG43fWxjlYrW5vD
         712Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6kER5OPRgE761XBS6oGMCGTpPbmwbI173/pV9fSn0EAmWTnZnX62LggInYYjpQEi39WEjKWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5siwsvA7FkAZuunryuADDiKTaZmyNmdHLDkAEH+acAiMvv6o
	q0/t7HfBFmYwDLJ15cIYabFlS9e41kDviod/ZtfArBj/sKIAG9OovqGUpHrDd5HLWke5vMm/UOY
	1K9R2oaJTej4jkZQzJNJEkFO1bGGMikp6NRUQU/NkFqHg2x6pY3Uz3hoqELY=
X-Gm-Gg: ATEYQzzR4nWBnLlmPlLHVc/bMYv6id25NGpw56wqM7ABqVZp6cs1TGukxBYaEUMHpO2
	nc1RSMpO3IbYPEOHUthjl3DFTBABcojRryylX7jV6NJNq3919ry6fGIod2RX9apcYa3lCk350tJ
	cu/dzPdorp+yiD/dZAdPjN1IQX7Qi2v0ZiiBH0Lj3rSI38MwC2WAikH3ykIV4uOaysVBhHIZYVw
	Uhto+w4Z99K9AzQrjo/PkZAaArBA2H5pIFpqiKgvxOS4CdS+a0/1lmJB4o0VLEt5Ba2XkccM3j3
	JZVEuClYbLLoTwXGM/hQJaNf99IubLMr3JiCVzPVZ58BA72uZ7CFoKb9rB1gbhTMfOZ7eRn4mFS
	BDM540pDCqYqRsKN0+MK/JYXKSwEMrDuCLHpfsFULufNLRDWN156GHnuYSBYs3tWsZYD1pkX82i
	1xZhA=
X-Received: by 2002:a05:620a:1d04:b0:8cf:db7b:6229 with SMTP id af79cd13be357-8cfdb7b688bmr982849485a.7.1774348312418;
        Tue, 24 Mar 2026 03:31:52 -0700 (PDT)
X-Received: by 2002:a05:620a:1d04:b0:8cf:db7b:6229 with SMTP id af79cd13be357-8cfdb7b688bmr982846585a.7.1774348311724;
        Tue, 24 Mar 2026 03:31:51 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6694b45de66sm3175912a12.31.2026.03.24.03.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 03:31:50 -0700 (PDT)
Message-ID: <f3661dba-2619-47d7-b118-6c483ba204e6@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:31:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: wcd934x: fix typo in dt parsing
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        broonie@kernel.org
Cc: srini@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@ixit.cz, Stable@vger.kernel.org,
        Joel Selvaraj <foss@joelselvaraj.com>
References: <20260323231748.2217967-1-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260323231748.2217967-1-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4NCBTYWx0ZWRfXxH04ZNAa01ju
 pWnA9x3L/mU0Cloas+UF2YCrz1e4/TEUaD+qIARK+3+SJgNa3nYDqHW/q3Gy6lwm8lC6wlvInVx
 rpheZpN9gBmzuLheqsYIwwg29VCk1LDvVO1jhBBHCMoKrBBXLcIGpVTa+tWoECADiRsk14ELy9z
 tjFnMd7ypVBNkCLpn5Hx6dioDupjXzleBicuVlqPs6YlCfmqWy7DdsaSeAtshrp4O0gA+vbLbmI
 uDUthgU7U9S6tCTZRPmNzoBhcqd4HAZNfhMHCrbIqZt3+cbsRPH5Mby8o8h1fLK1/Tm2RHrnUPN
 iwQhbGU/YoTfsFQZCsdhwoaefFSi63L850X+s4seXaX8Yjavot6gRW55roiA2YrpOMePT0i8O23
 Rrm3IeYdR4iiFzP10A56lwynFcxks5CIL2fAV1NwCB1ZL/nb8iByhsRZWhE3XUkquuiTE0ZL07q
 fmX7gJuFsKgeA+PUgHw==
X-Proofpoint-ORIG-GUID: vMnt7cuIJRIP30-O4QF8vxmU0fz97D8_
X-Authority-Analysis: v=2.4 cv=KuhAGGWN c=1 sm=1 tr=0 ts=69c26819 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=WFa1dZBpAAAA:8 a=EUspDBNiAAAA:8 a=viGe0TOZ8WVkida-i-oA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=MZguhEFr_PtxzKXayD1K:22
X-Proofpoint-GUID: vMnt7cuIJRIP30-O4QF8vxmU0fz97D8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240084
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,oss.qualcomm.com,vger.kernel.org,ixit.cz,joelselvaraj.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230109-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,joelselvaraj.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C89F4306876
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 12:17 AM, Srinivas Kandagatla wrote:
> Looks like we ended up with a typo during device tree data parsing
> as part of 4f16b6351bbff ("ASoC: codecs: wcd: add common helper for wcd
> codecs") patch.
>  This will result in not parsing the device tree data and results in
> zero mic bias values.
> 
> Fix this by calling wcd_dt_parse_micbias_info instead of
> wcd_dt_parse_mbhc_data.
> 
> Fixes: 4f16b6351bbff ("ASoC: codecs: wcd: add common helper for wcd codecs")
> Cc: <Stable@vger.kernel.org>
> Reported-by: Joel Selvaraj <foss@joelselvaraj.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

