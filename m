Return-Path: <stable+bounces-47324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801AD8D0D86
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4FC281892
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8FF15FCFB;
	Mon, 27 May 2024 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QbLusOh3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F717727;
	Mon, 27 May 2024 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838253; cv=none; b=Nih3pX/IhIYGAeCPf9Oy3HVnzLtm0ro2/nVSyacPBp0/QbUZcRyTokx/XCwO6KM8houbZBZ+j37a7olwVJHPrDmnVuJerqWeOB/j0izeBTMYaAO/OkdsjRxJ56bgJurQI1S2jneF6G1InbSh32zLP0QuzzueAt3gqXkQ869Dtkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838253; c=relaxed/simple;
	bh=rYvQkFBippdFXHFcDZbiBny7sv+PL8ixs1GZv7KHRTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=an9XQh13ONHaMX+GXR3c26VwLBk7Uk36/6MUMzcuYt/VyiStaTgwy81Y4Old/6odCh6/tES2UM9rQ6xUnN+bUm49vi+JAKLjcGpebYAorEUs/J90Infb6ug50yg7gdmJMvY1PwGdU8KQqyKZZd1BzAqK5q9bFHddXQ29J4p8OR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QbLusOh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DEAC32781;
	Mon, 27 May 2024 19:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838253;
	bh=rYvQkFBippdFXHFcDZbiBny7sv+PL8ixs1GZv7KHRTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbLusOh3zO+Gp0jGWRLzUrO64Vzld2tpHhDvlczjVnpcHLd5jF2Oi707ts0ZO8Mfb
	 ks7yWYefhrU6XYUZIQhSdN8pTar7PmDJcCb7pDvny5/iujs9471W9gYSYSye0Ufl5d
	 p5xe/P8QQpPVyUY9zdj+shvxSLmHRnDIzUK7eAvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 324/493] dpll: fix return value check for kmemdup
Date: Mon, 27 May 2024 20:55:26 +0200
Message-ID: <20240527185640.866359159@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit ad506586cb69292b6ac59ab95468aadd54b19ab7 ]

The return value of kmemdup() is dst->freq_supported, not
src->freq_supported. Update the check accordingly.

Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20240513032824.2410459-1-nichen@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/dpll_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index a6856730ca90f..22c2f1375e867 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -449,7 +449,7 @@ static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 				   sizeof(*src->freq_supported);
 		dst->freq_supported = kmemdup(src->freq_supported,
 					      freq_size, GFP_KERNEL);
-		if (!src->freq_supported)
+		if (!dst->freq_supported)
 			return -ENOMEM;
 	}
 	if (src->board_label) {
-- 
2.43.0




