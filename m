Return-Path: <stable+bounces-250664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM9ZGFL1DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C392594E55
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F9031D2256
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FBD372B31;
	Wed, 20 May 2026 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2EsfIHmf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DBC371D13;
	Wed, 20 May 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295999; cv=none; b=FLVP33IE1BANnBloeORLxjeEYivJ5vzBVxFi8vZ9uO77zt4uOjQBu3Wp0KmYtDtNB93m/Ty7TkI86LBgSEcpSxm5mekokDPgjdCjHw3zSmhyoFKoaX8NgKxMH794cX5z7LTYkdzpru1DI7CmmEgGMGMrqZzv+4NF3oyTfeaej3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295999; c=relaxed/simple;
	bh=W14LPHuCEYQ4QSIk3bQqJRNSdWzJBGCtz3laHIqTSTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf0Ae+UKFIjTCiusWMGAZ3KOotz3Jl9blbtkdzRTkAbrT3KC9R1bc6JCZvgv5vbB4kgxOh5+4QNuaiw+qz1T24BuEHQSvWMwKpKhg1f3T38N9TUYuvJTBXNu39Wf6y/6qGnPN6Q0llQ3Y+eGn3FSJFV5RbcK1cvUYyLQsvp8w1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2EsfIHmf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A101F00893;
	Wed, 20 May 2026 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295997;
	bh=ibQ6d/RLnwByLdaKPkfcU8VoYvsEz3dPZ5iwQxDaeZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2EsfIHmfG+QAneFSQ4G+4W3Dx9iS4Cs1Y9pZLd7xBbNovVkcZlACN6ieqDFDAR+cw
	 JIE9nQGb7QGyRDvyfRaKyiNXqm3zNX7tooqbNbMcgL4kPTnRDdpw0USjDf3KJkcPtL
	 I+uOYtLSWA9fddwO2pLKhJL1XaYe39pnSUnjBwIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0605/1146] ext4: call deactivate_super() in extents_kunit_exit()
Date: Wed, 20 May 2026 18:14:15 +0200
Message-ID: <20260520162201.871838712@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-250664-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,huawei.com,gmail.com,linux.ibm.com,mit.edu,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0C392594E55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit f9c1f7647ac8fb70bebb1615ac112d1568abe339 ]

Call deactivate_super() is called in extents_kunit_exit() to cleanup
the file system resource.

Fixes: cb1e0c1d1fad ("ext4: kunit tests for extent splitting and conversion")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20260330133035.287842-3-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 82c59291e0458..3d4663d99eb13 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -146,6 +146,7 @@ static void extents_kunit_exit(struct kunit *test)
 	struct ext4_sb_info *sbi = sb->s_fs_info;
 
 	ext4_es_unregister_shrinker(sbi);
+	deactivate_super(sbi->s_sb);
 	kfree(sbi);
 	kfree(k_ctx.k_ei);
 	kfree(k_ctx.k_data);
-- 
2.53.0




