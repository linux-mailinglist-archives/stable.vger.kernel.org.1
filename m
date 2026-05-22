Return-Path: <stable+bounces-253721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NW/EiUeEGrqTgYAu9opvQ
	(envelope-from <stable+bounces-253721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:13:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F8B5B0EFC
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB81A3012D60
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEEA3B993A;
	Fri, 22 May 2026 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ln4/cUDJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F2gZfoEH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E839185C
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441178; cv=none; b=j/qh+CToEgw1Z+6t0FSAEb1XYOLCy4YcQasDEMp+P5gDOUKDWl9KALJujqyR2d+w3Es+OhH0YmhKstdM5Ju/yDt4+9fl+gNujBUXS4Rlacta2bRP4qp8hCv3NpbpHkEBWgYnV0QWhtt63e4QDmM1h0XTcFqjgp6U1GJmeVE9l08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441178; c=relaxed/simple;
	bh=ri6+7Mshndp9CACThu5Gvsc42fp7xD2GlBt6c+BQ99E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bf0Ny1HIZTF89SDeWcNfqB50bSKl2oE6ub3eDmOSZcxMokj8el+D//81j2LgawZxGm89lT/d4jAwuMjM9lLofY4+1LQnNy9UIqKsUEpxJ7OxJxz95XMZViO9D5vXRG5Yp87/65Y3l1f8xst4Ik5n8Wa1m4ijggQtIL9iD4OkPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ln4/cUDJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F2gZfoEH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7cTFL778711
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HajT9N9mhu8ogn6wOXsYUoUBDXAOvtcNKi4FVtUWAAI=; b=Ln4/cUDJcDDKJPnK
	5FTJORWlZAol6r+dc+w9vLf8Vn4mBisR9/7USVNPmlJIprG2Al5kY+KR0Z1Pd16J
	OHNNvGhNU6HBqgb0z2D5c7OGTnCYojS01W3QD80yvHVMpHeH+Ay5Zrdf5uRYwBYf
	LUTqwiAO5UlccGg9afFt5RJ97lT64Gaa/j2ThZ+iFLWuYEDSt7pkEEeaKrOpYaSN
	eqV4/Q/kqM6VzUsAG2yk2SpLf0T+lcwOV3c8jAcEVTYIAATggmOTFTqSqCG/jxxb
	3DK6dwovhPmKG4EuEf20jufk3PDbPWXco8MBZJUlp9ji91DK3k1MDEyC/wpGiwBU
	8ZuHZw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7asyjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:12:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-516d4b3f3a1so16581441cf.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779441175; x=1780045975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HajT9N9mhu8ogn6wOXsYUoUBDXAOvtcNKi4FVtUWAAI=;
        b=F2gZfoEHLcwHrA64TWOGi/FrBAuILSJtZha6Rm5D0qcUjezIXyH/60dLn5CnrmjD71
         epY/+VJ5KEfLISbLcN68bzfWcxtVhCcq+W3pI8iyuAWMuqKY4uMDYAMZHy/fxarpQB+g
         u2/u58HTs+QmtGsws+SRScAH15yQGHtuR5sH2pAst5RlcbuTqxssQeykYOiHN1aQLyCu
         Z6jrPZR44iNDAuBvxBfxsUvpx3FhwObGuteTz3qnr4z8BA9eB/joZPFjx976aTsxMFu1
         Dg+r2to86KK+/8jtTswwuUFfwhqkq1uMRVM/9ehmEptniGC9B1gNrpbN855ddSGq8YqJ
         4vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441175; x=1780045975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HajT9N9mhu8ogn6wOXsYUoUBDXAOvtcNKi4FVtUWAAI=;
        b=kkRd8eznNEDFZ+Psm8Q3dQX4qQbfK29XTl786hpbnUtuKKiM8zWKSVgYVCLfFEBNdB
         rGJWdVyEn+ENB41LbH1hGSHEQi+DAWQZAPXQsAmm6fwHptafyUB/A231p30zi6vQe7Q1
         dQxq447MycmLUSjR98H/qdm1FeSHyoD25y0vkfu6V2Nnv8r+UYcWXQgS5D5cfV43/I71
         TOEjwSMHV/PajH5To4KXCirQONlW8UanXaRass5lLJ1Ymb6jfufn0hmEBY5cZIUdrH7U
         OGm7jewKC+SOLvxG6qgH6517plzWxxJfRfAWPBNUcFWV2Dt0agj2DtolJNhtdVCz/DrW
         A1yw==
X-Forwarded-Encrypted: i=1; AFNElJ8rXsVS5Ljej39S7DRijGAROoHAySO8u4q+75kh5MWitWUjlaNq8dEDRbsPwm0Y2pqb7A6No2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyenHN0pMLUTwteeN2VB6q6//CzPeV1D/Bul005kFZ0YC5V1+/5
	LZvgb920x2cfZhMKs8le1jgcdGz1ueIqTjcI9ALu+RZQOSjO2r6tCsdlP16YA7uwQssQBjhvinw
	qtM2iQWoXBFvj2Nd/fRHtz3Y43Qk2EwaQbyb/9Fab8MeuLnw+tzIjjz/UY/M=
X-Gm-Gg: Acq92OFihkgnHD3XBu3ymjoNTQsRmwi7emVb7Zgz0VA4isGy77UhZ06LyE+TKX00Ddj
	9zsf8ndA3I82rQN7dxhVRL4KWfVrPttxBwI0uMa5FinlLLi1wiV73cXcJkDMIQEgA0pjNK1dmkk
	qaqIdnTO87hQ9cSu1xVKIQpAbZ83p1beXMI7qUYIKMjiSbPlVhsxTcMqDEAvm4VX48EMOHT051c
	TFr31x8ma67xiPL+59xHVgiP1oGdKIRfgSQy9xivLs7sRPNhSo+gR8XkavCfQIq8Nhn9ifZOrPD
	+7SXQS9T0qUyMke1nmX0L07VSPKz5x9anCAmRQsToe80m03f1sY3xQzGBebBd5LyzY95FJ/mUhq
	0BtTsYh9yZifNHzCHGfBeGeCjz5FVTi7CVQWLB6c2HXPsaGDfqJ6CEMd1/uJv
X-Received: by 2002:ac8:5fd4:0:b0:50d:b164:5e40 with SMTP id d75a77b69052e-516d43cc4c8mr37574351cf.37.1779441175320;
        Fri, 22 May 2026 02:12:55 -0700 (PDT)
X-Received: by 2002:ac8:5fd4:0:b0:50d:b164:5e40 with SMTP id d75a77b69052e-516d43cc4c8mr37574121cf.37.1779441174890;
        Fri, 22 May 2026 02:12:54 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4cefsm11953415e9.14.2026.05.22.02.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 02:12:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:12:37 +0200
Subject: [PATCH 2/2] gpio: shared: fix lockdep false positive by removing
 unneeded lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-gpio-shared-deadlock-v1-2-76bca088f8c0@oss.qualcomm.com>
References: <20260522-gpio-shared-deadlock-v1-0-76bca088f8c0@oss.qualcomm.com>
In-Reply-To: <20260522-gpio-shared-deadlock-v1-0-76bca088f8c0@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ri6+7Mshndp9CACThu5Gvsc42fp7xD2GlBt6c+BQ99E=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEB4MQ6AmKBk6QFHXbXtDeQb5jc8HuNdTWUKy0
 iW1+s72tHGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahAeDAAKCRAFnS7L/zaE
 ww/mEAC6K8uyY1ppER78tPcR+azjIeIs/QCFIRNegYsQFOGExdC066I9g/3VoGRpe9z5wgSz8R5
 Qi0Dj92NE2MTQyRquyFBVlx+q1A5GaMiEnbX7bxU/4+0n0FOGWFwvsoH3I4JH4B5ybePQAH/kbS
 lINxRcHqvnBDSx4UE1VyJlUYmhIk8HkrycOvi4jbOXKgLsp5NaMeiNDaoT3tTp86IXUFJylqk/N
 14dqX0JME9l+Ia/ORmM8AEzyDlVCqkCHLtmwvuL4lMfS3bvVJQ4+SQEqzPifjzfZCYS2z73395Y
 wVB7QojY9wtQsaJ/EZcs+bYikR7u09Ev0Bk2XwaWZfSPUpwmjWPA1hVQEyKGiKnfEtJ8g8B2NeF
 t89yMRwdPRnpT2Gu3T8MhfIrDrCQ1kapfYozQTIiDMJPWXg7u8v44VYkUYVLN/nNzIkGvLPl3+R
 34LVlyrSdm0rK0aSRdt09/2C3TyaKcBqLgDfFxAJVuNvi9Lxq8xqNSFg1KhBTJJxXNM2tZy+WDi
 EbODq1osOk1nF4ne9gjVLMlRJ+nSVTHeFaIorzyYpcdKsUjxtEHZgGz03/NoDsuYkLgI+Q68u8p
 of++X6VKvRx0eXnbU4cAfAXGcpcxyTPPXfm493WKU+5S7+klnJd9vYlq1xnrKxHeKwbLfhj8XX1
 KLKS+QRbChK7h4g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: -8U2FoVdS3l4BYgsTke3sy1mL3V0C5g7
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a101e17 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lLOHQsxOTyeWscW5USwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: -8U2FoVdS3l4BYgsTke3sy1mL3V0C5g7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MSBTYWx0ZWRfX7EEf3y2MGuf1
 yzrtu8ioI7/aIcgzHcLFzQ6uRaaLwDbyVsOLrKCjG+Fz3p2LknSC/PhEL8RvcWCaQdvVPSdRhf9
 U+hlwRjFo7DnT+Iffja1b/0iJPF8DUqMeAev8mkNVXFVxjXh1bdCjIVy0gbiC05tQw2NAmcikxM
 OCeL02LrO41TF3RDjH/ROxwsXantvvtdNqCm4WYv+PXQLJDUupaFp6g1WOdhmFIIhy2PFQNw6+s
 iVo0KC7g/f2zNyGTyrqiNMtng3CaJ5fFbeP1ufaPLzHAqPV5e5bSb7d5phe+UzO2NKf4UDBfFSd
 PakKLea0WiW89ZIIArL04QuraN/mYJj6dADDr3E+Z81bA/SgioOGBu6lBzlcpPomHK7Ogdht0/6
 GPHyhjrE6U8VU/oFtLdJ9rWLf0d8G7kKKZuDtZb3NpYwbWB08OsNuFRj0Ai+mnB37Dd+rUAub6x
 jwdjw45JWus/kTALdiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220091
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253721-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 24F8B5B0EFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By the time gpio_device_teardown_shared() is called, the parent device
is gone from the global list of GPIO devices and all outstanding SRCU
read-side critical sections have completed. That means that no
concurrent gpio_find_and_request() can call
gpio_shared_add_proxy_lookup() for this device at this time. There's
also no risk of the parent device being re-bound to the driver before
the unbinding completes (including the child devices).

Lockdep produces a false-positive report about a possible circular
dependency as it doesn't know the ordering guarantee. Not taking the
ref->lock in gpio_device_teardown_shared() silences it and is safe to do.

Cc: stable@vger.kernel.org
Fixes: ea513dd3c066 ("gpio: shared: make locking more fine-grained")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-shared.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 087b64c06c9f42b698abe5741e63102538beb488..de72776fb154f1f2ec97a3e186dc96366f3cee8b 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -605,8 +605,6 @@ void gpio_device_teardown_shared(struct gpio_device *gdev)
 			gpiod_free_commit(&gdev->descs[entry->offset]);
 
 		list_for_each_entry(ref, &entry->refs, list) {
-			guard(mutex)(&ref->lock);
-
 			if (ref->lookup) {
 				gpiod_remove_lookup_table(ref->lookup);
 				kfree(ref->lookup->table[0].key);

-- 
2.47.3


