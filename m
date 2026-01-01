Return-Path: <stable+bounces-204413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97ACECEAC
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 10:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0FE930155F7
	for <lists+stable@lfdr.de>; Thu,  1 Jan 2026 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCEB2BE7DF;
	Thu,  1 Jan 2026 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cm8bhUoM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckKpStMj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F38296BA4
	for <stable@vger.kernel.org>; Thu,  1 Jan 2026 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258330; cv=none; b=srU61txYbIZ6lHdrypty6YbE3Ai73y3xPCm9Jl7F+zYQGEmwFY6oIOxJ4K8TsUz9kRb22gmnx+sya/kH0+Oq3naJtM+QtqphclDJ1VOddH6enlCgUw3qKjOUk0viTpdJDJCa6KegJa1BZQBQfIyIblvBC0FEXRrUCLu53jCzrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258330; c=relaxed/simple;
	bh=Hsx0y+DbmN46u/TuVMRMvMafpwW8lChJnxfxXyvlonY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtFoY6YUBQyY4FrSbjrKMNcyuTqDK5Dg3wDwMOGhSqR+vH4R9QsLncRCA+gutbBQkgwhZnTe6z+oZO6bI7+Qbgrrsx5y2hHJHvYVhRjvawUziHdKuqn8BtIa2IHgk2E6zRl/1VLb9eQS86tLn/vN6a9UFIWIBWPB7TJxsYOGwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cm8bhUoM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckKpStMj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767258327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dv2vXP7l71EPJ3a2syyzSbz7LlQzp2jJ3iF7aDVd9lk=;
	b=Cm8bhUoMoWjDH3bBxJvqhj5qVe99UmCiWDKB2W6TS/2Og26j2ggJSIg1opPBIO+bD8so3t
	QpRgeZNQOrUt9GFXnahfvQdptaw5QnZEd1WllpZdyDvmku2Fey+BfQH180f8rBSv3xyX8Y
	06zDAtR98WaEfJToskzxmJrtAhqpG9o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-NMz5v_aYMTyzbqKmM8Xnhw-1; Thu, 01 Jan 2026 04:05:26 -0500
X-MC-Unique: NMz5v_aYMTyzbqKmM8Xnhw-1
X-Mimecast-MFC-AGG-ID: NMz5v_aYMTyzbqKmM8Xnhw_1767258325
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f5dcd4d3so6149670f8f.1
        for <stable@vger.kernel.org>; Thu, 01 Jan 2026 01:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767258325; x=1767863125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dv2vXP7l71EPJ3a2syyzSbz7LlQzp2jJ3iF7aDVd9lk=;
        b=ckKpStMjNpS+wan6drbcpjHb/zKY7iZtX5J8CwjEShs6iBU+nwETNJSPeVwKHbzLR8
         W7w1MtVw6rKflZWuPVnSh9DyDHys+uXk26HuAWDFHQcj3PylUsSG4jcVVoDcskcW6cOY
         H7QOoQOi6wEg+IGNE/dDSvvz/W4XnlAWaaGffEsKA7XMtf8DweG2Z1SVtG7jduu7Z/BV
         xXm7XrmqwZmrq5Pod6CPVjD61T1W6PYryiL3WRmdnN+JS8thnJgpZPzo+lCOnt6NwHwu
         4AcZT8DgiULlBwcJJQ1KqixjIk+79rA7JJJnM51mGe9tAmtC30A2y4hE9AfqE+PNonnV
         R6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258325; x=1767863125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dv2vXP7l71EPJ3a2syyzSbz7LlQzp2jJ3iF7aDVd9lk=;
        b=BNlKJH+WM3KY34NEouosb8ae+WxLFHanXHbvvrneY9Q4ZA4OGDkICubAEyILnIBntG
         9/BBLd+f/j/QCLrddfNkhIVje3kHYXKiJlovQY9LDfYCuKNVWWkyQXfxo7ONkTq7Zuy1
         5cZMc2+HFhGkMHQe4ueWYewlmqV2f5f3xTQFOJNkwf51Bg7yC5m2FjszkF0T9pKohh0b
         v+6zG4mvDQonuBOuszYpO/FyHJGtC/D3x5ExuheFyxb+iUs24lFoUHXUck7Tfa1JSIBC
         gVjEDoZqhaiD+I2VwKhbPXm68D+lHoO0UewgHiRl9g2i5q6ZM4R6lw0d+B6XzRYtaNe/
         6gxA==
