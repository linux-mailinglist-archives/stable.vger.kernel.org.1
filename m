Return-Path: <stable+bounces-252099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECP5I0UiDmru6QUAu9opvQ
	(envelope-from <stable+bounces-252099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:06:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127559A723
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B7CA3360D10
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7BE30675C;
	Wed, 20 May 2026 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tfHE0Nqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D713F54D1;
	Wed, 20 May 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299788; cv=none; b=n9s3L+IAIa9zKs6NfEudDPSAug+f1hKkSJzrnX3xyyCRmkw7a7rvVYcxmsdfHcx7lMvnV+yNjbZOPJ6kntghYTERfnEH1d0UCpR5s6djyENqxmp44iNN8303/KDgpTfs5nfzOFWiL1jFDQ2h5js0Os8gWBRbneWBOITjKTrV75w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299788; c=relaxed/simple;
	bh=hzop/UtriHLvtA3N1KvAYKWbgtRZxU8nasdxVpoBIkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtfmhlTDVd7hQBIqoN16DchQWg5f+RwrUgYzSaMOv7WEbY8TjH8UchqPAALdyPF18QYmjYpJLoW8C6X1BobjIXHUclatQNzN4BFSEwGhg3pEK/i6tdZrx1oLYa9qdIvpdT66MzALApGbuh2s3L1tia+98Z0vTyHEGyJRMjR26xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tfHE0Nqz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8FC1F000E9;
	Wed, 20 May 2026 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299786;
	bh=pg8fgPBwUSZgVs4469Kychzd1LoKrwN0eUgbilDzZ1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tfHE0NqzKZ5EBrN7S4+u8rfesIM1/oc91BV3hG6HQXEHFb9m4bOuQq8Qn2jPfBd11
	 IW1zbN1GSPCkN8YqNGXPfi193jsARg6Cjh6NNm1R6xnMtd+D1h2ERl1gc8AUcXzEB0
	 kuKUeCWrsu05XvjVJfpjPUCE/t1Ontmm2W6Txk1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Oros <poros@redhat.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 845/957] ice: fix NULL pointer dereference in ice_reset_all_vfs()
Date: Wed, 20 May 2026 18:22:08 +0200
Message-ID: <20260520162152.889447851@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252099-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 0127559A723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Oros <poros@redhat.com>

[ Upstream commit 54ef02487914c24170c7e1c061e45212dc55365e ]

ice_reset_all_vfs() ignores the return value of ice_vf_rebuild_vsi().
When the VSI rebuild fails (e.g. during NVM firmware update via
nvmupdate64e), ice_vsi_rebuild() tears down the VSI on its error path,
leaving txq_map and rxq_map as NULL. The subsequent unconditional call
to ice_vf_post_vsi_rebuild() leads to a NULL pointer dereference in
ice_ena_vf_q_mappings() when it accesses vsi->txq_map[0].

The single-VF reset path in ice_reset_vf() already handles this
correctly by checking the return value of ice_vf_reconfig_vsi() and
skipping ice_vf_post_vsi_rebuild() on failure.

Apply the same pattern to ice_reset_all_vfs(): check the return value
of ice_vf_rebuild_vsi() and skip ice_vf_post_vsi_rebuild() and
ice_eswitch_attach_vf() on failure. The VF is left safely disabled
(ICE_VF_STATE_INIT not set, VFGEN_RSTAT not set to VFACTIVE) and can
be recovered via a VFLR triggered by a PCI reset of the VF
(sysfs reset or driver rebind).

