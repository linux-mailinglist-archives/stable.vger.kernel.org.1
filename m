Return-Path: <stable+bounces-130483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB0A80521
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CB44A41EE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D2C26B09A;
	Tue,  8 Apr 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r3u8QwEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AD26B096;
	Tue,  8 Apr 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113831; cv=none; b=XsnSs90yto3gbWOm1/QznI6w007RcF/+cTk3AMdxIWcaD7KzsDHXGHmpu7MAsLY5xXP99f6j1S+rHzlZ7yQDs40oNtTcAT5DkxGPkTsWFc7wd4qLLoSLoqZAvcv6ZW5GGeiEaVpasjngIFr5wS3OXDpv57/axZRvxGTTERVyuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113831; c=relaxed/simple;
	bh=OIkka/P4uTTcpnyjcdpMJG3aFXE2ojNbOKXfzW7bNZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew3Z4AkxOwGn0z+K9shKdZ5xgJoH1HmA2rgjE1Ffr5wq7wou40uNi35+jhDLCtyVY4tzc1wKIPvZ9ncil3WzcwpioF199B3U9sSymaLG0kjOBrYAahdi3PvNDTej4ynMUpCD0gTu+WlFRQMn7Yt/pPNqWKLrTpb1fkZ4DnG7k3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r3u8QwEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13D3C4CEE5;
	Tue,  8 Apr 2025 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113831;
	bh=OIkka/P4uTTcpnyjcdpMJG3aFXE2ojNbOKXfzW7bNZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3u8QwEmMV+Vnus2IQ+SgCQtv+6Mi4q54NXJZgUPOIzKrAgyStszad8J92YysoGmy
	 qkRXUwnIpMin3F4MH/3oLYoLPRpmOM+feFgNWoSEpTHSzrFuiK18nkeJH+3a/fPCLs
	 nWzb4cQD548rppB0g44xje117zy5BMngHmw3t9Q4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangwu Zhang <guazhang@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 037/154] block: fix kmem_cache of name bio-108 already exists
Date: Tue,  8 Apr 2025 12:49:38 +0200
Message-ID: <20250408104816.450930625@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104815.295196624@linuxfoundation.org>
References: <20250408104815.295196624@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b654f7a51ffb386131de42aa98ed831f8c126546 ]

Device mapper bioset often has big bio_slab size, which can be more than
1000, then 8byte can't hold the slab name any more, cause the kmem_cache
allocation warning of 'kmem_cache of name 'bio-108' already exists'.

Fix the warning by extending bio_slab->name to 12 bytes, but fix output
of /proc/slabinfo

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250228132656.2838008-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index e3d3e75c97e03..239f6bd421a80 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -53,7 +53,7 @@ struct bio_slab {
 	struct kmem_cache *slab;
 	unsigned int slab_ref;
 	unsigned int slab_size;
-	char name[8];
+	char name[12];
 };
 static DEFINE_MUTEX(bio_slab_lock);
 static struct bio_slab *bio_slabs;
-- 
2.39.5




