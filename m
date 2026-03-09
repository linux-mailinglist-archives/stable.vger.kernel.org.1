Return-Path: <stable+bounces-223633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMGoGcrCrmmRIgIAu9opvQ
	(envelope-from <stable+bounces-223633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:53:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7D3239364
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BDE3305B0B7
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7813BA23D;
	Mon,  9 Mar 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAScvoOg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BC332633
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060526; cv=none; b=Pk9XXTB1GBPuN1CdidCD0bn2b7BEhf1pF3R7+mngvKHV2biPhJTEGuoH4LyRKFbkbY/vs44cMqgM0YiflosbpAk6+myeDh0jHMgTOnyRFMubKN5CYpV75DukMQj01+Zc10r/fCC/fZXTu4rMVxfUL1kiFvnNxfwAeT7+jVeSKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060526; c=relaxed/simple;
	bh=xmIoewIM84MR0+WgPM7dcoUSHWwYowUA7w6SVAoOqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqI469OtS33fQNP8pg0bgrzYHYHE0d6Dd/f7RBCl/Z8ySUROT2gYmy+16aYpqElrVFcjWJ1qlZrkNrRAJh2wLlIDyYtO0QVedVk3FfYEYu3avSPRLujngatZRP9EW6lrZNVAg40yXsJHXlZkFQQU0dRhWQF7xoXDmwVs9vYqfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAScvoOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70C6C4CEF7;
	Mon,  9 Mar 2026 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773060526;
	bh=xmIoewIM84MR0+WgPM7dcoUSHWwYowUA7w6SVAoOqWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAScvoOgnhTMa0M+0O3DWV7doA2HUgr+NLcfI9Q/N2XmdX6ZCPZhN+yzzRfmkCHMM
	 UmcXPpdVi84vyJcH+vM07pPTfcmByMenFJVtaFDmF/J10xRt5UPJkQz8SrIxRhy7LU
	 kYG6ITDAIPnS+93yAQa2b5x3/5Par++JucYgXkvG9RfwPvJzgfvATV5UumUMCmvPAO
	 MNzr86JlMpQnt657AejkNVyWeS8X3w4Tv6rbqeJcELMaM05LYreiHP44D0vxL+EtTb
	 enOxVuG7zIN63HUx2cFa5ze4LMBTx0FdT1IuaYH6cx7VgOL/C08IfxICIRuXKxhdHQ
	 DPSss162zYWrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@codecoup.pl>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] Bluetooth: Fix CIS host feature condition
Date: Mon,  9 Mar 2026 08:48:44 -0400
Message-ID: <20260309124844.862930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030931-absinthe-imbecile-9225@gregkh>
References: <2026030931-absinthe-imbecile-9225@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD7D3239364
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223633-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mpg.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,codecoup.pl:email]
X-Rspamd-Action: no action

From: Mariusz Skamra <mariusz.skamra@codecoup.pl>

[ Upstream commit 7cff9a40c6b0f72ccefdaf0ffe03cfac30348f51 ]

This fixes the condition for sending the LE Set Host Feature command.
The command is sent to indicate host support for Connected Isochronous
Streams in this case. It has been observed that the system could not
initialize BIS-only capable controllers because the controllers do not
support the command.

As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
supported if CIS Central or CIS Peripheral is supported; otherwise,
the command is optional.

Fixes: 709788b154ca ("Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings")
Cc: stable@vger.kernel.org
Signed-off-by: Mariusz Skamra <mariusz.skamra@codecoup.pl>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ iso_capable() => cis_capable() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 334eb4376a266..80b601e344ae3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4564,7 +4564,7 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_host_feature cp;
 
-	if (!iso_capable(hdev))
+	if (!cis_capable(hdev))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
-- 
2.51.0


