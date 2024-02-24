Return-Path: <stable+bounces-23571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D0F8625C4
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 16:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E9C282B60
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A424B54;
	Sat, 24 Feb 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pzWGQLyz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFFE559
	for <stable@vger.kernel.org>; Sat, 24 Feb 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708787611; cv=none; b=ZCcDNu8SYC+Lxa6kEKn9oOvwb1MbbHLRPtcW2KeW152uysTCpJ3Dz8Aa0NHtb7hSm5Sz0NhpAbVx5e+dI5OEE/4CfLgOFn/ABIBtVMPe8H555gfqhzUA7S+z2xLNFZvUKarJ9nWUJK2IQAqd2QqgkZ2GApcFA7XcW573OnkB1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708787611; c=relaxed/simple;
	bh=iH0cmn/PzDVCeYjVzbKKlG/flQNqKVr7ns0XcjV4cMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QzbCj24b6kSU1I7FrkdJczRWLAsC5xoD2w8Hm4YVoTefcPhT7sqcP9mc13afA7w8KZ3zMYKWWea1SYBumTUjsTG8/bBP23bEVjXUaJnulXoQ9WkLTamnbnf0tXCoLbXL8OUYEmka3tNdiJapKl6GskwQ5f3J+itRnLj4bUtF5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pzWGQLyz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41OFDMVq009703;
	Sat, 24 Feb 2024 15:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=vm43AHf
	KrpEAmlriQ1rL1f2nqgUvYYMyaY7EE4JlVIo=; b=pzWGQLyzR6oJu9mn6tZladH
	orC2cyCf8neoVusEn6g8e7fqk8v9DPJrWj0WsC2tEqqxYg7742rsBwTy/ndvJ1E1
	DR7WWGxAm1OpLw9+eViU5uwUhFnj9Vj54Fq7/oWmVbWDuP9SIJ+gVhGeDswKY+2k
	ifdGAznNPhec2ehtY3/0EM6SFQmvnmEbjOZbPkcB5yrXhASt3Si6XIOIQA1QFpMJ
	AL2si5Lx/Z1sIS+KDivYLOJN7GKA0F6/h8nkYYHJ1mxxyvp+rd3xXmh1/8dkKSZq
	NQLbQ91Tk6YkQIGcNLsc4MOmRGC6jQV+RMO9E5mQ/TZuAVvPtYEx2zc2jBGViVw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf7sngrsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 24 Feb 2024 15:13:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41OFDLY2011129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 24 Feb 2024 15:13:21 GMT
Received: from hu-kshivnan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 24 Feb 2024 07:13:20 -0800
From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
To: <quic_namajain@quicinc.com>
CC: Shivnandan Kumar <quic_kshivnan@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] cpufreq: Limit resolving a frequency to policy min/max
Date: Sat, 24 Feb 2024 20:43:00 +0530
Message-ID: <20240224151300.2243534-1-quic_kshivnan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: os5BCl-kPgFj1R_ThU9Sa5l9MtRx3Eh_
X-Proofpoint-GUID: os5BCl-kPgFj1R_ThU9Sa5l9MtRx3Eh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_10,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402240128

Resolving a frequency to an efficient one should not transgress policy->max
(which can be set for thermal reason) and policy->min. Currently there is
possibility where scaling_cur_freq can exceed scaling_max_freq when
scaling_max_freq is inefficient frequency. Add additional check to ensure
that resolving a frequency will respect policy->min/max.

Cc: <stable@vger.kernel.org>
Fixes: 1f39fa0dccff ("cpufreq: Introducing CPUFREQ_RELATION_E")
Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
--

Changes in v2:
-rename function name from cpufreq_table_index_is_in_limits to cpufreq_is_in_limits
-remove redundant outer parenthesis in return statement
-Make comment single line

--
---
 include/linux/cpufreq.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..7741244dee6e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1021,6 +1021,19 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
+static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy,
+						    int idx)
+{
+	unsigned int freq;
+
+	if (idx < 0)
+		return false;
+
+	freq = policy->freq_table[idx].frequency;
+
+	return freq == clamp_val(freq, policy->min, policy->max);
+}
+
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
 						 unsigned int relation)
@@ -1054,7 +1067,8 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 		return 0;
 	}
 
-	if (idx < 0 && efficiencies) {
+	/* Limit frequency index to honor policy->min/max */
+	if (!cpufreq_is_in_limits(policy, idx) && efficiencies) {
 		efficiencies = false;
 		goto retry;
 	}
-- 
2.25.1


