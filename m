Return-Path: <stable+bounces-191809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E61C24EC5
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 13:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE87E3BDFF2
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD97348453;
	Fri, 31 Oct 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gN1t8NyA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ja1MbekQ"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10C347BDF
	for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912459; cv=none; b=nxQKpcCXTVhs2crvsP1tmwAoRjnpMssxzz9P+YueSBexLicxmBEmHVXgLlqMRdqe0W/6xXRBluHCmOw7Err8ZxzgbzaCo1aGZ63Y3RO42EUN0a22tYpChklqognrQZUG+1aqlmtQuwdPVDyCYcJd0xZZfu3OeXMY5DNSIovhRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912459; c=relaxed/simple;
	bh=tBK1qwBUvRQMVKV0Br5+JUjYr+yEhU8c8RDgQyKsT2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxV1ZXPxG4Z1h2ctfPiLvnp53YbwSAhBp+VSpCdl1bW4A90lRGZfwzPUEDiGcO21XDkrriYBIkHVijI/FhCQILG1aKdI9Rx7DLDybL07Qc5ma3MoAFC1TNlUG2HqkIB43e2eRm+a32M+Ugerzxr3KLPegY3ArKI9QqIkI7LXq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gN1t8NyA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ja1MbekQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V73IOd2058364
	for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 12:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZWwpst+Hrx7
	G02/RkAKzDN+ldfPPWqoovAXsun6iEuQ=; b=gN1t8NyAcBVi60Vvai+eb/AFnpz
	mJJrg9q+PLn6babOQyCZWdbP99SjWSpjQPsNxXaK19GL5a71MZPwB2zID1xwtgaB
	xzoRUsQSggjuuST1LjGO7ut4Qkcyj4fMb63cNkSJ0mSmCcj3FTbNFaXXJtBatJge
	Wdf7dU49CLdVkEhiPXAM2fIe+LC8gf1OtwEOALxgeU4wlEhBolBdlt8uiy0bj1dH
	oJbcykGiZphWIB670vq0K0KxRKEjn3rDEM6OSHyuAabtdu9yXPz8/pXP9jgTBYfZ
	WF33jk+EZ+0OGWF6aJo2O7hJSzSPApNcRAUWm1kzFVurV5D5GYN8RagFOgA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4rcvgtf2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 12:07:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eba120950fso48052691cf.2
        for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761912455; x=1762517255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWwpst+Hrx7G02/RkAKzDN+ldfPPWqoovAXsun6iEuQ=;
        b=Ja1MbekQg1Zs3yQShBeYdzUqi0r7QixB1al9xwafsSl1EOR5XARcm8JRxScESc+zyb
         oldJ2ku3MzwKAm9ApejYX5ACx21UArsLB/tV/i4z7CmVYNhaGCSawqL2yrFCY3JSXCmh
         28ShcBP/39PPYk7xlDnyjvNR58RUQeBhJXhUl1LeqB6Jy1ZI5NWiBL3RfeLfGZEneyJ8
         NTGj2sNYEgQFiIl8HnkAcMoJch0kTGfWW6S2CgR5cMJpoIUBAnvsW53VcWzuMKgHbjC7
         8Fe67EtbTxi6e5uHWgaiKAzsKwMTHI/1XyIB81JQFoNw3LdJTbYXDMtxtON+BNWb4K7i
         Th4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761912455; x=1762517255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWwpst+Hrx7G02/RkAKzDN+ldfPPWqoovAXsun6iEuQ=;
        b=lzqiHDLP7jemGtNpkb86PQ+KUs7WyfRVwaltiSLxTYRoE9Rc/8pbAgG94/2v+wzywl
         /vSrw1unqe3JSIVsh05OhC7mYd7ayvgqyISv1/ngAFkXfFmQ+IMkq9Yyr+FoTcDfWf47
         TwJW03BJXONppe8c4aX0o0w6dBRA6QL5oDHDio3MI2swGvlmPRFC1IQ9YKhMgBt+SJyN
         yHjMbJVX1SnAwfB8VtRZ3WIbNcXuMuIDpPEJ8oJGncrezj4Y8YtQ8cNfnxbEZnH0SSuW
         MawVJil3ctfer58emBbcyvpb16DYB0QpcOcqbZueBIo28iow25YybKNoqnewOE7btWa7
         GXzg==
