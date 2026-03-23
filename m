Return-Path: <stable+bounces-228189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBZjD+9QwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:40:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A96792F4F8F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A605317360C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AEF3B9D95;
	Mon, 23 Mar 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1t9w0JMp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CBD3B9D8F;
	Mon, 23 Mar 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274392; cv=none; b=FSOfYMSDv2i6D/lcO9vDevwgtVE6BuHIJhLQLNVevExsSMHPoJeNYH/ahWJM6tZSxERr/Clf0k6CfylubzGmB+1PZszvWNgDvhygpVs2Wi11OtCP9XDdrX7pHKxbXbZ0behn6BLKL/ETDGEC0mbQDy4GCKxgwK+vwZTy+3ac/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274392; c=relaxed/simple;
	bh=x0+1FWgBQoB60MM7o5dSB/Ut5c3DqL2IRwA2XeURWCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEtriAN9tmjcmBXfroJWlQGI8kxhr1CVIPOL4ZYa7nBZ3YPS8a279MbUqni64ZT2BFb8io95hfF7e5pmBseBPE33GhVlJzsCngumhSa+8sIjPbj0A6W8ihiHbsJylk5ibYB59M6Rf/faMuWahtXWiQKNEb2eLkInIcNW7ZbdosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1t9w0JMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC701C2BCB1;
	Mon, 23 Mar 2026 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274392;
	bh=x0+1FWgBQoB60MM7o5dSB/Ut5c3DqL2IRwA2XeURWCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1t9w0JMpcmwK/ipwkVaHAhY4JLB9CofquQ1Lwx8JYJo0Q8cw8VbXpBQP07ituVdtr
	 Dd/II0BkAo5B4Xtd55Io8KMoYSBmWjUb23HxwhTZGhDhrdRVRzLZnrX/lpP1337DS0
	 owGCXzd6/TKJfiwtmMhjPCqS0IjfX/XMawmasUEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 202/220] mshv: Fix use-after-free in mshv_map_user_memory error path
Date: Mon, 23 Mar 2026 14:46:19 +0100
Message-ID: <20260323134510.953520770@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228189-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A96792F4F8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

[ Upstream commit 6922db250422a0dfee34de322f86b7a73d713d33 ]

In the error path of mshv_map_user_memory(), calling vfree() directly on
the region leaves the MMU notifier registered. When userspace later unmaps
the memory, the notifier fires and accesses the freed region, causing a
use-after-free and potential kernel panic.

Replace vfree() with mshv_partition_put() to properly unregister
the MMU notifier before freeing the region.

Fixes: b9a66cd5ccbb9 ("mshv: Add support for movable memory regions")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/mshv_root_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index d3e8a66443ad6..45cf086ad430d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1334,7 +1334,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	return 0;
 
 errout:
-	vfree(region);
+	mshv_region_put(region);
 	return ret;
 }
 
-- 
2.51.0




