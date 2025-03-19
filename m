Return-Path: <stable+bounces-125007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FFA68F7C
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B35B3B12FA
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD71DF96F;
	Wed, 19 Mar 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sU+RuNfr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A51C2DC8;
	Wed, 19 Mar 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394886; cv=none; b=ED+OwQt0uQ6RkOeF5r0uwcMB5GdAxg10/FSuA1sdDLSRwZ0ngqR1i+CBdnltppfGXFrzHU1i3UO47C/WEA62HxIP6+iv74oJtYhrqFL3BRYUjGiO0JglOei5SeBwWWq/iD83rq6JCABrDftW5oQNTssKcxiXbVWK0njQFmP8YEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394886; c=relaxed/simple;
	bh=4+pW2ICK93zOFHQP5zTlFFo/emBngBSM7uzinVJMPP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyorpjUBuGH9lgdiMEajAznRBKf2h2YwRH69VgVZ1nZB1xP89PZOS6/WDawfJ28II415cfQGicMkEGz/RV20yymIr1/dt9GfjYig+a3q/Fpi9KiQo5fhzSSvCIzn6GSVcYWmn61NVoq+h/LxQTvuudoGnzKiap2k4v5KEEPvNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sU+RuNfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BED0C4CEE4;
	Wed, 19 Mar 2025 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394886;
	bh=4+pW2ICK93zOFHQP5zTlFFo/emBngBSM7uzinVJMPP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sU+RuNfr7eV6NXs6ZJIcMCR0Lnsu1PzifRCLHcE3pcaEovD8FOE3yHdTLbUe/2xh8
	 v72WAaPsbB23IoW7DaMMGKSKHb2d69TjL+mHbyh3IQCn8Fbx8FG1BWj0yt8liMCQUC
	 xFl/3TnBItAdEo5I83/m2biZq+pNkd2pZblihaW4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Klaus Kusche <klaus.kusche@computerix.info>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 088/241] objtool: Ignore dangling jump table entries
Date: Wed, 19 Mar 2025 07:29:18 -0700
Message-ID: <20250319143029.903576039@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 3724062ca2b1364f02cf44dbea1a552227844ad1 ]

Clang sometimes leaves dangling unused jump table entries which point to
the end of the function.  Ignore them.

Closes: https://lore.kernel.org/20250113235835.vqgvb7cdspksy5dn@jpoimboe
Reported-by: Klaus Kusche <klaus.kusche@computerix.info>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/ee25c0b7e80113e950bd1d4c208b671d35774ff4.1736891751.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6691bd106e4b6..6f3f408d0a019 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2061,6 +2061,14 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		    reloc_addend(reloc) == pfunc->offset)
 			break;
 
+		/*
+		 * Clang sometimes leaves dangling unused jump table entries
+		 * which point to the end of the function.  Ignore them.
+		 */
+		if (reloc->sym->sec == pfunc->sec &&
+		    reloc_addend(reloc) == pfunc->offset + pfunc->len)
+			goto next;
+
 		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!dest_insn)
 			break;
@@ -2078,6 +2086,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		alt->insn = dest_insn;
 		alt->next = insn->alts;
 		insn->alts = alt;
+next:
 		prev_offset = reloc_offset(reloc);
 	}
 
-- 
2.39.5




