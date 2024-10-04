Return-Path: <stable+bounces-80944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226C6990D11
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF20D282444
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321AC2038D7;
	Fri,  4 Oct 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNmsi6xI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF47B2038BA;
	Fri,  4 Oct 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066336; cv=none; b=KmIlQsYxQTNeH0T52wEMcSH1yRXBJ4LpH1nQsp7jYWaN48U+hjQH/k9X4HqZAI/JZuHzMUun6gNKV9HyKQe1ct028ABQ1R3PhNmr2pJCYmHrn1idPF1dJ+4r6+0BO7zATq/1LM+yfspVB2PBFKlNlKc8uTv9ZspYNvdZM+igOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066336; c=relaxed/simple;
	bh=I1B3Eho7//Xn1xA82Jy691ZQ6rI68mS5fLecHIiaD4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQpwqjv3NIQZj9sqhmV42W7yLF3KKXofOcgPrN+Ii873drZAK3aKaSZIFdRPqMO44P1LsUtkwRm8cp4iMNdWd32s9h1jQYpUJbADRDSAUdwo/DQr2rb63tG8ZGbE83KtpMV0ruU2wLTheuARWZ3y/z5pGqh8r+ktxaGAOIaKcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNmsi6xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD2DC4CED0;
	Fri,  4 Oct 2024 18:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066335;
	bh=I1B3Eho7//Xn1xA82Jy691ZQ6rI68mS5fLecHIiaD4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNmsi6xIbX3Crm8Ah+I706qc7NIOQZ5FssuEg/PrnxiB6SwFf8Upjq63vaEuuyHTP
	 OGUp6mklrETs+bYC8upwb0exWfw91Rs4qnQ++M21NJt0MIvUpu42rjQzT2DAHmX+sX
	 BYyvxIorBg+DpKqHsxed37awX+f1jk5buzssV2VE9P+FkPCzULxovB1cBaLxQ18pZ1
	 eK+ySTjOuYTlWggD5lFJ6tFo6+P8jNE+sGpIaz0o2LNjSQkxS7hTFs3DQRzN4LJUxH
	 FyKvhRfv4Vjl9JMdodjztcGAzPdxQoGqbjs0Mt72ClxF3zB5o+d+UlYroPUI72ZjlW
	 cNHCR2vcEpZpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 18/58] ktest.pl: Avoid false positives with grub2 skip regex
Date: Fri,  4 Oct 2024 14:23:51 -0400
Message-ID: <20241004182503.3672477-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 24451f8f42910..045090085ac5b 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2043,7 +2043,7 @@ sub get_grub_index {
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


