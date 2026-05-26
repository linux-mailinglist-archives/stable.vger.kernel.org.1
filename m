Return-Path: <stable+bounces-254277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIPsEnlbFWp7UgcAu9opvQ
	(envelope-from <stable+bounces-254277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:36:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F10415D2878
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6048E3025C68
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EA23CCA1D;
	Tue, 26 May 2026 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mhExxbV1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K91qW2uM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8413CCA12
	for <stable@vger.kernel.org>; Tue, 26 May 2026 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784478; cv=none; b=fw5Z01aGACaOHlYNVQUCvZJHehGZAsdJU1Og0iA0LH7gCtfVT/ZXKy6IS/Ul75q9eiAKpGGiMShArp1W+TIm1X94XGRoc3NiHgTA3HQL05CClRnNOO62OS1qN2oVOb3OQWQoeko3nuTDcBDlSEFgBkpaGDrgwedLcPJpUCvMh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784478; c=relaxed/simple;
	bh=V9aRg4gzHXQYQ76HkHPIB7aW2yTeFevIq1M8RFVJFJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVMkdyQeujuDGpQ1WT21yeP7Io5fEU7Z+fnMsI/msoXWYBmWHwhw2D3P9fNW/MMbXIaAaKt36PAd1N5yC2nQUnZk22yN/EFnag8JYAuAbqW6CbQqyQA3OOKdelFZl1IYsxuN/ixC91Kp6mlWM72El+5oaSwo7+J2IIfFbZv5yGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mhExxbV1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K91qW2uM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q60kA41763808
	for <stable@vger.kernel.org>; Tue, 26 May 2026 08:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zLtm52xCHMgolWmU+VREzSCSuG7mN7RCpDTC3+MMjCE=; b=mhExxbV1C2mI4OWD
	4xO5bl6AdyaH+PeV60jS3utMFYflUVGXsjkaKgwmMe3BehyxvrexnoQue2GtRxtG
	9NssHFRktE2JbwuTdM9VtpQP59Yz6iYns2qxxsOU1J1NirOnkjnj26b45RIi4Aun
	rhAbLCe0tRWso4oMxgQb/0bq0YqXIdoS9ggm1mASo14hBJsAK1advOE8C3w57o0q
	zifCG2mBChknaLHGYyG1zZ7f3YSbJtigpYQEguLu0uZJXGrWA961wBtXY+hVu1KO
	LnAIpJLLPwdu3+7Zw1G+QXH8Cc0rmP67DCeC2VG2aCM5uvqx67iqt0zQJa18GVMC
	mQG3AQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5vggkr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 26 May 2026 08:34:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-514cbe73d00so287130731cf.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 01:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779784475; x=1780389275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLtm52xCHMgolWmU+VREzSCSuG7mN7RCpDTC3+MMjCE=;
        b=K91qW2uMoy/49mwdauT4PfbOd9xGI5vqzF2F0NCWU/3FkyoC0vVASb/OXGA5yGUE8c
         ddd82MSISq8G1AmZrZdxnemIuT6KW8wIthZwNCWByPrvwuMPk8sfQ6Xy6P/meYLhzujH
         roNxreHE3KSK9EwopZ/RpVjqFEnF8HSilwuQKtfH0Xjx4oADcCOihmm2R8NQ5QNdVlR2
         buySCBfmHUUPvyPjFhvcg4FIVmCS0KnwrnLE+bMe7gJxXIC/V+doy/+w1xflEdpvfB6g
         CV0/nHSxFIVl/8+gvrvamfYCKZW3S4lXa5RL59k+zbr4KM6mEFvFygFexuyu+kDBAh2L
         LTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779784475; x=1780389275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zLtm52xCHMgolWmU+VREzSCSuG7mN7RCpDTC3+MMjCE=;
        b=hEcHUMzBWskvjVbNPXKoFzecziG5wTg+n7AMwuptPDPP/puGH5ByvpZa9/gi1SV5u2
         zPUHJhVvARl8SpliVLcNrC586yQmDOmm7BLrnICPV2sOt/OLpS9adaQxO6XK7UIOiHsp
         SOIBSJfrfzNnVdxMnJEr3iauYaZrQ5V0l8jXdg9M+5gVYCLHLjKP0b2m5OCO6bCkF04O
         N3PnFMd6e3qmHCJPnroJhJggxrJRNE0RqcMH/ID/bFWEDil12HzCjt3fXNwRcL4FGMk6
         +OXWPvRnCf49vTQkevhDt2sibg3H3EmIBXfazA97tAtCKVcnQrl2CzsaVrxwnqsdoK2z
         PQTg==
X-Forwarded-Encrypted: i=1; AFNElJ9wq8iIwwbqvj1UF4E+SGSP4retObPLznqbrHktE7v5/jqlEGmTr0dvsf1aMxPNLriTJTUtivo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFtwYuHp6lYgWcf+VoLcfpUh8ZmN+zxQu2L8iA5BmxBLqje78f
	ZFDJEvz+TfSoEJ2mhk6x++tJc5kBmmNhi36cL4GtDF7CZyXleS3d/yUU5unEFZzxGJX5usHwob5
	cJzTvuU/2NcaGCGHdmwdFughYwrrAzojpNrdt4LBX82Lclo7id42uogVHNew=
X-Gm-Gg: Acq92OEdN5gdrLnKA+EOOOizpCsf8ziMW7ophTn6pztpPQSJWf4JlrkXZVgbrhSzJth
	xNj3th/jzHVLVMu+q0wNRAXUKCSM2DGynWR4z64VMoYvsYjRwDcTA8aXju8Ytgfb0YhvcIo9wO4
	Q6sECACAiles/ydKauWsyXGKNTFzGeTcHczfgkbHWl3Ur4BoRV12YKe3Co0GDdnblp7p3or3Qje
	MXAWqXz3qGYNM8b11Hr6VMsR9hM+gK4fyhsbIez5C2yyiAlCruAAhEj0QvBlN6Q5QeoA4Bfs8Jm
	hZ+8vVnahsu588RwDwEth4z+7iOIjIwvzfreVfAi0/HoQSwl5siSm6Ybxm/n98EySDTfFsN0A1o
	wte3V6XZEpyFonJaKNvn/9rXhVEhVO5kazpqOYWGcjAaa8o6y2A==
X-Received: by 2002:a05:622a:130a:b0:509:4406:44e0 with SMTP id d75a77b69052e-516d444f66cmr242436711cf.27.1779784475438;
        Tue, 26 May 2026 01:34:35 -0700 (PDT)
X-Received: by 2002:a05:622a:130a:b0:509:4406:44e0 with SMTP id d75a77b69052e-516d444f66cmr242436471cf.27.1779784474934;
        Tue, 26 May 2026 01:34:34 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:77fb:9b68:d26a:48e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49048c6acf8sm92904325e9.10.2026.05.26.01.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 01:34:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Marek Vasut <marex@nabladev.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] gpio: shared: undo the vote of the proxy on GPIO free
