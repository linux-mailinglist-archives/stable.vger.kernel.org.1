Return-Path: <stable+bounces-80526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697F698DE0B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F045B24041
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855731D1303;
	Wed,  2 Oct 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1cp6t0nG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A11D12FF;
	Wed,  2 Oct 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880630; cv=none; b=Y1GEFuWnb24j2Mj2mn2AKlZsZnvoJ0OFsuPB9Cj4F/TauYzQMy7JzOYy3uPPP601WFyoXNH8JUUgxh7gQILA84Jcp57bpyM0EfHKy6QDYyCPP2rgohOXbiZw8tNdXN2U45Fem4dAr2wZP/GHeMFmriPPD8CP1PcypcFAMa4jj5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880630; c=relaxed/simple;
	bh=5hE1GH2Ch4t4L1wlfYsav0KBPlstTAJspgWe0B8tEEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjtYO7Cx8uQ6mmqHe9SKcdVk3is3AtDrPPs/ZMREZ5XrrMAApp9MGkJCWRyGKfMB/fMiie4z68OswPGF/JIF9eOB2DfjSjyAeQoTGms6qF3YFhfq9fs9j+XxfY09Nyx1BVUpyvemf2iiTP6P1Se2okxFxGMS5sF2JHUI8Fz/XXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1cp6t0nG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE448C4CEC2;
	Wed,  2 Oct 2024 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880630;
	bh=5hE1GH2Ch4t4L1wlfYsav0KBPlstTAJspgWe0B8tEEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1cp6t0nGKNCs1npTpfBttJKmTnGosG74Lrw5l98LEoej4zhDjj/6JzLp0B7m5mpNS
	 z5Hqv5F/lMp1AK1ayZ7r4XKTakCuWzvU4xH80JlxYH1sfv6bEDVB0DlbcGWxjcgUGe
	 GMyDmTWmQJlzPvrR9Nc0fCL8ChWWTlUGEe/qaEaA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Vyukov <dvyukov@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: [PATCH 6.6 524/538] module: Fix KCOV-ignored file name
Date: Wed,  2 Oct 2024 15:02:43 +0200
Message-ID: <20241002125813.130077653@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit f34d086fb7102fec895fd58b9e816b981b284c17 upstream.

module.c was renamed to main.c, but the Makefile directive was copy-pasted
verbatim with the old file name.  Fix up the file name.

Fixes: cfc1d277891e ("module: Move all into module/")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/bc0cf790b4839c5e38e2fafc64271f620568a39e.1718092070.git.dvyukov@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/module/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -5,7 +5,7 @@
 
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
-KCOV_INSTRUMENT_module.o := n
+KCOV_INSTRUMENT_main.o := n
 
 obj-y += main.o
 obj-y += strict_rwx.o



