Return-Path: <stable+bounces-210828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBaULiA1cWlQfQAAu9opvQ
	(envelope-from <stable+bounces-210828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:20:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 597685D0DA
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E90047ED051
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169ED326D5E;
	Wed, 21 Jan 2026 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IMKjUnsc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DDE3806BB;
	Wed, 21 Jan 2026 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019519; cv=none; b=CyO6Zie5hi+H3Ev48DYurdRAg/BP1mvROI1kRM0Fvqbret52b7xI0Uitk89E2zvLNiylprrkIyGDvgmrXQADnYpsDl9JMzXnrQi0etmuegZHBf7X3D7vxRlwaCxUWLeiDA/DzEIyonCEMATSjZHwd6R8jJ0a1zjF0GXn9jAD01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019519; c=relaxed/simple;
	bh=U55KYdoPTS7QShalBkCTSAC9ODs2l0PguIRfsM32DiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruvHgjFJw9IQa2P98UqgPO3UojgDI3tsB/r3mxaTfh1yW2ZnvlHsh0+OwqNsZtdGdaLIzCALi/X9QjViFqbRp7w1bMGVJDlUTsjJgQt8ASByyIpWg20EJYdDgfjEyG61eHjKZSanAAPSH97SZrTPfJbyOv9SdltbuWnf6V/xcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IMKjUnsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385A6C16AAE;
	Wed, 21 Jan 2026 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019518;
	bh=U55KYdoPTS7QShalBkCTSAC9ODs2l0PguIRfsM32DiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMKjUnscz/dpkDSUtKP3kFl50LiWTbGk7wr0sfY8FLSbuKiReiPHwh9A8sPpPeK3Z
	 mti69P72EqZCQytqCaM90cAq0gE/hRqIb9cFvF7uc/vZxUzLj5ajC3S/OhvuWWleHB
	 DADDQBIRii/0gmZj4WEiAgt77S5uFGcOefY/P1Fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 030/139] btrfs: fix memory leaks in create_space_info() error paths
Date: Wed, 21 Jan 2026 19:14:38 +0100
Message-ID: <20260121181412.540759807@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.com,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210828-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 597685D0DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 9d47678875b76..b2c90696b86b2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -291,18 +291,22 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
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




