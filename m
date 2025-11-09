Return-Path: <stable+bounces-192859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A318C447A8
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 22:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 664F44E2179
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 21:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC324A078;
	Sun,  9 Nov 2025 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dwx/yBFK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NrOe3H9c"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C11CAA79
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762723209; cv=none; b=OeICkEdL6OGBYJbqnc5CRKpE4Vz2r+WqbnY7jsI++Sq2JtjMven1qR1yynPxtojBFtETqN1+2R6/Fu2XXotzyKXmst4rIY1DqGzbbk000MvrebmrEHnQW/3a1hLqli5hHgHlnJYzzW/mKbsibJMeF9BtzHy9c9a/cUMwexFYVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762723209; c=relaxed/simple;
	bh=3kLuEtqOYFVKEThNqmDGAzD+Sfex2UQnxoC+sk8K5NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfnHWZPQ7oakA1Q0bQbza0+UT7piCR40W00dR4IWdc+HtXOpwDaznJ13WbQEa0qI5TgY4H3l7LWfh3j0ii6sOPpzWzJhYXtS+wHLfujQ7Cwlh1v5kePX+KnHy+FXsO/q8wWFb/NIy/QDadYzq4xrstY/q7/S+jnQYUiFJP84c7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dwx/yBFK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NrOe3H9c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9KCDIP1429696
	for <stable@vger.kernel.org>; Sun, 9 Nov 2025 21:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pbVsXejt6h39ywCxmkDZ92ta
	+Bmr5io8nWG70XNXbyM=; b=Dwx/yBFKPv9FIkUU8TOmrtC5wBVk1ViYs9PF/gWB
	ClkIPlZTPm6aUYAQL/zdhOFrGAiBNjPJlnPCy8kj6XBVXhdDtW6ZkBVj3pcZXGq4
	toN8NOkNE4c3SbQt3hb19yG5AnjwrUu1DCJHDlE8JF/5L6uvtUgK5LcKpIRE+Ngm
	t3Ep2M6pwJ/9tCEi6SPCr6hjl+y18WJPEL/CXqHlQJWsQYOA8IXKT5otvdU0oKV7
	yEVI4P1VQdrEfcSyyth/cCdZzIUAaKtBBfCypIn6xRytxKMPvC2IfNUJqofJpIaI
	rHBGxVqYIm16Fy8xUY4MAjj7NMtb4FMeX5ZlDaLRlssJnQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aad2a1h3u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 09 Nov 2025 21:20:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edb205b610so6264301cf.0
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 13:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762723207; x=1763328007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbVsXejt6h39ywCxmkDZ92ta+Bmr5io8nWG70XNXbyM=;
        b=NrOe3H9c8oFnsu1VF/QCNQfvNlM3WQObKCtnLp6kRkDMcCiQPumXjari7QzRIuJYLL
         iAF4Jku9bFXRWACspmMGf133X4qotHw/XZPKds91qIM/+cCedpGtksPq4ExdjyNuSgKA
         3MasZjbss8SwB35nUJWxi3JY+M9liD9OagaVCcWkUbSrCTcJyEpYnT5HZPEBNNssr2ms
         WvLbouO6aX0di5XlFZPgwgg/WSJpOQ1cvpTEQ61Okb3HNGoLeSP1X2EGJuMG5yfLruHE
         wRmUNZsvZQlksZA2rkMwoYran2cayzxE907arZGrZscKJgEZHnSb8g+ZBbcqBSlfcc7d
         gJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762723207; x=1763328007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbVsXejt6h39ywCxmkDZ92ta+Bmr5io8nWG70XNXbyM=;
        b=AyMiSgHng0Amd6wQ5/8Z89+86ovUh1pXtlW6bCK8jZqZ6sE6xFQHBWa9VamBp9IfhF
         twYGk4MSPlYYddt8ptV4JkMSUsSgsemeTSC3hYtsUPIR7SDei9q1eGnC5HWGNmuyJKGH
         syeoR12eXTMDvtw8yZpamsPtaAiPyATItBmGamYQcLMpymFwG36bdPBPM198E88Awld7
         6uRl6oD0eY6CZhIQ/40I+g5raSnzl2KWsAfHxCduA7OBZa8XnkN0tFfOlZHGYubO0RVX
         ihUD365xfXqAdO6/gQJTM0JunmKvRU3J4oIZC5+Gnsrlpji0V3YF+GmT59c2aUxteg3+
         oWQg==
