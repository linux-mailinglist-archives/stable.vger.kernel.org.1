Return-Path: <stable+bounces-200132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8ECA714F
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 11:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 258CD36B4B1B
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A13081D7;
	Fri,  5 Dec 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFuh0Fhf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ev02OXpH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F430E0C3
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923599; cv=none; b=Owg7f0gjr9YdMjl9hRA8XVp8EXKjIxxXJUFjYmteRnlFFCVQW3UHC50ZLBHKLxthHLAquOK0BfzPxzy97IZkYy5tNecKxojd4NVTRiOmrOMlxBk8faXTLlBYLOFmSu5qpV4KINsnaq3GCj9kUYhDgLquvlal8OlsaW4uqkeuLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923599; c=relaxed/simple;
	bh=MMGuL1vI04W6tUU6AIQeCC2kd4KIozOfeyw6PVUXtuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5+GTP1pwfehYpPKGPjclLRMqMLlt1iJlDakDS0p43vEE2FpLodq/E4YDzjsM4z3mIFfcsQXzgQOfTt8rzAJZxYNPADHiKZDdoLD0Jg4qBY2epDjpFHSinG4rVZOqS0jWmZzb74LlLcJaUmav9pp5/AMLEXIU5oLbp6Y5Npd5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFuh0Fhf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ev02OXpH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B52ec393172949
	for <stable@vger.kernel.org>; Fri, 5 Dec 2025 08:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eC5PNHDlygWpLQKznc8XPdUOqSVo8sJKvA6Tip9r02k=; b=IFuh0FhfJPqL8HrP
	FMH6mppvIXUjzkVH7RZozpfq+T9A8IkOZn9bNmLXdrNuMMXcXPhkCKMQ5zX+LW1z
	78oy9wnBQxV8nPl+8kSvsqQ2rhVUPgHRn5Mm5iQrmd+C6nydbdlj2mniAJgFw4V6
	Nk9FnnW9Ok5KULmUFVwDmTjpyQ955MtGw5fXlR2XOFCsrH/iNfaNT1/HnGVY6ktO
	1fjUzfaHShwR8HQcr7G0wohl2a54pQvKRztw0bA9W2Gbi8LTZfhNsx65U/OsSZSb
	p6W5cBRItMgZTNW1B9LQOtTfHVbDDQbVJS+T1/4KcT0Bb5WtDPiQWfw8hYIWyq9t
	msFeGw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auptqruc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 05 Dec 2025 08:33:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2657cfcdaso243120685a.3
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 00:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764923591; x=1765528391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC5PNHDlygWpLQKznc8XPdUOqSVo8sJKvA6Tip9r02k=;
        b=Ev02OXpHHA0Kt4CLevsy84+c8DQBS/HPONfzsJlPajUS5LAxFiyswQusK/TDDE+Yh6
         Xgk9UuPTNb7SYsYaPYMN27MuQDKVUMM/unw5cVGWRk04g7o90otL2T3WXxvXvxRQWMTs
         EdcfLyexvtKMGGIOihJq8B5ZMZj7+hBu26gDGxvMWTjl+lUWPCmV2fqzfJwnIJVA9nHu
         pOzZPWf2HzGBj5/XYiAywaARUBq9pSJprUwKBdu9zZWAhtXTVzzpspAqZ/oESMZtvZAL
         xtFWaUoEchv43pQrDkfKT9bA+pDOVj1ExyIRabdyBFMfj89dgOUJnUPrSufISXTrk08O
         lYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764923591; x=1765528391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eC5PNHDlygWpLQKznc8XPdUOqSVo8sJKvA6Tip9r02k=;
        b=cdgOwbbilm9Wi6npy00YMY6aPOHnU0+woE9XYwZiCffczAUQ1qfBOB3Qxj7IbR0e+L
         D0HnbfDJh63t95t33b7TxyQ37aLgTMaryIlCwqcOVNjtEh9S96s0Vu9jm165zJg7BngI
         S3ZTmF9pPv6A9BU3Ds0GzcUJ/9xljZW4lyAw5ZF0GRtx8tA4TJ6VzJ/zZ9eTJ/MFYrC/
         9JgM4qpv316CRArx80+PLsJK/j8jCZednWwgK/udRWb7aBABkuqrNFPGL6whscUX7BPE
         ExMuKbadjNbrd9V7pqhx+gjLKnmOqeqqK8QtEI5CqPTl+LmWajHS3EwxDLjB/dtBevx8
         dSXg==
