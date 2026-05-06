Return-Path: <stable+bounces-244371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDjXK54s+2mrXAMAu9opvQ
	(envelope-from <stable+bounces-244371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:57:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF354D9E74
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C30AC300AB21
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5543CEE7;
	Wed,  6 May 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="es7gRqPv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LAaJQpp5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E2423A82
	for <stable@vger.kernel.org>; Wed,  6 May 2026 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068633; cv=none; b=nawKPENfhNw9b3wEQY0gaDmCPyAzXVvytL4MR6BgmwClwqvMNh7ACdvToDrvxk/5PNRMuYlyJEerwBAOw5CMYBO2AdofmxTQdzJvQ+jdMFrBVbj+wvIWKeim+9dsSaHTJWIodJFdtMZyLBkZP868tquQmRXXnHMfrj1ETH+NUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068633; c=relaxed/simple;
	bh=87NP7XwywOn9x/iXWB+eXS5eWuDkx8j+CF4L7FZPusM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcMyAMuFqp2B/H1Gigzfcy4pRyfaUNJk8MOFmHaayiHxc8OQFOpvJ+2KjC1+rMEJadI5Y7krpmnHGSqKPUxuUcv+Ygdy+9hdvmurPYVi0BlrpmAxqgh7NpmWyM51YqJSNfLGtNG5p+YIvFEXoXiMoSpvQFDRvK01BJyiL0AuKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=es7gRqPv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LAaJQpp5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BQHol2581357
	for <stable@vger.kernel.org>; Wed, 6 May 2026 11:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Odr8obAqI6YzuQA1Xf0eZUfZcXB+THZa+6j
	Hl6jpP9g=; b=es7gRqPvfcWjkrWR2L584axIUuruZrtV6MWjOIfz7Lh1qSod49p
	Oy8XigTxcm9eNpkWcayHLBAGl0VvVqQhYUX+SAh5f6n1w6RBEaEAo83Xz/Hv7Du9
	6VYjwznv6cbl85IlV5FtzNpAORbLU2D5fShggV9A7NJSBQG78P/4evOrheeLY16/
	zXNVzW1+4+M90DyGoFSd5J6MZJFsKQq+Arruncd7eXWyloeYem9HlCXF9iXelcZs
	w/eEXlA7LzMN1Gh02d605dI+kI1YO4/cQ2Fhpn7o6dRaV2qyU4zWmPdQI/XppJX7
	zekoMJJwlhQya9WcC2w3j4dbsIiuETzuaOg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyyvw1byq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 06 May 2026 11:57:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8bc140520c7so27475826d6.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778068631; x=1778673431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Odr8obAqI6YzuQA1Xf0eZUfZcXB+THZa+6jHl6jpP9g=;
        b=LAaJQpp5SExFXdKFbSqZlBYkrRZ00hUU2Ua5ZpcHT3TWlKkeeqTd8MANgnsm/WU2/f
         jeSgCWn4jN4C+Zfjlxhfpc7cxRh78OZjHlZKB5bDq11YQy1q3ill4AUpDvnrkx1S237s
         4NLrlZmR2qDdUl/Z3vCxdF0u6JxnN6j7tsqjelf+jOlw+/6p2SsVeU4NCy2O9uAKKnci
         J5OPmezin6uT/L7xyDKlF0090aTWOTWVgXKo4fg1i9VYZ4pMttiPTHz+qPIDnyABIUH2
         PPmsyljpn+KURkpbm/MIjwzpT/BVHQBNr9xc2YBLdDz1o7H54b3eP9aSEBk+W4pYRQtN
         I+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778068631; x=1778673431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odr8obAqI6YzuQA1Xf0eZUfZcXB+THZa+6jHl6jpP9g=;
        b=IsK1SM+uvTQGdxqv6jaoPWCCmhrJfhgn54Gw/6YMvsuG7QPIayGnKnepy/bO2G4hFP
         NnYOJv1K4UX/o3JIXuNcvbsG+gXyV2AXy9XbBIkkRyABgoYvanS4Lguyw1s20s5WGLhn
         K7e1KLY7yrDgJJfkMtLVdj8m3NqEAbnQp5kWJP6Sf8SCVCuZBbzDIKoWqlq0Ig/fegPk
         8CLnuEuObvXhVbLoGJJIg8U3SqwNj+xVIZJEF29urfDkNz83RRHxcbMzcS8bEanS151a
         wHPV9rs/UUltx7mOqHY/UKqJCY/52ulK8cpEGqrRxTbvx7+ZtNuEiXAa3388htpOmXHk
         TtAw==
X-Forwarded-Encrypted: i=1; AFNElJ/roNezW8YYG8wIfMhFrhbVVsHcUrS9TW/CWq7T0vL8+uYxNTjpTqyh24EbIANMQdmdnWDEY+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEzGfry+75BxLF6mds+Xp0n01YbJHSLz6smmIsgNaCfPIBZNK
	i8kXr+Beqv5DPKfJNODNI0awD9vtpURJ0BW5+UdQG0s97xte06Lg5V/ruZOjgvxqADPovoSncZJ
	Yu7uWfzq4rFAinBeZD+7tFJgW4OptInSarcdWh34NOlXUabLkisiAGkSX/Dg=
X-Gm-Gg: AeBDietFdIqdkqVTQC5j7k1vKqV3+yJDFM2RZ/iRZvobJp9kYxldMVoSWhkDmr8KhTP
	5jarm8DxIdcGqX7pH54ZjwVPIthH/EpwEOdhAlInmUTGDtvvN0mEETaxaGKB+KctgW5n2vvEzq1
	p28KrAh1jLlSMCiOlWnoRvI1eZc87Ei9BORto/p8jtV/XEcYKEJLWX2l9vUG2QVClqar9ajsbJr
	ValdTtCJf3YDycBYtJ1q1s48jDZtVXZMCdKQbblp6IqdpUipaYPgDfML5sOlVYJ4wMWA+fXq1J9
	RhrxYjzjBT40eDt6WI/O0zFmzAUBcubxZHlNkqqYQFyc8+ewjLJz/icvXmFT5U+a5YKTkh56FyI
	gzKdotMNwpEZyGORpJijSKPCGY0WA2kInI62h1peRd/zdhnN0HPQi5EeJyrzI
X-Received: by 2002:a05:622a:608c:b0:50e:60b7:bb40 with SMTP id d75a77b69052e-51461157e8emr44080241cf.0.1778068631064;
        Wed, 06 May 2026 04:57:11 -0700 (PDT)
X-Received: by 2002:a05:622a:608c:b0:50e:60b7:bb40 with SMTP id d75a77b69052e-51461157e8emr44079861cf.0.1778068630631;
        Wed, 06 May 2026 04:57:10 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:ebfc:d4d5:c415:532a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm11651522f8f.0.2026.05.06.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:57:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>
Cc: driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] device property: set fwnode->secondary to NULL in fwnode_init()
Date: Wed,  6 May 2026 13:57:00 +0200
Message-ID: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YYCNIQRf c=1 sm=1 tr=0 ts=69fb2c98 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=oySY2n27BtFPXPS6EewA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExNSBTYWx0ZWRfXwKg0Ylxqx4VZ
 JWsb1v53VaDLpcA5ISagC2yVJPhRoyrucpTTYkGvZ9/EjCSPkdIgmKWEtIVR5Q0T4/K3jwiTHZB
 qpPZWszCuA5xc7fQTN46PsN0QPH85DDa3Lx1F9RJ2eV4R+AUqjm34r9MuCP1RlH9XHOcaDmhmA6
 5RSXATNG4xf4kobmWttMBhsbbOt9peJdR6fvB8IOjXKtLpWK+01LbmbUPbv/qoDT/dfCJd9XhGv
 icwL1+cYMT0Ux6nlpvWBZTqA2v6N+lGCLKD3k4FxnpxefMawRke3VA/1VI5DWKIqJTpPHc2b2Qx
 n+LgMuq7Iu0gUOV4R6T3gTiW5/gY25OELt/bq0XGzDg45ee0LpB9NL3sPqyHvIGTtIk29dGHJKw
 X8d/oR4Nn3B70VFOrQNMfBrjk5vpMt7ezwaBH6i7bMzlxl98aRWXck1LfCIV1jgxdw4OXe1Ubzb
 bHCmPYaewpg6/rAzF2w==
X-Proofpoint-ORIG-GUID: jWankLz3dft3KkG2h9MAjP60HF_-E1OP
X-Proofpoint-GUID: jWankLz3dft3KkG2h9MAjP60HF_-E1OP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060115
X-Rspamd-Queue-Id: 1CF354D9E74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-244371-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,linux.intel.com,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

If a firmware node is allocated on the stack (for instance: temporary
software node whose life-time we control) or on the heap - but using a
non-zeroing allocation function - and initialized using fwnode_init(),
its secondary pointer will contain uninitalized memory which likely will
be neither NULL nor IS_ERR() and so may end up being dereferenced (for
example: in dev_to_swnode()). Set fwnode->secondary to NULL on
initialization.

Cc: stable@vger.kernel.org
Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/fwnode.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 80b38fbf2121..31df7608737e 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -208,6 +208,7 @@ struct fwnode_operations {
 static inline void fwnode_init(struct fwnode_handle *fwnode,
 			       const struct fwnode_operations *ops)
 {
+	fwnode->secondary = NULL;
 	fwnode->ops = ops;
 	INIT_LIST_HEAD(&fwnode->consumers);
 	INIT_LIST_HEAD(&fwnode->suppliers);
-- 
2.47.3


