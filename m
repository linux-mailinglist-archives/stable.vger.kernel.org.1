Return-Path: <stable+bounces-63406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B96B9418D3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE1D1F245B3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84E18953A;
	Tue, 30 Jul 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BCafPPeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A9189522;
	Tue, 30 Jul 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356732; cv=none; b=ngsQEq7TaAZWTvTbAfQPfdqURFb9OzUP5CPDNR38hDboTALc9lHtGERhipI/iraJpmcJo9YiJM1wyVs2XJoO+5vCJ7OZDKZxF/BW8GswVyiyaVc3EK63ML5UGDPlwgX6Q/qfLlIeVDjnuKl4SkKDmhJbEVZI1TXuXH4Ytf4euvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356732; c=relaxed/simple;
	bh=GEmpZ40ureNYtdLPEV/UDNCB7/UJv7Y3+9j/ZiRB3z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVJKtjNRruQStdlb0mXXVXsF8lhHw06WpRnbsRLXyUrZRfRUvI2eJIyqPzQoIXHcwI130P2M5M2ZKC8lF71n/UBmOwz1RpKlYB8VizHo5+zYQqp30AijwhgdRIAGoEKnjKFYhkiRqLdotKpOyhgSJah+a2jsu5T2ooXoF8KqBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BCafPPeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAC3C4AF0A;
	Tue, 30 Jul 2024 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356732;
	bh=GEmpZ40ureNYtdLPEV/UDNCB7/UJv7Y3+9j/ZiRB3z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCafPPehQ0SunxQgliqH/oVafawnJn5FxDLlsIn38kFbq1LyVSaqo2nAqPkx95cSc
	 66B75IVCf1lRtlzlXlM40WPTezMjMixSJIlUYZqRpk4XYq9iIuxKN5nzGrt5FyKMDs
	 Y4e+ru6nhH9LScCIYe8alp/Pd+93KKQEU7PEaaBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 159/809] wifi: iwlwifi: mvm: dont skip link selection
Date: Tue, 30 Jul 2024 17:40:35 +0200
Message-ID: <20240730151730.883358705@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 46144103ace2863e26f4e911aa45200753b7dbca ]

If we exit EMLSR due to a IWL_MVM_ESR_EXIT*, a MLO scan followed by a
link selection is scheduled with a delay of 30 seconds.
If during that 30 seconds EMLSR was blocked and unblocked
(IWL_MVM_ESR_BLOCKED*), we would still want to get the needed data from
the MLO scan and select link accordingly, and not return immediately to
EMLSR.

Fixes: 2f33561ea8f9 ("wifi: iwlwifi: mvm: trigger link selection after exiting EMLSR")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://msgid.link/20240512152312.caab27a8dd8f.I63f67e213d5e05416f71513a8d914917d59aa44f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 6ec9a8e21a34e..b4a4d25b31cd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -1082,6 +1082,13 @@ static void iwl_mvm_esr_unblocked(struct iwl_mvm *mvm,
 
 	IWL_DEBUG_INFO(mvm, "EMLSR is unblocked\n");
 
+	/* We exited due to an EXIT reason, so MLO scan was scheduled already */
+	if (mvmvif->last_esr_exit.reason &&
+	    !(mvmvif->last_esr_exit.reason & IWL_MVM_BLOCK_ESR_REASONS)) {
+		IWL_DEBUG_INFO(mvm, "Wait for MLO scan\n");
+		return;
+	}
+
 	/*
 	 * If EMLSR was blocked for more than 30 seconds, or the last link
 	 * selection decided to not enter EMLSR, trigger a new scan.
-- 
2.43.0




