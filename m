Return-Path: <stable+bounces-210473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 163EBD3C4E7
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E88725CA5E0
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD8346AF8;
	Tue, 20 Jan 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S3ZTfcnL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iv+n/Nnh"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3FB349AE6
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902708; cv=none; b=bDVFYN0DZe7WK8ESNbS13rBkoYahxufDFpjRRQlyCGZRuWBXdB99FUw+vmNE01ZLCUnCEiIGDm+5qUfWYRyrs531T7a8WXpMelITtMcJ0gxv1dtUDp1NLAAcwGBskF3wsG6GIlF0phHGgVjX4UacRWjzt7RjVKpz3ewg6LMy0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902708; c=relaxed/simple;
	bh=NieccrGv8Y3yAk5L6CmqT7DDABCkciWgrOarVxizrrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fh1S56UTqb/y8US8f+a2lus9Z41d3Na7Flkm6QIRHteHKHqjngfOHAmDUGg1/cX4i/DleOXKxfdGB/U7Xn/mgV4UUCrH5bCPB7qbzIXdbVrpcgDAzXZZS0Z6Nq+ulwIpLg1qp0Mr/GxNStTVq4fz1cfAstKEXQmRarqKyy6mXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S3ZTfcnL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iv+n/Nnh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K33J5T3805148
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 09:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mxGvupNp5SjlmR1VpxDaocdnNqxV2zg24D9F7/DU4W4=; b=S3ZTfcnLcbyRor2Z
	rv5b/6uZKanjLL62IfALhbFP04ScBn0OLZKR+dm23KAcaThIqrY71u8jV9HLpEeb
	orZBaUahNv9gOgyZ1zDOoI+TNYbQXfmcGoxTZjkFLgOfyWkhxAWAY9/WzRgu5G5r
	i4mRs5u+kLzvV0Q0fATFaqX9KvdAweIWgNz0QYdamuHXm6G3FnEuvmCchiOip1DL
	vclm8omj5XzWeDrKIptm1ANU63N7QAEEhGLEP0ATB89fYOiuWKslcVySNxsveImq
	QaX9QMrztMSgZq6G7Zr6QpHhYv8ACH7ZnooO/O/hjeRq2eepfSjFt52PB5C36HLW
	8yBXFA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt1f894hw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 09:51:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a87029b6so926320285a.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 01:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768902704; x=1769507504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxGvupNp5SjlmR1VpxDaocdnNqxV2zg24D9F7/DU4W4=;
        b=iv+n/NnhlmxycQjkj5DJCmC1O79eD/GQrGfTeJZyjmWCkONaWYkmMUa5szk0BVM+BH
         1yxr2g19qKrBTLmDN+K6hoxL8rl3yyTMycQ+4qBRIQY76csI5w8I4UFxeFqZWscBEPru
         jeTEkDksoyi7LRR5WDQQQNQ4RGJuttN0PZSB/IUbnEH5kEDLI+4hrWkkAcCwmcky9qeX
         7Ka77AAr+knlglQmocbO45ZtK4r37wUnXmcS1tX22hnHkxvzlqlUMHtVzAjxD5tymv6q
         VTa19wWQDcIDl+/Io+XJm7J26VEW1dbtl9XRo4mfwZNuPEGn5L0UUp5v2oqjiV50hUrp
         5qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902704; x=1769507504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxGvupNp5SjlmR1VpxDaocdnNqxV2zg24D9F7/DU4W4=;
        b=Os8wOazKfZE7TzNSMMp7xZ/pBKnvtXEE/Gdja5LP1OXTHSEpFb65kYjcgMWMZhyPsj
         5i7C5SWv4FC86LKGboIzmo+yssppT//QDScyxqJoC6tUVSwcoDmahIm7goOJz8SR01K3
         niO9QjXehN72p2nBS4ATv5QVtKkJqUG8BsXLLFzv1u67zQOmdyzpJDEApCxjWLq7elfC
         RLNrndR4MA90ngbatIIs935YAgV7dePLqJz5XDPyVDu2jQ671tJG3OzSWN+mz6Aj9Nbp
         P6fmjwZm4QFZNkN4rlbHnEi7MzpsXWtMvr8ahNeN60ukYGbRaofPnvG+EsTulAFGNPjj
         Kazw==
