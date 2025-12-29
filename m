Return-Path: <stable+bounces-204023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99457CE77EC
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4FCF3011AA3
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBEB3328F2;
	Mon, 29 Dec 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aUw2FXxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B83328EE;
	Mon, 29 Dec 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025834; cv=none; b=RJvTCoH9F93tTqmBYsTd6VXcdlyjFZe4gIO3U6+ve+kpWG3f2yOsLfq5yKH2HnO4kUQKxutH9BrbG+WGl/qJaqKn6ANi68a9eAqhTzfJNKHnO4TVXA4iXIbEe2c80R8JRm++OKq8HQk0T+b7nvK0tPd6IwThQwVJb8dI/8hwTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025834; c=relaxed/simple;
	bh=OyjjQHMbqF2O7WO6S1msMmMEhwjCmUdSg/hVNTe05Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG+4ti2lQ2HqHmCAvZd7eIv3coUT/3XpUMmrD580s2oYP2rLPi4eNxRh8/7de7vNg6V0+c0523megCJDdXMzkuIo9HX8Q7ARbLPl4eotUxII6ehXhXKzNomJhRrzzNvRl8pNwLKAyLfTSLujj/xZY8RL7vtEPngEIJ4iEMqbUzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aUw2FXxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9FCC4CEF7;
	Mon, 29 Dec 2025 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025834;
	bh=OyjjQHMbqF2O7WO6S1msMmMEhwjCmUdSg/hVNTe05Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUw2FXxZmV2HPC9YLRQPdjwXQ7x7uxBqi0XJKTrS0V7xHen5ov0RVImOdd7RmQXXr
	 d3fz5oWHosjnofOOwFN1yAgIcy911MNwKHV0+IL0BoipJbauvHzsCmU6QnLyJY27d8
	 68du5HDvVj74CldpYAv4xKsVipnS5u3ljC6LpL1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.18 354/430] xfs: fix a memory leak in xfs_buf_item_init()
Date: Mon, 29 Dec 2025 17:12:36 +0100
Message-ID: <20251229160737.353458870@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit fc40459de82543b565ebc839dca8f7987f16f62e upstream.

xfs_buf_item_get_format() may allocate memory for bip->bli_formats,
free the memory in the error path.

Fixes: c3d5f0c2fb85 ("xfs: complain if anyone tries to create a too-large buffer log item")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_buf_item.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -896,6 +896,7 @@ xfs_buf_item_init(
 		map_size = DIV_ROUND_UP(chunks, NBWORD);
 
 		if (map_size > XFS_BLF_DATAMAP_SIZE) {
+			xfs_buf_item_free_format(bip);
 			kmem_cache_free(xfs_buf_item_cache, bip);
 			xfs_err(mp,
 	"buffer item dirty bitmap (%u uints) too small to reflect %u bytes!",



