Return-Path: <stable+bounces-83679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B799BE97
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A5EB231D4
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3313CABC;
	Mon, 14 Oct 2024 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYYf5yyZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5913C810;
	Mon, 14 Oct 2024 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878298; cv=none; b=Aw2ivpUrj/hCD4acHlSTLnAf7oDVxZvMto33XBl8xHRJfM/Ht01OxqrKXTQljLHq7Nw3CGG6y4GDWBXPM5SU71uhFe0BfIhHISKj7gNpMs5UsQb0yvf3Jq3VK7FFeeEfTXxdBwc29zIEYCfXfrbyve1ePyEsbWKn/X5oqqCEJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878298; c=relaxed/simple;
	bh=kjv1k59V4Iv3EuGSi6TCLdCI2lLkb6B+qdpAvoR8bi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kdotzxk2ELlgqKDQH/td8WW9HyrqSDSwqUglrvefzFonOPESuSCpyMxq4Q8IzkGVa1TQlspFungZuV8El33eybllFQpPu5iIYq2ZT3Nc/eTKwQhcMuo75gqFiNvafEdbOi7r+3NSEiWR5oOgLWkdRH/1Qm6m5RK3PR+gtCBZNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYYf5yyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA071C4CECE;
	Mon, 14 Oct 2024 03:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878298;
	bh=kjv1k59V4Iv3EuGSi6TCLdCI2lLkb6B+qdpAvoR8bi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYYf5yyZY4Roiq+8S5WXPqGnNzo1Ihus3q3pPmpIVzD++CIqFACzmT93DoSy5Y5qR
	 tVxnWvD/XV4esMQo2tCwArDGxzGzTiZLzoBFLwZ1MeN5IJCgArqY3cmefecMHznHrm
	 5P/9rQi6nozLy8amhlv9aBB5KqxLJFGc22WD1qcgldbjqnblj+cWrRWNEPxUmY8e77
	 bDz+Dcuh1er6U3l8wsXrONvMgV5ihvL4gStCVcR3X3ucVhKZZTW1oJRiKFCVyRUr9v
	 KC9CqONwDQXGmEM0f2Mn50/z/iqg9lxFIWnFZxmL932+OC6uujemaWZp2VfxpZjiyI
	 1fbOV8sKMmDfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 02/17] fs/ntfs3: Check if more than chunk-size bytes are written
Date: Sun, 13 Oct 2024 23:57:52 -0400
Message-ID: <20241014035815.2247153-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Andrew Ballance <andrewjballance@gmail.com>

[ Upstream commit 9931122d04c6d431b2c11b5bb7b10f28584067f0 ]

A incorrectly formatted chunk may decompress into
more than LZNT_CHUNK_SIZE bytes and a index out of bounds
will occur in s_max_off.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/lznt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 4aae598d6d884..fdc9b2ebf3410 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -236,6 +236,9 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 
 	/* Do decompression until pointers are inside range. */
 	while (up < unc_end && cmpr < cmpr_end) {
+		// return err if more than LZNT_CHUNK_SIZE bytes are written
+		if (up - unc > LZNT_CHUNK_SIZE)
+			return -EINVAL;
 		/* Correct index */
 		while (unc + s_max_off[index] < up)
 			index += 1;
-- 
2.43.0


