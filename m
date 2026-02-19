Return-Path: <stable+bounces-217494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BeIF21Sl2kzxAIAu9opvQ
	(envelope-from <stable+bounces-217494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:11:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9377161800
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C65153032CE5
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE3352F90;
	Thu, 19 Feb 2026 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uh/6F4eP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5vyEnZP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A3343216
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524676; cv=none; b=rFqrPQSjuowj65d5dz3LtWj42GIdkhkh+6wX92JSGVnJpycKKDEFIjDLVvygm4uWph4XqCoXXMsPyZERaIECp5MQWYJmhyDg6E8fFYQvUKJqhiRCdTc7XFQgFX1gYF09cVXDhW0vpiFjlcnidkzG9VpZS7itfbg1w5eYdEoFPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524676; c=relaxed/simple;
	bh=xvacaW1OysqWLNLZP3dNcuFwG95hURiYLwx+uhqifTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoCE7fb0HWenJ8R0Xk20XDrQGdyX2yQGWav7BIMKz54VU6LarlN0qppCRiGEsmuiq14riIUvU3r3Tu1AbKSwmrYcUBhjmeplGk3nRK7bFIq+JDRerhP7ib0zsY4FTUHGTEiRevBgh7yWJmKUySm5ZVu3eA5YcWNMK0idgRQa/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uh/6F4eP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S5vyEnZP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JCphe8160557
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Li8aKO5Qa+Wo0IPQrn4AlzJySEcAv189KWIISoGMojo=; b=Uh/6F4ePWccrNfmM
	zo6aKP7rs7j6P7BaGFBUlOirMyBBy5CPoXzLbvDZl1vmH3msxUcDwLI7o0vCRaXl
	90QjhPmZ530rrMT0j0dO9ZQ5yc2Fa2N2VyUr0F7NuNt15yNhmgnZYppuRit+x+kK
	PZKmjMZBTeAmqqtqgoAysBNrYiDlP8FHfGdO7YTEfJwpRVydPKXvbJJA+yagR5DA
	zXGwzNWss5ZWCbvEUHnAb4aZsjECV5KOYOWHlnElH59WhIycPUsSEmI3QuN86OiR
	kGqTAHECycB1a+qf69QwZUXqsR7Psm5DpXn6HqDYWO/Zl2sSnrutq9DZrK9+N+Om
	gDawaw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdrpgaf2k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:11:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a77040ede0so13733765ad.2
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 10:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771524673; x=1772129473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Li8aKO5Qa+Wo0IPQrn4AlzJySEcAv189KWIISoGMojo=;
        b=S5vyEnZPI1tYyehtxyKDcAG78rLPe2AJk0JcBG4pgfH770+3nJWV1jQM2gy7jk40bM
         w1LhRtLBSOSyKrbm3JduFx2k4FU7mP9CkTg66BSk/5WuEJ3YgJoKOGV1Bwo4+vHt0N6I
         uGDT+40Z6oxs4/u0l45jmNx/WL7sNJCMeqX/7VzHMlwbMRb8PwGRBeJFioVYEWJt/1OY
         7rm6XpyLFpLhpJUf2YNEdz5v3L1DSTslHeOwtxqLyPtroFeIM1d0VSz1OnXxFpVLH8Lr
         re5GJbn+ewxENqUiEbJztwtx+o9j2PVCQmrHO0i4QsztTvpMHk1ZKw0+uaGsF+k+AQec
         92aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771524673; x=1772129473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li8aKO5Qa+Wo0IPQrn4AlzJySEcAv189KWIISoGMojo=;
        b=q4YabUxHpZxxIO9kk2AVxDN2msz1+h1jCKVAnbxqjkfvDMKmE40FzOlSUCZeTE2CLA
         jgmQ7FpZlOo9Omn6M2i9nO3rHzli8GzsHDg1jnvv9qQsUJh3rN3J05qDdQkec9dQfRTs
         scScGN9FRWy2qkkfekEaZrkpbGxf91axW6W4TKAnv5AL075094TbriSzqZtJZY8UMZAx
         iQC+XuvV8gEUY0J7KMPfEVK36f+Dx0FpjFZgZCjrQoD+fWo9WZg2m48ziHa984WEGKva
         MWtDTb+qgHfMS4tkSrsy7tpivXkxYDC4raTwLJkAnWRX1o/ADSBe5dqNPCqdOewc3mMX
         Jk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+y6pf+g/Mqjxs08f6hur4xtd7kAsIlVcaeHJT8g9JjI3/7WXRDsYnc+MEZzTRbON+oF4u3O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyvPEb+Ut+hqb5J0/0+SarzgeH+Pet4STBgK2H8Ttd/d56P+M
	C1v0zYkwEBM+D/7VMMd8w1jOy6cyPzHbZ1C/gm2pLrdU8uPtDkNc0s72zQA27fFP9hZyWVTqBjB
	H1GpRLsPCa4Pdo4afcUALbE82Vhag++e4iDAiHxi0MDijKdJSY4C0eRzVkX9cJI2X24c=
X-Gm-Gg: AZuq6aI94fMO4i7rYNN7IdSJZn2yivipfNh3fyd1f3FzqU57SSMfBTS542Eur1AG6GU
	bPXxxJsF42LFh9qBmJDvQaApmvUFGk8aDnUOeYuU2Aht8XR8p+E+SFgf+/gcCq4u/zHdIp4FS7v
	Kjp4msp7fxdF/yeuclxX+7djkcJCFUGY+lGqyMe0B+cY2yd1ux2C2HLIijyGjQYiDtrFG9CTS+Q
	gTvmTS9Sd38RhGQBMSakNBVHLx0tObm6jNvnoZ6/VRYo3a0hqH73VA4zBMs0C5Q8PoaIz6AgwuK
	Easb76Ig2rIenfjZNSeBtz9O0yUSf6V0jXV1pRcZE9B0COo8gOvQNg0e8rOX/ZWZha0Y5lWnEsb
	3cdi+4EiqSlgzfsRWwBEx/G+NrBvyCby/Vod0osp7diSJUPuS911j
X-Received: by 2002:a17:903:3806:b0:2a3:628d:dbea with SMTP id d9443c01a7336-2ad50ed2f07mr51585385ad.24.1771524673265;
        Thu, 19 Feb 2026 10:11:13 -0800 (PST)
X-Received: by 2002:a17:903:3806:b0:2a3:628d:dbea with SMTP id d9443c01a7336-2ad50ed2f07mr51585215ad.24.1771524672780;
        Thu, 19 Feb 2026 10:11:12 -0800 (PST)
Received: from [192.168.0.103] ([49.206.59.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6f9d34sm171022145ad.11.2026.02.19.10.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 10:11:12 -0800 (PST)
Message-ID: <857f0582-8b46-4bfa-8c62-5ca6f3d0aec5@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 23:41:06 +0530
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
        Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
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
Content-Language: en-US
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
In-Reply-To: <wiztxwsea2aojcxmcs2q4vskooli7lrw3oio75bij54273mrbr@ody4vonry2qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: V_LZ7VtDR6RVp_BZ3xl8CsGKR7uZzOzE
X-Authority-Analysis: v=2.4 cv=JrL8bc4C c=1 sm=1 tr=0 ts=69975242 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=HeaAYArbXk87yN+lODdNzA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=3hJzyq8Zk_V8b2OfjNkA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE2NSBTYWx0ZWRfX47xoxDZOWYFV
 ms2eGxgs83iUmNT+EQfuMKGtlY+jJ5lhsbNvf5I+kzmBORttcJYXZmdq6RzFUQ6Vx/mswRPH2k2
 httUz3t9zR+pRg7i2VqNpS73A5yecFmxQJ2joKGgQtF9MG+Jfc+X48nMLbysNgXg31MJzxTORNc
 nQz47nMPzLHiLdNQklUQK4P4ldVlB92X0xx58xyYCubq/NiiEXqznV/tZR+Xe0loYqiNFZ3qXXt
 Ghd5iERxczMLm2X96QIx5oH1Qg0PxIjzQZcBneLo+ddxs9EgXkAoFi5Suo2SEjLQm/C4EmI/5M/
 Fdz78shVnv2dODBJL35UO6J3HU5Ml1P9YJRM/x0s/KfUHB05nL+51eeQgXnlAlYxHoG6ZFC6lai
 fckDOTpm+EWBy6Hu/gqUl0ofKpMyNaBAHZTDR/O0f3RISeh4fB8xZJZs7aFthMCok/p93VfOGYd
 jfyJ1LFB+AHfk5sbp2A==
X-Proofpoint-ORIG-GUID: V_LZ7VtDR6RVp_BZ3xl8CsGKR7uZzOzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190165
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
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217494-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jagadeesh.kona@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E9377161800
X-Rspamd-Action: no action



On 2/18/2026 9:28 PM, Dmitry Baryshkov wrote:
> On Wed, Feb 18, 2026 at 08:49:34AM -0600, Bjorn Andersson wrote:
>> On Tue, Feb 17, 2026 at 11:20:42PM +0200, Dmitry Baryshkov wrote:
>>> Since the commit 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds
>>> on until late_initcall_sync") setting of the display clocks is partially
>>> broken. For example, when on SDM845-HDK the bootloader leaves display
>>> enabled, later the kernel can't set up DSI clocks, ending up with the
>>> broken display, blinking blue.
>>
>> This describes how the problem manifest itself. Can you please document
>> why clocks are partially broken and how that relate to the GDSC state,
>> and why setting GENPD_FLAG_NO_STAY_ON solves this?
> 
> Probably the best answer (for the second part of the question): I don't
> know (yet).
> 

RCG update typically gets stuck if the new/old source is OFF while the RCG is ON; but
if the RCG is already OFF, the update proceeds safely even if new/old source is OFF.

A possible theory is that if the GDSC is in OFF state, the branch clocks will be OFF,
due to this RCG also will be in OFF state, preventing the update stuck issue even if
the new/old source is OFF. But, if the GDSC remains on until sync_state, the branches
and RCG likely stays ON, leading to update stuck issue if the new/old source is OFF.

Ideally, if both old and new RCG sources are ON during the update configuration, the
update should succeed regardless of the GDSC status.

Thanks,
Jagadeesh


