Return-Path: <stable+bounces-125274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F8A6904A
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83B9165D81
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C312153C7;
	Wed, 19 Mar 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cYVlVPqe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9261B2194;
	Wed, 19 Mar 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395074; cv=none; b=YX35cATFGDQjD0FdNLumvq0F3oAv1z9bRA7G6TchQnEk+oU6jSzvAiOnW73eJx0lgnMerMN4dyN/4dGENzNZEdS3Jtg48xRKa3c20/vx7m0k+hvH1Jk5z9ridjEXMM5mySFUv606Y26z2CxDPkXZzwwxc6KwwZGaZvbpQTbJY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395074; c=relaxed/simple;
	bh=4ELcdCKXuaYgMxxBR5Ut/nYVmasTN/FhDoAIcERqgSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql0MdjKuUaYRj//NE0Xc8c9q7jID1mZnU4aGlF5y47exgOy1s/W56gZ7i843EiA77R78yOab6ju2BeL/EwMKMYVXjLEAL3msYevsOaizY7UAORMrHGklP7Nehx5uCC2mdt1ig8SpT8/11Ca1C5IDb6bOrhlCZ+Z4JRTy3DAm0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cYVlVPqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D50C4CEE4;
	Wed, 19 Mar 2025 14:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395074;
	bh=4ELcdCKXuaYgMxxBR5Ut/nYVmasTN/FhDoAIcERqgSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYVlVPqeMmsCZckIfGRbitEX3DsJsyqaTVSSGl4jOSQBnQgGx1baa4S3Fuq2DyfRr
	 cGSzPVJ7e7GDDPuuJRKMNW1+Dyp9SBv3PR05vea+ENWi0olhbTyFrbnSimqsdiUmf+
	 lfbTk/ilLHaS/b7lqJoawtBd1jO/4lxhJkQWZR40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Klaus Kusche <klaus.kusche@computerix.info>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 086/231] objtool: Ignore dangling jump table entries
Date: Wed, 19 Mar 2025 07:29:39 -0700
Message-ID: <20250319143028.966465632@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 1691aa6e6ce32..3c3e5760e81b8 100644
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




