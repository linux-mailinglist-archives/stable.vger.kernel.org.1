Return-Path: <stable+bounces-222557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKx7M2tfpWlc+QUAu9opvQ
	(envelope-from <stable+bounces-222557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:59:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E921D5DC1
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A6D730180AB
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B132AACB;
	Mon,  2 Mar 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JyXpO75x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWWojCWz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B193B7A8
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445531; cv=none; b=uFBvz4Wk/6+iDSfMI3v0hpzwKxL3fKUDlDKcZj249/KqTM6c20sSsEwjcY58yXHIAx6ns06x9FwxhIhiv+0hUeBc7d+PFMRe1K4X8ijZKPDH+bxOrBjUUMd2HfwYdgsQeAPK2ll5k+EcC2OLPq00sS5/e/LDJkL6GD6LReWe7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445531; c=relaxed/simple;
	bh=X+mySEiLj/X2N40KikSw3L+Zg2B3m4zZp1U8WaBFubs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OxwV5bX6B65vSdHuSRjomLGzB6zmyOJ5tlOPXgHzdvGyAgWNKToASbeK4weGVzkymqargoFlZE04v9ZC33CnYj093o9Xs2lz74s4aVArzIaFiAmkuIBKB/9allIPHYLBOYAtgRn0MgKPn5R8RgCs1Uk41QeUXsTG7iB8IznNTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JyXpO75x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWWojCWz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62285Zb1662304
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 09:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iCtSXsUWu7OcMOBhOgieiO
	gHacTyjFYNQ4EssgN+P2M=; b=JyXpO75x/l1GelWNo/vOobT2f1+C+ejGeOWVI5
	yOGeLdY91dk+GKj9aVLEhkpKm55ii03+inQ5VYfIuQr40jFbJu4ZspOCPuCkyjSx
	oFm7tInAHl9ghiwPBTLdlJ8xUETJZqmL0l7oQE4p9A+xFRTGzde8MqOaQkzzi8lj
	ZaprTjVlSF1cMXbOxzW4YkBrvd2t1Fckb7xA0fMDF0G8h7mA5pPf4rd7oI/XoD22
	/nybL6aEfp0XHxTNECPavRuyM3I3JMcBuVXsgl6j4eABLm8m5hLx22WscT6reAUJ
	Jjh6GDFl1lTXq3f1Acnh62nqgt2Xn2ugJ+D/9qrEAkH/M/0w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn6r2rfts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 09:58:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb52a9c0eeso3443421285a.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 01:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772445528; x=1773050328; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCtSXsUWu7OcMOBhOgieiOgHacTyjFYNQ4EssgN+P2M=;
        b=fWWojCWzs4GKYMpdJKEVHnFdIJh7rcrttYrz6yfiAd85+6JqgRb3zdlEkiAJUI1wUV
         QuUMRspORv2+7GEc0ACfR6GmT6q+15a9S7oBGplp4s65FGezsOXd8CuB4TWPsA6TQjrH
         5evDfUUqkEfR5B58fIxZkm49FGxGHBxBKg5Th7Yehi15mqMDPHz4jxyLNYHpD2RCvdyO
         hW0zL2mlQ/n/A0NkP7tgw2cS/3bnH8Ah2PF9Qc0VjtUIQ0LI2BQfJoJNpWmpF/NDLRKk
         60tosHthX2LuoZKmFzcZyyyPfM4bw3pWcn8jLTJtbUZCUgjJrxcFjPHHA6+xNe+arfep
         xpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445528; x=1773050328;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCtSXsUWu7OcMOBhOgieiOgHacTyjFYNQ4EssgN+P2M=;
        b=rdiOQUdkTW8C7dgcDEslyxeaEpGVkfKhUWvie/6xbALfB2dIzR3j4UyMBKpCAmGslZ
         3Xi4y5+Tp9WQ7GG41IH8lLLGb6pNzegKamB5fWA1T8s3yxcgrOdRbJlsT94fPaALg5K/
         o5ncEzGv7CiDiZ2xcD1gOg7daU8XMPGfr5ze+lY/+Lfa3XmC2pfJEETpoQHNpk4tJezr
         9ZhG4J0uQfIALFM34+rnLOO8KIwtcV5ZZByoxaM7Ab7qIGV+txuoED4FjdnOdcrlshfA
         MemVUe6tZFv0i3b+SNRkGI8zpsYxv4HixFkEKcD6f8BVw74nqZZp+mv1fuEWodylcpiA
         1cFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzpYZ+Uh27DhA6usB1RNZ3l7aYpqiytr4LDhjr/X7agsL4qzYWooTEsNWEie0IVqyNUz2jCuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoM1HBbQmm5xWIKnH4fc9nlTyUOnVHOp5pJ4buf7y4gTtKptWh
	+l2BC3cxePkQYCDozQ1Aifi+eA+In/t5+wiiGtHukGBDckzQcUFgkflnv2wTcsf5yYX1pdS8zNd
	ef00/22a7qzAKljHr3fhq1GTijrgavIbklhPmpgSTWBipOXeslgfjZynDezk=
X-Gm-Gg: ATEYQzxMTLdgss9mJhe7Erpddn2ClgMH7azp1mUEXSBKX2tPMm9iyWbfDhGjdCUGcv8
	f/nxZbqF4+G9vquCTMKVbrqiwcKqeEUiz8bgJHHWnhTX1BpVyRVz/q8iOFFY6at2E5xDTNQCc5l
	NuADcYimljXduXIV2Nm0AmnOufQm0Wyk2tP1q8K+Wq+/+Tijqut9RamvZO0q47uk68iWqp/ebfa
	8QFn7xptL4CMEOMox40PKGirReU5xObQ7L4Js5nX/QuVdMpfTCNTehhV6LtTbFlGWsoO4C+gRxp
	wn+LSCI3Fnxy8qKS8quul3CSzSfKvyRWRM74fSf9jE4qqyvwXzu5XPLGjsMkFJYQTOEQ7uJtvj4
	cupI0zQX1pleJ+GO2Eyi/cSspWibCMQ==
X-Received: by 2002:a05:620a:471e:b0:8ca:20e8:f444 with SMTP id af79cd13be357-8cbc8df09c5mr1659273385a.51.1772445527940;
        Mon, 02 Mar 2026 01:58:47 -0800 (PST)
X-Received: by 2002:a05:620a:471e:b0:8ca:20e8:f444 with SMTP id af79cd13be357-8cbc8df09c5mr1659269785a.51.1772445527303;
        Mon, 02 Mar 2026 01:58:47 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm9523027f8f.30.2026.03.02.01.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:58:46 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v3 0/2] dt-bindings: display: msm: Fix Glymur DP controller
 reg ranges and clock
