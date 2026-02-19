Return-Path: <stable+bounces-217408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE4WHDbdlmlJpgIAu9opvQ
	(envelope-from <stable+bounces-217408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:51:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B102E15D8B0
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 268BE3008D5D
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E482FF657;
	Thu, 19 Feb 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EEdORzrZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HMqa2vpz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159D21ADB7
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494708; cv=none; b=MY94SvTaN1KtDgsU1+nDZTbBqEaX47AsgLDAQH66v6cmyHfitOubC4/hMkIG2BT+A/04UCqecZi6MEA004sqGkUe246ESaVzIjvJ7QfZQU3xb/um+33UMQfgY26IkCcJAjLST21ibwi85z7rYOAtak2Y8cZ6HQAtgFLcRE9PRtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494708; c=relaxed/simple;
	bh=wI/dg4ZqAhtMhC4ST5LeCR/MA4ctuOEPFZkM2wCxs5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CU4OM/p+DdqjzDzoGhtQKLAWERdWLA/vpgetvmpzbxDwQJrAv6DDXaxwSTsbWynipHZp+nWhtIK+ggdxRnj6lL3m6h6PvNUDjqp1xdhBlGkG1/MUuAnDCDNMhSE/tjCjEho3cwAOwTtz8xhVmgG4vZMWGDx77iMtEDJKHeHH1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EEdORzrZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HMqa2vpz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J57A8f3320023
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+Rubg6qHsULxUtr1QQ41ZJ
	cDsW80D1IebTHFR4/LziM=; b=EEdORzrZChIuPNwZqkWGOAlN6/vlcOhhhGes0M
	l4WOxqeJBG+Gcs2T6IjAiG31XcxdYW1LhLMZIqRAnNWdRLJio82E32GK6RjKS2BA
	QdXEYg76ZVmiFU7u83y26MSgcnWH/STWsC8x+gJVVkhV6Eaf41vd3Yme/DJ9AXQg
	PG+F5GCMHPduZbx5A2v+NfoiW7p6XSAvqx/JmVUg2S9Q0Ic+FFwt6CrtSj5RNQP6
	+568GzJM7NKpz5hUPDJ55ZpLMd8bD80U0S74yZvPtzigqqkUpsS5Rn/0+h1qRjE7
	uUiCocsl+P3gbG4MG9LPmZcOnym6oUAsIzmLvi/PEChh5q2w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdv388mr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:51:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb4a241582so556530185a.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 01:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771494705; x=1772099505; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rubg6qHsULxUtr1QQ41ZJcDsW80D1IebTHFR4/LziM=;
        b=HMqa2vpzqbMc2No8pRROEJfhRRofPUBgk5ElziDgeDRxdnGotI3Ej32Efx+CeOzhVl
         xeFztnhXM7ldaCvlNCtWLaUqtuRu0LKJ3hSkBFk+cDVLYst+k8PfJUVq9dGaNu/KSnov
         pIqAl4NoBbYg8GL6kBllfnsVYNwbVB/B2jJemBLpbdm/e6r9zljN3za41afZM2WUdQYY
         NmvEkJFy2qadoWaa+RGNlayp7+1DhoLwvkVETblRNdKrQM6Y+Xkksyh+HfdtSHb48eud
         N+TZnkvPM4A47DKRarkneuy+TYpB8tuPgc+LJ5Jj76FyBQrnLiQ2QaCgIsMovIqEwag/
         rVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771494705; x=1772099505;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rubg6qHsULxUtr1QQ41ZJcDsW80D1IebTHFR4/LziM=;
        b=FoWF1umMPKLaCGztyzYZ9LRfzImX2rmemofFz9kLBIkIgKQwPOSwd2AzVlKFBeHoUV
         dmFgQzONoqaVeLIIHcddEMyeRwkjGhpT/jFTPvSW6jYZXn8SMTwMxfJNZwhNGLgkHpKW
         GlBxHPi5sKC5A+r+DD7G4udqf0se+ZdhdFMWLH4IRKVZ1Ac+CHeDB0xnPy6zXyyz8yLX
         JdWm5Foni4S4T7t076dB4Jbgqbj6ql1QkuKhJsLlXeaR1uXK0x0vovXrALBiljNN+rsb
         KAh1gXLZ4wjRM6hCfUQxMmGQlFr/4F36nkZ92vA2juDTSD56qKGtKts3h5caMzSVIF4I
         u7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWG48ZSevIKX2YwuyqYdSE73exn9JHjI7E4K5SR4iWvNmW6aA/ifQMY1vUpUYFEuoEkEyZ+Cc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbgms0S6NeQgt5hIjBy5kdqWVOqlPy3vAHS0brscjY9aUvput
	LE2wzsqkuCy+ESaHHQMlzfMuvJEoG6JgerTm4Cxex/6EjjaLuncW5LFKXCoINZZ1PDHmu2PDcOZ
	C+NchcnWY/E+QD0WWfja6n0htMXAE87d1vdPZSbUYXuO+eiKO86QrrdkCMog=
X-Gm-Gg: AZuq6aIX55W0ih5xvWd8HsnpoASl8RpeWWYYfSop6nOvkq9wmDJ+ncL7Svupdc6W01U
	ab7pUYB60Rq3IsdFmh28dDSLlBXFWGy+iMq3vQwIvczixuk8ziKOBn6Q80IBEdWu47F8FkuR2nS
	XbFlDq8TGV7/xbZWRumtj1m3t5b/ov2yiHh46QwEKDjL+SiF6hCmZdHZhSFwnIgSvcUsPvfGujG
	KlObuqf3mDTj3ZI+FuSX06/6i6ZWILL//Q5gs7YtHf27YZwO9yZdVMgVsCr+OLPBXNvGpDepT8E
	3v0/RwW4SOP9DIuxX5nzkuECzYlpvTGO58ZUFJZmM4Bd/15/9BRq1PaOb9Nq8LJaQJYsmo9FM3a
	e7n0ZR5WsEhDB/yLQtogvcns5MijoUFumER+S+JDlAsc/wzl3A3L3
X-Received: by 2002:a05:620a:458e:b0:8cb:4fe7:4c8b with SMTP id af79cd13be357-8cb4fe74dd6mr2014170985a.62.1771494705207;
        Thu, 19 Feb 2026 01:51:45 -0800 (PST)
X-Received: by 2002:a05:620a:458e:b0:8cb:4fe7:4c8b with SMTP id af79cd13be357-8cb4fe74dd6mr2014168885a.62.1771494704682;
        Thu, 19 Feb 2026 01:51:44 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:acca:9ed8:5af5:752a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d99e194sm504346425e9.8.2026.02.19.01.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:51:43 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 10:51:33 +0100
Subject: [PATCH v2] gpiolib: normalize the return value of gc->get() on
 behalf of buggy drivers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-gpiolib-set-normalize-v2-1-f84630e45796@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACTdlmkC/4WNQQ6CMBBFr0Jm7ZBpUSOuvIdhUegAkwDFFolKe
 ncrF3Dzk/eT//4Ggb1wgGu2gedVgrgpgT5k0PRm6hjFJgZN+kxaldjN4gapMfCCk/OjGeTDqOh
 CrNkapQpI29lzK6/de68S9xIW59/7zap+7T/jqlBhS/ZUGKLS1sebCyF/PM3QuHHMU0AVY/wCf
 mmmtMEAAAA=
X-Change-ID: 20260219-gpiolib-set-normalize-1080e2eda113
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wI/dg4ZqAhtMhC4ST5LeCR/MA4ctuOEPFZkM2wCxs5k=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBplt0pQcVHXzXuK9xx6K0WDRS+qGz37w2utxVlH
 fuh0gq9N0+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZbdKQAKCRAFnS7L/zaE
 wxMQD/4mw9YqFtFSts0aQHhHVBpa8zhRRaVukl2TiapBhAyHsh5xZc4cuPoShp06SpAAA4kbRyn
 yteaBmxeC85DjKPpE2km43KDrIrBkJSWNYS3axvxTl/Tz0GzWir11Rew0Fy7GXhI4bGFwo6mZRt
 tdX/85tU4bASIiYCZIWbWsl+XORrZbY5F4Dcu4APZae78/Dxahd6w1XGpvIrJXXLyDIlrBFkmMn
 VK7dgK2l73/QkMGsXUlDewIIeUqsNKLXRxXz1c0j384KKgHyVP6UlEVyi4aPYqzbW4p8gqCYdmF
 XRemc/odTgD8flYFdf7WObtEhJP/6T0JLh0vxfGcWGH16z+7g05ptgssX9NhtaGz9qUqdnyP28x
 dyOC71sewcS6Qr4ClVo7ZbN8UUoq4R6FwztT9g53k2Pri7aX48CT3phpT3/5F3Q15Ay1DiBg66J
 IXgfHzQxDzKd8bjSb1YfLJ17sCgzNqElPnSbGxUhg99uq4YxlxWWnqiq9NsJzzTmY7hz1BMgXeX
 a53K/Rchyq6wVDu/pqZTbPxmAbAXY8544dxfAgj/yvjXnbsVgumhhouhs5Hyc9ruC1k5XEBSa/M
 neXZrZdLrqbGftxUcPgaYCEsXCf3lCbkWsqoQeNRSNUG+4uOZ4RN5ufLvfjxHn/3MTHgvajiqSY
 hUVDysBprlxpBJw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=ceffb3DM c=1 sm=1 tr=0 ts=6996dd32 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=67SJ3es6nUsVzo6b:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=B_XyRL9OZNDrUfLvRzEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: Hpk8l0SDVXq9DmsdOnpRsbcmI5BBrCLt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5MCBTYWx0ZWRfX9Yqikkm4yThg
 b+d7OqKaq+pmHQx7KDDruBPsCTMa15aLw8WgCTeaTAj3caJG4Ir0ymNusjoYkPrJpMu0EBWQGMW
 kNPJQ/EKBmDNCfLKMd1+REpN/wQdIPtr06jwdR62YyvEsLjXCSFwqONsW3A8asjIFAeUKGl9SXu
 sN76HNCsA8c1yP+PDW1aSsVYPkVBx9sg1OcPuXuLBc8OzfnGmtoD6xV2pQEaszWa6S6o8uKpC9B
 BjJR/19MgHgIgu3Zy1rIL3R0OFDWrrDfo8xCbDgDpzVNv3eO4jOAcD2VST9QpGTqPUKd08Fa7Rd
 3Yb0x35pw8PakHAPTSAZY4rNZWkOEkDAnakmuFHe991+etJeAtjeVwBJIJzVewVO2VDTFuSTYAg
 BL8uzVeCNZvG9T/pNZWMuZPDeI0IZFJojSo/xKXqbGwM2MqyyCuiV+bshFTTrO8nB+s2FwVgpvr
 /xRR80tILilcjBGzzmQ==
X-Proofpoint-ORIG-GUID: Hpk8l0SDVXq9DmsdOnpRsbcmI5BBrCLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-217408-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,msgid.link:url,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B102E15D8B0
X-Rspamd-Action: no action

Commit 86ef402d805d ("gpiolib: sanitize the return value of
gpio_chip::get()") started checking the return value of the .get()
callback in struct gpio_chip. Now - almost a year later - it turns out
that there are quite a few drivers in tree that can break with this
change. Partially revert it: normalize the return value in GPIO core but
also emit a warning.

Cc: stable@vger.kernel.org
Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Closes: https://lore.kernel.org/all/aZSkqGTqMp_57qC7@google.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- it's gpio_chip::get() that needs normalizing, not gpio_chip::set()
- Link to v1: https://patch.msgid.link/20260219-gpiolib-set-normalize-v1-1-f0d53a009db4@oss.qualcomm.com
---
 drivers/gpio/gpiolib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..c9cd751e7de2307fc5994eb682c53f2b3ce39233 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3268,8 +3268,12 @@ static int gpiochip_get(struct gpio_chip *gc, unsigned int offset)
 
 	/* Make sure this is called after checking for gc->get(). */
 	ret = gc->get(gc, offset);
-	if (ret > 1)
-		ret = -EBADE;
+	if (ret > 1) {
+		gpiochip_warn(gc,
+			"invalid return value from gc->get(): %d, consider fixing the driver\n",
+			ret);
+		ret = !!ret;
+	}
 
 	return ret;
 }

---
base-commit: 50f68cc7be0a2cbf54d8f6aaf17df32fb01acc3f
change-id: 20260219-gpiolib-set-normalize-1080e2eda113

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


