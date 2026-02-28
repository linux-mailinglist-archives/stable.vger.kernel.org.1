Return-Path: <stable+bounces-221185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLSLC8dIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DD41C7A53
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 073E833C92A1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B1E373149;
	Sat, 28 Feb 2026 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7umlK7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4F373BFF;
	Sat, 28 Feb 2026 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301543; cv=none; b=DWlL9NoN+PhBJ7OSu/Rzh4fkotYH7h4scRLPGlmp/dUI3Ywg3ZfmREVAinU7AqnHY/knJZyR7EMtigFuuVxtGO1+iFQ97U+vOY+KghikuT2Gab0uqgmg/yIQUGAdU258RXljSGNbPFZxTrjLSO4ZvvujsM2QieN8epFGMc2bsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301543; c=relaxed/simple;
	bh=gSAWfxp5eJD0sIzUDtpk/0NftBzDDHBl6uibrSaGe58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPrReUYn4s3EDFuDkLpy5fYjrvOj5hzB+IQ5fXfgzSj8KD6kU2ujpGkvRNkkmVNy5K2rS92kn0gpgxf4VgLKy451AAEHQkzEUms87vqJi68OwDUAUSVlKMGUYs70qygFkai1wY4W1jfiP6r9cU5lanykWNE1QUlnVSczkB8dWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7umlK7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57059C19425;
	Sat, 28 Feb 2026 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301542;
	bh=gSAWfxp5eJD0sIzUDtpk/0NftBzDDHBl6uibrSaGe58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7umlK7Kyb7bxsCnHqavK8KFyDGClXvjXleRy831tTYOterpe/yct0HJxq//Bwl0f
	 HpD3r1pEWLDqbYSejIYCgx1oRHe9YlwbQ/s11h+sz32gAmlPiNhsEGkfGrQxlHPFRK
	 vSCIjnyEVTSTg3W42SgcTfzlo51Y7CIkDv6biZRak1TyZMRD5bbf6wyDPJgdh2VDce
	 sCGNFRASGEDYbOs4QgDSPiEQJiGeW1xnicj2dJhubXEZd66TbpAWqMW/37TzIGnZ2/
	 KI4TPApvfN4YSHaKFpMdygxvvZFjumue3K/IXqsx6i8YCQYzYCg64+zK38lTVve6ru
	 U7/LCseU6SWXw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 725/752] io_uring/zcrx: fix sgtable leak on mapping failures
Date: Sat, 28 Feb 2026 12:47:16 -0500
Message-ID: <20260228174750.1542406-725-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.dk,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221185-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86DD41C7A53
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
index 03396769c775d..030d632d98392 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -287,6 +287,9 @@ static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
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


