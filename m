Return-Path: <stable+bounces-262324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pnD6LrU+KGq0AwMAu9opvQ
	(envelope-from <stable+bounces-262324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:26:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C9662586
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:26:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=UjAH9Lwg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262324-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262324-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C68D30D8701
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6563B993B;
	Tue,  9 Jun 2026 16:17:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CD3B3886;
	Tue,  9 Jun 2026 16:16:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021819; cv=none; b=DJquPc3QJ08KWbRPWaTNdRj9IBsBihtXcWxXBo+ycmhURuqG3g00QWajOtLFsZBvDQYH0YfHSkQgYLj9ZZWWg8zrkItMhzkCtOFPKK280xByxULSrvm12iatW1nfCklCoIHGJ89wDTTotVaXUdTUHUQSYc0A+4/Y49Ei21tk3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021819; c=relaxed/simple;
	bh=dY9BqOIQgXtT52xAm6vTPj4OdcYmIag9O+5L/neWZ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh7RQJCX4VbI/yakugwr9RkEys9pbCe7TXmH0Z8HFpbQDa46SqEDPUGlS6+4iW0nWIZjs6IwG6nhFPFtt3J7Rj12WKwTb5m1REPS4vhXxfT00EW0AJwagy4rb1yXT8UeYKw1SzthqsSwx4rWQ9W/pdXhAghAoA717kcwnU++eM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UjAH9Lwg; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6595mDRS3414808;
	Tue, 9 Jun 2026 16:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bt99k24KmPHPCAbiL
	vMSLQb9nJlE8pReeMnnc5N9/2I=; b=UjAH9LwgsH7IEmwrzxXqpBrVYoHBnC1NM
	q2Eg+/FOfKeGT5k4Tc+GRBkIyIYQegv+nPKbY6MeEWhFNmg2Uobvr3RUdKL6JVKE
	dKWYC9wzV6mHb9YILyeLuxDYtuVOBYaoNIjjDwiHZu7iNa8RWfzPszd7sty8oDI0
	1PKVRVa2Bw3JO6WDgYl5Faphy1MkoxqWByvMlpyI6VS0sm3a5vrN0kOJI0/GbYP1
	BV1Kp4d4bkwzKI7eMNevR825lom4KEPV9BMRc3iTcIbL5ueSoe05ZP6dxHE4gb+y
	/iFgSec1SkASS2QTpSr3zc9AozVh/krNDlO+mQDLalh9WifKbN6HA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qn3kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 16:16:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659G4djP018068;
	Tue, 9 Jun 2026 16:16:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g2m1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 16:16:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659GGoVu47579476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 16:16:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E9FA20040;
	Tue,  9 Jun 2026 16:16:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2C8F2004B;
	Tue,  9 Jun 2026 16:16:48 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.28.58])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 16:16:48 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 1/3] KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
Date: Tue,  9 Jun 2026 18:16:44 +0200
Message-ID: <20260609161646.695361-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609161646.695361-1-imbrenda@linux.ibm.com>
References: <20260609161646.695361-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a283c79 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=nU2LGVZeCOZSiWKovJUA:9
X-Proofpoint-GUID: E0H27-HAQDMn6uiUz_EteEW8c9p9lziE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1MyBTYWx0ZWRfX3oOLZshL8nkh
 1m9/Irn9ZM5LjlNquHGjpb1gaXjZdEvITsYfS+hX0f/XRkGaWZ+CJEUwpMpX7ttYxZE29EZEIca
 KiUgrvi9FiMCAS3J3aWBLhiTnyaqYg3ALWFr0mJJUV1MGBtYvDI4gZJhMhpAkF0OAnwZ4q98UF4
 kY6LT+IMyZqRTaqjSrzIEX86RfJ1YKqQ3YlIR/zJp0U5+ddTtdn6b72oeNo747e1ATEoI88oH+k
 cjU/KIC0J0MmSyJBT89AbMfA7jhFJ9GXR5/s0XkrrTcJET1LIWBPZxPm3IsMfq47dRQ5nYfZf0V
 rc8yuX3i/kQ/UpNGx0FGGjMk1myLFDjJKc1EM3av7yJRla/wOCl0VrMvg1vIlnTBls5018jMPCm
 zz/QhRldTW47xznH9w3PuwquTKAsZHhh2IYHWTg0p0RoZ9zc85y7F/Zz08TgPKC9eKFXaZnyheq
 sYQTaj6YZT2Ye10490Q==
X-Proofpoint-ORIG-GUID: E0H27-HAQDMn6uiUz_EteEW8c9p9lziE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090153
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262324-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B5C9662586

While dat_crstep_xchg_atomic() is marked as __must_check, in this
particular case the return value should be ignored.

Add an explicit (void) cast to silence potential compiler warnings, and
a comment to explain why it is ok to do so.

Fixes: d1adc098ce08 ("KVM: s390: Fix _gmap_crstep_xchg_atomic()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/kvm/gmap.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 5374f21aaf8d..4e6979783e16 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -279,7 +279,11 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
-		dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
+		/*
+		 * Ignore the result, it's just a best effort clearing of the
+		 * vsie_notif bit. The caller will have to try again regardless.
+		 */
+		(void)dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
 		return false;
 	}
 	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
-- 
2.54.0


