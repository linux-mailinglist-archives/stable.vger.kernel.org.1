Return-Path: <stable+bounces-261052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9+K7CuRDJWqEFQIAu9opvQ
	(envelope-from <stable+bounces-261052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 221D264F644
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=LLgEteYs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261052-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261052-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 605B7300372E
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05C5303CAE;
	Sun,  7 Jun 2026 10:11:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764A285CAE;
	Sun,  7 Jun 2026 10:11:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827103; cv=none; b=Bya4LxhlQlzQnKnWwUKjiKBeMVlNyZa/YL08oLUxVgWeyymtCvh8JbZC9hcBk0hcU2aMmlOqF96cQ032WuJxrbaJfx2eCgNplhjUmAXQwlm4eRyfxtGUBL1N5K6pM2Ft9buFqhZRJCQupjYvjStk21uRkHLeIZnCXGPG8SrIQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827103; c=relaxed/simple;
	bh=e5BtVyWX9kLBaI+tBJ8d8ZDSFkSPR3+2EJMkAmJgp54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4nth+0cEDAKCy90yFAboD3+yMPkmauggstV0e4sKwRMFGcuzEXJzzDM5luU2gzwurnb7FvIt5+YwQ5oUdpNj+ZfBxoYwMdLFhttLe8414wEKZVHF9etKMEeJ4rvvJQ43NaADDj6MhKYVHAVPXB2tCp4kY0YLh43g66tA2pMUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LLgEteYs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2788B1F00898;
	Sun,  7 Jun 2026 10:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827102;
	bh=JNwRqtCc/Fy0lucfpdeVEq1DCoYHWX0v1UWlKaCL6JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LLgEteYs6tpHOzpnSsBv9ZHpkdDtrQZ+3ubIPR+YzojIaSqROnHC3XN4yroRA4LaQ
	 cGigqFK5dCY7x+tz8V90r4DVsu4tnY9FGrccp4zXLTmybMHmHk9LE9eEcPEmdJNGkt
	 eeqO69ed9nv1VoRXaHNz665tfvrYV5IyLBgO+N/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 040/315] ethtool: rss: fix falsely ignoring indir table updates
Date: Sun,  7 Jun 2026 11:57:07 +0200
Message-ID: <20260607095729.027688125@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261052-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 221D264F644

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 8d60141a32875248ef71d49c9920fa5e2aa40b29 ]

rss_set_prep_indir() compares the new indirection table against the
current one to determine whether any update is needed. The memcmp
call passes data->indir_size as the length argument, but indir_size
is the number of u32 entries, not the byte count.

Fixes: c0ae03588bbb ("ethtool: rss: initial RSS_SET (indirection table handling)")
Link: https://patch.msgid.link/20260522230647.1705600-4-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/rss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 688c0e4bba69db..4877655f724419 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -684,7 +684,7 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 				ethtool_rxfh_indir_default(i, num_rx_rings);
 	}
 
-	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);
+	*mod |= memcmp(rxfh->indir, data->indir_table, alloc_size);
 
 	return 0;
 
-- 
2.53.0




