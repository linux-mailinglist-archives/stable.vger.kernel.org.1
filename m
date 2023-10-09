Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B797BDF15
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376701AbjJIN0K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376757AbjJIN0G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:26:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B92ADA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:26:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7726C433CA;
        Mon,  9 Oct 2023 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857963;
        bh=AjNaHUvl3qdkNZcwABzf/BzsdtYZ1EXCJT8NqJ+9gNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YaAhB2vLB1XTqtU2+csZ43eHOs7DkK1Wj+Hdh7Zyu82QV2/WSIy/o1kkwM4tFyGP8
         6RLdTv1kn5WV/AjFqTeM8UffI3FVrPkYnF/VeK+NvyOL7MDy5rpf8/fYtu4EkRGYHw
         b2KcUucqXQ/ll/7nF8oaPK5OYx/5yRO/f0uSpFQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 31/75] iwlwifi: avoid void pointer arithmetic
Date:   Mon,  9 Oct 2023 15:01:53 +0200
Message-ID: <20231009130112.317673532@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 3827cb59b3b8ce4b1687385d35034dadcd90d7ce ]

Avoid void pointer arithmetic since it's technically
undefined and causes warnings in some places that use
our code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20220128153014.e349104ecd94.Iadc937f475158b9437becdfefb361a97e7eaa934@changeid
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Stable-dep-of: 8ba438ef3cac ("wifi: iwlwifi: mvm: Fix a memory corruption issue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      | 6 +++---
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      | 2 +-
 13 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index c69f3fb833327..f34a02b33ccd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1960,7 +1960,7 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	struct iwl_fw_ini_error_dump_header *header;
 	u32 type = le32_to_cpu(reg->type), id = le32_to_cpu(reg->id);
 	u32 num_of_ranges, i, size;
-	void *range;
+	u8 *range;
 
 	/*
 	 * The higher part of the ID in version 2 is irrelevant for
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6dde3bd8f4416..27756e47f7caf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1090,7 +1090,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 					sizeof(struct iwl_wowlan_kek_kck_material_cmd_v2);
 			/* skip the sta_id at the beginning */
 			_kek_kck_cmd = (void *)
-				((u8 *)_kek_kck_cmd) + sizeof(kek_kck_cmd.sta_id);
+				((u8 *)_kek_kck_cmd + sizeof(kek_kck_cmd.sta_id));
 		}
 
 		IWL_DEBUG_WOWLAN(mvm, "setting akm %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 0f5c4c2510ef1..3c8eeb565135a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1950,7 +1950,7 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 		goto out;
 	}
 
-	ret = len - copy_to_user(user_buf, (void *)rsp->data + delta, len);
+	ret = len - copy_to_user(user_buf, (u8 *)rsp->data + delta, len);
 	*ppos += ret;
 
 out:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6d439ae7b50b1..f347723092eee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -686,7 +686,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 		mvm->nvm_data->bands[0].n_channels = 1;
 		mvm->nvm_data->bands[0].n_bitrates = 1;
 		mvm->nvm_data->bands[0].bitrates =
