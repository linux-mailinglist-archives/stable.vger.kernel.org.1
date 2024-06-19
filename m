Return-Path: <stable+bounces-54392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92DA90EDF4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F601F2176F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D414375A;
	Wed, 19 Jun 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1iz/GYGu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF2143757;
	Wed, 19 Jun 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803445; cv=none; b=XWyTk2alIIbWlqL5fVnwACvmCCE/Vza8yDgVTDd4gPIMj53uQjt1wTaeoy9VNjcv4urff3/ZoYNDILfTaP44UZ1xStMK6KMmDAkBLolUjiFcdIyAymTSJoX+xhIV8mFCNTwIJI00lI0FVeX85bi+8QfzI86gfy0INVKJlYJ0M/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803445; c=relaxed/simple;
	bh=dQF+xrEy8jayAWg9gJnhSZG8ECLrl5MdfdVlSIQbthc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oY+za9r6IpbWPPibXGFsMT4917uMYmWO+sCcXCExAdGY1y1nMhesTv8kFuz9WidElO5YNUDjj2Bt+c5GrISs/q7whLIYY6dGbAisNADeRKWnI0DNMAFOIY112pBP0Gpyuwwupx6/XF39pDe2s++XCzzfSC9ofJW6anRIKX+WHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1iz/GYGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3E2C2BBFC;
	Wed, 19 Jun 2024 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803445;
	bh=dQF+xrEy8jayAWg9gJnhSZG8ECLrl5MdfdVlSIQbthc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1iz/GYGutbBBfrzBsDhn1wAY6RBFlyiK9If2yJGcBD5P4IucEv5D64EUK5Mn+BTfq
	 +lXtgsrUB+P5Ik4lELPL5GyHqh0LUBPxtecjS3rq+O3O3Hd+lA+TVpXhhQZioTI72j
	 CiZGYKt3Vl9YoJZMHzsY5YVDaj2UE7GxC33DXYP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 6.9 269/281] wifi: iwlwifi: mvm: fix a crash on 7265
Date: Wed, 19 Jun 2024 14:57:08 +0200
Message-ID: <20240619125620.332321181@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 788e4c75f831d06fcfbbec1d455fac429521e607 upstream.

Since IWL_FW_CMD_VER_UNKNOWN = 99, then my change to consider
cmd_ver >= 7 instead of cmd_ver = 7 included also firmwares that don't
advertise the command version at all. This made us send a command with a
bad size and because of that, the firmware hit a BAD_COMMAND immediately
after handling the REDUCE_TX_POWER_CMD command.

Fixes: 8f892e225f41 ("wifi: iwlwifi: mvm: support iwl_dev_tx_power_cmd_v8")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240512072733.eb20ff5050d3.Ie4fc6f5496cd296fd6ff20d15e98676f28a3cccd@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218963
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -884,8 +884,8 @@ int iwl_mvm_sar_select_profile(struct iw
 	int ret;
 	u16 len = 0;
 	u32 n_subbands;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
-					   IWL_FW_CMD_VER_UNKNOWN);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 3);
+
 	if (cmd_ver >= 7) {
 		len = sizeof(cmd.v7);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;



