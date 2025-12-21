Return-Path: <stable+bounces-203156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 707DFCD3BF8
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 06:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BCB2300E025
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 05:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62703221F1C;
	Sun, 21 Dec 2025 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W4eXRv+6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WMxYSGbQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBB219FC
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766293285; cv=none; b=N/G6ay61ZV7H2/7hh1d8sxM91y6gK9vix4vDF5RzoIaxkLQTWnJMrox/T7N5SHajBzpRuWrtVuIqtekflo3Ps6Cu/PVVwj72gHH2Br3r3JCFB9y8AQlMFOQC2kzhdxrzHQgc6T8t11MOBd/3RjvToviIs3l3ZbR9raCChh62VTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766293285; c=relaxed/simple;
	bh=+u6jNQF+kxafGUZCklMCAdTtEh+nCgCjY7zCKfMo+rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXxs2b5nG/tqpdthZ1t4Kg5K++JzdX+9g15R7UPzG9PQxIHHMAdoOhaXk7Alejbi9FBJMcjMd4Y8+mfAHpIEGZiYvMoWV0hp9AWRVpA7v/1krgz5Yz/rPhC1D/63L6sxKyoXH+LmFzafQ5QzYAw4nFDflRjxlmH5ogjxg09D0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W4eXRv+6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WMxYSGbQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BL1WSL31611059
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 05:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Gg/igCHGddmXF3t2QB24Ayk9
	sySh3OwVkPubaBg3Oxg=; b=W4eXRv+6n9gtHLx+kn592ZuuDPIlErRKuYeNaAob
	qVbaR7FG8undXKxw2s4TPCKHeL5RyHSNd854i0Hq8YqNyWstVX3F+KbGM6Nf0C+2
	avzYPBvCXTVTTuXIfNR24IB2JFne01xersy8V28UJ1mMzXmz+ZYpvRv9wtj7L4+E
	vDGcHfIHmVcoyo8y1PkNDKc73YBAWq5xMfbToq7AYyGLxt6yP0fprHjV7KOCQ4cE
	MVbEcqtEcjktnzXj42wjqluuU1oK5ICVGnmPsKFCLGysul+qWtuq+/P3H7RY+AR6
	sckwqFLdTM3Q7oAFMOdch9zgWNMmQQ+ZiWgaIVP6wyFUBQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mvfht01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 05:01:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88888397482so87173256d6.1
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 21:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766293281; x=1766898081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gg/igCHGddmXF3t2QB24Ayk9sySh3OwVkPubaBg3Oxg=;
        b=WMxYSGbQE7JXGPXubTcL3qH8niju8EhLFD5exYQaOBhGf085IHIDsg3+Cp1ei3B+LE
         55Fzt2gn1/Yxyxmm70/nRcNYWNOXucmhJg24zDogaGSDoCg3L3lYHmEr0YY+38XfQ7PC
         mmeHyHK0ALFEyTGmuXH/BfmwVKt4m+hMom9SGTzzEFxhj73XiI2Qyczi6PLOVO1Ds+P3
         yvTJwmScpNK4tyOZoi9nFdwNy6aY4V+Nda8D8e+4JzxCuLb9Oy79vALB45mKbyTjIXBi
         xq8GRnvnDGbBTe3b8sTc4UUVDyzidMcZzjz84ouP0WsqGN9jjZxzPxsN7iZTTr6uYCvE
         Fi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766293281; x=1766898081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg/igCHGddmXF3t2QB24Ayk9sySh3OwVkPubaBg3Oxg=;
        b=MNIDarZrqI7iAXhNhPy5U1DGS1BMG9xPAm20diJWbVgSOEG70MV3MHWUdYfz60GdsR
         ig2mvtAQnmkcHZCwsZDNUU+NnvukjWxg27gENdaOOCLIc9wKjQCpUC15V6mBolz6nSsF
         SseMlujnVDMwveClc2NT0cDAgMxRw+tAa5RA2hem4ovXZFRMRW34keL0G8cy3+4TSRMp
         GJSyoCDCc9uDIps9RJa/ldFFfptDEakaVnLemiRPnOISScLLLMoY/aharjIWAl/tKXR9
         esKCK6kvgyDpYhn7+bROOl+txPNGiR26fHbxHamDWJkFvCbe959GyOpfLqNzt82N+0Ds
         QS6g==
X-Forwarded-Encrypted: i=1; AJvYcCV5wafT7wQd+mrg5di3bB/suLU1AovKO224o3NGg4ceoI7IahPW2HoQR7xJwmUP9Wg7aIy+GYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVjHlRHd4K4uDTyyYqwe74H0oLe/pIWHGMZv0bVLI5tM3sn4x
	vJXNZvGkDiIro3uG1C+bMcD5mCq+sMLmnuahEZTVhxZ4SoMYjyNRQqPSRKjw+lM8nUZHoT2uFGd
	v8zH2TGdFZNto3BJD+9alsmVtoapxgZUnt2K72JH93BEqiDgfytevej20/Nk=
