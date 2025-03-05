Return-Path: <stable+bounces-121072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4997AA509D6
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA5A7A9902
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAC525332E;
	Wed,  5 Mar 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUqWJ4NS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB475253330;
	Wed,  5 Mar 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198801; cv=none; b=jWxrACH1nsDdYgxnCVJqL7Umr/8Ljzked4rOvI38IR+4qo2BapdGUNs/E3G/ZwtKuoz5efmkhKg+dgg1n2XJ3KnCIZkQxtb7W1POnkIsefnBdcT2ZgnUqfRWBiu1It+x2SAB1Tpjx/HHBHnhlOo6aOH3qYTKzI3Z05mkqMVErIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198801; c=relaxed/simple;
	bh=kuErDEZZohm1L4TBTWyhxmLn08Cank4Q798xvHXjHwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc1X1e29y88SCZapf9BAqLSsMF2z0bRjqKMn2PXahx7CXyNJqKK29qm9fFukbbRVg5bw2Ow3waDh+uKCqDxmSxdtF9sGyzZ7BfmtaLD2+4ClvApg7sIgVYY6VpK+YV8ln07xDvXevrmqXahh1b2Fzpf7HB/nd+OdvJi5opfIsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUqWJ4NS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300F4C4CED1;
	Wed,  5 Mar 2025 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198801;
	bh=kuErDEZZohm1L4TBTWyhxmLn08Cank4Q798xvHXjHwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUqWJ4NSa/WedeuTOjEvK7bTsk6ZNvB3aHi/7yinEX1yw8z5VJszrlpXq6+Y5k/Hg
	 CMwQmhDUlWbv2Cxzprp/XiGgaxFK0sUwyu1hEj2CDV/iJFCU90SX6luNWei4BOjdk1
	 cewkQ9wCtz64VqWZoS0Mo0O1GlXr4Jl9mIfQgj64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.13 152/157] x86/microcode/AMD: Remove ugly linebreak in __verify_patch_section() signature
Date: Wed,  5 Mar 2025 18:49:48 +0100
Message-ID: <20250305174511.398682504@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
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

From: "Borislav Petkov (AMD)" <bp@alien8.de>

commit 7103f0589ac220eac3d2b1e8411494b31b883d06 upstream.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250211163648.30531-2-bp@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/amd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -246,8 +246,7 @@ static bool verify_equivalence_table(con
  * On success, @sh_psize returns the patch size according to the section header,
  * to the caller.
  */
-static bool
-__verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
+static bool __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
 {
 	u32 p_type, p_size;
 	const u32 *hdr;



