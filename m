Return-Path: <stable+bounces-160657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E182CAFD12F
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFCC1C22745
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8362E49A4;
	Tue,  8 Jul 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nepQmgkr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591082E4985;
	Tue,  8 Jul 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992307; cv=none; b=BeunZvXjrC2iYtotvrgNj1zzEYPfbC0cVFTyhfWzigWugMOYKicJ0muZMldiiJP6Pw1SbkPu+Y9rYyTJ44Dj1bTNn7G68IAv8irlgM3UGfQbPLovaK86GrSsz50goSxtN2t5Knu7/QeElf6xU3neDjaNvyPzAoYhurQZsgrz1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992307; c=relaxed/simple;
	bh=cyExTv0N4GUw+IGUD+p34Fqdku44b4Q3RSuPwcHBFXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdDH4QYtXf2BVidXMYX2Vfus00jyl6HQ7moNRGYbib3zXscISdAmIIg5otoWyie6/3ebnbFjG4umk3AzRqWuFRPokTHfXWk3yUM8n3W2jBYLOD5fsv8eC209K/Hlr2VQZdcf9DJ3ukzFdJQs7/2tUMoQ85P7F03pInjbuEAqANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nepQmgkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B87C4CEED;
	Tue,  8 Jul 2025 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992307;
	bh=cyExTv0N4GUw+IGUD+p34Fqdku44b4Q3RSuPwcHBFXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nepQmgkrzUlQ0eS8ueJbaI6CbaOF2A8qFlMpOnHsrfoKVGMbheAuzZiCX9lREW1UK
	 CkX33e9cCFZmAPQOCMx2Nbuc36Bz9u0K0duSrYdn5cPpDLVJ/X1EDGlqy3TkE6EOvO
	 vymIaplK6Ip/V8hU9qlG31eTpOc/lGTrVv/IbK+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 017/132] mtk-sd: reset host->mrq on prepare_data() error
Date: Tue,  8 Jul 2025 18:22:08 +0200
Message-ID: <20250708162231.232002789@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Senozhatsky <senozhatsky@chromium.org>

commit ec54c0a20709ed6e56f40a8d59eee725c31a916b upstream.

Do not leave host with dangling ->mrq pointer if we hit
the msdc_prepare_data() error out path.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: f5de469990f1 ("mtk-sd: Prevent memory corruption from DMA map failure")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250625052106.584905-1-senozhatsky@chromium.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mtk-sd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1347,6 +1347,7 @@ static void msdc_ops_request(struct mmc_
 	if (mrq->data) {
 		msdc_prepare_data(host, mrq->data);
 		if (!msdc_data_prepared(mrq->data)) {
+			host->mrq = NULL;
 			/*
 			 * Failed to prepare DMA area, fail fast before
 			 * starting any commands.



