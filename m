Return-Path: <stable+bounces-145923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7136ABFC1B
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 19:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8780C4E77DD
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81806264A63;
	Wed, 21 May 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="j7iiHsA/"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5498264614;
	Wed, 21 May 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847812; cv=none; b=Yu8gX3s0tKiDsSre6sNZw4DruqKy+vMQpS1ToIlMVg/E7hnRJInliXWEm+zefXvWq3XS7yKrKhY1uedpImDfS5xa6zbAgQX32N2IGcyzic2seF4Z255tAg2zHs9mhxYyyxgAvcfJStv/OgF7x1Du+VkcDVQH8DGwZMZ5ya0PDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847812; c=relaxed/simple;
	bh=fWpLvvACEVSDjDTolN7S+h5eTfjZAN5/5xDugxoVK7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AluF1/GsZyJraeqcksoAR89vAbANhSWC4CnGKwfCvXinGSqJSxPZyBNn4we6ZichF9x4urQDuteaL6WnGbbbQCJtH4joSv6gMTPuLHVwdikV7dTLayuSHwZ4TLY1zzr4xKRemfhfTeSrhMaQWrU6EmNJN2PzASS8VAZr2dfdfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=j7iiHsA/; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id ECA5F4017243;
	Wed, 21 May 2025 17:16:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru ECA5F4017243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1747847808;
	bh=BNsdjHd06G7z309kEr7togqzRjGcVaxuLsI5s4ltPlw=;
	h=From:To:Cc:Subject:Date:From;
	b=j7iiHsA/S1rxAgcXTkGdcEV5eq5hnGGX8H+sIu6Ekwsj3shdAwtVZ9TqPf2SYVBhN
	 jd3NJKjr5tSWq6EHp1zCggzSS/oUNlf+jlVvQbqN+agW/NfXrgaJWcDaOpOREAetjB
	 WIlmkZQc7eFGSER8g0c8idt5P/zojVpghHbpMsTk=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.15 0/1] Oopses on module unload seen on 5.15-rc
Date: Wed, 21 May 2025 20:16:33 +0300
Message-ID: <20250521171635.848656-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A followup to the similar patch sent to 6.1.y:
https://lore.kernel.org/stable/20250521165909.834545-1-pchelkin@ispras.ru/

commit 959cadf09dbae7b304f03e039b8d8e13c529e2dd
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Oct 14 10:05:48 2024 -0700

    x86/its: Use dynamic thunks for indirect branches
    
    commit 872df34d7c51a79523820ea6a14860398c639b87 upstream.

being ported to 5.15.y would lead to kernel crashes there after module
unload operations.

As mentioned in the blamed patch comment describing the backport
adaptations:

[ pawan: CONFIG_EXECMEM and CONFIG_EXECMEM_ROX are not supported on
        backport kernel, made changes to use module_alloc() and
        set_memory_*() for dynamic thunks. ]

module_alloc/module_memfree in conjunction with memory protection routines
were used. The allocated memory is vmalloc-based, and it ends up being ROX
upon release inside its_free_mod().

Freeing of special permissioned memory in vmalloc requires its own
handling. VM_FLUSH_RESET_PERMS flag was introduced for these purposes.

In-kernel users dealing with the stuff had to care about this explicitly
before commit 4c4eb3ecc91f ("x86/modules: Set VM_FLUSH_RESET_PERMS in
module_alloc()"). It fixes the current problem.

More recent kernels starting from 6.2 have the commit and are not affected.

Found by Linux Verification Center (linuxtesting.org).

Thomas Gleixner (1):
  x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()

 arch/x86/kernel/ftrace.c       | 2 --
 arch/x86/kernel/kprobes/core.c | 1 -
 arch/x86/kernel/module.c       | 9 +++++----
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.49.0


