Return-Path: <stable+bounces-179240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2612CB52916
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD501883365
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 06:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9240B28369A;
	Thu, 11 Sep 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nd27h2G/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900B280CFA
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572606; cv=none; b=d0t167mFNUB6XdEzo6FWjdbWS7QWJOQLWot5EpWfDwKttN/RgfHq3DRcoLRs0DZaEHa0Qjen6ned5WbdLabpnZNlnzyJEeXCtyQi6Js/x/8hu5IGcxUGytO/njjZzzbsiaPlx9HKp8l2WqMOBBE+IR/gPIVeKLGZ0kGDUfYMUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572606; c=relaxed/simple;
	bh=RhOFMO390kD6vVPQk+wsaIHxpEh7Rl6s/uQ6K6nB+Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbl7lhS5RlMfWUMSbKLwHW8fQUPGIdjgt4RIcgx+XSbZBoSI8S3kvYu70Q0v620luXS5+JSmOBDC51b4JOp5njAhAih1ao8crA0NCfQ0PU6b/GyCQsaWYd1fFdB5EsrUZ6ldBsTWMjZqLQe5UlwUXvumH6diN9htF/F1DwM0hT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nd27h2G/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2J0Cs005772
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 06:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HWX0jsMcz+X
	znw8DUFwCpjh9opKGeTSObz3aq0hQzb4=; b=nd27h2G/WdRY0aTMKSaIH9KhQbN
	QOrIe8F7m+di12OOyT7nEXM8i5lZ2STbxnPSLDsR9iXaF3tnvCNk8eX6z+fMxHrb
	3x5bSPVRgNMwAvjxgFdNWwszOplU/P7C1hwlpQ2ygNb5Bt87Zvon3Llu/Q+yzYsq
	8Fgq6IJ+lpbjtzGL66m/wbme7IJrYZ5CyQrFQvN/fEm7b1wtAZC9Bk8ywi+9Shpr
	8vjcL2rK07zNAlgddRYr70hWh8yA1Ur7JqAa09iRd2bDuDUMv2n3gq56WIE53LCq
	SLoE24Hm37w3vfjOo4D1CctroAjK2+DTc+7sUBk/3xQR/EllA0sL4KAaL1g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2ak74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 06:36:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b522c35db5fso327745a12.0
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 23:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757572602; x=1758177402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWX0jsMcz+Xznw8DUFwCpjh9opKGeTSObz3aq0hQzb4=;
        b=OS55TwwyWpoJex5VF2i5Vv8le5zsSy6c/gkK/4QoaVN6IvbqgmVFoikD9Is//Bi714
         nKGnNLqHoDXu6ADraSsE8uwjTH+y7zNLvNixDvU4VVvE0Xq5EeJ6NVRqUhivjwhOJSaG
         hiFPC3ReOt/b6RBAcaoEdBcUZVtzVIJssqURJA6yanCx0YFkNTAlsp4p8nqMMOT2L6rj
         R+W0TbArEuNrQP+/ksTcHxk+67lKIMifDubbJOIXLsEHDTz6uWYvIyFU+BQfiDZjX0kw
         l5OlzJlTuolu8tREBlH6O5sRrKBV38Rk8nKxmS8+9n4yxxSrOUYxzaOeJLDtbKizvKAn
         oC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGjXRLN4Ni3cTa7SrWGlLUctbrqBVpM0QzBI7XYN1ZKTft8NNOg2T8XKreZPl2nIwUHazQYYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtY26V88EvJqMHcAXLnslq7OieSj2RaTQSEimWBcuXEQlrlPJ
	SPhZdnAOOUr2zG96aVkBqBeRU1MdYLg+4y7mMM1SHI3QvqzfGlK8lt7XgZPhBVWbDeACrQ30wM6
	OSStowzp8tmwcH4H3fZoTUs8x7lBUw7OQNqEnip07lqmTReOFUa/6/Qf4p0AkszOUuJQ=
X-Gm-Gg: ASbGncuwj6iyzUHKTBBGPfyUW3TydkXrZda85BZ1airdEZ/p9HzK0ks8YHZ5yrF0n27
	IDQs5ExXTvWMVpkYlphXPgGvCJfj2bVys+Xsun27vTzONMWJRI7Zb4bCnba2vctUIIKTv54DZAv
	PkVxf/7EkgzRRiI0YeYiFUdzeHcgjDqFU7N+e59AjWa0+dtYdcaNFPPoGkX79SgrDoaXXQpimIG
	B0wozp1ZCEBTms5oxoNE1oa0V+yGpZa8n+IrZRykzSqH4tBxJYzm2MW+rpNgAYdpDtJcDM2ah8+
	v/ndWSDhH+OBjFSffugR7B1qXcbMn6ktoXmMUJHu53ySyIRwrPOtyUkL844XQd8UEFXAtvZzbNk
	X
X-Received: by 2002:a05:6a21:6d8a:b0:251:5160:f6c5 with SMTP id adf61e73a8af0-2534347f671mr26157977637.37.1757572601476;
        Wed, 10 Sep 2025 23:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ+PJd2BseHqXuEekWx1mlj2LglhTy48gVjDdZnPnheJmB4iWw19sNj3aiXoyLJBORiykMfw==
X-Received: by 2002:a05:6a21:6d8a:b0:251:5160:f6c5 with SMTP id adf61e73a8af0-2534347f671mr26157951637.37.1757572601004;
        Wed, 10 Sep 2025 23:36:41 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84f72fsm7739125ad.72.2025.09.10.23.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:36:40 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 2/3] ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
Date: Thu, 11 Sep 2025 12:06:11 +0530
Message-Id: <20250911063612.2242184-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c26dfb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VUbThP3hI7wIHPtXhhgA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ukaUJS-2jxZlwfp1l1fm9jCqye54RCIx
X-Proofpoint-GUID: ukaUJS-2jxZlwfp1l1fm9jCqye54RCIx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX2WE/oGVoBjY6
 czVfTDbk45Ov9DKfH9Da1FxDCU5umslyw3rdbKPZLRGJHWOKo+7/qI6vEIidLSJTL9cFAFu9HcC
 L6hm4bAEkimuyIMGo4AQLF9iJ/omXq0b6C7V7eGKoLD8F8TAg5QPlE4X5WtLc6qwdaPIsp62Nz+
 CRlBw2jCgYglyvMofd/HWrAxlmyaPrwgSxt00tzxc9mQO16SLWJmgEfqYM7RWWPNVZS9Cd3hZfg
 wHAaQ/aZI8uBXevlJ1BVAUEuWOuN6BIrablNHWR7AtzyGipTq49CFj0SpYh5yv/+oD86eTUz9Fv
 /UslaxSLmyAsXaG5AZDK0SthpXc+oWvCAA/A0fZMZ5PMCLzlvhk0ah4pnUHiFY2sEbJutVYMh/K
 oM85l40/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

The q6i2s_set_fmt() function was defined but never linked into the
I2S DAI operations, resulting DAI format settings is being ignored
during stream setup. This change fixes the issue by properly linking
the .set_fmt handler within the DAI ops.

Fixes: 30ad723b93ade ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Cc: stable@vger.kernel.org
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 20974f10406b..528756f1332b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -262,6 +262,7 @@ static const struct snd_soc_dai_ops q6i2s_ops = {
 	.shutdown	= q6apm_lpass_dai_shutdown,
 	.set_channel_map  = q6dma_set_channel_map,
 	.hw_params        = q6dma_hw_params,
+	.set_fmt	= q6i2s_set_fmt,
 };
 
 static const struct snd_soc_dai_ops q6hdmi_ops = {
-- 
2.34.1