X-Forwarded-Encrypted: i=1; AJvYcCVEWG6rVi6F40kaIq5JpE4heu7gvM3d9eN83tVZKwiQ/R5oyobrswo/1l5FSfMGbTb5KYfPUs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUsXWaCcXUzhXNtfMh56zlC/dt+U+i37r2U8kjVgcrf00tJq1
	K7GV4if7Cch+NmMdhISddioNsEasy4OkCZl7gd0Ntf8cPAQ5a7zKYvBhT9jVZ9TPyUrQoGNfLok
	ThZzjqj/P+MOju2wLxT+1HdbPSF7RfqcCBKDXvU0AJRjFGpO8uvFlr/0rW8k=
X-Gm-Gg: ASbGncuMO5S1520LcQM5yz98bu08bTry9emIQzue1nAlabUbGjSuQ9XE+bZNfhLMCWz
	5T/KxzA7AZVBrKHTWsMRvK7xPw+VLK2+FKkfqmEymyAZDw32rjGzGkhExosf1Mc97togToCyiBE
	lUwq/mxTQvVVzpVicJeFNeTQlQJ5L83sjdkfLqq34fDQEzIOvPTmnLItgUQdy1nbQxy0FstA/9H
	2678qCs472JHVeC8qtaCDbnW0N4/7boZhbQZmusi1n1Zf7uBV/qlMjHXM1C2PWdsipg/tbnFmgt
	Mwh2mJ+4BNj0n66kER/ep7Tcc22xFeCmNJVeuWSpcRfqVtA1fFTg51HvbsvnFS7c+0H6BCEcVbA
	640fQfnRhKw4txF2US5eS550Y2+Yin+IU
X-Received: by 2002:a05:620a:408d:b0:8b1:1585:225d with SMTP id af79cd13be357-8b61822c8ddmr761339485a.82.1764923590862;
        Fri, 05 Dec 2025 00:33:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvCTznjuLTd687VjM6qtxYI9yUJOjuyMNTDmIuSFHO+nw/t8MIdWeZTeXTyfuTr7AAid7ttA==
X-Received: by 2002:a05:620a:408d:b0:8b1:1585:225d with SMTP id af79cd13be357-8b61822c8ddmr761337285a.82.1764923590357;
        Fri, 05 Dec 2025 00:33:10 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:53a3:2e30:5d7:1bde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310b693csm69356755e9.4.2025.12.05.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 00:33:09 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: brgl@kernel.org, Wentao Guan <guanwentao@uniontech.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        andriy.shevchenko@linux.intel.com, mathieu.dubois-briand@bootlin.com,
        ioana.ciornei@nxp.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
        niecheng1@uniontech.com, stable@vger.kernel.org,
        WangYuli <wangyl5933@chinaunicom.cn>
Subject: Re: [PATCH v3] gpio: regmap: Fix memleak in gpio_remap_register
Date: Fri,  5 Dec 2025 09:33:08 +0100
Message-ID: <176492353839.12178.12868945450381013529.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204101303.30353-1-guanwentao@uniontech.com>
References: <20251204101303.30353-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: geUMu5n-ueJEmSQ3JZleAHSSt4BiX0aI
X-Proofpoint-ORIG-GUID: geUMu5n-ueJEmSQ3JZleAHSSt4BiX0aI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2MCBTYWx0ZWRfXzaceCbHvYBJ8
 ab2MkGQlkRjCWTAXn/WV+UvktQ9kU+O8IaOVLjpBnFQ53JhsON9r5+fjtgJhkNtmn74Xfjbu4lV
 q5E4ejAYCa0loJJensfyhQ0vuD3CaDHcIIDPbkm0ql/uRtD0BtZWZTsJqhMReJvGIujNMGMQz1L
 e1xnnlC5QlPn7NVeeNO6EQEBB0fskyfyP3O9nTBqaLC5JdKpHf9NWM6ZUK2wOcd2PjL2+r8mS9x
 pxPp/uYAw8LLbQr8KEYS69S+tzuU45BskwEOayYGwOO3B9PiNoOjZFPZQfDASGZMRizWxUHNPTS
 Q6PUYRJTwyL7Keg6umwY8vcuvAbAZrPUxnB67Cqda1ZW81xjHdSBkJSd6nNOUd76NB9ZBxnHvlv
 PTVHhfK0VyN+FZQGw1mwjxQ9tBpxbw==
X-Authority-Analysis: v=2.4 cv=fKQ0HJae c=1 sm=1 tr=0 ts=693298c7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vzvxVwKKtc5QML-hEyEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050060


On Thu, 04 Dec 2025 18:13:04 +0800, Wentao Guan wrote:
> We should call gpiochip_remove(chip) to free the resource
> alloced by gpiochip_add_data(chip, gpio) after the err path.
> 
> 

Fixed typos, reworked the commit message and queued for fixes.

[1/1] gpio: regmap: Fix memleak in gpio_remap_register
      https://git.kernel.org/brgl/linux/c/52721cfc78c76b09c66e092b52617006390ae96a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

