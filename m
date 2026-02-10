Return-Path: <stable+bounces-215631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNRfLfb+imnJPAAAu9opvQ
	(envelope-from <stable+bounces-215631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:48:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A011915E
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7524F300E1B5
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD534251D;
	Tue, 10 Feb 2026 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HoOC4VIG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHbhihe+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A82303C87
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716906; cv=none; b=ktvw43aF1SUFfAfBMSuMZVZ1Sf8WViqYU1exJLzSRdfGfv1EdvcwM+s5C1J0tpLKj+2nAArP+B+2iFLvkspEHf0FJr2YZKof1oB0W3QQZBUcxKbT6SQ1VawryEAa4+LcjoipTV2BT3MmF7Ob4WMdFUr7WEKAVA/FYwviXnnb318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716906; c=relaxed/simple;
	bh=e3dSQfqVhgsxxhUTvmPgK+yGjRC63OjJTvyIHJC7OgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tn92tnfaoA3zKUhBEbki9NDgYEuOpwPMD4pErGatcJX8Z4VIeklPQlsmdLtMl4ZKno1bFfA++ZHcb382emO7rGSY6l1XBcnhfUv1uMKr/rR/JGNgAEfn8AgnLVvGaiGymKWhMCiRlm3H2BX6hcMRzokD/dK5knZ4N6ZL2jZEF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HoOC4VIG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kHbhihe+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A6cR5j441440
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 09:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=w/GzpqhughA55/Qv9bqwmc49R9hRD/5gwHY
	ISOiMX3Y=; b=HoOC4VIG7awe+AB/6dgXMBZjhYWM+m4P+GcVgAIq8Iowgtv/C3b
	0i4QsMl0yjqf1GMkOttxvv5Z8bmB8eQbPMhwj8O2BsMIGnP1pJsIPfKBc3VN8QIn
	Cs5kqQ5AhqtN2cMBpl/rozRh0Dh7w3oOzazlMxmYqvL4hLPg5lOMW34jqYef2F4Y
	ssLupxdq38ueRzj3u4WqSMya4UxTepXZ77yI9gDV93UNr3R4jL1PDw/CA2FKadq/
	6ee70YOxRufc1wnNtkaaMvpXLesPJsoBUOVmLuQzsEOMtEjgwGQ3fQ0vL8gMGfqW
	QkQz+gcDuS8ZoQz4atd8Qchr0fnrlvhM5ww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7qp9j3f0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 09:48:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52c921886so73177085a.2
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 01:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770716903; x=1771321703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w/GzpqhughA55/Qv9bqwmc49R9hRD/5gwHYISOiMX3Y=;
        b=kHbhihe+AUlT+NasCiSThl33Ivj3xhA+FLVw13aH2zrnyOULTOEGz0f5GgsF50w64N
         8qCmJ7+AA/e60GwuF2mb7WNS7na3bX9/CKJYmzP7dowBNUlRtT+8BLneiVv9iVJCzH/Y
         gieHUIwoS6hwDlbFiOVq7dd4UVLUUDli9EXI66anKpfqcTPplInJ2lKtXxqjH4jcRBtK
         dkElBWemTPXmdevpRMEHhfwJtzh4AuwadxIwGSxpfWbvMbFuR9bKFKEdi1jzxzRuRr7V
         Q2vbGabQJGDG9FBvurgVswxqi6SiYwiCo4u4x4/i138joP5Ft9TBZ0aur/y7rPdU3KoW
         dOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716903; x=1771321703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/GzpqhughA55/Qv9bqwmc49R9hRD/5gwHYISOiMX3Y=;
        b=XiqBCU61i/t7MjY6N30WdyX6KeHGL5xa5Vb+btbrrBJuwKOB91A+I86YrsgudxBs1C
         XdJ69cdeyzXuQepg+RfcETjC2tbTyUCcYtwZ7VpRWeRH+FvhFJo0YEGmVoTlWvRx1hwq
         rbpqXIGUEcWRt4ltrFUCu7Zj83DodZlHHQ6kSSUm3dKrITjOtqGFb2rNO9/E0CG0GcBR
         /YeFtTaEn/COUYJR71QuW+s++Oh1s9q+o7dFM4ilugVHXssd0uSnlthp7MQ/4BdfzkLd
         KTpniGLF8LMHHmZvCVcJ6hETCSyQooqFO9FHibmoMEjawZP4B+KpTrhvXEZQwjNxvzwc
         Wm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrnA5MWkXw96jisM3GYjyAUcbF2/cTEl8lyLXY55B3RFWINH2sOzbuz69GZ2QwVfALx4nTQjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykQ/eoH0yFyb6iJdxPKoUKTyqpTePRwWUtaAE8z8ICH6uVAcTw
	vFcdQ50hHbP6LCSrvKmV66MQkRcqvhOcGsftN9HnKT2rX5LkXK78fFkId5h/2vH0H08F4lICsa0
	h17AYM++zkPSnSC8dbbsTytvn8wZ89KXcuqtTy8RYZ/R3uiqbR9+/AaH8UUw=
X-Gm-Gg: AZuq6aK6vr+InXv4YFpdM6radmfEZ6o4eMec6YfFVMcHhswtPy7qnWE2Hqh6GWhnvFO
	nB6sAFTBPAcF2kTkxQXXsboB50irYHDaxwvRVjHkA+8UBX+vFB2/w4JcoGj3zNbtOwUQ4Z3AGOL
	52ATGcDcJ7jv0nClJs12yTmenXjc78ZpPq5z7D50D1oh6MsIoYp5a9hNnlbQp2ON6J0H0yQD5ih
	NhzcOSiwd0iA/hbSgaoq0n25MBOzjzsLZr3IjdLMOBodQVhFUULBEpnp7bOrgMXBL2/K9xoqgNE
	qpkXIodSrauZYXm7f009P2c0w3QsY49FzlVzL1HLB/KTjFy17zu/olQmMfOUfxf65o4TOTODfiT
	E2fDyahiBIm0pMQssRXCaZ6EPMK9yKYPML6zFCN1aGjcpyrCpefE=
X-Received: by 2002:a05:620a:45a0:b0:8c6:a28d:b1e9 with SMTP id af79cd13be357-8caf17e757emr1814101385a.84.1770716902618;
        Tue, 10 Feb 2026 01:48:22 -0800 (PST)
X-Received: by 2002:a05:620a:45a0:b0:8c6:a28d:b1e9 with SMTP id af79cd13be357-8caf17e757emr1814099785a.84.1770716902159;
        Tue, 10 Feb 2026 01:48:22 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1964:f977:ccfd:e173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376bd5a074sm15492135f8f.11.2026.02.10.01.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:48:21 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] gpio: swnode: restore the swnode-name-against-chip-label matching
