Return-Path: <stable+bounces-76506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD8597A57B
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68C42849B5
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA315820F;
	Mon, 16 Sep 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc/R/uSH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356C2B9AA;
	Mon, 16 Sep 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501811; cv=none; b=dwDI3yi06ojs/XSaj8GVIh4nUV8zdgmsRQeH1zVYN0Zwj/dDbTagdbs6ln+hVIM6u+Zq7o3El9oBpvVR2geRg/vVHVolGbzufyVGnW2HEAIq6pf0lMaUy8jlYK903IW9J5t/FznYfgSEXb5dEhK4XfSd91UG9sBjxAtVc/fdPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501811; c=relaxed/simple;
	bh=BiTNLTz7WyfL7CcGIQ/jDtxOJcBfVarS3KkNOxAjdOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIDtvagvokp8y+tjexcGWE+280YYfh13MiHC6HuUAvRC6ba8WIddIkeJiAlCIImvrWzgV66SWAfxHQHXmj+IW2J0a0KViDSKcnfs4Cc+y15B/rtyaE5QEoAgTsslWj3XIwqs42GUQke4pjsl+Bmb0CAgrdbdhONiLtTmOrVNlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc/R/uSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29248C4CEC4;
	Mon, 16 Sep 2024 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726501810;
	bh=BiTNLTz7WyfL7CcGIQ/jDtxOJcBfVarS3KkNOxAjdOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nc/R/uSH13lcMV7TKObSVNthI12F7OdA0qD9IC15scSYTZXvqgQGVbZE2pcJKp/0A
	 fEaGEYlXbFjq+bGzMBprZr5saQHMGVcPH6L/PaDT8ARngPOJnXl0qlZm3VMnNrRhlo
	 QMXCuwBUdGdL39h/Jng15FI+wAL5ST7BMFh1ZfcQF5hzSHwfdW0okICdVTdt8boIB/
	 bL3f2HOQFw1oqbqtigXa0XpIPSF29dwFlRPI2Q0D4QLLcbG22X34dUQWytGLXJ4G6i
	 D2stUuSDRWCAlA8SA5XU9Oulvi6Ka2SYqQc8TOtw+RZTVGOpCs7zDqhU03lQUxXcC+
	 AywnbLFnSl3BA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: restrict fullmesh endp on 1st sf
Date: Mon, 16 Sep 2024 17:48:37 +0200
Message-ID: <20240916154836.565586-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024091343-excusably-laborer-3bef@gregkh>
References: <2024091343-excusably-laborer-3bef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2310; i=matttbe@kernel.org; h=from:subject; bh=BiTNLTz7WyfL7CcGIQ/jDtxOJcBfVarS3KkNOxAjdOY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm6FNU16CHitQ1XT2Hf0JOdP7wyNz60ArwxxZDj iBtpvk0FICJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuhTVAAKCRD2t4JPQmmg c1PZD/4tH0/DBd6MTd0efvmTUuYJi61j3opd/+VCAy/X/iyZz27YdTcu3QKzc/l9IAiUeQJIjS3 C9QcytV6kgIyDwIQZo3pHLegb1do2mTeLgxIK9jGFcxQhJyYOaBHn/8z2SA2lMiLNKfl5PjJdWD l6DMn8+ay1UU6S2M5gG0RBie0zPKabBzJUaHh9ZtJJEaIQWpPOCKpW0Ojk/Ez5SXOxNXqdegcdX ArPtYIr4t+SpbT9DmWFLnDdrLWPrADyv5BmAMowcx8KYPLm8KjrtxYsiIGsr8ejsUL1FhH18AVS QL9TQxuqbuXmJYZdXRCWwPqZj3eWish58ToWjZh08JPN4vrFNQX/G9HRrecQEdgz4cWsQe+8bjv nE+/UQGzTloFqmSeT7dMD3mbC/nhAVTxWLEoNrD8WHY66wDWXDfu2s0tzzQL0FR3Lq0WRL/J/g9 Z48xdGZW/+gSzenszwOYt5B5qq5tzvRI+vvrGZa0mwPpacydUVyPLBjbazPdYJHzA7wh57LftMC vYvu8xa42oB0IdcQ+b/JvlVIi5ERY+5Pjv8qBor2yULE5vmcdxOFnf8YxJphxf2ukt+IeHa0jPW jHd5/NKt8/mVj3AMxIc/mX3a5rXn+b09Nvrz9BVm6QXAHMGlN9dYmhD1LtySAY+sxYDKW+y0+lJ hSkGuKcebvxYmug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 49ac6f05ace5bb0070c68a0193aa05d3c25d4c83 upstream.

A new endpoint using the IP of the initial subflow has been recently
added to increase the code coverage. But it breaks the test when using
old kernels not having commit 86e39e04482b ("mptcp: keep track of local
endpoint still available for each msk"), e.g. on v5.15.

Similar to commit d4c81bbb8600 ("selftests: mptcp: join: support local
endpoint being tracked or not"), it is possible to add the new endpoint
conditionally, by checking if "mptcp_pm_subflow_check_next" is present
in kallsyms: this is not directly linked to the commit introducing this
symbol but for the parent one which is linked anyway. So we can know in
advance what will be the expected behaviour, and add the new endpoint
only when it makes sense to do so.

Fixes: 4878f9f8421f ("selftests: mptcp: join: validate fullmesh endp on 1st sf")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240910-net-selftests-mptcp-fix-install-v1-1-8f124aa9156d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because the 'run_tests' helper has been
  modified in multiple commits that are not in this version, e.g. commit
  e571fb09c893 ("selftests: mptcp: add speed env var"). The conflict was
  in the context, the new lines can still be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 446b8daa23e0..ed7c0193ffc3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3048,7 +3048,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		fi
 		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
-- 
2.45.2


