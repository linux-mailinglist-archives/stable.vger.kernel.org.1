Return-Path: <stable+bounces-217902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGq3EZ+BnWlsQQQAu9opvQ
	(envelope-from <stable+bounces-217902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 11:46:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B05E41859D5
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 11:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88DBE30FF9CB
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51424379974;
	Tue, 24 Feb 2026 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4DOzgVA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dw+dG3XU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BB369979
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929832; cv=none; b=TaB4CU4IRlNzTVMTBgA4k2i62w0HAWTLkytLl+tW/s08/a8/QImhHaGYa3Ui2Mwvbaw2rzmHyr6bi6m5Pqft43sL1hbHnAqN5vIcIuWo0JCbmRrQZRYi20c0DhsEyQ8SEyTmG8gGBxHA/gXe8nCykMe+3vAG4Nt8EEREVTt8szA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929832; c=relaxed/simple;
	bh=rdvBOwT1w+fOKzKlMJ4qCaqyF5VXzQXu8RFGhV4wPWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYi/oN8WU1B5OZtk+jqufcvS/rxaDPzaajCSiaHV6FJvfTmVkvnXg7v4+60tnwujP73XK8FTAtJmmFqvLRqR/x6gl8iziEuJHc8ZkQ1tURvKtwsw3EvnRLIWlyF+vaQ/cvNO1Q5FpYwORaivuUZNuhWqJpJ6rWlHgDT2brDjfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4DOzgVA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dw+dG3XU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFSQf2284563
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dcx9Fb9RAhIPBMtW22u+1jg9hETgYE9w0yg+16sdIuA=; b=H4DOzgVA83UHDgOM
	VVUnvWAYTLNOLPanpo4QupRYaWBh1QxF944TCbYx88pbymRFzDVawGttNM0lIv1N
	OAIJordGF5UDSK/c+qa+HpzR/3laOnj+Vq8+dUUI6f0+VqjvNHoF9NNbgs6slhDn
	usF4sPZ2ZO1C8eEJPwL6rd9Nk0CNGDVcflRdQref2T9u/ORNXr2kIbOTL/WYf9zX
	93cyZ8xqZ3nx25GYa0Kyx8g5utiIACl349wERwD/2WxWT4ConMD/lA+AwFBwhfss
	Z77+KjN/3XFhyxvVhpVf3xhAcQIDrzVrD8WMt0Bfl6Nz0Qc5Uu+NGFcxFtEbxr6A
	o6MMGg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtx0ascu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:43:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb413d0002so5542686785a.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 02:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771929829; x=1772534629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dcx9Fb9RAhIPBMtW22u+1jg9hETgYE9w0yg+16sdIuA=;
        b=Dw+dG3XUQUm/PHFpMKyHM8ZqNyUBhAV0OLKIOp3C1KQZgiCiMZm0nejujuse6sDy83
         gg9GBBzlL1nO0vzkMsbjXpT7RcspqsQxIAhSvit6lpUJGv5gkelMcMntBJbm+qQr+UG+
         19w5dYgdkanqXnu63H0mw6k7NVFrl6XR4j5iID4RBoQbbRTOWEL6Zp+stEP8Dl+O569B
         RXcWYiD7a10yU+Zusc/ACVjeNSYcOx4qdXci0k7H24m9mhmje8gTE8baptXutAWZEU8a
         zrJYlPG+cNEt6nxY1QcGUC5RG4XvWg1OihVXLPmI6LyRw21fyoWqsritMl30UOM2Z2aT
         shzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929829; x=1772534629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dcx9Fb9RAhIPBMtW22u+1jg9hETgYE9w0yg+16sdIuA=;
        b=D9WWM6eJjBdv4RJPTHq8BLtYZ8awTFv729z2IDKng3asLitL/1o+dIB4GxoHhxV8Qw
         e23phBOsPQY01+iR7kYIui241paKeeBCy7DgvYRJnYxt+KPuwBqRVXhPe146CEorLonb
         EgPACl7qjSH5pW3Jgvc+WTPPf3VsbX/zQ/DYIt3q2FVEZH8nMLq9WABDWcUMIt2qljkt
         E9PLeGPsVbP9iDYu3wmRnfWh1M55kEvBowJRmQg1RK+3sHsXRe0Er3gqm9ofajmg260G
         uoD/fMU2AHlAXyABDQip+oXa9nIdiXgIMTIeWVVimJzTeQS+QLInOHlwbf4aWquGMcra
         v2lw==
X-Forwarded-Encrypted: i=1; AJvYcCVYJ+OQbL+eq04nbeeU2PMaM76WD5yjEfIIjBdwU2DRGBRq8D9w17keKRjqPASbYmazQdRexfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG82hCFNUs0VmHsGzehwO85Gd/THsMvzZT0l3J6ImEaPs8+CXQ
	YJXgcr8OwTi59sk2LZGynXbwR9jQf6wrbF5Zgj5TJH/rLoA3RDSegDfDkXMTl+a82JkW3LhESuG
	kMQqS3nhZFXSVxOfKJldubZ9RV6yFgVRR0eitcxpltQtaFMWcN+qwq4BARKQ=
X-Gm-Gg: AZuq6aJxVuSWZQlRFCD8LBHbkujBo+7aW64+6WSZuMskPDiGI33L68CaAO3dq5FhbB+
	ZJXelxip0OB+gu67wISYaCvjZS3t2rQhvMfx0jdstoRN2TtPmGx6SmVMa6ZdRVGBWAcYxCwebwy
	2Qw2QCe4fCI6w2H0FiZtJtiHpuaall5RqAhx/Dofj0yxXHPSC8Yt6kL894ZttbuYEugszyXK3Hn
	wbMneEv2e5G87JqIV/s+Gr/L07uNKDbO2r/R7fmT2fnueGJTLoO0avKmvm95Db45GUBK9481M8e
	3s2CVv37uAH3Zm6hrX+XYPKYgSiyLGPEHDbrqDJzk5rKfI0yBeRbOIazF/Oe7M6n+VEh6blH6BU
	7V1wQ6oUSpgCMpK8UqJW32Gc5HUUurykS7IkFHMSclFcryA==
X-Received: by 2002:a05:620a:1a20:b0:8c7:110e:9cd5 with SMTP id af79cd13be357-8cb7c02208cmr1910193585a.45.1771929828464;
        Tue, 24 Feb 2026 02:43:48 -0800 (PST)
X-Received: by 2002:a05:620a:1a20:b0:8c7:110e:9cd5 with SMTP id af79cd13be357-8cb7c02208cmr1910190885a.45.1771929827852;
        Tue, 24 Feb 2026 02:43:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d40004sm25685906f8f.21.2026.02.24.02.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:43:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 11:43:39 +0100
Subject: [PATCH 1/4] firmware: arm_scmi: Drop fake 'const' on scmi_handle
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-handle-not-const-v1-1-90bf93b53e27@oss.qualcomm.com>
References: <20260224-handle-not-const-v1-0-90bf93b53e27@oss.qualcomm.com>
In-Reply-To: <20260224-handle-not-const-v1-0-90bf93b53e27@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11852;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rdvBOwT1w+fOKzKlMJ4qCaqyF5VXzQXu8RFGhV4wPWA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnYDdTaa70Ye5luvvU/8VfllC+pftv/qtWoBPV
 3buBcqZcgeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZ2A3QAKCRDBN2bmhouD
 1w8QD/9hJgj7Ium0TabC0RFOre/lPkhH80ZbNT0C7u3H72t80b9a9oXATiFxDqfMFn7onM2QmAQ
 M4iQ2VLzIT5u2i+dE85kbk7w7BD0HDHX8iTDl44DDfudhhOlhZIf+qq4A+cd+MRNHv7FoB4mSH8
 TK1K6BTOytpaQM7P8BDz/qeN19Guercv31IYV/0yQVb++rV3G/CiRM1vVjiGs+MCN/9bPxteGyE
 q2vKegAYvp0KMqdMme8RCTB990GeOcrj1aaKnidRgBo7hiAgmWf1aTSU4gp4zKKYWH4rkM5+7/A
 GFECFw2Mfp4QPs993wWOYvruO0jWC21EdKKZ8hQDe8z7QAczC8IdyKIUsBYI88ocldlc1W5k8LN
 ItvOLcSqCrUmIgd7jzTEkUComIAui37o4BAndrsxHN+bRa2AcB9pd2Tu9/2VeUOII88WUFYMXDM
 D08TbnJtqxefQAH6hKwHG3Dt2RO/P9xlmJNL9qNv9/KIE0/XPzBIh+VHyQ7oix0ifPWH82/8N5R
 m6I+MXPgn/artpE+JEa/PQl8qaVMuywYXgLCvNg3OtNb0ABfYVXppKDZt8or7dPZb5MnBGlGWaQ
 Kfiv7JuRUsLv8gHLiLKG2JjlbrMTpWL677RuQ1Mvy9LGMr6CjJtSSCsFy8IuDsVTzc1+qrymRNx
 M4z9//C0G6j43wQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: Fou9xHvhKLJFUl6U34YeX91Jsi_3uaav
X-Authority-Analysis: v=2.4 cv=euvSD4pX c=1 sm=1 tr=0 ts=699d80e5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YWpryjrgZ2of67SKuAYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Fou9xHvhKLJFUl6U34YeX91Jsi_3uaav
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NyBTYWx0ZWRfX/mT6SSeoRNWO
 W9L4beKvOKX+epD1PYk/aZrGuQXJJR1OIC/5WKJMLTqM6ti1rSNj8yrhVpnCdvAjAO27hc0bnJN
 eRauun8hNrfJbMRWLXsjW2Ny4e/DlcnoluIWl49kBrx+kc6cpSFS8SRQ29vaOWND6WGFu8m9Fc4
 aPiOsA4iicWP5VOe0v+6w0hT+SeDpt90Kun9F1b9qRflqRG7ZvgL3J3aOAtxp/rbPukgB+t7BS0
 oY4ksrFF1zdjrCnFK/HTbXQOt7ikWvzZ8hRlmPmMa7h6PdIb2SQp2KjOum08VeAuVaMU20LQ82F
 mwKKrGusUjReOfK/QQoi3O/BclS3bk9ynUUI+b0kdpAYrgNKCJfVYrfMtv2kWMSp1Cphskb04xG
 PIVP0ldTi4ADL7AjkVz4ykYcPWp2erOHTsPnPG0R+mE/zjuoWPA11P+5tziLLteu95Vsj6bazhX
 qD1oVmuZtH5GMlXLe9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217902-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,arm.com,baylibre.com,nxp.com,pengutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B05E41859D5
X-Rspamd-Action: no action

Severale functions operating on the 'handle' pointer, like
scmi_handle_put() or scmi_xfer_raw_get(), are claiming it is a pointer
to const thus they should not modify the handle.  In fact that's a false
statement, because first thing these functions do is drop the cast to
const with container_of:

  struct scmi_info *info = handle_to_scmi_info(handle);

And with such cast the handle is easily writable with simple:

  info->handle.dev = NULL;

If the function really was not modifying the pointed handle, it would
use the container_of_const() call.

The code is not correct logically, either, because functions like
scmi_notification_instance_data_set() are meant to modify the data
behind the handle (in containing struct).

The code does not have actual visible bug, but incorrect 'const'
annotations could lead to incorrect compiler decisions.

Fixes: 3095a3e25d8f ("firmware: arm_scmi: Add xfer helpers to provide raw access")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/clk/clk-scmi.c               |  2 +-
 drivers/firmware/arm_scmi/common.h   | 15 +++++++--------
 drivers/firmware/arm_scmi/driver.c   | 26 +++++++++++++-------------
 drivers/firmware/arm_scmi/notify.c   |  2 +-
 drivers/firmware/arm_scmi/raw_mode.c |  4 ++--
 drivers/firmware/arm_scmi/raw_mode.h |  2 +-
 include/linux/scmi_protocol.h        |  2 +-
 7 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 6b286ea6f121..f9efe14a95ab 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -405,7 +405,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	struct clk_hw_onecell_data *clk_data;
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
-	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_handle *handle = sdev->handle;
 	struct scmi_protocol_handle *ph;
 	const struct clk_ops *scmi_clk_ops_db[SCMI_MAX_CLK_OPS] = {};
 	struct scmi_clk *sclks;
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 7c35c95fddba..a18babacebf2 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -154,8 +154,8 @@ struct scmi_device *scmi_device_create(struct device_node *np,
 				       const char *name);
 void scmi_device_destroy(struct device *parent, int protocol, const char *name);
 
-int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id);
-void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
+int scmi_protocol_acquire(struct scmi_handle *handle, u8 protocol_id);
+void scmi_protocol_release(struct scmi_handle *handle, u8 protocol_id);
 
 /* SCMI Transport */
 /**
@@ -277,13 +277,12 @@ static inline bool is_polling_enabled(struct scmi_chan_info *cinfo,
 		is_transport_polling_capable(desc);
 }
 
-void scmi_xfer_raw_put(const struct scmi_handle *handle,
-		       struct scmi_xfer *xfer);
-struct scmi_xfer *scmi_xfer_raw_get(const struct scmi_handle *handle);
+void scmi_xfer_raw_put(struct scmi_handle *handle, struct scmi_xfer *xfer);
+struct scmi_xfer *scmi_xfer_raw_get(struct scmi_handle *handle);
 struct scmi_chan_info *
-scmi_xfer_raw_channel_get(const struct scmi_handle *handle, u8 protocol_id);
+scmi_xfer_raw_channel_get(struct scmi_handle *handle, u8 protocol_id);
 
-int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
+int scmi_xfer_raw_inflight_register(struct scmi_handle *handle,
 				    struct scmi_xfer *xfer);
 
 int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
@@ -522,7 +521,7 @@ static struct platform_driver __drv = {					       \
 	.probe = __tag##_probe,						       \
 }
 
-void scmi_notification_instance_data_set(const struct scmi_handle *handle,
+void scmi_notification_instance_data_set(struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
 int scmi_inflight_count(const struct scmi_handle *handle);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3e76a3204ba4..8b27e74d8a19 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -438,7 +438,7 @@ static void scmi_destroy_protocol_devices(struct scmi_info *info,
 	mutex_unlock(&info->devreq_mtx);
 }
 
-void scmi_notification_instance_data_set(const struct scmi_handle *handle,
+void scmi_notification_instance_data_set(struct scmi_handle *handle,
 					 void *priv)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
@@ -638,7 +638,7 @@ static int scmi_xfer_inflight_register(struct scmi_xfer *xfer,
  *
  * Return: 0 on Success, error otherwise
  */
-int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
+int scmi_xfer_raw_inflight_register(struct scmi_handle *handle,
 				    struct scmi_xfer *xfer)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
@@ -730,7 +730,7 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
  *
  * Return: A valid xfer on Success, or an error-pointer otherwise
  */
-struct scmi_xfer *scmi_xfer_raw_get(const struct scmi_handle *handle)
+struct scmi_xfer *scmi_xfer_raw_get(struct scmi_handle *handle)
 {
 	struct scmi_xfer *xfer;
 	struct scmi_info *info = handle_to_scmi_info(handle);
@@ -757,7 +757,7 @@ struct scmi_xfer *scmi_xfer_raw_get(const struct scmi_handle *handle)
  * Return: A reference to the channel to use, or an ERR_PTR
  */
 struct scmi_chan_info *
-scmi_xfer_raw_channel_get(const struct scmi_handle *handle, u8 protocol_id)
+scmi_xfer_raw_channel_get(struct scmi_handle *handle, u8 protocol_id)
 {
 	struct scmi_chan_info *cinfo;
 	struct scmi_info *info = handle_to_scmi_info(handle);
@@ -820,7 +820,7 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
  * Note that as with other xfer_put() handlers the xfer is really effectively
  * released only if there are no more users on the system.
  */
-void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+void scmi_xfer_raw_put(struct scmi_handle *handle, struct scmi_xfer *xfer)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
@@ -2202,7 +2202,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	int ret = -ENOMEM;
 	void *gid;
 	struct scmi_protocol_instance *pi;
-	const struct scmi_handle *handle = &info->handle;
+	struct scmi_handle *handle = &info->handle;
 
 	/* Protocol specific devres group */
 	gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
@@ -2282,7 +2282,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
  *	   NOT be found.
  */
 static struct scmi_protocol_instance * __must_check
-scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
+scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
 {
 	struct scmi_protocol_instance *pi;
 	struct scmi_info *info = handle_to_scmi_info(handle);
@@ -2317,7 +2317,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
  *
  * Return: 0 if protocol was acquired successfully.
  */
-int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id)
+int scmi_protocol_acquire(struct scmi_handle *handle, u8 protocol_id)
 {
 	return PTR_ERR_OR_ZERO(scmi_get_protocol_instance(handle, protocol_id));
 }
@@ -2330,7 +2330,7 @@ int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id)
  * Remove one user for the specified protocol and triggers de-initialization
  * and resources de-allocation once the last user has gone.
  */
-void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
+void scmi_protocol_release(struct scmi_handle *handle, u8 protocol_id)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct scmi_protocol_instance *pi;
@@ -2372,7 +2372,7 @@ void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 }
 
 static bool
-scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
+scmi_is_protocol_implemented(struct scmi_handle *handle, u8 prot_id)
 {
 	int i;
 	struct scmi_info *info = handle_to_scmi_info(handle);
@@ -2388,7 +2388,7 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
 }
 
 struct scmi_protocol_devres {
-	const struct scmi_handle *handle;
+	struct scmi_handle *handle;
 	u8 protocol_id;
 };
 
@@ -2525,7 +2525,7 @@ static void scmi_devm_protocol_put(struct scmi_device *sdev, u8 protocol_id)
  *
  * Return: True if transport is configured as atomic
  */
-static bool scmi_is_transport_atomic(const struct scmi_handle *handle,
+static bool scmi_is_transport_atomic(struct scmi_handle *handle,
 				     unsigned int *atomic_threshold)
 {
 	bool ret;
@@ -2582,7 +2582,7 @@ static struct scmi_handle *scmi_handle_get(struct device *dev)
  * Return: 0 is successfully released
  *	if null was passed, it returns -EINVAL;
  */
-static int scmi_handle_put(const struct scmi_handle *handle)
+static int scmi_handle_put(struct scmi_handle *handle)
 {
 	struct scmi_info *info;
 
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index dee9f238f6fd..bfc1d57ce052 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1464,7 +1464,7 @@ static int scmi_notifier_unregister(const struct scmi_handle *handle,
 }
 
 struct scmi_notifier_devres {
-	const struct scmi_handle *handle;
+	struct scmi_handle *handle;
 	u8 proto_id;
 	u8 evt_id;
 	u32 __src_id;
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 73db5492ab44..efae99febdde 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -172,7 +172,7 @@ struct scmi_raw_queue {
  */
 struct scmi_raw_mode_info {
 	unsigned int id;
-	const struct scmi_handle *handle;
+	struct scmi_handle *handle;
 	const struct scmi_desc *desc;
 	int tx_max_msg;
 	struct scmi_raw_queue *q[SCMI_RAW_MAX_QUEUE];
@@ -1210,7 +1210,7 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw,
  *
  * Return: An opaque handle to the Raw instance on Success, an ERR_PTR otherwise
  */
-void *scmi_raw_mode_init(const struct scmi_handle *handle,
+void *scmi_raw_mode_init(struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
 			 const struct scmi_desc *desc, int tx_max_msg)
diff --git a/drivers/firmware/arm_scmi/raw_mode.h b/drivers/firmware/arm_scmi/raw_mode.h
index 8af756a83fd1..49895b81bc3b 100644
--- a/drivers/firmware/arm_scmi/raw_mode.h
+++ b/drivers/firmware/arm_scmi/raw_mode.h
@@ -17,7 +17,7 @@ enum {
 	SCMI_RAW_MAX_QUEUE
 };
 
-void *scmi_raw_mode_init(const struct scmi_handle *handle,
+void *scmi_raw_mode_init(struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
 			 const struct scmi_desc *desc, int tx_max_msg);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index aafaac1496b0..17095e41f5c6 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -909,7 +909,7 @@ struct scmi_handle {
 		(*devm_protocol_get)(struct scmi_device *sdev, u8 proto,
 				     struct scmi_protocol_handle **ph);
 	void (*devm_protocol_put)(struct scmi_device *sdev, u8 proto);
-	bool (*is_transport_atomic)(const struct scmi_handle *handle,
+	bool (*is_transport_atomic)(struct scmi_handle *handle,
 				    unsigned int *atomic_threshold);
 
 	const struct scmi_notify_ops *notify_ops;

-- 
2.51.0


