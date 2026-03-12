Return-Path: <stable+bounces-224997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIvcHtQfs2l/SQAAu9opvQ
	(envelope-from <stable+bounces-224997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:19:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E19A6278C6E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 675493055E61
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC931F4181;
	Thu, 12 Mar 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VdeFul5n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C541FF7C8;
	Thu, 12 Mar 2026 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346520; cv=none; b=HGMMyQli2GJaxqRFfx2qvo31qKIHl5RduT1z4mo79Hmh0dH1hLY/cJEHoizj4g7LgKP12w97NemtPaASfRCRt7NeuekV3DsYx93PGLiQKeyU7yqdYhnKbBWxQHM1DgoFoxRiWRNDScfxfO4OOtv/H+bahfi1SEszFRByPCeypVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346520; c=relaxed/simple;
	bh=dZw4UA86ufTl9YclgybkU55C1RIXM2zochypvYd26I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/AUFtbSj9/eZHzskeeRDiiIszz4qS4ZL1n9sR4+nnCFbApYDah+K770mQYsh7xTHs7UmQDy8nW7prTivFTrpsaySrGoRBic4V8M38NJTuMtIEtydkSaYjzmXaXKgV8ZusZpc0VGams/nNNxyTJYT+J+wjrFrQFwEJQ8UuNTBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VdeFul5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E18C4CEF7;
	Thu, 12 Mar 2026 20:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346520;
	bh=dZw4UA86ufTl9YclgybkU55C1RIXM2zochypvYd26I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VdeFul5nGcgUvS5MMEZnc1afe6Yf1bxjV3AR/CXJePaDSz8s/DzCairr3GgBM13s2
	 1eaAeMVmPjZ7+wqWtR1sfBnSItmCRUgDoMvvhyBY06yby4ytKjSbOimUASZM3Ax/cp
	 pVq2+5j8vx19SrZ7WZco2qWWiDwhv/RkyGYQurPA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Erkun <yangerkun@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 064/265] ext4: correct the comments place for EXT4_EXT_MAY_ZEROOUT
Date: Thu, 12 Mar 2026 21:07:31 +0100
Message-ID: <20260312201020.525185125@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224997-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E19A6278C6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Erkun <yangerkun@huawei.com>

[ Upstream commit cc742fd1d184bb2a11bacf50587d2c85290622e4 ]

Move the comments just before we set EXT4_EXT_MAY_ZEROOUT in
ext4_split_convert_extents.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
Message-ID: <20251112084538.1658232-4-yangerkun@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: feaf2a80e78f ("ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 05d4a63300867..7301cf1726903 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3754,10 +3754,6 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 			>> inode->i_sb->s_blocksize_bits;
 	if (eof_block < map->m_lblk + map->m_len)
 		eof_block = map->m_lblk + map->m_len;
-	/*
-	 * It is safe to convert extent to initialized via explicit
-	 * zeroout only if extent is fully inside i_size or new_size.
-	 */
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
 	ee_block = le32_to_cpu(ex->ee_block);
@@ -3768,6 +3764,10 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
 	/* Convert to initialized */
 	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
+		/*
+		 * It is safe to convert extent to initialized via explicit
+		 * zeroout only if extent is fully inside i_size or new_size.
+		 */
 		split_flag |= ee_block + ee_len <= eof_block ?
 			      EXT4_EXT_MAY_ZEROOUT : 0;
 		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
-- 
2.51.0




