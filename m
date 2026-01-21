Return-Path: <stable+bounces-210673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aET5Dt1CcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:07:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A72EB503E4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7F956CED0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7DD3559E4;
	Wed, 21 Jan 2026 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcqZXg40"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011935505C
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964819; cv=none; b=L+eUl1PRUNuGTYs4IejZEMDZFhe+1g6iVKz+JkTYfHhihrJZcvLSciuMpJYE0sTsKzQPc8op5WllgYCsPUOz+3MnFZSjHo27ZlnuFr5tts125ApoPRYyIGa2mGBjx+G7TtGi8H/RiUSAQshMjyluBzKlvWoRf3jelCcV4Oo+fnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964819; c=relaxed/simple;
	bh=ehe0bHOiY9iyv8U1cp0UURd/EWYWC1T6p+ugFIcRUA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9z3ptKiVrdDCbdryM8rQrwB+Md/xOTHJeq7aIjypyo1GR3L6IUK3ZvEBLRJaMMbGWG8P0UgTi5vqixNSE6MLwvhyEJVq8HWjF8Ju6aXWYVF9wwv+A0XxlOUOX8ykLEyp1aw9IdI7daR6mQLBHyypJ9h096YYmmKJo8gdleU0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcqZXg40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86897C19423;
	Wed, 21 Jan 2026 03:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964819;
	bh=ehe0bHOiY9iyv8U1cp0UURd/EWYWC1T6p+ugFIcRUA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcqZXg40+rklQFF2nEAqcn3p7wM8zvHrE3MORsf71x6Ch4nj8gzww9CurQt7TG3gQ
	 FobivhrJ2wnqo2cE5O5DL+bthp3HIAN4VcgzQYrDo/N1h+gw/M32hmTa7OYNltxrnC
	 v+QgJxbK6ihU0SIIALxJkRKQRzJdt0OygMB+fZQt1NHo7FsX2jI5xjGVF/5BoQd8yq
	 GHXLOrAcF427GC0ou01ZY2rqrHSkOH+wCDANi9m1TFdgtRfzGMgGBj1LcicEhcYFln
	 tDshKPxRNMGbrUIEg2VssqYK/R8L9SbYHiacOjhwytR+Mf0CavosqrIPtIw+huwv6i
	 WgL87CwD3UyIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mm: numa,memblock: include <asm/numa.h> for 'numa_nodes_parsed'
Date: Tue, 20 Jan 2026 22:06:55 -0500
Message-ID: <20260121030655.1173340-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121030655.1173340-1-sashal@kernel.org>
References: <2026012036-system-boots-1902@gregkh>
 <20260121030655.1173340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210673-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux-foundation.org:email,codethink.co.uk:email]
X-Rspamd-Queue-Id: A72EB503E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit f46c26f1bcd9164d7f3377f15ca75488a3e44362 ]

The 'numa_nodes_parsed' is defined in <asm/numa.h> but this file
is not included in mm/numa_memblks.c (build x86_64) so add this
to the incldues to fix the following sparse warning:

mm/numa_memblks.c:13:12: warning: symbol 'numa_nodes_parsed' was not declared. Should it be static?

Link: https://lkml.kernel.org/r/20260108101539.229192-1-ben.dooks@codethink.co.uk
Fixes: 87482708210f ("mm: introduce numa_memblks")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/numa_memblks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index ff4054f4334da..c447add277ccd 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -7,6 +7,8 @@
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
 
+#include <asm/numa.h>
+
 int numa_distance_cnt;
 static u8 *numa_distance;
 
-- 
2.51.0


