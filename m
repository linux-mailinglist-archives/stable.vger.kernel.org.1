Return-Path: <stable+bounces-83706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B239299BEDC
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41281C21030
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D61494DD;
	Mon, 14 Oct 2024 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONDQ1rew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E2A1494A5;
	Mon, 14 Oct 2024 03:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878372; cv=none; b=io+ofgyQm5qtkZq4rTL9H13IA7LfZk3QycpCdGiqy6USN+vXTTGUzxcWKkC8XOaCnXgqKhG9XQCQno+iGAXaUeQa68Xqf1IaBQ3fXJHosnZWhIigWpAiZctntkJZf4Xw0nYR4zJqazTmoi8GdvYiaM/KV5lXdD50aIaIJndGHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878372; c=relaxed/simple;
	bh=+pCTZq5gffnwaGyI/JHSLk7jHCYopxjr2+PXu0oiK6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLFRdO399yaKV8wv10OLz+kg9vnuKAfFED1Hv1YIOJcnwLkow7M1/qlQvjWVdZH5JSZoU8WTZkKSMUUPWlg92JiZ7kUeKdfeF/KwHvwNB1dzw4cKh6UPpBbgvhaZJKH4Mpxv0O0gZPqd+BeH1ztMZkrrxbck/zEDftG5MjrE7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONDQ1rew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3718C4CEC3;
	Mon, 14 Oct 2024 03:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878371;
	bh=+pCTZq5gffnwaGyI/JHSLk7jHCYopxjr2+PXu0oiK6I=;
	h=From:To:Cc:Subject:Date:From;
	b=ONDQ1rew2ldnG/1YAoRDfmB9UxzBjFPyhonOImpzaFkIBoMiUPxxG78DAtOsxjbbV
	 4qG9X6SwKpXyj/Q96nKiO5qsLbLfCHV8GSLskgc/7lR4aq6F2d4A6P/PZRDqzI2xRS
	 AY7ia8mZFf9x97D6JcgkZAGglX/QFN5X6vAxtLb+LBjGiTePbvO+i/guMAKCOJFROe
	 cc6CLax0AyZqxXrxGRRKSEbS8PeeTOvmnCOGb21oZdmia8kR8Wr/KptOIx9U8aVhmM
	 8dDvtghE1DsOddc7Lbb2Lkt/xxzyRTlnUve1aSfnJDXH+DBojVA/2PnemHkXOoNkcc
	 sRzuJ/xKKXrpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 1/8] fs/ntfs3: Check if more than chunk-size bytes are written
Date: Sun, 13 Oct 2024 23:59:16 -0400
Message-ID: <20241014035929.2251266-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 28f654561f279..09db01c1098cd 100644
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


