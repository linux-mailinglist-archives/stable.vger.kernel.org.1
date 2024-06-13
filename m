Return-Path: <stable+bounces-51349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF7906F89
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3211C22503
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9120214198E;
	Thu, 13 Jun 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OCG1Goqg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A3137914;
	Thu, 13 Jun 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281036; cv=none; b=WIX86kvMxpHQSnT24l+krPAMM28c2SCQOCeahD6MIldwnsVdgWuq94Vfy0HscGLG/BczUXbvVM+PjQMSfC6ommGl+rKAKgU/N+9xqbHqA4pnTRG3HqrcobI5im9lWm1I6i7+4ovS8LfPzwFaOe44sx8Al6KVDf1mEriTJA/d2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281036; c=relaxed/simple;
	bh=CEZzpOiI+4i3xMbOJpBGML9cVTx4HoZZSa8i1+M78jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0K+c2WJLcpDDYmCZ4Keep5x/tUN/rwvZuBGgirJ07eaAOGxfymhHv+uQSxMHQigsd0ayAxStp5syCjDc1qSySamOWKPJNFys5lMNHnhLKeJFlWGQDIhNcBSucmIve83hxHxp3uTSrR1FD5+6gzCXekJKBAfSqzEITZ8pGVlMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OCG1Goqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C855CC2BBFC;
	Thu, 13 Jun 2024 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281036;
	bh=CEZzpOiI+4i3xMbOJpBGML9cVTx4HoZZSa8i1+M78jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCG1GoqgTk4l7YW0prWEe1Id9BNpyb7/TOf1tRcaLs4SXNfxfjK5LyH99TIQC6pq4
	 y1vnSgPuE6TsRAcnuOdIeBdeWoD+litiafWjn1Szi75ujEm+X+FWGDPlzKdDvPy5/0
	 guvsORtMHchIiQ4zZo7TwdpeDMcSC71AUJu3KKiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 118/317] x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map
Date: Thu, 13 Jun 2024 13:32:16 +0200
Message-ID: <20240613113252.116584033@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 59162e0c11d7257cde15f907d19fefe26da66692 ]

The x86 instruction decoder is used not only for decoding kernel
instructions. It is also used by perf uprobes (user space probes) and by
perf tools Intel Processor Trace decoding. Consequently, it needs to
support instructions executed by user space also.

Opcode 0x68 PUSH instruction is currently defined as 64-bit operand size
only i.e. (d64). That was based on Intel SDM Opcode Map. However that is
contradicted by the Instruction Set Reference section for PUSH in the
same manual.

Remove 64-bit operand size only annotation from opcode 0x68 PUSH
instruction.

Example:

  $ cat pushw.s
  .global  _start
  .text
  _start:
          pushw   $0x1234
          mov     $0x1,%eax   # system call number (sys_exit)
          int     $0x80
  $ as -o pushw.o pushw.s
  $ ld -s -o pushw pushw.o
  $ objdump -d pushw | tail -4
  0000000000401000 <.text>:
    401000:       66 68 34 12             pushw  $0x1234
    401004:       b8 01 00 00 00          mov    $0x1,%eax
    401009:       cd 80                   int    $0x80
  $ perf record -e intel_pt//u ./pushw
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.014 MB perf.data ]

 Before:

  $ perf script --insn-trace=disasm
  Warning:
  1 instruction trace errors
           pushw   10349 [000] 10586.869237014:            401000 [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           pushw $0x1234
           pushw   10349 [000] 10586.869237014:            401006 [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           addb %al, (%rax)
           pushw   10349 [000] 10586.869237014:            401008 [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           addb %cl, %ch
           pushw   10349 [000] 10586.869237014:            40100a [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           addb $0x2e, (%rax)
   instruction trace error type 1 time 10586.869237224 cpu 0 pid 10349 tid 10349 ip 0x40100d code 6: Trace doesn't match instruction

 After:

  $ perf script --insn-trace=disasm
             pushw   10349 [000] 10586.869237014:            401000 [unknown] (./pushw)           pushw $0x1234
             pushw   10349 [000] 10586.869237014:            401004 [unknown] (./pushw)           movl $1, %eax

Fixes: eb13296cfaf6 ("x86: Instruction decoder API")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240502105853.5338-3-adrian.hunter@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/x86-opcode-map.txt       | 2 +-
 tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323d..1c25c1072a84d 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323d..1c25c1072a84d 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
-- 
2.43.0




