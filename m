Return-Path: <stable+bounces-210460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B1ED3C2DF
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 192174E4286
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB33B9617;
	Tue, 20 Jan 2026 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9qhOQ8S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BfS2X7Qf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2573ACF12
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899219; cv=none; b=Ow8JNix7d3EoZsgemyxHssv87Hz/+ggPlKZMr9q4X6jWNnUfsjxo1RoTABza2asVTco6rKylztzLdfvpQkIIw+dGFy1cdcxE5o7IJysW6GA5xpvbiXMoqjY8mO5yfZ8IA1sr2DoeISOz3rkfsdAffmRyvJPVl7x+CAN6CmfRq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899219; c=relaxed/simple;
	bh=35oCgRYewlLF7r+7miyyM/NplHCSsA5uaSuseddiX/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWKllUBwygsmuN4vN7Zy73DTPBZZ2vEFhKqIROst/iZVlA9Nx/iUhUqP/Y51eb0soKnlIimXh+R7JBNdmpzoHcHoYh+PtJl5jaMXhR1yLc4/7vCv0DnMOwmIf9izUOTR8Szh6o+BjWhYUn/ldhx0m6TFD/31itD4uV3Esx3lx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f9qhOQ8S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BfS2X7Qf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K2P53E1347305
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 08:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FYhJZQan6/u5rTHnxfefDLYGgT4XhuJFOEiXCmuCZCY=; b=f9qhOQ8SMuY40Fiq
	hnFEOEZ4/z7TLuP36eNJnu/gWG12UsvMZ0bcZhVatY8RWCcvrEKjT3pwa53dZ+lw
	F2rNd6cuM2IfVE9zzvi4wwg1/+VS8yRaGwEzK3OibRVYbGoi5A8YK5dqSwZj99fo
	BeZfNhOwbB5+O8SGOJF4aDY7XJgN1OmoYXnBs6jZXtQwT/ViaMqu3mWdcVxSUonc
	wJevZU2C5YJJO4yqtuLyouG4lxdw2zl7YGup3Z8C7KFhO1cr8mwqO2JHDJKt2bPQ
	wLKmVI0l9pK5R9vhpFlTIh/NjGh6vHyUBd6b+5Bybp+SFPK0b90n9COG12rT3Euq
	rVQRYQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsnpdjkhs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 08:53:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a291e7faso738414985a.3
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 00:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768899217; x=1769504017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYhJZQan6/u5rTHnxfefDLYGgT4XhuJFOEiXCmuCZCY=;
        b=BfS2X7QfC2mjJoLW2v1JIHRmGjFFM76qGvwZqR3qpG/sjFOjJzEZO+9fzKkQzOpwbq
         BGuu/TX+qu6TodJ3wUeDzGXENkJ9Pha8BP3u37RS68GLUypI/c5La6VNi3sO2Z5iHOmN
         xW2d64mn33i/AAQwfKv04rt0ARk+QnwLidHDI3muUNMntZajSzY9+zfIzapk7dROyq5C
         0LRLo795HOrgbGNpCxSuYkcaCPZPbmKbTNQf7yM2zXoQJAXCzidZU46L1HwGNkMTWAw5
         hnosLIYSlhALO2OECf19RBIxQNa05+VetE8fOikkyZfz7As2J+npM5JxI+6lHIccHiXP
         dZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768899217; x=1769504017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FYhJZQan6/u5rTHnxfefDLYGgT4XhuJFOEiXCmuCZCY=;
        b=YFHlthEVVsXVnDQltyX9zCwvCEr2xkUAQhPlb2qQMMcYO920fNAeQ3vyiFYM5IxfT6
         RPw5H6g9405gWo1J9vtEyF1Q3QcMlN+rKyJn6Y1vWVXWX3LiUuCnbFd9gmNAuVPbeOnw
         YaRzPHgN5N7wG9MrasjoOAGfAuDhgDRlCGGJTo4UgNGbJPPfKI9nzGyXKwEtzxxOHLO5
         +hfJ6g0YbntNjOEni34k/KgT3DmdFP5MFqJ7w5tJSqFqdamg2z4LLJLD7YDqdxIh61ox
         ZNgqNUaFlG8cTTgfqBix2zCmAksesiN/lH+7BpWKGB2dc82l2BUfwslR2R+JmSejAcyk
         T8QA==
