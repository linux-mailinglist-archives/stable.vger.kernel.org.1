Return-Path: <stable+bounces-171245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C54B2A891
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A499E1BA2E9C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE21A1D88D7;
	Mon, 18 Aug 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gIFAjWDl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CD199EAD;
	Mon, 18 Aug 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525288; cv=none; b=dDFoJEGxrE728dIivKKlTb+2CSwF29xoWqzvjHnAImSbrsD1ifZI6/bof0dxiKgVUXZ16W9eUxqa2IFB0+AyM3WK+NQB7gCek3+poyIJuO7vRNI/vxcE7hdui2C1xPGLKgV9nlb0iS6CxSLTEZz+u2sVEtpGboJnspS2GGtaSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525288; c=relaxed/simple;
	bh=up8qeIxbjIhl3PIHkc8V0hpukx5HRSNuAHfAvxQaiOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQTCIdR9Gz15b4g37HYcocKteOJl1pQNG+bZoUb3hubPqWhRQh8Xv4UA5MxWHK+vxDDO/hsl+kjnGk3dBNJhjksfSkdMvTKc1aD+tdFDAVXf+iVhYWPKPIAMT70HklOWw1U06up6RqjG3ArOzCSRAaEqm6BwSO8X0pMIbJ4xHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gIFAjWDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC54C4CEEB;
	Mon, 18 Aug 2025 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525288;
	bh=up8qeIxbjIhl3PIHkc8V0hpukx5HRSNuAHfAvxQaiOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIFAjWDlZzhAU0E1ZInD4r37TFYEQJCG0ZF6QCIXyY69Ed9bj9ljIVMiZuFYYGSLl
	 9BFCh4J3i3N/psm5GNBqQZuhCVRVcWLYjfDhC62rCL3Yay2YQpUI20Db1gIdC1pTdf
	 eJ5z/+85WSxqRYLCEj1T0pQ7+0kpfXF8Pw6gYpAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 217/570] wifi: iwlwifi: mvm: avoid outdated reorder buffer head_sn
Date: Mon, 18 Aug 2025 14:43:24 +0200
Message-ID: <20250818124514.158553831@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit 422850b29e05e67c9145895bfe559940caa0caa8 ]

If no frames are received on a queue for a while, the reorder buffer
head_sn may be an old one. When the next frame that is received on
that queue and buffered is a subframe of an AMSDU but not the last
subframe, it will not update the buffer's head_sn. When the frame
release notification arrives, it will not release the buffered frame
because it will look like the notification's NSSN is lower than the
buffer's head_sn (because of a wraparound).
Fix it by updating the head_sn when the first frame is buffered.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250723094230.795ec0cb8817.I9ec9a3508e7935e8d1833ea3e086066fdefee644@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 077aadbf95db..e0f87ebefc18 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -854,10 +854,15 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	 * already ahead and it will be dropped.
 	 * If the last sub-frame is not on this queue - we will get frame
 	 * release notification with up to date NSSN.
+	 * If this is the first frame that is stored in the buffer, the head_sn
+	 * may be outdated. Update it based on the last NSSN to make sure it
+	 * will be released when the frame release notification arrives.
 	 */
 	if (!amsdu || last_subframe)
 		iwl_mvm_release_frames(mvm, sta, napi, baid_data,
 				       buffer, nssn);
+	else if (buffer->num_stored == 1)
+		buffer->head_sn = nssn;
 
 	spin_unlock_bh(&buffer->lock);
 	return true;
-- 
2.39.5




