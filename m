Return-Path: <stable+bounces-126964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35306A750BD
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 20:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC1917655D
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 19:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7861E04B9;
	Fri, 28 Mar 2025 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm2LZMxC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5F1537A7;
	Fri, 28 Mar 2025 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190007; cv=none; b=p9y76pbRODanw7g4vJwXoIacKrvBobhO1Lu2TB0xhiW55TaELMfLdZoXOlk4UjxH2FICX+7xYimV1n+SPzaw7j9c7hYDXTpKXN9KeUc3bQxtsoy4XVFO+X4bw8I61n71Edw7pQJmTX37XwFBk+vmZZsM7jeXS4V+FSn1eh3Cuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190007; c=relaxed/simple;
	bh=JNRQiP8x2T6lr/cpXu/ktLllk3HPQgUE+Ivnd7EMXUY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O9f2nIHHGOPMk45foFU5cmh8PEozGEWGQmQRBeQR0YWCJ0HlFnia354tUA7Z4Gdu3UTVD5DBai30cMl1JG6fmoXa53u1facFFDfkmOmEOyjcK4cDto6PgDlrI3858xpBQDCEfkkaWkqDSbrU2AyuunZlH+ARKPyxbCc9++ZsUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm2LZMxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31D4C4CEE4;
	Fri, 28 Mar 2025 19:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743190006;
	bh=JNRQiP8x2T6lr/cpXu/ktLllk3HPQgUE+Ivnd7EMXUY=;
	h=From:Subject:Date:To:Cc:From;
	b=qm2LZMxCob/cxdar/2ug+1NYh3kiEDfLszNp9WaeRJkoqi3qaJ+cC+IZzZWDaDQjI
	 tDqOvypao2tQauzs4T+dCnTUXnlH2gq1lbik+1DG1Rb2A7igT5C6bowwN/P8s14FSs
	 m25g+6iOdVFN71MxpSCfN0oHY0SHxmNdEmpG+YAA2kKPBJg3hFHd5/XHGVNsTAImbQ
	 8QPHlOXXzVEVp4XpgPQzmr1eoW8J8i4Pvx0bsR70T06NiYkBNFRBNkCkCWAIRzV1kd
	 jmd6CGAYk2u4zxMB15hXG+NYPkTKeRdUcul0xeTHOfaB8Q8H3XOTmRcQNyiOo+MBNr
	 rRyGVLYfxvnRw==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 0/2] Add wcslen()
Date: Fri, 28 Mar 2025 12:26:30 -0700
Message-Id: <20250328-string-add-wcslen-for-llvm-opt-v3-0-a180b4c0c1c4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOb35mcC/4XNSw7CIBSF4a00jL0G6Is6ch/GQQuXllihgQY1T
 fcubWKiI4f/GXxnIQG9wUBO2UI8RhOMsynyQ0bk0NoewajUhFNe0pwXEGZvbA+tUvCQYUQL2nk
 Yx3gHN81Q07JumOoaLilJyORRm+d+cLmmHkyYnX/tf5Ft64cu/9GRAYVOaIZcsloIcb6htzgen
 e/JZkf+7VV/PZ48Jaqi7bjsNBY/3rqub4znF2gdAQAA
X-Change-ID: 20250324-string-add-wcslen-for-llvm-opt-705791db92c0
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=nathan@kernel.org;
 h=from:subject:message-id; bh=JNRQiP8x2T6lr/cpXu/ktLllk3HPQgUE+Ivnd7EMXUY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOnPvn9uVXYOSWxeKTg35IFVnP1z+QXLi2+uP1DC/kzmt
 9UTwc3tHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiTesYGTo0g/Sao2fvtdm2
 zNFSZ9F77oCKvR++64iHnD70euLsKfmMDHc3LqwxUlH3S7df3ZO3deqBE+FeHY/+M//+m2QsGed
 vwwUA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

A recent LLVM change [1] introduces a call to wcslen() in
fs/smb/client/smb2pdu.c through UniStrcat() via
alloc_path_with_tree_prefix(). Similar to the bcmp() and stpcpy()
additions that happened in 5f074f3e192f and 1e1b6d63d634, add wcslen()
to fix the linkage failure.

[1]: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d

---
Changes in v3:
- During comment shuffle in patch 1, move to standard multi-line comment
  kernel style (Andy). Carry forward Andy's review.
- Move nls_types.h include in string.c in patch 2 to a better place
  alphabetically (Andy).
- Drop 'extern' from wcslen() declaration in string.h, as external linkage
  is the default for functions and the coding style explicitly forbids
  it (Andy).
- Link to v2: https://lore.kernel.org/r/20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org

Changes in v2:
- Refactor typedefs from nls.h into nls_types.h to make it safe to
  include in string.h, which may be included in many places throughout
  the kernel that may not like the other stuff nls.h brings in:
  https://lore.kernel.org/202503260611.MDurOUhF-lkp@intel.com/
- Drop libstub change due to the above change, as it is no longer
  necessary.
- Move prototype shuffle of patch 2 into the patch that adds wcslen()
  (Andy)
- Use new nls_types.h in string.{c,h}
- Link to v1: https://lore.kernel.org/r/20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org

---
Nathan Chancellor (2):
      include: Move typedefs in nls.h to their own header
      lib/string.c: Add wcslen()

 include/linux/nls.h       | 19 +------------------
 include/linux/nls_types.h | 26 ++++++++++++++++++++++++++
 include/linux/string.h    |  2 ++
 lib/string.c              | 11 +++++++++++
 4 files changed, 40 insertions(+), 18 deletions(-)
---
base-commit: 78ab93c78fb31c5dfe207318aa2b7bd4e41f8dba
change-id: 20250324-string-add-wcslen-for-llvm-opt-705791db92c0

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


