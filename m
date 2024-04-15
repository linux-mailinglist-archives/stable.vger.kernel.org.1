Return-Path: <stable+bounces-39892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C221A8A5535
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22BD1C221CD
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55574C02;
	Mon, 15 Apr 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMJABVGH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8921E52A;
	Mon, 15 Apr 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192130; cv=none; b=iVwCdM1G4/z3qxzetPJMImwQx0DsDPCNbaWKZ2dSg77yxOzBQQnSOv9lm4JzShmcof24UJFZARD690R24ohXbNal3VL63+4i/sPw8JGLMQONCuEjh37W7IsiZSTFZcWvGe3PPRB3kSil/j6+GMhT6SuoRWngrqqTUuXqwqqgH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192130; c=relaxed/simple;
	bh=fR6dtQUMSIaroyy1OOFxhknNXLCYjtRAaKvbTRvUaFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkbFAebzF8OyHyswxtt6ts8qMeIQ8BCalH6zUj7R0F5YvM8l6e6Y5ZW+CjF0qWFwO3vvQRvveemw2EzNTpchfrD0w/O3FMzKazjtyYD6CKCp/DwJwLWaXVfkEC1j46AbqWRWAhkXa4tLLteUyxiItTKlKZJkpzj1up96rro6LU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMJABVGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AD7C113CC;
	Mon, 15 Apr 2024 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192130;
	bh=fR6dtQUMSIaroyy1OOFxhknNXLCYjtRAaKvbTRvUaFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMJABVGH0qavfTbt9WniFjlaly1B64QaNqkjWdH3UHau+gfeWc7/DIfcnQHoT92fu
	 3QlxlnEGslSoDB50HaLdNTrm6WRLEvcN4sdm+86bF9WUJ4CC8L46AOXiX5w3Q2o50m
	 2JzRJmTY9ut7UH58nRi7x8TY+6naFzD90Ro/4HyA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.1 57/69] x86/bugs: Fix return type of spectre_bhi_state()
Date: Mon, 15 Apr 2024 16:21:28 +0200
Message-ID: <20240415141947.886658118@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
References: <20240415141946.165870434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Sneddon <daniel.sneddon@linux.intel.com>

commit 04f4230e2f86a4e961ea5466eda3db8c1762004d upstream.

The definition of spectre_bhi_state() incorrectly returns a const char
* const. This causes the a compiler warning when building with W=1:

 warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
 2812 | static const char * const spectre_bhi_state(void)

Remove the const qualifier from the pointer.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240409230806.1545822-1-daniel.sneddon@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2788,7 +2788,7 @@ static char *pbrsb_eibrs_state(void)
 	}
 }
 
-static const char * const spectre_bhi_state(void)
+static const char *spectre_bhi_state(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_BHI))
 		return "; BHI: Not affected";



