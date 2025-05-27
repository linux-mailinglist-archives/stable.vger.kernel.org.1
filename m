Return-Path: <stable+bounces-147764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A7AC5912
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB527AE3D0
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5327FD64;
	Tue, 27 May 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HtW9xCqF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459327D784;
	Tue, 27 May 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368356; cv=none; b=TdL+5HdIKrMaMjAUGBMbFA990j5Yp9pteqmktsMg+eeAq5thGNSn72kFFNkZZbdDIOBitifmsppFfXr5zhgBIFCxFDNQJiMclyOG7rWTezr6g5fsEDJGCD76/Va726NlHtFP1/pBAabm73GQ8A0mmvrgQDlAricD8orVYAq+nMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368356; c=relaxed/simple;
	bh=bbjWelZWF8Lo/HrdQ+Idv7YfPWC3iJ77o9ewv8hU5ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wy7AFuhEhd4cekNVS/zxyop62DkwrZFTrJnpB2aUYPLe4erTMX8gfrS029xDKBvvnNnZ+/cQLc/ArAO/KJvKaPno5K3ZwyuibBlnylj0vh1RCVHMnZ+ova+pN4/evuRwyUO/gvMMJaTjMC8FGrqgc/6xdXsW2fFf9jsDv1TmQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HtW9xCqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A1BC4CEE9;
	Tue, 27 May 2025 17:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368356;
	bh=bbjWelZWF8Lo/HrdQ+Idv7YfPWC3iJ77o9ewv8hU5ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtW9xCqF2MTp020Amx6vy2YL3my+r2CTBT8HWchK6kgQaIdwhwg40WXNCo1jxrM/h
	 ad2luWVRNP41chH1O/Nv4hcvXnyGniOqxy5pGcENG7y/+ORiX2RlFCSdxV1wY4W9f5
	 gFeeBleAokrJ7RUFhdVd9oxn+F53eh8bBOvi2qKs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Wei <dw@davidwei.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 674/783] tools: ynl-gen: validate 0 len strings from kernel
Date: Tue, 27 May 2025 18:27:51 +0200
Message-ID: <20250527162540.575564249@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Wei <dw@davidwei.uk>

[ Upstream commit 4720f9707c783f642332dee3d56dccaefa850e42 ]

Strings from the kernel are guaranteed to be null terminated and
ynl_attr_validate() checks for this. But it doesn't check if the string
has a len of 0, which would cause problems when trying to access
data[len - 1]. Fix this by checking that len is positive.

Signed-off-by: David Wei <dw@davidwei.uk>
Link: https://patch.msgid.link/20250503043050.861238-1-dw@davidwei.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/net/ynl/lib/ynl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index ce32cb35007d6..c4da34048ef85 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -364,7 +364,7 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
 		     "Invalid attribute (binary %s)", policy->name);
 		return -1;
 	case YNL_PT_NUL_STR:
-		if ((!policy->len || len <= policy->len) && !data[len - 1])
+		if (len && (!policy->len || len <= policy->len) && !data[len - 1])
 			break;
 		yerr(yarg->ys, YNL_ERROR_ATTR_INVALID,
 		     "Invalid attribute (string %s)", policy->name);
-- 
2.39.5




