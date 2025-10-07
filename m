Return-Path: <stable+bounces-183502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A50A2BC0087
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 04:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0DC24EC184
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 02:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840801F4C89;
	Tue,  7 Oct 2025 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bcd63eLL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846714A4F0
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759804431; cv=none; b=clYZ+YOIlqyAHiaRLfoZM6iUUhd38a7tQMMeinp+B20gnspU9jKZ0gtHPI45UK4M1Kd6qT/NTeiyCj7t54r/xf0QYqQ/zxVuXSpUVqzxFUs4gxhzNC0IO+qDnNGn8SBOh5mD8Dkc6reXJZxY3MsJZRERxM6ciSegkrWbfisMuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759804431; c=relaxed/simple;
	bh=Dlcnn7y3HlTxqYtAbXosZmFmnaZZi+s6TuVywlg5AaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LQbisYtNLTSHg5WHJfBvRP8N3D6A0rLyJm5ChEZwrxneA5YqV3sEZgvnsjFmme90+fkWnhh3/ATVGIm24zjQ8CMGx+Io1DnUmxBkE6zwZ2g0BeGSpjRSHk5OuZQkkxAfEZRsPL7wxVY/SJMwW9e4qBnzCBfS5Mob7wbW2244xyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bcd63eLL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596Et6SX003197
	for <stable@vger.kernel.org>; Tue, 7 Oct 2025 02:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7XSY4z7nlmBoPCLNtNQ+8rowUkAIu3i0gAH
	G6gd+0F4=; b=Bcd63eLLddyDJ6CXgrewHmny6+WzK8fp1RTQ/Aeio+5ycL19ssl
	GQEwaFgE9GXFYQfpfkd4E7a1N9+ncetEynzvVfMM2Y1rS+nrIqKvycmsnfdWqAsv
	wosf7clUQAVKyjUgHHkPQ0e4AGU//v6AfBr90z5m3DC5tVt31nh38WFHEsiF1owB
	+nzcykzvi148ojVoJLYJASL+HkT/z0oopKMvf+fyFteuSSXfRSmJZZ8khrRVMqBL
	tzGx3BAzTvQ5H1mu1CaqrTBLEjyH/ItrEybhNkeJRHp6rq38+pqNmy/ARBbZWSNm
	mkpJd886vbRDEcVHf5PdEAp0oocBXneNiww==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6wu08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Oct 2025 02:33:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-277f0ea6ee6so72368325ad.0
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 19:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759804427; x=1760409227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7XSY4z7nlmBoPCLNtNQ+8rowUkAIu3i0gAHG6gd+0F4=;
        b=okv824MpGtoXjmWyR7ZxHlA3drRlzp3F5HcTYp2dSqwJ8oFIAZtJOA0BLvbyQUdhBP
         e49zVl9Juwh93zaHj88+rI9rNPDV/SJHuJUoaezRtH91xtZhej+tJHmArrymrPBH5DHH
         wunkyK4dsWjV+CjAS7rZu8O1mMO4nAiU04RJe9uEVTFH7+oMA/4wm2v+GWHZhhAIyDtI
         /fzznYsw4NCmvUQ8DiyY0KSJruSU50gtLMfSfma1Hq4tt8tuhOQZDDCMuMaKvGQAM2RQ
         HpJdaqYhr3v4HYS9Q4o8YoYDXcBu5a61bBZ+S65dzdNoueNXrEfZFjEg6vDf83S2nNW5
         8Kcw==
X-Forwarded-Encrypted: i=1; AJvYcCXlZw+Zx6lwQmHKbocifuUOMmNkd2NT1Yr7QUJ7NQcnd5we3x+kk1+FBO7st+0xjRngYOjsomc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaT1oH4V6xhBw0iOxx9+OUJHsb4cuxcHrDfv1EuFe3O25tD4fE
	PqX76jyIDLN3PC2xceJWCcyKybPK6IEFWnx6QvrFiBGhGxHpu9InyCtQ12vj3lRqOOfxq5no0WZ
	N66xDhr+ZYd5U79c1zKoTE0lIjKC07cG7rUEgSJYGDLGal1wAtcB3G+JpheM=
