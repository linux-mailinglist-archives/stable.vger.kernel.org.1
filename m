Return-Path: <stable+bounces-82454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508DC994CE0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E2C1C25169
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5841DED4B;
	Tue,  8 Oct 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YyT0pPXX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F3189910;
	Tue,  8 Oct 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392316; cv=none; b=atd6YaLH4Vnn0dCjS66yNg0T4qZGTIW1YU6AbqPh/CsYTKvTTbkUScSEYaYMv6EYv1UeFgWs2QLYglM7aZ+ko0dxpou+tCH34SDcFcrjPvbOCCg37ewulbltXOCPuxsRSDZaqEnqAyxKo2d/Aje6GBZLzAHU0urVQP1pMeEbU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392316; c=relaxed/simple;
	bh=RQfnY9yUqQNdW2HCvJbhVLJXJC5xzqBX4i5l/kf/vlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+MsLV1sfdwBbyHR1oMp/yqEuPu8MrWJynhCeL/+GG9ixA+4qdvgVGc75865BC2VGQf0XyFwoXEhn3+kcEgFpX1huZj+iti54EChdNWJ0WqCgyUpKviFwE7DKRu7jsheE7tThjK2Ldyl0yxZWju8skYHjgMtqifSUp86NSMNNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YyT0pPXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB03C4CEC7;
	Tue,  8 Oct 2024 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392316;
	bh=RQfnY9yUqQNdW2HCvJbhVLJXJC5xzqBX4i5l/kf/vlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyT0pPXX7DTgLOEbmUQ164IycuM5l9jJ6KM2zrwLdSw68XuQSEErxTIthu9ySRhSf
	 p023gBmDfRNIrhm1XaEbdFKj5Qh7tXILNn8kFB4pewb9615jZDNf0g+/IiS3NV8dV8
	 MVlEzOtSRo4m2iOBFpoTBrZo0dVFuU+MHkaex0Ws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.11 348/558] KVM: arm64: Fix kvm_has_feat*() handling of negative features
Date: Tue,  8 Oct 2024 14:06:18 +0200
Message-ID: <20241008115715.992913801@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

commit a1d402abf8e3ff1d821e88993fc5331784fac0da upstream.

Oliver reports that the kvm_has_feat() helper is not behaviing as
expected for negative feature. On investigation, the main issue
seems to be caused by the following construct:

 #define get_idreg_field(kvm, id, fld)				\
 	(id##_##fld##_SIGNED ?					\
	 get_idreg_field_signed(kvm, id, fld) :			\
	 get_idreg_field_unsigned(kvm, id, fld))

where one side of the expression evaluates as something signed,
and the other as something unsigned. In retrospect, this is totally
braindead, as the compiler converts this into an unsigned expression.
When compared to something that is 0, the test is simply elided.

Epic fail. Similar issue exists in the expand_field_sign() macro.

The correct way to handle this is to chose between signed and unsigned
comparisons, so that both sides of the ternary expression are of the
same type (bool).

In order to keep the code readable (sort of), we introduce new
comparison primitives taking an operator as a parameter, and
rewrite the kvm_has_feat*() helpers in terms of these primitives.

Fixes: c62d7a23b947 ("KVM: arm64: Add feature checking helpers")
Reported-by: Oliver Upton <oliver.upton@linux.dev>
Tested-by: Oliver Upton <oliver.upton@linux.dev>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20241002204239.2051637-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_host.h |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1423,11 +1423,6 @@ void kvm_set_vm_id_reg(struct kvm *kvm,
 		sign_extend64(__val, id##_##fld##_WIDTH - 1);		\
 	})
 
-#define expand_field_sign(id, fld, val)					\
-	(id##_##fld##_SIGNED ?						\
-	 __expand_field_sign_signed(id, fld, val) :			\
-	 __expand_field_sign_unsigned(id, fld, val))
-
 #define get_idreg_field_unsigned(kvm, id, fld)				\
 	({								\
 		u64 __val = kvm_read_vm_id_reg((kvm), SYS_##id);	\
@@ -1443,20 +1438,26 @@ void kvm_set_vm_id_reg(struct kvm *kvm,
 #define get_idreg_field_enum(kvm, id, fld)				\
 	get_idreg_field_unsigned(kvm, id, fld)
 
-#define get_idreg_field(kvm, id, fld)					\
+#define kvm_cmp_feat_signed(kvm, id, fld, op, limit)			\
+	(get_idreg_field_signed((kvm), id, fld) op __expand_field_sign_signed(id, fld, limit))
+
+#define kvm_cmp_feat_unsigned(kvm, id, fld, op, limit)			\
+	(get_idreg_field_unsigned((kvm), id, fld) op __expand_field_sign_unsigned(id, fld, limit))
+
+#define kvm_cmp_feat(kvm, id, fld, op, limit)				\
 	(id##_##fld##_SIGNED ?						\
-	 get_idreg_field_signed(kvm, id, fld) :				\
-	 get_idreg_field_unsigned(kvm, id, fld))
+	 kvm_cmp_feat_signed(kvm, id, fld, op, limit) :			\
+	 kvm_cmp_feat_unsigned(kvm, id, fld, op, limit))
 
 #define kvm_has_feat(kvm, id, fld, limit)				\
-	(get_idreg_field((kvm), id, fld) >= expand_field_sign(id, fld, limit))
+	kvm_cmp_feat(kvm, id, fld, >=, limit)
 
 #define kvm_has_feat_enum(kvm, id, fld, val)				\
-	(get_idreg_field_unsigned((kvm), id, fld) == __expand_field_sign_unsigned(id, fld, val))
+	kvm_cmp_feat_unsigned(kvm, id, fld, ==, val)
 
 #define kvm_has_feat_range(kvm, id, fld, min, max)			\
-	(get_idreg_field((kvm), id, fld) >= expand_field_sign(id, fld, min) && \
-	 get_idreg_field((kvm), id, fld) <= expand_field_sign(id, fld, max))
+	(kvm_cmp_feat(kvm, id, fld, >=, min) &&				\
+	kvm_cmp_feat(kvm, id, fld, <=, max))
 
 /* Check for a given level of PAuth support */
 #define kvm_has_pauth(k, l)						\



