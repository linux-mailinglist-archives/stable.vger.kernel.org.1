Return-Path: <stable+bounces-137209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BBEAA122C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F5116DA6E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5F42459C9;
	Tue, 29 Apr 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GdOiDpNZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AD242905;
	Tue, 29 Apr 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945390; cv=none; b=AD1ZGw/m7NoTiWJEHHeRE6hBcKSnRyQCYktWdyzE8c6F80axTYmBNBIjtCVkM2gT2D6RePdUeGMIXTo3gCOnn7BVQ0qkDemN/f0LcGjem4T6i+Z/7KogmG/yb9XuRhXlMf8dRgiinHJ9zxARMM5lCd1+WHl2yI3mWRdtmhietAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945390; c=relaxed/simple;
	bh=c8tEyyIqjTvCjUHi23tPeZFdwk670ftRwQBRLSXP1JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAOf8p0B79D+0rCg9ulO1JeOJ49wqJLgwjN4Le3T9fmLA6QY10Y6BdrSNuJs5MnBEn/tzNEouODgbNrykxO2CaN2gSLHIRhWoRvvsws+o0oZY2lVJvMe/w3dzZM7/MDMBzifgSdsEcJFVZ+QvhS/rz1nBrQy7d3AANctgu4CzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GdOiDpNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D856AC4CEE3;
	Tue, 29 Apr 2025 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945389;
	bh=c8tEyyIqjTvCjUHi23tPeZFdwk670ftRwQBRLSXP1JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdOiDpNZ7oS1iupx0Ed7cdLrErW8AI6awvKxmNPyxOHuocwfxe9tbGKBqDNPncWeI
	 vkkyQW40DPaBQNY5qMtl8YheHgdrHY+mbB82pXV9Fl10bbsvize8QUnaAGQwYQ25/G
	 /flf3eZAsuxStYbfi2WN1zfbIgewXc78hNGVhE0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 096/179] NFSD: Constify @fh argument of knfsd_fh_hash()
Date: Tue, 29 Apr 2025 18:40:37 +0200
Message-ID: <20250429161053.281491418@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 1736aec82a15cb5d4b3bbe0b2fbae0ede66b1a1a ]

Enable knfsd_fh_hash() to be invoked in functions where the
filehandle pointer is a const.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Stable-dep-of: cd35b6cb4664 ("nfs: add missing selections of CONFIG_CRC32")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsfh.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 755e256a91039..42c168ac6b934 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -216,15 +216,12 @@ static inline bool fh_fsid_match(struct knfsd_fh *fh1, struct knfsd_fh *fh2)
  * returns a crc32 hash for the filehandle that is compatible with
  * the one displayed by "wireshark".
  */
-
-static inline u32
-knfsd_fh_hash(struct knfsd_fh *fh)
+static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, (unsigned char *)&fh->fh_base, fh->fh_size);
 }
 #else
-static inline u32
-knfsd_fh_hash(struct knfsd_fh *fh)
+static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return 0;
 }
-- 
2.39.5




