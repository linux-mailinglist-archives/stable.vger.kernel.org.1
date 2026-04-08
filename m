Return-Path: <stable+bounces-234449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBr+L3ig1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:37:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 290EA3C1193
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 429473174EF6
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C73D75C3;
	Wed,  8 Apr 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ia9vLtuw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E23D6689;
	Wed,  8 Apr 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672889; cv=none; b=MsGi4eHWi2fIQhZedP93i5fKZ4JKLNf4ayI99Duh8dedPW4zlrGGbihSb9jTu8AjRKpcWNZbub1gHGLTEDhsKf+4JKHMDV2GgJz93RlqxI8HOmRSnYyHIajgZwtKrqSmBdKNnfzKglHEYjf90GGpGt6TSPoVjm9zZNGv+4eZMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672889; c=relaxed/simple;
	bh=wX823UnxCQ81HVY/8+HfOsCF9a6fa8WvdeLGSJYPwUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEyzsB1Tv1CNW5NeXlM4CUYqOyryJUeMnSD3jdRz8Q8UDBAcE9K4dpjgl4KICd5ntHidqpEsB+O9TZollmlNBDZTNYTqMdfKlpEhe2xB/bQ8TN0MixD5m35n9QQ12LmxCc75zzjYg7mXCtmZQVGKY3bnldDthyfpCmWHO5JFlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ia9vLtuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD153C19425;
	Wed,  8 Apr 2026 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672889;
	bh=wX823UnxCQ81HVY/8+HfOsCF9a6fa8WvdeLGSJYPwUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ia9vLtuwl4ATSgHBsDRosRXAsyZOVr3Ciwt+vETaZKW0dIpNhkQVag3DrpAn2NgZV
	 z9usYul+jgD9Ow5rtPMNIyrjpdvGFSM/hJsLX7PXIVbZQ/hc3eQlQZcvX0QbB32ZxG
	 hyBk5un8tam87MXQD62y8BxJPVbu5+8I+xXSGk6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 020/277] wifi: iwlwifi: mvm: dont send a 6E related command when not supported
Date: Wed,  8 Apr 2026 20:00:05 +0200
Message-ID: <20260408175934.607995136@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234449-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 290EA3C1193
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 323156c3541e23da7e582008a7ac30cd51b60acd ]

MCC_ALLOWED_AP_TYPE_CMD is related to 6E support. Do not send it if the
device doesn't support 6E.
Apparently, the firmware is mistakenly advertising support for this
command even on AX201 which does not support 6E and then the firmware
crashes.

Fixes: 0d2fc8821a7d ("wifi: iwlwifi: nvm: parse the VLP/AFC bit from regulatory")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220804
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260324113316.e171f0163f2a.I0c444d1f82d1773054e7ffc391ad49697d58f44e@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 865f973f677db..aa517978fc7a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -479,7 +479,8 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
 	};
 
-	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210 ||
+	    !mvm->trans->cfg->uhb_supported) {
 		IWL_DEBUG_RADIO(mvm, "UATS feature is not supported\n");
 		return;
 	}
-- 
2.53.0




