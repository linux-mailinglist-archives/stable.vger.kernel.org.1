Return-Path: <stable+bounces-266475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FAhgEX+fMWoYogUAu9opvQ
	(envelope-from <stable+bounces-266475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:09:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5A694CE5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:09:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=yEEccKtL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266475-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266475-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B8C331A52B2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBE43DBD76;
	Tue, 16 Jun 2026 19:03:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49B318EDA;
	Tue, 16 Jun 2026 19:03:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636609; cv=none; b=RmhOuGXP3ZgkclaLVRYLtZCDchozeX3HeZ8ya4wRYkSZwcpbsyKSho3Jh7n9vjSBV3jHJzLysmcEqQh0Ey0W4FsRYc3Z4U3RNs2YnVk+sHZ90iRHMK7+cq6MHJZcpRZ/Pur9yK066nxZUHUGHyk34KTFE4AyOofHyLtsH0lcwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636609; c=relaxed/simple;
	bh=OkM24r8u9eOA5sUtBf8+JYmFCMxTIfZovCk+lMph124=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQrP/R/XCcgVichOwq6ofAq2J2GifTq9kXAaUdCgso5q0hIGc7XcrTnqCbz7M33zfCbwTgmzqzUrrgmoHRYFUxYFZdmScfpS98TAWGkoeArSbfmlVNHN3P66fwRBroWanIeW5qpxg5D7oMLOMwuNbT7HbdYhLIwZzLibDud6hts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yEEccKtL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8251F000E9;
	Tue, 16 Jun 2026 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636608;
	bh=wuVzxsNFs0koJgmgJ6feEJ5SEUFx6Li6BMETIMvOfTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yEEccKtLevah2ZgAhNUs3zDmUeyiot3n/yR1FJq7QviGT+R2LY+Awfqy4w7hUTthP
	 HaiOrHd2ayj3zm9ClYXVQEl1I5s6bqtdFrlDg0bLiUhmJUbehB6G3XdaaoSbNV16AT
	 0vgEa9D7SJyoh/bJuZg3ETN/23/eJPBS3RvTbQWA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 271/342] dm-thin: fix metadata refcount underflow
Date: Tue, 16 Jun 2026 20:29:27 +0530
Message-ID: <20260616145100.952988006@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266475-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mpatocka@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0A5A694CE5

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 09a65adc7d8bbfce06392cb6d375468e2728ead5 ]

There's a bug in dm-thin in the function rebalance_children. If the
internal btree node has one entry, the code tries to copy all btree
entries from the node's child to the node itself and then decrement the
child's reference count.

If the child node is shared (it has reference count > 1), we won't free
it, so there would be two pointers to each of the grandchildren nodes.
But the reference counts of the grandchildren is not increased, thus the
reference count doesn't match the number of pointers that point to the
grandchildren. This results in "device mapper: space map common: unable
to decrement block" errors.

Fix this bug by incrementing reference counts on the grandchildren if the
btree node is shared.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 3241b1d3e0aa ("dm: add persistent data library")
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/persistent-data/dm-btree-remove.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/md/persistent-data/dm-btree-remove.c
+++ b/drivers/md/persistent-data/dm-btree-remove.c
@@ -415,12 +415,20 @@ static int rebalance_children(struct sha
 
 	if (le32_to_cpu(n->header.nr_entries) == 1) {
 		struct dm_block *child;
+		int is_shared;
 		dm_block_t b = value64(n, 0);
 
+		r = dm_tm_block_is_shared(info->tm, b, &is_shared);
+		if (r)
+			return r;
+
 		r = dm_tm_read_lock(info->tm, b, &btree_node_validator, &child);
 		if (r)
 			return r;
 
+		if (is_shared)
+			inc_children(info->tm, dm_block_data(child), vt);
+
 		memcpy(n, dm_block_data(child),
 		       dm_bm_block_size(dm_tm_get_bm(info->tm)));
 