X-Forwarded-Encrypted: i=1; AJvYcCXGAo/pu6hCnzaG1ZVMCf3FEV03X9xFoIv8eDFTO6yNdLdD2wgTm4KLzrgdANFHQtDoD5t8zRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvn9KD3bapDaHX0/Lra5/PsB3NgvM9+H9p1ZxY/dD4+igUb6/
	+2m1DT/Z4+/9kCkEw0nrskpkWhbw7V6at34/5pDzHosb6AWzZhOwzc0wJeD9NBTsqAd0vhvoNIz
	L+/KSLhFVhYeqDl1ZIIWhI1FHnQd8SuzdPhdzUJv6/CPmGGUxZGWIv5UmMVA=
X-Gm-Gg: AY/fxX6spypvbt0z4xxBXmZKhyhLAzE+djdPTChWh8utdWAW8ChifmkcQAhsERLnQoB
	Fm2WiSb9CManz8qD2srbfE7u1fLx+sH8ZuFKtqMv5PiNvZu6g589Xt3kr+QCVf0VuL/qFMLMb+2
	FtK4y0U9MqT0ouoU3+XgV5+LgFGZ/q0J9mL6bEQtodBLANUEI/ozLeI/CQSnhJXnOTMIrUq/eR0
	6JxwC5XvjABTUTfIqZXApWaNJomWJgN/IUjHFAFUNFmj/y1fJW6tdsdSY7WwPpYBxeCMRWVM70O
	1UMn0rUKYPrRRFgxn7LEAn2UjH9avM0oWlJ15Fb/kS4NPeNiKP6GgSSD+1wiKfbe4+EmJXZ26YH
	Q/z6l5jt3BD8RqVmLGMl/7ShzQQNSi9VIiUMfZ8E=
X-Received: by 2002:a05:620a:1907:b0:8c5:2ce6:dc8 with SMTP id af79cd13be357-8c6ccdab4fcmr127357285a.3.1768902704312;
        Tue, 20 Jan 2026 01:51:44 -0800 (PST)
X-Received: by 2002:a05:620a:1907:b0:8c5:2ce6:dc8 with SMTP id af79cd13be357-8c6ccdab4fcmr127356385a.3.1768902703919;
        Tue, 20 Jan 2026 01:51:43 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dbd5:da08:1e47:d813])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm28937033f8f.32.2026.01.20.01.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:51:43 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
Date: Tue, 20 Jan 2026 10:51:42 +0100
Message-ID: <176890269589.42551.4073379727829793738.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120092650.2305319-1-tzungbi@kernel.org>
References: <20260120092650.2305319-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA4MSBTYWx0ZWRfX8zymFsB9FTxm
 GRx7A5ZIq9fljF1rBhSRIp0e37EycCLOGmNaixLufky7n68j2GKnX+BwBRJgMByHC0Q11BMH80n
 RK/GPZqbm0uYS3Q/Hm05i9PeLHtsDckgNoUlQERIpvCegd37EKr3LgViAbZ8Lgzq992zf4405FF
 Z1eFCMEzDbDeCTPGm+Qyte91yrZFNDk+0Yd+JbQnpH2h9lRHwH+tPf+9bvGXGVsLM7zMcFnwHwo
 Vqw/1y7tnrt7yoGCot3GLWj6sC/0Fec2ThmPWsHtD1qxbP4dy5CrExotrMzYyKmhLExVVYs7dae
 Lorj0JPb/lyt86zEUFOioMQFS6m6YUPy9v/FSBfsJFhEzERgxdk7Ycq60xxDuVl0RViRQK3H5WB
 IcBU0lEyOtUkGiYzedlye242yjWJzfHMFeEn5ZE/TMyCudDPOBvnCEIti8NsFJH2DdKm54eSkmc
 YfAJbri/j8GqBbwtZKA==
X-Proofpoint-GUID: jQRoa9dbDDqo8_0wJs4Pw9QGOvx3ocwb
X-Proofpoint-ORIG-GUID: jQRoa9dbDDqo8_0wJs4Pw9QGOvx3ocwb
X-Authority-Analysis: v=2.4 cv=LdQxKzfi c=1 sm=1 tr=0 ts=696f5031 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Qk74ZuyOwNiI-SMmqgUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200081


On Tue, 20 Jan 2026 09:26:50 +0000, Tzung-Bi Shih wrote:
> On error handling paths, gpiolib_cdev_register() doesn't free the
> allocated resources which results leaks.  Fix it.
> 
> 

Applied, thanks!

[1/1] gpio: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
      commit: 8a8c942cad4cd12f739a8bb60cac77fd173c4e07

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

