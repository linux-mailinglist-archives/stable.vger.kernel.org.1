Return-Path: <stable+bounces-213463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMByKOlbg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:47:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7FFE75AE
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09DF6300E26B
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1B3274B39;
	Wed,  4 Feb 2026 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rzPllomR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3F1C5D77;
	Wed,  4 Feb 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216422; cv=none; b=BldB+J7NhD3QUgzLQFh3pyyaaJ5sFL6FoiRjH+EZE7WtHeU3CbNZnnmSCNLWUTmyUzZoISqeZ9a8Ic6kxuLBg/+l6pKb7EJPecD3aYK/K5cWdJrfm4BOuXDAgwFwMaEm0+YWTqY5KRnRHpf8HNiJULTLIjbS6Zo3igJAaY9/BTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216422; c=relaxed/simple;
	bh=LTTxzFr8VcsDJ5Iycd4cyPUS6ckr/XTgZBCG25FtOYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEPEEhIo2ovj5bzTrQnY8VqbAfv1rAAe9WF8unqV/2eJCinxkKOO12hxbRrL34p+EgllYmTDnCPzlSaHf+zJGb7cmX0J8mdokWSsW05/diZMNN4qPQHyqwAN3Rju7TtPM7WjCvDKLxsq7CzSdoN0zEb2xKEdohxDuS7qPgCkND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rzPllomR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A2CC4CEF7;
	Wed,  4 Feb 2026 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216422;
	bh=LTTxzFr8VcsDJ5Iycd4cyPUS6ckr/XTgZBCG25FtOYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzPllomRdeCQBKL9zDHafscfbKTzDDNzk7wm6jJ4N3fEphMR8Sw4xdONn9qVb0R0W
	 YAXlhqbIDpzewpbsLS/36G8JZcUc37QkyocyTlTo8HolWZ0r6ET5zu64FTJzYAqxrl
	 VqEWXLdRn6OlEqYHpKX8lNLvaBKvpde+3agYAiMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Vatoropin <a.vatoropin@crpt.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 083/161] be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list
Date: Wed,  4 Feb 2026 15:39:06 +0100
Message-ID: <20260204143854.734855044@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213463-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A7FFE75AE
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

[ Upstream commit 8215794403d264739cc676668087512950b2ff31 ]

When the parameter pmac_id_valid argument of be_cmd_get_mac_from_list() is
set to false, the driver may request the PMAC_ID from the firmware of the
network card, and this function will store that PMAC_ID at the provided
address pmac_id. This is the contract of this function.

However, there is a location within the driver where both
pmac_id_valid == false and pmac_id == NULL are being passed. This could
result in dereferencing a NULL pointer.

To resolve this issue, it is necessary to pass the address of a stub
variable to the function.

Fixes: 95046b927a54 ("be2net: refactor MAC-addr setup code")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
Link: https://patch.msgid.link/20260120113734.20193-1-a.vatoropin@crpt.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/emulex/benet/be_cmds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index d6984c179bae0..a0f4bfe522d44 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -3796,6 +3796,7 @@ int be_cmd_get_perm_mac(struct be_adapter *adapter, u8 *mac)
 {
 	int status;
 	bool pmac_valid = false;
+	u32 pmac_id;
 
 	eth_zero_addr(mac);
 
@@ -3808,7 +3809,7 @@ int be_cmd_get_perm_mac(struct be_adapter *adapter, u8 *mac)
 						       adapter->if_handle, 0);
 	} else {
 		status = be_cmd_get_mac_from_list(adapter, mac, &pmac_valid,
-						  NULL, adapter->if_handle, 0);
+						  &pmac_id, adapter->if_handle, 0);
 	}
 
 	return status;
-- 
2.51.0




