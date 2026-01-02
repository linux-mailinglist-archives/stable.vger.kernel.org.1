Return-Path: <stable+bounces-204452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DABCEE196
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9FC03008E92
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB01D5CF2;
	Fri,  2 Jan 2026 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gm+LIwc8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hLCAQ8NW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D521D3C5
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347155; cv=none; b=bnCPZngAx+X48ogw8g5IJnzYD5hp7C9ohAWm83G229qI3siXCf4bQoWq7po8p+iqrHmyEEFDSrmGcCqhaJQQ5Pr4H73BzUsNw2hnGaIvvJv74MNuhWCac8Exei9boSLO6+d1qiDVhl7QKwLoMU1jZ8wK09NF6Vtzc+gGGL5+p/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347155; c=relaxed/simple;
	bh=HbnCiSwgSwPUNRmt5CLTByV60465BvgQqm/o+qKlj8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlqYltdTf/RKWNJpXaNb2i8X2UhUlRm0xffrwUnYQq4GtuU2UBW1Is40USMcc/H1YvncQQyuakwZz6BZ8QpX6a0rxIjmH5LSFO7ooWjoHEkZxcP3t4rwwABpxQuhspHOo1qHTq+U+MNDwQL9QyZx9NHJiFm4B0xElXn9sYfpgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gm+LIwc8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hLCAQ8NW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029VwUH2310158
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 09:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hUoUVpgOtlycCnf2jT/3o4bpPn9wwLgWjFSpXr5yHqU=; b=Gm+LIwc8PTuq4evU
	UohuC54X+HwSgweV6Mz19JJRueVkW2Iu1V1VKx2bxsHZMdDFwDcvayYZmb/Ujjyi
	X1QR+WshT4FTlWZH57xMjs5zIXcwIjEytEoYuVJf7JY2eu/IOdof4Xq3nrlmFwZn
	vYQu5b6NbaPo8HkQ2/xyPAJZSmLDFi3upO5jXYiAwhQQ1/JMxvqTEny74L8siANH
	BimYyjyKvNYKCkkcqk+Xx+i2T1MQsNITQzzPa0sT/QCzdDo02SOPs7KuiC8MNu5X
	6apWYm+BYws/1Y58ffBdfm2fIy2xQiW3ywtMqN0TCpAk6NRRNBDbpLa1r7tM3TKc
	xyW8cA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bdsc9spvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 09:45:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed79dd4a47so264038341cf.3
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 01:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767347152; x=1767951952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUoUVpgOtlycCnf2jT/3o4bpPn9wwLgWjFSpXr5yHqU=;
        b=hLCAQ8NWgTi1IqKhs1Cu/CbeNS96ZQs1/LE1kKCjjCgowxbLAfb6fDj+cEE6UBj1n9
         JFZhwuupOkJKOes9T07HsxTWmCkY9uT6CPIpx/vNFRHJ/syU9zBBToCaavWgqZ3xdM/M
         OAmPQcnIQhcZIyOnQJWCtIZIDM3AtS/6pZ0Eh7rroYxa7K7EI/udRPkBWmYOtnnEZ2tE
         RvnMaEAyHD2wThzxfXb7xCfrsQFQ1Pvx/VTav2cAGXSbud3PwAjlP73YAawb4jI+l+nt
         Asrv8A0SI6mSyTmy3w6mfk66SVxoYiWxi4vbATzw9tUe29Iw98qCdf1TCOFI1vX66cxt
         2uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347152; x=1767951952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hUoUVpgOtlycCnf2jT/3o4bpPn9wwLgWjFSpXr5yHqU=;
        b=KSJW0bVygiy1/SJbcmmL1pDBg6qAxlOUW019c8RikHK10Ifybd4OkVv80khsXnP4OX
         l6/lXB4nDEW5Lopw+clZQRI2mqyDTkPm6M6VTdJaMb61wDfOCLb4DQM8v8IsS2yZFyIR
         OxbFOOfG9SllX5DLibashRk9Iw8qYrqMQwU7gsNjiZ+CXZdHbfSKg+YukG9WB3GmmWAc
         VEtNtcGL+YA7NembR7hXxVk5LQDx7JxFnoRv7wInLVtepc3ZTWoq7EOZqhoatZKPr5TJ
         f7/uvZHrO0QHpaaKyyQmo1CX+EsWuF0QoRikvEOfn6LHIjEKtfPMO9RA4z4L7lE845lL
         Qnpg==
