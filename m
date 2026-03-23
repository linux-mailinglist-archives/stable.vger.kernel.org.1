Return-Path: <stable+bounces-230027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDTDCk/LwWlUWgQAu9opvQ
	(envelope-from <stable+bounces-230027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:22:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 881052FEE55
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC4EC301E220
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C53845A7;
	Mon, 23 Mar 2026 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZbIcTg2w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SmjG4ucl"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980C382369
	for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307882; cv=none; b=PofnS4MzbOmeq+UFQXx78Ye/jm9W3XZ4RBdehK9rAhGPjRnqADfm2D7zZFqEbml5GpBvc/OL+dg+D7Wqt1Wg0VK9aFdHpbqtGamXLhyOqEgtkZyOvn0BV229QG8nIvrDFAtgHBUASEm6Aj2P/80EDyrMpMrkV7N/QPWmdZbT8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307882; c=relaxed/simple;
	bh=AyY2hIjDZSFWCXLUqukGSX8OjxFTqekOyePOX3n/en0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOFeNz5/q/Kcuy1i2mX5jbK7Hx3bLFqr58tvW8hbSWJC8IUElqM+sbUsYsHbdzFBy0PScmXt3HfsaaJwhGExYuJcFdW6L8vOK4+4pul46IuLHxpJGw828RC11VoYh7ycf7pinW4/Ko7LehQ+qbQXzLPeU7I8ThUBcibDedZGfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZbIcTg2w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SmjG4ucl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqwg72972577
	for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 23:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=L5JF/OFCjycRKwxHlQnaKEqRuOkw7e8QXGy
	WvKIOmXw=; b=ZbIcTg2wC8gfT3Njs7Rx+upxE3sqFI3qCeE+W972ysdOTQOPwUV
	h4tlmpqopNjRcuPG58unf6gtv5IiOfIIPKNoVsKfSufzh/3Sl0d6Wdl1z3KncGn9
	kpuq2mtVVL+T7aGS2DgVmqMlGx6z2oKOIQsb0ak3HzCVqKBKZMRWiR1SXIEoGP0h
	fZkfLKtGlM2jC3DsLPh1orQvS/WaT8Vvlh6tFzbJktC71FVsX/L4kxzYlEEvk2b6
	qoFfJkc6PkPaGdtyA6AvMR/iFf7yyF7tec7DM0mihWgGNo3RxC5Q0VHw+LjTzu7D
	zfkq8k0CNWlSUCaeKdhuu0kJL9Lj8C2XIdQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc33x6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 23:18:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5090cc6a7d2so288299201cf.2
        for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 16:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774307880; x=1774912680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5JF/OFCjycRKwxHlQnaKEqRuOkw7e8QXGyWvKIOmXw=;
        b=SmjG4uclCXOruv0aweW3zkUNV4fOfmuLLcu8U2C8Mh4vNZ0WYYFLY0oTOR698BDYqA
         xHNyY1izdvF0nkNOXZ88/usu3xmh3i72qRQ8mppVP4mmUqDisLye1qHkgcU55xh+j+B4
         ERd9u+W5KnqnyvxfIznR8GNTtju8ueL813Z6hUZCEs23Obj/E5rZsgU6M08v01OohRwD
         7a+RDfCZecrGccnqJsYxXYm+1pWCmoLCOkZwu9MusFWiiIBTSkwnoI2zm6vKgq97go9T
         lTAoXNR8T3h/7BDXjihFvYIy5gr/a9ITvHvDcGetLxjdO9Uzy/z0S3QtF5j6CmzYDW9I
         x/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774307880; x=1774912680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5JF/OFCjycRKwxHlQnaKEqRuOkw7e8QXGyWvKIOmXw=;
        b=nWbO/dPln3se3ZdPWSJVYBUWiLH6pY292Z23ntVXQwMPDUFEgos8Fuc97h+9jtpNE1
         TwTzr25A4V2ZuoC5sNVFldPSgG29uS8UFBELx7SRuAbX9s25vM7OZhsLRU+iEbNEN5w7
         wlYY+nUPRR2PRPaDEpOoL0VnCTG0+eW0GjyOV9N5Ehw5MIorCNh0pBesvm7ERV3UD/Mp
         WdEAixbT/pqAKPAFxyi80AqDfTHUiMXpj8kTO8PLTH+XOrOhZKaT2pdMeAcQjENRLL0w
         y9J0I6txrWAv76kYWLqneVdg+lB3KeQDrjo+j1aetWTZtrl/ibB7wcYSm8RxFFRGx1y1
         8mxA==
X-Forwarded-Encrypted: i=1; AJvYcCVNg8kMbolkVyrVUvPTpkg9BXEett7/+RDXWrfinc/B7e3X6Mg3uKvFVEryXJXCqU4Q3empr14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRVh5OHNYcyjBoPIugimeXLNyfR98gi5suiyZiGIO3BvxP2mZ
	VKiZ79S+KdjcNE582mHPu11y1DLNlvtjdB3QSPyjwE+8lklm/Xvab8C8GyYkPJotjbmZj+aRnbb
	PZ+6PV21k2pBHZpq8izmU5c5aPqnxReI6bnM8xPivWkcWQ+IhVgM5yDYlPJE=
X-Gm-Gg: ATEYQzyccCXu/3c8OnivC3aL5fbdPvGsFEmVmYCuCPIK+QYJgryjAQbQiPVI5zbNiz/
	8BG8BZEeM3CT92+2ZgexMeOfE/+IU8P2rnJt7k/uR1DUnqq5wo0P6KF5mIw5kHb4BoJWkpv/lIF
	UmKdQKbl9VR4hbMTTOy4EzGAUilnVtt+Cnm7grwm1H0ndMckBnMVhal3T26itaAuE7t+t6VYLBI
	8hKTLP+R7Lc61zdhfuBEQ6CbnNRFKO2vKao9oacQgjq39LoWRevTrwv3vvX5hVL1jlT+l0jXD3g
	iNMsMEqijun0ECeePkGoXWwuGTkHkYhwRo4nmVSWIsbNyvq3hcXNUss48P1vzjxISCkMDsF1VQ5
	MUy+nuxVV4Yc8L2/Dsg2y8IPLOM7qdejiZLY3wMGhJPAnYDISDeThT24=
X-Received: by 2002:ac8:5f84:0:b0:50b:4b3c:7554 with SMTP id d75a77b69052e-50b4b3c7e79mr148900581cf.10.1774307880122;
        Mon, 23 Mar 2026 16:18:00 -0700 (PDT)
X-Received: by 2002:ac8:5f84:0:b0:50b:4b3c:7554 with SMTP id d75a77b69052e-50b4b3c7e79mr148900221cf.10.1774307879648;
        Mon, 23 Mar 2026 16:17:59 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871105d35fsm4131515e9.19.2026.03.23.16.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:17:58 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: srini@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@ixit.cz,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>
Subject: [PATCH] ASoC: codecs: wcd934x: fix typo in dt parsing
Date: Mon, 23 Mar 2026 23:17:48 +0000
Message-ID: <20260323231748.2217967-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c1ca29 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=WFa1dZBpAAAA:8 a=EUspDBNiAAAA:8 a=Gyz1a0GbE71Lk9qgVO0A:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=MZguhEFr_PtxzKXayD1K:22
X-Proofpoint-GUID: pcAFYnj-l-HrGIGLEwY-h-BQUZeUS9gZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE3MiBTYWx0ZWRfX0JXW6FQUBpbX
 5wMK7O5NRz7DRXA39NiCapKbjcVPV7UqO1SrvIUq1QpyrkewgxOz2ADCFdEom0gEH8QcAUnHeXK
 lW9jo3mmg3H9jcLpRSAq1YB9Rrcf+jTMHtjLcroSsCGD2VEmbuYUgSw1iZgGf+CQNQSIpdkfUhR
 AnKuEsynbPDfTh91l3YXfa/omTtEBiSrBIFBEASl76J/QzNY7e8Bw2PmjVzzXH+SpDiwkyCZBKZ
 bY238tkv9NwN5BO/gkgN8wzg7NwdKu/dGXEXYKqZBVyNynY2mLatsrlLQyDIPiqgfaP/u5GwcjW
 RRVhmBfrBY5GjUnBoWgXfav+ZPsqDi18dcyhhlvtVISlDcQ3XHJa4fWUXrnnohYbJp3gG5KnOw3
 ohN78l5NebNcsLXlEmcwAqYisuJ8saCTfMgCz/7KaWFGzg5pA/Crf8u2EMWELDVYeNrwgwERndp
 t5X7fXP2jZYA2FjQkiA==
X-Proofpoint-ORIG-GUID: pcAFYnj-l-HrGIGLEwY-h-BQUZeUS9gZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230172
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,oss.qualcomm.com,vger.kernel.org,ixit.cz,joelselvaraj.com];
	TAGGED_FROM(0.00)[bounces-230027-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,joelselvaraj.com:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 881052FEE55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looks like we ended up with a typo during device tree data parsing
as part of 4f16b6351bbff ("ASoC: codecs: wcd: add common helper for wcd
codecs") patch.
 This will result in not parsing the device tree data and results in
zero mic bias values.

Fix this by calling wcd_dt_parse_micbias_info instead of
wcd_dt_parse_mbhc_data.

Fixes: 4f16b6351bbff ("ASoC: codecs: wcd: add common helper for wcd codecs")
Cc: <Stable@vger.kernel.org>
Reported-by: Joel Selvaraj <foss@joelselvaraj.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index c8db33f78a1b..bc41a1466c70 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2172,7 +2172,7 @@ static int wcd934x_init_dmic(struct snd_soc_component *comp)
 	u32 def_dmic_rate, dmic_clk_drv;
 	int ret;
 
-	ret = wcd_dt_parse_mbhc_data(comp->dev, &wcd->mbhc_cfg);
+	ret = wcd_dt_parse_micbias_info(&wcd->common);
 	if (ret)
 		return ret;
 
-- 
2.47.3


