Return-Path: <stable+bounces-217236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAH5Ctl7lWl8RwIAu9opvQ
	(envelope-from <stable+bounces-217236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:44:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 970011543D4
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1EBD303049E
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E79321445;
	Wed, 18 Feb 2026 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lTY2qGB0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LV063I2p"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53593203AB
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404228; cv=none; b=nWRspFK6/cA7jkHQqvaXUV7LmxmdquhpUiBLAFfFRizAZDfN2r1b0U0gnhYWKd2UnYGwYJjl5diwDmIvA5jLzCJVukDRQU63t7sUhqHqUGKOw87+iZq2tzvtrKh69TQP7B6yzKkyQ7efrbTR82172UBdYwU4ZpMS1EYgSfOHTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404228; c=relaxed/simple;
	bh=t8MZQ/ZZEwlyiwhBvjBltm4YE5vk7TMCaSJCZpqS7hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkI0h5TAe0I/Bj6OIzLbUAA0F7koGnKwLBmkQttt8dT4GShxityIEjANQlV/JxyebOz4LNKzhtFGlMKVQzN7Q1U22XNvtvlDXVMyEIlgnlnpiNoUjgDUabIEoHHgFkMmMpjljkKiiutDif99azis0PAqil3gg1LgDBhKaj+Q1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lTY2qGB0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LV063I2p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HKX6Ej3694263
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D11DLbhgRQAYOxcXhcBA1YEKOPZKFRqaz0G263o14M4=; b=lTY2qGB0pm8qVZ7D
	Fqgvtie5yySSJlMnMA8Bwje+H/xaeXNYaeEFVN6n740mGv+fNlohPt2hSbBEy+Km
	B6QQ3OxcekZXYLHYAyfY9lqvRfNln4zc59SOxgdTrm+YaLlqie/2DZ2ITya7dJgm
	TyV/QxY891Q3KN1SIC7WxadItCfNKd0XzFYkssvECN6wzJ3utH4ZADZ7XpzH4z3b
	KjO9HhGBNeexDhVBLcl0Y6f8ldvr2zWAiOR3MqZLVTsKPbhvPsoS9jyZ2o4bTaXp
	iWrQAH70QRRh/gs+yMneXHPZhHn5wRUSN86KPSWxfMIXg+k/nhlgRS0D+0Ylap6n
	wuJoVg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccyfb1nma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:43:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb6291d95aso2637936585a.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 00:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771404224; x=1772009024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D11DLbhgRQAYOxcXhcBA1YEKOPZKFRqaz0G263o14M4=;
        b=LV063I2p0LlYz/eqwKEbSZ6iCVslTNfnUjoozxj4OzMNuAUsB4yFhjz9nSgTKub2+w
         aBCbzw6L2o2xVXs4XlOp2GOPCf+jmSjRAFF4b0BUoghdFxw7RLOCVuL3+d499ZFoQExP
         m7LHU/Nq1T8i0T1wqEVjZ3eRCNvWSwvuxzU/pTSQO3XluMVB+2YW3BEQ8//OK1Bf0bPt
         mpCLYLaA1f3q0hEMSQGvnkEGhXCEm1er2Tru/k0K/ZzdQYmbYi3yg6607gYKaTQAXO+t
         fmY7nKgyx4l7U/zoZ6FnVHZIw2Ql7B7DGktWkA65/H2iuwlS7oWe4wacWgBD5LGlRFzs
         NI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771404224; x=1772009024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D11DLbhgRQAYOxcXhcBA1YEKOPZKFRqaz0G263o14M4=;
        b=tTW2uQYFX4axlkovoBd53DJY2G4fINKstAGWrvKjb9rA9uIr1w/DCkx8f7BZf7gbeD
         Qbm+jpQi/GjYlLrDAeGCNEdxv/3Q56y3sVfC+LGe03QPWO2sDLohHfpyLVWpwtCDJEbc
         CT7dmvhfuZ05XclzRGQkJRbJK9zU28ioYr2GaTZLkl4EqbaLCylnymIL1mcKFk+ISpDo
         4sXE5k4SNRPRMqZ2+nXr5yiSOviMJSPGUhWh6RS5z61bJoCkDEa9f6guNLrVYR/vUo6O
         mddgnCKkLW41KyUDP1se3e3xpblNfUFGlRGdikbjJHGfnIirYG5M2wV/Zm2Rituzr7yp
         9+WA==
X-Forwarded-Encrypted: i=1; AJvYcCUv/nTFyBTDGUgm6GN+R7hcmZFXby9Y0JfYqa3vNy1UBveUA+seGTAabdgVOL6QU0lW3GJ53zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEhRDfm9h31KfNkQIi95JaEgmzrlqA0DkUGQEaJnhOoO+8UkW
	QIz5mx/BSFLuOelJQn1OIyLFeeMp7sy60scwlJzP3xW7uy8ir4lVVYRG30DqXjmacyyZKz0G4Iy
	Gxc7Em3lXqYX6LzPmdUulcq/Ks5tiiuRqrkOInmyQHc25RjM1nwsmuv7L3z0=
X-Gm-Gg: AZuq6aKHmR644I5C5jFO7yyxmU7Hnx7MhObBPhLtxSKaAwUJvkHKXkfn97NIM79nf5x
	P4fu0UsZS34Iea/litjtf0IQuLWrOCULksLjL5ytiMiWOrWrQ1E4QArV8OuKK2nEOYDQE8hmzt9
	x/W8gp7ZFw9ovP09zkhGSJWw5vVWIfJ39FQurF5xEdWRPNnnfzoRHaKCYDYVpfcPjTvPe4Bj/ml
	UkbatgWPesZuW6O4TqYPJqHgJZbLZ0IUXSTaK4JPPYiPG9qBgNbVJu0OPMhHIWvklkAQJQqmDV5
	PjNusSCvjgX8o/YgpcCNjlflcBFIXtY5fTmb/8yH5x6IHdd/1kHjKiw2E2sh4+jJpd3u6mZkToM
	IKSaijSM7/RbRlZs5BI7W1SfoEVaizXegNaUSmOeZP2F4jpFk2P8=
X-Received: by 2002:a05:620a:2683:b0:8ca:55:ac72 with SMTP id af79cd13be357-8cb4c024fbamr1719913385a.61.1771404224347;
        Wed, 18 Feb 2026 00:43:44 -0800 (PST)
X-Received: by 2002:a05:620a:2683:b0:8ca:55:ac72 with SMTP id af79cd13be357-8cb4c024fbamr1719911885a.61.1771404223856;
        Wed, 18 Feb 2026 00:43:43 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:6f70:9a29:d138:f5ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e11f5sm583750455e9.4.2026.02.18.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 00:43:43 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: swnode: restore the swnode-name-against-chip-label matching
Date: Wed, 18 Feb 2026 09:43:38 +0100
Message-ID: <177140420873.51570.16441963571525422397.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211085313.16792-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260211085313.16792-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QkmM8fGcseWGDlc2_JlWRPSBonw0KUIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3NiBTYWx0ZWRfX7FOOA4BynN3m
 RW/ZfSwRdFI8QiaIN62zGqokDCgWNejkwxXgSl/4bIo3rmj86KdvFeVuqyFLsm0ggBz4/fTHgnv
 hb9BEgFz62DUrfH/BlAfFhXubcHcPtJIqD7CXqpZmcPKpvirtcoUh57lvPPv8J+FzCL/Yqn1Jo3
 GlT36CELtEDIANensHdja7YdNXFdlM6A6GXOf6dBFiCB9V1esvOg6y+fJ3xsZHSzRuVwU957Yir
 VFBdZ03Ao0/hiBC4j5mVgI/ltbYyoyZPZarduxxVnNAkOm6gZdt1t+uGVD4FS0RJUZIktT/y4XO
 P2BnER3/97mQUemmnUhsQQPgTJDeGSm6BevVgcc8gSQqVFVQKAiyJ9mPhK6SHBWEtwTJ9uK1tmN
 bi00xLoeqJGV8fS0rB2hVqDPb3E1fOeSlK2QFG4EmEtfLG6Lzqn86rIK8OOQCYk+OX2hy2vryNW
 FqV26u+TeZfj/bRFuQg==
X-Authority-Analysis: v=2.4 cv=JNo2csKb c=1 sm=1 tr=0 ts=69957bc0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=10r_2F6UnNXIiLmb3qwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: QkmM8fGcseWGDlc2_JlWRPSBonw0KUIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217236-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,linuxfoundation.org,gmail.com,linaro.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 970011543D4
X-Rspamd-Action: no action


On Wed, 11 Feb 2026 09:53:13 +0100, Bartosz Golaszewski wrote:
> Using the remote firmware node for software node lookup is the right
> thing to do. The GPIO controller we want to resolve should have the
> software node we scooped out of the reference attached to it. However,
> there are existing users who abuse the software node API by creating
> dummy swnodes whose name is set to the expected label string of the GPIO
> controller whose pins they want to control and use them in their local
> swnode references as GPIO properties.
> 
> [...]

Applied, thanks!

[1/1] gpio: swnode: restore the swnode-name-against-chip-label matching
      https://git.kernel.org/brgl/c/ff91965ad8b214e0771bc5a15253f14f583a7649

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

