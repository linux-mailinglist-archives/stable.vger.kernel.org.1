Return-Path: <stable+bounces-219521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKDIESmhnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:13:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3201931D2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5CFD320DE74
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441B931A579;
	Wed, 25 Feb 2026 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OhW+0TbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05824312806;
	Wed, 25 Feb 2026 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002771; cv=none; b=YWFKuWx4chpgPA71tBhGmkcws7BgNhvVuLtwWPS657jm5lpKfzIzzEgwhvzIBA/d4sNr874RzpG5vAQWWdpVI9UGO3iUDMIZRlG5j8IkyMoGJfKGl73MlWti6gi/wc4SlxtY+xjK/6GJR65oSE1ww1kYxtLxBJY/8NZVVy5BzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002771; c=relaxed/simple;
	bh=b6lYQk3vH2A7VQ+ktftbw53R7DfxRRY95cguShWv1pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIbqgxdckWFnqTfy4b9pEloz0J43f20Wu3ZO2f6qTWPwAx+wpIE9pnxM4I6C1ok31fOvPA8DnNhv9JolH+Q2NI5Ov50iLeVlS/PAW4PpjSMFJ1WGbY8eM5bZpkAwtvMjmM/KevnPNcdaBQqfgwbkoTBXPRRzNgxHlaRZRPWMPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OhW+0TbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3133C116D0;
	Wed, 25 Feb 2026 06:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002770;
	bh=b6lYQk3vH2A7VQ+ktftbw53R7DfxRRY95cguShWv1pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhW+0TbA9DUjAaP74SqxJHKaehSTazQvuzDaMrns+45I6wkNQDxBgQE7EWzWZu9mK
	 YT+melbjchOWCohhMAo3FncZTiP3dpIV3uk0/8rW+u5n8DDPY59chN8V/cb8Sy0q7X
	 zuziLcmTGURhQXZvOkj7nMgK3GHV9/uVUkcZnk8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 606/641] btrfs: fix invalid leaf access in btrfs_quota_enable() if ref key not found
Date: Tue, 24 Feb 2026 17:25:32 -0800
Message-ID: <20260225012403.198012713@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219521-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Queue-Id: CD3201931D2
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit ecb7c2484cfc83a93658907580035a8adf1e0a92 ]

If btrfs_search_slot_for_read() returns 1, it means we did not find any
key greater than or equals to the key we asked for, meaning we have
reached the end of the tree and therefore the path is not valid. If
this happens we need to break out of the loop and stop, instead of
continuing and accessing an invalid path.

Fixes: 5223cc60b40a ("btrfs: drop the path before adding qgroup items when enabling qgroups")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 7a1dd250e92c0..302bb3ecf39a3 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1157,11 +1157,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 			}
 			if (ret > 0) {
 				/*
-				 * Shouldn't happen, but in case it does we
-				 * don't need to do the btrfs_next_item, just
-				 * continue.
+				 * Shouldn't happen because the key should still
+				 * be there (return 0), but in case it does it
+				 * means we have reached the end of the tree -
+				 * there are no more leaves with items that have
+				 * a key greater than or equals to @found_key,
+				 * so just stop the search loop.
 				 */
-				continue;
+				break;
 			}
 		}
 		ret = btrfs_next_item(tree_root, path);
-- 
2.51.0




