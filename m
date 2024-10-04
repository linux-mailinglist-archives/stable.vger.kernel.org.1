Return-Path: <stable+bounces-81068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D61990E80
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A341C22B75
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7FE2265D3;
	Fri,  4 Oct 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYa7Wupe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06451DF968;
	Fri,  4 Oct 2024 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066624; cv=none; b=A2FoxCuGr6jQrOw0S2AQSVJhrixOftein9YtTFlAgitlPfcPku2dbDsMclWYPA8aF65A0wqjxieXTlzG1waeNvCxeFQtv1/EzW53Ea1CluDTdMM2lZzP2Loyp6IbDCKrqvJEiKRVXIu6b+JOBNp05HKRWIvFYPisgxEBjczrDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066624; c=relaxed/simple;
	bh=PNfzdLu6eazFjAV0VylfCgx1zt4LvimnpNXESOcO6O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1nS9vnHAJB/WkzrBnUhRzN4cjzd+igmQOH9dQChUHHT174VOlbdteL5+3IPWYZLmAF35UTOOOkes6Tb6JIp+N9x6xrqQ7u7pHIdDmMMxYR1xGdgobhIOffgX5JT3riKIeJJQOItM47uxap2l2E6ppqkSnKitdIpo/axi2zNa0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYa7Wupe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B43C4CECC;
	Fri,  4 Oct 2024 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066623;
	bh=PNfzdLu6eazFjAV0VylfCgx1zt4LvimnpNXESOcO6O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYa7WupeIHze7A88br5WZVsU5eNztjvhALnMQz3YzkC1xMZQPUoKaqoIjvw1wzjO+
	 5VuODdr2BdQG4Sp6TfatdB/DbsMch9UBPZMhO7xGjeCf/iqal1Lvepv9bp6dSP85Sa
	 OLM41ss2hewSBrk7cLJZusVKerArnUzr+t+DrzEqJUjuJbNd7hdq7SjyJTUhpDu1pb
	 tHPSWsp8LOIR7uPJEXEO8Qitw8zlzIU9GSRvTg0JMPz4nwgrL40/14mV//LxFbYs0n
	 4bgfT7i+r/j2EuwD3jS+na5I9AdlV7SZhrYu8tQuVCLxsBL0kpwb1enpUTvAbTxvx3
	 vGg0/ThEcl+hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 10/26] ktest.pl: Avoid false positives with grub2 skip regex
Date: Fri,  4 Oct 2024 14:29:36 -0400
Message-ID: <20241004183005.3675332-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index f72da30795dd6..f260b455b74d4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1985,7 +1985,7 @@ sub get_grub_index {
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