X-Forwarded-Encrypted: i=1; AJvYcCUuVkHicHnTHEEehTSv9eHMkwH76hTzzMSlKQVa0IG+4b+VHkkm+Q6zyH/FqRhK210bvu5s8Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhL1TwXGgIPnGXahHna5/WAUV3xRJfNUCoud+mXrI3XcVuOP9
	uPlYZd1D8/d0eF68/DhaPc8gQP+rya38mdiK1R+Y0IPJWBwmgFrYPgpCHOOSVMi4mwTuLAKsd4M
	Otn4O5fSY6TdaVB5hn5xAI1dbgvT1431BlViOXWEYdQzkjxMUZQ8HnlfTuvo=
X-Gm-Gg: AY/fxX5CV/Pu94EJpO8qFQrfbzLDSyC5Hu9eZc0rv0NUbPVTk5RYN/kJaQCGs1m4V8F
	nFxtlf6qehGvqVu3ZeBYtBDM1kIU1+wn3yJ8TTjlUHWRyRNX+9bTK2xvN38J4AR2gEKcDl0ji4z
	QbVGH88eWkdASSzR5j2YdNdNLqxrW3E494PQgOW/eaUFYB321WZtA5kFarOdilJAHLBfxUcrb5B
	Ao1Yi91VdDi6pArXAbTiryNZVXb9VlPR05WF0ErUYwsnNV3rSHCWS5v+aQ0gxGlxrTLrQsZHgvR
	zIyCu6Fegd09McmSzMPgmudfo09dG3XrlaEqTNwXzCPOMLSPktyP9e3cn706O8AHphFmur15RNw
	07pq6+/M6lnvzJoCIUcAfAmMFwgFOAYdcHq/BfJU=
X-Received: by 2002:a05:622a:5912:b0:4f1:c6b9:b1ec with SMTP id d75a77b69052e-4f4abcf4bc6mr563248531cf.28.1767347152038;
        Fri, 02 Jan 2026 01:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCQA//A3oV//ABpqaerzgJb4aYoJOFmNXFg5kLqP3TO5X49rj/+bK+rs9KBUl5V46XYxLkOQ==
X-Received: by 2002:a05:622a:5912:b0:4f1:c6b9:b1ec with SMTP id d75a77b69052e-4f4abcf4bc6mr563248441cf.28.1767347151632;
        Fri, 02 Jan 2026 01:45:51 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8630:1161:9594:98e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1bdsm83029209f8f.8.2026.01.02.01.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:45:51 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linusw@kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        brgl@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: mpsse: fix reference leak in gpio_mpsse_probe() error paths
Date: Fri,  2 Jan 2026 10:45:49 +0100
Message-ID: <176734714725.19245.1109954933617562647.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251226060414.20785-1-nihaal@cse.iitm.ac.in>
References: <20251226060414.20785-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -f4fjOoFRQwTzIY5W1joY339yVEdTVeM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDA4NiBTYWx0ZWRfX2QRTRTGWGxr4
 L02iNLkeI23zgEyMLXjndSGq75Npl2shVqFRkxhT2TiSKpcsC1eYZbq8tIjiybuto1wnR0VR7+7
 hSZw5J9Zp3M0g3/irtM0yWN8KqRZVyHj+FYNYKhV6s9bEpOSpZUzaqbqxnEE1/uHkwT0OEV5jVI
 +hbQt1c9ikGnmnP4AGavzl4RiAOfK1rEnJBxOsy/clS1vwfk/pEZhTP0/7PEw/lCpWf0Ji4JtRd
 ozp0Pj6DbJVKpPpf1nceWNULi97gP/iTwY3hMhq35PbQuZYOE2lM98Npzj0MCao3oD9fQ26OT8h
 3ZH++BoHlIyBZ2isBoOCz5Gign+spjlGrc0iMNKNTjgj1bWs9dCM1ZfJNnH7lmgOz3028JO0LHl
 KyGdLYsYd0eWAHdnTJgvRDvQT1vHfZEmu0y6az3GVngBVN45pA0/El5izWddENhFWrD3ScFxNrv
 eskOoDHgtYurYwNBFAA==
X-Proofpoint-GUID: -f4fjOoFRQwTzIY5W1joY339yVEdTVeM
X-Authority-Analysis: v=2.4 cv=Hq972kTS c=1 sm=1 tr=0 ts=695793d1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=w99RjDxMTeyC-aVXdUkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020086


On Fri, 26 Dec 2025 11:34:10 +0530, Abdun Nihaal wrote:
> The reference obtained by calling usb_get_dev() is not released in the
> gpio_mpsse_probe() error paths. Fix that by using device managed helper
> functions. Also remove the usb_put_dev() call in the disconnect function
> since now it will be released automatically.
> 
> 

Applied, thanks!

[1/1] gpio: mpsse: fix reference leak in gpio_mpsse_probe() error paths
      commit: 1e876e5a0875e71e34148c9feb2eedd3bf6b2b43

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

