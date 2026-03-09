Return-Path: <stable+bounces-223498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMh7H+xqrmkvEAIAu9opvQ
	(envelope-from <stable+bounces-223498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 07:38:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 282622344A5
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 07:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FA97303A8CC
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC435DA41;
	Mon,  9 Mar 2026 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkSgjlrX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MYVbhpjs"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA5359A79
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038255; cv=none; b=JTKFtZJFYPNA16mkoFgcet/msN+Ri6qoW1Cpy82Tb98LMLckxvpn0rbtzwKrvGIvvqvRDyu1jsd3VxipF0Nb5tfsc418uqLZMGysTo6LTelWo+7hNQSOKtlY3I6m2OI11TbWQJ163as3xyZNwMk6u+Ven/sZtLzc7SOmRDyIH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038255; c=relaxed/simple;
	bh=BANGpb2pTLYLkExQ0zMnsBgrD8C6VbkTG23KlR+dnak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/pQzdZIrWEe4Rx8zX3V4+QBqK6FbYlL0C4wJ07bEwIKLjRxWC3PZRhvoGhOLllDq7CnjB4BcbcbEBSoz7Ta01pYELnIdkIGnlDeyeg4loGVjBWGqOYuMV563XQjTKP55XxmHlHeaT6dXu5QddeXLX4+LWkqg8F8yBP8LhXW5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkSgjlrX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MYVbhpjs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628NIxLK233691
	for <stable@vger.kernel.org>; Mon, 9 Mar 2026 06:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=75/WaeLRTgLwiigcgIHrvpYwnchz94sWj9/
	A9Y0mA1g=; b=AkSgjlrXNbn+wUffsmmd6f+go94gDEr2bj43OEHe82/5M/iAncp
	8CGuUIrd9M1BXzqpV74ji7lobUKarCC5lnERETIdLmjj1wlGTrMp5yc42JHHMowv
	eNVV5Ts32JjrZeksTNYMAI+ovgc/+bUvhh9NfyLDjx6k2zFFpkG+qhW8NHiLQLjf
	d39rSjprax1PqUj/rRQLDSyoJrc0ZGdDZxDPoq25ceG1OthZTrpfpZYEQGgsggw1
	EQjwLP49NgZchsFWkSTe8/EeeN10LhMSsK/bpWdJoT2ZLu67axqKhI2sKopURnK0
	Nx+ziYI7HSTF10HF4LdahgpDVrzDbXlzN3w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crc3vc4te-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Mar 2026 06:37:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so10506170eec.1
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773038252; x=1773643052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75/WaeLRTgLwiigcgIHrvpYwnchz94sWj9/A9Y0mA1g=;
        b=MYVbhpjseFB37rQYqEb5gCplXjnNX2mgFx+hWdhfKCzdxfYF/8JzGVxU8R+wtEYysV
         hTljHdq4PXRqjiNbfxicXFfOqa15y9rcbtJ2XHKGv5JWqV8BlVqHoIJiLGIv4jWsV4iv
         TPCMFfw72Ar6DFQSHjTe9+B3936Kbzb3nRKiRyJUOm+ZcFPuPR+SfFRECFUCZnaGjOrd
         N1f8CTvBdCvTznQW+p8fh2/FiFQlnOf1AelTyw19GpoWZE6G4F+EWg3g4OzQELFAcwuU
         I1rbhLnajiU1/uKZuVQsgC4XHseTwh1vE/IRsPFPtWonNNbQYTHATDa+OuPBkahi/3Mk
         kjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773038252; x=1773643052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75/WaeLRTgLwiigcgIHrvpYwnchz94sWj9/A9Y0mA1g=;
        b=iSc9STyiUtQSJ5FmiSTl19QAEu7/6SBWLJpuq6mmwua6M0wm/UmiHDCLF9+G3asY+B
         iJzmjSv+7GRxxmsGGCFo3rLgr4l5T+LfwSETt0qijZiM8KKoD/MuVXD18W/LIE2tpDEX
         n83r5f3YIGRN2BK3AmyhSn9FG8eZuFFCvsT3lgkfM/SNkBJziz0+ceWJ1xRUf3qHp1Vd
         Jb/0vHCKp+HzvXrvIcQ0IQYY7vbHD0NefGAybM9Sc9P12nVf7oh9V2phDsPqHCaK1wXb
         dFo/UKuXoR1Du2qjP5XLeRUOJjUxZK1YEpvta3beA8ObomSNi+cwSDa7/ykaE93HnrvR
         HYQw==
X-Forwarded-Encrypted: i=1; AJvYcCXHPOKOgXzgiW+TO5Y4hzNC0tQhR0cUbgIBt3V/5GjZnrD3zsc43qgXa3ppknspD5lF5YU7C34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjvQDgQbzmpNe30NfeID+xKDlKtkiLIXEn4ZZIxqv0qf/ab4V
	3sYuDpL/bczUxBi9PKBcfJIaV+lACpDRrHbJzWLP9ctr50U0YPBFz0IeLaAgBV6I3lMDX5XHMNO
	gkWl5Eg2TTGaG+NSN+YTnsc1dTPoVQDcsShe13YZc2GoLPmEwakLb5uYw9WQ=
X-Gm-Gg: ATEYQzw8gD4Iqs9tBzqOOodADlX38dH0/UWXUkbx4Hj5tXNCSiYH5hh6xTb0dq05Sfh
	/fRBjkBrL2oaaGxtDgESUxcge/VYtCWhzp9e43lel9spzR2aYlu/OLZ5QZEA/E/JxO3a+1uam3u
	xYEM34fmsEjLJ6hksBaevGMJtIK3eRDja6uYQOUri9aw7f5huGUpPcuvVBXah5npmnX7TsQ6x2I
	PSkPnuRk5Qbd+nTYceni0csxbKsp7Ad9Zv4ZXinbm6NpnvWOFK7secrESfHonF65lVJULGYNlc9
	wDHbrjl6QXXRDveif9VqazD4Cl9/EaXCaI2JdS8/o4s77u7/79Ese+2DZylld8BS1/YMSE0YPaO
	bycP1AL+/NdJIM4PlYYS8GyrOJMkb17dEi12W9AR/8FCG7pPtnYzzmrl6wtyclJuvS+vn+EAF
X-Received: by 2002:a05:7022:628b:b0:128:d55b:a0d0 with SMTP id a92af1059eb24-128d55ba213mr1040240c88.31.1773038252134;
        Sun, 08 Mar 2026 23:37:32 -0700 (PDT)
X-Received: by 2002:a05:7022:628b:b0:128:d55b:a0d0 with SMTP id a92af1059eb24-128d55ba213mr1040213c88.31.1773038251559;
        Sun, 08 Mar 2026 23:37:31 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f5a102sm8488626c88.13.2026.03.08.23.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 23:37:31 -0700 (PDT)
From: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, neil.armstrong@linaro.org,
        krzk@kernel.org, abelvesa@kernel.org, konrad.dybcio@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com
Subject: [PATCH v2] drm/msm/dpu: fix mismatch between power and frequency
Date: Mon,  9 Mar 2026 14:37:20 +0800
Message-Id: <20260309063720.13572-1-yuanjie.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R-VXNGPxzjRGhcX7eAFkdzvY2ur6qlP1
X-Proofpoint-GUID: R-VXNGPxzjRGhcX7eAFkdzvY2ur6qlP1
X-Authority-Analysis: v=2.4 cv=OOQqHCaB c=1 sm=1 tr=0 ts=69ae6aad cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=kp0xKC1fNrCP_-QnSFkA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MCBTYWx0ZWRfXzryYB5n4xruG
 hz9oco6CnWe8XG8KkgdLcsdvokN+58atbF1oxtMF7cePKo4j0K36doRKJjaC2/KQKyt/JrvMFeT
 1pzGYUC8iaLPQqrjgwkj2ooumQ+YqurK9b+vNDXnqVU4B+LbB6M1EPczSg8c3CoJ42mVp75pgK+
 IN7ZhLKw0I6Xj6aK6VM7eDvM04DMd4xZ3U3ijoBrWXSecvmjOfxPv0f0vRGFBXLaM+zjBpxFgXE
 G0JH0CXOZ794Hh1+obOmrbjhvsVGDZplCFEYQkn5tpAAG5q8T0fKtm0SBzThIFSTJ0RW5FeOAUt
 4r7KjQAhg85Bh1h7w1w9h38bwZbXhHSZ5LR3xM/Ex+DKDA1cXGpC0xjzlq+K6qdASYfbD06W/aH
 BXuc5ZxZT6OX/NOkQ5jLHzrV8x4HQHMLJDUDFUcLr+e4V42965aPzfTEC0O3hZEx19NoR91e6xA
 W1dkAv0s2BZN6EGKcrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090060
X-Rspamd-Queue-Id: 282622344A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223498-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[yuanjie.yang@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

During DPU runtime suspend, calling dev_pm_opp_set_rate(dev, 0) drops
the MMCX rail to MIN_SVS while the core clock frequency remains at its
original (highest) rate. When runtime resume re-enables the clock, this
may result in a mismatch between the rail voltage and the clock rate.

For example, in the DPU bind path, the sequence could be:
  cpu0: dev_sync_state -> rpmhpd_sync_state
  cpu1:                                     dpu_kms_hw_init
timeline 0 ------------------------------------------------> t

After rpmhpd_sync_state, the voltage performance is no longer guaranteed
to stay at the highest level. During dpu_kms_hw_init, calling
dev_pm_opp_set_rate(dev, 0) drops the voltage, causing the MMCX rail to
fall to MIN_SVS while the core clock is still at its maximum frequency.
When the power is re-enabled, only the clock is enabled, leading to a
situation where the MMCX rail is at MIN_SVS but the core clock is at its
highest rate. In this state, the rail cannot sustain the clock rate,
which may cause instability or system crash.

Remove the call to dev_pm_opp_set_rate(dev, 0) from dpu_runtime_suspend
to ensure the correct vote is restored when DPU resumes.

Fixes: b0530eb11913 ("drm/msm/dpu: Use OPP API to set clk/perf state")
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 449552513997..327881056dd1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1463,8 +1463,6 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
 	struct msm_drm_private *priv = platform_get_drvdata(pdev);
 	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
 
-	/* Drop the performance state vote */
-	dev_pm_opp_set_rate(dev, 0);
 	clk_bulk_disable_unprepare(dpu_kms->num_clocks, dpu_kms->clocks);
 
 	for (i = 0; i < dpu_kms->num_paths; i++)
-- 
2.43.0


