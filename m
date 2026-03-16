Return-Path: <stable+bounces-225538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCpJLh4HuGkWYQEAu9opvQ
	(envelope-from <stable+bounces-225538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:35:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3477D29A857
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DA96305FD94
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703423988E1;
	Mon, 16 Mar 2026 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e77zl26j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UIJNeIqO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532D3976AC
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667743; cv=none; b=mY7kb3ZxOTzsKrhwQ5CjTBsir/ezwrxszGKWoT+PfBjN172zy6VLxGzqysFt4EnLtgOjpC7cI83WvOZM3/mQ3swOT3pmF7ccBeAeOlC7L+E2X7S3tw4XbQwd+d0YOzJ55Q4+0OpeE87FcQdcjn4jIRdiO+HHWRbH2s5rd86fI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667743; c=relaxed/simple;
	bh=VjPa5dKBAL0HC5Ak2oFuEazOPoP1X2PPGkhAT5vG8+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYlTN6M1OuMG0Vli35ioxKA7CwiR9kNZBo59ELLnnkPAakdi+6yKRS4i7qTr/mtarhUGFrqIw3jxNkn6GO6FImNYUtHesqIC3SRkegYgLcRM9UtcEN/ZKnthZkRSG6fhC7S61t6NOFGmHYkyibdJ+THXTSji5wQVMhIjum2NrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e77zl26j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UIJNeIqO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBfBjv1282129
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fIboW9VuwE0EORPl7TKuMP0oFZdyasnxlARwx2DUE0w=; b=e77zl26jnmtKd24Z
	kvoS9enBzZRClRgwEQIxDDzM/H6edfYJ0M3wuT49dP8cbhpz+NeHyYQCu6lsA/hK
	KZaBsWMh2OQE46d4IAYglcIOfWT3c6hHc/Z8qspEMrvO+Al56XH9sscBC1s5oxil
	RyfZTibsCKwRMJ3JbXGpLEfMjPFee6Z6HXqeZgBZyhBtWlWHpfR9lt5yqM5fKro8
	eMEyOLCuqw8lWN4/wBEWKtB3EOXulKCCdDUkdcFR7zFMEDWZLs1B8baM3raC/LVs
	E3Ua2q/+6F//1Nfgj5NFqMiZYnmc9W6yhH//MU2xhP6qf0E3MMYGzluapUtYaQsB
	fEZpxQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvyyc5t5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:29:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89a01982dc5so43698226d6.3
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773667739; x=1774272539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIboW9VuwE0EORPl7TKuMP0oFZdyasnxlARwx2DUE0w=;
        b=UIJNeIqO7tik4tSy4IWZsTvDlQIVxFmO/tM8WPBYiUgE1UYsknX3GPhxcuim7Q/0wq
         1zLokzwKG7JTmeBPIj8WHkktoJqw1cewtPUka/PDnL0teZHb2aBVVx8XQrkEmpooJlRM
         f+A9kJd2UkvTjnwR194OJAQGosmPTNf3r2BCZ4d2Ixx4QJAf/W0Vr+0v1jepPox/CobG
         R4re/mqC/TUjZjcPzvgIZ2vToYoc7MVpUlHzSwATimK7dcQJRZh5Ha8UQwGtb2xzTKCf
         qpKlL/qbPZ6z2Vg06DvTj7PS72FjWJSKnAvjHkZB0FPQB85q3Lwqa6MWxTGInOvrPaA8
         gPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667739; x=1774272539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIboW9VuwE0EORPl7TKuMP0oFZdyasnxlARwx2DUE0w=;
        b=UzZjtTF5VimsO1W+BvSV6DRUmW2oFWzAsLU4jQiz1hZetHQaihgJxH6ZDMiZAySP4H
         25Lqxmveg8w6/gtGhZ8MecdG1akoGpeubjeh/oISIfGO8BVLe6j1ZWf37yC0WYQE4h1g
         R1yHuM+KKGaTaFJB8mkh8NOMaULYpSEiBssnW/WZ/oQldpjgGuEY5Huel0KhtcCdbkWm
         kFi7yP9RAicaGqDn8VFUpcs5B6lB+AH0Cn6RXSiLX9aQfFZKIG0g6/5+/3pABeePjlkK
         aX8iRMF1gmf5OC7qdfy7KHw88x/ejjlyULVE2NnBV77SEJbKyPlbuK+3yTHw/kanVY33
         rfsA==
X-Forwarded-Encrypted: i=1; AJvYcCW1kkeZ25FNNIzk4JTRZE1+fItx9vrA+6ieZjEGAtIkxB4+Mq1e+dJLA38L19d/E8r46fmM8I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVqgZIBvvp8c2jWiu6opFVkFfAxwniWNkSNRN7a84rEgGvskq
	xRGCGvbghCdZy1VDMINEEQZZtrQpuWR7tD5Tfdztk1VODB/Q/DjUsloP6lVKmtueGbEwgJxWokY
	7sbn9VYhD2E/ZLpWGx9+WhAD5RlISfzWBdICHkvwC3yNOR+ceeO6VU28T7hs=
X-Gm-Gg: ATEYQzxLszB39uHzSpUAOF774qB9dqkpTCwrJVPjdQcfbdOZr+MXvGIHX7uvG8NxHcR
	qKuxR/atzcVjxeQ3LQMz7fPGBiJhj3HrfU6T/Mo07XEZ/4mYeHVryH0cz/hbjgQiZ+RhsE8KzBx
	Y962Dd9KybsbXq5461vgbolK9cCjf5MP65+vi7FlIsNkRsIoLUyCRjTpFbrYlMSFw2rFHbqxmbk
	PUYaXaoOnHuYmkdNaf2dvbaUImlcsUASy6AN2LIBp5yNlcXOJvkE7PNZYx+m0ykri/PqrpelG7W
	YRBOxdZRLW6CUFOgEnPfSvQcFRHjbVEAlCVypXpStRQT1SfFem44aAPKL5MrDSoamFpvX08anQS
	bo3WxJSZyIaeKoGtXi/LdRVYGUHebkFq7PLUUqSh1847jTHOFxlAfoqeth+70yZfjZhuiGBSaHI
	gl+8U=
X-Received: by 2002:a05:620a:290e:b0:8cd:8736:9fc3 with SMTP id af79cd13be357-8cdb5b8a614mr1344672685a.7.1773667739383;
        Mon, 16 Mar 2026 06:28:59 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8cd:8736:9fc3 with SMTP id af79cd13be357-8cdb5b8a614mr1344669185a.7.1773667738744;
        Mon, 16 Mar 2026 06:28:58 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156033a29sm3400429e87.37.2026.03.16.06.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 06:28:57 -0700 (PDT)
Message-ID: <2a6698ea-c7b8-4038-b4ed-7a7c9acf3d05@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 14:28:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: geni-qcom: Fix CPHA and CPOL mode change
 detection
To: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        bjorande@quicinc.com, mukesh.savaliya@oss.qualcomm.com,
        praveen.talari@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=euXSD4pX c=1 sm=1 tr=0 ts=69b8059c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tN-bM4_ZalV-NnDHEpgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: OPKLuKfbUIFio8G9n3C7njwNGk7av5qT
X-Proofpoint-ORIG-GUID: OPKLuKfbUIFio8G9n3C7njwNGk7av5qT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMiBTYWx0ZWRfXwImMBJE1zL+J
 QedeRlIDIpYqru4CD9RTtAA+P2ImbgADSXujqKcDQqHDre6Fj5N0CxG3PnlO6tp6qHxemU6HM1C
 lmEt6f0/XzvKHPpP4Df2SCVWuZ2gtdR58J2R7WfxqXtiFu1UqfNDqEulERuuGU7UOyVjq0evh8p
 QxuJfHJXy5EdSTM4sbIeA0o3Z3LEtslJpeg8+QI6Si+iVEwL+gwJ9jotBx40ZsCoRWr8B7KWV1k
 tL5vEbLoyrh4koVsNcFyDUY+p56nsDkqoPL7KPKiiLq3LItAY5Sxd9OYXxuRj3pb5syacA8biIb
 7oles7ZvAMtLOY7aUQetf8pQPyXz1qpfFW9qwf9xDaOYy9X9EVFxwUSkLDVKplGlOhSSFq543al
 Pj/LCmcp3iHmZ+0qD8lE/QfMqtTBiDIeNjaRF8EiObjEW9eT8qFiWuHnN/4HcpFJYKCRdE5G2Or
 1OAfgOXdsmVCNKsAxyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160102
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-225538-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3477D29A857
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 2:23 PM, Maramaina Naresh wrote:
> setup_fifo_params computes mode_changed from spi->mode flags but tests
> it against SE_SPI_CPHA and SE_SPI_CPOL, which are register offsets,
> not SPI mode bits. This causes CPHA and CPOL updates to be skipped
> on mode switches, leaving the controller with stale clock phase
> and polarity settings.
> 
> Fix this by using SPI_CPHA and SPI_CPOL to detect mode changes before
> updating the corresponding registers.
> 
> Fixes: 781c3e71c94c ("spi: spi-geni-qcom: rework setup_fifo_params")
> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> ---
> This patch fixes SPI mode change detection in the spi-geni-qcom driver.
> 
> setup_fifo_params compared spi->mode against SE_SPI_CPHA/SE_SPI_CPOL,
> which are register offsets instead of SPI_CPHA/SPI_CPOL mode bits.
> This could skip CPHA/CPOL updates on mode switches and leave stale
> clock configuration.
> 
> This is a single-patch series.

Note this ""cover letter"" is unnecessary for such single-patch

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

