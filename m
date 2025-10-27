Return-Path: <stable+bounces-191155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A9BC110BA
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A721119C2880
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1F31C584;
	Mon, 27 Oct 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="thMM2SNj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B13274FD0;
	Mon, 27 Oct 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593151; cv=none; b=VneuMzbMflTpf8TTxFZbBfsN6rNYDmO1JRDIM0Se1N2+rTK9pzFIpihf5Ph8J/DgB0V3OQN+kC0DRzbFtqdb42i+elWEiPATc26uhI5ChHybq80Ucb1jy+5U+UP8oVRv8QQs556EfWqWiop85uvNIkdm8DR2Eo3UiCHQh6itwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593151; c=relaxed/simple;
	bh=AuzCwT7mar1ZeStfaBa9lx92xPF2mDia1YZMPlIZhag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKP3o4CC7FTHx0xKeWV+Gttm50M/zplQMJhm1MFe/DttuHbIvELIY09uzdDGrqUf9fihMxXH7Hdwm/OWzcZjqFwDjHshcoDEqrlHaKQtWrguhrqbHBBj6CghpTsGnGApelSx5K7RhsHl3Bpo6CxP4yJZbITt/30tw5PaaBH0VpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=thMM2SNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB029C4CEF1;
	Mon, 27 Oct 2025 19:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761593151;
	bh=AuzCwT7mar1ZeStfaBa9lx92xPF2mDia1YZMPlIZhag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thMM2SNjU/r0FEWdJHLpgqju45iPEiPpDClPJs1pkWkGRvEjg/HqPF7ThFvRuxDNb
	 As81tVNbk6JQPT1snZh7YlGu0+yu+wmxwSUec62x32UzqaEIT8LOHGImYwFEDTUCdh
	 Ch1GdYbYIJ4SmzDI4enyZS7GjDwg/mWqcQmZxGXc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 006/184] exec: Fix incorrect type for ret
Date: Mon, 27 Oct 2025 19:34:48 +0100
Message-ID: <20251027183515.110447705@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
References: <20251027183514.934710872@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xichao Zhao <zhao.xichao@vivo.com>

[ Upstream commit 5e088248375d171b80c643051e77ade6b97bc386 ]

In the setup_arg_pages(), ret is declared as an unsigned long.
The ret might take a negative value. Therefore, its type should
be changed to int.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20250825073609.219855-1-zhao.xichao@vivo.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index a69a2673f6311..1515e0585e259 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -599,7 +599,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
 		    int executable_stack)
 {
-	unsigned long ret;
+	int ret;
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
-- 
2.51.0




