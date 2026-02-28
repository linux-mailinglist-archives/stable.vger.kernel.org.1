Return-Path: <stable+bounces-220892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG6+JdFFo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8831C7539
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 520D33083DC7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60178424E64;
	Sat, 28 Feb 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6JdFSCv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22094424E5C;
	Sat, 28 Feb 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300782; cv=none; b=EsyzBRcIa9R02KNeNnTzMl06x76mhYsA+W72PnNX4uRCSR3u3qd8XMZEEI5vwx+OoZHNH1NkJrIdtc4e15kwNmsFKfZRUgIZdk3W+KQsA4AyA6RQYLwmhyPSihB5RcCihahDwMo+TT8IfISpv34F792HAQrYObud0SW5PWxbXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300782; c=relaxed/simple;
	bh=oTP09YI/Pkrs6Rd3W3Jt/xedViZH/Wz+wk5aZE2TSg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwSl1H7OYCL7YUgvZiQl/RkQe8H4Kuy5qZnpd4TVaes/EbKpSbOZ12nk36zGq5YqSYGQYkemZeWuAw2g0qvq8g6QUv+JA7TuM2f7qSMWG3pFOdN6/VZt2j/U6tACqbGst8UgdOKiZqE38blV/EWOe782KloSnzRz9wJ3hkTk9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6JdFSCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681C3C116D0;
	Sat, 28 Feb 2026 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300782;
	bh=oTP09YI/Pkrs6Rd3W3Jt/xedViZH/Wz+wk5aZE2TSg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6JdFSCvGlMKvHs/VbMubiM3WAAxgGxBgaLJtousV6dftfBOnUnYnLU4quV/9FMTE
	 sN+PoKSzZLasEV5LN3/UpK7iPh8rW1nMdWczWGI5aNk36w+7CGNvKpQnidmU09MNHh
	 RUo9i488/F2EqjVsGuST2NpqolGh3AncCceXP+3lXIiRbV4JdMmzm/2KUYz4Lmf5WK
	 xfptG7NIltWURhrxUyGjAfGIK2v+8x/+JK1o7IBRQiRdOUD6+VOP+ycXU580AnJ0+S
	 CQ9RsA8aH39xZWQIJ8+vk/k+HPfW8iq07uSAX8BONghkmJ77TkDdmFuI95e9hFK/UE
	 qSat0q45vr9OA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 813/844] io_uring/zcrx: fix sgtable leak on mapping failures
Date: Sat, 28 Feb 2026 12:32:06 -0500
Message-ID: <20260228173244.1509663-814-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220892-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B8831C7539
X-Rspamd-Action: no action

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit a983aae397767e9da931128ff2b5bf9066513ce3 ]

In an unlikely case when io_populate_area_dma() fails, which could only
happen on a PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA machine,
io_zcrx_map_area() will have an initialised and not freed table. It was
supposed to be cleaned up in the error path, but !is_mapped prevents
that.

Fixes: 439a98b972fbb ("io_uring/zcrx: deduplicate area mapping")
Cc: stable@vger.kernel.org
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/zcrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 3d398283cf340..b133c85793c9c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -288,6 +288,9 @@ static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 	}
 
 	ret = io_populate_area_dma(ifq, area);
+	if (ret && !area->mem.is_dmabuf)
+		dma_unmap_sgtable(ifq->dev, &area->mem.page_sg_table,
+				  DMA_FROM_DEVICE, IO_DMA_ATTR);
 	if (ret == 0)
 		area->is_mapped = true;
 	return ret;
-- 
2.51.0