Date: Tue, 10 Feb 2026 10:48:06 +0100
Message-ID: <20260210094806.38146-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8ovQF9gJBB5woOoIFu7vVN6JS78iFDLH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4MSBTYWx0ZWRfX59avWz0i22i/
 pDSIJg02Jdm9fyzhOn74/27xW9jTpVYQrZXiw3ouP43BiDh6DTUvYXE47veXBct6DO0+q+XVOZg
 ZmPl+3ALETxfQTG45fB7tmwIBOE+asvIDUa8ECKXGWTSMxdXM0nbQXYMN+y3gQ2O0jDNy7XNObC
 2HsZ1ktU/aYLbdprnmDiavqoIWcOsUeaGb3RSkYgnwmsRjvM+vaptBHmd+41khgx+JEALMZ5Ijm
 VftHFiIGYQhI0bjd2MXdW6pbP0TufZ45aJmHTeGAtNfN/qQAvLFDJcdV17mUz6/pOW8wcG1ZvDW
 q+Ehv/NH6YVZ6B21UI/HSFbyf8Rb+7YICsAhoRuqKi1aiXqru1N73j1be/FTgD9qSsUCJJ9L8JB
 tSw2w0cvBAaUiL2tcXtyfhwoo+EPQEh7HJal8uKtc8kWt5VxdxU2RbaUPxbJliKprVAeLdKbrIv
 pX8z8IgPTXpg3U32Mpg==
X-Authority-Analysis: v=2.4 cv=dP2rWeZb c=1 sm=1 tr=0 ts=698afee7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=4y_y0rSijc1pqmNUuoMA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 8ovQF9gJBB5woOoIFu7vVN6JS78iFDLH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,linuxfoundation.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215631-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E50A011915E
X-Rspamd-Action: no action

Using the remote firmware node for software node lookup is the right
thing to do. The GPIO controller we want to resolve should have the
software node we scooped out of the reference attached to it. However,
there are existing users who abuse the software node API by creating
dummy swnodes whose name is set to the expected label string of the GPIO
controller whose pins they want to control and use them in their local
swnode references as GPIO properties.

This used to work when we compared the software node's name to the
chip's label. When we switched to using a real fwnode lookup, these
users broke down because the firmware nodes in question were never
attached to the controllers they were looking for.

Restore the label matching as a fallback to fix the broken users but add
a big FIXME urging for a better solution.

Link: https://lore.kernel.org/all/aYmV5Axyfo76D19T@smile.fi.intel.com/
Cc: stable@vger.kernel.org # v6.18, v6.19
Fixes: 216c12047571 ("gpio: swnode: allow referencing GPIO chips by firmware nodes")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-swnode.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index 21478b45c127d..c88313b0026b9 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -42,6 +42,25 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 
 fwnode_lookup:
 	gdev = gpio_device_find_by_fwnode(fwnode);
+	if (!gdev)
+		/*
+		 * FIXME: We shouldn't need to compare the GPIO controller's
+		 * label against the software node that is supposedly attached
+		 * to it. However there are currently GPIO users that - knowing
+		 * the expected label of the GPIO chip whose pins they want to
+		 * control - set up dummy software nodes named after those GPIO
+		 * controllers, which aren't actually attached to them. In this
+		 * case gpio_device_find_by_fwnode() will fail as no device on
+		 * the GPIO bus is actually associated with the fwnode we're
+		 * looking for.
+		 *
+		 * As a fallback: continue checking the label if we have no
+		 * match. However, the situation described above is an abuse
+		 * of the software node API and should be phased out and the
+		 * following line - eventually removed.
+		 */
+		gdev = gpio_device_find_by_label(gdev_node->name);
+
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
 
-- 
2.47.3


