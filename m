Return-Path: <stable+bounces-223754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDtJKJyZr2lbawIAu9opvQ
	(envelope-from <stable+bounces-223754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 05:10:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB32452B0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 05:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1FE230EF1D8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C58C279903;
	Tue, 10 Mar 2026 04:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpCd0CYZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bsVqlvbD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C73CB2EA
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773115760; cv=none; b=CM076UkarWJQS/QEUjxs/+ebaA7GaVOAQKIUeqZyh1voB3wFrb5FwYgs9JQ6OvcUOEXjMPtHm+hxjT037I5aellzX3jE/g8zflZnuRDWZXLiop19C60V80J055BkYKdUwjr95TyrwU8AgWdcDv/XWKbC2r1/fYWFMGxUEA6mMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773115760; c=relaxed/simple;
	bh=D7RSg4l0xMBxXV15aj1igeBvh6Yp99FxN4zSXnETrEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsUE7R9pXsNF+3npW+nip+XNggAyXRnR+NQKnk0wsC2XA811Qu+FqSw6ftnNDZQpelvle5BswJdSRkTrNLfviJRSNPozHf76YIQBoL61GCtH2h0OsxSlp94lc3Im2q+7LxjxWusBzZlghxteQnjITdCzYlOt8K0QbCHoFJ+hiXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpCd0CYZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bsVqlvbD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2EumT1460427
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IUB4/DuDC1wDE2keWJkPB0qFs6Egwe4FX8Up3irNpes=; b=LpCd0CYZdTjKwucw
	o+bM8TVWH0NMf5JqcorJ1K34tQKIi3EC5j/935sYAh6dJ4arNkJyJ1+SESXbuvzt
	RcwiQsNM4cGeTvWt97rrZGB940U1A7uyGUG7A58g0WZ+BYsvT2uVNxWTLc1mwN0A
	PkUhLYgiFvxaR1qohYZ/r+Qe3tJr2I6344/6sg3czjvumqa/whhXYiPbhBeFZZz4
	3BD8XpkADQv5Ab+4pmywo1i2jVetbNLVmaS3bWm1lc0xx03VlDINjiUrfwYFD4Lh
	cKjkCAJClXjy1unPb5bkR4WLSQzjA2029WOgI5EO6sZUERFvyLvqPg7VcHvMx5qh
	/Nk9ug==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy2jy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:09:18 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4170546f2b4so10006403fac.2
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 21:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773115757; x=1773720557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUB4/DuDC1wDE2keWJkPB0qFs6Egwe4FX8Up3irNpes=;
        b=bsVqlvbDzRWGeTE+3huvv0Se01F0k3IL+zHMHrU3o7fzruaG8iqzMrPe2sTaeCLDvu
         6rkX6C7S3E3fWxZrnfQvmDVYuJVE2NLJQ0J3eJn6XmbYtmruK1FPB79+1uuVKpQMAvUo
         5/5Ye2FzZX2LIwhqnS2iD4HlqP2OzMBzZDXMA/VvOfqf7ku8gWB2rylVevGWkkDANPll
         7gYoasEykHewcPbksCH6VJJoLOt8Vz/prk+hxxivGJ4mLYdLUTHiGUhOpOAgGOkAm6Vs
         yBlUcl4EW4VSC6l5nUQ2S6jTVXADz/znqQh4T/biNWHzIWYsUm6bsDmpc0dIbhhqFshv
         hT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773115757; x=1773720557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IUB4/DuDC1wDE2keWJkPB0qFs6Egwe4FX8Up3irNpes=;
        b=RbqMuE2Ba1YqsiwYEEHGYsHI+PLldlQLDD7DfhlHaHDAWx35bFihiMlDFAw44X+bxH
         nIJ0+K+C1DhBBgmw+4bBa+PvUtpqBT7AApZuNeRjkYM4VBBvhMzUqdbp+94joxWnNZsb
         KP47OfdydSaY1wOS4sryTvb24qDS6Rci4RfyZrltht1tjYjkCfCplTo83AIy9rp4rZuS
         v5tPU6h3THUglmBGOO+PDCWAQvmKFr92cxtrPhOCquucs7UTk1kV6S6JGOR1WYwhH2w8
         sNH54+9M9pf4UbmTacLEqZ8k6ti+saTUcPn78HjPMNCvt3GCtInSgnis5rOy0qweodsD
         pE6w==
X-Forwarded-Encrypted: i=1; AJvYcCUaNONzqtJrSiwsUybfeb39sm4VZ8Y+U4gVUpSwAPwcsZmZXRKXdkwElIPj1qQvyLgESYhvAbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTci7DxBdI7lZiN+UTKut2zxMoC/fBIjl07iKDY1ubbzA5UP8r
	tEmJfY80/RGW4IKZSQkBEUiOwSCIAcsl4yA0QOF2tDUVm0UoipHnEBjU1cw8Cb4gfip29PvlgCb
	50moXnhCVs0Nf9y/mOXmmBFG0DETEAP/ObRmcQGu95vTkvSqEmK8JtFkj1UA=
X-Gm-Gg: ATEYQzxEuHTAVUlW4iHV6jrrjQIsjlcC69s1d3oYExjD+DBgWBf0lxcOpQHGnRpsE8v
	tDNo1zUoTkLBXhwGy6/2jQ8G92XCGpGQ9VtgmoWg8DrxKTVFOkM0ycs48S0zqfJnpCvRRqeEtJC
	VPCkMlJRfwP2mAHe6P444gYyo3/flw3lDCLOHGYvO5l20ug4i4twGbWO9NbBTynyodNMlW5F4BR
	IrsXqRCqNrbRiIxBsTmde74re+WkrlGB39kHPS6slXExdlB3rCNy6ELCjxyXYqyA+YiQyhDt946
	WpBMAbUoh3q9mXD3yM5kK6vbjdo903G7Uim+MEec8dHx/MjlZoqYKWWDNnaPJcc/DmDG1Rg0Q61
	mN/2evUaCFmFZV3/vuR//d0PdiGjaYugF9yfulC9eZrQ=
X-Received: by 2002:a05:6870:2154:b0:40e:a338:c8a1 with SMTP id 586e51a60fabf-416e3eac7b6mr8389220fac.11.1773115757334;
        Mon, 09 Mar 2026 21:09:17 -0700 (PDT)
X-Received: by 2002:a05:6870:2154:b0:40e:a338:c8a1 with SMTP id 586e51a60fabf-416e3eac7b6mr8389204fac.11.1773115756943;
        Mon, 09 Mar 2026 21:09:16 -0700 (PDT)
Received: from [192.168.86.59] ([104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756e24c39sm1595685fac.20.2026.03.09.21.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 21:09:16 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 23:09:03 -0500
Subject: [PATCH 2/7] slimbus: qcom-ngd-ctrl: Fix probe error path ordering
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-slim-ngd-dev-v1-2-5843e3ed62a3@oss.qualcomm.com>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
In-Reply-To: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=D7RSg4l0xMBxXV15aj1igeBvh6Yp99FxN4zSXnETrEI=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBpr5lpYvZ+ct4IErTPa9Ur2dZl9HwXHOifOnPpm
 stchtoirQWJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaa+ZaRUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUXTg/9G/PF5Gf2GSGQAlgzaO6XaXLSu+bf4rEzzYhXY2w
 z2kzQotKhcaGy57uXKawzo7hFMqeWhkfzdiCLvEksEG37vyJWF7avc2ucCx8UfYKn6e4vmiaOj3
 oe2RkUcVq41+ZxQoAt7TTlo1bQyrjrYc7CLVv9P0ev/2WvCJ0nWx1Gd2llYFCYFzA+w3dhuexjF
 +ZMka3Fz1n0uSIesEFyhii4hpz10Glfe4YVEQeT/oT6rClqpuQIU9wwl9IebSRN7Xr0sSJ/F7v+
 L6foAuYjH+XOxY+C1nNp+/ByYjXDsKkNfYB9FAeW8T7djBhmBxlm40oogjXFI7YgBPplJ4QVEXc
 rcEydODoIrLyMN1CgLHQao9SEa5k0Q4hC3j/6nAl/bWRXZlGpCPOLkTn+2m+9/wPqGOuoe5RpXt
 ggQgZycSARoWjBfJsbcc4i2PFj4Ep4fAW4mojnOG69bazCvDmi4xx4D5o/kp73e7vVH7J1XFbEl
 WRT0pARwX9+wcT/5gYnDyCF4FCx/rnMrw0Ck2NgF79Qdl9wXVyoXd1G5zi83f3e+7XxYD5UlNde
 vb4eI8d9+Y5Mk0f+hClophVqvIzXjd35E2d9pvhoqZl7qMwgSjWC0k6qObCN4maBXyE5Q25JYbs
 NuXt+llpUKl2QickmZ+VYBLKZPa3dCvlDM1YxtnOg5m8=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAzMSBTYWx0ZWRfX8cENm8ddx77Y
 2sRr9cJLS48ddTe5+Nr+16DV8CK0RkVD8uWEEDyfr4M1QhesVYq/qOSWZ6HQzb4nJ1PyQwU7j0o
 5Rn0xde7q59R5iGRQXCY7qdpWHJtWViNC0gISGxwSP4pTIOYHufCEcK8g7ZEFTbGLxyXKezYe4Q
 w5720mU4labHO88YMbT4o7cGWc4fsq4mNuB34UuT/pXtisnfllzmS8bRfreEO9wBCXTLDpgu2bT
 T02NWOsTg+yUZnaoVlbnImWEXVl8QFHqJsTlh1uHs0IdPZ2rFuaJ+jWKUjEK0Zdt1MXubZkqQQM
 O6ZAm0D5dLhnGE0H5GEAntkio4dASs51ROHyuoEpB9TDZ/t7ZmWkP4XhNq4Vq8Cx55U3oRCGHVs
 fwD3qbvt+GMNG4R5z/VQCt0lQfBAouZxiDuE/S2ntPl3zbm/YplzcgB67kMHsCYeUfw96eoWjlw
 GsP5H2mFRmrqcBRikFg==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69af996e cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=v7zRpcr-n2crOtZbBgkA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-GUID: pOtUNw5mVhljxeCv51lMUsDSiFVmh2Bo
X-Proofpoint-ORIG-GUID: pOtUNw5mVhljxeCv51lMUsDSiFVmh2Bo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100031
X-Rspamd-Queue-Id: 41CB32452B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223754-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bjorn.andersson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

qcom_slim_ngd_ctrl_probe() first registers the SSR callback then
allocates the PDR context, as such the error path needs to come in
opposite order to allow us to unroll each step.

Fixes: 16f14551d0df ("slimbus: qcom-ngd: cleanup in probe error path")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index c69656a0ef1766d5a9df40bdf37bae8f64789fab..b34e727bab086c95dc7e760bf1141baac9ccf6a7 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1662,22 +1662,21 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->pdr)) {
 		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
 				    "Failed to init PDR handle\n");
-		goto err_pdr_alloc;
+		goto err_unregister_ssr;
 	}
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
 		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
-		goto err_pdr_lookup;
+		goto err_pdr_release;
 	}
 
 	return of_qcom_slim_ngd_register(dev, ctrl);
 
-err_pdr_alloc:
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
-
-err_pdr_lookup:
+err_pdr_release:
 	pdr_handle_release(ctrl->pdr);
+err_unregister_ssr:
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 
 	return ret;
 }

-- 
2.51.0


