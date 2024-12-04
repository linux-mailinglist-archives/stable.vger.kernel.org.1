Return-Path: <stable+bounces-98305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E89E3E19
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AD12810F9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4DC20C03E;
	Wed,  4 Dec 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGXcSMjF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96ED20C032;
	Wed,  4 Dec 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325746; cv=none; b=qg1eSfF+sgELY3Pxq5MxyrmOF/tqDpPCzTojSmp2r1DkQECMXJZ4xzSdyc2Kfhqy3ODLuljZlCBsCHuyjQyqXCU0jXD1nzuFB5ja5VzOq9JijZilemqr8OM00IV4pqiHbQzTep5VGvyzGRe/1EDqV9vK4OnVORgB9lugCVdK85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325746; c=relaxed/simple;
	bh=LpOVQoMlpE/E8rUSHH5zwrqMIfcMHJ5yw+nwZF82uAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcTGTrsh1cIeq8jxW7NU+tOgd5GZHCL/3QOjaRVIunSijwwsYlp8KqEFPsq4bAEZeyD0UdDRjL7VhF5Ntq1/nwD2S2ooMNeCh5TAhLsc6KaLheHDqjYq5PaQIVXPs+NFNnzldVPlWj4pRXvugqAYap/hNQibytKzqlTxHb/30Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGXcSMjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA593C4CEDF;
	Wed,  4 Dec 2024 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733325746;
	bh=LpOVQoMlpE/E8rUSHH5zwrqMIfcMHJ5yw+nwZF82uAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NGXcSMjFEK3Gb5ZThhTotb8LtObyRrVYXZMwWsjbtfNNERt/rSoOgxKD4cfll0oT1
	 gA4Vir1uILjYXAxidPmQWIayCKAJFXCxh3QEWX1ClTDpAtN+oX46EtV3AV1qarfLJT
	 1gsDKErmPYoPUi3vgG8jWS4hBB7Oe+uBbsHpYM0tFBE/Ga1pvtzf8pkpEosmauaZx7
	 moc5xQAf/foWsJSDEs+AEuTGL1Mtx0fOtyjc4RXaPCx4v8rjB2qHOQ6WPW5+pro1TK
	 PH3Z8ZytH+xdIGUt6G2xRMLdYMd2TGVNtqUk6PcmrVufDsg/ngoh6LdMt43T08YwUu
	 oPROgdoK9zFkA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 04 Dec 2024 15:20:49 +0000
Subject: [PATCH v2 1/6] arm64/sme: Flush foreign register state in
 do_sme_acc()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-arm64-sme-reenable-v2-1-bae87728251d@kernel.org>
References: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
In-Reply-To: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LpOVQoMlpE/E8rUSHH5zwrqMIfcMHJ5yw+nwZF82uAs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnUHOpV1gwjo0EzhOoXMD37trHVNnA76xlj4H70URa
 8/Ka34eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1BzqQAKCRAk1otyXVSH0JU5B/
 9tJ8ahfl3ZVfslu1hDK5SdC1zHiWbpICVSKPprRqsqf34h8Q5rtN3W3y6cDJIAhS3VnYqrnyQ34PdB
 qQPuOe4L3HsDy+RZfLSY6gJZr/3/vHtN6tXCcFuQZ2KZAu7S2iDU+MfBRWUSSW2B5Nw5nW4AXCgnO7
 nYmwctPULF9HxwZ5Jk+zd9Kf5ym1S+3cEb5SjgSbMH9/EI93o0sbQqh+cOJ37BAbCmDS3CTdikqzPC
 rMDC2rIgm0u+ufDvuyO389ZOY8CxdxzZGumTrRX26WEaRStIyFVTUaI5OgH7XXS/xznwK61W6grplw
 4ANmhMEhh14yXBZYEuOsu3KK6qRKC6
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


