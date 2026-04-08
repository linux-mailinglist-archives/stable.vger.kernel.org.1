Return-Path: <stable+bounces-234192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKbID6Sb1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:17:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEA3C055B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 004EE301A087
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7493B67E;
	Wed,  8 Apr 2026 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhYLiT1s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E83537FC;
	Wed,  8 Apr 2026 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672221; cv=none; b=M7jXqpSLFCgsGp843aP9M4EnhUkLkpOOxmTbvQWeBsKJyCz88MTmLRbj+sh2oQBe0VbN4r37ziR3jvIr9/Cw0EHq0fUjr/B479IzLa6gkhowvgjx9gBJLZAUMUSFnXcwnbdi/auaX2l9WFuA5DdfvAe+ZLAZrZPKUcIk1x91Omc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672221; c=relaxed/simple;
	bh=aroPpoii0ChkH4MdCqrRHp9zKlDHN7bwF6/MTPv0QCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6UwAPo5+H6pYn/8qaIIP5YcYNVKATpdxksPsaO5syHtM+b8eRVzbBkEa2kDJA+MXlsbJOjyqvhTyGtummSOtDUKf/pXGkgiLorYmPgTHoRgZKZZ7KtweNJA5EYW5DcWQARg6WFNCrRedUPyBzfGzaBbtdxKG2EZxEHNeQsFY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WhYLiT1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33758C19421;
	Wed,  8 Apr 2026 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672221;
	bh=aroPpoii0ChkH4MdCqrRHp9zKlDHN7bwF6/MTPv0QCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhYLiT1s9cSc2mUF+lush597zz7wzaxVsDo213vZjBzn4KuYGGinlakGPrGcp/HWA
	 7jevlBJtoT43SWuXf6ARVJemyoVyRsp1vf18g0Op3jDcRUShWg2NTUlNZC74jvTRpq
	 umjkJx0oqYVutb/79uwvVheMD5IG1oaxT846iCJ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 237/312] Revert "ext4: dont zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1"
Date: Wed,  8 Apr 2026 20:02:34 +0200
Message-ID: <20260408175942.603251014@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234192-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EEEA3C055B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit ddf854e59166533b0f46ba32cd6cd9aca3197d1b.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index da7414e84ead8..e2f9c27c7e161 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3298,15 +3298,6 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 		}
 
 		if (!err) {
-			/*
-			 * The first half contains partially valid data, the
-			 * splitting of this extent has not been completed, fix
-			 * extent length and ext4_split_extent() split will the
-			 * first half again.
-			 */
-			if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
-				goto fix_extent_len;
-
 			/* update the extent length and mark as initialized */
 			ex->ee_len = cpu_to_le16(ee_len);
 			ext4_ext_try_to_merge(handle, inode, path, ex);
@@ -3382,9 +3373,7 @@ static int ext4_split_extent(handle_t *handle,
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
 				       EXT4_EXT_MARK_UNWRIT2;
 		if (split_flag & EXT4_EXT_DATA_VALID2)
-			split_flag1 |= map->m_lblk > ee_block ?
-				       EXT4_EXT_DATA_PARTIAL_VALID1 :
-				       EXT4_EXT_DATA_ENTIRE_VALID1;
+			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
 		if (IS_ERR(path)) {
-- 
2.53.0




