Return-Path: <stable+bounces-272164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rvffIYiQS2pvVgEAu9opvQ
	(envelope-from <stable+bounces-272164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 13:24:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E170FCE4
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 13:24:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XA45LfBC;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=X8Fq71hh;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272164-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272164-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC40536AE86A
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89544F7998;
	Mon,  6 Jul 2026 09:04:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEF4EA371
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 09:04:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328657; cv=none; b=BbpznxPAIJiwXnHVjGetnhoRUEep1vKGSj4AxWDWiRUAQv0A0vuroFEdUmdTAM+gK0dsYSDNMvO7gBL160IftcriRcV5keUZ6zzS4e0FoTGKHf9jWYyCaRL1BFXMh852q59qD6GrDTlrGzwrKvKQI2cwm1REdgzKTpQv1ztBeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328657; c=relaxed/simple;
	bh=sT5lFMV2RMY7vRSqwJD1AOKYGSl09riOc3ychpQZt8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEWBVZmlaAvtzh+6H5ZFsXIeBHqAgx+3tjR0m1GMPl69tVCfua7G25gdeTMcczVE5CZawQOh7vOfuANUnNL4mJwFK1p6aMyp/TqdtWeJdFUoeTwDSUz5SAUyF6wkcsaVJ2jGkH/WE7DZO2gvk3eeVhn7NXHRWNa8/lqnpzvdMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XA45LfBC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X8Fq71hh; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66693xIl109191
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 09:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7g2NlMcR+OJ0pQlyVRLd2L2YHSIMDkKMc5JLil2y3U=; b=XA45LfBC53IPO1K7
	vk/+zV3d8feWJ1hpXmoeKJsxQFmqxpLiwsdiWbAOhefJ/eH6s7dlAM+z/T1dGY8O
	BthVqwvMSC/GRRxTyzyPYI3p4c8S28gvs34IZebYYK0Gb8In+tijNGSbDvvF0yWw
	AU4XfH6UC4ZUIQM/s5sgxknyqaPUrlCdbqahTiktg66o6715FBVfFaU3Jl9JyFee
	XoAjt71tkfe7x93BJXL1W43STyEjy6/O81d78M8fuKS5jGi/5kTLQ2EH4WIO50x7
	Xmgz/6f40zv2j/ZM2D7oqsYc13iyBIXVMcnbgRxdXEtOYZQzbm9RIFgffowZFvLT
	i/yKeQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h988fe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 09:04:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c33f48ee4so28364481cf.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783328643; x=1783933443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7g2NlMcR+OJ0pQlyVRLd2L2YHSIMDkKMc5JLil2y3U=;
        b=X8Fq71hhwPZ/i0wzqV/6+OoXGSxOIPuqmrq3NC9AjtF75JMxl2Rtsqo2UVjhXz1W7U
         4dc9hdrqjod+bdjVgNSdgSKt6SGsSfXc5r++Lx7fbqxHP0ylEe+CFe3Xo5xt3MTchhrm
         FaDVtuuj9e35cjF+L+jMlwoo4oTcvAHIrN3mL9FLE3PWY2Nw8NM/S8a3SmOuKe2KxmeO
         5g8GJzZdPfuIUUQOmMFu3GhA+D6saXyxv5fXJB1XPsGdbkGeNx6IWfMX+18K72VKN6kL
         1MpwFVsxwubD+/uXDzWiRHbsRjVVa/tyDV6tD2VNhdCobvXS69e2li8Yeuxag8+fdGYP
         J7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328643; x=1783933443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7g2NlMcR+OJ0pQlyVRLd2L2YHSIMDkKMc5JLil2y3U=;
        b=GacGmHAA0jJOPosXPGoRxVMrr5kJ7fJzcu+ofRbkAcOZS/PWq7lefrqVAxGFWtz30r
         t8pLbyAGWaW+5mYgZANeKanWyxjp73p5R2/4yS9vJU0fekqYxWqAJvt/p41Sy3uO8bg9
         LO/Zf4G3gk2524hcqL7Nc1ClMQpY+yn5ExEf3NqgPvaOdayCJ+Z3l+/T0TZLxR1srzyC
         hEWkscK1bW2wb/COgB5TRymujxf1j4wNW6sOpUBwt1HyEp6V+//B7AcSylsFjfTxn+AS
         xFFfEe7e7geg9VPK7vvX++aUpgjyk0cRtwnnKt693rbS56C8nrtzVNuTgiebq5j8JzLx
         MAVw==
X-Forwarded-Encrypted: i=1; AHgh+Rrl3HExrWnNbIcTNtK9PseGI7kMsKebU3Vz8gRAM+pILl0zM0ziqSbyMRyWF6twApLdt3gXyR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+kxzHNnfJE74/h5aohA2qGv4WBw9DOnsAtcXMVCvMXAgtEZ7
	ZHjj0hauNDtrLLKhwMeiYNHFTOBdouhyN1PeMPQP1EiUG/hBCRww0TgXjmWoHUd1C61bhu5oAuP
	luXShJAEt4//z2SUzbB29RqvT7C3Y0E93BKoFjvBSoj8PDRjl8WWfBwkD44A=
X-Gm-Gg: AfdE7ckgjvUYs3ixaXWRngo7c5aLpFk9SgpVmjI9nf7GJtyddcrE1MEMcp6ByjZHgNC
	Z3oLOr/7WE3uupNCQorhm/V84D5GtpJHQ9kKjIS0ErVXkpFoOrGamvBb4g38A2OdDD8Ykgb7Ijj
	tzEFQam4+JGf8j3mqBlA9WM2rmccepixCYw2fs8OvYbUL2zRyfClSLrkMUmnSqHMgGbvZ+R2Bh4
	GFv8KMmYId4P30qm58Air4krwdzZ6z5sczw2IrLK2OGgRk4bq1vfPxFuU1AaL4no9nhQzooa0OH
	d9k0Z8xIA8f1/4nWjANZXmEQLjjeg3vc3vIbJB9JzQUge1sl1+YO84v5G319RkNHk0PP25Fb99o
	5qJroDq+o3xgg3Cyl7xBXwbdJx4DwPTZ2d2pvx2c=
X-Received: by 2002:a05:622a:180c:b0:51c:f3:34de with SMTP id d75a77b69052e-51c4c21a5c9mr124047641cf.20.1783328643233;
        Mon, 06 Jul 2026 02:04:03 -0700 (PDT)
X-Received: by 2002:a05:622a:180c:b0:51c:f3:34de with SMTP id d75a77b69052e-51c4c21a5c9mr124047341cf.20.1783328642807;
        Mon, 06 Jul 2026 02:04:02 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c636ea60sm315243765e9.3.2026.07.06.02.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:04:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, stable@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2] gpios: palmas: add get_direction op
