Return-Path: <stable+bounces-228966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n0b0BW9UwWlVSQQAu9opvQ
	(envelope-from <stable+bounces-228966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:55:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF72F570C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F43F30266D2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41252388E52;
	Mon, 23 Mar 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="peT9M2vl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BB2F851;
	Mon, 23 Mar 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277634; cv=none; b=TajhlFPris+lYY4ducE1zwcBMAPhruVcUdCUiMRKZelc4Lns1vVQtF0Gh6b1jPmhu0xg0k8sgTMDqDmDCPfvGTwq30EDfq3LJbhaIpu+DRqqANQ1uxnJnP/DqYMVekmhGy63Wnnce8zLLWLkU1dFzOF6PZnjEcZ8Jf4qj2egGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277634; c=relaxed/simple;
	bh=g+1I7BVqbJUzPEAzub2VV56vsxgUfLVUxxR0AFUmz/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d01M3LkN4UWfam/xNUmuluaLSIWn5kYnqVQXyCMJGDed75snTyin7AAB6/ckeg12nR0VF61W5zKB96uOA5ZzBwDWRMhzFxmFQoUwEGeTeypZJXEqPhOal0fFHtC9kaRnXQZtEgkRwG1HS9KN+mTXbXOffCBZwkkr1n3CV2nP4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=peT9M2vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287A3C2BCB1;
	Mon, 23 Mar 2026 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277633;
	bh=g+1I7BVqbJUzPEAzub2VV56vsxgUfLVUxxR0AFUmz/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=peT9M2vl4x2QZQXN91FTKwWbiro+e738I58YUkOX3sPFApNtfW6ZEGQOOhq9qbiP0
	 0Xdv+slC5UvpYziXMErJ1YMMJPfFnI1faUGDUJ25ckaPQze97r/vtHQXMDuiaRLWop
	 N8Im9xjZdugfFvw3xE2GM/daozIku++n6GoEG8N4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Mark Harmstone <mark@harmstone.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 022/567] btrfs: fix objectid value in error message in check_extent_data_ref()
Date: Mon, 23 Mar 2026 14:39:02 +0100
Message-ID: <20260323134534.318013703@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228966-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 84DF72F570C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Harmstone <mark@harmstone.com>

[ Upstream commit a10172780526c2002e062102ad4f2aabac495889 ]

Fix a copy-paste error in check_extent_data_ref(): we're printing root
as in the message above, we should be printing objectid.

Fixes: f333a3c7e832 ("btrfs: tree-checker: validate dref root and objectid")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index bca5ec4c26630..e38994ac14848 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1673,7 +1673,7 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 			     objectid > BTRFS_LAST_FREE_OBJECTID)) {
 			extent_err(leaf, slot,
 				   "invalid extent data backref objectid value %llu",
-				   root);
+				   objectid);
 			return -EUCLEAN;
 		}
 		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
-- 
2.51.0




