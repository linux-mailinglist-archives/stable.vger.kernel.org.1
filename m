Return-Path: <stable+bounces-228466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E0lNDROwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:29:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5BA2F495B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F1FE3101459
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D34921D00A;
	Mon, 23 Mar 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E78zyIaA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044D3ACEF1;
	Mon, 23 Mar 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275213; cv=none; b=MbF8cCXIT1Lf7aSoeq8eC+QtvlItceF5l4fu5d0CU3xqeYCVahYQkyGBdygtVjUdTL8+t8ABT98kwkmuxx+Lu6Q0BtcBirVjPt4x3jbUflphCisPN5KuqIcMb42eLk2YCLlVL3kDAodxKjVw7z5RIHonYbOGlv6/1dpcTIXUKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275213; c=relaxed/simple;
	bh=pd8LKc48mYDXbPPhK5R7JbnHSCU5xqxoKkhsIJLuaTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmLYtw3wbT8KriyEUOvu4uEBBV2f5UdV87xtixnEJxfSAs5Sb4rz4DL/umr9uB3o10TGyC4MmFnCCCnuDw1l4sJFCIRIEFkuyVgpXO0Y15ajLHHLdFcgS3ErnJTYb3VDYuNJj4PpLH3X8No+N8UKl7UE3e1ZpyvkQ+Kei8ZrRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E78zyIaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC3AC4CEF7;
	Mon, 23 Mar 2026 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275212;
	bh=pd8LKc48mYDXbPPhK5R7JbnHSCU5xqxoKkhsIJLuaTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E78zyIaAx2o8G5fImI20PnyjgZJLRqbA65q0ReNRy2spwgj1DxYl7HVwSbZSuDWlM
	 J+uaZiUD8XUGBdcTUysY16oKFpleeZZuYY7ImaQSgqhrcedH6DIlb0WTIHqBgbh6JF
	 8FTlizAIEjWXgxd2bWENn+dWRS8aBSMEVADLt5g0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 015/567] btrfs: move btrfs_crc32c_final into free-space-cache.c
Date: Mon, 23 Mar 2026 14:38:55 +0100
Message-ID: <20260323134534.142689587@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228466-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5B5BA2F495B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 102f2640a346e84cb5c2d19805a9dd38a776013c ]

This is the only place this helper is used, take it out of ctree.h and
move it into free-space-cache.c.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 511dc8912ae3 ("btrfs: fix incorrect key offset in error message in check_dev_extent_item()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.h            | 5 -----
 fs/btrfs/free-space-cache.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 834af67fac231..3108852ff47d7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -477,11 +477,6 @@ static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
 	return crc32c(crc, address, length);
 }
 
-static inline void btrfs_crc32c_final(u32 crc, u8 *result)
-{
-	put_unaligned_le32(~crc, result);
-}
-
 static inline u64 btrfs_name_hash(const char *name, int len)
 {
        return crc32c((u32)~1, name, len);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 9a6ec9344c3e0..edf3612ba3108 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -57,6 +57,11 @@ static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 			      struct btrfs_free_space *info, u64 offset,
 			      u64 bytes, bool update_stats);
 
+static void btrfs_crc32c_final(u32 crc, u8 *result)
+{
+	put_unaligned_le32(~crc, result);
+}
+
 static void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl)
 {
 	struct btrfs_free_space *info;
-- 
2.51.0




