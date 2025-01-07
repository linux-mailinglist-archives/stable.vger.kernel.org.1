Return-Path: <stable+bounces-107884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F035DA048FC
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 19:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70D1162650
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874FA1F37D5;
	Tue,  7 Jan 2025 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmedMuqu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B918BBBB
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273427; cv=none; b=qWP9THD5ScXUqsYkOKQPwHUYfX4Guqk/0e9FqKVO8vR3d7UjzYy1eBWgFfwoaDF8eU3anbEffyyPP2BAGDUWoJt7Q5f5HYB5MR6FSLxvh4i1r8fBixKrppEXH2IX4WxvtlGM+6getlV+a+lIAjCBxGJxHSyjLzsxXNQuDymXSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273427; c=relaxed/simple;
	bh=zOld9jP1i+Z4BZqa9he7zeaJ/gEucv2bP3au7vmugGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKMTyScxkwt7nQU29hdClpVSYy3YVizEwdBnf23VfsJm++QEwN/yw9mxla5Itx8TTFEyUVx5EyUoOSf5NcyrsyYUtPDtkOr3JU4mEetzsFzBDYh3VFvYfvkS06kSQCEEleXVzFyf0BP/7EjlKYPLHvRHW2ckyhJPlF/KWXcs1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmedMuqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385E6C4CEDE;
	Tue,  7 Jan 2025 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273426;
	bh=zOld9jP1i+Z4BZqa9he7zeaJ/gEucv2bP3au7vmugGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MmedMuqukCU7JX5yCL/wR/pVhQAEMrUhM4d7Lno2fUeEN4rNAhxfZdEs7lXcfSUG8
	 oJ02g/8du7/XaJD8xEYro6rdcQ1NQO4WT0Gg9I4rc0gJLWl2XLwxL55BnGj0E4C7iY
	 O9Wi/PCY9x1aE5ZdVceMMAxX8ahY13XDVEcgogankx2dbbuJy5yig0rF1dnnHJB1Lq
	 BDtNteJ1AIVKTzdP3Vji/yJFo3oloFwwapXgWMsrXKCDtMoQf1vi3tamQbIqy48Zo6
	 1i/vxCQa61jlMmkTthUmCT5yjhjGuI2rlfRky++uj5uUq55bjWlw0kwXBiOCEKTEoq
	 vqxaYOixhAzdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
Date: Tue,  7 Jan 2025 13:10:24 -0500
Message-Id: <20250107081951-5ffddac33b0d6e1e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250106175731.3308310-1-visitorckw@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 0210d251162f4033350a94a43f95b1c39ec84a90


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0210d251162f ! 1:  e4b874815eaf scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
    @@ Commit message
     
         The orc_sort_cmp() function, used with qsort(), previously violated the
         symmetry and transitivity rules required by the C standard.  Specifically,
    -    when both entries are ORC_TYPE_UNDEFINED, it could result in both a < b
    +    when both entries are ORC_REG_UNDEFINED, it could result in both a < b
         and b < a, which breaks the required symmetry and transitivity.  This can
         lead to undefined behavior and incorrect sorting results, potentially
         causing memory corruption in glibc implementations [1].
    @@ Commit message
         Transitivity: If x < y and y < z, then x < z.
     
         Fix the comparison logic to return 0 when both entries are
    -    ORC_TYPE_UNDEFINED, ensuring compliance with qsort() requirements.
    +    ORC_REG_UNDEFINED, ensuring compliance with qsort() requirements.
     
         Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
         Link: https://lkml.kernel.org/r/20241226140332.2670689-1-visitorckw@gmail.com
    @@ Commit message
         Cc: Steven Rostedt <rostedt@goodmis.org>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 0210d251162f4033350a94a43f95b1c39ec84a90)
    +    Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
     
      ## scripts/sorttable.h ##
     @@ scripts/sorttable.h: static inline unsigned long orc_ip(const int *ip)
    @@ scripts/sorttable.h: static inline unsigned long orc_ip(const int *ip)
      	const int *b = g_orc_ip_table + *(int *)_b;
      	unsigned long a_val = orc_ip(a);
     @@ scripts/sorttable.h: static int orc_sort_cmp(const void *_a, const void *_b)
    + 	 * These terminator entries exist to handle any gaps created by
      	 * whitelisted .o files which didn't get objtool generation.
      	 */
    - 	orc_a = g_orc_table + (a - g_orc_ip_table);
    +-	orc_a = g_orc_table + (a - g_orc_ip_table);
    +-	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
    ++ 	orc_a = g_orc_table + (a - g_orc_ip_table);
     +	orc_b = g_orc_table + (b - g_orc_ip_table);
    -+	if (orc_a->type == ORC_TYPE_UNDEFINED && orc_b->type == ORC_TYPE_UNDEFINED)
    ++	if (orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end &&
    ++	    orc_b->sp_reg == ORC_REG_UNDEFINED && !orc_b->end)
     +		return 0;
    - 	return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;
    ++ 	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
      }
      
    + static void *sort_orctable(void *arg)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

