Return-Path: <stable+bounces-219612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMngIq74nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB81980AE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF5230EE921
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1672B3B8BBE;
	Wed, 25 Feb 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUKOHBrN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1763AE701
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025784; cv=none; b=Bm8iGIJqRcaGpwSUWAWMyD4mPg1IohYo1n5VduYTzQGLy+fKHJr5R7wh2JG0WPiVmW47AGQY65H07NpJ2L3iKZdyBme5YTn0fYweW5nYOloawpWmG0lqk/aA95fdlo3kFqm+cUpMRdQLA/xx4emr22kX79uenkb4z4zWjITMIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025784; c=relaxed/simple;
	bh=4Y4zP84HFAUB3kgviW60MveSoggDS6HMNQ6s3Qtd2Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mI5ge3EZYcRlHXkaOymiPwFmIg3EtBh+V5pP4YJ+7UR4zNoxHis+IsYa5UeChiLrjDKEMKqoHn88BaVa6TKPb2/ItqAQf37T7vg/naHUz/1BO+dAXBWk2aYNNH6+EwI5SUdc9R4Cuwv9YorjRltLjtzgyhMhoT8o3g2su9onR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUKOHBrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3814C19423;
	Wed, 25 Feb 2026 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025784;
	bh=4Y4zP84HFAUB3kgviW60MveSoggDS6HMNQ6s3Qtd2Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUKOHBrN+n6BBl5KBBPEgevTQn07MVaYxXzkop+qpMCIasiZz5XnTMX/+NAPOmlmC
	 yctef+BdWWp2uTkThlqqp9nRq/72lpF80mMHFM+ugpBZXRetpEfxpVIZ3WvXUPxZYg
	 UuQw61abQnRrE8f8vU0KUELypJCeL68YVSEPk79V6az326JxVaoiHxeIJsLgY4xITq
	 /3wYeBV/WWmvGZYaYNzt/zQqoJcdWHG3dVGgmQbLc/UONVJOHEXueyJWfz8dLFqbO9
	 yin4tgITPYTDTprAd/OBv6Huo7MDTY0DUC54sAqEK/+QLbpysVM9wsP+yA/VTM8U+g
	 l4mGxLEE5Tdjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/6] ext4: remove unnecessary e4b->bd_buddy_page check in ext4_mb_load_buddy_gfp
Date: Wed, 25 Feb 2026 08:22:57 -0500
Message-ID: <20260225132302.222887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022401-arose-calm-3e73@gregkh>
References: <2026022401-arose-calm-3e73@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219612-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ECB81980AE
X-Rspamd-Action: no action

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit 285164b80175157c18a06425cf25591c9f942b1a ]

e4b->bd_buddy_page is only set if we initialize ext4_buddy successfully. So
e4b->bd_buddy_page is always NULL in error handle branch. Just remove the
dead check.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20230303172120.3800725-11-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: bdc56a9c46b2 ("ext4: fix e4b bitmap inconsistency reports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index da0c63897190b..bf53a6b283ae4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1601,8 +1601,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 		put_page(page);
 	if (e4b->bd_bitmap_page)
 		put_page(e4b->bd_bitmap_page);
-	if (e4b->bd_buddy_page)
-		put_page(e4b->bd_buddy_page);
+
 	e4b->bd_buddy = NULL;
 	e4b->bd_bitmap = NULL;
 	return ret;
-- 
2.51.0


