Return-Path: <stable+bounces-206723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F16D0946D
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 450A6302169C
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2123359F95;
	Fri,  9 Jan 2026 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q6aaYo+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79475359FB4;
	Fri,  9 Jan 2026 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960016; cv=none; b=BMJ1YKCT8ACNcR+m+H8fowJ6WqUwM15m2vBy4iJjEHBmqeBSh3cdXIIx3NhoCHHiuzpdbrNCZz03Hjh71xfCc6nn3U9IWmJuauZ43y+MgYgy/E1EZRV0DS/CHmeb4f0M6J+tJO8nKQFwndooJcwuRU6KSLEXSzGyuB/ziUCWukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960016; c=relaxed/simple;
	bh=xLoaAZnKs2eLLsoAhia42RJFwOfcsjMzyz4HGCTxXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJSeOXvLcAD//XoUCBz+6563hYhKlUjFIiny5Ixw1yOv2rhJrgGcbGOPCjNevYJZOnGJlSTF3LBNmO07JBZTXUKjWbc/tZc4nFpj5RuF70/hhQMIll80UF4koE7F77ZalDey6kYEbO3CONKlPr87R1+mUZzr63mFhbjuilq2BmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q6aaYo+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF057C4CEF1;
	Fri,  9 Jan 2026 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767960016;
	bh=xLoaAZnKs2eLLsoAhia42RJFwOfcsjMzyz4HGCTxXjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6aaYo+eAx/Y999Lu9SLO3F3Ql0OZI1u09zB3FdCLY1VdLenG4NMLWmEYap2GV8Vt
	 EjDFYu3U6jVI0zgh0bAdmh+6/l/QbHilldsqXOEe0Hv32JnFpHo/le5UcFYpYtoqL4
	 T/w2btaSpxXyT1/WFRXWziVYodD9Xg4VovsWZcF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 256/737] pinctrl: single: Fix incorrect type for error return variable
Date: Fri,  9 Jan 2026 12:36:35 +0100
Message-ID: <20260109112143.622156484@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 61d1bb53547d42c6bdaec9da4496beb3a1a05264 ]

pcs_pinconf_get() and pcs_pinconf_set() declare ret as unsigned int,
but assign it the return values of pcs_get_function() that may return
negative error codes. This causes negative error codes to be
converted to large positive values.

Change ret from unsigned int to int in both functions.

Fixes: 9dddb4df90d1 ("pinctrl: single: support generic pinconf")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-single.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 5c6d5add6ecac..2ee0ee3b6ed14 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -489,7 +489,8 @@ static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
 	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
 	struct pcs_function *func;
 	enum pin_config_param param;
-	unsigned offset = 0, data = 0, i, j, ret;
+	unsigned offset = 0, data = 0, i, j;
+	int ret;
 
 	ret = pcs_get_function(pctldev, pin, &func);
 	if (ret)
@@ -553,9 +554,9 @@ static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 {
 	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
 	struct pcs_function *func;
-	unsigned offset = 0, shift = 0, i, data, ret;
+	unsigned offset = 0, shift = 0, i, data;
 	u32 arg;
-	int j;
+	int j, ret;
 	enum pin_config_param param;
 
 	ret = pcs_get_function(pctldev, pin, &func);
-- 
2.51.0




