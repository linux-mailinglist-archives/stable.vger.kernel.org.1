Return-Path: <stable+bounces-232665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHT7HzCQzGnXTwYAu9opvQ
	(envelope-from <stable+bounces-232665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:25:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110637451E
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7D1D303F1CC
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150DF381AFB;
	Wed,  1 Apr 2026 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HhTWvBho";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EZEEJZsG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E637FF55
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013776; cv=none; b=p6JlGJMKd4Rp2tfTGcse33AH7oeDQHczrI3JdyPkvWgWzU8DaxG2AUZpAoeAeKUvda9ANgkEfv0/fuHFKt4W5765+TEEVAT32AfcIEeDMGb/OGnJYPG/xT/34YVHy5uGRYtOjtQdiva/yu4zElT5j/1HlRI1F0o9K46EHSnwHaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013776; c=relaxed/simple;
	bh=3orZ/lm59tquC+ygmtUkOAAIap6T40OPZUvH9QyqCTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDAfJrAoAUZRVPdKsBt9fV/u+auv0z/Bg1JfMncedkcK35/GSVtVZkwZf6Q9v0GT8F73aiimU58tkRmJgtxzPdEVcWO8Du8Viw2SxVaAO87ZzS2PJG6w1U8qdzjQzYzz70ZBgtBttcJUIWDylUBGqZlYMboLhGZtQ+XCdJ7wXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HhTWvBho; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EZEEJZsG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VNPweb3882834
	for <stable@vger.kernel.org>; Wed, 1 Apr 2026 03:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZkCqUsFz1Dz2jHRMWPeXASCiKv0dntlxkvx4wplkgQ4=; b=HhTWvBhoCDLOguV7
	Je3OwjhxUGyPJVJ619D39NFHv4/r201OFZhIwDwO59gd9qO+UJMcweoTiMbd2w5L
	JOo4zmj1LxZsTp4FeMNLEsJrjEuYniuulIM9bzc3eJISKWgfFFn4ruTMsx3xDvNu
	i21JNRQtNWLo3rOkjc4PHDuZPo8YbMPTLUdMRruQAxMQnyA07QSHtXKfigtGh5Mw
	bnZV+V1+puXoMJGp72fc9RL6fJtY/s5Q5eqHWFlOlgD5XIxiUQNuzaDk1tW2y4Ma
	aPnDkGDXqTYNB5bPdlsYIJ8ThURGkovKElzx/nLYdryM1O/r3lWgP6hgIwrCeTeR
	/A6T8Q==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d89utcsxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Apr 2026 03:22:53 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d9e1498d4dso24396903a34.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775013773; x=1775618573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkCqUsFz1Dz2jHRMWPeXASCiKv0dntlxkvx4wplkgQ4=;
        b=EZEEJZsGNEVVe0SyC2lN3n9yolPLA66AxXXZUK3eCvQm6YRErBjZBSeFdc6i0N6mNZ
         X4HepPl8ll264Cixv5EBIKAbhNgb8zgEtDJwvIUYXb7k5WMagzHJcfrP8sIkgF3jk1sl
         1Bc4tKjxqOQ2OhKMFeFmMzf/QRmrnfF1Bh/JUS5h+L4KEdMJG5o/DShGJ1Z0kgKkgKxy
         uujj3bcKB6SGIkPn0iFKY252DI8izfmUC32R8Z7HD9qWvXAMTma4ZGEoG1iDqTZrutVW
         D2PdeZaJ7NKdiN+HNjEQfVeFMwWcRB7c9APQ+oUwbQaDeVPII5yfeSWUyL27zD7Epf+w
         KAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775013773; x=1775618573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZkCqUsFz1Dz2jHRMWPeXASCiKv0dntlxkvx4wplkgQ4=;
        b=i/b5J19lXFGRW6GGph6bU292wrkfeo6yL5ODPCzpsrvEMa6kfBhmrOh2UrWI/VtimA
         MZ10i1+iU+pXEU+tuhD/1Q1LLsiv1jrpi45NSyYYq+jxADFzQvo3stEN/bN2puKjcSqE
         D5tJDpn9rRvjeut2SbPEnj8X1tQxIPClmMy7gAurveAMZ1DBwBL3ub/qU5pvZlDeoe3H
         EUiP5hNvFAm7PWB6hHtHGPY2H+X+DoF9haq5XnHRNh7wLNPbo7gC744vqIzRC3tlHHXX
         qMb3aSIKfbhX6XojWS1V7iMlHHBhUpjXAam/vgm3xX1M7+cIR24/YhRyS6XZf9BOslFv
         nSpw==
X-Forwarded-Encrypted: i=1; AJvYcCUrERBUf1GgeRsnEQkkpYr6YJwXVDOJcVhmGcbQaqZ7gpt3OfYBe2629Uwaswg02yRtZeY5Gis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXJbq1sXMU50X8PaUfvc7HPMV6mc5iKKY8it1e6KViNaJ4RHyj
	wS+WQhrcFZlyFEfzHZ+BsL1aSKd7rLtl0N9rd919Z0JZGXOyA+IVlovLcN8SIk+dnE0ZxshEKXw
	iHvVgEwnNDgPC4quB1MVAHifuoKH05Tqo2inuGErDDx+SjZti4UjM26IO7GM=
X-Gm-Gg: ATEYQzxp5pm6vK7ReHLfMLjScIsDa1sfyApk7IFG+xyrcB/JGsv6tOHm/EY2LuE/cWM
	lbS7T7YeA04R5eTDOmbFCginURriqfmf9QrzCd/9GbEyZwtMvn0X4tOA+HtN+LUIOdFxiD/t5Av
	AppdJOLoHiScInhwtpRAX0sZpocALj+orBZthHcPiLNylgw3eO0cnY1rHRLeClnKDt+CngCYlfD
	I9xc580hguDcoUNJKnKkEsRisUCELuGmmstQrO3sXhH92QGvDpgGhSSffrG4z0KUhBEjjS7fR9f
	cv9zPHCT5kr8P1CHC0s2D0bxLbJFld/orvm96dYbL82grKH5AlebgF6K7b9Mb6WOrtSVb/1KuXa
	tcRNtpLsQG+8NREbKTuR/qAiwC1tdx+wwUYXzAQxmdJ0=
X-Received: by 2002:a05:6830:67f6:b0:7d7:fba1:c767 with SMTP id 46e09a7af769-7db9942cec5mr1568047a34.32.1775013772566;
        Tue, 31 Mar 2026 20:22:52 -0700 (PDT)
X-Received: by 2002:a05:6830:67f6:b0:7d7:fba1:c767 with SMTP id 46e09a7af769-7db9942cec5mr1568036a34.32.1775013772161;
        Tue, 31 Mar 2026 20:22:52 -0700 (PDT)
Received: from [192.168.86.59] ([104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336d73sm9589357a34.5.2026.03.31.20.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:22:51 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 22:22:46 -0500
Subject: [PATCH v2 4/7] slimbus: qcom-ngd-ctrl: Register callbacks after
 creating the ngd
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-slim-ngd-dev-v2-4-9441e9c8420e@oss.qualcomm.com>
References: <20260331-slim-ngd-dev-v2-0-9441e9c8420e@oss.qualcomm.com>
In-Reply-To: <20260331-slim-ngd-dev-v2-0-9441e9c8420e@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4485;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=3orZ/lm59tquC+ygmtUkOAAIap6T40OPZUvH9QyqCTQ=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBpzI+HmNUPOTo1sn40W7yxJTFOgbTsxGuXKHYLL
 HlPCOsGwwuJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCacyPhxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXQ0BAA37HQ/TFyVD3DFAFGSXaqTd6Qnyo6/U2CUPAW1in
 IaJ1EliXTGyscHOv9csdNj25IhVQXj+5WYdoSiODv/vGHolrhohhBRCAktrL+YbSRrcARYi23u0
 QA7pNWG+D8MbEsgr4S9Kur5rDBrRXvs2mR0sOlMDaJfJHJE1IAmPKIxUWDaeTPQlP9ZU+BOOgfw
 RzsEEmT5NN30Q6zjttYNcKTECXB4TGbPOmWWFH/QwemGq07XEsruqCVtgdWrUmTgXPJR3tBsiOM
 p401WjRSYrmoL1BAJqnkHJuXV2sf+nkSS4x5RMWLaVz4Rwyu7i9kmAG4CJiBKepiC51qXlpCwHF
 hbPZLDLdZsgwgGGhLQ+bV2Th80R9CMpAXwXVoHVZ8c3EIyDq2eMMLQli1evZ86M0jEZyF7qz9XM
 M/6ElRAvH5BLs+eSdvZWMcD6Om70+/duQdd4GiEMpqiHBraincptzab3SAsxM8frwWUgU6kP45+
 uG7ZHCVUvWkTH/DYRdkIAlWCipiIDVGgTFogbUcijlhnzxdpM/kHgVwW673DsSzL61h1KhAiZih
 gv8IvA7waVE/8V0fPiqacKD4J5B4quivq1F9NnUyG2pk1GcZIAuFIZAqjF3BnugCygb7Yd8ZVbe
 97GMa7ZvDY6Q/ELs72ZI56LnLXtdY9deN9Dfvs3gHBXs=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-ORIG-GUID: w790ci0frS81gQD95RWeDkckAWmpa3Wp
X-Authority-Analysis: v=2.4 cv=C5LkCAP+ c=1 sm=1 tr=0 ts=69cc8f8d cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qvPh2VUuy8EyYpbUS7MA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: w790ci0frS81gQD95RWeDkckAWmpa3Wp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNCBTYWx0ZWRfX2rkfdKvdiwxH
 2x2nyhaZJf7DXPZdJ1QnYX5M9RgLsCuLMT54Gc21J5mGwHQP1Kx/2t3F5oUbwIyK5o0ykXJxg6O
 0XRYqf0N2HdFHdntxDmxRJTiqo08kB6bk60hUhZ9yCqTiTxkS+CH4wVzRpLSaY1U8FEZrAmGxf9
 F/wS1xIXMsMyX4t/I9Gfh/IkN8rlD69g2KgRqKe4obUP8gq33IkN3uf+DqlUBcx++oYczUN+G1s
 HM2IiFEEDg+X3I4fDeXwLCAVfqBgJM2LebT+yY8z7Vt/CjL0KstIeUsni17BB3cJo7m/obB6BwX
 jyjqEH8ScHLnVlWownNDq7DkiEDUTY9haMXf9QFOZD2mwNvI3z/VBrfxqRKgfHqoXaF8WhI/gIB
 wD09fnsg/5lSW12rFK8UOsj+EALX4PNmSQfR75uzFNfrgNSm6M1DgirQ+YMSncwWunip75nXTbb
 PlP26G1/DoWBzzNAAEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010024
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232665-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bjorn.andersson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7110637451E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the remoteproc starts in parallel with the NGD driver being probed,
or the remoteproc is already up when the PDR lookup is being registered,
or in the theoretical event that we get an interrupt from the hardware,
these callbacks will operate on uninitialized data. This result in
issues to boot the affected boards.

One such example can be seen in the following fault, where
qcom_slim_ngd_ssr_pdr_notify() schedules work on the NULL ngd_up_work.

[   21.858578] ------------[ cut here ]------------
[   21.858745] WARNING: kernel/workqueue.c:2338 at __queue_work+0x5e0/0x790, CPU#2: kworker/2:2/116
...
[   21.859251] Call trace:
[   21.859255]  __queue_work+0x5e0/0x790 (P)
[   21.859265]  queue_work_on+0x6c/0xf0
[   21.859273]  qcom_slim_ngd_ssr_pdr_notify+0x110/0x150 [slim_qcom_ngd_ctrl]
[   21.859304]  qcom_slim_ngd_ssr_notify+0x24/0x40 [slim_qcom_ngd_ctrl]
[   21.859318]  notifier_call_chain+0xa4/0x230
[   21.859329]  srcu_notifier_call_chain+0x64/0xb8
[   21.859338]  ssr_notify_start+0x40/0x78 [qcom_common]
[   21.859355]  rproc_start+0x130/0x230
[   21.859367]  rproc_boot+0x3d4/0x518
...

Move the enablement of interrupts, and the registration of SSR and PDR
until after the NGD device has been registered.

This could be further refined by moving initialization to the control
driver probe and by removing the platform driver model from the picture.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 45 ++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index fd533d5bceb6d7352e8ac6fdce321d3acc285f1e..814ecb01b575984f0951919bba0b8ef4fc64a6dd 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1609,6 +1609,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qcom_slim_ngd_ctrl *ctrl;
+	int irq;
 	int ret;
 	struct pdr_service *pds;
 
@@ -1622,20 +1623,16 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
 
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
-	ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
-			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
+	ret = devm_request_irq(dev, irq, qcom_slim_ngd_interrupt,
+			       IRQF_TRIGGER_HIGH | IRQF_NO_AUTOEN,
+			       "slim-ngd", ctrl);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "request IRQ failed\n");
 
-	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
-	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
-	if (IS_ERR(ctrl->notifier))
-		return PTR_ERR(ctrl->notifier);
-
 	ctrl->dev = dev;
 	ctrl->framer.rootfreq = SLIM_ROOT_FREQ >> 3;
 	ctrl->framer.superfreq =
@@ -1657,24 +1654,34 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->qmi_up);
 
 	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
-	if (IS_ERR(ctrl->pdr)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
-				    "Failed to init PDR handle\n");
-		goto err_unregister_ssr;
-	}
+	if (IS_ERR(ctrl->pdr))
+		return dev_err_probe(dev, PTR_ERR(ctrl->pdr), "Failed to init PDR handle\n");
+
+	ret = of_qcom_slim_ngd_register(dev, ctrl);
+	if (ret)
+		goto err_pdr_release;
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
 		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
-		goto err_pdr_release;
+		goto err_unregister_ngd;
+	}
+
+	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
+	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
+	if (IS_ERR(ctrl->notifier)) {
+		ret = PTR_ERR(ctrl->notifier);
+		goto err_unregister_ngd;
 	}
 
-	return of_qcom_slim_ngd_register(dev, ctrl);
+	enable_irq(irq);
 
+	return 0;
+
+err_unregister_ngd:
+	qcom_slim_ngd_unregister(ctrl);
 err_pdr_release:
 	pdr_handle_release(ctrl->pdr);
-err_unregister_ssr:
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 
 	return ret;
 }

-- 
2.51.0


