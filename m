Return-Path: <stable+bounces-177835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1CBB45CC8
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953145A3EBC
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9775302161;
	Fri,  5 Sep 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="klSrKRYG"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F42FB0B8
	for <Stable@vger.kernel.org>; Fri,  5 Sep 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087081; cv=none; b=dpKpiZwI9SrY+mXLriPyJARX/Uh0oZTsmIK1mLuV/wRh/ccuW82KPd6O/Yu8+AxD6j8Oz2HRSby2o8X3z3b3iLetRk0fei8M9AAJh2iLTri+lb7WlTm7rb7tfzjCpNToC1PiZtgyhUK6ICeWBJsfGnyncGHyi1ybeAjdVDMJMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087081; c=relaxed/simple;
	bh=vmg0oYOxevk5nWCek+pJEZ1daibBK7o4kDXZ315AyTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6z9pFS9bqZCRWQXZZ+EMFLstrQ5bSJZNMEflPxgz4nkXpiU7j64oyDS8b/Pl8syKMn+bjn1LaqpE3ooZiGwNQqz3xEuVGjSSnvQWWh4dr8P9KxptXQVopBtkxIQknzmlhwd3X2cna2T0e1u+3C8mo6EtSFfzIdJaCP1jH+ySQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=klSrKRYG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585FegWq032203
	for <Stable@vger.kernel.org>; Fri, 5 Sep 2025 15:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qv++HabcA9y
	4aEMaW0PNus8L2anA3PVptVFL6UgEzvw=; b=klSrKRYG2iH4+3b6N+L/zW0QrBu
	a5Rb8y6dAsWe2kBgFh7MCsjfzBTHzR1PL6QSHWkxgL6XhNsfUG8y41FWyziC/hry
	J9TukefpVzc+ntMKUo/cGr1aWH6EQi3/5V3qEN3MA7SY32B750umUAcmOMdwko0w
	moCP7QjEr1Rvn2KZLGIE1hJuyL6nOsNhLk+FW4yXvCNwW71eT6iFp5aDfudCEaT5
	gMHuuKmQjwc9HXTvIXwSkS1i48FkzuIuATRT7oyFnzqHpix0medqYtAgrMVnMAI7
	aAgOmyQqxOoarPGEkM/riUkquU/i6n+v+BeAudTC84D5igMU3qDJQFdeubQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpkraa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 05 Sep 2025 15:44:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b35083d560so50176091cf.3
        for <Stable@vger.kernel.org>; Fri, 05 Sep 2025 08:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087078; x=1757691878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qv++HabcA9y4aEMaW0PNus8L2anA3PVptVFL6UgEzvw=;
        b=PV47YhIPq050qOscjNbrnMxMoMsvD7goX2q1zOuT/N9DHFeJWj0MRermZNKbpg+LfT
         PrahqBhSjbjTgoAiXYTH9jE5b2yaFgpd04h+6QUWZcPmQEzye656xsWF5nvvoKlc34bB
         zb21vjxsY+rySnoCK3Xt/4OU+Mv6N1Rr+4eKR5lcJBqkJv3YCtFvu6s6fffLtPtMHNxq
         OZFEayp9Y8rTw12yVyQCNvFvgpdeuwlHUc4HMNElJ2qYpNF5Xk3dDptQvR8IzQHh0Xrv
         0APgT8ZNrAPWY04GEk7RJ6i5G0J4/DuJ/d00I7RbgcQQdLkFb+fsnR8GdbDKdrY9fR7r
         /YLg==
X-Forwarded-Encrypted: i=1; AJvYcCX50AvPIlyIOGbvsaPdpaXPneyKNIcRJD/7LBSiY11CBNVozNOmwWtPWwc1ZMr9tRT++jL8Kco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYU1GDCBnGC/mV1QX5mCIy5H9RpDQ5oGd5F3ego91aaDHbbB8h
	fOfq1LMnQ+EPqtb4d2/jNGPQeKUdxnNVMJU1yX19G+XAsSfGyqsoQ+LTKFhFmB00RUQQDPKO2eN
	04ujAqVjcEuvC7/Ou9tDYd9vERwva13hAxUC+iRPXAxS8JCwyKSAc1uyX/gc=
