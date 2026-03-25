Return-Path: <stable+bounces-230368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCowImwbxGnlwQQAu9opvQ
	(envelope-from <stable+bounces-230368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:29:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F8329CDE
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629DF303F7D3
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB43D669E;
	Wed, 25 Mar 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPnzPXf3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fBJ/JGBL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77399309DB5
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459066; cv=none; b=apQQVJ8vL5YSMA9uqwYoPMfb1vZpCLlOL/rKdJoqOkEqbYR/WmfvmWjdIQJ+qC0HhbHddCK0+aFNNG/Cds4Kg6ba46xzQUymSuYFmKgXirMOwpiP1UHo9Np+lAUTsX8UQotGCd7jLdfzqAshPiGef3mP501gouZWVwcR5BPrBeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459066; c=relaxed/simple;
	bh=DUeYUo8v2hrG8TO/xuYnnbrW1r9eSwbd9072+pSakI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H36I5/AtcCwUezVJsdL4i/cT8SfNxWNUps58QkgP4TKmv65ee1nH1jyIP9KhBsvZ/GE10BMxuI7qrcDzP6NFcKh1FwSEyBjAJBnZadSEjdCCGRjCgUCAqTk3t2LA7I4avlzlt8E8AK7uYTJqVs3H/QSBtndKhQ/jrtnuJfjdv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cPnzPXf3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fBJ/JGBL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFH1td1554595
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 17:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=T4wGSBtw4Oq+7FiM6cxcwXwB
	JwT66nkOPrc5ssKiSsw=; b=cPnzPXf3LuOAZTFFQ76uGhTtMTKKaGRkYK8Zbzyy
	RelwctbN+yrwSohdaMcOxrW2WLe/+D2OGudVee0GDbdZsAjKobNbTslOxK7chksJ
	7VlfNSjzS6VFSFByvYQy4Z2HAOgTvIiWETtrQ/Ca0S7rD0RdjAWM8nSQOvV26Bz7
	prDP8f2QozwVWo3QXvJKU+nXzjeVW/c4uFpcfkDFFzReN2g6zqMR9ucpj0y5zxi3
	ma9lk2P/i80H1Bsc4T5Yhx9WVc/QlLX2jaesF6RDQzSvT6yzX987oXSIaBdpKY80
	X6izwoPhikT64PHPXUdzpzmaXISB6Be0/HsZbbX6MPwTaQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4gj78xau-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 17:17:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b4987c698so380121cf.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774459064; x=1775063864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4wGSBtw4Oq+7FiM6cxcwXwBJwT66nkOPrc5ssKiSsw=;
        b=fBJ/JGBLVxxnmwkj4T4mQz6aSXNwTw1ZG2dOTrntXAuWE9AMWd2z4MvvvhwvpB1ILO
         HbIxc60EJkY8pnwlBshkfFTS4kFMZlPsuOnptX5FvnZqN0yvTgMlhJ1FkyOAGPMUyp/L
         9FlI11uJ8htavkSAkzirn7TTv82A6AVZJSS7J0uZlR91nhvwWRptczAwI5/Co9y4bPR0
         nLiC1BEf0vUdVKIHXHoryhOMpihUvub29o9RsVun9sdniPu1dDVWPaWVkWH9qBs/n6kt
         jaZ0pqaLsVeOkU0yvJRPgLct6CQYPsTvBchZg7vuhmPBGtUWmqHUvt5tMri2VBsqZ0Sz
         Hhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774459064; x=1775063864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4wGSBtw4Oq+7FiM6cxcwXwBJwT66nkOPrc5ssKiSsw=;
        b=lyW3t42PncrKZ2W8260WIbvQ/RtM8RUJfNcYfMEKPU16yAgbR4h1rYn6Ts6TRrEskh
         4TIutkOFJ6hSvdVOtNeMde405BodRLyIhdop0KawAIDuuVrtWYUI4arrlXaxVn54iX0L
         Xj0xBf3+avk5V+evlAKbOnUwVqAOv/1XpAhy7CpnKVymj/x3js2lrmbekZrfp2kxr7sg
         U0erKwPHKH2tQYG66ZF05eYuzmDOyX4OGfyug1fb9thgzhJklYcRb7G8sdS51QT2jLhV
         13oa4SRuCr7T97h/VznSF/uC4R5+Hjh765A6yPzDWyUqwyL2KzWJh/Ep2//7qS4KmPKI
         0m4g==
X-Forwarded-Encrypted: i=1; AJvYcCUYYKSYGgX9pTMqZjCawGbWYAbnvLs2jmWxplB+cV6vUvlbHizfFSOYRNilmQPAY5cA2jJzusU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiLwNr6B/cIe9TGfV+4MNEXtRF6oCTGaOFXcAXnei7eQHjH0jU
	aAMFEnAjhahaSweEWEr7v1nMpm1ubWgj95YFcG6RJ9HD7IAK2qvuDN2zWEx+LrUKMmt3CHyGKnL
	L2fKjOkPg9uHNnEsHYWrPHSMqtFK1hlY6aJcXWEzn/LveLcb6supbru7ET0M=
X-Gm-Gg: ATEYQzwYnjgzJLfSeh/StWOScIT5s4DU08GEZEuaAyAVgG2LXW0YFnCLwu4Fg13tz4x
	EBbyjqJBNvvq0DhnFoxQPD6M2qjNyf1C7IZOgNbB9t9b8X/N2VfK3u4p16383WU3LYaEIgmW7XL
	wRZGGc8dtArniA6azBOWTWVcSKVvbV2D76uQFP1i7/uCC9RjHkVx1pk11cNuKIkKLukypJA7cHh
	96NTgE+hsLcHyu+VdIrQT4pQaupK4e9SUCenG8brYx9pGo2zx6rwWwj3L+nY/kxHJ2KeBo5tks0
	B69cPHmzNokYWgS5szPT4BasdgVSQPyYgey/TN1iULNDK22ir/cVB0EVNNE+t9sWDi1pl5XvfGX
	Yv7/GZfDKZtrCbJtyWCcFvIjVbd/i4Fxpd5hxP3+zFj2C54ez65NSx34uxrfqCe5PgFqfpIG+6X
	wxn1/fzSqtIlXZwPuDQ7u2ebl7Jc43CUkJ2aU=
X-Received: by 2002:a05:622a:8349:b0:509:e46:84ea with SMTP id d75a77b69052e-50b6eecc75cmr86464571cf.34.1774459063943;
        Wed, 25 Mar 2026 10:17:43 -0700 (PDT)
X-Received: by 2002:a05:622a:8349:b0:509:e46:84ea with SMTP id d75a77b69052e-50b6eecc75cmr86464181cf.34.1774459063384;
        Wed, 25 Mar 2026 10:17:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a068f8c7sm27169e87.65.2026.03.25.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:17:41 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:17:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: qcom: lemans: Correct QUP interrupt
 numbers
Message-ID: <7ifkfgabmhkap7vnwewajmwtgptgioapgszj2klswqixbk4nex@f7nnwfcrit4v>
References: <20260325-lemans-irq-num-v1-1-a470d544966a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-lemans-irq-num-v1-1-a470d544966a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=M9hA6iws c=1 sm=1 tr=0 ts=69c418b8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZAk-9iMX1uhtNleSEbMA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyNSBTYWx0ZWRfX4lUqW7mq+Zjt
 vXU9WMR5L3CMug+P/IxI79Y+lBL97cpNhEjWqtUEM3NXY8UkzoSrYfoSu22GJ+r64eCar17dKJA
 E2pfdM1IsPe55PrCWLEUr94wDY4B2xZGlFqgP4hZHdt8XxNKlYaU9N2NL7ahMcuRaYhGlQUccoO
 u2J5hGiFVmbBpj6z64u2X6MjpgpPjSXaK7x/I9ldQA8c3rlHUvJ9TkYJyTii1noSz3V7mKgDYyh
 di0MzyS8wNpMSfpcaq+nwoMb/bd/dlyq7nH5toEothdLwGVgF7GYUxMIX70Y3keaGe1si+XNcov
 GVRb+t2/kEPOuf6I/0jI9nxfqLWuISDUfwnpzQ3gRUqmehw/H8AJU1YKsA6KWYe56+a2E8Y1CEj
 fhuG1E9Fc/DdYtZ46cPOTngyAAMUdx2TszXuOFZgb3aFY6C/WEvLEFQtWQfrkdXLfwKsnF+4TFM
 IMa2y3Sut7/0BLp6jQg==
X-Proofpoint-GUID: NcBtiPoYLV3dy3mvUHZplRwcrGOaE4qd
X-Proofpoint-ORIG-GUID: NcBtiPoYLV3dy3mvUHZplRwcrGOaE4qd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250125
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230368-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB6F8329CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 06:30:37PM +0530, Viken Dadhaniya wrote:
> Fix GIC_SPI interrupt numbers for QUPv3 SE6 nodes on Lemans SoC.
> Using incorrect interrupt lines can prevent IRQs from triggering
> and break I2C, SPI, and UART operation.
> 
> Fixes: 34a407316b7d3 ("arm64: dts: qcom: sa8775p: Populate additional UART DT nodes")
> Fixes: 1b2d7ad5ac14d ("arm64: dts: qcom: sa8775p: add missing spi nodes")
> Fixes: ee2f5f906d69d ("arm64: dts: qcom: sa8775p: add missing i2c nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

