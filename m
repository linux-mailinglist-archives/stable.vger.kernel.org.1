Return-Path: <stable+bounces-49726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B1B8FEE95
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D411F2444C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1064F1C53AD;
	Thu,  6 Jun 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ooMPBAof"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298D1C53AC;
	Thu,  6 Jun 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683678; cv=none; b=SuLTjyKKuhZvpC/ElWUx71jp888wSk5PW2SnQ8SWVgdJRDlhjxtPm7+0X9gYifbJxzRaWumDoHl2+WPPN83wTDuBKsggEOA15u5ZnVnJZAGCRwod3CU1SD+oB2e/ZuV8ERQcz8UQaker1lx2mOXFet+B+jiFSb3q+6EeevmO4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683678; c=relaxed/simple;
	bh=LfnDgQd27EB2H8Zh1pxsgbfafKLc9cwQOd2EOQeQV7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOqIk4BFmeS8UM1b0peREpESZ1+MrQvuv3+vm+IkI/5y9mIV01Ys8z+Enem/dUi1Qq62rveOBUxZlH0ihQj3EkZVbuxRewzYjo6PVJVkyc72lc/tYVPOWpPE1JROidg+B8ZrJCdTkPlYZLJnmcUGS3Q9mFxStSoOXir4lKnFpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ooMPBAof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB3BC32782;
	Thu,  6 Jun 2024 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683678;
	bh=LfnDgQd27EB2H8Zh1pxsgbfafKLc9cwQOd2EOQeQV7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ooMPBAofP6+rOKnIDZMZwPc/i/Beb+KsOPTtnKlIQK/ndsNGTo4oy5T7zLH1/MOHP
	 18OQbOkyGZnA9TRKP4leZHnz3/Rcbjxg/frw5haDJkQ72LKIvW3jOIeBUZcFpJEal+
	 asNFLle4+cj0OkrODYLWzUbvXU+u8Q9owSNRVhOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 578/744] um: vector: fix bpfflash parameter evaluation
Date: Thu,  6 Jun 2024 16:04:10 +0200
Message-ID: <20240606131750.997827280@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 584ed2f76ff5fe360d87a04d17b6520c7999e06b ]

With W=1 the build complains about a pointer compared to
zero, clearly the result should've been compared.

Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Tiwei Bie <tiwei.btw@antgroup.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/vector_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb295767..94a4dfac6c236 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -141,7 +141,7 @@ static bool get_bpf_flash(struct arglist *def)
 
 	if (allow != NULL) {
 		if (kstrtoul(allow, 10, &result) == 0)
-			return (allow > 0);
+			return result > 0;
 	}
 	return false;
 }
-- 
2.43.0




