Return-Path: <stable+bounces-189089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB9C00759
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3C219A5DBD
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23B130BF7F;
	Thu, 23 Oct 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofp7nl/H"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F430BB88
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215165; cv=none; b=oe9n2eZ+2exQrlNocKxWnGCeiBD9ofBn4Z4oNHLsnrmGiM2UP01fIngojsklhUv5BZKY0Y0ikyg5i+p0CHn+pYgJASEKeCLHfKvmy9Ps/f8CXaRaUKclOlqvBc5VIDcXGCvHKznCDm1J4QsUaz5rLbIj+H0OPNsTO7WeGAUj9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215165; c=relaxed/simple;
	bh=n/QDHw1ITWRby7vrBcC4hapXZgt2KFZCOKf4tNRyaaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4q1T0bh775QZg1VdZpLhGe264vsgyQrrvSoGtfYYdzfBhlQMOAGOsrQdKQxONUJe7716jL+XYhxQzkRf2A7P/7AKcEciF+0OeeYtd3WRjxlo0kk3dWzY/wZ9MTDQyrEv6xpPeCxdAMHw8GEwiR21BxngCM4DgCU1ALo9EE6tdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ofp7nl/H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N76T0X029864
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jdyJtjan7SM
	H7wF51lvA8fxlxpPM+Q5el4ttALOfDg8=; b=ofp7nl/HBaXVLLvPU82S4U87eL6
	Gy9EvPxlr17buAKxBAYQcnWxylx1Kg++K7y8RtBRTKCk3MLstr16HdN1ARN6pVcd
	6RVXfXm0xPTCQGj/nALSmHn8Vhp9cjATvCuE6O0M0LXy+3TANJXVZWyvk18fC5yu
	DhnYPYKaIAXV4/YnAwL8b6PB0V4AKOQ8yxiNIrZbx1H4i4d1x4bL6mJYAmwgQa1A
	AfRV9HT8L7HoB1n3vE8Xr9iyfd+zhOYMtpboYGP+zNQ5WbHanUx0Qz8MYHuqnRCS
	+PnTudC3dlP+T7wAtvywk02KPHYcSn0Nvbasoqgqc+MFqSidEGwvkV9z9jA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge80jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:26:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8b15de40fso31049151cf.1
        for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 03:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215160; x=1761819960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdyJtjan7SMH7wF51lvA8fxlxpPM+Q5el4ttALOfDg8=;
        b=DCeP0QTrH/9vHvyl/DlMt9HuUD8bAHpsKINAv0WXDZcT6XbC9MCV9e6zl1NySXcWLo
         /N9PnBPyeiEUkmWpop/LFbUBvqbScxo87SGiFge0ClgfZu4XEr+I3n7DPZ9wmbRxiOcQ
         vgpexsdRX6sPILFYEZyxNeDz4nLZ08jVxdqOCLOcv5HK2IVb76YNG83ocZx+T6oZqR7+
         5HKppIIKYrlUvID8KcBF/PDA59RQUWppMO1UO3LUnbC2tWDUKeZkB1cpQFAC53v5xwT4
         pjhfdEOH2dJMOtUbfvBwKdU2IjlspaTwJ8rzB61ykvKYAp45OW0de6Bkv87mH5Vk9wIl
         vYng==
X-Forwarded-Encrypted: i=1; AJvYcCUSCgerYGb1ua3+XdRQuwDfQh5c5x4rlIbyoiOhD+MsWgF/OjJGLYP+GnWRj/6Q74cOIjvzGME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzS9e3142enyJi2sMdD06MO8eD89fZbAp1xn3zMO1x2PZZsgAu
	yFlzXI1iXYahxOqbdDrl1aTcd5e/H2qzJYUPpG96GEkGLZDha7xbikRCWhucLr2zHYlmqmYcsB7
	FRQEzRqYY9b/+/yURJf9yPxf8rW3mUkTbKFv7xieANsTurLMxvTCBQ6UYvqk=
