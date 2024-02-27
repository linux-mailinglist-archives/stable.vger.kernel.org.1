Return-Path: <stable+bounces-25223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1FA86984D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC011F21A2D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B314533A;
	Tue, 27 Feb 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HyIL9fhg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E301145323;
	Tue, 27 Feb 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044203; cv=none; b=R8CBlz5YQzo1dpXf/craLO0I4QQzcNldFSaF+CKUWAwdGCAm/k/IH7LLMXxbQVGPYaaIipMpyN8n+odNjgoJS8UurpIhDyymoLM2c84Koh1EuD3zgilWnioN73cWXaoxcS8A4jiKieg5gd7X2y0NfjpyFDRSuvRci7jMfXZjEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044203; c=relaxed/simple;
	bh=s05xvGpT0Iqas6raAqx99dgiGEbf5QU8HFp9e/VCAno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAVP3Uy0zjgJm/PG4GwAotXpDtBjGviCCKn4MsR2m6EiMsDCMXDgc0DnHKbrfGTmnxJIr72os1HxhaT4Hxn9cSsy1kbCbiGWOfHBUcbCaYmJh8tbcaNF+z2N4IsV9jjD0f6IMk48ZGwWiLv2p9U8j0k7CbAQK2PeAdd17EDVOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HyIL9fhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FA4C433C7;
	Tue, 27 Feb 2024 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709044203;
	bh=s05xvGpT0Iqas6raAqx99dgiGEbf5QU8HFp9e/VCAno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyIL9fhgWzPv8C3wMlXTcQxVCyCpjhg0gMX9Cl1QwPkajsH0NQXyKP5kCpgMPNF/b
	 Y1T8i7+mv/QUhLq4eqBaVgacdF82Y0StH3rqPZVgdXBU/Hq0KcatdC2kzf7MqbaaBy
	 56nQTfwsEODXvYVSAAFU2d7Dy9umfwvkeJtortqA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Beulich <jbeulich@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.10 072/122] x86: drop bogus "cc" clobber from __try_cmpxchg_user_asm()
Date: Tue, 27 Feb 2024 14:27:13 +0100
Message-ID: <20240227131601.060295350@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
References: <20240227131558.694096204@linuxfoundation.org>
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

From: Jan Beulich <jbeulich@suse.com>

commit 1df931d95f4dc1c11db1123e85d4e08156e46ef9 upstream.

As noted (and fixed) a couple of times in the past, "=@cc<cond>" outputs
and clobbering of "cc" don't work well together. The compiler appears to
mean to reject such, but doesn't - in its upstream form - quite manage
to yet for "cc". Furthermore two similar macros don't clobber "cc", and
clobbering "cc" is pointless in asm()-s for x86 anyway - the compiler
always assumes status flags to be clobbered there.

Fixes: 989b5db215a2 ("x86/uaccess: Implement macros for CMPXCHG on user addresses")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Message-Id: <485c0c0b-a3a7-0b7c-5264-7d00c01de032@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/uaccess.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -471,7 +471,7 @@ do {									\
 		       [ptr] "+m" (*_ptr),				\
 		       [old] "+a" (__old)				\
 		     : [new] ltype (__new)				\
-		     : "memory", "cc");					\
+		     : "memory");					\
 	if (unlikely(__err))						\
 		goto label;						\
 	if (unlikely(!success))						\



