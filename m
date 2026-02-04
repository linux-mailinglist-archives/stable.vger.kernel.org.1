Return-Path: <stable+bounces-213806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEUaJtpmg2nQmQMAu9opvQ
	(envelope-from <stable+bounces-213806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:33:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6642E8DFB
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9532C3099C41
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF73423A83;
	Wed,  4 Feb 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JOco2Cr4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61CC2D8763;
	Wed,  4 Feb 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217572; cv=none; b=AD1wyYUqvSvsCJzKEB4D5wy8YxIusFP6OkGbZBQo/3YNeXCynnA16V9+M8gPkFYTvQIUWn4qGhV6S5mWnGnBm58CaZkOf0hjTK0YXcGFNeRhpSMzKeACoWYFppt0M+YbMEJodwoxO02v8YGTDDmeyB1TG/GmKnRAGjauz8K7MRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217572; c=relaxed/simple;
	bh=UZ9sl+46k5ydKGmxj6z4H6+Wdb79WXs9vHJ9iKOCoWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjjLzlOPKCCXyHNWbkHFv+4ZFl8jldyxl3jWT+4Adl2cCKO914GYPQPOWMmULnsX872G/jY/iPDceI7XN6wwghFMAMYNwAVaZcPa+Q55vimGXqUQcPl1uBMvBi0wYRlpTjzhHcLiYaJhoTnP6TMEy2ytS9VYU+TvzOqW0WGQTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JOco2Cr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16397C4CEF7;
	Wed,  4 Feb 2026 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217572;
	bh=UZ9sl+46k5ydKGmxj6z4H6+Wdb79WXs9vHJ9iKOCoWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOco2Cr4wVZN930dbkPK93JGhkYqSzy4S0GPlMkyn+QvE14rz4FKLmFUJ26Ah/wNF
	 8lDNUZlYr1Y7GDyF6xQisC73NmMBj85kKTF7SZNvWtF7c6Yd11mCz/6FuUqeZYhnUD
	 yeJ0N+bcBqAVLburRrbwMGJ9l1+mY7xMj0MAAXXU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/280] btrfs: fix memory leaks in create_space_info() error paths
Date: Wed,  4 Feb 2026 15:36:35 +0100
Message-ID: <20260204143910.394895454@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-213806-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Queue-Id: A6642E8DFB
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 15c578f49caab..230e086ddee8e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -285,18 +285,22 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
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




