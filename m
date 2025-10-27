Return-Path: <stable+bounces-190583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AE8C10885
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B791A26417
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502132144F;
	Mon, 27 Oct 2025 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjzegyG6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AEC329C64
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591668; cv=none; b=HwO8m2APvM3t7B2EDAe4q3jIQMZnh8ADj/kgRpJ5a6aWYe0YI83zrzHf+YiO+hkQ6pJo2prp+0TUHN86M5GI5fPpnVXKa02nQphOdU8TY6arL0/i0NVeC135UQILjfGUCAy36QKFJk96QlghSQji+U5vzi0GaZ9bOM+ntNu3ZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591668; c=relaxed/simple;
	bh=Mz7YuFINXQdC8PQ/VfexV55itQAo7KBzkvth7iSvNrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Efn6Tw1ZTjm6O5wOrGwTEb1IxlhDg0ZzCaJbYl1A8lIsvCUL7+dIq2j1WpwaXtAnrlgIT6Mr/Hryq13cY4zvPOa5YT6l42mEuvmqo5Mzz9m66ECiGpZEGhuRS3oeOEfDuX344Aj4sfL1HbBC3TSZ/WdTbuuOtSR7z73A5YwvMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjzegyG6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RG3AOv3165408
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 19:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmMsFA2jU2VzFA+RPyDjMpvUmFS+NJmtomscpMRHH4Y=; b=BjzegyG6B4d99ikO
	FG0IQn7Rz/gN3Qp/83Wt79hAbI1OvCMzNFnmW0d14ZzgtzcVTQWoZ6SPg8UuFYbP
	1k7umAqOHxuF04tYXikaTsuV1p9ReW+cXQeAgmtKPdwUZqERmxgpyQdSZ0UIMk5P
	ABbB0DjA1XGQGCVb8enB79lQZ3UqkIcntZGIt8wNLQz8UvqI60cObZs0MUVCS1pW
	9w4xm/pFgO0YegFK0JnXCAnSZxSVdXbBXy0r3bY9zlrKVxg7eo12gH+wC2799nkq
	MwnjZXna1gDCtUwsBr1birZ2HtJq0lqERyxP8b9HneH7GxWqZXBKliNvcj4+ovWJ
	DmPRbw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2bwx0gj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 19:01:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290b13e3ac0so43659475ad.0
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761591665; x=1762196465;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmMsFA2jU2VzFA+RPyDjMpvUmFS+NJmtomscpMRHH4Y=;
        b=J9+IA4Ie62Fv6Ajgox6fEW6qhecgkPrZ+bVyWlbDlR32GSYPncx/dzvwdLPrBCcyfL
         fWRkDtHRT/ceWpJM7vn21KHL5105qfcKO62sf8PsG+w3tAJhI/cYQqNcoNpOuAKxAuKR
         fYszjskS28drTIGwX1zyLmKxCdLJRiRMbXTrqxrgk7P8Lky5ms6BbepC8S7LqCuqIsR0
         3cnjE9mADMMlDKSgwRaHEP1iRFpT8HX0SQ21gWUyzy79FkYdhz/9M6+RGN0Dr8459BiG
         6nJE+F4km9efkhZAdjUJVfGn+MMbD6ZE/1dUNENjgQjQRVxTOG7Be8FCSAzrZpkRwIbQ
         H0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM7ucwMpZrVKAvVko/gWAJPUrkAvSp7XElDuYeG6JnBvlR6K07DrC2aSLTLwBA99x4/tXezX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycuvOWqv7Ql4VIBR05DZUM0lBoveRuFcHsEF2BxD+4sSgJmCej
	Q0O4PLOgtRj1z/dd/bWeEsyVuenQ2VHDEpQPafZbDEdL61HjzbsuCk2p7n2Q9j4/SRT87fYyuxv
	VVZ+3izRSSFSVN33Mt3as8aaG2fV9dwXrZNNWqUIIpVbdV3oGLfuaQyENonLLd6pfGpg=
