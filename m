Return-Path: <stable+bounces-120696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD7A507EA
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB0162ADD
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E981D63C3;
	Wed,  5 Mar 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C4EAaYJq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214AF1C5D4E;
	Wed,  5 Mar 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197708; cv=none; b=lP8iKqmk5+h5lkYbgotY5sMEU0HJjyFIyRsS8buz3m0rcqhIKWKX3LsEvaaSYD3hbpvwx1RH6BvmJ9qJ6wv1uiQCdU2pok7w4opQ/C8j/pOwlWz2VQNgrZwYdySDMqq+G5/4Kiqx9TKPKiW10fsl0EFRxO7TO6renoZVbwmjhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197708; c=relaxed/simple;
	bh=XonGZbT70b5TXmswR7RT3sNvzblu8ZX0V+zDbIU2MTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwEYdqYaQCOYRQJOPm7SOHjYzqTvoQvXmFVdaUYwwnr+dB7cee+Wpdue4qTrzgbQZiAujiLHYePR54iHYIOd9UaeJ/kNBVTaJHF7qVPXVeLNFenksoiAoYJES+3gfaXtcNwqOjPkUHBaT9Ug+vNNMBvXr1UnuPtcrB2/yCKhtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C4EAaYJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709AFC4CED1;
	Wed,  5 Mar 2025 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197708;
	bh=XonGZbT70b5TXmswR7RT3sNvzblu8ZX0V+zDbIU2MTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4EAaYJqWTflEkUTTn8PId9M66XHwlJgybvIep5sgSIxt8nmNv7q08MAy8A2FzaAg
	 isLWvVzGsGVymbY6mopZDN9m3YpAlfNJcyIjU2exllSuJ6udLMiWH7IvoZr+nJ0UBy
	 kQuHvs0q/zg/1c1BciMmAWwN8whkIaUSJMrYV2X0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 040/142] ice: Fix deinitializing VF in error path
Date: Wed,  5 Mar 2025 18:47:39 +0100
Message-ID: <20250305174501.950030959@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Marcin Szycik <marcin.szycik@linux.intel.com>

[ Upstream commit 79990cf5e7aded76d0c092c9f5ed31eb1c75e02c ]

If ice_ena_vfs() fails after calling ice_create_vf_entries(), it frees
all VFs without removing them from snapshot PF-VF mailbox list, leading
to list corruption.

Reproducer:
  devlink dev eswitch set $PF1_PCI mode switchdev
  ip l s $PF1 up
  ip l s $PF1 promisc on
  sleep 1
  echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
  sleep 1
  echo 1 > /sys/class/net/$PF1/device/sriov_numvfs

Trace (minimized):
  list_add corruption. next->prev should be prev (ffff8882e241c6f0), but was 0000000000000000. (next=ffff888455da1330).
  kernel BUG at lib/list_debug.c:29!
  RIP: 0010:__list_add_valid_or_report+0xa6/0x100
   ice_mbx_init_vf_info+0xa7/0x180 [ice]
   ice_initialize_vf_entry+0x1fa/0x250 [ice]
   ice_sriov_configure+0x8d7/0x1520 [ice]
   ? __percpu_ref_switch_mode+0x1b1/0x5d0
   ? __pfx_ice_sriov_configure+0x10/0x10 [ice]

Sometimes a KASAN report can be seen instead with a similar stack trace:
  BUG: KASAN: use-after-free in __list_add_valid_or_report+0xf1/0x100

VFs are added to this list in ice_mbx_init_vf_info(), but only removed
in ice_free_vfs(). Move the removing to ice_free_vf_entries(), which is
also being called in other places where VFs are being removed (including
ice_free_vfs() itself).

Fixes: 8cd8a6b17d27 ("ice: move VF overflow message count into struct ice_mbx_vf_info")
Reported-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Closes: https://lore.kernel.org/intel-wired-lan/PH0PR11MB50138B635F2E5CEB7075325D961F2@PH0PR11MB5013.namprd11.prod.outlook.com
Reviewed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20250224190647.3601930-2-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c          | 5 +----
 drivers/net/ethernet/intel/ice/ice_vf_lib.c         | 8 ++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index b82c47f8865b4..56345fe653707 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -36,6 +36,7 @@ static void ice_free_vf_entries(struct ice_pf *pf)
 
 	hash_for_each_safe(vfs->table, bkt, tmp, vf, entry) {
 		hash_del_rcu(&vf->entry);
+		ice_deinitialize_vf_entry(vf);
 		ice_put_vf(vf);
 	}
 }
@@ -194,10 +195,6 @@ void ice_free_vfs(struct ice_pf *pf)
 			wr32(hw, GLGEN_VFLRSTAT(reg_idx), BIT(bit_idx));
 		}
 
-		/* clear malicious info since the VF is getting released */
-		if (!ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
-			list_del(&vf->mbx_info.list_entry);
-
 		mutex_unlock(&vf->cfg_lock);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 3f80ba02f634e..58f9ac81dfbb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -1019,6 +1019,14 @@ void ice_initialize_vf_entry(struct ice_vf *vf)
 	mutex_init(&vf->cfg_lock);
 }
 
+void ice_deinitialize_vf_entry(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+
+	if (!ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+		list_del(&vf->mbx_info.list_entry);
+}
+
 /**
  * ice_dis_vf_qs - Disable the VF queues
  * @vf: pointer to the VF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
index 0c7e77c0a09fa..5392b04049862 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
@@ -24,6 +24,7 @@
 #endif
 
 void ice_initialize_vf_entry(struct ice_vf *vf);
+void ice_deinitialize_vf_entry(struct ice_vf *vf);
 void ice_dis_vf_qs(struct ice_vf *vf);
 int ice_check_vf_init(struct ice_vf *vf);
 enum virtchnl_status_code ice_err_to_virt_err(int err);
-- 
2.39.5




