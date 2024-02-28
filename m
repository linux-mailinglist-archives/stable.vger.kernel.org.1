Return-Path: <stable+bounces-25406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B077386B625
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA40D1C22012
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BC83FBB0;
	Wed, 28 Feb 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgLtCrek"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3F12BF1D;
	Wed, 28 Feb 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141744; cv=none; b=UBKslh3/eQACPe//xeDYLtEaTyzGQsovLcSZRgGS4Vg9LFCOhjJWefDe1VOp0RI8LTvaRNZ1rKIKBvomPKpNgfs5wTqa4arH2PMBa08Rpp2cxYmZbhgM1NCIcsDlkPhO33cPiyz16JL3w9b20tUE36TKzFXarpY67YRkvWWIfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141744; c=relaxed/simple;
	bh=UZeKt2PHDcLRd1bcd2FAL8+xJj4p+V8T6ZeizbzRooQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAi3MsMgqIbabbHWr2kX4+vVc4k305Fwwft3eM5ieGf17EAxI0Iw80A47X8VAlybLc3LBpxw6SINebM1CJg1XReHlF3v5eu3eCWcCf6xvbS2TNDpa+NnRunzepfZCg7rg8qmNpNEkZCuFR7B1NQKfXqGTos9pu71e4C31MyUWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgLtCrek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0CDC433F1;
	Wed, 28 Feb 2024 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709141743;
	bh=UZeKt2PHDcLRd1bcd2FAL8+xJj4p+V8T6ZeizbzRooQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgLtCrekdMJkUhRrzLeOY4STByGDxlxs1JlE8W+S4Wf1ZIHoibW0YRwb8LTV6EtRP
	 Pjok6l0WG0h4iwW0EBlT2NsrPItuUqXmFVOr7MNih6UQNmnicQ3GfkFbaJifjpQccW
	 IhykBYkPUixegeDhjERIuiaaMHqPzu4UtEsxrlt/Vzn0RQXSc9x5bxZTbkzGrwILAZ
	 5g4wMqjEoTLAiK/aSVOEXD7OHLiwfkY+yKn2D0ZUYEUb5ydKCsEcg79JOsRObyaRrB
	 uL5pl1A9zQbSRZPUu/pKqoTt3pnlUp7Y3wNXWZ9hWTKHN4AJHNXVMetcedA7jWwEJT
	 QzG6vfSyj9e4w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: add missing kconfig for NF Filter in v6
Date: Wed, 28 Feb 2024 18:35:23 +0100
Message-ID: <20240228173522.259824-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021943-wriggle-repair-49dd@gregkh>
References: <2024021943-wriggle-repair-49dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=matttbe@kernel.org; h=from:subject; bh=UZeKt2PHDcLRd1bcd2FAL8+xJj4p+V8T6ZeizbzRooQ=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl327a9h2UMApy0eiTLR7y8DZG5JWeHVhkVn2zY jKUxi5L6AiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd9u2gAKCRD2t4JPQmmg c01IEACee83rqbljaZytyC/k8NeZ+jCpNX+FCD9GSk40xE8zGY4HPf9KhH7ey+ExW7f9SPygXBi NVcYJJVLp1Ermw16kq7BzhjculQhmYn+xcRjsUkAStgRyqvSuA5Wbr8KfpYGzACl2Sn3ipBS1HU u0wqWN2dLMflYfv5CpICkzOVcEIbSuSXM5thJp44Jdk6dxiZW27CeyXLxJFO/5HlEdWU5aLbO3w yUPmPF3SJNok/7bc1YCbIU5/Q+MzPPYpQ1hD43jDtFsFONSGiqORFeHFA3YALxArjUEfxAl6Kgf VGoLhUTziOjKKwdxGb6fKOF56xZNVDcTCIgLamyu9g6LOZVUoO+MvT7FTRuxuehpu9L+CjwZ8cW SeSGSI893XH388P4gpTFQrdgCs7phZrx+81Rb3alE5aJh5D9zsJVEBvHZSLdNbkYXAGCGnGkDZK 32Xh/LslUhNGB9K1seoUTxsPUOgTtwqVYARR49+EFSwNaO8RZJCwnjClvc73eYPg43tsFJsDRFM Hnup/uosRedeewh5TG2Pa1ciY1btVoUkijumtUSDnnaAlbsZcirXSBg3SXTkTA8tGI29952bi+S YI8QkIYVBcysN8B4xcfIJeI6/P/tx8OpcqwJdwXQlFCicx+m9uTU25jx3dxaZ4VL2KiQgYxsodd HTIzUVbMFUUWnJw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table for IPv6.

It is then required to have IP6_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-3-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 8c86fad2cecdc6bf7283ecd298b4d0555bd8b8aa)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - some conflicts because new kconfig have been added later. We only
   need the added one: CONFIG_IP6_NF_FILTER
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 15914a078e630..2f38db59911e9 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -18,3 +18,4 @@ CONFIG_NETFILTER_XT_MATCH_BPF=m
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_IP_NF_FILTER=m
+CONFIG_IP6_NF_FILTER=m
-- 
2.43.0