X-Gm-Gg: ASbGnctJ6XUYxeHi3eU1belpF8chns14SqA+tW/8uwYJ2Fz1bMfdoQruUuolW+UQI55
	vTQhDue5/+UP0vX8IDLSHc4JK6M9zedqWvnXVe4iyEDIOvs9qKCDIlMUVUz6gs1eNDnKmCsxyhy
	CFOdg+MFTOIyHr7YiJQ5gpMMIB+wM6aU+eh9/I78JmD++yDJyvHdxpZj2Ee+nk6b3cTeVnQ/dzE
	55Gt600QrEiWyPlTHWQNTEQXRIVp+FLKMZFj/Dh3sTibi5M5PvYE9/fB0wc10tw+BA+fjpi8Vku
	dfuWNZycrzAZJ6rdh+97yIZ3EY4Otru9u0oxWoKJYSam5ucinF1ijVIk2S4/tVH3omxsNp6z+LE
	Xe0+s5qFROSeJge+m9aUGgTs0Zcfb/Q7rAtgawYuxGBcIoRcmHL1kVbppzdjUCpS4786EQpk=
X-Received: by 2002:a17:902:d482:b0:290:6b30:fb3 with SMTP id d9443c01a7336-294cb3b2ab2mr9467585ad.16.1761591663073;
        Mon, 27 Oct 2025 12:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa0PkB75QxFvEfsC7xYqy7x0qo8EfT8w0TreDLE2SS3cxu+kF6KGO6YQnwKLzSUX3UTKUvDA==
X-Received: by 2002:a17:902:d482:b0:290:6b30:fb3 with SMTP id d9443c01a7336-294cb3b2ab2mr9466685ad.16.1761591662097;
        Mon, 27 Oct 2025 12:01:02 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm89694065ad.16.2025.10.27.12.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 12:01:01 -0700 (PDT)
Message-ID: <7f021277-2925-4fd1-a191-c7034d526e37@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 12:01:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 067/332] wifi: ath10k: avoid unnecessary wait for
 service ready message
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Paul Menzel <pmenzel@molgen.mpg.de>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Sasha Levin <sashal@kernel.org>
References: <20251027183524.611456697@linuxfoundation.org>
 <20251027183526.385879492@linuxfoundation.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251027183526.385879492@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE3NCBTYWx0ZWRfX5u2BnKgqXHuh
 38aFg+x8cYe21EjbgGS59HXWTX/vGMRuJCBpaDXbg544ueU2FSA6I4h4RufmY4Nfm87mb7WAeW+
 XcChrMUGotgFbpgk+D3gBAEol8CleDZUPNjWAO1x6DPnOuFl3lqaTq56SdE/zlcigKmU2fRhP0y
 zWxt3v2prHi8fkO8MdfubtGjWEjyj5XHEPRZ6846svbtmG3G1b31hCeb7Ab8LHaPP5Utk9/Mm/+
 DZCepQc7fR9u/2Ez46ImrmqkwyIbQ2NIJ95iLwc+msN6vr5tsO+psRfw1/qwzKYIHVfyCc+FUIm
 mp7Pujby5jJviAktmSqhakCm9jv+XtylAXw0IMWtXoCUPyIhhoz6FwzJf4aWQvC2V4wmxSfBzqB
 pFJaG/4491J6Tjc8+xs2oJEsuw7X9w==
X-Proofpoint-ORIG-GUID: zo3YbXLKjNOSJDJIOlJ07mZwkAH9ogMr
X-Authority-Analysis: v=2.4 cv=U9WfzOru c=1 sm=1 tr=0 ts=68ffc171 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=faGc5X2Oct-Rl-nflR4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: zo3YbXLKjNOSJDJIOlJ07mZwkAH9ogMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270174

On 10/27/2025 11:32 AM, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me know.

Same comments as 5.4
Please do not propagate this. This had adverse effects on some platforms and a
revert is already in the pipeline:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=ath-current&id=2469bb6a6af944755a7d7daf66be90f3b8decbf9

The revert should hopefully land in v6.18-rc4.

/jeff


