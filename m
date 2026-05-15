Return-Path: <stable+bounces-247727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMoGLiMUB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:40:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2122754FBDA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0DE306DED0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F86477998;
	Fri, 15 May 2026 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDgIlxb3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17973D5661
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846779; cv=none; b=BqYZR/uy6pANUYHvF9rJ6OS0sxBgl/T4Jy4hiPbxKrTMWfJFLEAMKsKYu2fMtaxi/Canb6Wi3ZfqDPJMqckmodVpfpClOPD3altL6obQW9GOuJPSFTb9YCtQJkwErlGTh8lZh9ICCt9y1sXmcaqIPDJe3IxJuBwG0ss8y3iLcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846779; c=relaxed/simple;
	bh=vHBmHCjTdxWDsJifO8AmXGn+foRLqLIXDLjUI1ENqGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sodPwhbXphrzPZFzUySpEgrdNEzG4LcEVMogVzH7Szt7a0ESpyr4xxHLAwIEyrcD5m4yN3wUuv/bHe4byB6wQLCMua2G3na+7I/moJiX2SuYnYbrtAdCq7kV/TuHGvcRApSix0sNO/0HyYdXeFVVpzZlsCwwDm/1uw6aK8O958c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDgIlxb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37831C2BCB8;
	Fri, 15 May 2026 12:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778846778;
	bh=vHBmHCjTdxWDsJifO8AmXGn+foRLqLIXDLjUI1ENqGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDgIlxb3wdBgxAx9an0I912lPYDKFTh6o3FkEzki2PIvxiQJ64IsLHxjMY9PlMtnL
	 I2XArV3lItoNQEo728QGNke2LsiA3+eqLEXF+L52610lPydnRdxcYzNT9I363SZ9+o
	 xe+CAtTRUJ8aHwXJWcDRtKNfwsHTLf/6HsApSRnKiwWiD9zx5qBecVXv7COP/vb0Gz
	 11fkG58XN1MdKMEKCcRcytVLiUKQLGad/3S07IaMXCGPrfYTAGCdyjRhOa/VTrukPE
	 t4u7ltwJixAjxC7fSAZ45N2UyoGeWmZHzPTxz/JUG8wdl/yT8+P7/kIvzI5RdMLt+U
	 VjXlzq1P5caTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] btrfs: fix double free in create_space_info_sub_group() error path
Date: Fri, 15 May 2026 08:06:15 -0400
Message-ID: <20260515120615.3073340-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515120615.3073340-1-sashal@kernel.org>
References: <2026051234-decidable-catalyst-a4ae@gregkh>
 <20260515120615.3073340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2122754FBDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247727-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit a7449edf96143f192606ec8647e3167e1ecbd728 ]

When kobject_init_and_add() fails, the call chain is:

create_space_info_sub_group()
-> btrfs_sysfs_add_space_info_type()
-> kobject_init_and_add()
-> failure
-> kobject_put(&sub_group->kobj)
-> space_info_release()
-> kfree(sub_group)

Then control returns to create_space_info_sub_group(), where:

btrfs_sysfs_add_space_info_type() returns error
-> kfree(sub_group)

Thus, sub_group is freed twice.

Keep parent->sub_group[index] = NULL for the failure path, but after
btrfs_sysfs_add_space_info_type() has called kobject_put(), let the
kobject release callback handle the cleanup.

Fixes: f92ee31e031c ("btrfs: introduce btrfs_space_info sub-group")
CC: stable@vger.kernel.org # 6.18+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/space-info.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c4a50550672da..b3ff2e1da89ba 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -276,10 +276,8 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
 	sub_group->subgroup_id = id;
 
 	ret = btrfs_sysfs_add_space_info_type(sub_group);
-	if (ret) {
-		kfree(sub_group);
+	if (ret)
 		parent->sub_group[index] = NULL;
-	}
 	return ret;
 }
 
-- 
2.53.0


