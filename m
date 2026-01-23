Return-Path: <stable+bounces-211377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHrjDk9rc2mXvgAAu9opvQ
	(envelope-from <stable+bounces-211377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 13:36:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0B175E6E
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 13:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E65B3034E26
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 12:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FFD2C21F7;
	Fri, 23 Jan 2026 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7A2FzM1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OBpIns05"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5EF26D4E5
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171756; cv=none; b=mH1bSiK/ykFoV8XZHx6TohTaN8ctN1AIhy1WHss48Qd1+8zDM7ppsE7vHcOoNvyv6ujHFz6eX15Gg4/U4uFnkExYUJ4F4chOmkrZjPoZ8WwD72ss5Ajw569NYfBYT5I5yRHaVVB1gsGuX6kx3+ee6jwyqR8rxXh3Od3haUolM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171756; c=relaxed/simple;
	bh=rdThuJb9LxLDAy865A1PnnTw6bKg+tJt2zlKK1yqx3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UH5riMuPWCBqf3secWqWCshPy+9IHqSz9HBqQQZw8cFe3CO/t2FcYnrBKWZ0kyUO43D9y4foYJMDBIjbFixYL5EpYoerS0J8WPs2TyEV3vptDYv18nwQN2Eih2QzvOqSSpwQsdI69KvLJbtNWU13kfzsI6iPYtwsxwZwsTM6EQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7A2FzM1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OBpIns05; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N9dcub722389
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 12:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oSwpNOBLoGtq8gfXP6URVakFfQLR/Vgz8IFVlrSrCaE=; b=L7A2FzM18F47aDOD
	spVUZc257HYL9iMkog+HPTo9RGlofP9GvvlpM8E5fsZ9iebMz8vHgfUOXnw/CYE7
	T1FHJ60oCFlOra6A0adPvGtym+cP/wXdUKjty93ZtW6sFnoCujSl7DR/gYg7HTey
	MIcIKb/UgmMTwaLtmpVzLHQRcSWBf7Q04GGPMJcr0JAHgCj3lXhz2nbF2O/ZX4eW
	OJoJs2latQT/ogRn9umgp2OpymIeegAulqtW7aT6vsIRi/7gGFEI2qaoJsf+izxC
	akhnmQFlgBJVIXLCdZMPWMCrH+QOaFJ3xQLK43luotzszSax7oV3fm5LI+xKDIJM
	KYJu1A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv069j3vk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 12:35:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c52de12a65so46856485a.2
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 04:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769171753; x=1769776553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSwpNOBLoGtq8gfXP6URVakFfQLR/Vgz8IFVlrSrCaE=;
        b=OBpIns05IvfzaI4XylHy8HDTfvqxfkG/2C1VF9HNkY4jNB/qnHZuiEOOkleMeLELI7
         qYzNABcJImz0rN325uu59BTOAeCnZq/9D/8L64/pKihniAYC0B96IKNf48tuHelDKVcn
         4/P+D7TaQZGKDLcvBIKjldk0edCGmP/y16Gb24HXjGzJ1qgZutVi2PNfkc341Pshc5w3
         JVtmZQCDMWtXgyayI0QtlLy0CsWfCVXyBhcY8mbtuHKhiM03wAtSg7y6P8AotzumNcUv
         rClJPVFN8Q210uPmIL/71RcHQA/l0rcKjA29bnMMdBqFBpou7E7T7+cZFaH2+hstL0HV
         WA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769171753; x=1769776553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSwpNOBLoGtq8gfXP6URVakFfQLR/Vgz8IFVlrSrCaE=;
        b=Sd3XgerGFhnV/u+SoiIJuviQdQ+/TCtREdfdN1ORnLug3PVv71gwrwfgOl71BiQyq5
         Bc0nrXydBll8IkT8Ck21cEkwN6qUJ3u8j26nldD5gZNfC1bDgQrKX8dnwayw0A8+IK5D
         yldjS1BRDPqNdq3FiQc7u4htts8OqChcfJdONP7JvppUuRqLX8225FhH0ny2+vfQmC8y
         j07luoI0+gb/oKhFvzQpevzeMeBeRcJ6wp9x8A5OxQgYXndSo0EsGs+Cw70QNLuUr7PR
         iOFBWQh9MZyk18E9VARMw71YQUgYuRvqNAf/d2fkphT3rGAirzaBYZVPTb004laGeDtx
         VYAg==
X-Forwarded-Encrypted: i=1; AJvYcCU97AYE2F3Z8s6fXfiYzJ7Iw9EMZlXU4VCjLJr2KofUz6H8AbUrt0Slfv9Bh3EV4dubG69v1Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHgoWLF5nT1HF462ZwnYRHcUYYqT1ao8W/om4nA6ntMQKP6tp
	Z1hsJx0RSXaGZeYO6zcX6sl5DYa2QgT/iyuWpmtPA8GYJaquTs2ptVueDqxxuEDb+dyNF8wmUAR
	F3ilY/cDS6obZUKr4i8TjdDj+x3lDkcdllhMwt+ueLfbrP71S9H4Lg6lJoObE0gTIo1A=
X-Gm-Gg: AZuq6aLqb5+pBhZn7+LBG7FDWxdD4b6NiYZ3rkWVREwwO1qhOx+rUlc7VxtpFhoobZQ
	uagPnESz7N8B7lgaqBMEBhY6JRLCkwy68qzU8eapa5UldZfKlmZ2/32GAmUt4IU3+8JGMAjFYe2
	u1G83++M3K705PVnOGe2C279IX4szFf7pVij5lflO1A0KqC+nPB+m0kjl2Yxzvv/LCdaPA9niAi
	EXL0xzzDPJaMmfLXdLfo7uHJN5wVZFhLR16yEPktr4Nyk/ONmKVtHxRW5HiljCZgPaK530Y2cED
	DiWPmEH+OJo3IHuXBZA5ZA1gQSijan85QJ1060261dKtM8QEIkIf2lEzz6v/X9PN5n8AiGM4RVJ
	+2SRG315Vf0wj7CnAWjt4XbpBdJVGvqVWmyeSGEzp+sNLD2fNrz8+0FyIiyuUkgk6/YU=
X-Received: by 2002:a05:620a:1991:b0:8b2:e346:de7b with SMTP id af79cd13be357-8c6e2da3ca5mr280043385a.1.1769171752698;
        Fri, 23 Jan 2026 04:35:52 -0800 (PST)
X-Received: by 2002:a05:620a:1991:b0:8b2:e346:de7b with SMTP id af79cd13be357-8c6e2da3ca5mr280040385a.1.1769171752180;
        Fri, 23 Jan 2026 04:35:52 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b7661f7sm98326066b.54.2026.01.23.04.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 04:35:51 -0800 (PST)
Message-ID: <837022c2-0e0f-4b20-af9c-de04d8d08074@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 13:35:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: kodiak: Fix PCIe1 PHY ref clock voting
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260123-fix_pcie1_phy_clk-v1-1-38f82ea01792@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260123-fix_pcie1_phy_clk-v1-1-38f82ea01792@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eLUeTXp1 c=1 sm=1 tr=0 ts=69736b29 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dkODpQc6jYzLo0hoCJQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: lA3h0SBbP-26J3m6qca63sq9MPmYRJwD
X-Proofpoint-ORIG-GUID: lA3h0SBbP-26J3m6qca63sq9MPmYRJwD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEwMyBTYWx0ZWRfX+ZPoHGZ4i0WR
 IONfviWWU6reZz36uvMb4rujPD3R3rBrEVFGyskJmU6Ve2jHvC19izfzJrmVYT7CN/teOMho8bq
 zWmCexZzzdMFNhDfGPm208nMvrTvS+jr564Eq12dInSHMW0to9vQZAX+1ChvnwxMBcwYn68mU+d
 YfnrklALgHHU+enCtzF8ONiwAAJeUqcYqxt1mH5rU0PMQihVwGcM1V+031X3J4Y/dSctmWIW7l9
 +AinAfoCZxexeE2Cy7m50VUBDCL4klcGj7/A0Ntho30D5Af0C5KKeWjMWoC+4iglqlH8CPaljcS
 aF5ExdWp9rNBAt1psN3u6FSGLdkbGqLKaFsQipPI0V6UG+hoHTn9h5qzldnmg+m2OUn+XQkZ9Ao
 11ydpUoiqDeKfpx6883oNaX3i+6QfZSm0Ny5aUNCAC36g7eFm9qBsJQnTme5hQaeebz0ynfbbmb
 f7wjcgQ2oa0BkNU4r0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211377-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: CE0B175E6E
X-Rspamd-Action: no action

On 1/23/26 1:12 PM, Krishna Chaitanya Chundru wrote:
> GCC_PCIE_CLKREF_EN controls a repeater that provides the reference clock
> only to the PCIe0 PHY. PCIe1 PHY receives its refclk directly from the CXO
> source.
> 
> If the PCIe1 driver in HLOS votes for or against GCC_PCIE_CLKREF_EN, it
> will inadvertently modify the refclk to PCIe0 as well. Since PCIe0 is
> managed by WPSS while PCIe1 is managed in HLOS, there is no mechanism to
> coordinate these votes. As a result, HLOS may disable this repeater
> during suspend and cut off the PCIe0 PHY refclk while PCIe0 is still
> active.
> 
> Replace the unused GCC_PCIE_CLKREF_EN clock entry with RPMH_CXO_CLK to
> reflect the actual hardware wiring and prevent unintended changes to
> PCIe0 clocking.
> 
> Fixes: 92e0ee9f83b3 ("arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


