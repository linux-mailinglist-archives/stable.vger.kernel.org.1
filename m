Return-Path: <stable+bounces-262544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6kR5H9WaKWolagMAu9opvQ
	(envelope-from <stable+bounces-262544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 19:11:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F04466BE36
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 19:11:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=jtr1+vKQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262544-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262544-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9164930ABEFC
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7534034D93B;
	Wed, 10 Jun 2026 16:52:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F503446CE;
	Wed, 10 Jun 2026 16:52:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110379; cv=none; b=Xyt3GrUkFLbK65rGPoO+vVxxqJ1youqyixq4QeSRU6YrlmrhxNuMtNXxB8xO0/Hvl3UsnepldhquEyIaqmKZNXbnBZh+/pvK1agTeC3f+Hb7D+A8l4GP7rErFA3Ga8vCKQHnzP+U912Vqq5/cTfW/GhfM6dSPfiOBVgEH4jKqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110379; c=relaxed/simple;
	bh=R0gc/SheEhuVtImxEsZPPhcLcul9kiH3HSHcFbhq0pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiySvTph+kU613iyGkMmvKMrn3Z5Npe6WioE277HpqjtHzh9XJY+CTFlkZEv91mGk16yElaSTsqdqHSZh8/zwr2KrRnbPwLeIxu8b7NAVNIM56//vTcM3on0zrOd+z+oPL4sNb/0FY7nR0w4z/hD7tU7/OtESDrD5MbpkCOuqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jtr1+vKQ; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AAmN4U3821146;
	Wed, 10 Jun 2026 16:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IHHWxU5354xgoQgsL
	CUsaUc07XbUi7gCJo+yCes0dWo=; b=jtr1+vKQbOKbrKFeQVlGV27YxcVMCSVC4
	em3HWtPW/bdL0VaPG5AGGbttJ7+zJYAMRjWOLNjColaoryCMeV3KV/nVfBH7mFh1
	83kIIjOs8s/n0PSlm9QnLeMsdTbxR184Uw2hb76hH9aDwVG283y6o6yVIpLRravh
	oTgmDP5bHBiK2Tc/lOxXA/xfqbscBkzvc34741YWFDbyHPEtjhlAHN0hee3G4jWA
	6WSiwdc4A78zIqS2/hbSFTiLb/GAolslkxUcSLHn0xbHq34uXdATNkW0YwcYP4gJ
	SWrz1c8b/U2+bE7FXjAgYga5814fWwr5S3VGxI//EvN3TUWNDRmFQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qt4gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AGnmM0010873;
	Wed, 10 Jun 2026 16:52:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq7pe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AGqmRX27263312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 16:52:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72B7720040;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AFD12004F;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 4/5] KVM: s390: vsie: Add missing radix_tree_preload() in _gaccess_shadow_fault()
Date: Wed, 10 Jun 2026 18:52:46 +0200
Message-ID: <20260610165247.238366-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165247.238366-1-imbrenda@linux.ibm.com>
References: <20260610165247.238366-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a299666 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=5WtQGhaX4H0GvqE0kYQA:9
X-Proofpoint-GUID: o5KNSC1hRgppjCyKnnedZxHSSIk6Tfy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfX0F9rTgTAhXVQ
 ArU6Lww8BI8RT3pr+gqZQqJUvfmiKFFvlKZc7sE0f1o5bYxZoX/Rsp+tNkBNqcZKhyxOr89Wqfk
 wd/VP26+a0bUyC0WeBzFP5DENALKSTemUoDqUkI8RYpvmPmzSgp/qry/zwoJoCWkGhpG7OLP96g
 stKahPTuW9WSqkB/04t7UVJClIH9B7/D3wYxcz1+8dUkaUYVXKRgEaL1XUM6A8XQm2+BpGmeQW5
 mKoB91bH91VHG3AaUzlmnVHgFWxG1A951xgp1H6Lju09kaAd//McBrxmtNqUuWuV5+YhL3u8zrE
 SzYjWCjn+uLj/z94UmiKlBqOc30wD3lZgTQ5f8y7dMNFqx/n9hNoyzu1E4d5WMX0Ux7bIpkiWtZ
 OJsfFdy72fkqmmRQj5Xyrux32DKD27u6CyhKDeu8y0cPdH48iqd4Lz19rBUN8jp3aJN1L0pXsgf
 uTs2fwfgT/x90CGLrJw==
X-Proofpoint-ORIG-GUID: o5KNSC1hRgppjCyKnnedZxHSSIk6Tfy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100156
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262544-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F04466BE36

Add missing radix_tree_preload() in _gaccess_shadow_fault() to
guarantee forward progress. The core of _gaccess_shadow_fault() has
been split into ___gaccess_shadow_fault() in order to simplify locking.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/kvm/gaccess.c | 49 +++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 20e28b183c1a..c072b6872bf8 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1582,35 +1582,46 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	return _do_shadow_crste(sg, saddr, host, table, entries + LEVEL_MEM, w->p);
 }
 
+static inline int ___gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg, gpa_t saddr,
+					  unsigned long seq, struct pgtwalk *walk)
+{
+	struct gmap *parent;
+	int rc;
+
+	if (kvm_s390_array_needs_retry_safe(vcpu->kvm, seq, walk->raw_entries))
+		return -EAGAIN;
+	parent = READ_ONCE(sg->parent);
+	if (!parent)
+		return -EAGAIN;
+	scoped_guard(spinlock, &parent->children_lock) {
+		if (READ_ONCE(sg->parent) != parent)
+			return -EAGAIN;
+		sg->invalidated = false;
+		rc = _gaccess_do_shadow(vcpu->arch.mc, sg, saddr, walk);
+	}
+	if (!rc)
+		kvm_s390_release_faultin_array(vcpu->kvm, walk->raw_entries, false);
+	return rc;
+}
+
 static inline int _gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg, gpa_t saddr,
 					unsigned long seq, struct pgtwalk *walk)
 {
-	struct gmap *parent;
 	int rc;
 
 	if (kvm_s390_array_needs_retry_unsafe(vcpu->kvm, seq, walk->raw_entries))
 		return -EAGAIN;
-again:
 	rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
 	if (rc)
 		return rc;
-	scoped_guard(read_lock, &vcpu->kvm->mmu_lock) {
-		if (kvm_s390_array_needs_retry_safe(vcpu->kvm, seq, walk->raw_entries))
-			return -EAGAIN;
-		parent = READ_ONCE(sg->parent);
-		if (!parent)
-			return -EAGAIN;
-		scoped_guard(spinlock, &parent->children_lock) {
-			if (READ_ONCE(sg->parent) != parent)
-				return -EAGAIN;
-			sg->invalidated = false;
-			rc = _gaccess_do_shadow(vcpu->arch.mc, sg, saddr, walk);
-		}
-		if (rc == -ENOMEM)
-			goto again;
-		if (!rc)
-			kvm_s390_release_faultin_array(vcpu->kvm, walk->raw_entries, false);
-	}
+
+	do {
+		radix_tree_preload(GFP_KERNEL);
+		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
+			rc = ___gaccess_shadow_fault(vcpu, sg, saddr, seq, walk);
+		radix_tree_preload_end();
+	} while (rc == -ENOMEM);
+
 	return rc;
 }
 
-- 
2.54.0


