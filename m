Return-Path: <stable+bounces-203024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DDCCD5A7
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 20:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D0930819D9
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 19:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65633064C;
	Thu, 18 Dec 2025 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIC5h6JW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KFszxHMJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B732AAD2
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766085008; cv=none; b=HnNfVbmknQJj7ApIrZCvxtO0RBgfUzNkuSOyQNf7M2l3/vAPR3+Cu4iR6JfX6b+nWdc1MKQqwGFkRgmb80hr4n0Q25JDprco4TF4pOrxvZ9996XKVvvpN67kaIvJlLPyTTlebsYtHTUoVlSEb0iW0lY3PEV6LEvBdvGT9ZgZkeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766085008; c=relaxed/simple;
	bh=dIw8j365ikKyDlsgwjx4WaIiStWEnX4+clh7heSJnj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxGDaHvBBzQZjxLfgnpefj7AdoqmZwPtfsxMxY8+/q+k7gM9NvCiDXCqsfDanNCVGrErE16tKe0SwtMIFWM8QhDSTExHlHK371EmsApryV8KZn8XzYhxfs+L4Vlnp0MMiBkT2kic4UFKNse409YqDelx82yGHT6vu2sIRU7wPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIC5h6JW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KFszxHMJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIAGC8k756564
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 19:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dIw8j365ikKyDlsgwjx4WaIiStWEnX4+clh7heSJnj8=; b=DIC5h6JWngJRQiGO
	4a3tmpai3afMojQofFnHVDy3lNKG6BpZGEUzjmcp/bpe8UaN35zK+SPt5D/GO06E
	4ABE1JP940T2DYzfqgEtNUcI7hnyXEpArjvRgANwTV489DM4qv7YGPvynME79vj3
	Cxc/e2h3UtZMqPbr+1sFIU69sYcVBo8zLjhTk2qml3gR4yvc0HIFxWQIbP4B/KOO
	AShzwNTyQQPr5ZiODW8O72sR913m4eszaGMLaEU6o6sNSEVoc2FA9WphrjVFKDZF
	aTFjkkVZOicAJHjBiiBeHgIpLFpkY8EjO5SJv9lanMvDo6gV2dLohtyqR+cwNXcr
	eT4GgA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b49v0ttxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 19:10:05 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-888825e6423so20055136d6.3
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 11:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766085005; x=1766689805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIw8j365ikKyDlsgwjx4WaIiStWEnX4+clh7heSJnj8=;
        b=KFszxHMJKLzABY8vwHPkPhAPIxERm1OagH4ZYOQucg0CPj4Hig18MU9csMnCCrTp6X
         EhiaUgDAYUqZtAgiIbz7jiixQfWVQDoVF/laJ//BERKF5zKfjIp36Pdmlxp02D86uzgx
         Hf3kXQn14gfEvsGjqteSBfeNxx5yURoXRf/K25ZPXfWolPTEA/u86Y53DseJGEPIeKhA
         W9JAeA6IGLrMlPNUDaI8wC5gANqDyGcC+hGsHtMOCtupjbhwB2CqU1DAs/aPDNCP7Q0G
         GevIzScJKMNESDBPFvSkGqG5ME0zeXaRwidQsVQaQ+DEKGebYNPSF0FkPelG6AwY/rQH
         Gdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766085005; x=1766689805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dIw8j365ikKyDlsgwjx4WaIiStWEnX4+clh7heSJnj8=;
        b=B6sU+eMWowoxRapHdwGUwq4suPWLMh4RyjLW/D5p9QzItasXRdNxiTjIjSiFYhj3Gf
         7LiTIhTAeq0bqSdyrgRZenXF+a0YKvR9a3YU3S2MzZmOpvDaK7mQig2BSh5BRnNeJ88c
         l8gh6uykaRvl9+bXUGtlW5o+WEUd3d5i5o9rxrBHdm+2iKjpPsz+HxeajLwE4wZIx19j
         4hbkj+Ze99rrMbR+nbRq90hjB7rBt0uSQY7GaRbaIPVawm9CDdtnEVwkvmuvEagn5TVB
         w0lAgIbKCS71xlt8QHdES8l/MKD1mrdm3OPfWxgWY44GxOxTS9Wx4MvcQdEbmXnI2cyZ
         1Q/A==
X-Forwarded-Encrypted: i=1; AJvYcCXAN/+nZfDOk2H1kXV8ghu4fTUbafbE2UyarQ22wWYgK6KhwNGNw15aUT0a1IZwYdOw5b4DGz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvHd34cZVKw8mACdvo9jLj7GHRMHvinjYamhsqphj9YKAFv8h
	MIPKvIUl6cf2wcerCVXSsQ6EgMEs2F7ajfhot19YwlPDL8EtR91kKO3Y/h/vlQneM8x8Vb8FvU6
	FeWmD5U8ouBxejnb1Tr02GyaMURgkhI4jBLmiUciuozF66i5vqN7JjTcp3qCsBGlkjMMNXNXpqK
	C8DwqP8119GPIWE9tHWE2DAfW3MvBRNCJygw==
