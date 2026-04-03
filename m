Return-Path: <stable+bounces-233167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCzuIQiQz2kzxQYAu9opvQ
	(envelope-from <stable+bounces-233167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:01:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAFB39319B
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B96A5302C347
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853D396593;
	Fri,  3 Apr 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ber0jQCC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tZAaVAYY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB208388E5D
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210500; cv=none; b=GCJTnUPOTncf+PAAuBOk2x+BbnD3N0T0ra/07aAhkSKvaQjZjsf4XmEKd1SjxSuipZJTw90NyXOpQMdcgQW53DJQ7vmIwBvOn35dDMsh2FXik9f8JHrlBBPeaK6FrHxCWNNYWvragSI7Dq87cBjfx5uE7/KjJNnDE8JnaknoHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210500; c=relaxed/simple;
	bh=L2JksKLbPNVq8Ac0770BvTv7J3yhCMVk8PpHriFElNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1iKgIazB2sg8UUnal0eWtJvu4sdhX499vYUH9DXhjN093AxJwht0wgquG5I1umOy2x+ZJCOR6zIMIZOIDcj1h3jxL1uNHg//JFNlcV4pd6/X15HHHKKTUt5jVOwqFiht9EfKFwxWMI1NXqFsNDF5lwuz44N17Jm9tMuNYQwgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ber0jQCC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tZAaVAYY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775210492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JpVYK1kYMsSmb0glYSul7QEcfCfzZZ/MPpQITA6+2SA=;
	b=ber0jQCCECPWvjhDqUHvJsByuTPZ1b0RP6+ISAlRPSt0QRzzVaTAcWMDBjj3rWqvO7naXj
	kb/DM7MDHe7QKGDhg1sWAv7qdqqVk+tzIZBWfXQiKlKlvIOda7NwaUNRqJ348oubz9f7Z8
	8zKpfG8CLQ25MgoF9TfiQcz5gReubPE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-USX1oS11P2qLUqeSCZ8xLQ-1; Fri, 03 Apr 2026 06:01:31 -0400
X-MC-Unique: USX1oS11P2qLUqeSCZ8xLQ-1
X-Mimecast-MFC-AGG-ID: USX1oS11P2qLUqeSCZ8xLQ_1775210490
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b258636d16so17788365ad.2
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775210490; x=1775815290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JpVYK1kYMsSmb0glYSul7QEcfCfzZZ/MPpQITA6+2SA=;
        b=tZAaVAYYb0137VzbY+O1YgVmN3tMuFJ4KX2MFnwnYn0J/KXGHZQgjEPgdmmAGR5VhE
         95BmTEzFK29jH8EkDIM6kAUurd9xi+oOiWmeGkjSAL8Ct0tux+2ESva4XslxdqCdMGYQ
         aEUgG+BqqUtA5wh/XMBoN0LAdh+YVYR2iSIvQOr5TP8yyW9RBKoKzQ3d0DHHEb+Zb5/T
         lQtEfDwu/7bqpPqKmbjpyxVuQHCnt6OyRFhGNyAbflb/WyWS8meZE7b+QHttzYOeb0oT
         zL/r7QK9FNlUzbJPasycKPRisYXsmQjU2zrP1UxZcpprp8r3BszNFU/JUlOsqRC/8qMu
         wN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210490; x=1775815290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpVYK1kYMsSmb0glYSul7QEcfCfzZZ/MPpQITA6+2SA=;
        b=PzIQovxxpnB3web2DoizShwBJX2ekIfdHCWtAOk3W0eZ8H28SEjSIbmn/97PeQ0u+K
         gG5RA3tqrU1VAoxyPH8Dpw1tHoRGDy5NT9b6y4dqfOSWvMjJDX8cC/MXhwZskux99nK1
         c1F+b/zXikqZuNdn83U23NBny3pIhV0/T0w6su9oS60lT9UKGxm+IUQNa7HR6OmuJTmA
         5F92iWTSp9Imd4rKpR6HsKqh5yRejJLmst3KNTB55pwHxtBgyj5a4PIT4QQc0xsRP6V1
         BhqmVi/f7m1Kp10SXE47gzNrEfUCAYVsgdcG8ndGQ1Qy0PYS+e+MflPqpPK1T3JzfxYu
         wa0g==
X-Gm-Message-State: AOJu0YxpinNxMwU/dgW/wWTwe1xKwbbfVDwASDzkVBt3/iDceUZU0q8K
	Z2+Zk4+wp/1PVOby9Yr2V3dnxuZZ0aYmRimlOwCWlKAY2bQfT1Lcj8HOrHQmZx/gXO3QD9XgR0k
	Fzy7NVn9fGxG3itlm8WBnMuMMXGjckygtJsiKqtOM0UdOM74wieZBoqxUAA==
X-Gm-Gg: AeBDieuhLeQmrhj3TsoLCMFB6iWml3iBoIyvum+Y6T0MWucQ8Ir7UVLLF0Ori9kEmYU
	D1KAKyQ5pzFj7UxG7kpBRVyWq3D7/X5frVw6ZcaruPPEnkRocigmsVL+1bwJ7WGFYkSePoecwuQ
	D4xCebkzVgi9BgH5mdYQn/9Qvj5NgUapuyOPueU7D75GCkbpryrN8FZo0I4M7WPYXIREouqAItD
	yk9N6kl6jXtCkMEPvFg7a2tXOjeb9iv+o6O8l8MHj86ufKTbP0NyErELX5k4JuRjK/8RJXm19aY
	9BiV9vo7Jn5X0c24P35+nlEAdlKsNVahQ+z2GobndfXLncKivxODh4jEOIkixd8AievsJHd2xbn
	+gjjegIZjh4qj
X-Received: by 2002:a17:903:94e:b0:2b0:7026:24bf with SMTP id d9443c01a7336-2b28180530fmr27122935ad.14.1775210490279;
        Fri, 03 Apr 2026 03:01:30 -0700 (PDT)
X-Received: by 2002:a17:903:94e:b0:2b0:7026:24bf with SMTP id d9443c01a7336-2b28180530fmr27122265ad.14.1775210489564;
        Fri, 03 Apr 2026 03:01:29 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm58846095ad.55.2026.04.03.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:01:29 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] crash_dump: Fix potential double free and UAF of keys_header
Date: Fri,  3 Apr 2026 18:01:25 +0800
Message-ID: <20260403100126.1468200-1-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233167-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBAFB39319B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If kexec_add_buffer fails, keys_header will be freed. And depending on
/sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
following two problems if the kexec_file_load syscall is called again,
  1. Double free of keys_header if reuse=false
  2. UAF of keys_header if reuse=true

Address these problems by setting keys_header to NULL after freeing
kbuf.buffer and re-building keys_header when necessary respectively.

Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/crash_dump_dm_crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index a20d4097744a..92eebef27156 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -417,7 +417,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 		return -ENOENT;
 	}
 
-	if (!is_dm_key_reused) {
+	if (!is_dm_key_reused || !keys_header) {
 		image->dm_crypt_keys_addr = 0;
 		r = build_keys_header();
 		if (r)
@@ -433,6 +433,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	r = kexec_add_buffer(&kbuf);
 	if (r) {
 		kvfree((void *)kbuf.buffer);
+		keys_header = NULL;
 		return r;
 	}
 	image->dm_crypt_keys_addr = kbuf.mem;

base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
-- 
2.53.0


