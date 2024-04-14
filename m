Return-Path: <stable+bounces-36514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BA89C02D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B211F24757
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F26A352;
	Mon,  8 Apr 2024 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X8Lc71Kr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D6757FF;
	Mon,  8 Apr 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581548; cv=none; b=EYNJ5c6XAoZ3sPadjLlj16HjBC34uNKzLz7/UyQ5NSBFhLOGJaS4Wpyiq/ndo0ILcBiiApvJxrPSqhd6JSPD0DWZ0/TwfjGIqnH5DfgB375dCl4lv1FQwex14bw3eG218vNC41O0+OS63yRjWlU/5HAjhHRJLzqs1ij3rIJgTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581548; c=relaxed/simple;
	bh=6nnJN6PgAOBzK4L//o0IvxQ+cv6c9kEQEwg//Fzlnkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnYWYpCYYsRKSwVTm2d68SmeayooyVA9GUgevbIVLaooYL4ihiPA0U2bDI6K0sRIt+ct11CdYHUZEz3AbTMEmgv8zf7GpsjJNyMLOC4+K6dQUlSagQrIFvA/3wBUaB8y6HdyMwVtTO/6A/21xnx2sGrxpsHMcmbRG6DR8oOesQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8Lc71Kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FE1C433C7;
	Mon,  8 Apr 2024 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581547;
	bh=6nnJN6PgAOBzK4L//o0IvxQ+cv6c9kEQEwg//Fzlnkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8Lc71KrUUNjSkwt/AAuXjtvf/7nq4daG7mHjLjfUqWXcjZCW/Opjq60x8qYzQOa8
	 qBFEjQPb4l+W0Pk2kVsSXRng3a4WVoFAeYgGDGKVdWXyhG853pgjp7o5LfhfTrQTIw
	 Y6Xnd1gRTEmisR1KQOhsOjMvi4Gqh+iyuQ45of60=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Elliott <elliott@hpe.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.6 017/252] ice: fix memory corruption bug with suspend and rebuild
Date: Mon,  8 Apr 2024 14:55:16 +0200
Message-ID: <20240408125307.182826421@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit 1cb7fdb1dfde1aab66780b4ba44dba6402172111 ]