X-Gm-Gg: ASbGncvkDlTKz2ZkuXca76bE2vEQAyh8m3ehN67fS9exPnHIq4/KIr+FtsdQQdRiztN
	mF1KWNEGQdJmtHbF5zv4mU2hLldzFh4iBNhtdR85LZynyFHZVWKNsi2rr/1pbZmiWrd1bNIL6uN
	O3SFCKNhubO4maX9tfzacu6hl3rl5OqqDssmTWP1b8DSFhuX8KyzFsFLUI2dvLzyvkavDds7NqE
	jOfVTZFhhYFCTeBwAidmDkiwlJaMrqygnPK065Baq1HXzk5EQfKsuPpBFRJsYPDaSiLNmn0NVmL
	nSt83ytDWZsfZVR8GBXT9PwsBzTkgg1AHnSrUZGONNVyVlyCNpqcgQ==
X-Received: by 2002:ac8:5c91:0:b0:4b5:da71:ce7f with SMTP id d75a77b69052e-4b5da71d400mr53788571cf.44.1757087077913;
        Fri, 05 Sep 2025 08:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfPWdh54JtUPfB1le9155RfINKV1xe4VJp0Xip0ilNblDszr9jrIP5rzVTnhlLQvIFuLirlg==
X-Received: by 2002:ac8:5c91:0:b0:4b5:da71:ce7f with SMTP id d75a77b69052e-4b5da71d400mr53788271cf.44.1757087077420;
        Fri, 05 Sep 2025 08:44:37 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm165716585e9.6.2025.09.05.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:44:37 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v3 01/12] ASoC: codecs: wcd937x: set the comp soundwire port correctly
Date: Fri,  5 Sep 2025 16:44:19 +0100
Message-ID: <20250905154430.12268-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ILKblkJJtx3yulJRfaB_okSHBN3cM7Cl
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68bb0566 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0i9YUgi2cL8IzqKwLzsA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ILKblkJJtx3yulJRfaB_okSHBN3cM7Cl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX59QL60JFdTM+
 uYACbJrqdM2GWpGGvKW26/OEq/us7B+s2JDAIdtwCHyS85IVtg339d8TNWNtp2WTmw7qSbuaxm1
 bQYPet8lr5ytkFHcwuwmG6FnNEkqz3qIuga7ZqdZAFhR/u+QnSKzd1e0pKsp3hEmPnGvghtoNUF
 EH/9cXfxIi/AwM9eT2iqi9AzOLAXevN3dO47kkKhW5a/RzNF8Uk8y0wYdpfhK5vG5WmliaO+zeS
 HCMLI2bfJCp4nkoK3vYcguKc50KwIDfavf1ACRijphkrfPQD4kGhjGRMdJx/RcByCviWTbW5+aT
 hYYm3Id8nzrRSMu/L6pAmNnmCUjBn5fn8s9/WiLdpmVWZBqXuDDAlhk3ltgfFnmSO4opGS2prz7
 qGQhkFrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

For some reason we endup with setting soundwire port for
HPHL_COMP and HPHR_COMP as zero, this can potentially result
in a memory corruption due to accessing and setting -1 th element of
port_map array.

Fixes: 82be8c62a38c ("ASoC: codecs: wcd937x: add basic controls")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd937x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 3b0a8cc314e0..de2dff3c56d3 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2046,9 +2046,9 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
 	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
 		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
 
-	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
+	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD937X_COMP_L, 0, 1, 0,
 		       wcd937x_get_compander, wcd937x_set_compander),
-	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
+	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD937X_COMP_R, 1, 1, 0,
 		       wcd937x_get_compander, wcd937x_set_compander),
 
 	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
-- 
2.50.0