X-Gm-Gg: AY/fxX6aE6X2wtn890UMlkAMdmsnm58z+sGj0Xr3i3LZ5SpOxN42IUNYQAFvkhi+KXL
	aR6+4YPapyrcYoVaNfFBGzFHp8PkluU9JPB6y3qgRAXJXGfOWqNCZITWou6cakn1dCxhT4SF25p
	hWMrhfGnkslPRjRP4QeEl7WeHDgLdQRMiHdr5JHQf3KbUx8/SnbEVjUHxfE5KB0yuhTu1wAfsCz
	U3BBEhq9CkQP/b8ga+9YBM/39E=
X-Received: by 2002:a05:6214:5903:b0:88a:32db:ca2e with SMTP id 6a1803df08f44-88d8859d814mr11385756d6.66.1766085004830;
        Thu, 18 Dec 2025 11:10:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElTYAdoPhfH6LxXjgHHJuq9GB+MaXPuKPdY6tm4KOAmStZEaNhs0H2TbaWVu8vQa2PTPIgBrIHJI1918I+nRU=
X-Received: by 2002:a05:6214:5903:b0:88a:32db:ca2e with SMTP id
 6a1803df08f44-88d8859d814mr11385106d6.66.1766085004406; Thu, 18 Dec 2025
 11:10:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com> <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
In-Reply-To: <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 20:09:53 +0100
X-Gm-Features: AQt7F2r9lOf3zDCFBlKxs8sdhKMbeErBZkq0-ox7XPW2t1SLGzCNcjhrK8xkLWc
Message-ID: <CAFEp6-3mHFYFPS=iakDyWUknDH8z4qOaHwFLuP=Qz1PvYSL_XA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: qrtr: Drop the MHI auto_queue feature for
 IPCR DL channels
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxim Kochetkov <fido_max@inbox.ru>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        netdev@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -jRVut4wbBNPeQRpddgGJIKDLRT_vFhx
X-Authority-Analysis: v=2.4 cv=Q/HfIo2a c=1 sm=1 tr=0 ts=6944518d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=isMaZ9OHK7bkWVW8W2QA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=xwnAI6pc5liRhupp6brZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -jRVut4wbBNPeQRpddgGJIKDLRT_vFhx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE1OCBTYWx0ZWRfX9DgYnzhNc0nR
 OtE+LvTUboNO9Z4jeD4rZmW/KwlaV43RGlzfj+NbKp0jK2bnL1jGBmqQNX+WaV9rk2Kmckv3nSH
 dl13Av8Fjir/9qy8QcD7uCTBlwh6PJiRwPJ533eHy9m1PckW6Kqy5Sy6o77/D+1vGf+OGVlh00x
 1tFINKHhsUar6lx3/ycAR2/yolBW5269c4FB5NgkoSH3iRBU7gzEG5wzeAWy+yslnD3XSXgAS0T
 lWJ54xh2MFs3RS0KgXMcic67tVYY2kB5ybwRIPqWYzd7thKV021S9gWTpUyEZCSHXHN3TEtzPMb
 60Jiprw7y6CuqPGbZEX4hY5WCFQV0ElxSG2rZjXWFjqQCwVLi1ThJcZ7bEKY3jMa7dOMxvjBJHj
 fsoEaKcfJLI3BJ2KuBR4eMiBqSxWWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180158

On Thu, Dec 18, 2025 at 5:51=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
> auto queue the buffers for the RX path (DL channel). Though this feature
> simplifies the client driver design, it introduces race between the clien=
t
> drivers and the MHI stack. For instance, with auto_queue, the 'dl_callbac=
k'
> for the DL channel may get called before the client driver is fully probe=
d.
> This means, by the time the dl_callback gets called, the client driver's
> structures might not be initialized, leading to NULL ptr dereference.
>
> Currently, the drivers have to workaround this issue by initializing the
> internal structures before calling mhi_prepare_for_transfer_autoqueue().
> But even so, there is a chance that the client driver's internal code pat=
h
> may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() i=
s
> called, leading to similar NULL ptr dereference. This issue has been
> reported on the Qcom X1E80100 CRD machines affecting boot.
>
> So to properly fix all these races, drop the MHI 'auto_queue' feature
> altogether and let the client driver (QRTR) manage the RX buffers manuall=
y.
> In the QRTR driver, queue the RX buffers based on the ring length during
> probe and recycle the buffers in 'dl_callback' once they are consumed. Th=
is
> also warrants removing the setting of 'auto_queue' flag from controller
> drivers.
>
> Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
> So only the QRTR client driver requires the modification.
>
> Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffer=
s for DL channel")
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation=
")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldcons=
ulting.com
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/.=
..
> Cc: stable@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

