Return-Path: <stable+bounces-80801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06466990B2D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A801F22330
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F84B21F42C;
	Fri,  4 Oct 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTwdLzWE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30E21F424;
	Fri,  4 Oct 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065946; cv=none; b=BUmv2f3yHKauFb9aRLN1GifBML/8TdV0rhHRklLC5KgbLyHI9nYAuedjzMblMreihZDx3rXyWE4wtkGTppjzXG0Q/UcnO68MLQVc9Hvx0Eopo8Y2jt8hVJB9vSaqRBfvyR3YhoNZy3PD/Bnelsrwjy1BHlSY1gPPnzNASgP6HUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065946; c=relaxed/simple;
	bh=PnutMTHxb768uHmtN1NClv5Q1qr9qkMm8OVdtRWtvFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDJCPwzGgAx/L+QWCp9xLTPlLwIPB04rRe2rxaYMktYphAU4bUFB3YBcAIhwBAf181eZ5TXFPVMT0yIeeEu6RxspOLjR569CT+LvVrLdCO4Jt5TLZn41Zd9SfkyhpSeXiUmLS85K6zCn7jOYT4yde6TJeIZLIgvvnKQO4e8a/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTwdLzWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB2DC4CECC;
	Fri,  4 Oct 2024 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065945;
	bh=PnutMTHxb768uHmtN1NClv5Q1qr9qkMm8OVdtRWtvFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTwdLzWEQpSpYmehIAzAMVo5qf9XplC6su5XcSB4j78GyjV3L4iBod+a3aJk+dwyF
	 Yxbk55OBLn+InxqCrNeDkr/Xn6+0Zb4g2eqmcSTVDSyn1zT/ieXMo/jjoA3I1AJ3zn
	 XbfjthhVa1Rd85y8arZTUBH903mInq1/m22rAteeint/xLJSnmnC+gHWl/IVrBF0uD
	 XOQ2Ves2kpk1+lSegoAXeghsUvzN1mBOzfUz6kDmi/fsrWI0O/Jv7z2D5xwQFcMXZh
	 UO0SRb+BT4rq7bv9YtugUBpIWj9zcwhmbSq2e+Idh82Gz56aXAPRKSvNRba8JDeB7R
	 qASy+TVMGthaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 21/76] ktest.pl: Avoid false positives with grub2 skip regex
Date: Fri,  4 Oct 2024 14:16:38 -0400
Message-ID: <20241004181828.3669209-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Daniel Jordan <daniel.m.jordan@oracle.com>

[ Upstream commit 2351e8c65404aabc433300b6bf90c7a37e8bbc4d ]

Some distros have grub2 config files with the lines

    if [ x"${feature_menuentry_id}" = xy ]; then
      menuentry_id_option="--id"
    else
      menuentry_id_option=""
    fi

which match the skip regex defined for grub2 in get_grub_index():

    $skip = '^\s*menuentry';

These false positives cause the grub number to be higher than it
should be, and the wrong kernel can end up booting.

Grub documents the menuentry command with whitespace between it and the
title, so make the skip regex reflect this.

Link: https://lore.kernel.org/20240904175530.84175-1-daniel.m.jordan@oracle.com
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: John 'Warthog9' Hawley (Tenstorrent) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index eb31cd9c977bf..e24cd825e70a6 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2047,7 +2047,7 @@ sub get_grub_index {
     } elsif ($reboot_type eq "grub2") {
 	$command = "cat $grub_file";
 	$target = '^\s*menuentry.*' . $grub_menu_qt;
-	$skip = '^\s*menuentry';
+	$skip = '^\s*menuentry\s';
 	$submenu = '^\s*submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
 	$command = $grub_bls_get;
-- 
2.43.0


