Return-Path: <stable+bounces-185725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0BBBDAFF9
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 21:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949283A9D01
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A212BDC35;
	Tue, 14 Oct 2025 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MoZLW8vO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B824DCEF
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469051; cv=none; b=GckMTxtKS6frjjyVGjeyuLQL4fdlkDFyxI1AHQrAZJkagsG466RZJmN2Hp9fKFYJINfWSP/8V7/PAUiV9S6zwSK6zT383r4bZcjfPK4fo1tYi9P/J8qFlPTVda2pQrP4bh7ByEVkVOBpAaYJeiPqIOhKLFXEVO9LvRtUn4C5ZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469051; c=relaxed/simple;
	bh=e+X+R9Ur8Uh5LmGQzmqJlUxmh0X41eK9EA8zz3DijaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgXBmQMza+XbsxKzG9aaMBTeA9a3KGQUVr3reEzEr0QK0gCpEO+JFoULhcvwM/9UwNes1MLkOj7nI3mSvFJH6Sxv8q/4HY3EqZvj2datEgK7UFkZM2LYgK/XZhPyxkn9FwVdyXhvvk2Iapd3A9mVlwascCoabTyHKVqZsiInfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MoZLW8vO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EGkGsn018998
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 19:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4QwgY7p/7dQLrHKG1G7rSASmEneVobGXLDD
	GpE9Gadw=; b=MoZLW8vOWlG7/TKdPDNMW329+TXDbwU7TmKnG808M8qrXlR4Ccz
	feB72mGU30V4izCXJuI/Vfjhyy5gJ+0z/f2NsHT51mBm0KH+JPGUPn4TfW6eKIul
	L5U3rUTRZW99Fsafc7pSleuV4pGsLe4+gWhPilcLETiCmpEKYSmYHtMdhpNGFCa/
	BZQr95ZXg2asg+7BzzszFRKjllecbtEiFYREHReHBDeYZWH/aqmH45xBFZ087+71
	pPkAIMf6jTl4F29SJTEOmnPwT/k2Warl3UaDUIra16vPAfh2Tk+JVHSFAgAIRxX4
	Copc7I2WNRLYrvUZfDpdTl3kUS4bgfta0vg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1ae1kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 19:10:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-827061b4ca9so2584613785a.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 12:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469047; x=1761073847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QwgY7p/7dQLrHKG1G7rSASmEneVobGXLDDGpE9Gadw=;
        b=hgOQpIVd4WlgJSQ22Cog9F8AY5HM95pTo4ypd/oUP9F8mGUGa0xSQFzSRTgF394TfG
         rCTjFhOdPu/H8+Fw8gJ/zaX+jQewZ7fVaEdzrbzTOBbgDpqkM6xfDQO3ftXvWyeZUK/W
         l7xFA1brubg8Si+67MS2SKfyf17z96FFnJCr/XnMhk/hfHRGQdW7t1y3Yp842URC3uC9
         GYCyvW8xB3AbYzmsYQVP97maJhPDELT/8ntcRcLojnngGNQeSx7qy2mmjuc+Yj/Oo+XA
         LQd8v6L7XgfN9gCdUnZFtVceylSrAVZ6j+RAx7xFewfl+QzF23ZrJqisLbPDDPxGNQCj
         WUMw==
X-Gm-Message-State: AOJu0YzT2kGuPOuGdBzJiJ4nKOFO9+WAjwKLtH8eox9JdcwwEoOF4ftZ
	jrLpmnucmv2VifqNqXQBkxK+Zrpt1UN0qOJ9KuUeJX49FIv6DO1Rw6TLqlGB1WvO5MPEYHbZFoQ
	HXXyQ0nxhh06Wu/GaDjRL+IwCd1lwgJpmSI+UHRYChCkMpOCOo9Rctm+/27UBozQNAVw=
