Return-Path: <stable+bounces-253415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE80FtxTDmrJ9wUAu9opvQ
	(envelope-from <stable+bounces-253415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:37:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E72859D550
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C302B3045B3B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A026C39E;
	Thu, 21 May 2026 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MJQzCC9u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ka7xWfv0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B3221D89
	for <stable@vger.kernel.org>; Thu, 21 May 2026 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323851; cv=none; b=U34c0PPA7L1D60jt+Zy/SJ7JqIoV2CSITfqg7lJ1m1ZX+1xafSI+9yRcYxVJUpXF+SRE1miQqbjW0/3v4yA64ojmyNPTzWm58rVIPtrqdY9nR+ZHGBaKIC6EMFh49x1i2ZfWk0/daWQxs7ijcag3MNS1mEU5anOVl9+PhLHzm78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323851; c=relaxed/simple;
	bh=uslzc7nmyiyHk64GKvcYr12UhsrifhwRpc28XFd675k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fK44vP5u8eWwUfNI5THFBD5tUf1cXzlqVUz5f8q+AsGDGZ/n3KQTsvXqeBcKsoY6pQ+LleqOqUc1kQ7zYrut2X4QQWRt+ffO0aN0SKXRUoUX3tqllkdk4Z/+LL8WENFxlelz6OfWMSSiN7GiE8VxICHQ4fPjTb9fdlKQ7afo/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MJQzCC9u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ka7xWfv0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KGVTmR1177857
	for <stable@vger.kernel.org>; Thu, 21 May 2026 00:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZitX75AVxgG
	uWGiVafC3GvCVVrQgyZQFWsUqIo6AsA4=; b=MJQzCC9uiqc8UeqSu6hBkDkzW8z
	vMpfXecaBT8O+Z2unJsqYd53WFdDNjf0yvPvSt2lc5Jc0cA7HS39EpnvHAYei+Vv
	ToRM8y06afkNoW9RQV+ckYvOPVOEaAVa/yK7BIDAhif6SREQyJqkCVfyBR0kPME2
	UQX/it1lwZyEfXPRw86AGhmmiFs3wmR2inHWoNLhANr7UvNcFxUKYp2Hq+TEqUV6
	h6XG63mCc4PlYqU6K6Z8X4EFR9VwgqJBShzFKgjOZ14r/dyrTZLuNUxzl/0wOXZA
	9egAiuDYoWQYDFAJuSXuHaQR2C9opgL5+xjxO2Cxck62mRWK+YlZGTkUjIA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6u6k7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 00:37:21 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd6fc10a42so110139827b3.2
        for <stable@vger.kernel.org>; Wed, 20 May 2026 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779323840; x=1779928640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZitX75AVxgGuWGiVafC3GvCVVrQgyZQFWsUqIo6AsA4=;
        b=ka7xWfv0FAfyrpNAaqdCSRcMklpSnGvwAe6535N2U7TdcVAbqkUQNpb8g1S/ueu9WL
         VreJvfT4Kzcvvl6shiOf+4+9e5amTScKJIzYs7BHKTCdJMjd1xATfELperA6m04i+O+6
         al1F3HY4W9ZDQCyi3IlEyEg5OeMggKg5ilo/plibXA+Jol3KdCksBBtw9Btj5mPSf0JG
         B7rnWunfW1cDBKZaBgAKxLMc5h+eFdH5EPM57N83zI3c63t/greSIM7Oq5T3WphAJvDt
         4qIbJPQpOpK+zaUgr9L1jbUY6FN+dJLWcUqjCGvqqOjlDnXfHS77hIT/ECn0z2I1aKpN
         PcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779323840; x=1779928640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZitX75AVxgGuWGiVafC3GvCVVrQgyZQFWsUqIo6AsA4=;
        b=CALycqvym8bYBHVD18j8uNzL4tWgJ2k56tZCQZMLufUFpgmASVNy7SetBsfM+w/YEK
         DqqV5eQLckBduPvHhtiTqE2rZMMjJAkrgiWRPu9UjoOWMHzGLFKeJf+bC0PDu8lQw2lv
         MHDjkh2102kIo7jN0WQ9V6gMtdGKrhJMYCyz1LaPzX9Oh3tnf5ndIG/5NFbfEWSqpQLl
         OkENFSswFLb8+cBpL4ahAjbcl6HCVb1klrnrDjllsNvhfScMUtlPAXkzY0FIHcP+STWi
         HowjnbtltkSH4QTEhQ5+683BEdqb0fyx4m3YmawyJ6V6i/AW9YcAQm15P3yz3mPiJqie
         jt5w==
X-Forwarded-Encrypted: i=1; AFNElJ+ffzWwEH5RU3xaYbHF47IyZ4jPDEYNYEaaGLa8LkkzcOVAZi+GB2hhHW9sKg1OvT/rFEw8yow=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkn7dG5lotrUaQ562vyhiY+V59pYtRClOVpWM2TFM9avBRPqDP
	qOVBRZInWm6JMn2Vf7l1cPteen+80yXQtb5gPuqHaXANPUOBtzRcnlegQ4bce8LD15tcE/jfNWB
	z4LNruMhGZABnhjfUqjBvvzLAVr00YptlmXIdQR/t2M17tgo1AHa6+E+s1i4=
X-Gm-Gg: Acq92OHxaNKAIye6uAnFjnMYAF8pEKxxD9/hbnD/4fdxmmHzw9XrS99hKkpjK0sBgXR
	7TrXBQ2/SxejixXe8n+hYM275ugb67l0TKAmQrNmBY4boIQh8q4gVcjfNq/VgafNpewXuIISufg
	Ik+c0D5MRHxswSr/eS37zdFi1NiqQ8wF7OWN5r5FAH7pZ/LIXTiu9PueL4uX8kXMCvB+guWbk7J
	1+dGYNSi5xThvRuLgCEqmnY8Jo4f3fGtlTf+9t+eHJFEZ0tXIga7WdzsLScCJbX2QRV+8NCTRTa
	EGXh8R5v1ZMacGbGvkXLWGOuMjZ1ANwbLMAJ1uKoN6yAezivPN/K4UcOXIab7KF9yE5enQv9z5K
	QEbiqW0fSO5sm10A8B3Q3hxUwPmAgT3EiTHSpOHHpsV3eTLh87C72MlS5/Jouecsmh+MOPZlT0C
	3K7gqBmpUzVqjFSf8=
X-Received: by 2002:a05:690c:e07:b0:7bd:98cc:a675 with SMTP id 00721157ae682-7d20dcf95efmr7291887b3.47.1779323840339;
        Wed, 20 May 2026 17:37:20 -0700 (PDT)
X-Received: by 2002:a05:690c:e07:b0:7bd:98cc:a675 with SMTP id 00721157ae682-7d20dcf95efmr7291487b3.47.1779323839867;
        Wed, 20 May 2026 17:37:19 -0700 (PDT)
Received: from scottml-Latitude-7455 (107-198-5-8.lightspeed.irvnca.sbcglobal.net. [107.198.5.8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c98d9sm60545717b3.10.2026.05.20.17.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:37:19 -0700 (PDT)
From: Michael Scott <mike.scott@oss.qualcomm.com>
To: linux-arm-msm@vger.kernel.org
Cc: vkoul@kernel.org, neil.armstrong@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, wesley.cheng@oss.qualcomm.com,
        abelvesa@kernel.org, faisal.hassan@oss.qualcomm.com,
        linux-phy@lists.infradead.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org, val@packett.cool,
        bryan.odonoghue@linaro.org, laurentiu.tudor1@dell.com,
        alex.vinarskis@gmail.com, linux-kernel@vger.kernel.org,
        Michael Scott <mike.scott@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: qcom: x1-dell-thena: mark l12b and l15b always-on
Date: Wed, 20 May 2026 17:36:14 -0700
Message-ID: <20260521003615.1260844-4-mike.scott@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521003615.1260844-1-mike.scott@oss.qualcomm.com>
References: <20260521003615.1260844-1-mike.scott@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: C3833LR_2nVdzaBx4exB9qURYWfgWL3N
X-Proofpoint-ORIG-GUID: C3833LR_2nVdzaBx4exB9qURYWfgWL3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAwMyBTYWx0ZWRfXyis1dfF9Clu0
 jGpSTkwtU+u2Ho2pX/14O/V5l2DYgxdXfnnO1lZ/CdwOBehQCXP+PF4XNL2f5w8n6PXF9FGpd9+
 bz2bxw/L4f2knb4bQ1aEPXks4McMgnEa/294r7eKhhkE0uJkvT1mj6i+dtGO4hTcbM3W54MAkeD
 dZNnsWSQ4OdvBeOhw6vSNWj52UoWlKcEiI+n8GdUeIiyM+h1IpQlw5FgJl21PkrlF5Q0i9QOoK0
 u7PzA07Fn42EPymm3mXzNF2FdgPD0SBZXytI4w6cNiUQnEX8LqGjIncrrgK77z7b1yP/Ek6H+aQ
 +nQ9crt+idUW085QwYohDCE0GZVo7R9G+fU+++tHrRspjyeqNzsirFKL5hyVmRZ2rJXxb4G9M1U
 HPISboMFhhLJZbsAZa40I4Bg4QTaAYdMFQKaV1zZcIlpsEreWVuj/WCZwFIGj2CpPRARrpgOgh9
 lDSqMp+kw24HjhD1a3g==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0e53c1 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=cdagev08qavQYXHyx3V8vg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CbK1FIr4-MOfYfEwsVEA:9 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210003
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,oss.qualcomm.com,lists.infradead.org,vger.kernel.org,packett.cool,dell.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253415-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mike.scott@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0E72859D550
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The l12b and l15b supplies are used by components that are not (fully)
described (and some never will be) and must never be disabled.

Mark the regulators as always-on to prevent them from being disabled,
for example, when consumers probe defer or suspend.

Note that these supplies currently have no consumers described in
mainline for dell-thena beyond the audio codec (vdd-buck/vdd-rxtx/
vdd-io on wcd938x), which can release them when the codec goes idle.
The board-level gpio-fixed regulators that feed the Type-C retimer's
VDDIO and other rails are not described with a vin-supply link, so
the kernel cannot keep their parent LDOs alive on its own.

This mirrors the same change Johan Hovold applied to every other
X1E80100 board in a March 2025 series; commit 63169c07d740
("arm64: dts: qcom: x1e80100-dell-xps13-9345: mark l12b and l15b always-on")
is representative. The dell-thena board file was introduced four months
later and did not inherit that change; this patch closes the gap.

Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Scott <mike.scott@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
index 96e7a18366dc..d93b704872b5 100644
--- a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
@@ -589,6 +589,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -610,6 +611,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 	};
 
-- 
2.53.0


