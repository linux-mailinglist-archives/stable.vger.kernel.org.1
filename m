Return-Path: <stable+bounces-155351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CDFAE3EAA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41FF1889F70
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92223E359;
	Mon, 23 Jun 2025 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FIDOU8sm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F6188CC9
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679661; cv=none; b=J9PMWOpVsQsH8vWHu4mbdt/d7Kr6np5y7JjQQ35LZW/y2si64o1RGDVoxLuEg8YoKfKTrHAHNjkLNYe0isEZWTHxe0PRuKNenPCM+7f31brqGxZHAleNyC859bSql9+GMO8nKTzWiOpCBjIkUqTVxLi83Bvw1uyfbudxnNFhvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679661; c=relaxed/simple;
	bh=XUEbJtAiDjOdaX48Q7TjMfMGWFHpbPjfRhLFNpC1Jd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kbpQlkbWFdLsMbIE9+nf5XtY9gOMFGcfla+0LY8NAUQ6LOn5/2JKL//E56Wbhc/eqmj8NKQjFA/q+M/XDu27wmj3sGb9HrW2vZHQXFBYjr5WK6XtF4z31oociEXiN2vVfo9kZ0dzcBgith2K2z+y4NdhBLzjkjc+gOzoitLpaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FIDOU8sm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1993558b3a.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750679658; x=1751284458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcbPqcjHt1aOxgj/9YDPcPNMrCpf8Up7njFbfb+IWhM=;
        b=FIDOU8smkXGacvJCY+jVfxzORPrvMeaJ1oKVxnAs+EYnmeQb2SQnsWXWO76RRKATrw
         Uv4U7OgLzGPVqENahHlwsZP7wqf0CW/GO64BOhTDfzasY77t9CtPMLpaPFZ/FoqxiHI0
         2fwzCTk79v2yk6W4VIo0KAHINAPwZk2XiGlM5qNhvYGqMnEgmWnrfSOD8mTbpPl+sgZJ
         Y1GmPbu+2Fxh12h2XE5FI8dLK+NPQMyhowk4E3b57aZtaaDxBRn7tIRBelvTyjKTFt3T
         j625wwYbhetbxLyOHSJt5OUj7a6vnbCx7TkgjI1N0/tM1yWAsM44A4jLlZ5hnq7IarHA
         9CCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679658; x=1751284458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcbPqcjHt1aOxgj/9YDPcPNMrCpf8Up7njFbfb+IWhM=;
        b=DZJksf52n8lVJK/Fpwad00O6PPmguCCtTVRgCJXjWuhfr+uz0ZAwX44VGxx7o/qEjz
         JLASl/IoNMGLf2NdenbYBTtHD/6H2NrAnE2O98UuWN0mgxWZxGMnFcr24FFU39wKHpPp
         iGMVuvC3qQ/j5hkQKkCVh1AfWVBvROfz1Dbfb6OoAhz3hDEG1D7/NSTEpSv4QvQQhsx2
         c4XnKB3Eo1X/Pe7aH0iXoyY05E1FeSSwLaV9YfWuRVq/YF8n+gBEkVcRraRU/AGCdsBv
         Nu8BTUxJnex/0AQxHqMXNcBwAK/IwtQXMu75hJBzbiFgWTOAmUnuHPwUd2DzNBBdhqfc
         443w==
X-Gm-Message-State: AOJu0Yxmg/QC2dG2oqxG3ZUDn8fgLIc0YfGt0h8ikOtVdB0ls9v67HD1
	PHhQcUP7SKK6N8wWSHv+UyCvjOnlsV/V66sW0VfIsYqRc5aWui982wzFrmXiuHc/Qw==
