Return-Path: <stable+bounces-13709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED0837D80
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCE6286E84
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C65C8EF;
	Tue, 23 Jan 2024 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0CdGagPN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26434E1D8;
	Tue, 23 Jan 2024 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969988; cv=none; b=EGOE3oiKmnqaCR5Be3ZayDw2fPCxcDjF4dVLcinNpI+FS1sx/Qt6dxErmTJToc1fteC9yrbL80GkKxaE0SPoJ+Znmwy2TzX8TbPIbIrROqawuZny2nc/Z5P7NIFu/aquzCGwAGxOYeYjNX/rObs71HtgZYKQPV2Y1Md2vymghqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969988; c=relaxed/simple;
	bh=iWkH9lJynFBQlr4UE20U8wFdygMYEhlnRX2b9Tg/wrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sz43MuDgKQvs7FcbVgSQrWcdXIMZal7MUr0E3DM15t0ckgEQBp68+rYtWdGtnqVz76qee9v+1PfxKc7aGUMBtB+GIFYWzkbjg8SKpazY6YpwfcdiYfqbU1zw2ht2TgFMpIjy+hkgcZKqH41KbuAhIfInG+hf/l/SOupRahF+v9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0CdGagPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75093C433F1;
	Tue, 23 Jan 2024 00:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969987;
	bh=iWkH9lJynFBQlr4UE20U8wFdygMYEhlnRX2b9Tg/wrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0CdGagPNzKbaJBgrsayJpEzGnWNKR9uctF07Faay3lQdSXI0nhkugFACpqa24lQuU
	 jEdKtr/0qnBZ//zVBZFwIx29i5b7bBVjU1mII7AqMDZjgma1acSBgICXucXh2UkZwI
	 tlpDmPM375QqqOnmBWoFrePcahmW63NncQNmMdcU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 552/641] apparmor: Fix ref count leak in task_kill
Date: Mon, 22 Jan 2024 15:57:36 -0800
Message-ID: <20240122235835.420872938@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit 2cb54a19ac7153b9a26a72098c495187f64c2276 ]

apparmor_task_kill was not putting the task_cred reference tc, or the
cred_label reference tc when dealing with a passed in cred, fix this
by using a single fn exit.

Fixes: 90c436a64a6e ("apparmor: pass cred through to audit info.")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4981bdf02993..608a849a7468 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -954,7 +954,6 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
 		cl = aa_get_newest_cred_label(cred);
 		error = aa_may_signal(cred, cl, tc, tl, sig);
 		aa_put_label(cl);
-		return error;
 	} else {
 		cl = __begin_current_label_crit_section();
 		error = aa_may_signal(current_cred(), cl, tc, tl, sig);
-- 
2.43.0




