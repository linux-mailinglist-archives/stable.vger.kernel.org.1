Return-Path: <stable+bounces-63947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C23941B65
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AEC1C2296A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67180189907;
	Tue, 30 Jul 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LYBp7+Pv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0891A6195;
	Tue, 30 Jul 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358468; cv=none; b=DCtqHxcpZk+anrkMZ0bu/rVhKxtVFbCP+FZIsJgOduZkDQ3wE4cjiZ6JQGW6MCEu1gPo9lvlQcqhlWqbwZvrlNnNoui/MkyfrC+LbeP/0faR9M6r5aD+goioqbey4vsylWD89y3xN5bLjmx1a4I8wlHLvn7BQeXfrK5NB6vr2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358468; c=relaxed/simple;
	bh=8nS4yOd/GEyt4TsYwRzHnyGWqqrTrrLKaFI7+fzYKXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVKkLCdjLQsnrY2Y908LFu9LD6D2y9PR4ml3ajeGmzAST6p5WcsS1nAYLVvlv3Z4EdZskdWJlILB0JPWBHu+QqtwKM0DbE05A4S/9+acfZd1lFhlKUt0px5A59jzFlF8Ns4/fsM+1yuiPhN5XEBZ1A61aaUP8QZv5Rk8/mHChQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LYBp7+Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE36C32782;
	Tue, 30 Jul 2024 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358467;
	bh=8nS4yOd/GEyt4TsYwRzHnyGWqqrTrrLKaFI7+fzYKXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYBp7+PvAl7KAhymVfFm2/M/9YmEaj877Z3J0xPbtPBOUnXcAAWwQ5Rq7igKzGaOu
	 ulVvS6lI8SZBOw0xvZDeHj7VFrSUKl+TOthj4ANNskxY6SeJsJrfGMcgXqbj9jAmon
	 qxvf/ZnAGW0/3i6fu2b0ym5chONtL5sOyOaIOsZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 393/440] kdb: address -Wformat-security warnings
Date: Tue, 30 Jul 2024 17:50:26 +0200
Message-ID: <20240730151631.155264233@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 70867efacf4370b6c7cdfc7a5b11300e9ef7de64 ]

When -Wformat-security is not disabled, using a string pointer
as a format causes a warning:

kernel/debug/kdb/kdb_io.c: In function 'kdb_read':
kernel/debug/kdb/kdb_io.c:365:36: error: format not a string literal and no format arguments [-Werror=format-security]
  365 |                         kdb_printf(kdb_prompt_str);
      |                                    ^~~~~~~~~~~~~~
kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
kernel/debug/kdb/kdb_io.c:456:20: error: format not a string literal and no format arguments [-Werror=format-security]
  456 |         kdb_printf(kdb_prompt_str);
      |                    ^~~~~~~~~~~~~~

Use an explcit "%s" format instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20240528121154.3662553-1-arnd@kernel.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/kdb/kdb_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index b1f79d5a5a60e..fbbe198b056d4 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -357,7 +357,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			if (i >= dtab_count)
 				kdb_printf("...");
 			kdb_printf("\n");
-			kdb_printf(kdb_prompt_str);
+			kdb_printf("%s",  kdb_prompt_str);
 			kdb_printf("%s", buffer);
 			if (cp != lastchar)
 				kdb_position_cursor(kdb_prompt_str, buffer, cp);
@@ -449,7 +449,7 @@ char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
 {
 	if (prompt && kdb_prompt_str != prompt)
 		strscpy(kdb_prompt_str, prompt, CMD_BUFLEN);
-	kdb_printf(kdb_prompt_str);
+	kdb_printf("%s", kdb_prompt_str);
 	kdb_nextline = 1;	/* Prompt and input resets line number */
 	return kdb_read(buffer, bufsize);
 }
-- 
2.43.0




