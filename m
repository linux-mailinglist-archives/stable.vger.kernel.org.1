Return-Path: <stable+bounces-72199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 187AA9679A4
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28F71F21C26
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E1183CAB;
	Sun,  1 Sep 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gaAAJDdd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593E185B63;
	Sun,  1 Sep 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209163; cv=none; b=QNp2pqEsO0BVwZj0RItr8ttE6rkh02+oaZoc0EkGeqbmmrSzZ7WIfV305q6dotn0vwddWq9BN2kC0PmWkJnf6BjOUvIfXD+T1n4SE+vdNi2S1iEeercA0pjiKSYwmXydTCYGWbD3oqyRnlBeqQd8y2iPUjLmRTZc3qKUsKxocJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209163; c=relaxed/simple;
	bh=t0Ir/OfEDQf0yupz54NIB4LuIYdKwxzZlLwcIkVNEMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDHmhbMGTawfxxDGezNhtrmmyRh9BRV3gHpZfdls34cKUvW+FsHR2VmTZ8p0yJrPSl0KRaQEPAQ+k0PbddSqveG6SwO6K64UIxFp3DQPR8qMrpYmijBuewH8n0a0mr1E0IThCXFU5/CaejVr/a7/gQxiUp2Of89HD8g0cajE3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gaAAJDdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B490CC4CEC3;
	Sun,  1 Sep 2024 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209163;
	bh=t0Ir/OfEDQf0yupz54NIB4LuIYdKwxzZlLwcIkVNEMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaAAJDddug+QbW5OhgfMEJb4j8dCO9leBKNPJ1/fShd6xJQf4kqJN7OVT7ouA7Xnr
	 CaF4UcwZTICzMvRvYo9nNWU9EE1gLhmAEzFHcezei9yobQkbavkZ+WfvKGjLCoalNi
	 CAs1gNQaQLCoviDwqDYHepVMifqFYlyY5jXE7SLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 06/71] pinctrl: single: fix potential NULL dereference in pcs_get_function()
Date: Sun,  1 Sep 2024 18:17:11 +0200
Message-ID: <20240901160802.127032720@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160801.879647959@linuxfoundation.org>
References: <20240901160801.879647959@linuxfoundation.org>
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

From: Ma Ke <make24@iscas.ac.cn>

commit 1c38a62f15e595346a1106025722869e87ffe044 upstream.

pinmux_generic_get_function() can return NULL and the pointer 'function'
was dereferenced without checking against NULL. Add checking of pointer
'function' in pcs_get_function().

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 571aec4df5b7 ("pinctrl: single: Use generic pinmux helpers for managing functions")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://lore.kernel.org/20240808041355.2766009-1-make24@iscas.ac.cn
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-single.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -350,6 +350,8 @@ static int pcs_get_function(struct pinct
 		return -ENOTSUPP;
 	fselector = setting->func;
 	function = pinmux_generic_get_function(pctldev, fselector);
+	if (!function)
+		return -EINVAL;
 	*func = function->data;
 	if (!(*func)) {
 		dev_err(pcs->dev, "%s could not find function%i\n",



