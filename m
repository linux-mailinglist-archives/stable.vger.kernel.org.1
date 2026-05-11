Return-Path: <stable+bounces-245148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL0kJoiNAWpyeAEAu9opvQ
	(envelope-from <stable+bounces-245148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:04:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BEA509C61
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FA9730A5E6D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738F3A8730;
	Mon, 11 May 2026 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R84is9rq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KAq3i4lL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0583A7F5E
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485793; cv=none; b=G/SUXC7n//YrzPdOuz40gsXbSXl+6laYLfGaq5EpWo7QXlfcKk/Utk0queCB5/IDWPvfmiYa69hY8+TSAidKYf8apUmjGBrEWpnSh+EDeX0Dk52MGLVnJdux9V/g2a5DWtZPtfIyF6Q6WT2rMeduPsY6I+AhfMrod5+A/8Yx8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485793; c=relaxed/simple;
	bh=dfcYwkyuDNYynj44TLY/xzDAGhF6slaoqu29/jCOjLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDLfw4/i5/VZVjONnZ+CGB1lnW2rJhzHvY6WQ+UBPF5TwgaZEdly+nSQznfT2sjUbS4KTExQN+0vi1WzuS3YCFctXJ2hI1H9sjxVGxNrnicLX/WDFBZiagIBVnmreKrLu03tBVZVTgLrMyqFTBSq3MnesWkjcjmIBOmX8xKfS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R84is9rq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KAq3i4lL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B4bPeL1805990
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zD0OZ3vl1Z6/q5f1uoJsnOx26bZdUEuAO+g
	pWzawFUc=; b=R84is9rqwSI5OH3TizEVkUFTdeHN+ftcMSJX/hfgCHCf+nfc0JC
	O0KRYqwiUFypzewXzD2GMob62VE+Ndg9lefuFwqwAxpbDC2j1dolRfUkzYcb7Yge
	L6f+TdG8GILv8mWAO7bYISRygcdFIhkOIzvafVewdzQPd3k+rkIeLo/ed+6xdj8N
	tl8oeTBgyByJUWZ3rVJsVzGHvnQJUoc8LAWUd5ayq2cUmlk+Tkhjs83EcXiPwLB9
	uYB5qOZvkMmLps9lmCl39l1t2wb50SZwHPsE9sa7FH9C9BFu95sdq6kzYOheHF5b
	/+zrYYmBg3w2cwXTa1w8HYxwfcjdsBwJEqA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e2dksu7j0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:49:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8acb0aa51c6so22211736d6.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778485771; x=1779090571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zD0OZ3vl1Z6/q5f1uoJsnOx26bZdUEuAO+gpWzawFUc=;
        b=KAq3i4lLtAwqckL+dOLezbhEoR42dOK3EPl2BdjWVY8CZV3LJEGqq+MmKDO9atlmwA
         U22hn8o9mI9RsIiSYjAYR4AfPI4WkMshDDsSMcoMffi9F9kZR5NzSSLlWw6AcQDzCaRj
         T8V4ICBaj3pnxKt6cxFFw7B3KMffxk4XMmZjfaK2zZ1y3NyCBZkgD1e/zu0g+rzd2kA3
         QcqGLRkirX6sUq1ZOd4JxTkWnJKqUjCQzHL+4b43LG6/fI2K2jcVHEYeYInxUV8kzhh7
         m5k2drZbt+sgc2MUHaP/y6+gRi4rv6PKsmwMF+DQDL0fLkrBB2UspcDnz2H34acMra48
         /qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485771; x=1779090571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD0OZ3vl1Z6/q5f1uoJsnOx26bZdUEuAO+gpWzawFUc=;
        b=hGIU9TDTBVQP6ThsZsxYHlHtl7aaTJMaGgCemES8M7QFteTbCXvqe9ItyXjncJwje9
         5OyzITI8ovvKBCuE6U2RJItdQp0DE8//moeCBsB/Vzfasuq0Qjy8oV+MXteGh91SXeLW
         5lkyfaE1Heotag4UULF57bz/kfK5jS3KHl+zkESB4v+x0W8BSvyNJ5jYBHb4Y68Cy1aS
         5aTr0Oj7ydMnn/6vfEt9QJf+HVsetfxDKsJxdrLQB1EQ43PBmNLlx/RDmmb+BWxTd2YA
         VBeuA3qZnZaRHfCwIzSrF1qZZN1UAAzxU5cHwRRFPXTqldD3pu84Dq7cSsC6oe0AiqTi
         TcBw==
X-Forwarded-Encrypted: i=1; AFNElJ/CfzMoWX5O4NRLnWcLulSATTor1o1b4lTGuRvBMTLZVl2bucPnrqUUdtxl3Mwn+eUM0OlsMjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyejYt5NTuJ0WSYTFTQDWZAssb5XEAQvX/ti0dmzyIWD8Bef3MX
	3LRkKsFetqrFBsxh45MH75FsBl4h0dHU9js0lqRtwG+tBv51mdpdRvzUvxAE5S9A4fOUA/fIa3I
	7JUEbGL/e3NQ0pKKywPTUn86gCJygLjVa9ERVjfsUYSoh1JZe00Ek59dbTf4=
X-Gm-Gg: Acq92OHwbIZptLHD+aeMVZf7Mm1H4uJ384O4E2i79R3wGI0CUstoIoX2gyhcji0ZHyu
	reKOp0EPAzOoyWBArjl9Q/hinuS6yIWkK3HzQMTuGKriwn6AWgq9Hbp09XCC4IzbSXSFYySXazW
	qakHklYemEXQDeccP5u6fzBkkjIDmDO4MOuhTnEyo/4OKcV3QJn3NiAmO5FncMYcHJFepwAPwYH
	6s5gi6PDJuFu9U27YEaMnF8v9gD5NvbEeLY5YcR6JQMm+y4Fezixwuw6yPlDOjPBwI5YwrENbFd
	RDiukT+7mwT2NjMjODm+brSRchMmSf0/mKrw7Qca0pa1WFsgpIPweewKdU2vmlV7N4vpSP5Ls/J
	ko+/ekRBTnTFFGRscRyPt40IhOyunilDWFQaq1VPjLHOFffBVeUVGBdmtHO8J
X-Received: by 2002:a05:6214:2386:b0:89a:1c81:65a6 with SMTP id 6a1803df08f44-8bdb9b59b8emr211043346d6.17.1778485771478;
        Mon, 11 May 2026 00:49:31 -0700 (PDT)
X-Received: by 2002:a05:6214:2386:b0:89a:1c81:65a6 with SMTP id 6a1803df08f44-8bdb9b59b8emr211043146d6.17.1778485771059;
        Mon, 11 May 2026 00:49:31 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702ec51fsm147605045e9.12.2026.05.11.00.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:49:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Saravana Kannan <saravanak@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] device property: initialize the remaining fields of fwnode_handle in fwnode_init()
