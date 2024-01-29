Return-Path: <stable+bounces-16439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E4F840CF9
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F60B2503C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39715704F;
	Mon, 29 Jan 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zaUn41VQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231B157049;
	Mon, 29 Jan 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548020; cv=none; b=Hunm4eEpDwRVYpVQxgPWKfsGfkF/lnR3zPsuRkaCvmJF9maKMr/JIv5PYolWa/bQvQzgDeklTAFY2+zI5Qz24iQUakw2Kgwtev9iOi8VuebaqeTQGJw3e1L8Oyewz8tTeOPQzekgsZ9i/YUpFfls8iQ1V3EiPKjfla8MY82MPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548020; c=relaxed/simple;
	bh=l9d5kexJ0Ft4a6n+aK/AnR5aXGcap2bENb7DjVTHyBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvGwQDRGEAntJJKL869hrD+ubrbzfH9nzsYiYe0vxTUskxcI44aoZP09GQgBxnClkN2UyeqYp92+gVs/CSdQnp7V1Ow5KzlH+28NFJDXJ50QROKJSuoIwKBcygl7XPWpiF2s7l78TTYd6IDzhCOZW9IQtu1GiVP5q6vLHBNUkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zaUn41VQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D4CC433F1;
	Mon, 29 Jan 2024 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548019;
	bh=l9d5kexJ0Ft4a6n+aK/AnR5aXGcap2bENb7DjVTHyBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zaUn41VQaxJ9W5VJvsjbcAxMkJKlmiMuaUs43hMnN8ho21K5z2VtfHe5Izzo6dSGj
	 BBeGqsnc+m+mTA/o0nQ0beed7Nv+FNpCjXA1+LxR/19IS6SueVunQ4aq6z8SmYaCVe
	 6sv4aV3g/rmJWA/slIeQu5mpTgiJYIZw29neY810=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6.7 012/346] OPP: Pass rounded rate to _set_opp()
Date: Mon, 29 Jan 2024 09:00:43 -0800
Message-ID: <20240129170016.721631681@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 7269c250db1b89cda72ca419b7bd5e37997309d6 upstream.

The OPP core finds the eventual frequency to set with the help of
clk_round_rate() and the same was earlier getting passed to _set_opp()
and that's what would get configured.

The commit 1efae8d2e777 ("OPP: Make dev_pm_opp_set_opp() independent of
frequency") mistakenly changed that. Fix it.

Fixes: 1efae8d2e777 ("OPP: Make dev_pm_opp_set_opp() independent of frequency")
Cc: v5.18+ <stable@vger.kernel.org> # v6.0+
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/opp/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1378,12 +1378,12 @@ int dev_pm_opp_set_rate(struct device *d
 		 * value of the frequency. In such a case, do not abort but
 		 * configure the hardware to the desired frequency forcefully.
 		 */
-		forced = opp_table->rate_clk_single != target_freq;
+		forced = opp_table->rate_clk_single != freq;
 	}
 
-	ret = _set_opp(dev, opp_table, opp, &target_freq, forced);
+	ret = _set_opp(dev, opp_table, opp, &freq, forced);
 
-	if (target_freq)
+	if (freq)
 		dev_pm_opp_put(opp);
 
 put_opp_table:



