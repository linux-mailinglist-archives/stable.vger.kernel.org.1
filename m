Return-Path: <stable+bounces-241234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IkVEGwJ72n14QAAu9opvQ
	(envelope-from <stable+bounces-241234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:59:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B03EE46DF48
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E7E301CA6D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B777A38758F;
	Mon, 27 Apr 2026 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JlWc8yUy"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561D386C18;
	Mon, 27 Apr 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272969; cv=none; b=u3gdyKcZZOqgXBLt89uwGUK7iHxwsd2RJamSY4FAmG3v1i0Bgt2j4AHKRx86MpvhlrZ4ToY4ugAGC0jU2q2PyzttIWvrs3SWIMKICnxe0GvNs7OtyEjwXkMUqm9G34/chLgi3aqE10brDUO1Haqb4gEOhkV4AxbNHPLx5dx+8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272969; c=relaxed/simple;
	bh=LRD7oLtudIamBREpgjy5kneg6OcHg91ArzImy3XTXnA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=uaoZmZBQmUli3tid7828l2mnbzydpH6VWCynk1TzCt3kmKvA2qn0VjStrS1LGHjGyWLgQiyBD7FObogxiJZbo9umFUIhlygcJwr7b9jNS7OFq4BVseCw8pLBWCTU4f9faITShR5BkDOEFX+LTYnnGILXnPld+qc3/kqED4SSHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JlWc8yUy; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777272963; bh=7eoDS3JbR1q53aB5qfXy+6cxeaSinsD0OmwzLxXmZTs=;
	h=From:To:Cc:Subject:Date;
	b=JlWc8yUy/t/dJWTi58I1npU/UjzvASPJfF7QnlcEmvq8Bn8Ijk7tFTdxh/h5XRH6X
	 BJ78VntXfZTyHEujee6XHX/19wfs0onomvv9nGte1+JMAKKgTpy5UDulQ6lY5YYN9t
	 3TbTvSpiBS0J18JuV7aL9wT54w2MDUcG4U9SeE/Y=
Received: from NTT-kernel-dev ([60.247.85.88])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id CFA1B0D6; Mon, 27 Apr 2026 14:51:58 +0800
X-QQ-mid: xmsmtpt1777272718taqvoj5v5
Message-ID: <tencent_7000919DF2E0E898B39B6394B77AFCBA6307@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJqcnwnva7b1H+V1NghqGV6lPV+Y5erHH8XEnlKKbfjNUiiPjfx5
	 49fNKR9ub66m2W47d7c6kChayWE933hZaniYHIjkDuDi4dByW5eQXBCD7DF7fdUpL6oy0zCc9gGZ
	 bOJBCNtdVj6O9DZG0o6U9aGCt4NvcLk9JOJ8MF3yYD7nWpwYxEVCtqoG4eFSYVGPaDlv+KGxht9g
	 F/sZvMcvp/o1A4wHmlewTiLXUJz5RXbetM68kSyStyhlLPO5HpbBLivp0PfRnu4giUjDDw44D9FT
	 PAaVv/eC3+TKYH6FyzLW7qQKB909bif66wySFecXFkcB1UXvNZG3DAeOCc1vzuqtd637ezdZTeN+
	 hJ1DEVAXBn1tkT3OuH9wfDN5o5ljcL4/FSwl1BhgzmrsuVVY1HxqHlDvbUTwp+FfAbh+GdZ8jvCK
	 cxiM/PIJDMK4u8nwPSkLtEa3nCkQxco4VoEW8KMYtOjKEeAAk+DSmbJ3B+Wc/DLrwld2uO5KaHSv
	 nzAjbo8nOEJgHRw0zklMUNh0scRZmMytZuvYMtldOjFjmnoe2dvKrnvqlzMPDlii86bsjr7HmYmf
	 /XXTFABrX0XzWCcbPm2K7i/q/rC0sOW+0qBz4eqUM5kx23vNJmoB7oG8GAVrSPMEmivNzgvifq35
	 3VnFpzJ74BqaHdL5eTqrLnIQqN6kuDdjkGA0Jg0lGljrhevM+Di/J6Bq1Qt4cf2XpFq1e7baIu9r
	 5vCTlCGIzE89h6YsZEqsuU3TFrtowuGMyszgUz40jEZ43Ep9vEY7dBxg1hscJRIx+0RSyA+L9026
	 RiLBsQ+BzPJf+2k+4UfHlxUIh/TlgAahcqU0VvBck2sEcaxwr+oeFKCjtzs/ch6p5C9avZM1I2LF
	 O0RTdBeVnm01LDGd/T2wZ1O1Q/8MWsWI9spFc4UBYZFb+7sIkrc+x0bxNu2Rx3Bb52CcHLD3KluJ
	 Fh0BFztB7/YS9dOF1VjYksBGO+5tRmb+PFEPzseJCCucVBVmEXWYXuGP7C6pNTxYSzf+4zHlSLbK
	 qDrgZGwDgPHsyIib/S
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Fang Wang <32840572@qq.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	tvrtko.ursulin@igalia.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Jesse.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 6.12.y 2/2] drm/amdgpu: Limit BO list entry count to prevent resource exhaustion
Date: Mon, 27 Apr 2026 14:51:57 +0800
X-OQ-MSGID: <20260427065157.4118642-1-32840572@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B03EE46DF48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241234-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[32840572@qq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:dkim,qq.com:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

[ Upstream commit 6270b1a5dab94665d7adce3dc78bc9066ed28bdd ]

Userspace can pass an arbitrary number of BO list entries via the
bo_number field. Although the previous multiplication overflow check
prevents out-of-bounds allocation, a large number of entries could still
cause excessive memory allocation (up to potentially gigabytes) and
unnecessarily long list processing times.

Introduce a hard limit of 128k entries per BO list, which is more than
sufficient for any realistic use case (e.g., a single list containing all
buffers in a large scene). This prevents memory exhaustion attacks and
ensures predictable performance.

Return -EINVAL if the requested entry count exceeds the limit

Reviewed-by: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 688b87d39e0aa8135105b40dc167d74b5ada5332)
Cc: stable@vger.kernel.org
Signed-off-by: Fang Wang <32840572@qq.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 66fb37b64388..ded22f244ada 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -36,6 +36,7 @@
 
 #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
 #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
+#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
 
 static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
@@ -190,6 +191,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
+	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
+		return -EINVAL;
+
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
 		info = vmemdup_array_user(uptr, bo_number, info_size);
-- 
2.34.1


