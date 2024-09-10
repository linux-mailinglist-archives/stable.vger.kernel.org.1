Return-Path: <stable+bounces-74480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CBD972F7E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FD4286AE6
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7E17BB01;
	Tue, 10 Sep 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F63g+D4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE63224F6;
	Tue, 10 Sep 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961929; cv=none; b=HABOPDoeiBwwPw9vJB+kir8r5qQ7qM26Hvchm8VGJntrD6utFbL2Rq+zNy/1mTyAiasNdic8MmbrDvLAl8RsVm9d380xcAT73EvvP8RznNRR3oOrVhEt+8TTKRwJ5EELHhQoqC8ASJgPzRlLoSDDWgWUuiVD+x1x9tLX576w/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961929; c=relaxed/simple;
	bh=kJacjjkSZhq5O5+jxKynx0onfEhoDrV9zVAuzhc51Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaITRRpGA/qXyd/GPU2ZIt7aFseQXOa5lGPNOoHMboWhrEBLO/Q8Arw/lcYr4REKgRw63aVVqUVVMh6T/Swn3ENEiPJR6dDT/7l1FBxPqT6Rfk1F54J9WYV3VNvdfKo15YJAcKqV8K8cF3YdCAqN6zCG3b/aaDr0D0TTdtbZKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F63g+D4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8525AC4CEC3;
	Tue, 10 Sep 2024 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961928;
	bh=kJacjjkSZhq5O5+jxKynx0onfEhoDrV9zVAuzhc51Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F63g+D4h06+3Z+rizg8OBt3VLFp0xh79bs6F5Ywy5YYEQ3WK2wgvDjIuswhPN+kkw
	 sUks0uOvBeMEy0TMPecZAuX5oXWIt+VTXDo7iuY/YnUFZG2GlpRQm2XbqxDChC6gom
	 oepi7YHwdkwbntO1wEysxUCl8Rd2Sy7nG3dkB6uY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zqiang <qiang.zhang1211@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 237/375] smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()
Date: Tue, 10 Sep 2024 11:30:34 +0200
Message-ID: <20240910092630.510273471@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit 77aeb1b685f9db73d276bad4bb30d48505a6fd23 ]

For CONFIG_DEBUG_OBJECTS_WORK=y kernels sscs.work defined by
INIT_WORK_ONSTACK() is initialized by debug_object_init_on_stack() for
the debug check in __init_work() to work correctly.

But this lacks the counterpart to remove the tracked object from debug
objects again, which will cause a debug object warning once the stack is
freed.

Add the missing destroy_work_on_stack() invocation to cure that.

[ tglx: Massaged changelog ]

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240704065213.13559-1-qiang.zhang1211@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..af9b2d0736c8 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1119,6 +1119,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 
 	queue_work_on(cpu, system_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
+	destroy_work_on_stack(&sscs.work);
 
 	return sscs.ret;
 }
-- 
2.43.0




