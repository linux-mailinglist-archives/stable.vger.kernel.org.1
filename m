Return-Path: <stable+bounces-212013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI8BFo8remnd3gEAu9opvQ
	(envelope-from <stable+bounces-212013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:30:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885CFA3DDF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5659301296E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062F236D513;
	Wed, 28 Jan 2026 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQQXbGFL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD67E36D512;
	Wed, 28 Jan 2026 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614105; cv=none; b=lBjoh0uIWpDy1BPK/kQJrhZolY15YNT2PZNNLHlLF+CiX5ATw2grGFJEERw1tPwanHYfBLu4uB+9MUNgGDxVMrKbJ30/wA012oeAv/T6ZcXWwBIsFuRUOAOqCj2bqrcWLu7QMkD0uGNRXjf4NqG/G9u19xcUmk5Eu1yC/j4yJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614105; c=relaxed/simple;
	bh=s4a8b86oa/sY3qH0OSOF8mZNyBMHW0lNC6qcLetYL04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gET5PBR7W7p/wUv8jJxAXBJV9W7M9VSv3r9ANtWUGLw7TleCyWOpJLsA1KxBGCyRv5XvBbUZmkbwiI7dPBE4UL9sbqpRM5eahrcRwfuOURrWYw4S3yKSiANTIuBks216wGty1Q44Htqf2Gdd93iZg5vyPo/knRLQ7U1oY3dMpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQQXbGFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3131CC4CEF7;
	Wed, 28 Jan 2026 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614105;
	bh=s4a8b86oa/sY3qH0OSOF8mZNyBMHW0lNC6qcLetYL04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQQXbGFLcM3stTexHzi9E8VJZDXSnOHrlBK9PuCu7iQqJttG87xIhbLXW+EjoyJ9k
	 O1IMdzz59mwZzhWOor7HW4cS6PHHQOAV9zF7Vkzny0ffNwM7QJIVn3BlE2Qdkv89Wv
	 wKfm7GmcK4P6LpUck9zl5PoT+a1iGnRj/2LmPlH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/254] pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()
Date: Wed, 28 Jan 2026 16:19:42 +0100
Message-ID: <20260128145344.934929355@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[hammerspace.com:query timed out,seu.edu.cn:query timed out];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-212013-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[zilin.seu.edu.cn:server fail,trond.myklebust.hammerspace.com:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 885CFA3DDF
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 0c728083654f0066f5e10a1d2b0bd0907af19a58 ]

In nfs4_ff_alloc_deviceid_node(), if the allocation for ds_versions fails,
the function jumps to the out_scratch label without freeing the already
allocated dsaddrs list, leading to a memory leak.

Fix this by jumping to the out_err_drain_dsaddrs label, which properly
frees the dsaddrs list before cleaning up other resources.

Fixes: d67ae825a59d6 ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 95d5dca671456..ed18e9e87c25f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -103,7 +103,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			      sizeof(struct nfs4_ff_ds_version),
 			      gfp_flags);
 	if (!ds_versions)
-		goto out_scratch;
+		goto out_err_drain_dsaddrs;
 
 	for (i = 0; i < version_count; i++) {
 		/* 20 = version(4) + minor_version(4) + rsize(4) + wsize(4) +
-- 
2.51.0




