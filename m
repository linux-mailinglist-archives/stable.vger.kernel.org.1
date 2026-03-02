Return-Path: <stable+bounces-222558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNDHEntfpWlc+QUAu9opvQ
	(envelope-from <stable+bounces-222558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:59:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB8C1D5DE7
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA5463039C8D
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB6392C28;
	Mon,  2 Mar 2026 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZvTX/TF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X6uVm4ox"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5A38D01E
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445533; cv=none; b=C216L7moVEaYYPGFPpX35GebNoC6qd/f13mpUfqQxCdPAuxcZD4d0Whuq1LlQACRvpkxmXX2Bno+IhgP3MCpZ/P/xIvIu17wNzx3xEW7RMWFsZPCRyuNqmqUZ81RUBvs2NSVc9JjDZJOzge9ZpF6CsbvJilHXUB2U8QtEGanUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445533; c=relaxed/simple;
	bh=ugiE5l8CcjjtV9Npwf4dBU2Z3sbwAjztE1heu0QvfRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgZ6G9uHVeF5g1vejbaVNRWy+AoobCx+d+ZrQNAOiM7tSPylrZya1FKwCByAlZqCTOyjqop7Wnox9r4H2aYqwTipeTM8OEL8nPnZJK5B5P2GLf0eKK+7DBSotUbkgLuICL9rn3YTba1EpDvOr44TXsPHotbOA53t6Hm+ebVI63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JZvTX/TF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X6uVm4ox; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6227xE132732643
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 09:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AltrQ11Tnt/rvrqxhAxjaejTKOvYKBB8rT6LAMYIOZ0=; b=JZvTX/TFus0PFkgP
	smpqYF0pKuw4Dh9dOB82LfeLNny7gH9hwTq/dgVIR4UVpRC5LcILkwqIU7xpjSCA
	Uf3xCrFDPtC9sQn6rMP961wrgF4zFfWIwI/uuDz+RYzorsLf3ISQsgMmOSEw1gSN
	H16dKGXWfjbmLRmC7Ng6IYMbol8IFJ9uy+9pfQszUztJeeyRu11LaxZniEb/oE3V
	WefihAwI+UEaEYRNdfxKAytPMaImGywifHrU2Vb/3pIwB613StsjIyKPyB1AcF0p
	ao8RXhvua6hIxaqZDsAwvanNgTjeGMQtZkb+Nzk+P3hElWFT5gm0Mf9Nsjr5la0r
	FEao+Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmgbatuwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 09:58:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb0595def4so4195296185a.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 01:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772445530; x=1773050330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AltrQ11Tnt/rvrqxhAxjaejTKOvYKBB8rT6LAMYIOZ0=;
        b=X6uVm4oxlFwVgkc8okCzSqkx6CHhl7YCAoTOVBRkht9zcouEwZTDJ3TKD6WlaN8K3n
         dPUnOnbHilPjucla0bGQAw7l5cBkRVVlvDEbpDkqXg/ext86gI/LkUMA4tjW/JoaTJ4R
         B2RThuOtf4lW6Ljvh1IIg2HJgqGNboa1DNoOw0aF6YuE4E5pRHZnBQ/z3YL9JwLBibhA
         7+kPG5uzkZV4VAHWfdQeIS6HswqZPq+DQd4SOMIp4xeT/H1Se+CLuWWSeS2BHyRO12i8
         sHhUOclOjiGpB5vRSqBtzPRhdwkJQ4i7ThxjrGKQOnBxeuYw5WcRgTuwljVM9HpaFQhs
         bN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445530; x=1773050330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AltrQ11Tnt/rvrqxhAxjaejTKOvYKBB8rT6LAMYIOZ0=;
        b=HjRk5RkZDBOvJNAV3RjRkS1Fz9g1mGT7yGohmOFG8+uzT5WDCpD8jqeR8D0G23uaCN
         /UaBA1mOHZj5J/4S1PwisL12XQctP6pHXkNoyDYmcU/22LkB+trOHRwhZyzC15Kko/P1
         odjZgzN+/yZaJwFZsyMiuUvWDnk72dNFNJ8nyGW0oxa4ciIG96/MPprxfaN2DXvIEkPc
         z/Ltqq5VufIwl/XfpmCPIZBOH4kOyTnUgcVoYGdkV8LYtc/m8ipJmNhHUKxx+0AUUQ9A
         vwMBc+pVHoXc6FfcA9OIrST2Uzdxxx0IAREXKtsYqvxJNWyz6nR5W7VlJTjMxvH9bDeV
         dwog==
X-Forwarded-Encrypted: i=1; AJvYcCVY/L0D38rl5zr5RF/wdYcBPrSTMbKkk3YjdJ+kNgpiAb5CZEFbkI7+y3v/oF5vgDk+cuW8HPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoE3WA+hfYzvqSF3YMTBOifdk8GelrV+ukad/I9g3mTwjDiZ/u
	K0N3UpS/XuwNegCOk+Fs/8zvFNp4BI69G2AYztz/xUAy2epmZi/GVv0pcr7ztJ9eAiU/10EGfx8
	UMKuFyRhcFY+8d5ZJTD21sH3n6OcXsUjc/e+hSkA4Ifm/ei2NyrEa4HRsqis=
X-Gm-Gg: ATEYQzwIPOjG9Gxj8rkQkb8IxCI+djPkdSFOgTA8icHgXyFexXR4s/Gm1K5bk7Wo6QR
	hC05BSkd6hKtOvh3yEPF/1mRdJU0jiQQ4p7r/Myy0N0p5rOhWNT8TnccwMm2SGv2d6XvmDp2pZx
	/isAZXcNlql5H59aHPQAN1RDaTSwL5IyGNl3ZZXL6XxKD2UWbnvsFFwW1gJt5cFYr3NJxfA6Ex9
	j+C8cIwHGbeRdFJ+GZGiifDNcTncCv360mTT26LxmWU8O71/mT/38UGWB6Y4ZwMN/nVdf8X9vHd
	IofLi2ej5j2vn9cWBlks1MUCuy19NaCcTTSyiJEsqOBDoVeUTu+6xHLoUVrisCUEc0H2ZLoocb+
	wqO+tCoRqWELVvW2xU+xovPUV0pxobA==
X-Received: by 2002:a05:620a:470b:b0:8c7:3ff0:d472 with SMTP id af79cd13be357-8cbbf36a89dmr1665568285a.15.1772445529938;
        Mon, 02 Mar 2026 01:58:49 -0800 (PST)
X-Received: by 2002:a05:620a:470b:b0:8c7:3ff0:d472 with SMTP id af79cd13be357-8cbbf36a89dmr1665564385a.15.1772445529405;
        Mon, 02 Mar 2026 01:58:49 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm9523027f8f.30.2026.03.02.01.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:58:48 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 11:58:35 +0200
Subject: [PATCH v3 1/2] dt-bindings: display: msm: Fix reg ranges and
 clocks on Glymur
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-glymur-fix-dp-bindings-reg-clocks-v3-1-8fe49ac1f556@oss.qualcomm.com>
References: <20260302-glymur-fix-dp-bindings-reg-clocks-v3-0-8fe49ac1f556@oss.qualcomm.com>
In-Reply-To: <20260302-glymur-fix-dp-bindings-reg-clocks-v3-0-8fe49ac1f556@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=ugiE5l8CcjjtV9Npwf4dBU2Z3sbwAjztE1heu0QvfRM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBppV9TBAduqk1gcr0xXxNkiQDCYKg8uz16HPzEf
 wewNSqwUUyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaaVfUwAKCRAbX0TJAJUV
 VillD/9gXbcbldVwFesEX/WpAjC1aiqVjQ7lPDaV9iSKTn+vNs3Vu8SZ2r7tcKaP2PyQexSdrd8
 mrYVW6J3DqEPW14o7tdPhVckKxCPPt9sHOxGf+XSy8jICvBtg3XZtZQfwPI88Sjg7qttvAAqzI+
 E+FzWOlIg1L0JLD2jJq7neufzgWFhrfvu9yyoFzD8V4SxIsd1MdH6WpUYdDeiWNJkbQ51qW91hF
 6G2dvHy++UYb5wcdMC++IqeTVikEgqO/+m55R08uoFfCGtzH3MoYXCW2N6ux8yabUVtM/84RgJs
 wVGsGC9m/ZdU+ITDYRGemhEwTQ3rGgJ8cQbrESGbLy7BwRyPrDdoCeWckWLmX87iJXwY1NLXOgg
 l33eGQkr7WSuQflEU7PAmW9a8eCzLRSRZH5xUQeKd0tTiQTwdRDI1qdY/1cyROjr0XVb4gylPOt
 pDcxSup+yLlTnT/be6+IQFgeGI1pYwjv1BcBaAXA4YW5xqxwpTaP6/SSm6hlwc7ruzSLj8MCIWy
 AwG3TypK46asAnzCYPbVRProLx/iVDYM6nT3hJoOrng5fNgwNE+PzNeaKrk4D2VYHIgajls0kX3
 cPEAAj/+Fy/5yixcFL9nx4VpSmJw0/SjerRjFCZbZI+W62H86Ke1Gs2dhtAt1Hpx3vpvoMZTQoL
 cep0UDwNFCgKuqQ==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4MiBTYWx0ZWRfX5Qea9asjgT5B
 JxxYmrMJ8ci9FmaMv4T5qzaT3ABp9oYJA+r5Wj4j37I8v75Bqnwl0sLD++VajLu+0ap1hsy0vuu
 8mxmbsKt2O4cV7l9+eoGnYPNqDq8lzJJcd49zb9kslFXsyjPwylbQ98jeFqp7tqotOi2z3t5CUR
 xFrh1N9LFZb59iJ0JW+Vnw1aP08zp9b2fyPB78KJGNJMbezpJxKFvQBxkzBeRZTAYGE0Iaf/0u+
 +ksA2So1ojMpaYw2r4PN3Ob2Waq1vfifHCOJQzugPsYplyVvG4Ld6xX8aC+f975iuCAZIgK6IAV
 h+iRPwJ1nYoFCMYCGigyowGdrwQsSDh/2a4lCb9/xRUCBw1GMJqVFBnzZY5Nvj5dtsxhr1dsCCV
 fU6jYT6LWu3SDsIqrQCykxuFZPWBTPZn0Hos7+Aq/pJrjswe2cujX20ipEapzNwHPsCHxJP9CDp
 K8+uJKorFCN4yH1T9MQ==
X-Authority-Analysis: v=2.4 cv=QfVrf8bv c=1 sm=1 tr=0 ts=69a55f5a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8l7133DT9HzGPwHiDQYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Vqsv2AYpRENzHCaFaKLE0L8LHh0fxAg1
X-Proofpoint-GUID: Vqsv2AYpRENzHCaFaKLE0L8LHh0fxAg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020082
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
	TAGGED_FROM(0.00)[bounces-222558-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: DCB8C1D5DE7
X-Rspamd-Action: no action

The Glymur platform has four DisplayPort controllers. All the
controllers support four streams (MST). However, the first three only
have two streams wired up physically to the display subsystem, while the
fourth controller has only one stream (SST).

So add a dedicated clause for Glymur compatible to enforce reg ranges to
describing all four streams while allowing either one pixel clock, for the
third DP controller, or two pixel clocks, for the rest of them.

Cc: <stable@vger.kernel.org> # v6.19
Fixes: 8f63bf908213 ("dt-bindings: display: msm: Document the Glymur DiplayPort controller")
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml         | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index ebda78db87a6..02ddfaab5f56 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -253,7 +253,6 @@ allOf:
             enum:
               # these platforms support 2 streams MST on some interfaces,
               # others are SST only
-              - qcom,glymur-dp
               - qcom,sc8280xp-dp
               - qcom,x1e80100-dp
     then:
@@ -310,6 +309,26 @@ allOf:
           minItems: 6
           maxItems: 8
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              # these platforms support 2 streams MST on some interfaces,
+              # others are SST only, but all controllers have 4 ports
+              - qcom,glymur-dp
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+        clocks:
+          minItems: 5
+          maxItems: 6
+        clocks-names:
+          minItems: 5
+          maxItems: 6
+
 unevaluatedProperties: false
 
 examples:

-- 
2.48.1


