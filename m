Return-Path: <stable+bounces-237540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIZcJpcm3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:23:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D63F14C7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2CC031DFCB0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302734B1AD;
	Mon, 13 Apr 2026 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X/Jgvuhh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0671D34A3DB;
	Mon, 13 Apr 2026 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099718; cv=none; b=s+paAhkroAj0IMmMTrIPOjxQ4YOEyxEmGunAHBLlDJWFmpWjv2he3Uej/DTnZu+dwi9FGbpGT4ATTIjTKkODQ7G0XumcjgM6UDKSQO8Uu7LB5WuXfOIr+wItXepH84hq/9ObpW68w2yj+U9xX05LkgEt22AA70ImJ08avtBmhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099718; c=relaxed/simple;
	bh=2wXqSwvt4iNmftJXZ3QTFewII+MM8jLJ2n2ehdEpKYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKcVlx35RNS92M9sEeLCySo6QzAGShdwvwAJygxHPTqR6UX+QiBOpRJ6PhiTJKq+cFyW8eBAGIdi9P54V+qZRJAEMjmQ7g1pBVsfUR4fA0fb2kMgQZMLmPdhllPtbfyUvc97qyE5605pei2Hay/vkHAlPtIY8lW806ru2AqToaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X/Jgvuhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9009AC2BCAF;
	Mon, 13 Apr 2026 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099717;
	bh=2wXqSwvt4iNmftJXZ3QTFewII+MM8jLJ2n2ehdEpKYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/Jgvuhh8L8sVEV8b2eDglaYhfTftFakHKfELeI+GBhZwhedwIFkiF/+wQAfDbMNg
	 FE0MDv/kdq3oPLjLOz4DU2rwQKC+F9lNDjRnL3F7YHGEgYJUSSqBvFgUR0FRcZzPUW
	 doAOpoekdq8yi7sYc8FDofC/VMXmjMJP9eJ83GyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Ruide Cao <caoruide123@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.10 447/491] batman-adv: reject oversized global TT response buffers
Date: Mon, 13 Apr 2026 18:01:32 +0200
Message-ID: <20260413155835.762663246@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237540-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,narfation.org,simonwunderlich.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,simonwunderlich.de:email,narfation.org:email,lzu.edu.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: ED3D63F14C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruide Cao <caoruide123@gmail.com>

commit 3a359bf5c61d52e7f09754108309d637532164a6 upstream.

batadv_tt_prepare_tvlv_global_data() builds the allocation length for a
global TT response in 16-bit temporaries. When a remote originator
advertises a large enough global TT, the TT payload length plus the VLAN
header offset can exceed 65535 and wrap before kmalloc().

The full-table response path still uses the original TT payload length when
it fills tt_change, so the wrapped allocation is too small and
batadv_tt_prepare_tvlv_global_data() writes past the end of the heap object
before the later packet-size check runs.

Fix this by rejecting TT responses whose TVLV value length cannot fit in
the 16-bit TVLV payload length field.

Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Cc: stable@vger.kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/translation-table.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -849,8 +849,8 @@ batadv_tt_prepare_tvlv_global_data(struc
 {
 	u16 num_vlan = 0;
 	u16 num_entries = 0;
-	u16 change_offset;
-	u16 tvlv_len;
+	u16 tvlv_len = 0;
+	unsigned int change_offset;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
 	u8 *tt_change_ptr;
@@ -868,6 +868,11 @@ batadv_tt_prepare_tvlv_global_data(struc
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(num_entries);
 
+	if (change_offset > U16_MAX || *tt_len > U16_MAX - change_offset) {
+		*tt_len = 0;
+		goto out;
+	}
+
 	tvlv_len = *tt_len;
 	tvlv_len += change_offset;
 