Date: Mon, 02 Mar 2026 11:58:34 +0200
Message-Id: <20260302-glymur-fix-dp-bindings-reg-clocks-v3-0-8fe49ac1f556@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEpfpWkC/5WOTQqDMBSEryJZ90mMUrGr3qO4yM8zplVj81Qq4
 t0b7Qm6GfjgY2Y2RhgcErslGwu4OHJ+iJBfEqZbOVgEZyIzwcWVC1GC7dZ+DtC4D5gRlBuMGyx
 BQAu68/pFUPLCcK0VYlOx2DMGjPa58ah/TLN6op6O4sNoHU0+rOeJJTu8f/aWDDKoqqZUhVBFL
 uXdE6XvWXba930ag9X7vn8BChVuresAAAA=
X-Change-ID: 20260227-glymur-fix-dp-bindings-reg-clocks-704d0ccbeef9
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=X+mySEiLj/X2N40KikSw3L+Zg2B3m4zZp1U8WaBFubs=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBppV9RxSQpE808cNLAeohVls5YT8Atr4vGjY4XU
 NnnCUza1/+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaaVfUQAKCRAbX0TJAJUV
 VtPYEAC9wmhC4eBN9sCIQphv+PrNEUqfswJf8Ynvzuf7D2LAwghKFVSoYQCAmARFbplJGhOI7+0
 4GQjcYp7AmWEhxf8dQd96DToCQkqfigo+TgN+gjXy89CkJdYgYxvJmJSdUm7cPAQIT7bq74XxrT
 9b8k5c9F3oodNlfUsdtYQs49HUe5VH+HMYryXMUxJfS1BbQRJ06rgWgL9FWSuUAN6/rlM8KMKFc
 R4SabTBroB6sug9oVzHbiEoGZiiAGnSJSVxnkm7yppPsoCbJOn8yzA4PFfQCTy66+7euj2FbYEh
 G2en1qi2+u2cAvBvhUiRWvtX3TAqgJTIPUIsg7KjgHv43WOgbl+uFNtS9HFkM94r7bOP2Q7ZBM7
 T2zYFEuONYfxW1HpOASPtWg5tiMVNfGETYfDA94RfaxHHsuitk2kVAjkwbK5glUxeKrvA2H/uKE
 lxLNrElrL56cVsqMECjSTXQO59pcQCUpNCCPQB3+T0sUdUJ239iT+aSeiNmRcVgBKq8c5ATC0Du
 MOR1kRxCDpsCWBfFdDiqwGbke9ZicQxk9LXsRaObib87NqN811/HkEwmtxAuTwvhylNVU8jSVzy
 LmDvI37hY1NRYvBd03Jco/KAknNeI2EqtxDke/7HM4gHM5h+yJCAA5GvzDhOx6mPlCUaq3qYViG
 CzmAxD60c2BQ3UA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: vWUbIs_5XnsD1Fn4guKt_jGXIVnl6WNQ