X-Forwarded-Encrypted: i=1; AJvYcCUbI81KBK4+Qn5AuRn56XtrsEk5Elh70wcBF0V2ku0ACiBE71n4pOMzjcYdnK5jnnOs66CHWBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkn4ONNXcojZABVfa2Q/TKwaZC4PBVVm0L+9vsvUn3FVKEQAfh
	qxIIMLs0567cQeYDr0D+Ga6BXyGTvMKWhroc9mQqfYQYkNCtbuUD2m/vnhuy0Q4+wkIhlElNcT2
	tY36R82YVBy5/E/H5R6n2MtK/RgdMfNVMhihUUxW39u5GxEZHDHKUikT6EHA=
X-Gm-Gg: ASbGncsZPCAz3CLfS55hWOQUQD226G3Fv00LBnVCRzNSRgfg39drsmNaMEd6LXGF8AW
	F1w4W52IYgG8DyfwwltTiKbN5f/XFNKe5d0MwPOY9N2L/G0O/rn3O9idpPmmueSz790Zh7oJuG2
	jx+x2k4c8kOG65bkPvNQ3RFGwfGBBi5aMmRolZg0O1i1Q0vC16aePJj5o/eUEeVpuvooAhIm/e6
	0lJ4s0UuoFd/q/4Q+ZqA52YkqAU38hIHX+5md/EtnLCvJrO4j8RNZ0SjyhSCvHNLbm+OlPh/UW/
	YYOCdta28Q2vqp+2s8bi+a3oW+9W4+cBps4fITeQAGcyiHBOg+RpLHwFlyRBEidbndDCIH/6/45
	+zX3hKQ30RZkT
X-Received: by 2002:a05:622a:1f1a:b0:4eb:a3eb:2ad1 with SMTP id d75a77b69052e-4ed30f9c8bcmr39360991cf.53.1761912455271;
        Fri, 31 Oct 2025 05:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFubrQw4XO/dt+yCzz4q2Xa+aUfqymGqW7ebuZTqajutjz+f81U2jcLSjc0jlESDX5Kqxd0BA==
X-Received: by 2002:a05:622a:1f1a:b0:4eb:a3eb:2ad1 with SMTP id d75a77b69052e-4ed30f9c8bcmr39359921cf.53.1761912454522;
        Fri, 31 Oct 2025 05:07:34 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fd280fbsm21273995e9.5.2025.10.31.05.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:07:34 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v3 1/6] ASoC: codecs: lpass-tx-macro: fix SM6115 support
Date: Fri, 31 Oct 2025 12:06:58 +0000
Message-ID: <20251031120703.590201-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJYb4f+Z c=1 sm=1 tr=0 ts=6904a688 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9D4bFhRDwPOLDOHaW_wA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwOCBTYWx0ZWRfX5ZftIN4seHCa
 nSpR3kn+RcqPkqodv75b4JjFVjus8lRYc/Fp/oyz7J/vxEb7rUGZf4I3RmdgT2R5QwwXL+OcO/b
 XQMyhbTVHgPt1Sj1j9e3TNqUt6cr74kzWvLuvzcfJk8pghnoOQjBtIBIFCiEdTOX5vPND+88tkh
 4NymkpY97sTUc2opzbdl5YkxMRm8QK1mEGIMFG+zvFzYcDN4Mkoo87Fu6vt+W3ebjzq3+4ozRKb
 p9BvJNSBrpaIRpUfuMenvOf3ckxjAragWp1QZhaaqmTwH7ZFzilGr1mL2eEmlm9u/E5EnXwCvZF
 b+mg4QuPH/S9zsg3mtgABSu44ouT0cRpB9JIFDrjSrgzYOsLKebfTTdSw1Q0edmjqzXCdtXx+60
 ZWETkgdW9+M173llG1r7qn7fHM+7vQ==
X-Proofpoint-ORIG-GUID: ATDCNUTXtQIwshm3bYVo-59CGuSX7sXm
X-Proofpoint-GUID: ATDCNUTXtQIwshm3bYVo-59CGuSX7sXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310108

SM6115 does have soundwire controller in tx. For some reason
we ended up with this incorrect patch.

Fix this by adding the flag to reflect this in SoC data.

Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-tx-macro.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 1aefd3bde818..dbd8d0e4bc75 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2473,7 +2473,8 @@ static const struct tx_macro_data lpass_ver_9_2 = {
 };
 
 static const struct tx_macro_data lpass_ver_10_sm6115 = {
-	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK |
+				  LPASS_MACRO_FLAG_RESET_SWR,
 	.ver			= LPASS_VER_10_0_0,
 	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
 	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),
-- 
2.51.0


