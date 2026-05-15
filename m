Return-Path: <stable+bounces-248290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHTPGNVNB2rAxgIAu9opvQ
	(envelope-from <stable+bounces-248290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:46:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE1553E08
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B975D310F661
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF3C3FD95C;
	Fri, 15 May 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xRqo8USw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC13FD94B;
	Fri, 15 May 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861356; cv=none; b=QcPCnSmReV4f0BZ8+FqZyJc10PHA7UDLJHCK3D/EXOzM1gbMKMaPbV7cLVbxfQxeLAGxJ8zwfacKHAsRzzZuTFdGg1TdZDTWc1d5MkxA34BuAIBqKpXgaEdwlbviiePzdGM8iEvpbN29uKQPG9W0Mz+OWfwZtpSL2hqageBbuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861356; c=relaxed/simple;
	bh=mucZ4Pf5mVvDwXtiQb9e0lLI7SwELleZyddSm6x5zHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+FQaM43yKNGS7yM19dGfaGlAKZEicciLdz7UAew0kOh9J6AjD1gd8HxEpfhgsdp9QePGWjDVlKbxemfjKxVS0dxpqk0X7Bb9zEAoyEqWQUdna65dovpGTGB0c9atiChrSNbXIYkUKpLzOaYLvmkALsyCaCkz+jkCD4ozzF4/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xRqo8USw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87B1C2BCB0;
	Fri, 15 May 2026 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861356;
	bh=mucZ4Pf5mVvDwXtiQb9e0lLI7SwELleZyddSm6x5zHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xRqo8USwa71ujFTQaFebuV01V66KMkX03pZ9p1Zm8H/h60dNFVDKzoqgcVKGtCvIX
	 6ihFMHBjaFJn5LROEp2w70JM29Q56JQ+77eDcbJGLaaV4+VxG2/B8YwqIPnIbdlcxM
	 gvbBMGPSY8ceor00M+lZuanAB7GeLqQYaX7rIaI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.6 290/474] f2fs: fix incorrect multidevice info in trace_f2fs_map_blocks()
Date: Fri, 15 May 2026 17:46:39 +0200
Message-ID: <20260515154721.275899407@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C3AE1553E08
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
	TAGGED_FROM(0.00)[bounces-248290-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

commit eb2ca3ca983551a80e16a4a25df5a4ce59df8484 upstream.

When f2fs_map_blocks()->f2fs_map_blocks_cached() hits the read extent
cache, map->m_multidev_dio is not updated, which leads to incorrect
multidevice information being reported by trace_f2fs_map_blocks().

This patch updates map->m_multidev_dio in f2fs_map_blocks_cached() when
the read extent cache is hit.

Cc: stable@kernel.org
Fixes: 0094e98bd147 ("f2fs: factor a f2fs_map_blocks_cached helper")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1507,7 +1507,8 @@ static bool f2fs_map_blocks_cached(struc
 		f2fs_wait_on_block_writeback_range(inode,
 					map->m_pblk, map->m_len);
 
-	if (f2fs_allow_multi_device_dio(sbi, flag)) {
+	map->m_multidev_dio = f2fs_allow_multi_device_dio(sbi, flag);
+	if (map->m_multidev_dio) {
 		int bidx = f2fs_target_device_index(sbi, map->m_pblk);
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 



