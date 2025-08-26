Return-Path: <stable+bounces-174567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA5B363FF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFAD683566
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E43376A8;
	Tue, 26 Aug 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u8UQnak4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781D318143;
	Tue, 26 Aug 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214735; cv=none; b=Zvb6C2YxZ596Lx+ZJNoGIajgbhihZu/YmMMO6D9yPleyjUofBsjZHUiaPBEL35s57UyZNzMM45bSB+ME2hrTJViEUDdPHku+pIDcK7/QUacCj9xD/FKkzihHMhUjqhRS+MhIOLf6u7B0SV/NPLQ6rCu9QVMlHszVjvBR+0IWanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214735; c=relaxed/simple;
	bh=N6UTf2WMOxdGRtsKyUT1fBIt1wuj51YZD9YPKzbwFuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7ma/Lp/JRP4jbjDjcwL/0Lrv0XYkdp3QDjNECwifd/LFHLDsawO0q1yk+4rw5fpilQ1gDbq3kReQIba8Gwu93Z/otBC40zYLG3HP8tzIQ85MSBi+aJ7L85GVuparE91Ly4Uil8me8rWJWLf4ejs9ml018ieqU+8BHU5+acQsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u8UQnak4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A37C4CEF1;
	Tue, 26 Aug 2025 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214735;
	bh=N6UTf2WMOxdGRtsKyUT1fBIt1wuj51YZD9YPKzbwFuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8UQnak462JJoGXW8vVq+FgkxCuAkVS/qaKep6It6YeXoNRS/AOGYnpx8BkTIZhbL
	 1X5A49ZrMbpL62P/Nq78Hw7unJrsxFiEhWqm1zGpkvsMdAkv1MBBxXMVYgE2wPd725
	 m3EQ+yXoovSrbCwfgqCBrNL55D8+ngtPUwhte9bY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 218/482] kconfig: lxdialog: replace strcpy() with strncpy() in inputbox.c
Date: Tue, 26 Aug 2025 13:07:51 +0200
Message-ID: <20250826110936.161950479@linuxfoundation.org>
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

From: Suchit Karunakaran <suchitkarunakaran@gmail.com>

[ Upstream commit 5ac726653a1029a2eccba93bbe59e01fc9725828 ]

strcpy() performs no bounds checking and can lead to buffer overflows if
the input string exceeds the destination buffer size. This patch replaces
it with strncpy(), and null terminates the input string.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Reviewed-by: Nicolas Schier <nicolas.schier@linux.dev>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/lxdialog/inputbox.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 1dcfb288ee63..327b60cdb8da 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -39,8 +39,10 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
 
 	if (!init)
 		instr[0] = '\0';
-	else
-		strcpy(instr, init);
+	else {
+		strncpy(instr, init, sizeof(dialog_input_result) - 1);
+		instr[sizeof(dialog_input_result) - 1] = '\0';
+	}
 
 do_resize:
 	if (getmaxy(stdscr) <= (height - INPUTBOX_HEIGTH_MIN))
-- 
2.39.5




