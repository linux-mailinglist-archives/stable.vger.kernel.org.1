Return-Path: <stable+bounces-30533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0008C8892AF
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89448B32505
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C3B1B5DA8;
	Mon, 25 Mar 2024 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBLzdHFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429712733E3;
	Sun, 24 Mar 2024 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323321; cv=none; b=s6lWh+ZkQ8rYWoUxkckobpK/SY2vJ9BQ857fdX4S79aCpJ5K2PdgCBCK2iOdnPanW+wm7+AjwU9bIaZr3+pbhFw1UGrl0y41nbzpjYLbdMFeukXA5/plq2zGvQrlxKMPfVYdroZMaOYruPsWlxj/Zu4DpSm2hUDDxNRNEkApV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323321; c=relaxed/simple;
	bh=DDOX3T0lZuNLGsUeStj+eXV4HiTTPbTPnMakOgBV/qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBS8hQWYzbvzDj9nd3XbYzRJ0KZxUgy4mAU1aoB8B0luQue60S3cMcN+feP+EIaP6tbSvmnHVA+bFtnAfSh24oa3rFmSrDwvKTIh/EJcznxolMACeb0CJqkc/O8PZ/1VCngurE2G5cgwxnmLJJ0bHSbmjeaa6Jo4r6TnpyiZT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBLzdHFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7968DC433C7;
	Sun, 24 Mar 2024 23:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323320;
	bh=DDOX3T0lZuNLGsUeStj+eXV4HiTTPbTPnMakOgBV/qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBLzdHFXmiH9ehI5qH74+LZuj0Q+858S+VKkJnUUjkcqvFmI+x5PYV3IkUS3jr07C
	 lYB8uVSqHngU6GZ7Seq+nayKRRXat7LfHoP3SyrMRUcq9RzKVkvagWwIvOHcHVEK+2
	 yDSXGU5lFvdMi8s9G3b30kjUTAHVVFh07JQWSMhwCz0ScLwoGbaQgGc0DosFD777+u
	 +OOJs9wVd6UnRPI2nTPwAVgTdFQCgY/Sc2s56RuKdK7gDkJT6BJZND85PPbQSakIEC
	 TMk5e6yBtA2MaS7aMOsJzHUlcuujGuS1PVL4HyJgVit+XsY/vZwFBHRzmRiv9aAnWU
	 1j+CQ5Lt59few==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 020/317] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Sun, 24 Mar 2024 19:30:00 -0400
Message-ID: <20240324233458.1352854-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 787f1b2800464aa277236a66eb3c279535edd460 ]

"struct bvec_iter" is defined with the __packed attribute, so it is
aligned on a single byte. On X86 (and on other architectures that support
unaligned addresses in hardware), "struct bvec_iter" is accessed using the
8-byte and 4-byte memory instructions, however these instructions are less
efficient if they operate on unaligned addresses.

(on RISC machines that don't have unaligned access in hardware, GCC
generates byte-by-byte accesses that are very inefficient - see [1])

This commit reorders the entries in "struct dm_verity_io" and "struct
convert_context", so that "struct bvec_iter" is aligned on 8 bytes.

[1] https://lore.kernel.org/all/ZcLuWUNRZadJr0tQ@fedora/T/

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c  | 4 ++--
 drivers/md/dm-verity.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5904af05f6057..a3db76dcdb3ec 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -49,11 +49,11 @@
 struct convert_context {
 	struct completion restart;
 	struct bio *bio_in;
-	struct bio *bio_out;
 	struct bvec_iter iter_in;
+	struct bio *bio_out;
 	struct bvec_iter iter_out;
-	u64 cc_sector;
 	atomic_t cc_pending;
+	u64 cc_sector;
 	union {
 		struct skcipher_request *req;
 		struct aead_request *req_aead;
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 78d1e51195ada..f61c89c79cf5b 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -74,11 +74,11 @@ struct dm_verity_io {
 	/* original value of bio->bi_end_io */
 	bio_end_io_t *orig_bi_end_io;
 
+	struct bvec_iter iter;
+
 	sector_t block;
 	unsigned n_blocks;
 
-	struct bvec_iter iter;
-
 	struct work_struct work;
 
 	/*
-- 
2.43.0


