Return-Path: <stable+bounces-212387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHpDMnsyeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:59:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DFBA4E40
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E9E319F6C1
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5361306B06;
	Wed, 28 Jan 2026 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rOsnetFd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECF3043B2;
	Wed, 28 Jan 2026 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615349; cv=none; b=OyXcMBwQnVNckw9xP6sg7AMcYLDJwBl84fbbAPt4p3/pv35d6C43HGNpPyc81PaHqh0Gbc1/vFEX8L9Rg/6aUw2T90SA1ew0bzF0uX1wik+rEpzLvOYKWSjEqMWdDkl03+G7GFbetR66/792BY4bbZpkz9NF4LdKdGIYYd6/XHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615349; c=relaxed/simple;
	bh=KjwKhvZgTXP0Jfq8uS8qjtmzxVpdh1JYzCkQSxNkKcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB6QV11Qo8ZYULHFpAyB7xYiVV8twabHqJ6qt/ab3zNel+duXnhQ2sWZma4dpd0d/PdKUSKVw4wD0adWGPmhYmyVSY/6p7Rhm9LiI8ec3rj5DbmhZYEaHz7JC9qYgkEJgtVWHF+aeR89vFwRkWEzrr28YKobVqstuP7wn0UC0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rOsnetFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F93C4CEF1;
	Wed, 28 Jan 2026 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615349;
	bh=KjwKhvZgTXP0Jfq8uS8qjtmzxVpdh1JYzCkQSxNkKcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOsnetFdx0ZeDxP4WaXsQc+yeDSMoE/5WjQinbhQV/hE0DPwGxiKuRwQJi88Psett
	 SqI0WF/VJOv8ZVZpljQgaZ167QVNtF472R1KQGMOpe6ImBOgyvjzL/Nqmkp+rlDpFV
	 ya2N7mAFnicfu+5GAmtF7CynGNZ5uuHWJDI4QG5g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@nabladev.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.12 120/169] wifi: rsi: Fix memory corruption due to not set vif driver data size
Date: Wed, 28 Jan 2026 16:23:23 +0100
Message-ID: <20260128145338.322849355@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212387-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 30DFBA4E40
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@nabladev.com>

commit 4f431d88ea8093afc7ba55edf4652978c5a68f33 upstream.

The struct ieee80211_vif contains trailing space for vif driver data,
when struct ieee80211_vif is allocated, the total memory size that is
allocated is sizeof(struct ieee80211_vif) + size of vif driver data.
The size of vif driver data is set by each WiFi driver as needed.

The RSI911x driver does not set vif driver data size, no trailing space
for vif driver data is therefore allocated past struct ieee80211_vif .
The RSI911x driver does however use the vif driver data to store its
vif driver data structure "struct vif_priv". An access to vif->drv_priv
leads to access out of struct ieee80211_vif bounds and corruption of
some memory.

In case of the failure observed locally, rsi_mac80211_add_interface()
would write struct vif_priv *vif_info = (struct vif_priv *)vif->drv_priv;
vif_info->vap_id = vap_idx. This write corrupts struct fq_tin member
struct list_head new_flows . The flow = list_first_entry(head, struct
fq_flow, flowchain); in fq_tin_reset() then reports non-NULL bogus
address, which when accessed causes a crash.

The trigger is very simple, boot the machine with init=/bin/sh , mount
devtmpfs, sysfs, procfs, and then do "ip link set wlan0 up", "sleep 1",
"ip link set wlan0 down" and the crash occurs.

Fix this by setting the correct size of vif driver data, which is the
size of "struct vif_priv", so that memory is allocated and the driver
can store its driver data in it, instead of corrupting memory around
it.

Cc: stable@vger.kernel.org
Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Signed-off-by: Marek Vasut <marex@nabladev.com>
Link: https://patch.msgid.link/20260109235817.150330-1-marex@nabladev.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -2028,6 +2028,7 @@ int rsi_mac80211_attach(struct rsi_commo
 
 	hw->queues = MAX_HW_QUEUES;
 	hw->extra_tx_headroom = RSI_NEEDED_HEADROOM;
+	hw->vif_data_size = sizeof(struct vif_priv);
 
 	hw->max_rates = 1;
 	hw->max_rate_tries = MAX_RETRIES;



