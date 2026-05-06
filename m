Return-Path: <stable+bounces-244459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJIpB2m3+2kXDwAAu9opvQ
	(envelope-from <stable+bounces-244459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:49:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5FC4E0BB9
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B03CC3009CFC
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6BF3B3C11;
	Wed,  6 May 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhZ1F+76"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288983B3BF5;
	Wed,  6 May 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104162; cv=none; b=AJIaud0P+rQz+0xAa9gb606hyo+Gk9yYM90HEY9vp4P1slDQd56n91kFb+QkpFbxeuEFB1DZhJNolPm071hZceP0N7RBIy4WT1AKrDvQTt7d077e33f96kWzx71wsisYny0wkxYHH33lJeg8heFdUpO48VdYmAuCYuWRKRUmMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104162; c=relaxed/simple;
	bh=1gopt3oD1vgDGMa0QCAACurSZyWc49vnCmFC5wKhI1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kOnXQ/Wl8VI/H+xvSTq4znRYaddYFrnGDM43jegHziLfvsDKHAG+2e3SD1qbzF0KirI84piJzA6R++atz/sFzOVSwAfYZ1Do1wWA2bSDO/notfI8zRx+ONC5UdfIwiqAgV3TMgt5jB5DZmoHWXW38+3XMVjZu089ddep726X+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhZ1F+76; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104161; x=1809640161;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1gopt3oD1vgDGMa0QCAACurSZyWc49vnCmFC5wKhI1M=;
  b=IhZ1F+76PYFLhHE5B0ZGsffm/85t1pbI+lYjXEh8F0z7vcEi4Rta7Yil
   R4taqRE/yqrmUPG6GE36/7MJAip8NiezNw0XAjXnLZ+xMeVeSJa4u/DJ/
   N587y0oIfI98g6S7OiSI/nKzcg4TVZWSBVYi5Kpd99plmNi9RwiC4ElFI
   6cUKF36F4+TAFjjdBBiRiIQtRO2/MGGcKKcU9CrgGWrH+lAfdtrIqAPTE
   jlFf+o/jzpkTRtVTws4Xeemk8t/XvProD2jWqe+HcE4P+CDimf+1IV62/
   rLHH/W3u0KWAFP2HUug25ha3iBB1GFAbgzr4rTf1cveFxabXTwswlEGYO
   Q==;
X-CSE-ConnectionGUID: TBO8jjmzTk6Wl0u6VqBPXQ==
X-CSE-MsgGUID: di4fEU6cRkyP9B3DdCLkgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982501"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78982501"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:19 -0700
X-CSE-ConnectionGUID: D5uBUZVjScqOpKEysrrvog==
X-CSE-MsgGUID: NWp3zmeWRiG0WHAewAeSZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259698616"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:19 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 06 May 2026 14:48:12 -0700
Subject: [PATCH net v2 3/8] idpf: fix read_dev_clk_lock spinlock init in
 idpf_ptp_init()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-3-a5ea4dc837a9@intel.com>
References: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
In-Reply-To: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
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
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf26Mbtky9sVZnU/jmx5ZBccsuPiyWOh3S25rO+uKEn
 pWC7Nb6jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACby9yfDP71in0VHPu39ssfe
 7lx08rV8uZKM4xl/nlp82MjCoHdmXyQjw+yG1wxTWPaocp6vCzi514XPSFe2qrbxxLGMXVsy1+7
 hZgMA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: DE5FC4E0BB9
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
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-244459-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


