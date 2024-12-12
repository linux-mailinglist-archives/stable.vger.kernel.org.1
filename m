Return-Path: <stable+bounces-102998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E59EF5FD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2906C189C86F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29182226542;
	Thu, 12 Dec 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xjb3ukYP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704D226529;
	Thu, 12 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023231; cv=none; b=CIFiQMrsajw6AdUWscHjsND8FqVbXB+pm61G6ZIS/6c64RW10mMYMJqY+bBK/UVOZ93+UtT+/Is6dcwJ5tK2osE52N7EXwpBlAYmxH0diL3df07QxHINhVoM4Ydgj3nROkJ4qBU7bGXu35kqTP274GL0U2vZBpUSxd4ng15Y2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023231; c=relaxed/simple;
	bh=SBjDsIjB4jYz61oVTYdqKwFm6/iSoR6F6hSUhBLKOXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1Kxh/eKScLr0Nfz5DTee1HR69DLsSZmWiblatRIS+31JelfEGsIx9u3l4dcJT1TeTGq7JWDuQsHeYGcbyIMTL3QcMns/Bi8z7s8b88qB2kpkooD2IG1a9ABVQSkliukRVTlvKxuqOfI4kzk+vm+0oS0xFV3063gXFNEtlZJ1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xjb3ukYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F61DC4CECE;
	Thu, 12 Dec 2024 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023231;
	bh=SBjDsIjB4jYz61oVTYdqKwFm6/iSoR6F6hSUhBLKOXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xjb3ukYPHZJeHYYRL9Nv5vj2WQe3ypdofdWHXZGTHxY2rAroZizAaInaLkWRUh854
	 eu53DO7ZlIAQpza9O0sVohgVSkCpVP8jn5o0f+SM6WjovcVnKd9Eu31z1GXBIWqVXd
	 f6Ycc/mxKZv6rNpRZ/plSJ3/2rISiEoYWxmtM6Ho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.15 449/565] arm64: ptrace: fix partial SETREGSET for NT_ARM_TAGGED_ADDR_CTRL
Date: Thu, 12 Dec 2024 16:00:44 +0100
Message-ID: <20241212144329.466797149@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit ca62d90085f4af36de745883faab9f8a7cbb45d3 upstream.

Currently tagged_addr_ctrl_set() doesn't initialize the temporary 'ctrl'
variable, and a SETREGSET call with a length of zero will leave this
uninitialized. Consequently tagged_addr_ctrl_set() will consume an
arbitrary value, potentially leaking up to 64 bits of memory from the
kernel stack. The read is limited to a specific slot on the stack, and
the issue does not provide a write mechanism.

As set_tagged_addr_ctrl() only accepts values where bits [63:4] zero and
rejects other values, a partial SETREGSET attempt will randomly succeed
or fail depending on the value of the uninitialized value, and the
exposure is significantly limited.

Fix this by initializing the temporary value before copying the regset
from userspace, as for other regsets (e.g. NT_PRSTATUS, NT_PRFPREG,
NT_ARM_SYSTEM_CALL). In the case of a zero-length write, the existing
value of the tagged address ctrl will be retained.

The NT_ARM_TAGGED_ADDR_CTRL regset is only visible in the
user_aarch64_view used by a native AArch64 task to manipulate another
native AArch64 task. As get_tagged_addr_ctrl() only returns an error
value when called for a compat task, tagged_addr_ctrl_get() and
tagged_addr_ctrl_set() should never observe an error value from
get_tagged_addr_ctrl(). Add a WARN_ON_ONCE() to both to indicate that
such an error would be unexpected, and error handlnig is not missing in
either case.

Fixes: 2200aa7154cb ("arm64: mte: ptrace: Add NT_ARM_TAGGED_ADDR_CTRL regset")
Cc: <stable@vger.kernel.org> # 5.10.x
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20241205121655.1824269-2-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/ptrace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1075,7 +1075,7 @@ static int tagged_addr_ctrl_get(struct t
 {
 	long ctrl = get_tagged_addr_ctrl(target);
 
-	if (IS_ERR_VALUE(ctrl))
+	if (WARN_ON_ONCE(IS_ERR_VALUE(ctrl)))
 		return ctrl;
 
 	return membuf_write(&to, &ctrl, sizeof(ctrl));
@@ -1089,6 +1089,10 @@ static int tagged_addr_ctrl_set(struct t
 	int ret;
 	long ctrl;
 
+	ctrl = get_tagged_addr_ctrl(target);
+	if (WARN_ON_ONCE(IS_ERR_VALUE(ctrl)))
+		return ctrl;
+
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl, 0, -1);
 	if (ret)
 		return ret;



