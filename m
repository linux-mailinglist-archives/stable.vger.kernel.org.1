Return-Path: <stable+bounces-80997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D47990E2F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BBEB2C546
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F31C1D8A00;
	Fri,  4 Oct 2024 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmnfHCRU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6E20FA7C;
	Fri,  4 Oct 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066461; cv=none; b=A6lRkmY9zEpp4KgpS5cQkzyv8tXQIPNgXFDi6R58BXsf1WyogVchRK/MsGm1dxJq4lyfXxJkC+qEptiq7ttB8P/fOYY6CDRIP18XRf0q7qJNWWFU6CvlTkTUNHPu2IC75XAXHVR3v3Efb9rlG44RSNFSUtr1jxQ4BB0Ka7qT4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066461; c=relaxed/simple;
	bh=S1cH/tUhi9S86Jke06n4nZxyL1wuLzEaKDUuNPUUZfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkcXcP4u1VOBBtI1oFJqqtNK7aKX0JTD9FOPAWdWOBt15FE3tvJwRMWDvplN6J4Hvr5txybHlj3A7CXJIUb3HSi/oMNziDsfyXBAF8hCx0BmBRWOD0vb+iF6OBUPFnVNr5AJQrfntOJua8J71eeyhsGyooNiXukxPSyg8nVaTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmnfHCRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC329C4CED0;
	Fri,  4 Oct 2024 18:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066461;
	bh=S1cH/tUhi9S86Jke06n4nZxyL1wuLzEaKDUuNPUUZfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmnfHCRUVNfRfrHUHpE76gnFqssiTM16qKHueMAlI64mxhgagsfXwWrFwZqQOAQOm
	 KetbAdvDT5oY6pXrWkLll5oE9cdpmeTq/uh4rgS3Vef8n4ZwSkLuLxcMXkyJ9q418z
	 t7pVh7LlGdv7uy67Xsa5FuYd/+KVjzqoX7GRkd/brJIOtGh+ZfknmqT1tdlS+5YB45
	 BaQTb7p82o5cfcRBg6gTmWoiqQ1uOxneQuJ20g1u+uesnH0PciGWnjmiuF0qKrBBOo
	 88mlvIBMHe08Do1ctTHyfmTn4D3h+vd4cFVYtmF1l248smYE9JeUrPEmQyUjy52aBS
	 c73lOwCTJW/uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 13/42] ktest.pl: Avoid false positives with grub2 skip regex
Date: Fri,  4 Oct 2024 14:26:24 -0400
Message-ID: <20241004182718.3673735-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index 449e45bd69665..99e17a0a13649 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2036,7 +2036,7 @@ sub get_grub_index {
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


