Return-Path: <stable+bounces-81113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC07990F17
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5A41F22943
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268423020E;
	Fri,  4 Oct 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCLH2G4v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7D230205;
	Fri,  4 Oct 2024 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066724; cv=none; b=DDvNOKAuPzgvV3ICK1DW4Jc8gj8rv9YHaIGdqGzXszTHWes1yh0sfRJkLT5iJn5LjofDRQuv3yXVvhKDEWZN56sRzhRryVoSIFCVbI3t4ZV1Hxt1olOMVeDuopm/Y3lzIEk0uEMxUEOa1cYG+PPsqvPxzHHoBmfRlokB0t7LP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066724; c=relaxed/simple;
	bh=zrLJysfcwiQ4mwzB55fzaMxerf+EPFQ6hpVd3oEX7o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9G9HZFOIO55UYy/jgpjPji8xlJWigfCohSIxR7SHCqIVeyjl0b8C9asLO5vTcuIOlgz1QCIrlWWpfu7QY0Ny/heVJku+hb886MXswkP3kesjmkcVjB/r+qyF+VcvSg8bN/Nkd6Oijl1Ujq5hMn/wLYR+snBkI4GoTdpn9JSPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCLH2G4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E31C4CECC;
	Fri,  4 Oct 2024 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066723;
	bh=zrLJysfcwiQ4mwzB55fzaMxerf+EPFQ6hpVd3oEX7o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCLH2G4vInyT/nSUVM15EzORIKcZUHE8ctoeQI8TxRbuoMoUdZyh9Muvwu/SZIb5S
	 ybfIkW0FUgYBgdUcDMO1jvBoCALlu9MBHbtyEm3hi5R1yYzSDqzscwWrwaj65+JZbf
	 zUkRkWPRPAhhDFkk1CnFVzacJ6Q9yi122IUlCpb+6aPyFet7HOUWX5xWEaZ3vjnFmF
	 Uh0HFZ6vT6/q1v1rS5kx9auyKgsuUclFoQXt5pibESrpHLlQoQzYsjLdOUa6j54fIY
	 8oZa+RFQ9pg6qq9/eq36gXT2vpUfUSKRxhMGhnJWmSUSkhF1BuyLKIDnJSGJNV9U+j
	 zvOv3/gpjSaQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 08/16] ktest.pl: Avoid false positives with grub2 skip regex
Date: Fri,  4 Oct 2024 14:31:35 -0400
Message-ID: <20241004183150.3676355-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183150.3676355-1-sashal@kernel.org>
References: <20241004183150.3676355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index a29d9e125b00b..fe73902a197c6 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1969,7 +1969,7 @@ sub get_grub_index {
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


