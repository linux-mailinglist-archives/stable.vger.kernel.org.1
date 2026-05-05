Return-Path: <stable+bounces-243970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOXNIhB9+Wmc9AIAu9opvQ
	(envelope-from <stable+bounces-243970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:16:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 586CC4C6C14
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB608301061B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB583C140E;
	Tue,  5 May 2026 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7dd4Xa9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338C3AD538;
	Tue,  5 May 2026 05:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958141; cv=none; b=QblmYtPliqRr2rC0IYUNpvWsA9gHoEEsbW8LBEqPO2ab5/TmeuSvIx4mPzfhaNpeCPL7M+Q9pyN+FwypVYSAcZ66T2C53QWQR2cbTcy8aL+Lr74HY49MAc37clEvY74Sp8ESvyONFKw3ZvstpBmf+w9MmaQKE2uR8yKzyCr2ZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958141; c=relaxed/simple;
	bh=1gopt3oD1vgDGMa0QCAACurSZyWc49vnCmFC5wKhI1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0Xu+q3/hdecN9Bba7+HcZdroVfTzJtxW5hNs4HfnY9usSxwlCpWmftWo3sVdaecUgvIjVwzs2xjiHmefgJDirhcmno89KWOFzT1gS/8dyco6VqCTBEmfBSWa4bOL58cvMfxgGxI/AOc8Kw5/YH99wzPw2DqK+MaFSHpLPKMeE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7dd4Xa9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958140; x=1809494140;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1gopt3oD1vgDGMa0QCAACurSZyWc49vnCmFC5wKhI1M=;
  b=J7dd4Xa9EbQbLyXUyopTLr9gID1ep28rp1czNs17gcstHoNQASystCn8
   CXJ/R38HiRq1w/v/E5mshrw1BO9LXLZCurBZPwsXzwoJ0JhUHN2g4jz0o
   p3sapxXfj6wgeML4+p4nLFWfuUpuTU7stkMUiLeacR8eLowhhtg37G4TB
   AXJ36+CIwmbYT4XwrlMUG8SIM64sS2xyHdxFPQhmznPRmeCjLp8AxclVp
   NpRy6z4aaOFr6KE0PBhWR31GcWAi621aBTie/b377wuAqTFl7AsTLfWfN
   dUDvAA3wfVLjr99D1axCsxQ3CqnH7SGnGrplrHZI6T1x9f+WxEsqWJIpU
   Q==;
X-CSE-ConnectionGUID: T5Ujry8HTgune+80BOoiig==
X-CSE-MsgGUID: 3XQYrgFaTVedcurbzEfmug==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126447"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126447"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
X-CSE-ConnectionGUID: QJOlgsKhSQq40JHXI1Qudw==
X-CSE-MsgGUID: EA8z9bMTQ8imzD99zZwwjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683496"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:17 -0700
Subject: [PATCH net 04/13] idpf: fix read_dev_clk_lock spinlock init in
 idpf_ptp_init()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-4-a222a88bd962@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, Simon Horman <horms@kernel.org>, 
 Samuel Salin <Samuel.salin@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3217;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=mR3J8kkDD6WAkR1aCGRoQIePnlsi1xMHs5/yWSCQUUg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNV/TbxW+nrTz4ambW5pvVDOwTLmVtaXhi7NOG+/tn
 t9+htZlHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkUhrDfy+h8zuWLL43ocW4
 aQ33aYn7EgGpG89MtjDcd4HVcOmpk4wM/z3z7gXfMJWw8y80qq3h9t0ScexE2m+RZu4MIeZkMZd
 KVgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 586CC4C6C14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-243970-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Emil Tantilov <emil.s.tantilov@intel.com>

In idpf_ptp_init(), read_dev_clk_lock is initialized after
ptp_schedule_worker() had already been called (and after
idpf_ptp_settime64() could reach the lock). The PTP aux worker
fires immediately upon scheduling and can call into
idpf_ptp_read_src_clk_reg_direct(), which takes
spin_lock(&ptp->read_dev_clk_lock) on an uninitialized lock, triggering
the lockdep "non-static key" warning:

[12973.796587] idpf 0000:83:00.0: Device HW Reset initiated
[12974.094507] INFO: trying to register non-static key.
...
[12974.097208] Call Trace:
[12974.097213]  <TASK>
[12974.097218]  dump_stack_lvl+0x93/0xe0
[12974.097234]  register_lock_class+0x4c4/0x4e0
[12974.097249]  ? __lock_acquire+0x427/0x2290
[12974.097259]  __lock_acquire+0x98/0x2290
[12974.097272]  lock_acquire+0xc6/0x310
[12974.097281]  ? idpf_ptp_read_src_clk_reg+0xb7/0x150 [idpf]
[12974.097311]  ? lockdep_hardirqs_on_prepare+0xde/0x190
[12974.097318]  ? finish_task_switch.isra.0+0xd2/0x350
[12974.097330]  ? __pfx_ptp_aux_kworker+0x10/0x10 [ptp]
[12974.097343]  _raw_spin_lock+0x30/0x40
[12974.097353]  ? idpf_ptp_read_src_clk_reg+0xb7/0x150 [idpf]
[12974.097373]  idpf_ptp_read_src_clk_reg+0xb7/0x150 [idpf]
[12974.097391]  ? kthread_worker_fn+0x88/0x3d0
[12974.097404]  ? kthread_worker_fn+0x4e/0x3d0
[12974.097411]  idpf_ptp_update_cached_phctime+0x26/0x120 [idpf]
[12974.097428]  ? _raw_spin_unlock_irq+0x28/0x50
[12974.097436]  idpf_ptp_do_aux_work+0x15/0x20 [idpf]
[12974.097454]  ptp_aux_kworker+0x20/0x40 [ptp]
[12974.097464]  kthread_worker_fn+0xd5/0x3d0
[12974.097474]  ? __pfx_kthread_worker_fn+0x10/0x10
[12974.097482]  kthread+0xf4/0x130
[12974.097489]  ? __pfx_kthread+0x10/0x10
[12974.097498]  ret_from_fork+0x32c/0x410
[12974.097512]  ? __pfx_kthread+0x10/0x10
[12974.097519]  ret_from_fork_asm+0x1a/0x30
[12974.097540]  </TASK>

Move the call to spin_lock_init() up a bit to make sure read_dev_clk_lock
is not touched before it's been initialized.

Fixes: 5cb8805d2366 ("idpf: negotiate PTP capabilities and get PTP clock")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index eec91c4f0a75..4a51d2727547 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -952,6 +952,8 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
 		goto free_ptp;
 	}
 
+	spin_lock_init(&adapter->ptp->read_dev_clk_lock);
+
 	err = idpf_ptp_create_clock(adapter);
 	if (err)
 		goto free_ptp;
@@ -977,8 +979,6 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
 			goto remove_clock;
 	}
 
-	spin_lock_init(&adapter->ptp->read_dev_clk_lock);
-
 	pci_dbg(adapter->pdev, "PTP init successful\n");
 
 	return 0;

-- 
2.54.0.rc2.531.gaf818d63126a


