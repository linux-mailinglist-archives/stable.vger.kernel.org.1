Return-Path: <stable+bounces-156418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A95AE4F84
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BC87ACB06
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BAC18E377;
	Mon, 23 Jun 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sqDLhAfg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD67482;
	Mon, 23 Jun 2025 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713366; cv=none; b=W2mnYZSz4ExJT1QgRjl+Tpv0EI3lq26eoqSzeySFS+tGjn9mLJ5Hso5MmbqkxFoAVg3xBJK/D9N6Dt93fjTO6Er8loenKeJJPw44EQr6uZ3K7QiL+tnJ4luAWTTMzN2IRgsIi/qSXwNKuwQqh+MBvGRWw+iE5PJ4YaFsb2MmDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713366; c=relaxed/simple;
	bh=uXiiwzssqjyGYsb0jtiDVGNvaiy0s/MuuyA/CE4rLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j//KrRf4ugCmxI7x9jRtdJ+S4Yeu+9H9zx/N0HpKavQQs0ZmuqE0whbudm++d7RzglFhTptFabF40vJvBht6S4MTCUK9lcPNbdJ9+s5PMmHUVjGDI7Y+NYW2JCkSSx1IT5YhJQIMa4B2jGp4W8yxFI/OFEL7KfAUsxdyCKRbSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sqDLhAfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71165C4CEEA;
	Mon, 23 Jun 2025 21:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713365;
	bh=uXiiwzssqjyGYsb0jtiDVGNvaiy0s/MuuyA/CE4rLec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqDLhAfg9MY4jE1hUeGt6bR6ZdFGFbvx3cfSpaIdbzjzJU9Q2mu5gadNiZm0uZZZE
	 kJxG1t4pDEkGbgP89iGOvHEhMiOm31pm2pebjfLmg7334r3/u6tAvqsJOaHqQrOIFI
	 2E/2gfBK0qEvxfWzb2C8f75osPOzvyX86KOLueEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 080/508] libbpf: Use proper errno value in nlattr
Date: Mon, 23 Jun 2025 15:02:05 +0200
Message-ID: <20250623130647.205862035@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Protopopov <a.s.protopopov@gmail.com>

[ Upstream commit fd5fd538a1f4b34cee6823ba0ddda2f7a55aca96 ]

Return value of the validate_nla() function can be propagated all the
way up to users of libbpf API. In case of error this libbpf version
of validate_nla returns -1 which will be seen as -EPERM from user's
point of view. Instead, return a more reasonable -EINVAL.

Fixes: bbf48c18ee0c ("libbpf: add error reporting in XDP")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250510182011.2246631-1-a.s.protopopov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/nlattr.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
index 975e265eab3bf..06663f9ea581f 100644
--- a/tools/lib/bpf/nlattr.c
+++ b/tools/lib/bpf/nlattr.c
@@ -63,16 +63,16 @@ static int validate_nla(struct nlattr *nla, int maxtype,
 		minlen = nla_attr_minlen[pt->type];
 
 	if (libbpf_nla_len(nla) < minlen)
-		return -1;
+		return -EINVAL;
 
 	if (pt->maxlen && libbpf_nla_len(nla) > pt->maxlen)
-		return -1;
+		return -EINVAL;
 
 	if (pt->type == LIBBPF_NLA_STRING) {
 		char *data = libbpf_nla_data(nla);
 
 		if (data[libbpf_nla_len(nla) - 1] != '\0')
-			return -1;
+			return -EINVAL;
 	}
 
 	return 0;
@@ -118,19 +118,18 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype, struct nlattr *head,
 		if (policy) {
 			err = validate_nla(nla, maxtype, policy);
 			if (err < 0)
-				goto errout;
+				return err;
 		}
 
-		if (tb[type])
+		if (tb[type]) {
 			pr_warn("Attribute of type %#x found multiple times in message, "
 				"previous attribute is being ignored.\n", type);
+		}
 
 		tb[type] = nla;
 	}
 
-	err = 0;
-errout:
-	return err;
+	return 0;
 }
 
 /**
-- 
2.39.5




