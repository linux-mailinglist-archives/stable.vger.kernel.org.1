Return-Path: <stable+bounces-89368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F99B6E20
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 21:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D319B221A3
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 20:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9221765D;
	Wed, 30 Oct 2024 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOoVF7LL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0D217657;
	Wed, 30 Oct 2024 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321390; cv=none; b=WG2VXiwaxbbwosJh1pIWlXlkL91hXjTWN7fv3tmKi54IrZAqhIW8UH+5XmBKgzjFBuxDCWzhR0Olass18UgTLINH2ptj8ZJGIm4tO1jV4F8LSMEdaMJ+6LMfxq+PKDRqlOuddSs2D/FHwfgYJ5CuvLa98AHD1gVv0YToLKOmlOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321390; c=relaxed/simple;
	bh=qJdTcgpxMWoOYJiUsP4GiG9tUqa01DGZ7YOgoBaVGYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBJTV7YStkqSp7imVksZwabPkiicylrpWYbjBsoYbMgQ1tHM3CBxzdK+lf4vQRIGXRCFZNK8XiCUofvKuCPCLsCIJ9ykUI8B3nG8g6e2eAaJc53OIPTm3hQDU0VO6kSg71sm/ATEqIIwR9qfM6438eeZhIr1A+fRDZ/4Jg4B0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOoVF7LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2757FC4CED3;
	Wed, 30 Oct 2024 20:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730321389;
	bh=qJdTcgpxMWoOYJiUsP4GiG9tUqa01DGZ7YOgoBaVGYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MOoVF7LLTAGPZR8k2y9yUPTSo3ePcHSsIQKKysT8QUfGtY3lQVdYZqVM+iITuloim
	 E7+DHneXNINFM3j7VlFWRmnGc3PyugIbOXZn3HOW5OuZ+JTup64mFLx/RYvpVC3tYd
	 46qFpapz61zxbnJQTiIH6BJB/ix0X5AZ2cd0ZR6SruXvngyNixxOHkgHgN2JDjbyQf
	 40BTfLzImQ7zA6ViT1dH8CjN8RBP++xbxwf/3fDZv7B7xB5oWn9brXkpUrV9lo91xN
	 QODVwZPQJYvp165YgXvA8QAIdZ2SQlJXRTlygDB0e7HeyskrYT+kV6ScZTOyMBtuid
	 Y6zZhINpalTnw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 20:23:51 +0000
Subject: [PATCH 2/2] arm64/sme: Flush foreign register state in
 do_sme_acc()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-fpsimd-foreign-flush-v1-2-bd7bd66905a2@kernel.org>
References: <20241030-arm64-fpsimd-foreign-flush-v1-0-bd7bd66905a2@kernel.org>
In-Reply-To: <20241030-arm64-fpsimd-foreign-flush-v1-0-bd7bd66905a2@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qJdTcgpxMWoOYJiUsP4GiG9tUqa01DGZ7YOgoBaVGYE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIpvnUTblL/oeizk6bN46HjZA0iw8vzEUtYmdpw9l
 fgVjsx+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyKb5wAKCRAk1otyXVSH0O0ZB/
 9Y9TutGjpVTwnaB7MGwyaYlS45T1zetmUTPlUgk5Bzrrtxnik4kWCWtMbUweX/06JhukK8Mo25LHu+
 IWlwyj0MO9SREDJUnqgGsAeJwCLx+Zg1mduJpZynDnFSwuCdEPM2cWtUu+LMvmG5MM05wquiL96F6Y
 EoQ50JgPqJV3ssrk+StMixv8AsUsRJ3EcECzuWQF34WlHFILUocL7cTz1i1yP5T3ykAQy0dy/knPu3
 wg1GhMzCp7m1ouVUHjLlJOSHBZjzO7KwS+fjTjDJU3zO5K/oSwd70BUm/CVBykNnZDDaafQnleB30X
 pMa33MLb0Sh+c5uvS/mgWDsXmFUW/H
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

Fixes: 8bd7f91c03d8 ("arm64/sme: Implement traps and syscall handling for SME")Reported-by: Mark Rutlamd <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/fpsimd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 6d21971ae5594f32947480cfa168db400a69a283..1eaa670cbffa448c1aced8c8b37040492e18a21f 100644
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
2.39.2


