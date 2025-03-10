Return-Path: <stable+bounces-122083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE7A59DD5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D38A18872BF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C902356AD;
	Mon, 10 Mar 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U1L18rjG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7B231A24;
	Mon, 10 Mar 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627478; cv=none; b=beN7X6Edd8t07CwAi0znmxkM0jgVSiYiSwI8Y4u90q556+NHIhVJLMpztANgF08pFdNVtjeWA8PIDazyZOwzx/bTNiAhLndgoTUYH1kssGW0SJzSF3nPnUaOgPqBfvSA4PvayqiG2pR4rvptwX+aOx6z1edh6ZYpf/OIXPP4v+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627478; c=relaxed/simple;
	bh=5t9EZmJdNdL/IDkHgVxDAdN/KmZxzuJZYISNw2ZFF+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoR00QWMWVIEMUPbLihS2211ZD906hyTRtZI5/FBr1eVnA85enDvwAYfx9zUzaLk7gDmYoqoK4igdVp7XvATlLrHYzNnNw6QGOJl3P+/4Cg/SjA2vyTICTVpsvsWphkjeW/+ots+nb4Ebbiq025xuYH8Y4jqZpYZ5mr4n9leLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U1L18rjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8CCC4CEE5;
	Mon, 10 Mar 2025 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627477;
	bh=5t9EZmJdNdL/IDkHgVxDAdN/KmZxzuJZYISNw2ZFF+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1L18rjG8GsV2MLe7H9D46E9apUkIm9e1cXpohLzQWJqpE/cu1VECwN1jp1wReMN9
	 RlnuQZDGuGWpziXMySzRf/kmGJnCn2ERq230fW0jph13GRNDJjO412QIzplXHCvogj
	 AZ0gRF+MiuZssmkR/k3VMShypIQqBEY8mTFbHfD4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 141/269] wifi: iwlwifi: mvm: clean up ROC on failure
Date: Mon, 10 Mar 2025 18:04:54 +0100
Message-ID: <20250310170503.338875547@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit f9751163bffd3fe60794929829f810968c6de73d ]

If the firmware fails to start the session protection, then we
do call iwl_mvm_roc_finished() here, but that won't do anything
at all because IWL_MVM_STATUS_ROC_P2P_RUNNING was never set.
Set IWL_MVM_STATUS_ROC_P2P_RUNNING in the failure/stop path.
If it started successfully before, it's already set, so that
doesn't matter, and if it didn't start it needs to be set to
clean up.

Not doing so will lead to a WARN_ON() later on a fresh remain-
on-channel, since the link is already active when activated as
it was never deactivated.

Fixes: 35c1bbd93c4e ("wifi: iwlwifi: mvm: remove IWL_MVM_STATUS_NEED_FLUSH_P2P")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250209143303.0fe36c291068.I67f5dac742170dd937f11e4d4f937f45f71b7cb4@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 72fa7ac86516c..17b8ccc275693 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1030,6 +1030,8 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 		/* End TE, notify mac80211 */
 		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
 		mvmvif->time_event_data.link_id = -1;
+		/* set the bit so the ROC cleanup will actually clean up */
+		set_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status);
 		iwl_mvm_roc_finished(mvm);
 		ieee80211_remain_on_channel_expired(mvm->hw);
 	} else if (le32_to_cpu(notif->start)) {
-- 
2.39.5




