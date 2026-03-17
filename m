Return-Path: <stable+bounces-226379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAVEBR+JuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:02:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFC2AED32
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 843FF30A9897
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4EF3F54B4;
	Tue, 17 Mar 2026 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MqjKyQzu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B713EAC6F;
	Tue, 17 Mar 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766439; cv=none; b=ZahaYgwqkU2y0jBUm9y3Yle1ldqgC/JVDOk1MLofQQF67kl3YdfNXo4sqSe6IerD87YaLl0J/Ge8Qo+tzLG9clPGvjhCZvpPedYHJJCaKr8tIpm9ypptbudD7upE0DCOTc4hsuZb5sSDyX5z2f27JpPgloab/TJOY4bJsTKgkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766439; c=relaxed/simple;
	bh=rSLHmBZrVL+A7xzvjAaH6JDYyJtrPcUWn9J0yPUyeFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRwZhgAZWOF1t1XTx/SM5qxwqT1vGCRy8wc4U7KcCBNO0TITwUVKseWxmj0W3xhrxRQy5e+HI2cutZ+fGhb+cxWrNU78tWS26iIKThbbNudRtZvRZx1x/Rxu81G0+iDCJnU6xXlh7XHLztsng2Gf+vNBPOLbl8larr97OdWM+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MqjKyQzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6869CC4CEF7;
	Tue, 17 Mar 2026 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766438;
	bh=rSLHmBZrVL+A7xzvjAaH6JDYyJtrPcUWn9J0yPUyeFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqjKyQzuxkroUQvzqGeJuXyGmYI6NXb3Ck8G98e7Z8CHM6ku81EutTY4acE7b/rpG
	 FsH1hgimf6K6a+q5oJF+6/SMU0tT5Eiz3yQMGtDTrO12Gh9aEZHcbyOtP3JYoEK2zY
	 yyDVWxan/yyapqwwjK7gSF5xjLvabzd0MtX4pzB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.19 247/378] ixgbevf: fix link setup issue
Date: Tue, 17 Mar 2026 17:33:24 +0100
Message-ID: <20260317163016.108477715@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226379-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,mpg.de:email]
X-Rspamd-Queue-Id: 18BFC2AED32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

commit feae40a6a178bb525a15f19288016e5778102a99 upstream.

It may happen that VF spawned for E610 adapter has problem with setting
link up. This happens when ixgbevf supporting mailbox API 1.6 cooperates
with PF driver which doesn't support this version of API, and hence
doesn't support new approach for getting PF link data.

In that case VF asks PF to provide link data but as PF doesn't support
it, returns -EOPNOTSUPP what leads to early bail from link configuration
sequence.

Avoid such situation by using legacy VFLINKS approach whenever negotiated
API version is less than 1.6.

To reproduce the issue just create VF and set its link up - adapter must
be any from the E610 family, ixgbevf must support API 1.6 or higher while
ixgbevf must not.

Fixes: 53f0eb62b4d2 ("ixgbevf: fix getting link speed data for E610 devices")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -852,7 +852,8 @@ static s32 ixgbevf_check_mac_link_vf(str
 	if (!mac->get_link_status)
 		goto out;
 
-	if (hw->mac.type == ixgbe_mac_e610_vf) {
+	if (hw->mac.type == ixgbe_mac_e610_vf &&
+	    hw->api_version >= ixgbe_mbox_api_16) {
 		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
 		if (ret_val)
 			goto out;



