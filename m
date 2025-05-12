Return-Path: <stable+bounces-143788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD68AB4181
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8092D7AF43A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22BC2980C8;
	Mon, 12 May 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEs/mpWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F5296FAA;
	Mon, 12 May 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073052; cv=none; b=V6J0l3UZvv7Hdr9gfXK7qfZC0/gbuoWh1MeNYOaWf8PFUA4UHR2//CkkHiCH0lu6zC7HrvpWZhbzwSFnTWJaokVKXtY4dXGWXORZim4arMct80kNx5iB7fRodLPdi2MyqCU4evWthsFM2/9MwEXiGH+f3hMEDHmhlD3EPRjE0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073052; c=relaxed/simple;
	bh=8d+MIh0ZJExvxWHnilQyk/lGhI/iKEiO0XS+vqKLqqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPbMDmRzOH4YewgxUZ5dYK09KDYhdd9k7ZFmBn3MKRau4fLfPQYCoiK18H6aNU9uEO6p2xJVLpvgWtKTFiIt3Cgvt6rEVs8A+tMeoAi1DT3GIpbrDHXajpjiYe4l+fEo1622OBHzKH7IzL+eNKo5grbsL/ie57Oh1JuohwLUiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEs/mpWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6734C4CEE9;
	Mon, 12 May 2025 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073052;
	bh=8d+MIh0ZJExvxWHnilQyk/lGhI/iKEiO0XS+vqKLqqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEs/mpWlGtLJPnWe1DbOkZk3hsqoOELMyYIyhVnPp8ZRP8pB5fN+cN/GUOtsAe9oU
	 LEo4oI8K7bJJeWZpX+nxSYh3k0Ruyp+klDd2FKAhfmcdR1weuhmBFeLK5LgGmR3Ytb
	 VnE6pNRKaRMn7voPTtEAdxwfgdUibl1jmJ0htWN9v+T/pgJ600B0Ac5SLnTHs06Qp9
	 /bPKaYAj0sCLtiYhb5pDok7geLm00/MwqurdmrNRx+tHdB1cKv4j0gUQBDsw/jRdaU
	 ZSgMx/1RZF/G6HrZAepm+k/ztkv4sKxapNb8GnylgephUr7Tl+rE9mfjyX+6pCfouj
	 0l1xR+Cm8OpHg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	colin.i.king@gmail.com,
	nicolas.dichtel@6wind.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 09/15] tools: ynl-gen: validate 0 len strings from kernel
Date: Mon, 12 May 2025 14:03:44 -0400
Message-Id: <20250512180352.437356-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180352.437356-1-sashal@kernel.org>
References: <20250512180352.437356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.6
Content-Transfer-Encoding: 8bit

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