X-Gm-Gg: AY/fxX4DeVpT6Nz4qLRaz84swbbo4Zdw5GVn4PnEyBarotOCNove8/kI34NC5uGgxyK
	7HaJoEVIv9PxT/E5wxcmKFAPkhGtLU70Duaj28KSUI0RGyroo3mGwSh0Kgd+4K2xH8biqksUBjB
	ijU2LSUgzIEJINRQ6hcfc2J8CsOrBfzJV2qSYe2rOUxmDnr02cOZyABToE3oTNXuIiX1raaOHYv
	tKbIY2zZnlAE76BsS2jf1bQhXuAeCDbIZyVX99AuEWY+ezH037JA7JDS8dI9C0EutzGcns5NYJb
	1b/TZjvmVngwIw+dwFTeBYqAkUY/lCI1YQFUIFoqh3Hj7KQKt8vB7ciSGuOPe2RWYwox05uWJqL
	SsjvIA10f560oW2+MdND0ugUUwJzyN+N3ykTh7xVbopgeWnM9MZiwhot3O2U8YBETHWf9ipI/Hq
	vOqhP8bthyAH7kidGZEps+hbk=
X-Received: by 2002:a05:6214:4413:b0:88a:2e5a:261b with SMTP id 6a1803df08f44-88d8369eaf5mr118232206d6.41.1766293280930;
        Sat, 20 Dec 2025 21:01:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPp5cBRlRTRCcuu26i8vacBZiOXfb8ihvUUlU/SG7YOw0ALSZVP73w1KaKm9VvKFnoviFo3A==
X-Received: by 2002:a05:6214:4413:b0:88a:2e5a:261b with SMTP id 6a1803df08f44-88d8369eaf5mr118232016d6.41.1766293280462;
        Sat, 20 Dec 2025 21:01:20 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5e5csm2059684e87.15.2025.12.20.21.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 21:01:18 -0800 (PST)
Date: Sun, 21 Dec 2025 07:01:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: qcom-pm8xxx: fix OF populate on driver rebind
Message-ID: <saptquofele5jd764hkqzq7s6vhsu2427nw2jtm7h5uswf6asu@dvrhg5dekuyd>
References: <20251219110947.24101-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219110947.24101-1-johan@kernel.org>
X-Authority-Analysis: v=2.4 cv=H8rWAuYi c=1 sm=1 tr=0 ts=69477f21 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wTlNtMXEErMED71dkKYA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: _mPTJHWRVFjXFdjcQmL4CtYeZsloinzn
X-Proofpoint-GUID: _mPTJHWRVFjXFdjcQmL4CtYeZsloinzn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDA0MyBTYWx0ZWRfX6h26gY8d2V+Z
 re6vrhR6aSPHToJvlvXGWiV7wecbP1z0w6eqIXXgp1BlAhFw6VVyat0BxZbiqHNyhKqF3RAZjqu
 l9rDfEkS55RQNuKuiuolmW7R1LmwCbzmK4aenHmJu/qLJrNrqbO1WLH9cRuYxZ02DxBk8LTRByg
 n36egFZSu49bCpZvGuk29C9oqwwIwAMVeoJDsyNQ6gxogiB6VFrdFqlewSBkrYPxUgC6dy8DmP5
 bIdKF/Gpvr34vyz55E2fWn18nDOr47iI/2g1K8RfU2qzapAt7qtCPABjFgUoUCkkJwf3mfLq7aw
 ddXdRA+P/2HPpfI/SZe9mywnpcYlM8q6oC8hzC5FIIu9UWxJFtl3H4of5p9H4rE4jV/8bFz+goH
 ojAaC8xpipA30kTqhmJas5iCnhaQnSm0DR6vp6RRKvw9Hj12l2px8ngWsvYcZMsH9ArcfrednTz
 9EXfs6z5FsDDGZVP5dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_01,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512210043

On Fri, Dec 19, 2025 at 12:09:47PM +0100, Johan Hovold wrote:
> Since commit c6e126de43e7 ("of: Keep track of populated platform
> devices") child devices will not be created by of_platform_populate()
> if the devices had previously been deregistered individually so that the
> OF_POPULATED flag is still set in the corresponding OF nodes.
> 
> Switch to using of_platform_depopulate() instead of open coding so that
> the child devices are created if the driver is rebound.
> 
> Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
> Cc: stable@vger.kernel.org	# 3.16
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mfd/qcom-pm8xxx.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

