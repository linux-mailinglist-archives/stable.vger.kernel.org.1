Return-Path: <stable+bounces-174569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2A6B363BC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC1A1BC7424
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DD433A015;
	Tue, 26 Aug 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iGPiVN8n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBD231A55;
	Tue, 26 Aug 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214740; cv=none; b=aczSy5/TRACkM54Ne4gbhB1AFjHAEvPvXLLVrArTzRBvSvF7uksbf+J8ufsiCljQ3f18daRU4nKx+2Ed9a/MBxCLyHE7GbklGmZ/Oh3+eOyOqgcotAUOeCdBT7WRYEHxS9pd7WuSOHnu/tgr+v7hXXdKAhEZaT2tcmUatHgq8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214740; c=relaxed/simple;
	bh=FEVy77dV1/c8BvxAPd8kE7ae9zCY/j7MMXHvSLkwp8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXfYTWv0ymNm6KqgR7ritPGuKaHM34rO6WQnvbYd/BCevJu9kjLDIfyN4WVj4RRNp2C8vmrg92BOfJLfLh1YkCBe5LigE1HXEeaXiR1ZppqK8WAYsFjHCMvxiOVpRsFDA6LrBtrJBtUNh/VGjmig/lEgd48mRPETag0Vv77n5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iGPiVN8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31248C4CEF1;
	Tue, 26 Aug 2025 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214740;
	bh=FEVy77dV1/c8BvxAPd8kE7ae9zCY/j7MMXHvSLkwp8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGPiVN8nwRM9vWFbp0QX01zKGNtOo0vuAV6UB5SCwI2RHN17KCX6tv1QUP3pr7JRn
	 bin8hv2UNTysqlervihaD3biMxGOo7vhyGjPVjIdx2AY0JTYOLctX3kNB3ot+M68fk
	 KOwVfDnI27RHHo6K/Ilk5/u9t+iFZnsC0++I4FDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shankari Anand <shankari.ak0208@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nicolas Schier <n.schier@avm.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 220/482] kconfig: nconf: Ensure null termination where strncpy is used
Date: Tue, 26 Aug 2025 13:07:53 +0200
Message-ID: <20250826110936.209801823@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shankari Anand <shankari.ak0208@gmail.com>

[ Upstream commit f468992936894c9ce3b1659cf38c230d33b77a16 ]

strncpy() does not guarantee null-termination if the source string is
longer than the destination buffer.

Ensure the buffer is explicitly null-terminated to prevent potential
string overflows or undefined behavior.

Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Nicolas Schier <n.schier@avm.de>
Acked-by: Nicolas Schier <n.schier@avm.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/nconf.c     | 2 ++
 scripts/kconfig/nconf.gui.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 3ba8b1af390f..16a2db59432a 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -585,6 +585,8 @@ static void item_add_str(const char *fmt, ...)
 		tmp_str,
 		sizeof(k_menu_items[index].str));
 
+	k_menu_items[index].str[sizeof(k_menu_items[index].str) - 1] = '\0';
+
 	free_item(curses_menu_items[index]);
 	curses_menu_items[index] = new_item(
 			k_menu_items[index].str,
diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index 9aedf40f1dc0..da06ea2afe08 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -349,6 +349,7 @@ int dialog_inputbox(WINDOW *main_window,
 	x = (columns-win_cols)/2;
 
 	strncpy(result, init, *result_len);
+	result[*result_len - 1] = '\0';
 
 	/* create the windows */
 	win = newwin(win_lines, win_cols, y, x);
-- 
2.39.5




