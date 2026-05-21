Return-Path: <stable+bounces-253579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hmr0FiYyD2qsHgYAu9opvQ
	(envelope-from <stable+bounces-253579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:26:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7165A93DA
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EEC4324ED34
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787D93D7D74;
	Thu, 21 May 2026 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9XB55V3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K6w3FJZ5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF803CB2CF
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373557; cv=none; b=Kd1LkcLG8nwDoOO9NUnAUGCqhvJmId+XO0ydDtnm13ODIwruDUjMt1ohas5L4MXM4A9C5sNGsSIGuBhZilaFWSEmHz8CvpQF3Y766gWbf3sIujqrvJ4e39dX6Bxznqr+VN6n0BQd7XW/B4odnHnQMig06i0s8wF/lF9RXNQYIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373557; c=relaxed/simple;
	bh=xudBWpbKh+co3aDuIBbv0rKdU2B9DSmcu3U2VXlWK5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJv0kVLvYteMDJOQBkenTcV+Qi2ps9vTht4e7x+nzgvKWRth7pr8m95nIk5sRonA76/5IR0LZinixNuUpDHrfTAFaJNy4mb/Y4926df6DJXNza6+1jm2Z/vaORd1MLIAYse4KTS1YfN8ieMHpvlZPcsFTQW62OADHowrwZSa9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9XB55V3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K6w3FJZ5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99kLC3343474
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tMQyVE88XDjrg6ahIhjPSSGPMHVTkMapw+j6m54r1kQ=; b=F9XB55V34uutEFES
	gHVJrtHkexKPz2SS/ikQbt2PTIqjZ0mgl21sVwqLWqARDRmxxSrSXKZRdGlLR+aN
	JTtMKocdIVY9wvs3IoYsLJCLasQg8+YAEen8ZDDFccrorK/qfYRMdD8BHRki2nSF
	QFPm3UNxcnDg+5bTaPG0HhIDkesoIuvYoFFq66zlLChr394FDAYERvAQkfFjU3Wj
	BH1wQao05w82gwP0Fbnu+V938/MaBWiTynDxNdfibnAvr9wqF9n1MbBQEN+wLfM3
	+uqzCljUbn/0TqOUNog9nh0ptpGSLxi4111ccvKjMcitkplwxzitzXDuFhNu4UzW
	86sHJQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahsrmb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:25:54 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6314daf0053so3275466137.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779373554; x=1779978354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMQyVE88XDjrg6ahIhjPSSGPMHVTkMapw+j6m54r1kQ=;
        b=K6w3FJZ5xsrow+zpSus8isplPWbYGFZsZe2QeIeoFqFHHSCCh75j3FwGJ9Xq0Gx7Nt
         f75XDezRUy33ysxpymxjN2pZ9tinjM154p04eo00o5LtkiC9cmeCOTc6ycfEv6RCzeRF
         s+ACT3IheC9kVtQugvsKY6nABqODxgBWvIwHlfEMUeJLVlAbNm95j8yz1Fws8RgTbcr7
         oRfbbG+S7fuIKKwCQ6jsttbaL32eYOMBUqCjxOD2IRl8+lJeFGxrEmh5abk5YvjL3pGJ
         gWH/GfeQzWDQyz8QSUEzNL3CAVJDUqFrGditV/MJ64pYNY1UfGkbkcWxlMvrt6vxnaIl
         M7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373554; x=1779978354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tMQyVE88XDjrg6ahIhjPSSGPMHVTkMapw+j6m54r1kQ=;
        b=JX32rJM0Pu3gjdf2VHG4CZ6IwEUD7CWj6uIh3r2ihJt5B/PFLWkz5m2/aRGe9gWsbp
         d2VuQc9LO4yg0H0+l9VS70Nfc/lxu3CTge6bGF8ZOFTv6BAdjA10ETyvfQW+WoIq2whx
         20ws+fN3SIZSMRDCf2PKvym88NbQtv3VoVf8tuXQ1iPhlFrofFhVvz/2aOuN1fl5XAK9
         SIZugXI/ocx1w6H7FUwtxwYrfJk35dHj0EHA3hkEesXnJ2we/lMmle3EkQDgKcOH4RIt
         KL6fS9MsRyx578eSE3gFCA12cg1G+yl/eP5lGMFdy0mUXmTPBV87mcJ43bTCTB4v30sL
         VxkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sdGLTt5qC7rZk3HHyepDsNJCEEfjOausc1V8gAgwJw7Jae9Oo3gB53ZQRgJds+/2ZA6LQCJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDgc8RzQ5U4y0tZe60vabMb8zaps2M/rgISIDHqtWmbkdBRmX
	yEezdZCW1gF6sT7aRH5Qwp6UqlBUL7qBUImFhGIx/oOot/gba3vgUrCbGxiYougJRNjrbr3MoDc
	sZ2Y8sLfHvQcMAs4bjpVInmkkwC/pxqI9/8bmNzIm2BR91CdZDZcMEmCj1qo=
X-Gm-Gg: Acq92OH48Yyl0lJ9nC/CE6FtaEtwpoUlGO0Pec223F4CbWOQ6FhDk1fueYVDuO+Va6P
	zWgiDNrd0eWFjOKOupzbT64Ck7DIat2whxW09caxk1GaEag8/vj/dQdFF77SU6Ldna68cNPTKVK
	mqiof6MFMx73bsNuau3ig9MQujc3V8CFxR2qy3s6qsjZoVeuz22RSUh/GcnsZLgogdiO5WGhrJm
	niE9mOwfza9dCy7P9I6gSdCuQLKcajkGmT13TTxgJZ4xMcOdhoFwgntitA5CXEtnrP7/Aw1bN3+
	7JpsRy4xTTJIkDZQpL+waUTY5+ytgJZ/4X4upgiDAlc6jwVhxp73pyxkurw3KNkXfzwjPGiRh9m
	dlBdKYOWGbB8uBGdkVzsFZMtokgVlNWdHb9km/0PoVN/abcNB0Q8=
X-Received: by 2002:a05:6102:5e8b:b0:650:9173:ff15 with SMTP id ada2fe7eead31-6738e3d89acmr1649216137.8.1779373554106;
        Thu, 21 May 2026 07:25:54 -0700 (PDT)
X-Received: by 2002:a05:6102:5e8b:b0:650:9173:ff15 with SMTP id ada2fe7eead31-6738e3d89acmr1649150137.8.1779373553633;
        Thu, 21 May 2026 07:25:53 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903c9abbadsm30441925e9.8.2026.05.21.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:25:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 16:25:34 +0200
Subject: [PATCH v4 01/10] nvmem: core: fix use-after-free bugs in error
 paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-nvmem-unbind-v4-1-7fa136759491@oss.qualcomm.com>
References: <20260521-nvmem-unbind-v4-0-7fa136759491@oss.qualcomm.com>
In-Reply-To: <20260521-nvmem-unbind-v4-0-7fa136759491@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Johan Hovold <johan@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=xudBWpbKh+co3aDuIBbv0rKdU2B9DSmcu3U2VXlWK5Q=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDxXksMp3ZHVWueE4feiB4n2u7T7OGH4e8hlVN
 CkVQW1VqDyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag8V5AAKCRAFnS7L/zaE
 w9ARD/9U2dzYoSPDwKI9qazXI+xRdkR5dBSwA0T3CelgX4mBNHtpJt1qf+DiZf9rB2wheoPvB/1
 SCehWIko9Qb3UBRGjZrtRyhw5htbaJaV1u8zlrv8xnnF922BHhuhKj/jBPVUjpF1G0xvJhfmCns
 rgZ90KAAfw8NKK4z9pO9DY48XEPTUHiMtcw4euYbDEFazWXkFTzNm+TyQ7cL8020xsa7C4WIHqV
 i/wTD2xBmbMZxKhhiroUGzqv8H45FUmmF4NGUUr/SOPLbZABWdkQyRDAeq/wvxGyE1gZIckPo5V
 tecjpFGVozMenRi4jLB8eXybKICc8lPiEpD6TkkgDVltf1gf+WMxn7eIYQPnpPu9sTsVZeP3YoX
 XVqRqSFWgBLyszaWnwISWbkBnpGCurA17jcUDc2K6676hG2z5W525kliOQXNqX9Ejt+Es0ofAY+
 ekdtkFPIPviU5To2XDI9Lh0WW62OUJ21gRRKx9VI3km+gH+PFUsGvxs2AOetjCs+6ggg54YfXBO
 axxQfYr5uMKFDuYh1Bjo67LBZuAbsBwVqdxk0FDDtSIm+X0hY29AxLOJNHcmKHoxjgzK8qEvjsJ
 4etsw094lP9TblOztWGtJdhLUmhUsYy84T2Kiz0OjIkubnSTQTeL/ZehM0I5AGD25AfCHYC8eco
 lhp8Sjl1a6cduiw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0NCBTYWx0ZWRfX8t3PeoH04sQC
 uPNfBFzw6QhRnZe5q0QpsPcEXlRwzrQjpF39B0RBkRe+P+05EDbxXIkDgG6zUCIF4KUKjESKcrB
 kjlPtinGjGmA3f+UUv/rFLhZYnISDLfdf7U0yB+zVgHbVrkVz6CD050UrFNZmRTyBoizCjGltXr
 XHRsh7oyk1h/d9FxzaZx8fXPwpf8UzeYE6G25LCHb93ErPH9PqLb5w+XmhN+GiDxUyubv/pVjNa
 WrpQXkltllMJEZQ2AUU7FRtNLFG2gqn7XlSx2X3uujDwcXG7npapohCJqgwIh7eLN02+LmUErEr
 0DzalwiT8PfgQer5U3t469WrpxDSvWvycSY+3Ad6OzLzxUK3m1eHfubX3uQI541FA/wywyNrOyp
 DVR5nKOC9HY0oDvRmaV4qTyJ0V91ryjsUNm9EqWHKbHlwofBPsVrTiHw0ygYo6Y68mX3OvBVV80
 NVxIXVkaPsuiVtOLkDw==
X-Proofpoint-ORIG-GUID: ejyyQVeG2lM1VHHFaHZb03R5lDpbhvER
X-Proofpoint-GUID: ejyyQVeG2lM1VHHFaHZb03R5lDpbhvER
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0f15f2 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TrVhhfAylj9VslsTBVQA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210144
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253579-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C7165A93DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix several instances of error paths in which we call
__nvmem_device_put() - which may end up freeing the underlying memory
and other resources - and then keep on using the nvmem structure. Always
put the reference to the nvmem device as the last step before returning
the error code.

Cc: stable@vger.kernel.org
Fixes: 7ae6478b304b ("nvmem: core: rework nvmem cell instance creation")
Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/nvmem/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c02d2c6979d7c9bbb7f94abdfbdad1..e871181751f3c2739154b3cff27ef9b90032e607 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1468,18 +1468,16 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 	cell_entry = nvmem_find_cell_entry_by_node(nvmem, cell_np);
 	of_node_put(cell_np);
 	if (!cell_entry) {
-		__nvmem_device_put(nvmem);
 		nvmem_layout_module_put(nvmem);
-		if (nvmem->layout)
-			return ERR_PTR(-EPROBE_DEFER);
-		else
-			return ERR_PTR(-ENOENT);
+		ret = nvmem->layout ? -EPROBE_DEFER : -ENOENT;
+		__nvmem_device_put(nvmem);
+		return ERR_PTR(ret);
 	}
 
 	cell = nvmem_create_cell(cell_entry, id, cell_index);
 	if (IS_ERR(cell)) {
-		__nvmem_device_put(nvmem);
 		nvmem_layout_module_put(nvmem);
+		__nvmem_device_put(nvmem);
 	}
 
 	return cell;
@@ -1593,8 +1591,8 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 		kfree_const(cell->id);
 
 	kfree(cell);
-	__nvmem_device_put(nvmem);
 	nvmem_layout_module_put(nvmem);
+	__nvmem_device_put(nvmem);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 

-- 
2.47.3


