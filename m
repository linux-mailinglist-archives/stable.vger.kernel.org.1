Return-Path: <stable+bounces-248286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBHUJUpLB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:35:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1275C55385E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C14E33211043
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2773FD954;
	Fri, 15 May 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RfbcVWgo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195D3FD94F;
	Fri, 15 May 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861346; cv=none; b=fs10LU5PYwH1SvYlxx7DsooWtcz0vm2lxxyGvanB/sn9A/vyoHJeVbHiZZRU1HYxGoLk6n83hiwtOhHg+Lg5ErHKH9e94QHnNzbx/3Z6BGg+vdcRY2XQBupAX+2b/+mgmFmMWL37V79SYP7B5a9yJEVHWNFPXrz6GAyS2dgzgLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861346; c=relaxed/simple;
	bh=Wnip4S9xK+2wZe9Qn3pGGjwjP1X+4CsE9e61mM5YWY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCMR4M2yC9y+2T1lEZIwpzYyat2GZAIuNqFD5nwYvK16aAqLG3saB8vMJ5AyUPuFk6jPacO7jwSm7JtX7tSW+91Pf6FqZdbDEkbfpjjw+ZgAlY6D6AZXrK9LVduQGh2NDoYUKfOUYEzwSo0ePtkajBZfeP8GAjI3JeUSOsrz3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RfbcVWgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FD1C2BCB0;
	Fri, 15 May 2026 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861345;
	bh=Wnip4S9xK+2wZe9Qn3pGGjwjP1X+4CsE9e61mM5YWY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfbcVWgolCYmAWg665RkuxY+kRbAY7MBnu6rkvruMDyyvGCqOyih5LRx0RlskhZL3
	 PlaxV4nDU/JUYJAy/Neg28Nxt1Ab7c6OmYOpbzYcxh9dXWJ7qmsLomclDU1iZ3Q1WN
	 wZT8hTSR2VFySjvwjY2e32bwdhhs+O37KnxD3KeU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.6 251/474] dm-thin: fix metadata refcount underflow
Date: Fri, 15 May 2026 17:46:00 +0200
Message-ID: <20260515154720.430458758@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 1275C55385E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248286-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 09a65adc7d8bbfce06392cb6d375468e2728ead5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/persistent-data/dm-btree-remove.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/md/persistent-data/dm-btree-remove.c
+++ b/drivers/md/persistent-data/dm-btree-remove.c
@@ -490,12 +490,20 @@ static int rebalance_children(struct sha
 
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
 