X-Gm-Gg: ASbGnctmO3PZSbSAzQEVCd7How85KX6fbE4eTjjsyj1WcE51yyuwsyfTSE/Aa8v577H
	0rSaSmW+MQZuxve+SrpsO/APVuKUcWSa2wLhM/d5rv2R3FiBiXxx7Ko6rHGX3JH0kSKj4959I7j
	rx+zk+2y7qXQe7AuRQGjfLWPnTl63AjJVDbksCRNSiSCLZtNKI9d4a+d8RiF3IIQEveFIR/ovhj
	23pBQKwvsS8P6hJoJttSrPl9O3LSBp9Wu8YSsEdsTmyjP56ZtakEe8i/8skRNKU9Scy+qXrl7BP
	OMHAJ/ChPOhuvgZPsbvj9ZkgOgjWGqLBMvNdpYP5QGCofi+p+PVbS4viXWE8D3lEmVoFwRbBmUD
	69PJYmepPVOsi3K45+mR95eE1UaFpFXBL
X-Google-Smtp-Source: AGHT+IFSgz9YvKD5rjs/M34PdPuvSAxFbsJ19VA22oFExH9obexSRuwKRqCNIJosN4+XPMB314VvoQ==
X-Received: by 2002:a05:6a20:9184:b0:21f:54f0:3b97 with SMTP id adf61e73a8af0-22026cf37camr21491358637.15.1750679658526;
        Mon, 23 Jun 2025 04:54:18 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12427b7sm6597716a12.40.2025.06.23.04.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 04:54:17 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH 0/4] Fix kernel panic problem caused by bpf verifier in 5.10 stable kernel
Date: Mon, 23 Jun 2025 19:53:59 +0800
Message-Id: <20250623115403.299-1-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Wei reported when loading his bpf prog in 5.10.200 kernel, host would
panic, this didn't happen in 5.10.135 kernel. Test on latest v5.10.238
still has this panic:

