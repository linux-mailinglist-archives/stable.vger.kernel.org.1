Return-Path: <stable+bounces-219490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEuCCeugnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:12:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B752A193195
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEAD131F9F38
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379F2D4805;
	Wed, 25 Feb 2026 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJbpb+13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AAC318B86;
	Wed, 25 Feb 2026 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002750; cv=none; b=uhe5f7XNPafwC0iB+JmMPPA6j03N+RPDLRryV3KLS8DYqHYw20YSHWHDYUbIPnn5ROPQKuU/tsl/3BWlX3jLKPJN1H8DMqydzbd4GIn2y0ruh9gHhPt+gtd/vUf/j96ineihistwLZQERLFt7ceKjylRkGMgzoPuW9BENbLLQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002750; c=relaxed/simple;
	bh=c1pvBslOHKLzuOnU3+8iKwDiVEOddm0+0MrGV4MKfEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+ydbPv7XikRjiLWDC1vRva/gkgea2oBjNH55695cGfpawx+EqvG+05k18gKZEsCKBOmpIHy99op/dw+woN6GRxLgQNwsaRwCwPgnIuSEE2VuCDotWsNw09Jgua7JKu1Tzv5VCdhj8aIalA8aaaUpDqMbAsKkvPYKKtTYps+t9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJbpb+13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903BDC116D0;
	Wed, 25 Feb 2026 06:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002750;
	bh=c1pvBslOHKLzuOnU3+8iKwDiVEOddm0+0MrGV4MKfEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJbpb+13EZxvetZVUu9SiTmM2JF6lz7BPje2G+fk9flkY8Qsm/6CMWo39mDAEhJ6N
	 Czxt5EHo8iJ0WAZwO7Eh7zSUA/b33EUzQidqabKBHQI+7gQJWmu+RLMT0RMqc3TzGW
	 6u2KAYE6dtxV/aRrTKWVL169rot4IrJ46XYv7pq4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhengmian Hu <huzhengmian@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 575/641] apparmor: avoid per-cpu hold underflow in aa_get_buffer
Date: Tue, 24 Feb 2026 17:25:01 -0800
Message-ID: <20260225012402.449223693@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219490-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,canonical.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,canonical.com:email]
X-Rspamd-Queue-Id: B752A193195
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengmian Hu <huzhengmian@gmail.com>

[ Upstream commit 640cf2f09575c9dc344b3f7be2498d31e3923ead ]

When aa_get_buffer() pulls from the per-cpu list it unconditionally
decrements cache->hold. If hold reaches 0 while count is still non-zero,
the unsigned decrement wraps to UINT_MAX. This keeps hold non-zero for a
very long time, so aa_put_buffer() never returns buffers to the global
list, which can starve other CPUs and force repeated kmalloc(aa_g_path_max)
allocations.

Guard the decrement so hold never underflows.
Fixes: ea9bae12d028 ("apparmor: cache buffers on percpu list if there is lock contention")

Signed-off-by: Zhengmian Hu <huzhengmian@gmail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index be3678d08ed23..13c9bfdf65ff5 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2136,7 +2136,8 @@ char *aa_get_buffer(bool in_atomic)
 	if (!list_empty(&cache->head)) {
 		aa_buf = list_first_entry(&cache->head, union aa_buffer, list);
 		list_del(&aa_buf->list);
-		cache->hold--;
+		if (cache->hold)
+			cache->hold--;
 		cache->count--;
 		put_cpu_ptr(&aa_local_buffers);
 		return &aa_buf->buffer[0];
-- 
2.51.0




