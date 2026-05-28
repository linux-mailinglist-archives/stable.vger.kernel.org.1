Return-Path: <stable+bounces-254929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJcIABUuGGqyfQgAu9opvQ
	(envelope-from <stable+bounces-254929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:59:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED75F1B9E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBFB3310A39A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A349C3E316E;
	Thu, 28 May 2026 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VUj0w8Ly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37E3DEAFB
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969308; cv=none; b=oC8ykj5y94TKbkJkB9a7UohDK6ncyJkyxNohBxuwMwIL6tAqi6da9ZUYchc5uptSGe0nGa9bckbKypdNopw5w9Rs55CXTqQH63V3FzRupEqlhcnAX4r7eywLYgsxEfLztieXuJXHmGYJziUdHW5Uufv9ug+eYhUoclXGMw4uK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969308; c=relaxed/simple;
	bh=oQ/tOW/Y2iWPzMb6MtaWz+sCMizjPQm90TjEJD9NjaQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Gehf5d/khJQulXYHGfMgcopMZ7ZHQjXBOT8BM8TRrdO9vOeUdbL8gHTICqcFeT9kfwkB8oGp+l9hXoLNdQP7Z1lS1lXm+wbEC9cn6bQO93xkAqeTel+dYzSmy5cRN7svmFnCjBslILFR/rbyTp/LbqRtrYv6giqaqp8/D7q3hsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VUj0w8Ly; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CC01F000E9;
	Thu, 28 May 2026 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779969307;
	bh=2JdSpQivjZS5+Jjw9qHmJaqejrs/XLzYsTzMcc5zpG8=;
	h=Subject:To:Cc:From:Date;
	b=VUj0w8LyeJjWW5YECiyRpUIscl2LxHylG1mXes9owufDpEHM/3qEgGrK79yBvlsc8
	 tNEbg4QMIeWsUCkeDsWlBzGfkRflq91ugo5AIJxFWykqbW3hKS9FOUVkXkjKLBHCGZ
	 jgBAPCfjLWtNKI6JOmBN2ff4AhojFFFWO8AiSG4o=
Subject: FAILED: patch "[PATCH] batman-adv: bla: avoid NULL-ptr deref for claim via dropped" failed to apply to 6.1-stable tree
To: sven@narfation.org,idosch@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:54:09 +0200
Message-ID: <2026052809-jacket-grill-2912@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254929-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,narfation.org:email,linuxfoundation.org:dkim,gregkh:email,nvidia.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 7CED75F1B9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f80d3d98d2ff78d9e2fe5d68b1f45948c4f7bd24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052809-jacket-grill-2912@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f80d3d98d2ff78d9e2fe5d68b1f45948c4f7bd24 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:23:49 +0200
Subject: [PATCH] batman-adv: bla: avoid NULL-ptr deref for claim via dropped
 interface

Without rtnl_lock held, a hardif might be retrieved as primary interface of
a meshif, but then (while operating on this interface) getting decoupled
from the mesh interface. In this case, the meshif still exists but the
pointer from the primary hardif to the meshif is set to NULL.

The mesh_iface must be checked first to be non-NULL before continuing to
send an ARP request using meshif.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Reported-by: syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9fdcc9f05a98a540b816
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 1bef12e659cb..ffe854018bd3 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -356,12 +356,14 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	       sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
-	mesh_iface = primary_if->mesh_iface;
+	mesh_iface = READ_ONCE(primary_if->mesh_iface);
+	if (!mesh_iface)
+		goto out;
 
 	skb = arp_create(ARPOP_REPLY, ETH_P_ARP,
 			 /* IP DST: 0.0.0.0 */
 			 zeroip,
-			 primary_if->mesh_iface,
+			 mesh_iface,
 			 /* IP SRC: 0.0.0.0 */
 			 zeroip,
 			 /* Ethernet DST: Broadcast */