[   26.531718] BUG: kernel NULL pointer dereference, address: 0000000000000168
[   26.538093] #PF: supervisor read access in kernel mode
[   26.542727] #PF: error_code(0x0000) - not-present page
[   26.548093] PGD 10f3e9067 P4D 10f332067 PUD 10f0c5067 PMD 0
[   26.553211] Oops: 0000 [#1] SMP NOPTI
[   26.556531] CPU: 2 PID: 541 Comm: main Not tainted 5.10.238-00267-g01e7e36b8606 #63
[   26.563816] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   26.572357] RIP: 0010:__mark_chain_precision+0x24b/0x4d0
[   26.576572] Code: 51 01 be 20 00 00 00 4c 89 ef 48 63 d2 e8 bd df 31 00 89 c1 83 f8 1f 7f 29 48 63 d1 48 89 d0 48 c1 e0 04 48 29 d0 48 8d 04 c3 <83> 38 01 75 c3 0f b6 74 24 06 80 78 74 00 c6 40 74 01 44 0f 44 f6
[   26.589100] RSP: 0018:ffa0000000ff7b60 EFLAGS: 00010216
[   26.592612] RAX: 0000000000000168 RBX: 0000000000000000 RCX: 0000000000000003
[   26.597416] RDX: 0000000000000003 RSI: 0000000000000020 RDI: ffa0000000ff7b78
[   26.601362] RBP: 0000000000000003 R08: ffa0000000ff7b70 R09: 0000000000000004
[   26.604261] R10: 0000000000000007 R11: ffa0000000425000 R12: ff11000102ee2000
[   26.607202] R13: ffa0000000ff7b78 R14: 0000000000000000 R15: ff1100010ee37140
[   26.610327] FS:  00000000007a0630(0000) GS:ff1100081c400000(0000) knlGS:0000000000000000
[   26.613678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.616105] CR2: 0000000000000168 CR3: 0000000115e72002 CR4: 0000000000371ee0
[   26.619059] Call Trace:
[   26.620118]  adjust_reg_min_max_vals+0x133/0x340
[   26.622048]  ? krealloc+0x63/0xe0
[   26.623435]  do_check+0x38c/0xa80
[   26.624859]  do_check_common+0x15b/0x280
[   26.626496]  bpf_check+0xbe1/0xd30
[   26.627939]  ? srso_alias_return_thunk+0x5/0x7f
[   26.629796]  ? trace_hardirqs_on+0x1a/0xd0
[   26.631503]  ? srso_alias_return_thunk+0x5/0x7f
[   26.633402]  bpf_prog_load+0x422/0x8a0
[   26.634987]  ? srso_alias_return_thunk+0x5/0x7f
[   26.636864]  ? __handle_mm_fault+0x3cb/0x6d0
[   26.638658]  ? srso_alias_return_thunk+0x5/0x7f
[   26.640543]  ? lock_release+0xe3/0x110
[   26.642114]  __do_sys_bpf+0x485/0xdf0
[   26.643624]  do_syscall_64+0x33/0x40
[   26.645110]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   26.647190] RIP: 0033:0x409a6e
[   26.648470] Code: 24 28 44 8b 44 24 2c e9 70 ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
[   26.656154] RSP: 002b:000000c00199edc0 EFLAGS: 00000212 ORIG_RAX: 0000000000000141
[   26.659451] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000409a6e
[   26.662375] RDX: 0000000000000098 RSI: 000000c00199f290 RDI: 0000000000000005
[   26.665267] RBP: 000000c00199ee00 R08: 0000000000000000 R09: 0000000000000000
[   26.668204] R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
[   26.671125] R13: 0000000000000080 R14: 000000c000002380 R15: 8080808080808080
[   26.674085] Modules linked in:
[   26.675363] CR2: 0000000000000168
[   26.676772] ---[ end trace 3fc192ee4dabbf12 ]---
[   26.678667] RIP: 0010:__mark_chain_precision+0x24b/0x4d0
[   26.680926] Code: 51 01 be 20 00 00 00 4c 89 ef 48 63 d2 e8 bd df 31 00 89 c1 83 f8 1f 7f 29 48 63 d1 48 89 d0 48 c1 e0 04 48 29 d0 48 8d 04 c3 <83> 38 01 75 c3 0f b6 74 24 06 80 78 74 00 c6 40 74 01 44 0f 44 f6
[   26.688665] RSP: 0018:ffa0000000ff7b60 EFLAGS: 00010216
[   26.690828] RAX: 0000000000000168 RBX: 0000000000000000 RCX: 0000000000000003
[   26.693777] RDX: 0000000000000003 RSI: 0000000000000020 RDI: ffa0000000ff7b78
[   26.696680] RBP: 0000000000000003 R08: ffa0000000ff7b70 R09: 0000000000000004
[   26.699651] R10: 0000000000000007 R11: ffa0000000425000 R12: ff11000102ee2000
[   26.702561] R13: ffa0000000ff7b78 R14: 0000000000000000 R15: ff1100010ee37140
[   26.705522] FS:  00000000007a0630(0000) GS:ff1100081c400000(0000) knlGS:0000000000000000
[   26.708806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.711179] CR2: 0000000000000168 CR3: 0000000115e72002 CR4: 0000000000371ee0
[   26.714143] Kernel panic - not syncing: Fatal exception
[   26.716893] Kernel Offset: disabled
[   26.718911] Rebooting in 5 seconds..

I did a bisect in linux-5.10.y branch and found the fbc is commit
2474ec58b96d("bpf: allow precision tracking for programs with subprogs").

This series revert the above commit and related commits. After the
revert, kernel does not panic anymore.

For detailed log and a reproducer, please reference this link:
https://lore.kernel.org/stable/20250605070921.GA3795@bytedance

Aaron Lu (4):
  Revert "selftests/bpf: make test_align selftest more robust"
  Revert "bpf: aggressively forget precise markings during state
    checkpointing"
  Revert "bpf: stop setting precise in current state"
  Revert "bpf: allow precision tracking for programs with subprogs"

 kernel/bpf/verifier.c                         | 175 ++----------------
 .../testing/selftests/bpf/prog_tests/align.c  |  36 ++--
 2 files changed, 26 insertions(+), 185 deletions(-)

-- 
2.39.5