The ice driver would previously panic after suspend. This is caused
from the driver *only* calling the ice_vsi_free_q_vectors() function by
itself, when it is suspending. Since commit b3e7b3a6ee92 ("ice: prevent
NULL pointer deref during reload") the driver has zeroed out
num_q_vectors, and only restored it in ice_vsi_cfg_def().

This further causes the ice_rebuild() function to allocate a zero length
buffer, after which num_q_vectors is updated, and then the new value of
num_q_vectors is used to index into the zero length buffer, which
corrupts memory.

The fix entails making sure all the code referencing num_q_vectors only
does so after it has been reset via ice_vsi_cfg_def().

I didn't perform a full bisect, but I was able to test against 6.1.77
kernel and that ice driver works fine for suspend/resume with no panic,
so sometime since then, this problem was introduced.

Also clean up an un-needed init of a local variable in the function
being modified.

PANIC from 6.8.0-rc1:

[1026674.915596] PM: suspend exit
[1026675.664697] ice 0000:17:00.1: PTP reset successful
[1026675.664707] ice 0000:17:00.1: 2755 msecs passed between update to cached PHC time
[1026675.667660] ice 0000:b1:00.0: PTP reset successful
[1026675.675944] ice 0000:b1:00.0: 2832 msecs passed between update to cached PHC time
[1026677.137733] ixgbe 0000:31:00.0 ens787: NIC Link is Up 1 Gbps, Flow Control: None
[1026677.190201] BUG: kernel NULL pointer dereference, address: 0000000000000010
[1026677.192753] ice 0000:17:00.0: PTP reset successful
[1026677.192764] ice 0000:17:00.0: 4548 msecs passed between update to cached PHC time
[1026677.197928] #PF: supervisor read access in kernel mode
[1026677.197933] #PF: error_code(0x0000) - not-present page
[1026677.197937] PGD 1557a7067 P4D 0
[1026677.212133] ice 0000:b1:00.1: PTP reset successful
[1026677.212143] ice 0000:b1:00.1: 4344 msecs passed between update to cached PHC time
[1026677.212575]
[1026677.243142] Oops: 0000 [#1] PREEMPT SMP NOPTI
[1026677.247918] CPU: 23 PID: 42790 Comm: kworker/23:0 Kdump: loaded Tainted: G        W          6.8.0-rc1+ #1
[1026677.257989] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0005.2202160810 02/16/2022
[1026677.269367] Workqueue: ice ice_service_task [ice]
[1026677.274592] RIP: 0010:ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
[1026677.281421] Code: 0f 84 3a ff ff ff 41 0f b7 74 ec 02 66 89 b0 22 02 00 00 81 e6 ff 1f 00 00 e8 ec fd ff ff e9 35 ff ff ff 48 8b 43 30 49 63 ed <41> 0f b7 34 24 41 83 c5 01 48 8b 3c e8 66 89 b7 aa 02 00 00 81 e6
[1026677.300877] RSP: 0018:ff3be62a6399bcc0 EFLAGS: 00010202
[1026677.306556] RAX: ff28691e28980828 RBX: ff28691e41099828 RCX: 0000000000188000
[1026677.314148] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ff28691e41099828
[1026677.321730] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[1026677.329311] R10: 0000000000000007 R11: ffffffffffffffc0 R12: 0000000000000010
[1026677.336896] R13: 0000000000000000 R14: 0000000000000000 R15: ff28691e0eaa81a0
[1026677.344472] FS:  0000000000000000(0000) GS:ff28693cbffc0000(0000) knlGS:0000000000000000
[1026677.353000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1026677.359195] CR2: 0000000000000010 CR3: 0000000128df4001 CR4: 0000000000771ef0
[1026677.366779] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[1026677.374369] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[1026677.381952] PKRU: 55555554
[1026677.385116] Call Trace:
[1026677.388023]  <TASK>
[1026677.390589]  ? __die+0x20/0x70
[1026677.394105]  ? page_fault_oops+0x82/0x160
[1026677.398576]  ? do_user_addr_fault+0x65/0x6a0
[1026677.403307]  ? exc_page_fault+0x6a/0x150
[1026677.407694]  ? asm_exc_page_fault+0x22/0x30
[1026677.412349]  ? ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
[1026677.418614]  ice_vsi_rebuild+0x34b/0x3c0 [ice]
[1026677.423583]  ice_vsi_rebuild_by_type+0x76/0x180 [ice]
[1026677.429147]  ice_rebuild+0x18b/0x520 [ice]
[1026677.433746]  ? delay_tsc+0x8f/0xc0
[1026677.437630]  ice_do_reset+0xa3/0x190 [ice]
[1026677.442231]  ice_service_task+0x26/0x440 [ice]
[1026677.447180]  process_one_work+0x174/0x340
[1026677.451669]  worker_thread+0x27e/0x390
[1026677.455890]  ? __pfx_worker_thread+0x10/0x10
[1026677.460627]  kthread+0xee/0x120
[1026677.464235]  ? __pfx_kthread+0x10/0x10
[1026677.468445]  ret_from_fork+0x2d/0x50
[1026677.472476]  ? __pfx_kthread+0x10/0x10
[1026677.476671]  ret_from_fork_asm+0x1b/0x30
[1026677.481050]  </TASK>

Fixes: b3e7b3a6ee92 ("ice: prevent NULL pointer deref during reload")
Reported-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 47298ab675a55..0b7132a42e359 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3157,7 +3157,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 {
 	struct ice_vsi_cfg_params params = {};
 	struct ice_coalesce_stored *coalesce;
-	int prev_num_q_vectors = 0;
+	int prev_num_q_vectors;
 	struct ice_pf *pf;
 	int ret;
 
@@ -3171,13 +3171,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
 		return -EINVAL;
 
-	coalesce = kcalloc(vsi->num_q_vectors,
-			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
-	if (!coalesce)
-		return -ENOMEM;
-
-	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
-
 	ret = ice_vsi_realloc_stat_arrays(vsi);
 	if (ret)
 		goto err_vsi_cfg;
@@ -3187,6 +3180,13 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	if (ret)
 		goto err_vsi_cfg;
 
+	coalesce = kcalloc(vsi->num_q_vectors,
+			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
+	if (!coalesce)
+		return -ENOMEM;
+
+	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
+
 	ret = ice_vsi_cfg_tc_lan(pf, vsi);
 	if (ret) {
 		if (vsi_flags & ICE_VSI_FLAG_INIT) {
@@ -3205,8 +3205,8 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 
 err_vsi_cfg_tc_lan:
 	ice_vsi_decfg(vsi);
-err_vsi_cfg:
 	kfree(coalesce);
+err_vsi_cfg:
 	return ret;
 }
 
-- 
2.43.0




