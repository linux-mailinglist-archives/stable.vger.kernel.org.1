Return-Path: <stable+bounces-249299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNFRCREdC2qiDgUAu9opvQ
	(envelope-from <stable+bounces-249299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:07:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297A56E51E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3CFD300FB04
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433AB492189;
	Mon, 18 May 2026 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VhqQMg9l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SlodVRAD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5449218E
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112461; cv=none; b=M9SwS1bHwm5yU2coy81owGSZkyll/TNMeEFCvVtGP/XtrejmGT8PPpEpZLtydLS+nNAzR0GIAJdq6SVnDSE/LWlv0kCZ7imL8+DQ65J7G2e3GgLuRJdyGHrUr8dKEJsim6x8k9SGkQOa4STyW8w1S1rjhNvsOczNIplWiXZCtcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112461; c=relaxed/simple;
	bh=S8LUC6eqSlTAsIldkCTjC/CsuP2MsarcViqYhls7uNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P/OGNp2BNCdMchF/8fLIEJi2gRsnzhNJ4CWZ+Vl4p7eArM07AU5GRhlDfdzlIcareTxBdxlTPMaJWiGbFPOfJkAu/X+NitMDJzuzId8MkqypwR88rJKnGfH6sadDrgz5DUN3M5rD6a9m3XSVwakFBiyQ4+QZ0HDbUXKvdY6JN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VhqQMg9l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SlodVRAD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IAorEF2083092
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wbs/00sIy0HRUS/VzxcZvFVipUwRNKU5yzSk8ZCe+Cw=; b=VhqQMg9l+Es1EhIP
	EQyDzcmaXqmpqTuJX+4NbcdHUvAZK/nEGHUYihhRScCfQAE6VarU+6Ef8XwYY0vp
	T1wVBxC5Epsd2mUPdb9Vk7ChQsdtDVKtqsFqMDg18n3TfhnM4JpVJ9nE9Vm5fgzk
	SHp90eMCsMM0Z5+Ke/UHExwltx45m1NadKA5Uxlfi0q4IvuQIqK17+Mt3guxTviD
	AcTkCFXXWsrP9/Jfd/rp34hpdGB6t6VLCDwP5S5ePw0S+obA4XwWHVJvMvlFAlsA
	GwnE5/xhmC/d85oIuO/lytCJB6Ow5yz74UzBM3yN060vSPDiwQlzXRNfK/J7XGyV
	dn2jBw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81ch8q32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:54:18 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-135405e4035so9607727c88.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112458; x=1779717258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbs/00sIy0HRUS/VzxcZvFVipUwRNKU5yzSk8ZCe+Cw=;
        b=SlodVRADrW03d/UubEi0WVycltvmEx0l9etOnttyN2oLGVSNuj5/PN+0V39hvjWINa
         Gs+KYHdvVCtjw6tftvhPmquTvYI7vHrAKSWIuveuxvKpG0CegYWW51eh5DePXy3MI+zX
         ikkPtR21PMpKwn7WVvyfluO5Xla69h/Wq9Dfn2vdrL77sIuKP3QZqucLSrwsZnDNmyLo
         t626mEq/qzgvdjiRURv5sdMqMLhQ6nQr0gWZLK7CYzb5sxD/a5rn787XCZL06srytbRD
         3AIeKzoPBhttRBTfhF1W9On8mPqd2f3MY+i7CUOQPhJC/9drhHfFQEK7bx4QQ8alJlvf
         JnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112458; x=1779717258;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbs/00sIy0HRUS/VzxcZvFVipUwRNKU5yzSk8ZCe+Cw=;
        b=AXZgB+bRMb3iXghvVSsTCC63KtvM59ghD4VGJJbMxZsLuRAQRsTT+ZgCatU0j1sDw4
         xEo9hbp22kYSIitbY2yu+7yahCkcPdWvCdke+bgh68qO+IJahm7x2L8YkIlGPczNoxH4
         X9MavToazGGfxjMxv5UptVo0LXUwnlOEctNv25NXLoUtebb5hV+umbCx2GCmGFWqhraa
         MYLJOS6N6PAjjHxv44HrIvFrKVAtPt4BuaWlvZ4oDNDp5J1KqZ96looyvRT9bgReJ5xv
         z+mWN+z6iSJqfF3cv5/sRzREkisSYOvzS3pDJobeU43UeusBJ+RIuwtEUS8cUlmENfWP
         Yqdw==
X-Forwarded-Encrypted: i=1; AFNElJ+6B/IKHI7gZ9Ya/IJOE3Z5TgAFWF4uF5JaSMwN00XYB9sticpcak2JjEnv1UQ0iHd8Ut3gepY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXsi7xNuv10ww8cHTs5WAZ399zGm7Zh/Y/y1dTIgM08aicfcT
	D2ka1nWbCtVJxpgFiuUgTdksQLoMwt4dMFc1qShrDra62cM7TdfGFI1eSaL00Ci2ch5vls6QZEa
	PFtXLDhyXIlMy3NwbZPXI6FTyydutZtUwzyRpJeMPFlHJFDWSXr/KexKola8=
X-Gm-Gg: Acq92OEcr5KWPEDRHcmH26ZZZQojXncwAxaXvKsdEiqUVJbLZlmzfwUQAW3GRpFoJ2i
	PUmyYBXfwanvflXDMya82b9orvl+1SF2fU3/MloK7dg0sBb405lwCj/gWT39dErf4GFanGDOKWS
	2M7gd7cH9IPdPP4JgW00Dpn39oyOEgy95Eu44NpTuPh5XKs2wYSs27qwNXw7lz3rk+Yt868cpoD
	jIWo+e/XgHIEm8mM/5cJ0NQm6uhiru/C1Fs3vBQClh289SRl6UwlzbIzmYAqsQqU5+eE8pWdGwT
	oe0s481+Gvn+mQU6vupqsB8ahpCihclt/WEpYpDUvbXk3+g/N5SdP5SAhb8+vASRpgHskXZ0j8S
	n/4oAcgRl/G3FYwt6V7ZsrSlwPGod9/JJGKCrIOPclJ32VPsbfqfgBq5liXuB9wKEX9mXCpnXa2
	f5
X-Received: by 2002:a05:7022:911:b0:12c:5e48:4c01 with SMTP id a92af1059eb24-1350441939fmr6474499c88.1.1779112457682;
        Mon, 18 May 2026 06:54:17 -0700 (PDT)
X-Received: by 2002:a05:7022:911:b0:12c:5e48:4c01 with SMTP id a92af1059eb24-1350441939fmr6474476c88.1.1779112457051;
        Mon, 18 May 2026 06:54:17 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm20870488c88.12.2026.05.18.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:54:14 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Kyle Farnung <kfarnung@gmail.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, santiagorr@riseup.net,
        stable@vger.kernel.org
In-Reply-To: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
References: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: clear shared SRNG pointer state on
 restart
Message-Id: <177911245414.2671480.12255059395274590716.b4-ty@oss.qualcomm.com>
Date: Mon, 18 May 2026 06:54:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a0b1a0a cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=CbO934nNXDxLm8dFh94A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNiBTYWx0ZWRfX64NUddmH1fZy
 4iN37glzQH5BYLHG6aIpy0D4sLAkoY1pJoD/DCWoq0qX16lmT+D1E4z5vyw17w84uaZwLTsIxlm
 ZiEoirDM4vSni9un8/0F/Bli4MJadBe3FfHL1xEcy57Fj9e5NlOJX5XZf64fn2s0rQG7WYcBoSz
 gbK8BCujvZ5cD6hsKQPxYHbs6eBNiYI9ebAK5vl7kQ8ccSLJ8hIhaauEUzeSSJ5zr8fvIyPHnGy
 OUGx08nnPQBq8yM8A80X3nvkhgleyxe3SRyeSSiPRqXygYdjy/7jhhxS+7Xnop0OgxPVYY/BZ8U
 gu8QijmVTbUwgpmmXX4dI3V4fBZsXwnGatn+Vd8dn2LQl5+49FtI6I+oqZWThNjdkkWsCPPZ2Ox
 MhaqD9+8+mIThW8qWDfuWo8HVfn+izNB+bC/9EQAClIFCCsqRBgArT1NRGmVzAcGuxDVy7ID4is
 TGYN2sHP0lCwkuRgTUA==
X-Proofpoint-ORIG-GUID: Zn0wMOOvsTTsX6Yv-2s0GZoNrFLi2Wym
X-Proofpoint-GUID: Zn0wMOOvsTTsX6Yv-2s0GZoNrFLi2Wym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180136
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249299-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,arm.com,oss.qualcomm.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4297A56E51E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 13 May 2026 21:52:12 -0700, Kyle Farnung wrote:
> LMAC rings reuse the shared rdp/wrp pointer buffers without going
> through the normal SRNG hw-init path that zeros non-LMAC ring
> pointers. After restart, ath11k_hal_srng_clear() can therefore hand
> stale hp/tp state from the previous firmware instance back to the new
> one.
> 
> Clear the shared pointer buffers while keeping the allocations in
> place so restart still avoids reallocating SRNG DMA memory, but starts
> with fresh ring-pointer state.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: clear shared SRNG pointer state on restart
      commit: f51e4b3b5574ad8cb5b16b11f8a1452147ece87a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