X-Gm-Gg: ASbGncsQW+d5u/i1mNYoF5HFwYfaF32Ek5/oDUVcBA5MGUUQOVkUKjSCTQmdPRCc4OS
	aUlKZJY62862VF1d+tq+Q9rRVHCdT7Y1yNTHAwUYOouFpMaUjuMATd+iH7ynZqdXyWJbivBhaJc
	OQzoxlT2P17CvALiy0lGXDvDZOJlM6YdVzCHJpoB0W5XVEwzAfCPOj03jJFdTCL5oQ4QW5BW7rh
	RSk7fvXGisk8AvMpmUstOTAd5jbYJSjGq7g4SGXlGOtiN6uXTpLyGuC9L0UFwiKfwYAh5oxyQDm
	mtKosI9SyqPXS65PwI7MywnRHcelK+y4bwzic4F8GXErTsoFKYLr9lX3yhCjbx7sJgE/o0LRXI0
	24vC9eFpJfnYnW602qAvwNvWyApC3YFV3PtQU6ZrYK8DJvncbMH/Y
X-Received: by 2002:a05:620a:1727:b0:859:be3b:b5ae with SMTP id af79cd13be357-8834fe99826mr3365363785a.11.1760469046963;
        Tue, 14 Oct 2025 12:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF66ZuMKpSnzuq9VIfTAIUppjlPnmbny6drFFA+unLAaN7qYjtDj1DAxTGgjJ1+oUl6seWUkg==
X-Received: by 2002:a05:620a:1727:b0:859:be3b:b5ae with SMTP id af79cd13be357-8834fe99826mr3365358885a.11.1760469046387;
        Tue, 14 Oct 2025 12:10:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908858456dsm5499649e87.124.2025.10.14.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:10:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.17.y] ASoC: qcom: sc8280xp: use sa8775p/ subdir for QCS9100 / QCS9075
Date: Tue, 14 Oct 2025 22:10:45 +0300
Message-ID: <20251014191044.3808939-2-dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68eea039 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KGRU7LGiJR5Q1pf3Q6AA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: z63UUuZ0jOZW64AttgGpm5rvjoNBnVzy
X-Proofpoint-ORIG-GUID: z63UUuZ0jOZW64AttgGpm5rvjoNBnVzy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX70JgPZ6j82Lz
 eIrPGLS7HrzO+pu5falZ0zP8oWaSWG8LxW1pNfC2AU+6lrkZXsqqAt7dF/NFOqDaAnv4gLXVmse
 nllDVN8to0fUv9cuwi1Bt+LnPZSzXRLO9Yi4sEi//C+KLJLv3OXx0JcF86wk5MilSCLrq1GRE+O
 HftmYnYKOFJK7F8lDEwi4gExrRn9PPzxr3xonxKW2FalGtq8dyNxf4Fkb34NbZoSZ/Qg6uuhvhX
 4vtJ7n8T4circcvejHhRvRGXpsmu44PgkGweKPlCf9CPQeRaPL+/NLyKerc0KCWcSxksIWjPWYF
 i4gj24UwTnCFeEoEDQLm5UfsHg+2woEvO4Gn3AczuyYk3YNMBp0GzZiK+PiQXnR65T52bXGYiJX
 kIAb5cPz1SP5bFWy4tCWXzdYPBA41g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

[Upstream commit ba0c67d3c4b0ce5ec5e6de35e6433b22eecb1f6a]

All firmware for the Lemans platform aka QCS9100 aka QCS9075 is for
historical reasons located in the qcom/sa8775p/ subdir inside
linux-firmware. The only exceptions to this rule are audio topology
files. While it's not too late, change the subdir to point to the
sa8775p/ subdir, so that all firmware for that platform is present at
the same location.

Fixes: 5b5bf5922f4c ("ASoC: qcom: sc8280xp: Add sound card support for QCS9100 and QCS9075")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20250924-lemans-evk-topo-v2-1-7d44909a5758@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 sound/soc/qcom/sc8280xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 288ccd7f8866..6847ae4acbd1 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -191,8 +191,8 @@ static const struct of_device_id snd_sc8280xp_dt_match[] = {
 	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
 	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
 	{.compatible = "qcom,qcs8275-sndcard", "qcs8300"},
-	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
-	{.compatible = "qcom,qcs9100-sndcard", "qcs9100"},
+	{.compatible = "qcom,qcs9075-sndcard", "sa8775p"},
+	{.compatible = "qcom,qcs9100-sndcard", "sa8775p"},
 	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
 	{.compatible = "qcom,sm8450-sndcard", "sm8450"},
 	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
-- 
2.47.3


