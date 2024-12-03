Return-Path: <stable+bounces-98121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C509E273C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A3F161EC9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316E01E25E3;
	Tue,  3 Dec 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndSANgbH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E51F76D1;
	Tue,  3 Dec 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242861; cv=none; b=Th7keMLMvEYK5mCB9O264RqN9B4RUijRyAoocxkAoy+tesRFI/272GpoIEZhaB8L+JgJ3tD1+yupInX06WXTgl1vIia3Y3HzTx/Rz3WVcq78hW86R9YXTE/ORpHfDIkqO8qQnuH/02x/XVV4C+azGYxguf0YCUuADDXIusV3DR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242861; c=relaxed/simple;
	bh=JlKOuN4ycyhHiyePAuwecv5nx1ae5bHMhg/5Atl0ePE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLXnowz/h9y6XII4i97sSKBWGRRJuRaZwHWhNgaTqfmJCUibk22ymWAVj0HmbfWNy72J1/SHG0iCxXVjyhp9NAzgksgG78X43ST8Gg9x/nKeqkxbT+buIgJoXwJaS0g85V25SfLmgy1PgzPoSOvILlcPDlhSH4GSj7TNGhyl49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndSANgbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5010EC4CECF;
	Tue,  3 Dec 2024 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242860;
	bh=JlKOuN4ycyhHiyePAuwecv5nx1ae5bHMhg/5Atl0ePE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndSANgbHZsY1GYVPr1C+5thQRvMBS9LsEBV1fkPxtzp3IhyNj/5aOj9efNVwfkahD
	 HcMB6dq3h970c9sqUUz4Mc0fEGbcclVWjPyT6sNht/vIxz4slmCoztBLsymjLxxKmZ
	 Cii5zyG01Hbu1SBc3VKP/VM6ZW2yFZt95z+JLjZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 824/826] tools/power turbostat: Fix childs argument forwarding
Date: Tue,  3 Dec 2024 15:49:11 +0100
Message-ID: <20241203144815.895251448@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

[ Upstream commit 1da0daf746342dfdc114e4dc8fbf3ece28666d4f ]

Add '+' to optstring when early scanning for --no-msr and --no-perf.
It causes option processing to stop as soon as a nonoption argument is
encountered, effectively skipping child's arguments.

Fixes: 3e4048466c39 ("tools/power turbostat: Add --no-msr option")
Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index aa9200319d0ea..a5ebee8b23bbe 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9784,7 +9784,7 @@ void cmdline(int argc, char **argv)
 	 * Parse some options early, because they may make other options invalid,
 	 * like adding the MSR counter with --add and at the same time using --no-msr.
 	 */
-	while ((opt = getopt_long_only(argc, argv, "MPn:", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "+MPn:", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'M':
 			no_msr = 1;
-- 
2.43.0