X-Gm-Gg: ASbGncuLZwIfHSQjDqqHsoZa4vDpmDEK53AdHhGgyTku8gd1ZQ15idHKsTFgsAIsRZh
	V/4UHTI163UXTjbNfnuZSpgOPEZjNl6SJq8ekELnTxWVKKEYNmZSRk/CoHqUpw1nSJW+96LEBFy
	HZHO0jtj6WYAGiofM9NViCUYavFsW5+JCLKmNitQkRi6DFtZC1EPNhBxYYe7fPWdpzApifM8fru
	wsfj00+eClwfWsu9wAwqYg21tvxOdw9khkS5vDAacitRHhOP7RjXohnNVw5G1dxXSJbnS7HfLip
	QH0JJ8KooBuzmqS/QafbXhUcqfBqMPsZUhglTyYZlmDW8p8s7GDgW5CC7/XfGs7QYKcFbNjueMS
	4r0vL+4qEkfoy
X-Received: by 2002:a05:622a:1827:b0:4e8:b8f7:299d with SMTP id d75a77b69052e-4e8b8f72eaamr207458381cf.68.1761215160567;
        Thu, 23 Oct 2025 03:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD7wLSA44400aNfpBlMqCLaACZqamHhHypYbkYfQM4rxcD3dsHflxyufF1YmFN6YdHQzG4bA==
X-Received: by 2002:a05:622a:1827:b0:4e8:b8f7:299d with SMTP id d75a77b69052e-4e8b8f72eaamr207458091cf.68.1761215160076;
        Thu, 23 Oct 2025 03:26:00 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:25:59 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 04/20] ASoC: qcom: q6asm-dai: perform correct state check before closing
Date: Thu, 23 Oct 2025 11:24:28 +0100
Message-ID: <20251023102444.88158-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfXwnygIno/vsGZ
 1DvdKKT+5PfXFBLjQHW6qZ8cUp1jLhKP7txwTtXxEOCWKG4QkMj+OcV2h00WnSWZYlqGZYSCHbQ
 yHhBYAppoe1ILtlI8juPqxeoNfiVO5dLfRtHkUDAhoLzte6OWP4BJP7mEWovVJQX6R17S92wyDh
 nhlxvx59BD+gFH9EBOI0j3nWHcblB/J254DKkBv6i/mEun2MyadHFHN41KWEh8P+EcejN+KYfU3
 91kANcommqsJhfa3fLyPpYUQ51lOgzlc8Xd/LXzSG6N625smmlBWf5OTbeFf8ef63Z2DCfZK3qi
 OX2frW9hgJRr7xuESbj4ep+ZwL5cw+9WUrDuZYjFr+8Muwk/46h/VFrJ/Pz617I5h+zTZkAtrno
 f7kplwl83hjx2S3CjhsRlmbop7Orkw==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fa02b9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=MOmvoJmQv4oe-d1MVI8A:9 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aUn5U7I29hwq9oow29kOd5sHEvmlQ124
X-Proofpoint-ORIG-GUID: aUn5U7I29hwq9oow29kOd5sHEvmlQ124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Do not stop a q6asm stream if its not started, this can result in
unnecessary dsp command which will timeout anyway something like below:

q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: CMD 10bcd timeout

Fix this by correctly checking the state.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index e8129510a734..0eae8c6e42b8 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -233,13 +233,14 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
 	prtd->pcm_irq_pos = 0;
 	/* rate and channels are sent to audio driver */
-	if (prtd->state) {
+	if (prtd->state == Q6ASM_STREAM_RUNNING) {
 		/* clear the previous setup if any  */
 		q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
 		q6asm_unmap_memory_regions(substream->stream,
 					   prtd->audio_client);
 		q6routing_stream_close(soc_prtd->dai_link->id,
 					 substream->stream);
+		prtd->state = Q6ASM_STREAM_STOPPED;
 	}
 
 	ret = q6asm_map_memory_regions(substream->stream, prtd->audio_client,
-- 
2.51.0