X-Proofpoint-ORIG-GUID: vWUbIs_5XnsD1Fn4guKt_jGXIVnl6WNQ
X-Authority-Analysis: v=2.4 cv=Hpp72kTS c=1 sm=1 tr=0 ts=69a55f59 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=zEcBLWh7pef_YpQEXFYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4MiBTYWx0ZWRfX+7HIFbCLQGFf
 YZQLiAvDT9SokT3QE/zbBBChs/xognuJh90XUsMAfbWdWLrlfsUHApxIL0GeM0trwBwlbT+SMTE
 QMYY10cCrbQcvRJHn4+BClD9auYecGdc7MgnweyO+wLhbPSvgUTl4LBxLT5kg4kvflBgYNSaplY
 xgLkncxKtu7xr81zOqQXwYhjbnfAPycvEclXa5WdQTixeocs4hX3LN69LOPZDJaq5WDJB2B0m5l
 PLYyiaCEGw45l2sgMtheLf0Ks5ZIl6INp/M8cRZqicekMiX5KbiCcXypyrlftVWl+RunmMIitBm
 +lNfeFQ/sgrSF/bPPLhLCTa+erf4+jij/JD8CvhZevXmV1mqpc99Ogf7VyLezSYHIaPpjkIldvY
 J7NOYX/i44JriFrFnR9imGaLZx/GQMFUcGXLDshuSkMm/qRDCGecF/SQMzXfi1azq4m0/YdUtnQ
 Oq4mYeXUiP//jha2SoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020082
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222557-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,msgid.link:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,linux.intel.com,suse.de,ffwll.ch,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 73E921D5DC1
X-Rspamd-Action: no action

When display patches were initially submitted, they did not include the
p2, p3, mst2link and mst3link reg ranges. The devicetreedisplay nodes for
Glymur are still being reviewed and have not been merged yet.

This fix resulted from review comments on the devicetree nodes.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Changes in v3:
- Fixed the reg ranges in the example node in qcom,glymur-mdss.yaml as well.
- Link to v2: https://patch.msgid.link/20260302-glymur-fix-dp-bindings-reg-clocks-v2-0-e99b6f871e3b@oss.qualcomm.com

Changes in v2:
- mistakenly sent without cover subject line. Please ignore.
- Link to v1: https://patch.msgid.link/20260227-glymur-fix-dp-bindings-reg-clocks-v1-1-99f7b42b43aa@oss.qualcomm.com

---
Abel Vesa (2):
      dt-bindings: display: msm: Fix reg ranges and clocks on Glymur
      dt-bindings: display: msm: Fix reg ranges for DP example node

 .../bindings/display/msm/dp-controller.yaml         | 21 ++++++++++++++++++++-
 .../bindings/display/msm/qcom,glymur-mdss.yaml      | 16 ++++++++++------
 2 files changed, 30 insertions(+), 7 deletions(-)
---
base-commit: 7c21b660e919698b10efa8bdb120f0f9bc3d3832
change-id: 20260227-glymur-fix-dp-bindings-reg-clocks-704d0ccbeef9

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


