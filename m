Return-Path: <stable+bounces-234823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JQfK8mn1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:08:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D003C27B3
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFE7C3080189
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4A346FB0;
	Wed,  8 Apr 2026 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l7K97q2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A22BEFFF;
	Wed,  8 Apr 2026 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673855; cv=none; b=oLv5KQEvxqghr6Cw9I6SMJoUkAw0e4dybm8HcMLWPt2cSmdFPA/S5r2dUfsyNYOaMpYsCaOpvm/I4mrfeIfwSOeBH5UuGaY5WpA6eKr3Uo6lhdC0Cp+bXn0Ae1h8kiRTxXBF6HlWe0PpcCIhHJtRGIrKCmgAxHPk+pOsWeERvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673855; c=relaxed/simple;
	bh=SNplQiqoSOcfYwe1S2YMv3WpOwJ5yiwgkGpvGDoXRHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omYbmt2KsSdMK4nMPO7owyisg3fBQPMICMY5uBMsRJI3CXWPuVYzZZK3S0optMyz83ZGRQqHNHoYHWJoJQIIWmswJ7AasFIGCH0XFlvdH2X0ppPA13jhVsV7b10/RHN2m0tdrFZyBjxjcYGJcS2DhlH0EOx/L9f2EXaDcGcYxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l7K97q2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC98DC2BC87;
	Wed,  8 Apr 2026 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673855;
	bh=SNplQiqoSOcfYwe1S2YMv3WpOwJ5yiwgkGpvGDoXRHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7K97q2crkI+gKjUNGORvGWgzqcRBd1e0r3nhWsijZ6XBCP/oADFG50u46M6EfRk2
	 72u5yWQq8cQdR6FYBTb9QONoqRkJS9j47M75n39ZG7xEUE4U1qvtVDi8B3Z9l6fa+9
	 n7tpIwzx0VYIxkdhyrp+s7lTyjKw6yU/iJw28MX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.12 116/242] wifi: iwlwifi: mvm: fix potential out-of-bounds read in iwl_mvm_nd_match_info_handler()
Date: Wed,  8 Apr 2026 20:02:36 +0200
Message-ID: <20260408175931.429955769@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234823-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,ispras.ru:email,intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: 24D003C27B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>

commit 744fabc338e87b95c4d1ff7c95bc8c0f834c6d99 upstream.

The memcpy function assumes the dynamic array notif->matches is at least
as large as the number of bytes to copy. Otherwise, results->matches may
contain unwanted data. To guarantee safety, extend the validation in one
of the checks to ensure sufficient packet length.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org
Fixes: 5ac54afd4d97 ("wifi: iwlwifi: mvm: Add handling for scan offload match info notification")
Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
Link: https://patch.msgid.link/20260207150335.1013646-1-a.velichayshiy@ispras.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3195,7 +3195,7 @@ static void iwl_mvm_nd_match_info_handle
 	if (IS_ERR_OR_NULL(vif))
 		return;
 
-	if (len < sizeof(struct iwl_scan_offload_match_info)) {
+	if (len < sizeof(struct iwl_scan_offload_match_info) + matches_len) {
 		IWL_ERR(mvm, "Invalid scan match info notification\n");
 		return;
 	}



