Return-Path: <stable+bounces-227479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOq0LKQLvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:56:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D32D791D
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43D793010D8B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE2364935;
	Fri, 20 Mar 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DO8md27f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C71248886
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996843; cv=none; b=eGY7vtWSqiBnCIU6ThzcRFtJQyKcyYRGgJM4ibNkWFXWsODyFLaXn3jGvl0OuJlza8bpqPP+HG6HwiBkZrI2rEROK9ZhuZNtk3UpW1t0VRCTjHZyt+Vfnl5eQank7cQAcXiAlAGC0S+/pkIO5Ds4Ocn94+GO8VRVNWunm3y9YUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996843; c=relaxed/simple;
	bh=LJ2M4kw/8XXEOtCGNOaKRutG8h4UQAjTUfcDiR2tFdg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OICD+eOFj9ht/R3ZM3N1Ddzn+J4FiVz6kkdjPTeiAsU5k542uqCL2x7vo63Aat2Oe5XnyZyujUEfXrsJHXfwWd6N43xoGom+UdxyTU8XpyrexYhrFEn5XP5f8Gounev/Unl9QlffQXu+yJUK2Gkv3pTDAhuXJnkFmh+jQdXwlZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DO8md27f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5884AC2BC87;
	Fri, 20 Mar 2026 08:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773996842;
	bh=LJ2M4kw/8XXEOtCGNOaKRutG8h4UQAjTUfcDiR2tFdg=;
	h=Subject:To:Cc:From:Date:From;
	b=DO8md27fPQsu8ndBISwK39SF1wstuNujVufJoexdL8DLwMDAhB+GHm+qDefQsQCiH
	 oK9WEMsXF67aSAuFOMJ3M5hWRtFRZUTLaY7LmQrH2qcKSzyljZZufskobUn4mzgsk9
	 IEEVASPAaX6xfMwkTwv8hUn0k5tjQECnCG1sU/y4=
Subject: FAILED: patch "[PATCH] batman-adv: avoid OGM aggregation when skb tailroom is" failed to apply to 6.12-stable tree
To: n05ec@lzu.edu.cn,bird@lzu.edu.cn,sven@narfation.org,sw@simonwunderlich.de,tanyuan98@outlook.com,tomapufckgml@gmail.com,yifanwucs@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2026 09:53:57 +0100
Message-ID: <2026032056-kettle-helmet-7e5d@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lzu.edu.cn,narfation.org,simonwunderlich.de,outlook.com,gmail.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227479-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[narfation.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.924];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 4B7D32D791D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0d4aef630be9d5f9c1227d07669c26c4383b5ad0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032056-kettle-helmet-7e5d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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
 