Date: Mon,  6 Jul 2026 11:04:00 +0200
Message-ID: <178332863765.18977.12844804130835773641.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704-palmas-getdirection-v2-1-2fd85fee3832@kemnade.info>
References: <20260704-palmas-getdirection-v2-1-2fd85fee3832@kemnade.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zxNEPo3sttHbEmlpTaZZRicx_mOnRIQo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5MSBTYWx0ZWRfX7HjA7Nph/9Fr
 OE0NBl/oJDAQFDIkZivf0upL1ru6I0Ip9C5fryqVIr4F0zJ+WGlgtgqZX33ImcWBcO5tMPucH0E
 tBvn7GaKVggTdP37TkGcOGQcPOMbw5U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5MSBTYWx0ZWRfX9Ne7igWGtv8O
 bx4qJEVSYE81at3/go023p1FFKr4vdsWCCnSEuZpL7vntMjUKkIG5VVG3MgCKMygfSSgB1qfFkU
 dWfbx6kBWGs+glX5eBMqsD1uLtV6CmGZ9p63FTSxkipzlunK+77SfV/q/fCoc0YbHLR27CdM74o
 DSvvgiiMIwXIzJG06Oqy1XH37FI7aB32039bDBdFuYhNHq0I3RIziJuvNW8t++vr8XqIvyTl03u
 2pPBrRpvXVxyR3DzN5UdSD7j6lvEJZDPsAKF8QvDYbdNlxoDfAkXEChAL5Y5MZYvBJoSrBmo9Ad
 2Wua+3k79yX76NQVo5UbWZ19mWU2ukShgHmJGLGY1KL0w1dPeDviA0d1FFfhWsGqcMWcq+6ZwVu
 GOzrvjmIdA5uDQoy558pLwpA4zhI1ON3vsj/C+ODB4V2KfOztLCnddgsBvOQXps69X8voZ4wmUK
 F5JTw4OR/B4Nl8wTI/g==
X-Proofpoint-GUID: zxNEPo3sttHbEmlpTaZZRicx_mOnRIQo
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b6f83 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Xj82jd3BsPfj_FevrHIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060091
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272164-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:brgl@kernel.org,m:andreas@kemnade.info,m:bartosz.golaszewski@oss.qualcomm.com,m:linux-gpio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-omap@vger.kernel.org,m:stable@vger.kernel.org,m:ldewangan@nvidia.com,m:sameo@linux.intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E11E170FCE4


On Sat, 04 Jul 2026 10:40:54 +0200, Andreas Kemnade wrote:
> Accessing debug/gpio is quite noisy without a get_direction()
> implementation.  To calm that down add an implementation.
> 
> 

Applied, thanks!

[1/1] gpios: palmas: add get_direction op
      https://git.kernel.org/brgl/c/0c001f9c0d96cbb533559cfa6177a1daea89a21d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