X-Gm-Gg: ASbGncttdfkPfEogDnPImhRcp5BEKPZkJLkJ6TlWeMReKGqO8QlK95EmQ1yx0sAoV6c
	o07S3cT45ggwIHiWxZuyEiuaWGxHbJKMoqEUODXoSGMhuwA1dS4J+2nAb/WJdojwXyrf1ainEJQ
	JDmZiRvhISNYJ+0bt/4BcavOKoN6iLT4VHl76s/1Sti+FJXp3GpmzXJsCqFY6XPF11fyDYt9JX3
	JjIbQipI3HQzrs3HKAbdPhoZFoqqwLlciG0/L/SB86ikWNeIYYlpKWvTyCgPilaPCgdvPiKlP9A
	SwO4+QgiJ6YuyridCaSU0lJzu09xLzXPWNWF2pFrywkZABlCoKFZQGYzgZ0AkLO/zBLzbFisOkU
	db2oYiA==
X-Received: by 2002:a17:903:3504:b0:24a:fab6:d15a with SMTP id d9443c01a7336-28e9a5665f8mr169858245ad.20.1759804426895;
        Mon, 06 Oct 2025 19:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiig/p1KQze92yCEITwhtnQai6O3T2aDxdUHjAMcQsNgWMdH7TrKomEar5i3ANE9//H9BSuw==
X-Received: by 2002:a17:903:3504:b0:24a:fab6:d15a with SMTP id d9443c01a7336-28e9a5665f8mr169857945ad.20.1759804426362;
        Mon, 06 Oct 2025 19:33:46 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba25asm147726755ad.87.2025.10.06.19.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 19:33:46 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com, stable@vger.kernel.org
Subject: [PATCH v1] ASoC: soc-pcm: Fix mute and unmute control for non-dynamic DAI links
Date: Tue,  7 Oct 2025 08:03:25 +0530
Message-Id: <20251007023325.853640-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfXybhyElyx3fLJ
 Uz+MxfyFh7ezhUAZGr0+0mTF566IxAQkk/YLD/vbmBcgxtgU6AFB9l/0IDm4R0jrUrweOYVHEyr
 o/UNgcaPSb58iP5bUD4oBmL9Z7FsAbOBxRbQzpibDjDvK9KAWkGr5xcjWjxoFIC4qzfVPjNmd6/
 +BI99U1JFz8WXxkTfFMdF90RbxBCskDTEp6KLMpIPGdXEBkHtNoyrgs0VRUenzHgi0NT+/4LDDS
 hfGQSPu2gWBX33Y9ct22rBESvUNJdqty70TwPfElGC3IimhqKDNoNXFhun/34cMQdyahtGaubWr
 WYk5HWRcdQCi/wc3RiZrHP7FE0/hWbT1Ee2co/6HtsKsXI4hEiKq4GaGSqaHq6kp/dJmOGeh+KM
 dGkj/TuJr5mhn3CtDrphJhmt8Amj1g==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e47c0c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3uxOjINHiGvl1vUfC3YA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 1Y9oSFpsXoXpm4OfUb8D9ZD-K_UTLkqd
X-Proofpoint-ORIG-GUID: 1Y9oSFpsXoXpm4OfUb8D9ZD-K_UTLkqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

In setups where the same codec DAI is reused across multiple DAI
links, mute controls via `snd_soc_dai_digital_mute()` is skipped for
non-dynamic links. The trigger operations are not invoked when
`dai_link->dynamic == 0`, and mute controls is currently conditioned
only on `snd_soc_dai_mute_is_ctrled_at_trigger()`. This patch ensures
that mute and unmute is applied explicitly for non-dynamic links.

Fixes: f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2c21fd528afd..4ed829b49bc2 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -949,7 +949,7 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
 			SND_SOC_DAPM_STREAM_START);
 
 	for_each_rtd_dais(rtd, i, dai) {
-		if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
+		if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd->dai_link->dynamic)
 			snd_soc_dai_digital_mute(dai, 0, substream->stream);
 	}
 
@@ -1007,7 +1007,7 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
 			soc_pcm_set_dai_params(dai, NULL);
 
 		if (snd_soc_dai_stream_active(dai, substream->stream) == 1) {
-			if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
+			if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd->dai_link->dynamic)
 				snd_soc_dai_digital_mute(dai, 1, substream->stream);
 		}
 	}
-- 
2.34.1


