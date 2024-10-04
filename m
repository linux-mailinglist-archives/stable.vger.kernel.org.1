Return-Path: <stable+bounces-81093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B057990EDA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C401F2360B
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21361E0DF1;
	Fri,  4 Oct 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBcuHUB6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF71E0DE9;
	Fri,  4 Oct 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066682; cv=none; b=gg679tj3rm4yFV4PQqfG93gP/eYxLPuti8ccM0+Eki91o4O1F50vvHn6kdfO1uUM+Xw1r5fIqIkniZu7hIMrmgIa2jLuiJDlh4QvTBoLAZZGzz9e/p0MjpPdkgRnkI0B64SmxtPjIz/M3HZ5tvjl7w/1HNqYf3zs8gmPnwq47/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066682; c=relaxed/simple;
	bh=Et/QtzBMD6b+dSzO1dRlGuwZ1D+exiJmgTfEy/ZuCiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl0X8GOyko+8BBRGMgutYPkdl0Lhonb4VgDmo7lPsD1Oa/vOPHj4fRbS+c66Au+JKDeIiNIDIAO2ZzNHXgq/L7jby+0I8n/BmXqXbANgPKkZtZjPMWFk/DzRgoZS2LJ2i10+HgaUODLBvv8aYcjw9TeTqVcS9egyxRsqe1c6Cg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBcuHUB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A64C4CED0;
	Fri,  4 Oct 2024 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066682;
	bh=Et/QtzBMD6b+dSzO1dRlGuwZ1D+exiJmgTfEy/ZuCiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBcuHUB6BYzmQcR+bxYw6+PEeOj4N8k8KwgjbhCxErHv2fRr5SjY8qccB2QJEk+Uh
	 hnyiL0M8cekIzK1wyN8n+9kLgJ6VjLuwAs20d9QzWKKEITtIVbkr4rOc7gePmcNCkZ
	 nllnQNeoYmnvjbdSSPjU9RADpKnbalYGYH/YYPs++hfOMBadnPdDz6H5/av4Apia9T
	 S2kRGss+bUfsdmruUJ60/QS7PoKs6X3EMokh/n5igtBGH2zbY2UUf+8HQG/gBR2zDo
	 TWZXlFVgre+VN+jHsueeyvXuqU7tbM46bm/b1DQEUNJv4gXVbPcGsQ16CSej9qCdMY
	 dE4ju46nRxhVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 09/21] ktest.pl: Avoid false positives with grub2 skip regex
Date: Fri,  4 Oct 2024 14:30:44 -0400
Message-ID: <20241004183105.3675901-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183105.3675901-1-sashal@kernel.org>
References: <20241004183105.3675901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index d36612c620981..e7adb429018b2 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1954,7 +1954,7 @@ sub get_grub_index {
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


