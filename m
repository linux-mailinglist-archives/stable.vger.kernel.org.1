Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4C7039AD
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbjEORpD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbjEORor (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761419F3C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB0262E04
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05FBC4339B;
        Mon, 15 May 2023 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172525;
        bh=kUrKhhjbrNgLmWrEkrLqnjT5n441ieTdGqorhDsJrRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6dliw0Ov+p+gdmAe7xFXvmR2c73V++jEm+AIjkHxdum77F30UWZy4Q/Waf5fS6d5
         yuN0yyuFRhebOKgPKs8/972pghMRLjDkPf52iQbc4n3TL9Mx6zJtXE77VnlQ7Igru6
         lR4Wdw0m+yNzhFqws9PTxaOfaWmzDsEBurEBvjI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 181/381] wifi: iwlwifi: fw: fix memory leak in debugfs
Date:   Mon, 15 May 2023 18:27:12 +0200
Message-Id: <20230515161744.998557331@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 3d90d2f4a018fe8cfd65068bc6350b6222be4852 ]

Fix a memory leak that occurs when reading the fw_info
file all the way, since we return NULL indicating no
more data, but don't free the status tracking object.

Fixes: 36dfe9ac6e8b ("iwlwifi: dump api version in yaml format")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230418122405.239e501b3b8d.I4268f87809ef91209cbcd748eee0863195e70fa2@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 267ad4eddb5c0..24d6ed3513ce5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -344,8 +344,10 @@ static void *iwl_dbgfs_fw_info_seq_next(struct seq_file *seq,
 	const struct iwl_fw *fw = priv->fwrt->fw;
 
 	*pos = ++state->pos;
-	if (*pos >= fw->ucode_capa.n_cmd_versions)
+	if (*pos >= fw->ucode_capa.n_cmd_versions) {
+		kfree(state);
 		return NULL;
+	}
 
 	return state;
 }
-- 
2.39.2



