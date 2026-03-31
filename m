Return-Path: <stable+bounces-232216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAmSGf8EzGnPNQYAu9opvQ
	(envelope-from <stable+bounces-232216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:31:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C4736EDF9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05BDB31BAB55
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90B43A1E8C;
	Tue, 31 Mar 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mNyhqg1y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6753EF0A2;
	Tue, 31 Mar 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976176; cv=none; b=RIKT9d2P1f16qxN2tR4qRpudQZd0tSMUT9TLYTMpubs3PPyFeQjttoowOghT3njRjDYUgDNR0TF+2epE+CXk0XC+mkWFn1byn9PGd3+EwGps26mtlb+2ePNdpINWRkxXTqQ1ZNeSzlf8QGCq1y/YeiJEVcwPUu9aZpPQ6eA+5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976176; c=relaxed/simple;
	bh=9YdsbkenZMpTD8TYG4sBpt8/x1dtoPN4vaFyazQbjp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/vhpq4jCd7/0FxwlPluA3It4WPBh+zpL66hSVxYmOBfIDf/6KMvAdZ8BYA4bYzl2FZqtXt9yQAnbM4TyK2Ei8Q9a65fC23vhFhgpW+eZo5r5aLWeO2oZczxlju7h1Sc4EHkQjMpwnaKu9hopn/objhVN5jl3QRyNUKH59pkn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mNyhqg1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0382AC19423;
	Tue, 31 Mar 2026 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976176;
	bh=9YdsbkenZMpTD8TYG4sBpt8/x1dtoPN4vaFyazQbjp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNyhqg1ya2XulxoE6vOF+cuUDGBiE8YTtVyU0r+DZU3mBTsxWUeJbGTO8r6UB3b6a
	 e8y2V4MpnND67McPiy5d7EcCgUtu+TKhsUVNOYO0jMJ7r8emL0ZzPfAtb7tdfmP7UG
	 PTiifm5OjtkZrHXuAei5Fpgm4ER/Cvv21HgVho2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Mark Harmstone <mark@harmstone.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 236/244] btrfs: fix super block offset in error message in btrfs_validate_super()
Date: Tue, 31 Mar 2026 18:23:06 +0200
Message-ID: <20260331161750.477935173@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232216-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,harmstone.com:email]
X-Rspamd-Queue-Id: 07C4736EDF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Harmstone <mark@harmstone.com>

[ Upstream commit b52fe51f724385b3ed81e37e510a4a33107e8161 ]

Fix the superblock offset mismatch error message in
btrfs_validate_super(): we changed it so that it considers all the
superblocks, but the message still assumes we're only looking at the
first one.

The change from %u to %llu is because we're changing from a constant to
a u64.

Fixes: 069ec957c35e ("btrfs: Refactor btrfs_check_super_valid")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dea64839d2cad..05e91ed0af197 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2468,8 +2468,8 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 
 	if (mirror_num >= 0 &&
 	    btrfs_super_bytenr(sb) != btrfs_sb_offset(mirror_num)) {
-		btrfs_err(fs_info, "super offset mismatch %llu != %u",
-			  btrfs_super_bytenr(sb), BTRFS_SUPER_INFO_OFFSET);
+		btrfs_err(fs_info, "super offset mismatch %llu != %llu",
+			  btrfs_super_bytenr(sb), btrfs_sb_offset(mirror_num));
 		ret = -EINVAL;
 	}
 
-- 
2.53.0