Date: Mon, 11 May 2026 09:49:26 +0200
Message-ID: <20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5-duDzhB-Ml1-d34W4uSqFSYswL61PP_
X-Authority-Analysis: v=2.4 cv=d93FDxjE c=1 sm=1 tr=0 ts=6a018a0c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=VQTjnhxCuS3Q28dGhDUA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 5-duDzhB-Ml1-d34W4uSqFSYswL61PP_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4MyBTYWx0ZWRfX3JX0E1d/faz3
 PkPajM3Pi1+Q1Acg+o8/iLh+6ZVbyLPH+tV0WCX/ey/qP9+TOf7Zgmy/cqVX/6ib7hh3tSRY8qh
 a1W+1Xny2Mj81AzQalr2cIkmm2Z+XB2zIEKTCnHVr027XWtHmPXniPKDvAtkt2lo19OVIe8KqRK
 Hje3LYh8KKoTaPV85qA5JSvKp8i3nZ9RzXUdancOGOXhL0TCnJHmeKdHe9WTpFrcA4HOmTPUk8O
 VOzhK63xugvBjQ/SrT1NQkVX5ewh9YxpbzZlZuNCJYxvPAKWQFMh4erZ7w2IzN9fFv5d+gO3c/R
 sVhLUICBMecAoyeTwpCE62IajBL8T3RgQfMvH7Mi3VNhQsiF4ug+nJsSBJOMA63VrhWuQnQzvTT
 4p7T+PxRPDqys06X3zIKC0TXiv7oqtoyN0C73Hm+yI8OphrS49+YQTtt/U4hVYrEqPe2ADE2hUZ
 8SC9JpD4B0K8coInoTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110083
X-Rspamd-Queue-Id: 26BEA509C61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-245148-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,linux.intel.com,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

If a firmware node is allocated on the stack (for instance: temporary
software node whose life-time we control) or on the heap - but using a
non-zeroing allocation function - and initialized using fwnode_init(),
its secondary pointer will contain uninitalized memory which likely will
be neither NULL nor IS_ERR() and so may end up being dereferenced (for
example: in dev_to_swnode()). Set fwnode->secondary to NULL on
initialization. While at it: initialize the remaining fields of struct
fwnode_handle too just to be sure.

Cc: stable@vger.kernel.org
Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- initialize all remaining fields in struct fwnode_handle too

 include/linux/fwnode.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 80b38fbf2121..c30a9baafc0d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -208,9 +208,12 @@ struct fwnode_operations {
 static inline void fwnode_init(struct fwnode_handle *fwnode,
 			       const struct fwnode_operations *ops)
 {
+	fwnode->secondary = NULL;
 	fwnode->ops = ops;
+	fwnode->dev = NULL;
 	INIT_LIST_HEAD(&fwnode->consumers);
 	INIT_LIST_HEAD(&fwnode->suppliers);
+	fwnode->flags = 0;
 }
 
 static inline void fwnode_set_flag(struct fwnode_handle *fwnode,
-- 
2.47.3


