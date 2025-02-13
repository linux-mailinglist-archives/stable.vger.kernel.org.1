Return-Path: <stable+bounces-115734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C9A34591
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C9F189B14A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20379202C4C;
	Thu, 13 Feb 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I/Nsecyq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD0201267;
	Thu, 13 Feb 2025 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459064; cv=none; b=UshSjsR4RozppjnD5G6HVJVr52IX7epU+6GxeDJtjB49ShA75KtKHMbxVAh83PvurnYyo+EImQDRCIytRSJGIvfiUtJhv6vxPyV/Wi9vGePShQEHUVbnuUnuDRCOdtM9H+C7zQRJU+cfN7QOcKBJsHitlPw5PmZ/EJLNuEO62Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459064; c=relaxed/simple;
	bh=Tr876m93rnQ78dxmTxuHuOd3ZYkVec/uXj+XGSDwEMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlY/y1Nwry8qqLBpzxVG/CDZtGyN8cpkRmCJeZP9Dgf/ruCpZ/QBv7ezlk9Vzau8WoGjsv51AYLcAqAdX7OS1EMvGSneYEZyqSAdVJXXA6Ql+ge+xMbneqgKFCSvyM2f2oNvd+O7Q9M3t+xAAHqlU25NYvxP+S4RGQgvsw3Is6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I/Nsecyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0442C4CED1;
	Thu, 13 Feb 2025 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459064;
	bh=Tr876m93rnQ78dxmTxuHuOd3ZYkVec/uXj+XGSDwEMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/NsecyqSiKgraOkSWrq9MGAAXuy5qehqeuxZyfg1yCeoceoKHdJ3oTcytjYsh4Ov
	 4WW5RUyOQmmyPEZBbOMvIJpbv5N8SBrLLVT0g7GcFr7OCUVCVZ9JNZ0BrnHYeMd0Ge
	 IPXsApKORNoQDz+bvzGC5Zkuc2RmsQd1kpC4iFx4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 6.13 157/443] binfmt_flat: Fix integer overflow bug on 32 bit systems
Date: Thu, 13 Feb 2025 15:25:22 +0100
Message-ID: <20250213142446.655961581@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 55cf2f4b945f6a6416cc2524ba740b83cc9af25a upstream.

Most of these sizes and counts are capped at 256MB so the math doesn't
result in an integer overflow.  The "relocs" count needs to be checked
as well.  Otherwise on 32bit systems the calculation of "full_data"
could be wrong.

	full_data = data_len + relocs * sizeof(unsigned long);

Fixes: c995ee28d29d ("binfmt_flat: prevent kernel dammage from corrupted executable headers")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Nicolas Pitre <npitre@baylibre.com>
Link: https://lore.kernel.org/r/5be17f6c-5338-43be-91ef-650153b975cb@stanley.mountain
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/binfmt_flat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -478,7 +478,7 @@ static int load_flat_file(struct linux_b
 	 * 28 bits (256 MB) is way more than reasonable in this case.
 	 * If some top bits are set we have probable binary corruption.
 	*/
-	if ((text_len | data_len | bss_len | stack_len | full_data) >> 28) {
+	if ((text_len | data_len | bss_len | stack_len | relocs | full_data) >> 28) {
 		pr_err("bad header\n");
 		ret = -ENOEXEC;
 		goto err;



