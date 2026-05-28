Return-Path: <stable+bounces-254951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCeYNfwtGGqyfQgAu9opvQ
	(envelope-from <stable+bounces-254951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:58:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5835F1B5C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AAD9306129F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042393E5EC7;
	Thu, 28 May 2026 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1DMNBXfZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C043E63AF
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969440; cv=none; b=jUWxZM46IiHyKMtbQeQ0Qf//MCI6EVSaKUmtK7CkIbQtt0s89kL0oLvLHsijyiQkx1NemKU5OfOI+2AQq6t82ck3eTtPo6gF5kJV0zTort1Z+5+Xgv+nLz6VbsKz9cd4pn/mhp3JxiROj/YPnmjmZynHif9bmF6U/p8N7JKAwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969440; c=relaxed/simple;
	bh=glarzOXD1zT5Iud5F6/f9Hj11nsTTmZiT9s6hLtXJr4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MLs5E78a2eSV3v9jR69Ep/VYfc6U49zlS0Yj1XdT8PEWVCJWud/JPdLE0tHDakW2lVYYC0bGsh8dkJ8dHDHxaqSn5aTpcT12QIWLAkJs1gpK4XQj43Ljp6QwwtVYBWquJSH5IbtJ1vUMhfjqh6LrkDZMxSZmcGDqhZgFlu9wM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1DMNBXfZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016AC1F00A3A;
	Thu, 28 May 2026 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779969439;
	bh=ORpWI1GAIaZ6LY7DbDa5tqYvZfUcTeUAFvgzznU054s=;
	h=Subject:To:Cc:From:Date;
	b=1DMNBXfZs7COnfnHForyTp5TOR0DWfI07jJzLmMCGHPPlSsXEuRQDOhmrSQjbgA2W
	 0lrwOBP3LGdJau9ClI61d3xj+GW1QnfYrSYgJlzmUPtw3KGngZUIPVAOfCcW0Nht3L
	 6hPp2mVimNfnG0ORPCPyZXoaHcUuIc65gx8ANxgw=
Subject: FAILED: patch "[PATCH] batman-adv: tt: reject oversized local TVLV buffers" failed to apply to 6.12-stable tree
To: sven@narfation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:56:26 +0200
Message-ID: <2026052826-badly-emote-1554@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254951-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,narfation.org:email,gregkh:email]
X-Rspamd-Queue-Id: 9F5835F1B5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1e9fab756f8395096d5bba7be0c373c4c8f5d165
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052826-badly-emote-1554@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e9fab756f8395096d5bba7be0c373c4c8f5d165 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 2 May 2026 19:08:37 +0200
Subject: [PATCH] batman-adv: tt: reject oversized local TVLV buffers

The commit 3a359bf5c61d ("batman-adv: reject oversized global TT response
buffers") added a check to ensure that a global return buffer size can be
stored in an u16. The same buffer handling also exists for the local data
buffer but was not touched.

A similar check should be also be in place for the local TVLV buffer. It
doesn't have the similar attack surface because it is only generated from
locally discovered MAC addresses but the dynamic nature could still cause
temporarily to large buffers.

Cc: stable@kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 05cddcf994f6..06548dae1039 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -877,12 +877,12 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_meshif_vlan *vlan;
+	size_t change_offset;
 	u16 num_vlan = 0;
 	u16 vlan_entries = 0;
 	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
-	int change_offset;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -900,8 +900,10 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(total_entries);
 
-	tvlv_len = *tt_len;
-	tvlv_len += change_offset;
+	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
+		tvlv_len = 0;
+		goto out;
+	}
 
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {


