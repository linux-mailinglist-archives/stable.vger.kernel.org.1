Return-Path: <stable+bounces-210942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB3xD3ofcWmodQAAu9opvQ
	(envelope-from <stable+bounces-210942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:48:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7455B824
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2FE17CC15B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB2376BFA;
	Wed, 21 Jan 2026 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+mfFvpL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC861DE4E0;
	Wed, 21 Jan 2026 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019906; cv=none; b=GoQMgWTf3NyIefFdcr5yy9EQ6X21IPhpKqRTdwORncatfz0Sinuuc4b5ae6c8iZHQQki2uwRF8KgRre46MvRT07Eg4hLpC+gpZmrg9bViVMSmjyquLOMkoD/Q3UusxvVzhr2EbHOIbfq227XwpyorM1u4hIsHXCTtOWV27QbOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019906; c=relaxed/simple;
	bh=v8dX2dK/TPSVPU4kORhZ0cV4q7YozsttAbQ/xpXJQqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=natQMQ0Y2mTzToKoh7xFU8g0eCtszBYH06J0xP3pH93SosR+uxvKjKzUgLQsAj0Wc9xc8cmGArriV47QjRXCfNVQ4TqvFKvMV33qe9igKM9ZK7ZWNHzOdtBGcj7Yy+pzWu6d/2p+MrsRXJZ4Gfuq5Y+WVJLcjZyEqzmASU32F7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+mfFvpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBB6C4CEF1;
	Wed, 21 Jan 2026 18:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019906;
	bh=v8dX2dK/TPSVPU4kORhZ0cV4q7YozsttAbQ/xpXJQqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+mfFvpLJ97nPNEuEgEXIbQe1Lcn/KSRsXhN3dEIBu7CHfBwpaWbWVxzfB17MO2/b
	 sOmI/1GQGGxWhIkROgixcmOt5lq8JfVEQeoHIBPypUdh1m4Lgi1Fm5u/VtIvj8rCw/
	 sGvXBsH2H2DwiJaOQa45gBs0v03GBXkTSNXh/900=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 132/139] mm: numa,memblock: include <asm/numa.h> for numa_nodes_parsed
Date: Wed, 21 Jan 2026 19:16:20 +0100
Message-ID: <20260121181416.203905014@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210942-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CD7455B824
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/numa_memblks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -7,6 +7,8 @@
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
 
+#include <asm/numa.h>
+
 int numa_distance_cnt;
 static u8 *numa_distance;
 



