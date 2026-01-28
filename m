Return-Path: <stable+bounces-211999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GQLHREremnd3gEAu9opvQ
	(envelope-from <stable+bounces-211999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:28:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F9A3D05
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 332B7301726F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4736CDFB;
	Wed, 28 Jan 2026 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kYQeWa2k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425C36C0CE;
	Wed, 28 Jan 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614058; cv=none; b=svHWCjnhZfoC0ZadDYKlXIrBb0hzhhyvHYzswrPE8mK8fHDyNWBFg9UF0XFAIRCE5QIMJrXhgwbBZltkXMq3r9k5MNHQJxcJ8EWsN28KPXvH4MYQbgZ3MycKpJRzFvNZZAIdCEtTIckW6DbompFgIvEVqoyDNNFYMcCW61pkAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614058; c=relaxed/simple;
	bh=5asWBJc3TKKyRXBziITpKSE5TOHtZ02USWUJKUqkmT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lr0BBkAP/ajSK36LBGXaPvPvVjQsNPd08DzrgLdPnwNdOPVyDhasvAStwelEf0jcU5jUKXBnOBseHrLHVLBzzXnn0lqnEaDP8Wj/ir6dbq75iKNYWu3gkP4jwtjzYBaxlvtPNz28sd1XU85p/UF7kDYBIYMEJQBK0vinag8mokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kYQeWa2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E69EC4CEF1;
	Wed, 28 Jan 2026 15:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614058;
	bh=5asWBJc3TKKyRXBziITpKSE5TOHtZ02USWUJKUqkmT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYQeWa2kBXpfBl06sFGTHYO2QMvd3Vs2sastTsRK4lijMVN0/sgoE3TsR7DZxUXzd
	 xemuudkggZ6JJ+m6nvGpLje74dEjtrLvDRtE30cccO5bgAPtFmDjONFTy/WMcsvh6b
	 qKwySY28dnQbaCSwyZoLzvJWlz/J/BMDmbXpWoA4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 023/254] btrfs: fix memory leaks in create_space_info() error paths
Date: Wed, 28 Jan 2026 16:19:59 +0100
Message-ID: <20260128145345.539488702@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211999-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.com,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jiashengjiangcool.gmail.com:server fail,wqu.suse.com:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E56F9A3D05
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit a11224a016d6d1d46a4d9b6573244448a80d4d7f ]

In create_space_info(), the 'space_info' object is allocated at the
beginning of the function. However, there are two error paths where the
function returns an error code without freeing the allocated memory:

1. When create_space_info_sub_group() fails in zoned mode.
2. When btrfs_sysfs_add_space_info_type() fails.

In both cases, 'space_info' has not yet been added to the
fs_info->space_info list, resulting in a memory leak. Fix this by
adding an error handling label to kfree(space_info) before returning.

Fixes: 2be12ef79fe9 ("btrfs: Separate space_info create/update")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/space-info.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 01d9a93346c28..00d596a8176ff 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -288,18 +288,22 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 							  BTRFS_SUB_GROUP_DATA_RELOC,
 							  0);
 		if (ret)
-			return ret;
+			goto out_free;
 	}
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
-		return ret;
+		goto out_free;
 
 	list_add(&space_info->list, &info->space_info);
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
 		info->data_sinfo = space_info;
 
 	return ret;
+
+out_free:
+	kfree(space_info);
+	return ret;
 }
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
-- 
2.51.0




