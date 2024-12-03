Return-Path: <stable+bounces-96302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C999E1E1B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D35B621C6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB531F12ED;
	Tue,  3 Dec 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtYb1fxE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E661EBFFD;
	Tue,  3 Dec 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230090; cv=none; b=kllPGhv+VGIhflyide3WNmv2wasYqjI7AYRHz/Y8h2OPUHncgQ44ydqM47lr2wG2diNKRYhoGI8MQS9XX760q/Y/fMQfARSX6JZ98Rd0WpquxFEM5MPN5eRlvk6ZPGQNfpeD8z6Em/IOyiZQ0HhX3qz52oCRplBQ0JvgFlGBk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230090; c=relaxed/simple;
	bh=LpOVQoMlpE/E8rUSHH5zwrqMIfcMHJ5yw+nwZF82uAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSOFRuVlfgQEOdfr/ruQZJcL2EkRGJf67m8O1UbaqQY9oCwy/dPy45psUnbDGcmrC8gGgt8bvdWDBXeaAaFaF2KsBXR4dknRJ0DMl3ZNNorEOs6XSYPBfL5jIrTNrrK2ih8BJDr/dx/Efp6dkG1GeQDqZF/IJzqrjJugHr90448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtYb1fxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACCCC4CED8;
	Tue,  3 Dec 2024 12:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733230090;
	bh=LpOVQoMlpE/E8rUSHH5zwrqMIfcMHJ5yw+nwZF82uAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NtYb1fxEkI2ZLYOEInRO4JT0N1O6Cp77u2HFOwEHVSmNmbf2mmBLUjqLFy5Muk8ls
	 tNHX8UfGBS94tO5oQ6EBOqpHVic4wyRcZzBAGWRGaOGpA/vZR5IIWJQBIMREXyMRZw
	 mS9c9iHlerOja+AAN72vQqTvDefMaHLfWQrRRL0TuN90LxRZXVQ9gzqM4fi2bGmjzo
	 C8zJ+vR80iUumIGgA5JzJ7JDigny3VQEwpyYCsEBj/ULGyNMTwXHi3x/kRWP3cLMM/
	 yK5BcRvwa6m/QbqpPjDA2DYQWy7xo/rfhkJ77rHu2whIUKlJyb32sI53o09uMIieiF
	 eqDc1Vg8U5BJg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:45:53 +0000
Subject: [PATCH 1/6] arm64/sme: Flush foreign register state in
 do_sme_acc()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-sme-reenable-v1-1-d853479d1b77@kernel.org>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
In-Reply-To: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LpOVQoMlpE/E8rUSHH5zwrqMIfcMHJ5yw+nwZF82uAs=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnS/fwxZFimK2tZr1lq9W90o8CI4fq/Sy1JJxgCOwmCpNZxB
 sv2djMYsDIxcDLJiiixrn2WsSg+X2Dr/0fxXMINYmUCmMHBxCsBE3vqz/9OzNm9XOHpxwU7GkkX7Wu
 5sfHg6nbPpFfv2KXbJHOlHD36KPvRVi3nZzmsXpPz8TwtMn2rhv7XCyuXbmqqlvKunlnyc82Nf0skM
 YbtK48Atu47Paw5s6rjn0xHkJNNgdvJfCHP+TV1Z90l7C3/IvbEK2bnKjDH6u2ecUl/ocaF+ra21Bb
 YGtl9kn1xj5VbsU2yTeOK/xf77moPBv8xkvxzlcemVubFttVXYvdd/bVujl4rPfZFuVV5SxHbSV7mb
 t6rO3tkgNe6n5uSfj39G7Yxmar6g/7/OMHWJmFMgU/eUDxPXf0qb8ttUsbb8jfSfhBw7kTRR8ZKHc7
 tVl3hckAvtaf3To2sxx1y9INoJAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When do_sme_acc() runs with foreign FP state it does not do any updates of
the task structure, relying on the next return to userspace to reload the
register state appropriately, but leaves the task's last loaded CPU
untouched. This means that if the task returns to userspace on the last
CPU it ran on then the checks in fpsimd_bind_task_to_cpu() will incorrectly
determine that the register state on the CPU is current and suppress reload
of the floating point register state before returning to userspace. This
will result in spurious warnings due to SME access traps occuring for the
task after TIF_SME is set.

Call fpsimd_flush_task_state() to invalidate the last loaded CPU
recorded in the task, forcing detection of the task as foreign.

Fixes: 8bd7f91c03d8 ("arm64/sme: Implement traps and syscall handling for SME")
Reported-by: Mark Rutlamd <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/fpsimd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 8c4c1a2186cc510a7826d15ec36225857c07ed71..eca0b6a2fc6fa25d8c850a5b9e109b4d58809f54 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1460,6 +1460,8 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 		sme_set_vq(vq_minus_one);
 
 		fpsimd_bind_task_to_cpu();
+	} else {
+		fpsimd_flush_task_state(current);
 	}
 
 	put_cpu_fpsimd_context();

-- 
2.39.5


