Return-Path: <stable+bounces-217722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DMkGdIwnGkKAgQAu9opvQ
	(envelope-from <stable+bounces-217722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:49:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AA217521A
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8041F303A25E
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB5E35F8B2;
	Mon, 23 Feb 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFqyrSGr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kA0rgQmZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B335C1B6
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843780; cv=none; b=E7UXE7lxXnWzqYMotDA6zBf3JU+r+3s73t9ofkM6iOsKPLBtRLCtpf3PbmTyAcCOTsr9tDqJKlb36hUSaCpq9G2jRJheQTLH1h8/DnRG/6UwpFI/uHL1JEyR8ctbFqNoJIUnD9Sn9aq5WgpmZzQ1hLvfu0KNpLpJN2RRJE9x3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843780; c=relaxed/simple;
	bh=GC0VfP4esaZr5rSCEvFooS80d2grlfnSp82KksiJ5tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClVzAI9LfKsfPtN+t5SyuSCjCtsjI/YF5cFkt4TvVdpC02RyfXvJ1ygP9YgZKg0DUDkOiy02plDoh0p8r+IpP5yX9vMXg/zv0QEE4Kd5JyaajGCWo7HY8+6kvHdkTxgHvvD7y4ZuBfLOLlGsiANA3dcHN7ddUnvrY4vMziJxsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFqyrSGr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kA0rgQmZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NAYRnB561785
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 10:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4v89inTDZEXdrd9RJRHgT2h0ptcHr+emdXUC5U1ttwU=; b=gFqyrSGrAA7DWawB
	AtkoMH1AuGUJOODq8G7Ie9sJUrZVYRx/Je66oqCbPXZEoRJ70OhG6eFaG4LhSTOh
	m+Ng8YsHQMRFm8z2N7ejmcrrWQLSFpLq/92nfOkPiT0aV6qYgsY2hr6zKZxkVsmB
	Rg25/QMueG9G51qMZSZYOPzih+duvqeg3dqU82arIdM7KPljGKo9Ls7CfFiE8ukn
	IwLh07RJIK/qjVapYMgTcw1OGdJcbu6baNjqo41XAZEIeV31jJiHpIiiIXgweUdy
	/wJIozGSaPnJxFdcaD7KyaZ1SMOVAYKGsReBrC9h8nw9pCqH/yMwK8uv/07G3IRc
	Q9tOeQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8r81ge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 10:49:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71500f274so467495585a.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 02:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771843776; x=1772448576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v89inTDZEXdrd9RJRHgT2h0ptcHr+emdXUC5U1ttwU=;
        b=kA0rgQmZjR0hzoW7IBo6AO7sCIhrS2qDEPlWC8O+NZS9VNDcldtIDyUYE6om8WDMbE
         D7AcjNAHhuzdQFcPymgKO7idr+jAc3A0xioSWSPwxhEktB+DwhDnI8+qOwQlVBxVA70A
         sjvp5ckkcO+Q/pnn5ou72lVimcRMfnQP6HVJKGPWJjFScTQ0En9zUm/ZFKQKeV5wPfsp
         1yVVHznn0yAg/AOMiW0GFG4AO2reWuFAclfvOipxwfsL0B1XkZOeN0o18bWCrracPIKF
         7nGAGAXdtBPRD2pZYsIaJERy+bip/ly8+u6f8ABjAxcrIl9fH3z6KPs091K8MsTwCk4B
         hHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771843776; x=1772448576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4v89inTDZEXdrd9RJRHgT2h0ptcHr+emdXUC5U1ttwU=;
        b=L1As2xvjs9j2+ZKypl4JiSZtEMREHgN3Kcc0AqhaIbYUwncOtmAPxjdn9iGjcBGYwb
         GTE+U1A0/BcsDE924fkGWpP2oa2t791FUc1fqvuPJdqgLB5PNi473i2iyvzTTK0BQR0i
         2IWzAqbVtsx2uykHvjKQPtgLeTynd05+j+biJ2FVKS5s7etGor+8cgJmpiQB6jLSeQn7
         BgBaJWdRIzkrj8SDfdJbDjOib3/PmtwEICT/9891khFr4b0MdH2BuJX1GLxGScxnwGEP
         94needTzAk4llakN3VjI8d8m4spIJVjt+T8lkQ4Y8VGTMcBaBQuCitgq4K0ZUz/zbnKz
         vhbw==
X-Forwarded-Encrypted: i=1; AJvYcCVKvL619RiB/JTGGhHzUAbz6ruBwxNYEdc+sB/H/CfiyMxW3TxiJ5Rc9BOkVoC5GgZaz+2V1FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAPP9Lx3MniTzYAfuDm8Ef6BRzsZbTooXYIXtod+3BK3ksB9Ip
	CuB8oN1VEKoErNXP+ZqtxYnU6OM7Q0jfVaLyCEpP5YAr0t8RrJfq8kmuTVwU8Nh83Wgf/JayaNq
	0mWEn32yF5Fa4tjK1pRRcmGbJx9Evu7M8omUknPX4q5bgp+LrJ3JyjtkF3jQ=
X-Gm-Gg: AZuq6aIEDd88LzrymqvSERZMcIh0xlhh9TCuMweM0+nUn7wbA3A/kUFyFyteXWPVirq
	MViMJxSMlHv0zKqBxBnCVqWSDGYGlvjqEcR0/UEz446bAhIyMbp8bdyFLTJGhNOCLBXOz8PZcUl
	pBXKZTOBtq04dcUPwTYULDaDu9k+TIAu7YNJN312S8vsGlH3LYzQ42/xdx6T1dYnkj5fwkj3WMq
	kKF2DJLsGEDTTzqfEchdBHqd0s5pAMdY8WR6oHuFKnN+14XccY54iENN8A9lluQotOPAIuSpEo/
	OpSW3tByiGQYqsM+1tjzMF1C1UbtPlvWpXfdGlcvv0zx8sqRvVj2/En1v+sMp89B+tDTWCX3bgZ
	s38UaAgYuiE/yddsfFp+X8HPdPdJgjiwIu1fRWXM+I+9loeazo68=
X-Received: by 2002:a05:620a:4085:b0:8c6:ac29:70ff with SMTP id af79cd13be357-8cb8ca65e96mr996535585a.52.1771843775951;
        Mon, 23 Feb 2026 02:49:35 -0800 (PST)
X-Received: by 2002:a05:620a:4085:b0:8c6:ac29:70ff with SMTP id af79cd13be357-8cb8ca65e96mr996533385a.52.1771843775432;
        Mon, 23 Feb 2026 02:49:35 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54c5csm17969876f8f.38.2026.02.23.02.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:49:34 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: normalize the return value of gc->get() on behalf of buggy drivers
Date: Mon, 23 Feb 2026 11:49:33 +0100
Message-ID: <177184377034.141773.496278586164543775.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219-gpiolib-set-normalize-v2-1-f84630e45796@oss.qualcomm.com>
References: <20260219-gpiolib-set-normalize-v2-1-f84630e45796@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h4DFga4r3q-LURSfIOHUgczkoPoueZeC
X-Authority-Analysis: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=699c30c1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=67SJ3es6nUsVzo6b:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qavmD5TIkVLpn3QFz_0A:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5MyBTYWx0ZWRfX7XJb3XilBnZY
 7TtTA7gONMBKY1IoQN3zwG0HfgVqTwp+/HQmU9e3XiB4Y/5wpsMuUdcfSDmT3ais5jwCaLC4Mzr
 I57H1WAPlvEhsi2vPEv/tueOIO9l2INbrx0T24CY3+yq6wvOtgyQ7+J1cOAsGgo6dHMDzs41I5T
 AgdmtbcQr2NkXmne+ifE3LTaAzRltDJ8oKa3Xj9wUcEJEu7zcQh09B93yQ61NoIXLwGPRSIBpOV
 B49E+MLd5+SFxh9jQlPFz4A3NJacd/UwDgIItZdKDZb1pnaX52HWq6xyCrOm4y0U0d3mEtq1swW
 ZYlHDYnCaK4ex40cLxe96W41FV5Of8CyV4sX+mVPyKhhaK513UyhD9iN0gc0mFwp+5wDi4LfKl6
 uPDxqDdoPM7hHnOIVPuX0A7zx3gNugohRdvphhxIFWZbDnQ9eybSoAOtru4R5fpvk2pk7zDsxIi
 MCvuczDZas+XMPFZqHQ==
X-Proofpoint-GUID: h4DFga4r3q-LURSfIOHUgczkoPoueZeC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-217722-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03AA217521A
X-Rspamd-Action: no action


On Thu, 19 Feb 2026 10:51:33 +0100, Bartosz Golaszewski wrote:
> Commit 86ef402d805d ("gpiolib: sanitize the return value of
> gpio_chip::get()") started checking the return value of the .get()
> callback in struct gpio_chip. Now - almost a year later - it turns out
> that there are quite a few drivers in tree that can break with this
> change. Partially revert it: normalize the return value in GPIO core but
> also emit a warning.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: normalize the return value of gc->get() on behalf of buggy drivers
      https://git.kernel.org/brgl/c/ec2cceadfae72304ca19650f9cac4b2a97b8a2fc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

