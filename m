Return-Path: <stable+bounces-230877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDeVDm32yGlUswUAu9opvQ
	(envelope-from <stable+bounces-230877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 11:52:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A36BE351732
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6982B3015854
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C0F307AD6;
	Sun, 29 Mar 2026 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DgBXDthx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnXl+ouP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BAC2F39B5
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774777962; cv=none; b=WB5vvg3z5vzvbGg8I8Ct+bsk7CJZVgpl2UALk5w9OHlYd8LVSQ1YWGf3YAeGsQpAil7BEAdDLhUZPhOXUnTRV2MAcP92bZ8AbWRHxLAlL9jdrMu79xtQtZxj39DhWVJkQtH4aZJw0mwTrOe9ERHi0fXBd6P/xMWW6g4/QLqhBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774777962; c=relaxed/simple;
	bh=7I1eZDkRK/wdoYxZ7s+Ps63Cn8C3cZQaKdTWPLvtd8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+Lzfr69Z6HEEJpLf9tJ8YEdSriA0QWiJ2MsBhR7IE+fYWaR/hQe+fUKBEYv/bWqogySfmbIsmt4UeQMHSltkKzFjsH9gNr+GCMw1UQSFgHeV6SEEp5DuVjJSDP5PXikJwJjTIMNQ3/z1XT7UljQPypszACfcANJQkwFHgH8L7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DgBXDthx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dnXl+ouP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62T7S7OD422045
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 09:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hAyNkY+C3fVpD3lC1c6+6VJB
	YgiejZKZd/p+VA35QAk=; b=DgBXDthxv5tldkiJRuVhdhJOm1JntCp8ib32vvFd
	RoBiF+V/tECzgqQFTGzs9azaf3Kb7oG6v0MhZzhdQGzhNXEC6b7ubvFu+QNZ+TUt
	N+tVoeifX6wP6uTT3yhnPvxuXtNw2UV/SNnqhAiIcjk5PA1HwzB6n5XMycT5Z4Fx
	cOcTh1lVqwNYqbp0UJdo/qMTZeeTPXm1RwtRmN8oYkVW9ufbYq4WbkneiLkTuiQx
	OufqQEIixd4QVQsZuGxRhqWwGp2Nok663vnGN4CcncCmNxzvFj6hIhSBpTJ98c9Y
	cyAmjXYZk2XxDjitYA4Z/t64eOC74HPnFcFbOOs9o6UU/w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67c7ah6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 09:52:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5090e08dcfcso102609211cf.0
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774777959; x=1775382759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAyNkY+C3fVpD3lC1c6+6VJBYgiejZKZd/p+VA35QAk=;
        b=dnXl+ouPVigFEwqbh2pAOGlvFbzv/+T6ea/PFG9zJhKr3bSLktCImrQvBJt+b+U0HE
         Y7gPQ2alC8JUaluNfdvvSipJtiKTtDh2feUz5vpTypmLTjU5BnkC15neFXdjvKdFUXBg
         50EBgUJcir1xyih6Ju6AMI/PXwo+wj/tp3MB4EywvgX0fA9TYCbt/2lnvnPbrnieHFX2
         BxeogZcOVZB94yD710xJNzrLYwZ5ZZuUPy5j5MAw0xyqQVji3aUGij6EftjOJGG8ifTC
         Iv2mmBp0kadMF3pR8dQCrjYJG7ecg0coMpDgkP1QmMvrP2/zrqLhveKglJwSPANd71DQ
         i1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774777959; x=1775382759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAyNkY+C3fVpD3lC1c6+6VJBYgiejZKZd/p+VA35QAk=;
        b=LumAmaiE9EW95uAKbyrxFAfCQaW50V2rbAO4ve5y67GUchJFNjBmKmodu0YSNc9wRQ
         PIT+w4FLuU12IdR0+SNDI8zkEKbc0/TJv0ArpGA/Sx4PcnbiBS/PnMxY92G7A6E+BkwY
         xHxFGx+OeE8weh4RofOM5U9rQ9395Kr3o+Un+xrqQS5N2arRl+cHCec3BcmHCO3wxdTO
         FCZ3ELP/QY5DRkmuI9aZPiAIZwkANUisacw0jvz8TebNFQ3Ul6LjQFf8ykExpshfOoaB
         GcG6SiUiPl51UWLJPCpfg7qCZuz0wFz4FfzUccZjTMe2sfD5N5XC9as5a6nacyyimJa+
         vtfw==
X-Forwarded-Encrypted: i=1; AJvYcCV4w0XhokYJPsXfqVk0s3D6ig/e9PJa+sIHaYlHJuKi5A3JtJo9wAik/ClYDfGXPrQH2sqCaQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/jMWUr4s55oT7IY+N9Cppw0JHzrPV7YUqNoNekQxqvdZGo4a
	+/unJSVV+SNDuA56SaReYlHjIKpN9QtGXVLTL7/50mI2O6R/7YI8iJbAC27etbvPusguhcN7ILD
	qhx+v8UXtEqHm/yw5VqSzizjdiXlx/4pjeysNT5SAe43ZW+8p0hZXb0HL9fQ=
X-Gm-Gg: ATEYQzwqldWP0sN392tWYCP7YgkgD7cBvWbOafACv7kOpZOJiA4rS+L5ZZlyQE8IAdQ
	m4OBo0yY5OytpIaoaN7jnyTTSzDwfKfouisFR7AOrbo5ynG83WvdeGeSg+VBJzswcLGwG35FxdG
	0e00aaGp/enRGHAGL8KyHxAzb9ZNh36VjoMWxNiZtzVpdajrsJokkxGP9V9zOa9cDEomPxf81J/
	c56hYTLXjydug2xFHcX0KY3cD7YKoY5dbZYzs94JknXiVFE5PS22qy05AfpBicHAs1NG9e3tpy5
	sVxlist/NdiXTOU5+4uCjipRyzOUXYt9kWlHVXSQA09D0o2yaLfY7U51mLKue40iy3flQ4orTHw
	JZGe7+F1d4/NI/svZSHnn+IGGYjeOJ2BfxeYrCaDXVml10Muufy6Jf84HDDbEorolP4NN0gKIs8
	bHXLftYQLvnNWSkAeYfgCAwI9DIPUUxBU7lsY=
X-Received: by 2002:ac8:5f14:0:b0:50b:532c:2ab0 with SMTP id d75a77b69052e-50ba383e5ffmr110867781cf.4.1774777959406;
        Sun, 29 Mar 2026 02:52:39 -0700 (PDT)
X-Received: by 2002:ac8:5f14:0:b0:50b:532c:2ab0 with SMTP id d75a77b69052e-50ba383e5ffmr110867571cf.4.1774777958955;
        Sun, 29 Mar 2026 02:52:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c8391fe90sm8782231fa.42.2026.03.29.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 02:52:37 -0700 (PDT)
Date: Sun, 29 Mar 2026 12:52:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Biswapriyo Nath <nathbappai@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Sean Young <sean@mess.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-clk@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Add
 PMI632 Type-C property
Message-ID: <raecqyz4r7je5s6ecyclffwoi7kqt2oqwctj6aevj5tsfuxfkz@5i2jb5i62thx>
References: <20260329-ginkgo-add-usb-ir-vib-v2-0-870e0745e55e@gmail.com>
 <20260329-ginkgo-add-usb-ir-vib-v2-5-870e0745e55e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329-ginkgo-add-usb-ir-vib-v2-5-870e0745e55e@gmail.com>
X-Authority-Analysis: v=2.4 cv=SPdPlevH c=1 sm=1 tr=0 ts=69c8f668 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=4paqipjyf0t-I0uxfbgA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: B3AFNfKBlIV_HzvI4mUvEZXwZIgf2nl9
X-Proofpoint-ORIG-GUID: B3AFNfKBlIV_HzvI4mUvEZXwZIgf2nl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA3NSBTYWx0ZWRfX2g4G3v9JZ0L/
 RLmVaqglRhBYxvrxUx1yTcwZuThiACHBcj8hOXhv49quhbRHE5fKyMxTYJkqKi9sbBsaHgCwRZz
 kCXlPoR4/twbppVxADUwHDLGRpuHW/IQKlmysQ8dzG/hXlzNIvzvfvpYgqXi3DQE5cdE16dq+Ka
 lDDWDPW8HiOHFI1quHZ/wvNCi9IaoV71uYxdbY0fCkjiXonTh6yX63T6nHFFpTc/Oqm9kAoL8v2
 ktSNr0PfnT3NToc7W1MlvLR8RolEcGqJRWETB5rDZhnmQOJXaVqqLzlSRrqvVTSEmFJ+DDi5ykN
 MIyNAxqNkMMgd2A+sOybPhEhbU53XBXqP1c/VENOmexrVVRagez9Olf3VP/8vt55ulESkxhfAwY
 x9cmOc3GKlnBsQKF3ScYqB9Ln5SH4jFszr9iF2/vPmZjr2e2XpgOyYY2KT8Qw7RRB3onFTHsoYe
 hBbNNbLNuPB39UT+Ncw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603290075
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230877-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A36BE351732
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 04:48:00AM +0000, Biswapriyo Nath wrote:
> The USB-C port is used for powering external devices and transfer
> data from/to them.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
> ---
>  .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

