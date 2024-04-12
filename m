Return-Path: <stable+bounces-39289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D38A2B39
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D841C23113
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE545027F;
	Fri, 12 Apr 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whT1ltKc"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8AB524B4
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914255; cv=none; b=inTJKXEX3fwnHNLRfNWPt3RbsU3xH+kABj2I80LMeG/KNXIKQasRNDIsLiQx/3jzuS4jRhzZusTcPuzRKE6VxTj/nV0dRGW+1cimC+TnqebJQWz6KyUM7LBjvlbe9RBR4oTR/9quKZ5on/Q4EEag0/fLq8GkpkFSicq9OArF66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914255; c=relaxed/simple;
	bh=3cPpFl4Rz3bxVTl0yk8EApFN9Movr3DUA2vA+KwCKbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZjUX7uITaqDo5D4g/m54dn0ByXV+58EibnNDuxg6e3uVMItqXnmWtq8UJarCwq+GyoHD2VBh5JpgDb3bV5ucoBsOOeLSO2a9NDyRWwEoh+YfbM9FEpy1YJmO1cQ11KiziUVzRODX7WyL944aFilBWHDlGddJ26gQ38ToT5Wn/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=whT1ltKc; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712914251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QlMOAglt3KtAFBRNDg7nG2bsafC0IjNhI150WhnZFqI=;
	b=whT1ltKc3iDFr9NjnAxW7L5Da5ZtnjuPwCAcauwHc2eFk4sOeagSUBzpBZUoVuaD38+EYN
	bX+JYkEWi0FckjiVynpy7mAzF77+Cvt8jc8USb4NRqduzaiqytLrpH0w/nI4CKR7u4CkIh
	Oi04V23abXuhmyqS8Y1S9TOfO878IJE=
From: George Guo <dongtai.guo@linux.dev>
To: tom.zanussi@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4.19.y v4 0/2] Double-free bug discovery on testing trigger-field-variable-support.tc
Date: Fri, 12 Apr 2024 17:30:39 +0800
Message-Id: <20240412093041.2334396-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

1) About v4-0001-tracing-Remove-hist-trigger-synth_var_refs.patch:

The reason I am backporting this patch is that no one found the double-free bug
at that time, then later the code was removed on upstream, but
4.19-stable has the bug.

This is tested via "./ftracetest test.d/trigger/inter-event/
trigger-field-variable-support.tc"
==================================================================
BUG: KASAN: use-after-free in destroy_hist_field+0x115/0x140
Read of size 4 at addr ffff888012e95318 by task ftracetest/1858

CPU: 1 PID: 1858 Comm: ftracetest Kdump: loaded Tainted: GE 4.19.90-89 #24
Source Version: Unknown
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0
Call Trace:
 dump_stack+0xcb/0x10b
 print_address_description.cold+0x54/0x249
 kasan_report_error.cold+0x63/0xab
 ? destroy_hist_field+0x115/0x140
 __asan_report_load4_noabort+0x8d/0xa0
 ? destroy_hist_field+0x115/0x140
 destroy_hist_field+0x115/0x140
 destroy_hist_data+0x4e4/0x9a0
 event_hist_trigger_free+0x212/0x2f0
 ? update_cond_flag+0x128/0x170
 ? event_hist_trigger_func+0x2880/0x2880
 hist_unregister_trigger+0x2f2/0x4f0
 event_hist_trigger_func+0x168c/0x2880
 ? tracing_map_read_var_once+0xd0/0xd0
 ? create_key_field+0x520/0x520
 ? __mutex_lock_slowpath+0x10/0x10
 event_trigger_write+0x2f4/0x490
 ? trigger_start+0x180/0x180
 ? __fget_light+0x369/0x5d0
 ? count_memcg_event_mm+0x104/0x2b0
 ? trigger_start+0x180/0x180
 __vfs_write+0x81/0x100
 vfs_write+0x1e1/0x540
 ksys_write+0x12a/0x290
 ? __ia32_sys_read+0xb0/0xb0
 ? __close_fd+0x1d3/0x280
 do_syscall_64+0xe3/0x2d0
 entry_SYSCALL_64_after_hwframe+0x5c/0xc1
RIP: 0033:0x7efdd342ee04
Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48
8d 05 39 34 0c 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff
ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
RSP: 002b:00007ffda01f5e08 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000000000b4 RCX: 00007efdd342ee04
RDX: 00000000000000b4 RSI: 000055c5b41b1e90 RDI: 0000000000000001
RBP: 000055c5b41b1e90 R08: 000000000000000a R09: 0000000000000000
R10: 000000000000000a R11: 0000000000000246 R12: 00007efdd34ed5c0
R13: 00000000000000b4 R14: 00007efdd34ed7c0 R15: 00000000000000b4
==================================================================

2) About v4-0002-tracing-Use-var_refs-for-hist-trigger-reference-c.patch: 

Only v4-0001-tracing-Remove-hist-trigger-synth_var_refs.patch will lead
to compilation errors:

../kernel/trace/trace_events_hist.c: In function ‘find_var_ref’:
../kernel/trace/trace_events_hist.c:1364:36: error: ‘struct hist_trigger_data’ has no member named ‘n_synth_var_refs’; did you mean ‘n_var_refs’?
 1364 |         for (i = 0; i < hist_data->n_synth_var_refs; i++) {
      |                                    ^~~~~~~~~~~~~~~~
      |                                    n_var_refs
../kernel/trace/trace_events_hist.c:1365:41: error: ‘struct hist_trigger_data’ has no member named ‘synth_var_refs’; did you mean ‘n_var_refs’?
 1365 |                 hist_field = hist_data->synth_var_refs[i];
      |                                         ^~~~~~~~~~~~~~
      |                                         n_var_refs

Tom Zanussi (2):
  tracing: Remove hist trigger synth_var_refs
  tracing: Use var_refs[] for hist trigger reference checking

 kernel/trace/trace_events_hist.c | 86 ++++----------------------------
 1 file changed, 11 insertions(+), 75 deletions(-)

-- 
2.34.1


