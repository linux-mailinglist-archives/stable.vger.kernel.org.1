Return-Path: <stable+bounces-104603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F429F51F8
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D887A2151
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7B1F8679;
	Tue, 17 Dec 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ei86El//"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C971F7562;
	Tue, 17 Dec 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455552; cv=none; b=uHgkCkjXbFFobRr/g/7IhRPTmHHE1x83NnB3gQEZCB7FEFIHpg4bmCmr8uLFpjmpgtwC1ABHDngV6fWvJ9uhSkOd60g39B2XWUJvx0NVlQ1waWGwfd5GLmix8VVDvrHn/XpPftDfKRoHJPpez6jqzpxLsYpm7hRLOzp2yV6yyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455552; c=relaxed/simple;
	bh=D9NSRIs2WhMqoKpsPTmPDhvjFIAaxLrhJEFSHwezOb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAuxL+y/EIDMbpgf+swc5CJG3APy1K2+kTvXFRP0yks2DLm/I1UOzs+IbNCdj13iAuNDIyvGAckX7Ju4g5fZqjmzHXDErQ0t58RmesGuw+hvD6cddOppvpdJKL2jtTtsC7LD+t06Idct9lHB8o7RD2XPCl2/zXtUSbPFO+cpW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ei86El//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDF2C4CEE2;
	Tue, 17 Dec 2024 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455552;
	bh=D9NSRIs2WhMqoKpsPTmPDhvjFIAaxLrhJEFSHwezOb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ei86El//9U3/W6PixpyamwuZP6wytiB8JFMMw57/A0QjoNCiSJ9i8z3cCZIKLRkTk
	 SGaOTlJ4Q4xkPCKQXay/pmr7w2UatGk/T39jLcqM8gIRMCUSAUK9f8ZvLf7oskNu16
	 Ho8ieqaE3ffrPMHzBG9KfJERhZJf79ihd1R7vIIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.10 37/43] objtool/x86: allow syscall instruction
Date: Tue, 17 Dec 2024 18:07:28 +0100
Message-ID: <20241217170522.203874032@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170520.459491270@linuxfoundation.org>
References: <20241217170520.459491270@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit dda014ba59331dee4f3b773a020e109932f4bd24 upstream.

The syscall instruction is used in Xen PV mode for doing hypercalls.
Allow syscall to be used in the kernel in case it is tagged with an
unwind hint for objtool.

This is part of XSA-466 / CVE-2024-53241.

Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/check.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3039,10 +3039,13 @@ static int validate_branch(struct objtoo
 			break;
 
 		case INSN_CONTEXT_SWITCH:
-			if (func && (!next_insn || !next_insn->hint)) {
-				WARN_FUNC("unsupported instruction in callable function",
-					  sec, insn->offset);
-				return 1;
+			if (func) {
+				if (!next_insn || !next_insn->hint) {
+					WARN_FUNC("unsupported instruction in callable function",
+						  sec, insn->offset);
+					return 1;
+				}
+				break;
 			}
 			return 0;
 



