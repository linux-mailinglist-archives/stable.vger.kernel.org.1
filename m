Return-Path: <stable+bounces-107343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0636A02B7E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CDC3A5DC5
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398831607AA;
	Mon,  6 Jan 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EMN4NW/N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F67082A;
	Mon,  6 Jan 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178180; cv=none; b=k5SW7OF+cQ0eAiZhwNMynutCJsVO8yhyMnNpwSCfJgfdWuP5fyfDPUAUZkxFYglaNK7xdMNQgGTUr06+/T4VbiHQykOVyJ53Hy609ykYWlsjwTgnwzzuG5vCIIoMmxXrdHhBvKujHXUziqetIxLocCVRm2O1zjqs9EkXuRKtu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178180; c=relaxed/simple;
	bh=b8zDzWaIqxRRTvj+rZBKZPl9xZNsl7xLJ1bsr+vZvTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sauzl1DczCfp/iqJy+C24yjRa16UUxl3ndViztkYwjQlMZIR/Qhpi3fDjGHop//SuDlljiMu0ZBad86tEGiaS1LIHDlpsTpw2glyyiCU4iwmRTuJLZXaEOZ6EQ+o0hCabUZFp0i7Dc48ELq4gc/6dIUkfWI48wJPuhwFo1Qlyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EMN4NW/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FACC4CED2;
	Mon,  6 Jan 2025 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178179;
	bh=b8zDzWaIqxRRTvj+rZBKZPl9xZNsl7xLJ1bsr+vZvTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMN4NW/NX0jW3LIX5Cy4pH53deVkflgjYH/wZbQgognArkMdFeys8u2FgQpERLnff
	 JMJJDMrCc64yROjQmFGAOnqtjATDXU4VTIXaXV/LaqErsdioxGlseQaKAVl843wlc9
	 8qEV1BDjrYlKaizid/wtfS2TmGyHPQsKc/bD0TX4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.10 032/138] sh: clk: Fix clk_enable() to return 0 on NULL clk
Date: Mon,  6 Jan 2025 16:15:56 +0100
Message-ID: <20250106151134.437283986@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151133.209718681@linuxfoundation.org>
References: <20250106151133.209718681@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit ff30bd6a6618e979b16977617371c0f28a95036e upstream.

On SH, devm_clk_get_optional_enabled() fails with -EINVAL if the clock
is not found.  This happens because __devm_clk_get() assumes it can pass
a NULL clock pointer (as returned by clk_get_optional()) to the init()
function (clk_prepare_enable() in this case), while the SH
implementation of clk_enable() considers that an error.

Fix this by making the SH clk_enable() implementation return zero
instead, like the Common Clock Framework does.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/b53e6b557b4240579933b3359dda335ff94ed5af.1675354849.git.geert+renesas@glider.be
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/sh/clk/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -295,7 +295,7 @@ int clk_enable(struct clk *clk)
 	int ret;
 
 	if (!clk)
-		return -EINVAL;
+		return 0;
 
 	spin_lock_irqsave(&clock_lock, flags);
 	ret = __clk_enable(clk);



