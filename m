Return-Path: <stable+bounces-35740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EF689755A
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 18:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81361F267F1
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1BC1514D5;
	Wed,  3 Apr 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2dBHy20"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCD1E52A
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162283; cv=none; b=Mi1UyCpvQWHiM/VLW8pCLTLW5ldhJjljMMOVwyiLb+ykjDH41LkIfJX3F7yz7vd1gDfwUMwH3Lbig0de+Ooa5qtEpFZPZKX0f1TdUDYj0DfP/OLhcPD+hhxAF7L+WzLKMkeHEj+Lz4hB8zGxfLF2ul1ZOdTvVYRsOStx7MiY7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162283; c=relaxed/simple;
	bh=ytvGI9heir8jUTNz8fa21KCx3UR41dZ1BEei/fkS/tk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m5abM+SwyYQjJVkSI20mIZxbS4RCeaJzb6V/JtYp2jWrYERC6/OGdSXOwCHQEz0rqu79ryYYO6P1R4Yd2AE1QDnJAPfw6HXVQ4KAr5EHUAa5zYWYV4fWXuua9deePp52ZtHoDhUh9CRTrpBKNGdp+2Ts0ckv0h/tfmORM6RI97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2dBHy20; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7cc74ea8606so4198439f.2
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712162280; x=1712767080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q1vrkM4qy+eCxZFi+KNPrNFLVrCIYB9n/XwoXXqqv5s=;
        b=X2dBHy20VCfrkvrQ6WM2WSZVss0oa5SFr3NpuNhg6lMs1wVBBc0U+qJfCXzpXvRdAz
         3EnOr43T6+cwziuo9Ez1jx9GO1UkoLE0wGcys4K3+9tqoxUST6TcVyn2KUnfiOrv/UYs
         1qFf77G3s5l0KgLHt82yoo+eMjTI4JDJO75HKUdMLfvY7Gay2+WC4nJM49FXoNDegy40
         I+PkoFZOlZoy812OD+CWreLMYEYdh0fq2XtKFERUDxmWhsErqEWfF/POnUPGqdc+wjUl
         GHF/0htmJxmizb0DyMDSoPlj5vh2CYdmK5xHx+MXLuroELuq1gucI9ZSyLUH0CmIWp00
         brCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162280; x=1712767080;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1vrkM4qy+eCxZFi+KNPrNFLVrCIYB9n/XwoXXqqv5s=;
        b=IK+c6wRHNqAFTrBq03UsMsUUirmykVU/TK6zpqWky3f77ozg2cEFeQAIJLnnrajfSj
         8yo05krTzytmszjuWQV5gb36Cv2N70oWuo31UqqY2Q7+oEZUf3Q+LZFMS9J4dEM3IrKf
         K0ioa34UEj90u5NOuHtwBMMfJsdoxPvVfEVSWeCbRM+G27UhIs+bhvHCuXIsesWSsqdO
         qmHz2aK64CVIp8QUw2duLWvdvhJx6fUjzOttWaG+OrMcyNHBRNVuMrQVgSJlSZf8/BEm
         JUmmbceFiUTsryTw/8G+bw6lgAybqIVnNF/z0mlWkcG2L2eVHoTgqlG/91k+gDPk2R1L
         16tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJOOI3xLcamyQTJ2+iYlZk1G6Aq30bfdtKQgzaTuIVkxSeGRmHGyZj6pmalBYsZ9dM5E8KsoKFCKtSJy+aCWHqEWSQPJi5
X-Gm-Message-State: AOJu0YyarTa+6g2UqFz0UnMUlttP+1dZl37FvRjvLZLZXC8UyVmOHiw8
	vbDxSKZsZL9JQnGrDb5zeKVIWgP8uAw5wQPe68MQhzmRbqnMfiSBjAtC/nIphPFkfkh6PKynLaM
	jZcKNQg==
X-Google-Smtp-Source: AGHT+IGB4vV/Sw5krILq3RILr7noozz1vwF6KwvYjFIURr/fONHnLOvW+gLWPcsGnEAhdPwH930QmeaHYght
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:20a1])
 (user=rananta job=sendgmr) by 2002:a05:6638:3488:b0:47c:1788:e23 with SMTP id
 t8-20020a056638348800b0047c17880e23mr953740jal.4.1712162280573; Wed, 03 Apr
 2024 09:38:00 -0700 (PDT)
Date: Wed,  3 Apr 2024 16:37:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403163753.1717560-1-rananta@google.com>
Subject: [PATCH] KVM: selftests: Fix build error due to assert in dirty_log_test
From: Raghavendra Rao Ananta <rananta@google.com>
To: Sean Christopherson <seanjc@google.com>, Sasha Levin <sashal@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

The commit e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in
the dirty ring logging test") backported the fix from v6.8 to stable
v6.1. However, since the patch uses 'TEST_ASSERT_EQ()', which doesn't
exist on v6.1, the following build error is seen:

dirty_log_test.c:775:2: error: call to undeclared function
'TEST_ASSERT_EQ'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
        TEST_ASSERT_EQ(sem_val, 0);
        ^
1 error generated.

Replace the macro with its equivalent, 'ASSERT_EQ()' to fix the issue.

Fixes: e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test")
Cc: <stable@vger.kernel.org>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Change-Id: I52c2c28d962e482bb4f40f285229a2465ed59d7e
---
 tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index ec40a33c29fd..711b9e4d86aa 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -772,9 +772,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	 * verification of all iterations.
 	 */
 	sem_getvalue(&sem_vcpu_stop, &sem_val);
-	TEST_ASSERT_EQ(sem_val, 0);
+	ASSERT_EQ(sem_val, 0);
 	sem_getvalue(&sem_vcpu_cont, &sem_val);
-	TEST_ASSERT_EQ(sem_val, 0);
+	ASSERT_EQ(sem_val, 0);
 
 	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 

base-commit: e5cd595e23c1a075359a337c0e5c3a4f2dc28dd1
-- 
2.44.0.478.gd926399ef9-goog


