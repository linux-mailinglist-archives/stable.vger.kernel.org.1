Return-Path: <stable+bounces-217802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH68G1CNnGmdJQQAu9opvQ
	(envelope-from <stable+bounces-217802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:24:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D900917ABE8
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9237C305A94A
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F54F33121E;
	Mon, 23 Feb 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="eAKiuAiS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36871624C5
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867433; cv=none; b=DO8/dezbjjuaAyYdzwlZIHwSDPyE/oT0OGDgfgORme/Yl/2X8uIa4y61uAex7PN9zrelbvZ+myvJ3AAkyx2jtOt/NA8Bv8Z+Y53bplUJkjJ4PXanU+7RR7jFT+tggpT09gsf9C2v4ksD9Ibi38Uz3xDHyzauCjMmGobdPHzGtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867433; c=relaxed/simple;
	bh=FR/BjuhRVisdI/O+p6v7+as0OGm+B3yNv87LwL8ENyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNQFUCqKN7CIXLwDqOaECIMp24WSze4uGhNLH7F3I5Xly/tndIfky4R63DVEIBhVy/zSbm2Gi1Bi/WXE8UgVy3qAdS6e9psA1IRDksNLtQ52HwXf7OBr7FGHwZOjRhK7zbqe1PppdPep2190sifg5V7YFZBEqiUxK43hiIUrKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=eAKiuAiS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8249fc726e9so2383804b3a.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867431; x=1772472231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4NzWXM4tpHzJDOwTGT86JiglGjnpcPu7UVk/0b1E2c=;
        b=eAKiuAiSLKqdIR89LDnPHVqlcX06U7syl85UdTxId7nExar5EuJPUzXpVj9g1f8Nv0
         OiP2xwSwzcP47006RyD28BIubiWB0iNf+ZLx5EngOkMeGs9IBGdBHAnaVOEUM+o36TM3
         KF6hSsp0kczh2vx6oNGOBZQ4q83+R05yyRaBtmxLZOJE94kEuNhi4LOOFP2kQZGmYG/S
         hDMstwWsqQEcKab4+9P9QzRSIOfRjldR9LIVVVX2OBJxLrF4OvjfVuIXMzfmwGox59Mg
         2KfRZXyLBB5XqnBfyF+dW9vlYIusBPQ2PtdTZrcng4QCjiLDNkEnaaysocWQ16UgaUNY
         RiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867431; x=1772472231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4NzWXM4tpHzJDOwTGT86JiglGjnpcPu7UVk/0b1E2c=;
        b=T/y4weqX1CcC/9AdnIuuVjURJmnuJS/VmswrU3a8pacRKeLqGQKE8P4rWS78T6wLJi
         1IQnnZywE57dMqxAh5tBsKRNg7mZ7quy+ro3vjNPco1tRCkd5RjQ8GjDCsSl7n+DJhQ1
         ezzdWzTpwpF+aKvhPhERe0ZIntwYQIraAqTxeafoNtbnIaFTUWZi3pzNmLJHfM4jmz6u
         VR7CWob1+3B0KwdLLtk+4sBmzNb8kKmoUJ3k1CmRSrazaUDAutfCD7TJBhQIA8cMV+Ot
         ZrH7W4wqtW2gGOMfKRayPfJfqCDJ7buM12HS33677whs+KMywFEVcRhp4YHFpHF3Oxmm
         prEg==
X-Gm-Message-State: AOJu0YyPvLzBkG8fH5FdIW9ly1kA9YaudkBCcuXY/SHP7Bd8Cx31e2Fb
	OBcRKkM5GZxTKPo5/9uO0ce3t+pOVu/5euIjt2+9KX8fKUMUl70PII5lEEpnEq4zr5ZRBfKi3KW
	WJJcT
X-Gm-Gg: AZuq6aKGXZpZKml0ZBi4CHNnRV4lVHqhHnyyzq4xrqvdLc2wmW6o2e4vVjMfDPvOLcn
	Q4D6eZUQAnL1RPiyFjsQ4zGDvIjbfNNJItKRxrGrMa1uFuwQxUGayFsdXJ0MlfK0T4lQ44EbGKP
	Wed+nfmMzIeraSCZBN/GXv+kzbKKIZcLh6Cf4uslwN8TxXlVTiL554A/EUsCIGTgU//m86hJrkX
	HVsP4iY/Xd+9y6mh2sWHM3jh0vZNnDOa5utDFte+WB6H6JC2gIJdbyqCQiCzkN/b70wTCLgrmZU
	sCBazzbzuVbF98AnSX4X+uym/BUojuCbDLGtk5s4Vne8Iwo6dcUVe1yRPAl6j6O8bB8NBWk7VY1
	IyO2kOahnbrs9iKPWHA9N8wJm8uVZAw9itWxdE5m2b01Vf/yYU18LbDa6aTQ0sVKpzfZSulz5sc
	vPLuAOgtHyuCPbdQyxhMZkv3sMNqnby/0=
X-Received: by 2002:a05:6a00:3e0c:b0:821:8202:44e3 with SMTP id d2e1a72fcca58-826daa022fbmr8898341b3a.30.1771867430896;
        Mon, 23 Feb 2026 09:23:50 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd641313sm7876162b3a.1.2026.02.23.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:23:50 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>,
	Marco Patalano <mpatalan@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH 5.15.y 2/2] nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()
Date: Mon, 23 Feb 2026 22:53:32 +0530
Message-Id: <20260223172332.291881-3-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223172332.291881-1-jsingh@cloudlinux.com>
References: <20260223172332.291881-1-jsingh@cloudlinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudlinux.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudlinux.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217802-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[jsingh@cloudlinux.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[cloudlinux.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudlinux.com:mid,cloudlinux.com:dkim,cloudlinux.com:email]
X-Rspamd-Queue-Id: D900917ABE8
X-Rspamd-Action: no action

commit 0a2c5495b6d1ecb0fa18ef6631450f391a888256 upstream.

nvme_fc_delete_assocation() waits for pending I/O to complete before
returning, and an error can cause ->ioerr_work to be queued after
cancel_work_sync() had been called.  Move the call to cancel_work_sync() to
be after nvme_fc_delete_association() to ensure ->ioerr_work is not running
when the nvme_fc_ctrl object is freed.  Otherwise the following can occur:

[ 1135.911754] list_del corruption, ff2d24c8093f31f8->next is NULL
[ 1135.917705] ------------[ cut here ]------------
[ 1135.922336] kernel BUG at lib/list_debug.c:52!
[ 1135.926784] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[ 1135.931851] CPU: 48 UID: 0 PID: 726 Comm: kworker/u449:23 Kdump: loaded Not tainted 6.12.0 #1 PREEMPT(voluntary)
[ 1135.943490] Hardware name: Dell Inc. PowerEdge R660/0HGTK9, BIOS 2.5.4 01/16/2025
[ 1135.950969] Workqueue:  0x0 (nvme-wq)
[ 1135.954673] RIP: 0010:__list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1135.961041] Code: c7 c7 98 68 72 94 e8 26 45 fe ff 0f 0b 48 c7 c7 70 68 72 94 e8 18 45 fe ff 0f 0b 48 89 fe 48 c7 c7 80 69 72 94 e8 07 45 fe ff <0f> 0b 48 89 d1 48 c7 c7 a0 6a 72 94 48 89 c2 e8 f3 44 fe ff 0f 0b
[ 1135.979788] RSP: 0018:ff579b19482d3e50 EFLAGS: 00010046
[ 1135.985015] RAX: 0000000000000033 RBX: ff2d24c8093f31f0 RCX: 0000000000000000
[ 1135.992148] RDX: 0000000000000000 RSI: ff2d24d6bfa1d0c0 RDI: ff2d24d6bfa1d0c0
[ 1135.999278] RBP: ff2d24c8093f31f8 R08: 0000000000000000 R09: ffffffff951e2b08
[ 1136.006413] R10: ffffffff95122ac8 R11: 0000000000000003 R12: ff2d24c78697c100
[ 1136.013546] R13: fffffffffffffff8 R14: 0000000000000000 R15: ff2d24c78697c0c0
[ 1136.020677] FS:  0000000000000000(0000) GS:ff2d24d6bfa00000(0000) knlGS:0000000000000000
[ 1136.028765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1136.034510] CR2: 00007fd207f90b80 CR3: 000000163ea22003 CR4: 0000000000f73ef0
[ 1136.041641] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1136.048776] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1136.055910] PKRU: 55555554
[ 1136.058623] Call Trace:
[ 1136.061074]  <TASK>
[ 1136.063179]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 1136.067540]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 1136.071898]  ? move_linked_works+0x4a/0xa0
[ 1136.075998]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.081744]  ? __die_body.cold+0x8/0x12
[ 1136.085584]  ? die+0x2e/0x50
[ 1136.088469]  ? do_trap+0xca/0x110
[ 1136.091789]  ? do_error_trap+0x65/0x80
[ 1136.095543]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.101289]  ? exc_invalid_op+0x50/0x70
[ 1136.105127]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.110874]  ? asm_exc_invalid_op+0x1a/0x20
[ 1136.115059]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.120806]  move_linked_works+0x4a/0xa0
[ 1136.124733]  worker_thread+0x216/0x3a0
[ 1136.128485]  ? __pfx_worker_thread+0x10/0x10
[ 1136.132758]  kthread+0xfa/0x240
[ 1136.135904]  ? __pfx_kthread+0x10/0x10
[ 1136.139657]  ret_from_fork+0x31/0x50
[ 1136.143236]  ? __pfx_kthread+0x10/0x10
[ 1136.146988]  ret_from_fork_asm+0x1a/0x30
[ 1136.150915]  </TASK>

Fixes: 19fce0470f05 ("nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from interrupt context")
Cc: stable@vger.kernel.org
Tested-by: Marco Patalano <mpatalan@redhat.com>
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a959b2c9ae38..9381655c1ec5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3263,13 +3263,13 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
 	 */
 	nvme_fc_delete_association(ctrl);
+	cancel_work_sync(&ctrl->ioerr_work);
 }
 
 static void
-- 
2.43.7