Date: Tue, 26 May 2026 10:34:22 +0200
Message-ID: <177978444193.19212.5319068808664522535.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522-gpio-shared-free-vote-v3-1-8a4fddc6bedb@oss.qualcomm.com>
References: <20260522-gpio-shared-free-vote-v3-1-8a4fddc6bedb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IrYutr/g c=1 sm=1 tr=0 ts=6a155b1c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=GL7bd0rghyH18HNIpw4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: yPHbGJ0QulxVM8nQX4kuw7Fnra5ghyK4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3MyBTYWx0ZWRfX/uWRNnIf9Wpz
 HND+fFBJB0xzTWgM8udpUmLWzmZ5KReOVNT1B/G7EiTeSrGqjUUcdSQC2IrcL7hjYyIhOhXdIrU
 OTumF5nsRC7fTco5RaKccm+jKeFPrEVa2G3QojodIaVVAYlIKN9KJ3TXdhVHpEMwQ0CAOBsdPV7
 I2+vMOXv2eXtk2Z7JgRQPcRWAcpkHkvtgWqm7a2xVMzvC4otd4EBWdYyuf4M/duE1MflP0d8ubh
 vatEYkBvYaXuuZ8xR5N7NlKPUGsCWwdePhXnAJok3dDgxRUZVM88tg8efFtRkdf5BGUSbgwdBt/
 vAGDrxgcdhyJK8DlOoV8RSVarpJeEd4UY7uo7eG3OILdlbGSvFOyNDyHQs0lFO0gnRO7rYhvtHx
 KiFUiEtMqKUch+IIn+cGQs3pVrUnSj36f83/ewAlCyelSWDTGvf1DtdoTLAhSB0LwwyeFpAJKWj
 Hf6VMQ0hHzxSaUu77Mg==
X-Proofpoint-GUID: yPHbGJ0QulxVM8nQX4kuw7Fnra5ghyK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-254277-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F10415D2878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 22 May 2026 09:49:35 +0200, Bartosz Golaszewski wrote:
> When the user of a shared GPIO managed by gpio-shared-proxy calls
> gpiod_put() to release it, we never undo the potential "vote" for
> driving the shared line "high". In the free() callback, check if this
> proxy voted for "high" and - if so - decrease the number of votes and
> potentially revert the value to low if this is the last user.
> 
> 
> [...]

Applied, thanks!

[1/1] gpio: shared: undo the vote of the proxy on GPIO free
      https://git.kernel.org/brgl/c/54c2855a8de1fe135df5c1baa953d8c4d68198d1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

