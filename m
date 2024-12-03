Return-Path: <stable+bounces-97871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066BB9E265F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9512616C3D8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8BD1F8926;
	Tue,  3 Dec 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xcA6T/yZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FF1F891C;
	Tue,  3 Dec 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242018; cv=none; b=isd4ncDkAe7CY4PK8uapla2Wc7g8VU2VpqdkaDB1n9uVd5uI3zMDUJk1ei9isuE62O2ps9T0gQoDtiqOaU75sFckE9Sqd/bgBU2NGe6CYVlCmzvZjhfsDGmljjSZZEuZyVxweDIhQ4iVOjxFLe0A7lTbGlw9fYDOKIA/QLjGfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242018; c=relaxed/simple;
	bh=DBLD4k5hJAS/cQzOaAbGNIQwdMwtDdA39/ufYjDiEvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bd9rRq6eUjiduQrEskGqIUQ7qRRGd0DeNJZ40QV9GCamUwrnRImnHtCw1Opnsp9EtE7fwXsEcFnRY9urrBH5eEYHpuFgE5hLt+HtHufJyxJTl9RHS2f76vjYvLHv4b/Wgj/M85zKXvevTJB7g4/Je3UBVx+ugPAq0m6P+0MCEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xcA6T/yZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A168BC4CECF;
	Tue,  3 Dec 2024 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242018;
	bh=DBLD4k5hJAS/cQzOaAbGNIQwdMwtDdA39/ufYjDiEvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xcA6T/yZ7TD0nSxcEuuLTE62E+7KtEpT4T05Lesv74LxB2zEppfbiGFqvwccKKxj5
	 CHi3kr1zzIuY3z5S9jQ86EQqUNfd61cTnPI4s6VFlfoq8yOBJsVfrmshiH3qV+OcrS
	 ElokMQtqmEElKT7tAOMpCDKEV1O/W5+6jDxP2s18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 552/826] fs/ntfs3: Equivalent transition from page to folio
Date: Tue,  3 Dec 2024 15:44:39 +0100
Message-ID: <20241203144805.282250224@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 045fff619312fb013540c80cff18aab3c33048ab ]

If using the proposed function folio_zero_range(), should one switch
from 'start + end' to 'start + length,' or use folio_zero_segment()

Fixes: 1da86618bdce ("fs: Convert aops->write_begin to take a folio")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index e370eaf9bfe2e..f704ceef95394 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -222,7 +222,7 @@ static int ntfs_extend_initialized_size(struct file *file,
 		if (err)
 			goto out;
 
-		folio_zero_range(folio, zerofrom, folio_size(folio));
+		folio_zero_range(folio, zerofrom, folio_size(folio) - zerofrom);
 
 		err = ntfs_write_end(file, mapping, pos, len, len, folio, NULL);
 		if (err < 0)
-- 
2.43.0




