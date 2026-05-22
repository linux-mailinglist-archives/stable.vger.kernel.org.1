Return-Path: <stable+bounces-253709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAB8CzoMEGpqSwYAu9opvQ
	(envelope-from <stable+bounces-253709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:56:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 895325B045F
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80AA03055C30
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1539061D;
	Fri, 22 May 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3jYpOTL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iXga7tUA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185C37C900
	for <stable@vger.kernel.org>; Fri, 22 May 2026 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436189; cv=none; b=qNIKI+vtKQd8PrS6ITXmZxX/8u3yYVje9hJ3ltzoKq/+1wuqwxrZIvIFEi8eYWunYxPfql6dBs1h6cdfzYtWmNhPQgCJFeD6751P1EcIEfwSBmqjcFpU0vOZoo9v+xLJpyuylcr2/qQ5H5IqFqthf9tP0ywUga500eP9bsOe+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436189; c=relaxed/simple;
	bh=l7kaeS3mGOoVOEW2iiK5UOwTHGrPoGsOER+L3RPvz+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LdptXnEs0vcf4RKsuYMb7Yp0U0Dw1Kc+t6wyPLHpwg4LorbCswfJyzJQ546yqy2S+6J7sg3nq/TrJFueAc1YBCGj9T1qwV63un9jfXoUB8pUumcJu83xk7hs7TIE3D56hyvW+Q7PCHxzLygfYPl+vmEX8JUzqzR5UHeasgdXPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3jYpOTL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iXga7tUA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M31pjZ3532248
	for <stable@vger.kernel.org>; Fri, 22 May 2026 07:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lwQPfvnXgWv/+L4IojXmsU
	UfCKlKS4NCtApexlElfgE=; b=e3jYpOTLlk4/VbhffE7bxWctpQVC5yUkGeNhlJ
	8CvaHWWHUyUJXU9AbYD8ZXUxfTqnFxZmOU03foesFYlvfZ04w83eMbs/fZ72gTpQ
	Ehk7sYGv7OZDijC2/fMqcPj7OiCr1RntIW9XEh3rDEOfPihlp5AmU5x5/qaArPTl
	igKCOzi3XkhPQDwo4sc+jM9xdtjy7U2lkhUop08BqfECu8lyIchFD+RmO4EcLBUJ
	eAgZ83AiiV2YLTipfkE3jD2wXs5idjWHC9f5IY72SzqIPyVRcRNx1wUkKT7UsTe/
	oy7FS9u9gQFBynWKLgzWl+y/bDEQyJ0Q4wfA4l7NmuN4+j9g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gutu0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 22 May 2026 07:49:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5165d10e036so109071881cf.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779436186; x=1780040986; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lwQPfvnXgWv/+L4IojXmsUUfCKlKS4NCtApexlElfgE=;
        b=iXga7tUAWVBTZaqewqfU9bBxVyt65fUjke27xZVz2S0wBfKEWSh1Nkz3rwEO5MdBKc
         COyP312gJlADwl5cp0UhPrX0Jyv5dToFKHAg6ZyMtM98vc8DuWljRXF8wAELh9Gq4nNR
         iA3kV3+I6eYu7LbeChqBD1X9NZlvMZqCzX4BgNEKR+RDZFiyULDSFUiREcOuyDHvSb5E
         73sPHV6SWDV6rKxh3lm21IDb3adLAJK238lTbO4Un3sLBQi6MwHnBeZy6BpT0ChJw8CU
         1wmHMquCEO4cb5hfhE6RE08mQ3umdimKy/dhSadM3SXjZZ3cBdT+hBJJ1jzMs4IoB8vu
         6naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779436186; x=1780040986;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwQPfvnXgWv/+L4IojXmsUUfCKlKS4NCtApexlElfgE=;
        b=gUZZFy48aPzGsD+e15nE/QES8odaGmCq3VjaxZ1EJT6A6XOzg/iDpiEY2aktUaP+m6
         oneVDLl5RTHLPTs8mCA816gb1ovR8MqZlBn9EI4P8W70VY1sUQrPBkC94AWRPo5vTG5o
         Q61pBvKO+oueR4B0rKoY77Bq0DVN9qc1af+fnpi682vc0eBJ7Lohh3VBtoHeWKTZ8LbL
         WZkBpNoQ2fgJ4wIHyh7oOyIip/q7hZ3zPAM2VkFOwsj03sWP//ZOl78qJWllRgzqnwS8
         gTGSXSmQiHsomGHJs9pAmjj1Jaql8Xm+B5K468Yf12YWFB8WoZKB/qHm62bc/iRBt490
         Tifg==
X-Forwarded-Encrypted: i=1; AFNElJ8WxLfcyfsrWCi1gmMf1E9wDjo8ayBBNw02bNTuzPztGJfKsw0daqLefxdMUGwkImKFvjWM/hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIuxBXEDrBAd4A3PIt7RueBWIivx2VRc98lS2+JYi9IKpwbMX4
	Zo23mnTZFUF1rkj2lK+w9oJUYA7s36NmusdjgWx62CnFVti2DuMfHiupTnU/8/c34F6DX72WoSY
	RjKIY3/EBNkD3REd/swK5n1opM+UnOvrAYhh09E91j++GuJgXZbJvdMdVAlk=
X-Gm-Gg: Acq92OEyEt2j1PSZwY3h93jODPC28kDK4/ixQ99TCspcPMgtVOfFu5cPtsk7I2sXX76
	DQP0paP5qVTeevqRFZ+0XpaWmMpefdjDuE0jEHqYkqpws3lDto7CF9J/TlSP1oGv796XE/XSDRO
	UrnYcuWov38bbX28WAgid1uCpnIgBGUNjoyd9gyhhnQbIQZa21swIjXjANErDTyDlnU2vJmgR9s
	Ux5KZgkczdvZqjmVqaOiaaTSdL44rfmKYCDKLvoqz5ZCmSZwtbzwb8H0qCrRxAxNuSh5SlbzmxI
	4L+9Tr6TIZmMaWLRzRlQy1FnYI5ODNOkP9KtqIBykR0f80KDoItLjV2zuH7tQujYYL7XMdtmMZd
	9lMjN5bukvBbyyLQtCobH7r8ZIobwGUn0KDlaw+n5dcy6u+dMPQ==
X-Received: by 2002:a05:622a:110f:b0:516:d781:589a with SMTP id d75a77b69052e-516d7815f68mr17380331cf.22.1779436185992;
        Fri, 22 May 2026 00:49:45 -0700 (PDT)
X-Received: by 2002:a05:622a:110f:b0:516:d781:589a with SMTP id d75a77b69052e-516d7815f68mr17380101cf.22.1779436185501;
        Fri, 22 May 2026 00:49:45 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm13175235e9.5.2026.05.22.00.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 00:49:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 22 May 2026 09:49:35 +0200
Subject: [PATCH v3] gpio: shared: undo the vote of the proxy on GPIO free
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-gpio-shared-free-vote-v3-1-8a4fddc6bedb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAI4KEGoC/4XNSw6CMBCA4auQrh1CH1Rw5T2Mi0Kn0EQotthoC
 He3sHKhcTPJP8l8s5CA3mIgp2whHqMN1o0p+CEjba/GDsHq1IQVTBYlK6CbrIPQK48ajEeE6GY
 EIxnnXDXCGEPS7eTR2OfuXq6pextm51/7m0i37T8xUqAg21LUUpYVR3Z2IeT3h7q1bhjyNMgGR
 /aJ0V8YS9hR16JCbXSj8Qu2rusbkvpaIw4BAAA=
X-Change-ID: 20260520-gpio-shared-free-vote-f62333ab4fff
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Marek Vasut <marex@nabladev.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=l7kaeS3mGOoVOEW2iiK5UOwTHGrPoGsOER+L3RPvz+Y=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEAqTRG1HZxmaYm7q4oMDavypQFhPok6AjTC/P
 iRg7XuPSSqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahAKkwAKCRAFnS7L/zaE
 w2v4D/9oop94b2Vz+NG97q040GCmVqo5BqJ23a8ZrkIvDqK5b7krJP8CrfXXdM9cziInNqDkDRc
 pJkj1kZ9fK4C84rM3Sp4G4O1O+sRbFXA0sYHMCScaF6MaA7hbwAGU5TmbdgvNfkTaFmhmw0acTz
 Q6j8fNvU412S77ryeQSf4iagD7N7gZngAsNHaSzqDZ1bPqAj23DFC3HbptXY3nn00hgiVA3xk3K
 C1HpS0ckD1HtvJwXGUzPDSKyTC6qd89jK0ovoWSDT2dOOLaGeaz7XBZO8drArNdB/QHp+DvK/wJ
 NJHBFyYXiHpG5VWxqeMD8qCF2fEL2AFxU/heJ56ptzys12MQvjIsdPmgpX7Z+ApmZ7RT/CbLHv5
 OVc6IrxON4M2QLS4sKNu1ghA2cK3bsq7z+z4HtVyZEh/6JNRl90tWmRCpRPqVd7vo8rqvQ8mmx6
 L1mO61cLXPSEKy5Hz92CHULxv/7S0KwWEfK5/b09IKnjaFC4IcUxyQPu3CZ3DiGHY12SOLETxvE
 cvW57YkiLl+wBMjy+TWIJGaVcuDZq9OGNBVv/GqwiQ9hOEQIrZpCKH05GoFKVY4uMhha/wiWLKp
 t2YTAd7KU1Z3cZa1gwrKS0vTI3C25giA/uD/94OYOaRguj6wpOEty3i+73aXo5q7mGYHFY9hpUQ
 erGkJV2FK7Mdfvw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a100a9b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=C00im2qEfLC3rBLg9RsA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: G4b9Qfg7yyUMjUb3gsj51gilYZYir6kM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA3NiBTYWx0ZWRfX5JGxvWy5lUfK
 vqPsFaN1GdaoQnHfs49xDozr6yeMnYzZpTigve52YpZ+EdIzPzvY07ZCkVcr4r0Ie4cpRs3cbOV
 dbeFYVafq16LHiRXpWzWvh/tBfaQRkAFJIq9RbN7zAAOwD8r7kYV9rlyd8w3cbKCAPFdNev8Jsx
 zaFe/wMb4mbGpijPaKfDMMwFTfjaSkSTgewaPz3by7whk+XhMLo8gLVjZCIQV1lKNJWF2CIjMpw
 Lp8Jhevp+YRKRVxET7jLSjVPAkTCteyJ+F8QLeG0xWhDcPxx1nhSQ7C5jwvb8v69MDS5xjjwcc/
 xQx7Mm1BKkiGYufNcj82yNcC01OQ5e7/5G9bMW04pRkBRfLQ56NiueJvo8XpCTiuePpN4zQbj7v
 3ccKHp+dhNh+r6Mjd73SCEsD9AcyyLkXWctkKWjTwVPA0PW9DVXbTsr1z0jA1doY8CbxXLl42Ui
 xUwCaYGKyXDCrmvWZ3g==
X-Proofpoint-GUID: G4b9Qfg7yyUMjUb3gsj51gilYZYir6kM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220076
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,qualcomm.com:email,qualcomm.com:dkim,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253709-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 895325B045F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the user of a shared GPIO managed by gpio-shared-proxy calls
gpiod_put() to release it, we never undo the potential "vote" for
driving the shared line "high". In the free() callback, check if this
proxy voted for "high" and - if so - decrease the number of votes and
potentially revert the value to low if this is the last user.

Cc: stable@vger.kernel.org
Fixes: e992d54c6f97 ("gpio: shared-proxy: implement the shared GPIO proxy driver")
Closes: https://sashiko.dev/#/patchset/20260513-gpio-shared-dynamic-voting-v1-1-8e1c49961b7d%40oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Sashiko commented on this pre-existing issue under my patch changing the
voting heuristic.
---
Changes in v3:
- Don't call the sleeping variant of gpiod_set_value() for proxies using
  spinlocks for synchronization (sashiko)
- Link to v2: https://patch.msgid.link/20260521-gpio-shared-free-vote-v2-1-7d948edfdbde@oss.qualcomm.com

Changes in v2:
- When releasing the shared GPIO, restore the value to the "default" low
  using the existing interface to keep track of the votes correctly
- Link to v1: https://patch.msgid.link/20260520-gpio-shared-free-vote-v1-1-6c54966583e2@oss.qualcomm.com
---
 drivers/gpio/gpio-shared-proxy.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpio-shared-proxy.c b/drivers/gpio/gpio-shared-proxy.c
index 29d7d2e4dfc02c34fb3f2abc343ee30b61579b66..6941e4be6cf1871b134c55c05877c9793de52ac3 100644
--- a/drivers/gpio/gpio-shared-proxy.c
+++ b/drivers/gpio/gpio-shared-proxy.c
@@ -103,9 +103,18 @@ static void gpio_shared_proxy_free(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
 	struct gpio_shared_desc *shared_desc = proxy->shared_desc;
+	int ret;
 
 	guard(gpio_shared_desc_lock)(shared_desc);
 
+	if (proxy->voted_high) {
+		ret = gpio_shared_proxy_set_unlocked(proxy,
+			shared_desc->can_sleep ? gpiod_set_value_cansleep : gpiod_set_value, 0);
+		if (ret)
+			dev_err(proxy->dev,
+				"Failed to unset the shared GPIO value on release: %d\n", ret);
+	}
+
 	proxy->shared_desc->usecnt--;
 
 	dev_dbg(proxy->dev, "Shared GPIO freed, number of users: %u\n",

---
base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
change-id: 20260520-gpio-shared-free-vote-f62333ab4fff

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


