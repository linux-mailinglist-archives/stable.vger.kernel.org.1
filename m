Return-Path: <stable+bounces-90411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68459BE825
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048101C23277
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337BE1DF75C;
	Wed,  6 Nov 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBOH318Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F761DF73C;
	Wed,  6 Nov 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895692; cv=none; b=qm7N55IP9Z7Op4dv/bN4rGZVpjo+Ej5sWlBYXu7NHdhdptzAIK1I9Pu6EYIGr8z4bRMkKVe/QVehY3x2diH4uhjaGtS23oyvFt3iM6J2qvYQ2bibMDEIwkFu2tCjVhaomZp8n8MUv0E1Svyo4svDY0mg9IZleLFFmE32pF03vlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895692; c=relaxed/simple;
	bh=ZaFDuHmYEwd5jlZKm+vb3396+ZreoqV/nnnulB27xlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU5SL6ga0dd78KDVo2gnsUuGxL5j5Lsrj50ZZeJvJiIMYk0IhFX0ym4mhKbz5OxPBoNIyufmfL1x/gPAguXvzVlFVkvlmTgcAXrl8vFrX3Ob1nMYoLl77Q68igqUBvSza2Y0TB9hxXQGiBIRtZecfgg09dHhOYgmEpgWxB4rPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TBOH318Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B98EC4CECD;
	Wed,  6 Nov 2024 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895691;
	bh=ZaFDuHmYEwd5jlZKm+vb3396+ZreoqV/nnnulB27xlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBOH318Q3gJLTNEn+EXwZxhN39xmIotmPR069eVfhcaF/dXZgTyt2uwLyWBBbBo0V
	 pMtCpmFVj9CBvrEankvA4mVQYnbW16O9jkVz4wUCCmyylJYVQFByGs4UcC6hcMtw4o
	 /slz3K6FsKUPtUBpsrc39ZfCsqUjUtaesrxCTJAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 304/350] KVM: s390: gaccess: Refactor gpa and length calculation
Date: Wed,  6 Nov 2024 13:03:52 +0100
Message-ID: <20241106120328.301262657@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janis Schoetterl-Glausch <scgl@linux.ibm.com>

[ Upstream commit 416e7f0c9d613bf84e182eba9547ae8f9f5bfa4c ]

Improve readability by renaming the length variable and
not calculating the offset manually.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <20211126164549.7046-2-scgl@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Stable-dep-of: e8061f06185b ("KVM: s390: gaccess: Check if guest address is in memslot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/gaccess.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 07d30ffcfa412..b184749ffc5ae 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -831,8 +831,9 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 		 unsigned long len, enum gacc_mode mode)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	unsigned long _len, nr_pages, gpa, idx;
+	unsigned long nr_pages, gpa, idx;
 	unsigned long pages_array[2];
+	unsigned int fragment_len;
 	unsigned long *pages;
 	int need_ipte_lock;
 	union asce asce;
@@ -855,15 +856,15 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 		ipte_lock(vcpu);
 	rc = guest_page_range(vcpu, ga, ar, pages, nr_pages, asce, mode);
 	for (idx = 0; idx < nr_pages && !rc; idx++) {
-		gpa = *(pages + idx) + (ga & ~PAGE_MASK);
-		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
+		gpa = pages[idx] + offset_in_page(ga);
+		fragment_len = min(PAGE_SIZE - offset_in_page(gpa), len);
 		if (mode == GACC_STORE)
-			rc = kvm_write_guest(vcpu->kvm, gpa, data, _len);
+			rc = kvm_write_guest(vcpu->kvm, gpa, data, fragment_len);
 		else
-			rc = kvm_read_guest(vcpu->kvm, gpa, data, _len);
-		len -= _len;
-		ga += _len;
-		data += _len;
+			rc = kvm_read_guest(vcpu->kvm, gpa, data, fragment_len);
+		len -= fragment_len;
+		ga += fragment_len;
+		data += fragment_len;
 	}
 	if (need_ipte_lock)
 		ipte_unlock(vcpu);
@@ -875,19 +876,20 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 		      void *data, unsigned long len, enum gacc_mode mode)
 {
-	unsigned long _len, gpa;
+	unsigned int fragment_len;
+	unsigned long gpa;
 	int rc = 0;
 
 	while (len && !rc) {
 		gpa = kvm_s390_real_to_abs(vcpu, gra);
-		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
+		fragment_len = min(PAGE_SIZE - offset_in_page(gpa), len);
 		if (mode)
-			rc = write_guest_abs(vcpu, gpa, data, _len);
+			rc = write_guest_abs(vcpu, gpa, data, fragment_len);
 		else
-			rc = read_guest_abs(vcpu, gpa, data, _len);
-		len -= _len;
-		gra += _len;
-		data += _len;
+			rc = read_guest_abs(vcpu, gpa, data, fragment_len);
+		len -= fragment_len;
+		gra += fragment_len;
+		data += fragment_len;
 	}
 	return rc;
 }
-- 
2.43.0




