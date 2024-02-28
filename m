Return-Path: <stable+bounces-25405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2696186B622
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFD71F28093
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143E315B973;
	Wed, 28 Feb 2024 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7uwYGsV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC31332BC;
	Wed, 28 Feb 2024 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141709; cv=none; b=FFqKdJHxh9urRWxlLWjoVQ1qJPxEfNW0ogVj5oF/qQZ+yjX+Tx+vRAozZWzI9tm63/IcJl6IbLJsb1wxyGjdy6d/Xnc0uyeqVWJgZm6qmwfRswKJHPALlo0dqZPkswcLO0JkzmLbeBmb5DJEuLlxrLCqxAq8jJFSqcoaLHexD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141709; c=relaxed/simple;
	bh=1F27ypnXTmzE0WflGRGQsd62NQJSZMuYpWg3InFU+U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDhFXQpZfM/rr8sxMjukvdmQdoPKRllUySheyO5NOG1RM6BoNgV/oMJlt2skE727O68AHzIzbiD8aNBZ41O7XnX7jd2rzs2p7iNoPVSGM3p21d5YNjhMlBvmOdpbQzahGyIFXQUGFW6cZA9bHew8StwbP0KrvWk03BVbfBpDbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7uwYGsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DD0C433F1;
	Wed, 28 Feb 2024 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709141709;
	bh=1F27ypnXTmzE0WflGRGQsd62NQJSZMuYpWg3InFU+U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7uwYGsVubUcXzkSahuEjwycsCkthxJBeH5aDjWq3cDtLf2b4BKDb7jfO5HEY3EUs
	 66YYMHgaeYkX3ZvQ0fTDqxNdfVRqnmADwflhi32ihL/nec5b/dGEPMmsp+TASOyFuh
	 u/4mKpmW5Yd5HczeIl7zsNhQpwOOLcUVY6347xRHMxon0wq1j8vLmoV7TAvNeHvnfF
	 OXWunZNO9Tn51BbHyjzgx4gsTie+E9RB7eB3eFark7GEOXY2vdkVGVwtT17iDJdjdX
	 NoUnj6ZGM54M4ZllNsLy6ygKDNr4Ms4XN/k1T/52ED7vLXI+R+zC5e9Q0NIjMaYzEY
	 QMmHPjaLbJvEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: add missing kconfig for NF Filter
Date: Wed, 28 Feb 2024 18:34:36 +0100
Message-ID: <20240228173435.258891-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021925-lyricism-unshackle-b3ca@gregkh>
References: <2024021925-lyricism-unshackle-b3ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=matttbe@kernel.org; h=from:subject; bh=1F27ypnXTmzE0WflGRGQsd62NQJSZMuYpWg3InFU+U8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl326s99aMPGbzSOVWKGge+BIdE16mwO073oRoS xKrRwC1RUeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd9urAAKCRD2t4JPQmmg c6D3D/9QlLIJ+Tb8de0iPLoe3EgITtoXdeM6Kp++dJgKNvKJqFhH+M++8Vh4yLMHSUMMv5L0QSk aoG8jdJrorarTvACD/P47mKYgZ6fuImjHXVzU06EAIGgvagU4W3dsWeFiVQywrhKSPsCw7niL+X mxG9F+ovwmeC8mbEngV1F4+X0VKQ8vuEER0yh4Gm/gLlOlVLL+xjVAKj4GN++4njVp85iuqfGUK NJG8PnVUK1AOpUM+1KCtzcRuZieehTdfPPySXEvuOpOSBfWiaSzIVA/yw6KX/ozjLDdMBnYrsB0 ZYy1tO22W08u3wFVUN1dlMKeFZwSTcMCEqSjAkDL82wJTcoAeEfJNYmL7jcqK13/Uqu+QFAqhWb 0krx710rN/en7y+CRepw1QimcVI4zyClJVVGg44BVfHPtL6m4HyQuOairp/i5wQ4+diqjmiuOcw RkvAwWhXQP09BJtEMec/YYV4wXjsTZXtZqfjuLI5nPz6Cr28W9KslJuRs/6rVjcpQt6YU0qmk94 0e7gFOu71/unlnmwzNNmc7DwGa69aTBBGIDTaSs7G1+pDYmiPONk9efsovCgQe503Rqdmsu7eX7 kMds4vHGDzelyrox8ytBf8OWSjiMVVAEhgP38mamsQMwr9okML37sqgLwzsz9mdu97Luwsam1iU RFOmi25KUZgr1xw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table.

It is then required to have IP_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 3645c844902bd4e173d6704fc2a37e8746904d67)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - some conflicts because new kconfig have been added later. We only
   need the added one: CONFIG_IP_NF_FILTER
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 3f9e540fee570..15914a078e630 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -17,3 +17,4 @@ CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_MATCH_BPF=m
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NF_TABLES_IPV6=y
+CONFIG_IP_NF_FILTER=m
-- 
2.43.0