X-Forwarded-Encrypted: i=1; AJvYcCUiYZ/MIcwPzwV1GhgZNh5u/rBYrK4uM61noclFMQHZOwYCjM34BVy7Wxhpf6oMb9j4WuFlVlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeLDUhK54UFmxVoaiN+Fm+9akRGgvOPUGmeopZInwzKOMAGlK
	8COCitwyaumQ9qa/amt80lt0p3KBnf73bZ8Dj6GVCduiiEadE2vm1exDb1a6IcA/+RUTGD8JOBZ
	4Lz6VtYLnKol7iG6HY8rEjhvM8R9z5tJD7ZzTIirX5nxGXlCbb/MU++Mszw==
X-Gm-Gg: AY/fxX6MtqEYxOkM7RIG3Mo4ubuIsOMgm0SpAoH4grsP/a6TJPkBk/TfkMT/YIK7ItN
	Q+VictK7A0E3jURCjxN04h4/sVVquOFWBf8ajeosigoR7ZwlDXszNCpusU/C9xWe1pZibw1XCQe
	GANtvu9okj52SklHdOenwanze0e9S9K+Ea7t6vLnAi3Lm/dr/3d4sVSrQWfrSeTZi77h6CM/kqQ
	ppaFUWUcz3ti00kX7U/6IYLqC3Wg8HHXNGPchpUZQ+RI0/eeKhZLj/+6qj4yR+26Vc50MWLGmd5
	ckZewXJgvyXNy5Heks5I97tT7pfFjBKKboV7fKgQxVNHeLxXG3gwzAZJp3dqgz1gATQLN9uTFHr
	vFM6KdpE7AdGxXqNzTKcUXCHd/TPuPgm6hv/jSwZJt32SW8VTw+afmFXTSoQfD9i79cGaIJ9BOD
	OF7JO/JZYGrnFLHg==
X-Received: by 2002:a5d:64e9:0:b0:431:382:f141 with SMTP id ffacd0b85a97d-4324e3f5da3mr60213162f8f.12.1767258325312;
        Thu, 01 Jan 2026 01:05:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4WAOxBJTLEpMN3jGlnx3z7h44fd/Ys6O2ejcU9i7fcmeDx6jvrwYWYXW2AgjJFsozrXROrA==
X-Received: by 2002:a5d:64e9:0:b0:431:382:f141 with SMTP id ffacd0b85a97d-4324e3f5da3mr60213121f8f.12.1767258324894;
        Thu, 01 Jan 2026 01:05:24 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2c4fsm78890215f8f.42.2026.01.01.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:05:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	x86@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] selftests: kvm: try getting XFD and XSAVE state out of sync
Date: Thu,  1 Jan 2026 10:05:15 +0100
Message-ID: <20260101090516.316883-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260101090516.316883-1-pbonzini@redhat.com>
References: <20260101090516.316883-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The host is allowed to set FPU state that includes a disabled
xstate component.  Check that this does not cause bad effects.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/x86/amx_test.c | 38 +++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/amx_test.c b/tools/testing/selftests/kvm/x86/amx_test.c
index 4ac41c1a7255..00a42a592a37 100644
--- a/tools/testing/selftests/kvm/x86/amx_test.c
+++ b/tools/testing/selftests/kvm/x86/amx_test.c
@@ -125,11 +125,17 @@ static void set_tilecfg(struct tile_config *cfg)
 }
 
 enum {
+	/* Retrieve TMM0 from guest, stash it for TEST_RESTORE_TILEDATA */
+	TEST_SAVE_TILEDATA = 1,
+
 	/* Check TMM0 against tiledata */
-	TEST_COMPARE_TILEDATA = 1,
+	TEST_COMPARE_TILEDATA = 2,
+
+	/* Restore TMM0 from earlier save */
+	TEST_RESTORE_TILEDATA = 4,
 
 	/* Full VM save/restore */
-	TEST_SAVE_RESTORE = 2,
+	TEST_SAVE_RESTORE = 8,
 };
 
 static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