X-Forwarded-Encrypted: i=1; AJvYcCVqCNtF+1TCKUptzc7+sQE2Okkj2qcVtF0J1jttaZtdXuZM5PGWzUmN7ccziDxxdam87safPYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMga74xIdu4ya2wwrjGjwS/39fLsqOdJKdg2H8DPP3CXzGYoS
	d9ECz9JwxrvuVTFn6VwOYMGRHVCxj/3e2p1XD3fj2dPqk+FqvdoV6iFtcyvwIxdd+wcmfnbSkzk
	n+KoQ3mODe17c7+kgP9HWdXHmhc67qV9t2RKGhuw19crev2bIMFR5jDpQxF8=
X-Gm-Gg: ASbGnctt0dwkwuVYJgVu9Q4oDSML/L2jBtamhD0Ulk1D0HzoIN9vpy9teF0LcC8dtUw
	0n4S0mKQH7dQ+/onIrOn4rBYFzOhJeWgGwxJ+tIeYpvEHIfyIcrgSHgO85Ai/KQKnPzMwuDcLzY
	tE566iZ4sgvip18F/7ROtD0G6IfPRFFMefbQCHC8kzjhMURv8a36PaJNvnCvGBYv4nOsCj+PkSu
	HgkRl2CyOy7GQKSwlgAgQxRke59FhW0DN9EVJmi4Q0nScDbG1x1ZlHQ67ID0Al29ddgxWlKV3IY
	B9KAKue6SGypzI+22vx0TvQ2YizlQo8HSSiOPUPpLqzem9pKEDSaKdOSwiMVo9aHCXpCYTrMT5J
	sSge1Auw0d2bzfNzg9LBFMuV+7ckrAHDSU0X3Z7ZTfOxKDA01zAPyXq+gThP+4+te8WtXYNliXE
	hUZVRZuVWC6m8v
X-Received: by 2002:a05:622a:1391:b0:4e6:ef26:3152 with SMTP id d75a77b69052e-4eda4fe0d46mr74479241cf.80.1762723206717;
        Sun, 09 Nov 2025 13:20:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYVBQScxAvnOfUXqgyJ3sZSK5uT7+bzU0vnJcBmWRUuT8ax0C+UWHx2AcA9vXBjJQ5A/MiZw==
X-Received: by 2002:a05:622a:1391:b0:4e6:ef26:3152 with SMTP id d75a77b69052e-4eda4fe0d46mr74479011cf.80.1762723206344;
        Sun, 09 Nov 2025 13:20:06 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a3a1c2dsm3412544e87.84.2025.11.09.13.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:20:05 -0800 (PST)
Date: Sun, 9 Nov 2025 23:20:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        quic_chejiang@quicinc.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Fix SSR unable to wake up bug
Message-ID: <lfvc5ndd6sb4hpgf7yxnajve3ipiptll52lzxjomjfpkjba2qk@3lgl6doz5tvc>
References: <20251104112601.2670019-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104112601.2670019-1-quic_shuaz@quicinc.com>
X-Authority-Analysis: v=2.4 cv=aedsXBot c=1 sm=1 tr=0 ts=69110587 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NZlr1TM-Zul8l3pKAykA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE5MCBTYWx0ZWRfX2U+kPqVZXgTn
 j2A22arbP/TiWc8sunF4nhTaOMeisvU1h5tCfDaQkjsTZICrszBJiOf6IgSvPXh0OZnmOff7Oy9
 3rcYTKGkw+C7Xxl+r4g0ShuqGQD/ggu7VDxUb3EzbE1qKaodhqn7Qs8JJMWOX3oaJtI7gdGG4QQ
 i+jJMM03zzVhZ78djcOhk/2RMwg7JHyvMepWjgjprMktYLp/zVwotWQH1u9PpYTQ30s/EK7tkk8
 exEaYkdsuAsyG/vLkk0fqOh+0CgywHPNqCvVfCvBFv63PuixEt6dFxlqwKMfQLhCXSNTBF9e0YH
 mxNF/wscRYfwYRg6EUIe69lm1U19XpmOym9ZvpuoOmnAm+vLW0IIEPPDgvP9KtHuKZf2hqWWPTD
 reNvrxQDQ3P0qUbCsJA1570Jv6xpyg==
X-Proofpoint-ORIG-GUID: VT43LEfr0No8ftf_Agw1_nJjootXTWde
X-Proofpoint-GUID: VT43LEfr0No8ftf_Agw1_nJjootXTWde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_09,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511090190

On Tue, Nov 04, 2025 at 07:26:01PM +0800, Shuai Zhang wrote:
> During SSR data collection period, the processing of hw_error events
> must wait until SSR data Collected or the timeout before it can proceed.
> The wake_up_bit function has been added to address the issue
> where hw_error events could only be processed after the timeout.
> 
> The timeout unit has been changed from jiffies to milliseconds (ms).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>

Missing Fixes tag.

> ---
>  drivers/bluetooth/hci_qca.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
-- 
With best wishes
Dmitry

