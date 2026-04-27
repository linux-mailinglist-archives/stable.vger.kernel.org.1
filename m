Return-Path: <stable+bounces-241228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OtqMukH72nd4AAAu9opvQ
	(envelope-from <stable+bounces-241228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:53:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5A246DDCD
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D436302DF6C
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E038F94C;
	Mon, 27 Apr 2026 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EfaVkvpT"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C63264FA;
	Mon, 27 Apr 2026 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272715; cv=none; b=ogloHca5VW8Y1uLdEEsw3tzTfwnSYE18ofeaENB3VfeQTXHeorVN/0O5LwalUYrbCWQcsT+dx/6KZet1Ps4swXljivc8FCFPtr+7dWDGL2Bf69qU2OBRnscWpe7Eg0Xb6knGPRasQNWS6dLCgDd6v8PAgKfN+SR+3hj1jHEJsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272715; c=relaxed/simple;
	bh=SIkLTwXx+19eW46RjvDYfRGi/+vFUwsdkLTWEyKkJqs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gr2bSnOAp71u6DRyAnU9/ytFQMqjyDFEoHcNcJEhdNxy3mXNsfzLdQTyRyLolAi3IKH1G4Lw4SRCp+bWMyp05k6J1YmdJqMWyEJfUBYMHjLkPzFnts/BohYeq6kFEcFVFJ6BhoNzQK71n5ZvJAB6dXhAdMceY2HBsZDDylP5XTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EfaVkvpT; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777272704; bh=ks8ggYiCLDadKMxcZ8CW+2cQqlh6RyPsgTtN23PYkL0=;
	h=From:To:Cc:Subject:Date;
	b=EfaVkvpTYvW47+GK0uzcMjTdJrExZAQPwbgVy9MEZz/ZWFMd/TZdbJmiprDOTDRzk
	 NkOYEh5KHNUboLXyp1cyd10nK/Pd7sv2PZxFz9cwYGeHbdOh1RtxchGvDPsejlPzGP
	 Hrq5/X88dVvveYmKvhZf7+ToGYJ8xwM+b+bS/BZY=
Received: from NTT-kernel-dev ([60.247.85.88])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id CE98AADB; Mon, 27 Apr 2026 14:51:41 +0800
X-QQ-mid: xmsmtpt1777272701t78vn4y9q
Message-ID: <tencent_8DBF29E0271CF7880497A344239DA11C2B0A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XhMGAw4Y2fX3RcOFCSr9oRvruFjIRTe12uuhbLspCq/SNuxvm7A
	 /fk2dEjaYSKw0EedVgPO6nIz6hLkHgVIovQaqi2r98YMvjd3U2/vqzWwcywvrK2hcL8XMVFi5mTr
	 aFZyz7oKC2HY+LAukPfbcNgTYO3cPCFsLHpUb88LlzUhakacuGNho12hcp7o1tkkH7SpO82enzTC
	 l0rglZjLbzM3vjgjglGL7IwDQNU7U/+KInd23qTD/reO+HdVks9XQNft/Sxih3dBovBCYiwqlwh7
	 VWHVMwhILJHDTs/9QmilCLXVHswg0JKsnu7b55aeN4XFb1ZJM9U7iEu15UXsoZNy7ai1EuUIV2s5
	 SRlfPND3AQ1Zy3BEShDgJY/qNHnUWu9uFxFGG7SBsGsEstl+uN+bph6AGZ8kajr/6RlJzxs1x30Y
	 wsVgutCd1YZb8grk02KL8527aQ7SDXjTjHgtVfYdiYMYj0LBroUGAiz8pDGlfQmYJ5mcAacQeNvv
	 q/G1237Jw+nE27gSCTdRFRtpBDQKalmmkFXAxf1SVX2ciLNkbmXVFkeRhCVZxzjM/sZU39Ox4EEN
	 dEzbzP581qm8P/KRqZY119BhwP0NTihokx3mIKXDMTrncrEl9DMUSPrWSYQqTk0hRyHmSPt2UwF1
	 w0yRTeSJ+Ybj2Nye9IYpODU6cq3/aiCVv3pO6fBZNpGqz2mJbmh6qvE1tKeaMQOl7B8pemJHyYzZ
	 9PM6fFZ0h0WYQIdj5xtVe9ZUi5QLRNVEJ4oRtWtfbPcBGQcxDrsxPKihk/yCDEK5jaey9QixmhQh
	 ID90LasAN1l0o+VryfPK7FkJ92QdCtRIffUqMET+vdgBLloEQTd5qyZkz6SQHmrtPt9nd84s072j
	 ExqWgGdRNSz9B9yTzEmmsvTiBkpo+/PmN4K1lTmGuogumRLBnJ3vhP3n2e+bnIgNrH9pJbn9f7op
	 Mi2kXYMCcsMJ5DBts/0KhejMXs313OQ2R0ENTa6EurJ77/3OqDZAUDM4tdvpx3MR+acCRRR24=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
Subject: [PATCH 6.12.y 1/2] drm/amdgpu: Use vmemdup_array_user in amdgpu_bo_create_list_entry_array
Date: Mon, 27 Apr 2026 14:51:41 +0800
X-OQ-MSGID: <20260427065141.4118590-1-32840572@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D5A246DDCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-241228-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[32840572@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email,qq.com:dkim,qq.com:mid]

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit c4ac100e9ae252b09986766ad23b1f83ca3a369d ]

Replace kvmalloc_array() + copy_from_user() with vmemdup_array_user() on
the fast path.

This shrinks the source code and improves separation between the kernel
and userspace slabs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Fang Wang <32840572@qq.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 41 +++++++++------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 702f6610d024..66fb37b64388 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -184,43 +184,36 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
 int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 				      struct drm_amdgpu_bo_list_entry **info_param)
 {
-	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
 	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
+	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
+	const uint32_t bo_info_size = in->bo_info_size;
+	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
-	int r;
-
-	info = kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
 
 	/* copy the handle array from userspace to a kernel buffer */
-	r = -EFAULT;
-	if (likely(info_size == in->bo_info_size)) {
-		unsigned long bytes = in->bo_number *
-			in->bo_info_size;
-
-		if (copy_from_user(info, uptr, bytes))
-			goto error_free;
-
+	if (likely(info_size == bo_info_size)) {
+		info = vmemdup_array_user(uptr, bo_number, info_size);
+		if (IS_ERR(info))
+			return PTR_ERR(info);
 	} else {
-		unsigned long bytes = min(in->bo_info_size, info_size);
+		const uint32_t bytes = min(bo_info_size, info_size);
 		unsigned i;
 
-		memset(info, 0, in->bo_number * info_size);
-		for (i = 0; i < in->bo_number; ++i) {
-			if (copy_from_user(&info[i], uptr, bytes))
-				goto error_free;
+		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
 
-			uptr += in->bo_info_size;
+		memset(info, 0, bo_number * info_size);
+		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
+			if (copy_from_user(&info[i], uptr, bytes)) {
+				kvfree(info);
+				return -EFAULT;
+			}
 		}
 	}
 
 	*info_param = info;
 	return 0;
-
-error_free:
-	kvfree(info);
-	return r;
 }
 
 int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1


