Return-Path: <stable+bounces-227480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKXWLjkLvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:54:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F92D78C1
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4718A30074F1
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD22E06ED;
	Fri, 20 Mar 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kRlFjHN/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6212248886
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996848; cv=none; b=UbntyUG35O7DI2rLflPvBiyGt+jcSlOnNO0oulLgHyAWfeBgu5+Fmitq94S1PBXpiSIto2XkwyBJYcMU7MFwrfEzG3rrZNXf3aKi8pZSKiQmjpe0wtULH7N6CliN7+1YgaTdcwjay6nFsZSuUyxbDJpNQxXtMCiMvQ/GFbYJ/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996848; c=relaxed/simple;
	bh=zLl+TT89NGDt2vzQ384/BKRuTa4S8RONlKW43bSsDNo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tzNQTi6jpQqrb0QaLX5liwpmxjSIy3K4niO/YmYhw/6dLE65n44VzW9HrZqYtw5yMwLOaHCxbARZdXPxi1Ev9CnqtF/LkeSK2mLu0M9d1Z2grWhbDjl/VbR2JerdXClOzkrPgBcrZwcJgRmrGJGAxV0prVTZ3VV6xLN3Qsa8I1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kRlFjHN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D00C2BC87;
	Fri, 20 Mar 2026 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773996848;
	bh=zLl+TT89NGDt2vzQ384/BKRuTa4S8RONlKW43bSsDNo=;
	h=Subject:To:Cc:From:Date:From;
	b=kRlFjHN/TApGx3vSzpWdjref7SvafFFgKfZyQ1FCy5f43BrDuTT50D9Yle1poSPvu
	 snKz2Lk/416qKg4f/RDdNbAOef8jvHZGJCGMwg8Gh+QtFbRHKwuy6rKGdWHPDh4e/5
	 BExQF5avrUuXHvJ6/f0L2cCRVQvcZzHrYnwnzzQU=
Subject: FAILED: patch "[PATCH] batman-adv: avoid OGM aggregation when skb tailroom is" failed to apply to 6.6-stable tree
To: n05ec@lzu.edu.cn,bird@lzu.edu.cn,sven@narfation.org,sw@simonwunderlich.de,tanyuan98@outlook.com,tomapufckgml@gmail.com,yifanwucs@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2026 09:54:00 +0100
Message-ID: <2026032000-grumpily-detonator-0c67@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227480-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lzu.edu.cn,narfation.org,simonwunderlich.de,outlook.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.924];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: BB3F92D78C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0d4aef630be9d5f9c1227d07669c26c4383b5ad0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032000-grumpily-detonator-0c67@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d4aef630be9d5f9c1227d07669c26c4383b5ad0 Mon Sep 17 00:00:00 2001
From: Yang Yang <n05ec@lzu.edu.cn>
Date: Sat, 14 Mar 2026 07:11:27 +0000
Subject: [PATCH] batman-adv: avoid OGM aggregation when skb tailroom is
 insufficient

When OGM aggregation state is toggled at runtime, an existing forwarded
packet may have been allocated with only packet_len bytes, while a later
packet can still be selected for aggregation. Appending in this case can
hit skb_put overflow conditions.

Reject aggregation when the target skb tailroom cannot accommodate the new
packet. The caller then falls back to creating a new forward packet
instead of appending.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@vger.kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b75c2228e69a..f28e9cbf8ad5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -473,6 +473,9 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	if (aggregated_bytes > max_bytes)
 		return false;
 
+	if (skb_tailroom(forw_packet->skb) < packet_len)
+		return false;
+
 	if (packet_num >= BATADV_MAX_AGGREGATION_PACKETS)
 		return false;
 