Note that this patch does not prevent the VF VSI rebuild from failing
during NVM update — the underlying cause is firmware being in a
transitional state while the EMP reset is processed, which can cause
Admin Queue commands (ice_add_vsi, ice_cfg_vsi_lan) to fail. This
patch only prevents the subsequent NULL pointer dereference that
crashes the kernel when the rebuild does fail.

 crash> bt
     PID: 50795    TASK: ff34c9ee708dc680  CPU: 1    COMMAND: "kworker/u512:5"
      #0 [ff72159bcfe5bb50] machine_kexec at ffffffffaa8850ee
      #1 [ff72159bcfe5bba8] __crash_kexec at ffffffffaaa15fba
      #2 [ff72159bcfe5bc68] crash_kexec at ffffffffaaa16540
      #3 [ff72159bcfe5bc70] oops_end at ffffffffaa837eda
      #4 [ff72159bcfe5bc90] page_fault_oops at ffffffffaa893997
      #5 [ff72159bcfe5bce8] exc_page_fault at ffffffffab528595
      #6 [ff72159bcfe5bd10] asm_exc_page_fault at ffffffffab600bb2
         [exception RIP: ice_ena_vf_q_mappings+0x79]
         RIP: ffffffffc0a85b29  RSP: ff72159bcfe5bdc8  RFLAGS: 00010206
         RAX: 00000000000f0000  RBX: ff34c9efc9c00000  RCX: 0000000000000000
         RDX: 0000000000000000  RSI: 0000000000000010  RDI: ff34c9efc9c00000
         RBP: ff34c9efc27d4828   R8: 0000000000000093   R9: 0000000000000040
         R10: ff34c9efc27d4828  R11: 0000000000000040  R12: 0000000000100000
         R13: 0000000000000010  R14:   R15:
         ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
      #7 [ff72159bcfe5bdf8] ice_sriov_post_vsi_rebuild at ffffffffc0a85e2e [ice]
      #8 [ff72159bcfe5be08] ice_reset_all_vfs at ffffffffc0a920b4 [ice]
      #9 [ff72159bcfe5be48] ice_service_task at ffffffffc0a31519 [ice]
     #10 [ff72159bcfe5be88] process_one_work at ffffffffaa93dca4
     #11 [ff72159bcfe5bec8] worker_thread at ffffffffaa93e9de
     #12 [ff72159bcfe5bf18] kthread at ffffffffaa946663
     #13 [ff72159bcfe5bf50] ret_from_fork at ffffffffaa8086b9

 The panic occurs attempting to dereference the NULL pointer in RDX at
 ice_sriov.c:294, which loads vsi->txq_map (offset 0x4b8 in ice_vsi).

 The faulting VSI is an allocated slab object but not fully initialized
 after a failed ice_vsi_rebuild():

  crash> struct ice_vsi 0xff34c9efc27d4828
    netdev = 0x0,
    rx_rings = 0x0,
    tx_rings = 0x0,
    q_vectors = 0x0,
    txq_map = 0x0,
    rxq_map = 0x0,
    alloc_txq = 0x10,
    num_txq = 0x10,
    alloc_rxq = 0x10,
    num_rxq = 0x10,

 The nvmupdate64e process was performing NVM firmware update:

  crash> bt 0xff34c9edd1a30000
  PID: 49858    TASK: ff34c9edd1a30000  CPU: 1    COMMAND: "nvmupdate64e"
   #0 [ff72159bcd617618] __schedule at ffffffffab5333f8
   #4 [ff72159bcd617750] ice_sq_send_cmd at ffffffffc0a35347 [ice]
   #5 [ff72159bcd6177a8] ice_sq_send_cmd_retry at ffffffffc0a35b47 [ice]
   #6 [ff72159bcd617810] ice_aq_send_cmd at ffffffffc0a38018 [ice]
   #7 [ff72159bcd617848] ice_aq_read_nvm at ffffffffc0a40254 [ice]
   #8 [ff72159bcd6178b8] ice_read_flat_nvm at ffffffffc0a4034c [ice]
   #9 [ff72159bcd617918] ice_devlink_nvm_snapshot at ffffffffc0a6ffa5 [ice]

 dmesg:
  ice 0000:13:00.0: firmware recommends not updating fw.mgmt, as it
    may result in a downgrade. continuing anyways
  ice 0000:13:00.1: ice_init_nvm failed -5
  ice 0000:13:00.1: Rebuild failed, unload and reload driver

Fixes: 12bb018c538c ("ice: Refactor VF reset")
Signed-off-by: Petr Oros <poros@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260427-jk-iwl-net-petr-oros-fixes-v1-5-cdcb48303fd8@intel.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index de9e81ccee664..e53a1e4247cb1 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -804,7 +804,12 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 			ice_vf_ctrl_invalidate_vsi(vf);
 
 		ice_vf_pre_vsi_rebuild(vf);
-		ice_vf_rebuild_vsi(vf);
+		if (ice_vf_rebuild_vsi(vf)) {
+			dev_err(dev, "VF %u VSI rebuild failed, leaving VF disabled\n",
+				vf->vf_id);
+			mutex_unlock(&vf->cfg_lock);
+			continue;
+		}
 		ice_vf_post_vsi_rebuild(vf);
 
 		ice_eswitch_attach_vf(pf, vf);
-- 
2.53.0




