Return-Path: <stable+bounces-220019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EHgKikiomm4zwQAu9opvQ
	(envelope-from <stable+bounces-220019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 00:00:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9221BED81
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 00:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B10E73031AF7
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED392DC76B;
	Fri, 27 Feb 2026 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h00peL+A"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355351C2AA
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233254; cv=none; b=J/kZDu+V/5t5nK743Fyzws4taqGFQADxAh4hvVg470S36+KRefM6K+EUpbKjUT/vjFlTSRc4MNHwZ0YGm6mpxgkKIjhJwUT4DgkyUDmsPEottaF5PjXPu53ftb34H8GKkqykfLkEr/tOSmavwJ8PH7KlfjcywZUwzimedbVd+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233254; c=relaxed/simple;
	bh=jikt4BO5bKr68du97aEy1rmSSVZVowMT1HhoobeHQAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQ1p/i/O4JBTIKGIjC5R/6S86ipU8NzYn5MSpSPIxKkNsZh1r+UCh5Or8NwrRhAvS7PV6TeXqqjQdYt5zxZa87CYK2xjGtyv+HrbbvAqs9xzAAszu4rZEJyYqvQeD1Rt/wcKMc1sc50R8kV73Y07nFWWzRuWCUBHwS5Gh2E65sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h00peL+A; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772233250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f83mZvouigfOnm3JS7ZtfSKIhAmQ+Bxe6S0lXNepeKM=;
	b=h00peL+AccAhBGNphQwdzqANq+R2EFOQu50iORciSlJ4eDZBommnIssqbmu99doaXHiRsp
	pSW+pUUYlCZ1fTb9VLYdqIrDnDdbtqI8JRraRLhlRBGOXKfhm+46IkfSTFV7U2V2E/i7eE
	BEvZ6M5Pga8na4nPvKEZBBnpgQBNIxQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Coiby Xu <coxu@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crash_dump: Don't log dm-crypt key bytes in read_key_from_user_keying
Date: Sat, 28 Feb 2026 00:00:09 +0100
Message-ID: <20260227230008.858641-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220019-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 0F9221BED81
X-Rspamd-Action: no action

When debug logging is enabled, read_key_from_user_keying() logs the
first 8 bytes of the key payload and partially exposes the dm-crypt key.
Stop logging any key bytes.

Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/crash_dump_dm_crypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 27a144920562..5ce958d069dd 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -168,8 +168,8 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 
 	memcpy(dm_key->data, ukp->data, ukp->datalen);
 	dm_key->key_size = ukp->datalen;
-	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
-		      dm_key->key_desc, dm_key->data);
+	kexec_dprintk("Get dm crypt key (size=%u) %s\n", dm_key->key_size,
+		      dm_key->key_desc);
 
 out:
 	up_read(&key->sem);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


