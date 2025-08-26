Return-Path: <stable+bounces-173922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F8B36070
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6C01BC104C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00E6202C46;
	Tue, 26 Aug 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PHXb9lbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF71E25E3;
	Tue, 26 Aug 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213019; cv=none; b=QLh7AzjM5qfETqztbF2hIgN0STlogwM4feDryeEU0L2O/9bUMotJqZ1vmg6kWc1cImQt5iFbDXSv/fllFfiwh1kIGp/pyZyrYf9EMhZ2ZUmtD0qAcX2M4qkqAVG10fRRLhVzxWDpUpOU+XBjfvJYvaAltlWNklQcuVqW6CvkIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213019; c=relaxed/simple;
	bh=FirY1Wyd1+a5KMcjrkHr8xLEaj1ek7DBR4sEyqTE+HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ir/Bf79yRnkEygUFDKn/2QOSV2dBLIkPy5agz6gyNyyHyhuztYyh3YF9tSFjmhl0ElUClUvyccNYF5IznTGwYRn9HzEJQxGV+v3Ka88r6zLIP+E2egbom696lOrCfYlOrJMKuqemXEbVZX+c3RX5lupc2OQsg9Db7kVgA0yNRKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PHXb9lbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE96C4CEF1;
	Tue, 26 Aug 2025 12:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213019;
	bh=FirY1Wyd1+a5KMcjrkHr8xLEaj1ek7DBR4sEyqTE+HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHXb9lbp1SZP1IGYYaenOyb+3sOU22N+SdFJvMkz4JVSTetaisA5xKiPeuplDE3XZ
	 OFVOtSslYUG1U0zNjwVDz0ZpQC8EgJ9k1kOqAb89zv3mSYiK1uD4H+nKKHK/OmiKAf
	 EE3jytZjQpoGQAsr0dyexn8zcS5UZj9L6AyJGnj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 160/587] wifi: iwlwifi: mvm: set gtk id also in older FWs
Date: Tue, 26 Aug 2025 13:05:09 +0200
Message-ID: <20250826110957.016169417@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 61be9803f322ab46f31ba944c6ef7de195891f64 ]

We use gtk[i].id, but it is not even set in older FW APIs
(iwl_wowlan_status_v6 and iwl_wowlan_status_v7).
Set it also in older FWs.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250710212632.e91e49590414.I27d2fdbed1c54aee59929fa11ec169f07e159406@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index a82cdd897173..6c108dbbbc54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2143,6 +2143,7 @@ static void iwl_mvm_convert_gtk_v2(struct iwl_wowlan_status_data *status,
 
 	status->gtk[0].len = data->key_len;
 	status->gtk[0].flags = data->key_flags;
+	status->gtk[0].id = status->gtk[0].flags & IWL_WOWLAN_GTK_IDX_MASK;
 
 	memcpy(status->gtk[0].key, data->key, sizeof(data->key));
 
@@ -2369,6 +2370,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		 * currently used key.
 		 */
 		status->gtk[0].flags = v6->gtk.key_index | BIT(7);
+		status->gtk[0].id = v6->gtk.key_index;
 	} else if (notif_ver == 7) {
 		struct iwl_wowlan_status_v7 *v7 = (void *)cmd.resp_pkt->data;
 
-- 
2.39.5