X-Forwarded-Encrypted: i=1; AJvYcCXt9XuE3G7KKnIiGGyDGcNosEQamA11Xrmcu3/7JmTYXqvRuKiT6MgtIJkvVmPCpLBtg/gfdN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3zKVejvFNO53IrzssoXrX0+ioxiAUnND23qAjn5MB1f2eFMN+
	lJXm/RS/i2vaAJTWlyOhKlNJ/bWQd+qxkppp1aCaG9xcrsKKFZWJaYAwnXkT8yz1Ope/lWy61/H
	r5gVn0yA/mwEiI+yDcAjROSTwtXBpr8yIQdOuHfuKtKhfMcNK/TRGWAjQzI0=
X-Gm-Gg: AY/fxX6Fs23v8UtN0EgN1PufVu0/vhullofaRpgjbb5Aj5e6Nrfm9USO6QuwNOXzhcp
	8g1si2EeSrRCXupfzmOV0Jl7QNS4VD1yV8L3QrbsxyEsDKBbq3CJM4mqa9CHwozhgih2mIdy7EY
	p0qw/8OIFCZ0oCM1sPOuAYMfXvMptl4CWac0dVBKu0SQZPkOPp/V1jRsL8NlzY2bZNy0d+GonpD
	eIJRF7uiNWpByIWbOYvyT8XUcPMRkQvN3JQJQMwpQtb6Jq6nzwiyZ5ya5n+qEzDN/yDaxAcvSJl
	/zyoYa2Y7W/gH/qJzO82CrdJZ6NZYbhBX3DKplbqIRk4OgMHbOixRGs8bupp6b3Ao9xnMoEaGxn
	b9n/XFeN92AEiuDZNSPqTHeSaAX59C5hbiMNZp0E=
X-Received: by 2002:a05:620a:2cc2:b0:8c5:2d4c:4f0e with SMTP id af79cd13be357-8c6a6909abemr1458361785a.25.1768899216769;
        Tue, 20 Jan 2026 00:53:36 -0800 (PST)
X-Received: by 2002:a05:620a:2cc2:b0:8c5:2d4c:4f0e with SMTP id af79cd13be357-8c6a6909abemr1458360885a.25.1768899216361;
        Tue, 20 Jan 2026 00:53:36 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dbd5:da08:1e47:d813])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe3b01csm104476035e9.5.2026.01.20.00.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:53:35 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: cdev: Fix resource leaks on errors in lineinfo_changed_notify()
Date: Tue, 20 Jan 2026 09:53:33 +0100
Message-ID: <176889921080.13004.4539872035214024062.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120030857.2144847-1-tzungbi@kernel.org>
References: <20260120030857.2144847-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NtncssdJ c=1 sm=1 tr=0 ts=696f4291 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=laS5qSSDnmk5FH6KhN8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: kTSZuYY2LZfepZsTpc17xklUFZRaWtNM
X-Proofpoint-ORIG-GUID: kTSZuYY2LZfepZsTpc17xklUFZRaWtNM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA3MyBTYWx0ZWRfX0U8myDN2g7RG
 OSi9Cwf52fzkOd3LzkCTM2Y1k6wbavwiztYKmTwycptL8Ebgyo2ZViyNzbrXrAUS8otgiIcEpj2
 6FoQYQGb7Vm1459jVjfBDx50OvhGr312x+rfbyrRBOHUpaOo2jJK7oHn/Yt/5GYycvHTc86OyF6
 HySr3BSWRW2k7Z0h0rzALIEQ69nJ7RE0nyeBeE33GE3JiYSacAkJqiN7RHqvf+05GaAw12tG1IZ
 BzOvSWrj0eTd7ODQle0/Us6LwAd/usMW8eAb8RiGa7qevpRxIszsXByRr3K0ZPmqsrNkfyK8XgF
 M4r/Kd1pfy1QCcQF/4SsLJbdEkqJxKmX7G2xU1pSa7p6uxzFVE2WohF+72CPoi/xrGsWvY/NAss
 QrmfMkUHTM9EB6EWbDcH8XmYy4Dsf6SCZvuDvXOWMpuwpJNhOvM84731bcfR3LowE9CWIrMQT5k
 mtJ0CJqU6My+w4aPLyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200073


On Tue, 20 Jan 2026 03:08:56 +0000, Tzung-Bi Shih wrote:
> On error handling paths, lineinfo_changed_notify() doesn't free the
> allocated resources which results leaks.  Fix it.
> 
> 

Applied, thanks!

[1/1] gpiolib: cdev: Fix resource leaks on errors in lineinfo_changed_notify()
      commit: 70b3c280533167749a8f740acaa8ef720f78f984

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

