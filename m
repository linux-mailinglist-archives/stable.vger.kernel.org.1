Return-Path: <stable+bounces-131567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CFA80A45
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177F97AB636
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318DC27605E;
	Tue,  8 Apr 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ApYGUchZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F7276057;
	Tue,  8 Apr 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116745; cv=none; b=IQryNKYRLUkENPVuirpJjg2uL/4dKFhfw4UM1hinFvf9KcC5WLnHF6C5tql0P7kbGUBdsjLfo89CHfIVxXUCaUFDgEYyd67JD16zdjvf27NUDX8afADFA+3dRg+L22Vw3/7C/XAaLZcCT+fsc6tlDFtSTtmm79rb6SEX/HgNOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116745; c=relaxed/simple;
	bh=kpotMDKI1mJfcebzW9DC3jeivrqqzx+hyxkXqhxEYnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REUJHkxfy7q++96Cm8WuNYhbjbsC9Omj/8jz3b6Tz0MhhIsLKSq8L+R5SJAyPwHSifok3H3FcsITCz5hlE0LxlqvpeshwuvfnFBwLbt26nx9qgrWIf5qujJnAu25oAVdcQB5HV7hZ1ppOisDEnChamScG7KXpH4SwmeLfnJgOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ApYGUchZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EF1C4CEE5;
	Tue,  8 Apr 2025 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116744;
	bh=kpotMDKI1mJfcebzW9DC3jeivrqqzx+hyxkXqhxEYnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApYGUchZaUy7LmKZ9jBhUbPZm0nFHO+AgKQ6rHlvQAD89yJmrL6XlF9Nvs7TlZlnz
	 8xjG1j51FUUW43Y/mLngVjMs4oQspiQPKaj9R+1auJtTBc/cPf3KhH1wZB2S1whIee
	 qQM1sQ/HAM8N5OHs0jbrQlHhsJclY0BIaqjvmN/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 252/423] nfs: Add missing release on error in nfs_lock_and_join_requests()
Date: Tue,  8 Apr 2025 12:49:38 +0200
Message-ID: <20250408104851.607939369@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 8e5419d6542fdf2dca9a0acdef2b8255f0e4ba69 ]

Call nfs_release_request() on this error path before returning.

Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request into nfs_lock_and_join_requests")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/3aaaa3d5-1c8a-41e4-98c7-717801ddd171@stanley.mountain
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 82ae2b85d393c..8ff8db09a1e06 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -579,8 +579,10 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 
 	while (!nfs_lock_request(head)) {
 		ret = nfs_wait_on_request(head);
-		if (ret < 0)
+		if (ret < 0) {
+			nfs_release_request(head);
 			return ERR_PTR(ret);
+		}
 	}
 
 	/* Ensure that nobody removed the request before we locked it */
-- 
2.39.5




