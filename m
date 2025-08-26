Return-Path: <stable+bounces-175765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDEDB36A3A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB23E987B1A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8AA352077;
	Tue, 26 Aug 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rjv0pJto"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A25342CA7;
	Tue, 26 Aug 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217910; cv=none; b=RTq+szOKudvuXke+064lBMqUryxjcfPsqsWtDMcN5SoU6e+x3qN0uJ2gWjIyuM/r2Q9+pnegeSm81UdWz7ibpkWCRYN3YaAbKW0kY1hSKndpbGjpwlPK0CwLmzFBpke4ZGHrRMA3fYChyDB0n3kzbs7CYh18j3zkByVYbfgNKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217910; c=relaxed/simple;
	bh=zzDKZSsvsxDxhXGJ8gN1eZ/mSOXV3BWuHkfYj4Z+qcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3HP4DWz49YUK8RCeH5f5iM7/HBVlPdZbwbxYJ2pou9N90JBz+vI20qYKat2Rw4jmt5lXgzpYXJ0aT6XaIplaxsnVwSzbeqM2kY7ZQJgNkvDgvYI81pwiMfK+/Qe5kj8YVOcQM3MNeY1/6gMgc+Il+G2PcQual/MO745+M1i3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rjv0pJto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7E2C4CEF1;
	Tue, 26 Aug 2025 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217910;
	bh=zzDKZSsvsxDxhXGJ8gN1eZ/mSOXV3BWuHkfYj4Z+qcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjv0pJtoOo2LcjSFfRJVqelr+rKr4P6bNrHqq9Vu1DHnv30ivueBZqWxMWVZrUEBs
	 6VTV+zHdOI2DVn4Y7KyB+ir2z9FwKhm1SpabbneJqoq5j7mFYMFLXT1h/IaNW0mgn3
	 fy3R3M7+IS3JVhFiYEgo9+fyaD4KV86eOPNTyk2o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 321/523] kconfig: lxdialog: replace strcpy() with strncpy() in inputbox.c
Date: Tue, 26 Aug 2025 13:08:51 +0200
Message-ID: <20250826110932.383824363@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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