@@ -150,7 +156,16 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 	GUEST_SYNC(TEST_SAVE_RESTORE);
 	/* Check save/restore when trap to userspace */
 	__tileloadd(tiledata);
-	GUEST_SYNC(TEST_COMPARE_TILEDATA | TEST_SAVE_RESTORE);
+	GUEST_SYNC(TEST_SAVE_TILEDATA | TEST_COMPARE_TILEDATA | TEST_SAVE_RESTORE);
+
+	/* xfd=0x40000, disable amx tiledata */
+	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILE_DATA);
+
+	/* host tries setting tiledata while guest XFD is set */
+	GUEST_SYNC(TEST_RESTORE_TILEDATA);
+	GUEST_SYNC(TEST_SAVE_RESTORE);
+
+	wrmsr(MSR_IA32_XFD, 0);
 	__tilerelease();
 	GUEST_SYNC(TEST_SAVE_RESTORE);
 	/*
@@ -210,10 +225,10 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_x86_state *state;
+	struct kvm_x86_state *tile_state = NULL;
 	int xsave_restore_size;
 	vm_vaddr_t amx_cfg, tiledata, xstate;
 	struct ucall uc;
-	u32 amx_offset;
 	int ret;
 
 	/*
@@ -265,20 +280,27 @@ int main(int argc, char *argv[])
 			/* NOT REACHED */
 		case UCALL_SYNC:
 			++iter;
+			if (uc.args[1] & TEST_SAVE_TILEDATA) {
+				fprintf(stderr, "GUEST_SYNC #%d, save tiledata\n", iter);
+				tile_state = vcpu_save_state(vcpu);
+			}
 			if (uc.args[1] & TEST_COMPARE_TILEDATA) {
 				fprintf(stderr, "GUEST_SYNC #%d, check TMM0 contents\n", iter);
 
 				/* Compacted mode, get amx offset by xsave area
 				 * size subtract 8K amx size.
 				 */
-				amx_offset = xsave_restore_size - NUM_TILES*TILE_SIZE;
-				state = vcpu_save_state(vcpu);
-				void *amx_start = (void *)state->xsave + amx_offset;
+				u32 amx_offset = xsave_restore_size - NUM_TILES*TILE_SIZE;
+				void *amx_start = (void *)tile_state->xsave + amx_offset;
 				void *tiles_data = (void *)addr_gva2hva(vm, tiledata);
 				/* Only check TMM0 register, 1 tile */
 				ret = memcmp(amx_start, tiles_data, TILE_SIZE);
 				TEST_ASSERT(ret == 0, "memcmp failed, ret=%d", ret);
-				kvm_x86_state_cleanup(state);
+			}
+			if (uc.args[1] & TEST_RESTORE_TILEDATA) {
+				fprintf(stderr, "GUEST_SYNC #%d, before KVM_SET_XSAVE\n", iter);
+				vcpu_xsave_set(vcpu, tile_state->xsave);
+				fprintf(stderr, "GUEST_SYNC #%d, after KVM_SET_XSAVE\n", iter);
 			}
 			if (uc.args[1] & TEST_SAVE_RESTORE) {
 				fprintf(stderr, "GUEST_SYNC #%d, save/restore VM state\n", iter);
-- 
2.52.0


