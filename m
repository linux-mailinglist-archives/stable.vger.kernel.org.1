Return-Path: <stable+bounces-251403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAzxKPz6DWru5AUAu9opvQ
	(envelope-from <stable+bounces-251403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D4595C69
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624A53432B77
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2633F44F7;
	Wed, 20 May 2026 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxtBVZCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928E372B58;
	Wed, 20 May 2026 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297889; cv=none; b=kqNE9LSl2ewEkennVJlCdjOtbdEvGHr9h3Wf/FDXhbilMfuqovYjHxJB5MmRWKAyj9f5+IquVFj/QFKaogFySQ1w8H55r6YVhs2J2tiIz6tI7gNaQHJtiu4V1uISXuz4vpnbBPx8+reXCvHaTFJxFs8IKtgqSTN8j4Q7ujuElCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297889; c=relaxed/simple;
	bh=7vMsgE9V1uHYyvV4r9Zv8S+7NNP2j5rWPRch826EE1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaCyisRYaq3MFBUFQa1FL06GoQD22RwOsuNptMbwyMp+GkxD16MXAslgmStnytaRp28OFFbtADtEqdhUF1Q3dirQZP2x1h++nFSS9e5Dw/L7IR5CQGVZypQ04rS5Ep3cjZKxFk8Nnc1A4r+tW+xX2nVBmPUffbdeya45zE3NXss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxtBVZCY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D3D1F000E9;
	Wed, 20 May 2026 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297888;
	bh=T8WtAwgAjbTSPA8k8TKUD8iWTU85NN7Q1cY3Taft/qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxtBVZCY0yg0q1Hu0wU9rkB0fUkiS99MlvGFVUPewDvdQTzu0B6B0gWQF2Bu5A/Og
	 CAN+uzkCLmMXSnbHIT12OT+Fet/jusRi3fasKyCd1bMrx6+JvNKFC+9G2VHs6IiA2I
	 8oG1G8fPZWL5rKpUWQ6S8hatnUBSfdom6VhmNaUU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming-Hung Tsai <mtsai@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 201/957] dm cache policy smq: fix missing locks in invalidating cache blocks
Date: Wed, 20 May 2026 18:11:24 +0200
Message-ID: <20260520162138.905099815@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251403-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 484D4595C69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming-Hung Tsai <mtsai@redhat.com>

[ Upstream commit 2d1f7b65f5deedd2e6b09fdc6ea27f8375f24b45 ]

In passthrough mode, the policy invalidate_mapping operation is called
simultaneously from multiple workers, thus it should be protected by a
lock. Otherwise, we might end up with data races on the allocated blocks
counter, or even use-after-free issues with internal data structures
when doing concurrent writes.

Note that the existing FIXME in smq_invalidate_mapping() doesn't affect
passthrough mode since migration tasks don't exist there, but would need
attention if supporting fast device shrinking via suspend/resume without
target reloading.

Reproduce steps:

1. Create a cache device consisting of 1024 cache entries

dmsetup create cmeta --table "0 8192 linear /dev/sdc 0"
dmsetup create cdata --table "0 131072 linear /dev/sdc 8192"
dmsetup create corig --table "0 262144 linear /dev/sdc 262144"
dd if=/dev/zero of=/dev/mapper/cmeta bs=4k count=1 oflag=direct
dmsetup create cache --table "0 262144 cache /dev/mapper/cmeta \
/dev/mapper/cdata /dev/mapper/corig 128 2 metadata2 writethrough smq 0"

2. Populate the cache, and record the number of cached blocks

fio --name=populate --filename=/dev/mapper/cache --rw=randwrite --bs=4k \
--size=64m --direct=1
nr_cached=$(dmsetup status cache | awk '{split($7, a, "/"); print a[1]}')

3. Reload the cache into passthrough mode

dmsetup suspend cache
dmsetup reload cache --table "0 262144 cache /dev/mapper/cmeta \
/dev/mapper/cdata /dev/mapper/corig 128 2 metadata2 passthrough smq 0"
dmsetup resume cache

4. Write to the passthrough cache. By setting multiple jobs with I/O
   size equal to the cache block size, cache blocks are invalidated
   concurrently from different workers.

fio --filename=/dev/mapper/cache --name=test --rw=randwrite --bs=64k \
--direct=1 --numjobs=2 --randrepeat=0 --size=64m

5. Check if demoted matches cached block count. These numbers should
   match but may differ due to the data race.

nr_demoted=$(dmsetup status cache | awk '{print $12}')
echo "$nr_cached, $nr_demoted"

Fixes: b29d4986d0da ("dm cache: significant rework to leverage dm-bio-prison-v2")
Signed-off-by: Ming-Hung Tsai <mtsai@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-policy-smq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index 7e1e8cc0e33a3..76a35cce85028 100644
--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -1589,14 +1589,18 @@ static int smq_invalidate_mapping(struct dm_cache_policy *p, dm_cblock_t cblock)
 {
 	struct smq_policy *mq = to_smq_policy(p);
 	struct entry *e = get_entry(&mq->cache_alloc, from_cblock(cblock));
+	unsigned long flags;
 
 	if (!e->allocated)
 		return -ENODATA;
 
+	spin_lock_irqsave(&mq->lock, flags);
 	// FIXME: what if this block has pending background work?
 	del_queue(mq, e);
 	h_remove(&mq->table, e);
 	free_entry(&mq->cache_alloc, e);
+	spin_unlock_irqrestore(&mq->lock, flags);
+
 	return 0;
 }
 
-- 
2.53.0




