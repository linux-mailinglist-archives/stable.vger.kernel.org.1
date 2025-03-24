Return-Path: <stable+bounces-125970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15306A6E361
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D46F189540B
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6791F19C554;
	Mon, 24 Mar 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7p3iaXO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F3198E75
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844077; cv=none; b=Fczi+d9nEcaHVoJ0Ql8LKBPYSVb9nWYbCy+5cX31M1EpkQQ/vUah9qt9Qxh8jWG9JAo+y/VMwCPWHCtjYnd1XStVdDzoWyAcz6eelGJ1qez7n9LXivKE0109kmQL1mbQay0tw8CAC3pRls+JS77zICOxxX7+kmBDO726nOGvSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844077; c=relaxed/simple;
	bh=0T4JFLhJnl4iWm2bszU4lW8Y2/BqIgDH5IiF44yaoYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvdLGzSu/nWLFgn/ks6OHxSyCGG2mORMA5I+nKUoL94VD0x9f0cYkF8sWKoUPP5t/IxNovGVnvgdfiowRShGD+iAqA1MDrFGW/4eHrlv2zMkzFcc3lvs4V3Usqj7zDoHYWV7N6DWE8Qh4T0LVfoqFTIrA8swlydKBBTOCGGvWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R7p3iaXO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OISukd030625
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 19:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0T4JFLhJnl4iWm2bszU4lW8Y2/BqIgDH5IiF44yaoYk=; b=R7p3iaXOREmp9MPS
	FOl2KcaK5pekD50Z5RzIB8VdqKAwrjZ/RkxHya2rPcyCZJaMmZsYdrfQICNwNir1
	sWZ++Rrmv/8HwSkJg1YxYHhTyl4jA2bPyD02DU4ZNsaPblXLYGc175YXiodn4CaB
	LsyOot7ge1bw74GTLg/qd1nCYRdxav0LdCHv9LPHJjZraYjX9sB4dlmzblBGBEuL
	+tzkl89SkC06rSBlycRi1mKRiR/GynGbKF+ghMs2do2yRjFi7pJxKRd2qwIEyQQ+
	PxafOndg79idZjuzGpQpUb3S4mgTjhgI4/rsx22hGu1PqicY6kVXCc8epmFDupLw
	buGcFA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hpgbdbhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 19:21:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c53d5f85c9so138478885a.1
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 12:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742844073; x=1743448873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0T4JFLhJnl4iWm2bszU4lW8Y2/BqIgDH5IiF44yaoYk=;
        b=I4+KbkkNlPmNlch/0Rs/2rkdlv2dJU+U4Bwk3cvheddOMhCki7mbbNb6JC8wl4r9c0
         5qSI0JZAGNhAhaX1BvMfB1ih4qyG1+lJolOQwtKIoWYILK8Ti6ZnOPj7FOsZk69Ib8mr
         FcXlEPNpfpXIu9dUZFap5f5a/hwj2zgDb73YuPEEIDfOQ+S5c5ZTGf6DI4tdAOAXw+IX
         e39T9uVjT1VHwxO0JY7LOCH7S5fGn6NwIzyOCW2svjUkobCIus5Z7aSPgnq6eXTm6PF1
         JCRj/puutPrvgOR75rJ4m7h2FX00JPlOYS9uj8xsD6tWYb6B7xYYlaRjGJtAUeNBO8O3
         6wgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs5gBdOQgP4uSayR0rJwYQXYOj4HJZEgWqNeVhSdvfGtip9yrKbuOvdVgBgoaKgxUCF00o+Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVnHLGYbmHgFHexeBRaZukuMqkZSYS85kdFH4OBuYZF5gdV0t
	/AzjAkqDk3kysg9AFkDLWJq9/Fp+110wlwnd4LE0HYeeK9W+qRDdXoElqRmziF1Vqou2hrxdeo8
	SIaCATZa2h0tL3xhTCPepWV32gecC/ljwHVV9eQNtM1iZvWGR425idSY=
X-Gm-Gg: ASbGncvcbVaCFRQRWWumdeEZ6t2CyHeFV8woTXqdXWOolIp4PLIdv0WTMpYeBQflPDG
	7XDSmDXOsyGOOlcLcOOGKXCk03aX7H6l/OL5P+OIBpTJOzs0sGxsuiP/dSTqmQfduPhf+6auNeK
	zNbPgj+olkudVWXh5RjwQvM3FwtQlakLeRJcGKLAPXWM8riwRImGMQldBe15GBp26rVzw9XUOxt
	E0ve6Vmh06x8nDIvJVaFSqEF7Rq9zD2a2JiEM7YEDb09U7QWpmOWwMftiShOpBek0575QQgPtyQ
	9p5PqIZjwD19rMPmgjc6X8rcDP59dYzHSAE6INlxgjFyFf3yzRfBSlN715GDgMH6QMmH8w==
X-Received: by 2002:ad4:5ca1:0:b0:6e8:f88f:b96a with SMTP id 6a1803df08f44-6eb3f27b6c2mr81881906d6.1.1742844073281;
        Mon, 24 Mar 2025 12:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfn8mbJAqQ2iSvP5BVpjwukE/fw5NAfTybeF+konRlU7Y8X9xq0mefSPXdNyWq3w+LFMKy7Q==
X-Received: by 2002:ad4:5ca1:0:b0:6e8:f88f:b96a with SMTP id 6a1803df08f44-6eb3f27b6c2mr81881646d6.1.1742844072705;
        Mon, 24 Mar 2025 12:21:12 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e509dsm730749766b.68.2025.03.24.12.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 12:21:12 -0700 (PDT)
Message-ID: <7f161a25-f134-44cd-a619-8f7b806a869d@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 20:21:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: fix spurious DP hotplug
 events
To: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Clayton Craft <clayton@craftyguy.net>
References: <20250324132448.6134-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250324132448.6134-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BoydwZX5 c=1 sm=1 tr=0 ts=67e1b0aa cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=6uNWq3ElG-ILUvwBAFAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: jHYWBGQFHR8GXDjMDX8-nqmuwZ96MRJ9
X-Proofpoint-ORIG-GUID: jHYWBGQFHR8GXDjMDX8-nqmuwZ96MRJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=996 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240138

On 3/24/25 2:24 PM, Johan Hovold wrote:
> The PMIC GLINK driver is currently generating DisplayPort hotplug
> notifications whenever something is connected to (or disconnected from)
> a port regardless of the type of notification sent by the firmware.

Yikes!

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

That said, I'm hoping there isn't any sort of "port is full of water,
emergency" messages that we should treat as "unplug" though..

Konrad

