Return-Path: <stable+bounces-253720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJeqKhweEGrqTgYAu9opvQ
	(envelope-from <stable+bounces-253720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:13:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F55D5B0EE7
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC4C9300E153
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0DA3BAD95;
	Fri, 22 May 2026 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kIl/1b+q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBCCYcAe"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCA25B08D
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441177; cv=none; b=ZBd2g31MTM16JVvtsGjgD7etzferqCVmmWKGPCb3EL3zcUudaUL12i+IMyYG8gvrZ6jKR/IuHL8weumGcA4UCfnI9bjEMekqQhlM5ldgU/MH3N9YFFHxBalpYLvUnbcoM0U6PLpPRXxOM+cm6KKlmf7V0gMoN1Eei7q8NOz9fZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441177; c=relaxed/simple;
	bh=s/zZIjFeP8/2k81esWo2MCwCvK3NUWqItzbOgSvm+XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrxOgy/5IDKoeR9W1LStOZpLau3G57+d9rbF2trQwJz7BQSS5NfVtfVEed+T54yu1LKCo+5geSJAd89wD/CZIM6YUQOdKMcp0ekvShDXQV/o9oeX3jNHyWbVMDvKCrP4l1xIl3GcV2e3AW2KFphjIYW7QskdL9hUwaEeLaHuQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kIl/1b+q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBCCYcAe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M6UNmP1959419
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K08GxGjbyjk9lS2Rm9N/zaIGPK47NJLVvBwRaxBMJg8=; b=kIl/1b+qYIrHQHI0
	LdxOsHC5mDFatqNAlwDeUN2kdNBS3LML8Bey6NMhML2aX1ZG3EbvCKpaoCHydZty
	EzSXcF+LrNvqdqfd1RRe7LkkS9Qtopuyle5BkSGSM1NDW4YT/+habWRW+s7ukrkN
	e1Nsqsr60QQKDsobXUx4wSeIuKNsckjm49l9UWW1WbaIcrh1BaU8vFJr+0yTmlyD
	T9Lu+OC0U0CZg/oIJD0hKD0eNu35V/sf33naliJ64hwPgtWHVob4hp4/6vDdjazO
	20aIItoNVXrbzWfVfY+lNyyQykY5DIfQyeG7wvVHLVpPJdauEWfV+b52lDeiG3gI
	fuuaRA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxersjc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:12:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d8e8c47a3so56368741cf.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779441173; x=1780045973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K08GxGjbyjk9lS2Rm9N/zaIGPK47NJLVvBwRaxBMJg8=;
        b=LBCCYcAeq19xjZCLgfQGCFY1v6zegv7e5YJy5zPHRhs3F9Bp6caeBymXQd6jQ5hSZz
         R4rInaczlBEPPTJ3wci/u97vvaPoDD5b0P4dm7icrKikdhewZbQ7vYv4brjd2sUbjNkG
         ooIqw0ySewOFcoyDmZ7Jea5rH1TcxuSZU20czc1TMA7kVrbc63NoYfi7n2Zg+14OSsNA
         5rFOJY0PvSRIhqkGwxP4eXQ9ecB9OPIb68EN9h+l0uTI7Dd3DH3aMMd+c7Hp7MlYjGa1
         tUWHDFpJk5qVNJ2freKV4orsjaldzaqLpTTK7xekTCVziktzzn2sum4l1AHNJQxqiffV
         gEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441173; x=1780045973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K08GxGjbyjk9lS2Rm9N/zaIGPK47NJLVvBwRaxBMJg8=;
        b=Xecb23v8rl49tESl9HfuTGCrO7AlXDl32+nIjwnAFpzHiCZ2Q9ypiGuFWlbCFOqxGM
         FbhmcE/4nA1tK+XEViehPTwfSH9L5PioVG3dkLlog4uen++yq3yvX51gq1yHrbvPlEPU
         1RcKUYnUYOUFpwFldp1D4LlwgkV//Tus0LXRP2GqPYI0Axt12T4exE84r1hGhLeA5khI
         ESR285IYOqeu5F78AT4hFgVuG3mmvbSb93b1qBiYjN0hgGyOBBC9GrkriDeotOvkevF4
         iV6cMDWtNoVzwOLGFHft13WTq85ACa+GjH7cYwZBPxtCa+4mY945qMgECdVq9Q08F64g
         1oNw==
X-Forwarded-Encrypted: i=1; AFNElJ/3sQo2ydPRD0klCJ4vV2gfHasku9sKuquA4p568GZKhUKCG7NwJVP2YrIj+FjIgcBD6bu1nuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9EOsPF3sgtZVzVJaPAxEV60qCV0qpD/0aVJjPD8+E6cpaTr3
	/eXY2+Fgoy6Z5gOGnt09TUOSBGt/W0gMVnHZcS7e/0NDL4WIn3GNhY6OUwmdY1nP+uXSbsidot2
	C9q3kgtuDd05Bo7sQkYHvbAWVjndRkqI2WTduySUVyDquIKmftgqZcE+Iolo=
X-Gm-Gg: Acq92OFaiANVXgoJeeDlad8yXyGni++GOY/yezM40j8LY4uUUHGldybp7jtjZUAvQj8
	oEtcDQ3b6VBogeaHVbjmBz7btboK125xwqSbePBAoTE1PRaDzkpFevf5gPA6zbAGcCcDv9kCogZ
	pGeY1ruihMKGWU4e2ygIIEqWyqtwTETL4BQe/Ailed5DqzrMJrsrVx/Aqa784o+x1pVnfB9jRub
	rE5oJPSlrwHaaHZhpbLkXQ2qx0wlUGONF1ub43oNYooLVjtakacdDX5UKJjPNw4spZqijL67aRp
	UeWudC/Tf2MWyA3qKQ5jGAqFaZhzbZuioR9niPjP+UnwYWW+wl3I6cdEgFUld98UgkRFnaQkNKt
	L366V23SOz668zpgzyErNX5uJhHfnMyLPLODOErW4lmaiHu1zfthlVxsrvuie
X-Received: by 2002:a05:622a:251b:b0:50d:60a4:47a7 with SMTP id d75a77b69052e-516d429dc50mr38668011cf.4.1779441173480;
        Fri, 22 May 2026 02:12:53 -0700 (PDT)
X-Received: by 2002:a05:622a:251b:b0:50d:60a4:47a7 with SMTP id d75a77b69052e-516d429dc50mr38667811cf.4.1779441173067;
        Fri, 22 May 2026 02:12:53 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4cefsm11953415e9.14.2026.05.22.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 02:12:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:12:36 +0200
Subject: [PATCH 1/2] gpio: shared: fix deadlock on shared proxy's parent
 removal
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-gpio-shared-deadlock-v1-1-76bca088f8c0@oss.qualcomm.com>
References: <20260522-gpio-shared-deadlock-v1-0-76bca088f8c0@oss.qualcomm.com>
In-Reply-To: <20260522-gpio-shared-deadlock-v1-0-76bca088f8c0@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=s/zZIjFeP8/2k81esWo2MCwCvK3NUWqItzbOgSvm+XA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEB4L290UDqcHSoJPDRdplmBHWS6z73Y5PvQmx
 9FRbwt+SJSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahAeCwAKCRAFnS7L/zaE
 w4J1D/95G3XAKIR96aO2aPxKtvZwZFLE0M3ofS8aEoe0ThqBN5Q0q5M/ZJAr3PICi4pEwSWecEv
 220tdJtVX3CLtd13CNsfKiCAJ6+NbEouviq+ZV2T/KMfyek60fgv81NNGQY5eNJRJ5gc+Rw+XQE
 xdOqUl+hC/EqvrcWHYJsrw0CqSIMrkHmc2zIE1HQ+y3IkLtmxq9szAF+oOBJjbq34XqobkHsLQ4
 UedzWjZySmwkmdSh9RzTuiaJm73uwrS94v0BZo2u/Zx7qoBuixcKCVKP02UaSzInmq7knVmQWob
 roNY/kS8Ce06NjWVQLnBMWxuShNeajh+4dETWmTPimOOhrO+xAHP/q2j9OaN5R5SVIuDjJ8cRCY
 AqsVJ7HJP3nwQBN6DmKndYEvaBJ+EKMpykBAaeI+CbRpFhRouOwZVTODOzYdjSZZQs5oLdCWTJy
 b9rXWh5FvT1kMsg7lRSUzuTa3baeyoudN9J1wQRMYIPZBmo+wmbcS5Y8dW7VcsCgbnDwGRBjHOj
 4BqJ5LY29/NPqMT1626pm7TP7eRPN+ukffYfgfXhqm2cNAOdMSeuRGjpOChM4XMnRZ2mgERizqz
 oQAUApsl96d9wjoyozPWOkEEBxD9wK+KIVtYtYfU85I9xciY9lBd6KMBNzFUeoYVx8jwHZbFLwU
 rcL0OGXMJaw6Piw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MSBTYWx0ZWRfX5U0h8bFEcdgj
 dBjFYBnJ6gD7FKEgGlmpe5F7HTSbxVw/GTfKs6EppxTiyt+/20F/GF/u7BpMdzRu98msAzshTbj
 1JtcqAdt1Pf5xmB7CO7vgRvE24G42EbC+1Yi4dAQvj4yMM33+fPWidmkynGak9si4tOoBvP4zHV
 SCoR5sh0flk/sCjnZyWD5Kt/2/jADPn4xgu0Vq20No2uR6w/narFtEcwVwz7TuzxxODadjBedF8
 dt4cfcAKP9uKPY61bLc+9S3gD/Cvr1kyfrL5cec608ritrwBT54iQLqeBfhibtA5T/jcX8Nw3+Y
 y+GPiY4nw1SSRd0gQ4uEUdQN2+34HYUaz0lhQbrm+m9uqb8/kPU8A6tlZFruM8A1jmn/fMnqMrH
 oAu1hCMjM4gT4K+Wg+zo5Xft+bd3Z1tx4EUthkxey1RXgq78yomXeCPNf1XAT6BHTj2gEPWk0iS
 cse52MHb1QVNtMnBz5w==
X-Proofpoint-GUID: 4h2Q_BBZw6YTlbcdzdBZfGKs2BucUTIL
X-Proofpoint-ORIG-GUID: 4h2Q_BBZw6YTlbcdzdBZfGKs2BucUTIL
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a101e16 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JrNlowrVSM02oZUCpr0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220091
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
	TAGGED_FROM(0.00)[bounces-253720-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 2F55D5B0EE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 710abda58055 ("gpio: shared: call gpio_chip::of_xlate() if set")
used the mutex embedded in struct gpio_shared_entry to protect the
offset field which now can be modified after assignment. The critical
section however is too wide and introduced a potential deadlock on the
removal of the shared GPIO proxy's parent.

Make the critical section shorter - only protect the offset when it's
being read.

While at it: mention the fact that the entry lock is now also used to
protect against concurrent access to the offset field in the structure's
documentation.

Cc: stable@vger.kernel.org
Fixes: 710abda58055 ("gpio: shared: call gpio_chip::of_xlate() if set")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-shared.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index e02d6b93a4ab42b197f0fd64e4854a303f54f140..087b64c06c9f42b698abe5741e63102538beb488 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -53,7 +53,7 @@ struct gpio_shared_entry {
 	unsigned int offset;
 	/* Index in the property value array. */
 	size_t index;
-	/* Synchronizes the modification of shared_desc. */
+	/* Synchronizes the modification of shared_desc and offset. */
 	struct mutex lock;
 	struct gpio_shared_desc *shared_desc;
 	struct kref ref;
@@ -598,12 +598,11 @@ void gpio_device_teardown_shared(struct gpio_device *gdev)
 	struct gpio_shared_ref *ref;
 
 	list_for_each_entry(entry, &gpio_shared_list, list) {
-		guard(mutex)(&entry->lock);
-
 		if (!device_match_fwnode(&gdev->dev, entry->fwnode))
 			continue;
 
-		gpiod_free_commit(&gdev->descs[entry->offset]);
+		scoped_guard(mutex, &entry->lock)
+			gpiod_free_commit(&gdev->descs[entry->offset]);
 
 		list_for_each_entry(ref, &entry->refs, list) {
 			guard(mutex)(&ref->lock);

-- 
2.47.3


