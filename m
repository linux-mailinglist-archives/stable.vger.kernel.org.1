Return-Path: <stable+bounces-80876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8D5990C23
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95481F24C85
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15321F400F;
	Fri,  4 Oct 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtjfFBSf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067B1F4006;
	Fri,  4 Oct 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066157; cv=none; b=oKn1B8gTfJEHoWnvC2AucMYr609bvrNSPGDh8FdDB9bkkPVFtM91svYGIKZq/Z2ZWpnzkdu6Nkynu8XxHlyN6sy3V8G2E6VwwdOlX4h/2YuXyfdyOgbtdTZZCJ9ZgTeG6eZ6cfqgjaMhorbq5YUat1qcrQkSycNI98/YhpTF+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066157; c=relaxed/simple;
	bh=PnutMTHxb768uHmtN1NClv5Q1qr9qkMm8OVdtRWtvFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqbPGY/ydFphF/SAOms9/BxYPSM9IKqVkvGrJVX212NHGjzORbYbYU4VrDpEFrfZ5OGGBTrQ68JYq4wIXnWSBDtBcZhvS4oC5iDd2lg9T3l84TkvFj/5eSjHihwZJTEaH2bTY1LxhTIOkcmHNm+HOg7oBBs+lJv+FpHj1exR72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtjfFBSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B83EC4CEC6;
	Fri,  4 Oct 2024 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066157;
	bh=PnutMTHxb768uHmtN1NClv5Q1qr9qkMm8OVdtRWtvFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CtjfFBSf9OhH5FJAwW9lMngFEuTrx5YFAiOGyReJVjDExJDsXgFQ5LDG7V1zNWnie
	 vFD4JvSjzIu5l+Zdn5uz+EkyBRYbSTRCj3ptaN2xZZpEmeL3LsLDFLWzO54PzeClaF
	 NWVLv9o5EKakg0NzYE1O2bqlSnA3Numcg+p557exXUZHCvQ733yhSyQLzttCVIC7HL
	 wyOCjI2p6Jk0ediBOlKYtgLxAglS8k5Wy4q/w8yn3+i2LDKxBhR/atKMzd2NaRkpnk
	 MkTGkdc7PoEzDW4QyRUjN1j5PffTQm7ayQLygBMb7mSd0XgETGgS0Qp9lVPhNQiTbt
	 TDvVBGuwwWbnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 20/70] ktest.pl: Avoid false positives with grub2 skip regex
Date: Fri,  4 Oct 2024 14:20:18 -0400
Message-ID: <20241004182200.3670903-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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