-			(void *)mvm->nvm_data->channels + 1;
+			(void *)((u8 *)mvm->nvm_data->channels + 1);
 		mvm->nvm_data->bands[0].bitrates->hw_value = 10;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 8ef5399ad9be6..d779e5e19568b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -83,8 +83,8 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 	fraglen = len - hdrlen;
 
 	if (fraglen) {
-		int offset = (void *)hdr + hdrlen -
-			     rxb_addr(rxb) + rxb_offset(rxb);
+		int offset = (u8 *)hdr + hdrlen -
+			     (u8 *)rxb_addr(rxb) + rxb_offset(rxb);
 
 		skb_add_rx_frag(skb, 0, rxb_steal_page(rxb), offset,
 				fraglen, rxb->truesize);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 411254e9e603f..2e3eb7402197f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -220,8 +220,8 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	fraglen = len - headlen;
 
 	if (fraglen) {
-		int offset = (void *)hdr + headlen + pad_len -
-			     rxb_addr(rxb) + rxb_offset(rxb);
+		int offset = (u8 *)hdr + headlen + pad_len -
+			     (u8 *)rxb_addr(rxb) + rxb_offset(rxb);
 
 		skb_add_rx_frag(skb, 0, rxb_steal_page(rxb), offset,
 				fraglen, rxb->truesize);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 65e382756de68..e4fd58f043ce2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2150,7 +2150,7 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_scan_req_umac *cmd = mvm->scan_cmd;
 	struct iwl_scan_umac_chan_param *chan_param;
 	void *cmd_data = iwl_mvm_get_scan_req_umac_data(mvm);
-	void *sec_part = cmd_data + sizeof(struct iwl_scan_channel_cfg_umac) *
+	void *sec_part = (u8 *)cmd_data + sizeof(struct iwl_scan_channel_cfg_umac) *
 		mvm->fw->ucode_capa.n_scan_channels;
 	struct iwl_scan_req_umac_tail_v2 *tail_v2 =
 		(struct iwl_scan_req_umac_tail_v2 *)sec_part;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index a43e56c7689f3..6dce36d326935 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -363,7 +363,7 @@ struct iwl_trans_pcie {
 
 	/* PCI bus related data */
 	struct pci_dev *pci_dev;
-	void __iomem *hw_base;
+	u8 __iomem *hw_base;
 
 	bool ucode_write_complete;
 	bool sx_complete;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 6c6512158813b..f82fb17450165 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -727,7 +727,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 			goto err;
 	}
 
-	rxq->rb_stts = trans_pcie->base_rb_stts + rxq->id * rb_stts_size;
+	rxq->rb_stts = (u8 *)trans_pcie->base_rb_stts + rxq->id * rb_stts_size;
 	rxq->rb_stts_dma =
 		trans_pcie->base_rb_stts_dma + rxq->id * rb_stts_size;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 04e1f3829e96b..4456aef930cf4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2798,7 +2798,7 @@ static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
 {
 	struct iwl_trans *trans = file->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	void *cpu_addr = (void *)trans->dbg.fw_mon.block, *curr_buf;
+	u8 *cpu_addr = (void *)trans->dbg.fw_mon.block, *curr_buf;
 	struct cont_rec *data = &trans_pcie->fw_mon_data;
 	u32 write_ptr_addr, wrap_cnt_addr, write_ptr, wrap_cnt;
 	ssize_t size, bytes_copied = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 4f6c187eed69c..76d25c62a28e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -154,7 +154,7 @@ static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 	void *tfd;
 	u32 num_tbs;
 
-	tfd = txq->tfds + trans->txqs.tfd.size * txq->write_ptr;
+	tfd = (u8 *)txq->tfds + trans->txqs.tfd.size * txq->write_ptr;
 
 	if (reset)
 		memset(tfd, 0, trans->txqs.tfd.size);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 0f3526b0c5b00..8522cdfc9e5d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -189,7 +189,7 @@ static struct page *get_workaround_page(struct iwl_trans *trans,
 		return NULL;
 
 	/* set the chaining pointer to the previous page if there */
-	*(void **)(page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
+	*(void **)((u8 *)page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
 	*page_ptr = ret;
 
 	return ret;
@@ -314,7 +314,7 @@ struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
 		return NULL;
 	p->pos = page_address(p->page);
 	/* set the chaining pointer to NULL */
-	*(void **)(page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
+	*(void **)((u8 *)page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
 out:
 	*page_ptr = p->page;
 	get_page(p->page);
@@ -963,7 +963,7 @@ void iwl_txq_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb)
 	while (next) {
 		struct page *tmp = next;
 
-		next = *(void **)(page_address(next) + PAGE_SIZE -
+		next = *(void **)((u8 *)page_address(next) + PAGE_SIZE -
 				  sizeof(void *));
 		__free_page(tmp);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 20efc62acf133..19178c88bb229 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -41,7 +41,7 @@ static inline void *iwl_txq_get_tfd(struct iwl_trans *trans,
 	if (trans->trans_cfg->use_tfh)
 		idx = iwl_txq_get_cmd_index(txq, idx);
 
-	return txq->tfds + trans->txqs.tfd.size * idx;
+	return (u8 *)txq->tfds + trans->txqs.tfd.size * idx;
 }
 
 int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
-- 
2.40.1



