Return-Path: <stable+bounces-119227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A80A42443
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090AB7A1E57
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C323373D;
	Mon, 24 Feb 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dnf9Zaib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E31F824A3;
	Mon, 24 Feb 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408751; cv=none; b=fI1L9qLvpUzWgMvkU4t3cndpEaOGLMRJFd61nkJHscDw5crtrKUv1qw2pic5LE+tysTDhLt+6bmKp/jquw2WlF6SJFaTl/wDIGy5S6O+WJOYOfOXqVpTs5wz7zOtAM+OqU5eY3WZT+obZiYA1083PrzwfMzlWoXyen/pK+J5N+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408751; c=relaxed/simple;
	bh=x6q1aSJzOc56dRdp0kFlhIHaaonCXkTd5vnQEItvyAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mqc2gB41cGye4u69artiGicwWry5kJtzXOmCb2AQo0PIYBydyYHGoPweKzGJfcY3rBvXWan0nfWFFOd+aWm4qAaBX71/0g94WObh9Ub43dfPveHRp29+y5MYOsL0SvPGPc+zT1vnh4xwiEZKyKfhETm4TRO+ZbDgKsxHEbD2FkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dnf9Zaib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83386C4CEE8;
	Mon, 24 Feb 2025 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408751;
	bh=x6q1aSJzOc56dRdp0kFlhIHaaonCXkTd5vnQEItvyAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dnf9ZaibD5Zg4uegYfg13j980T1lsx+F68SKL9tUGpJZLTjMlnXpJ3KDLuLlhfPlM
	 Zt+C5krLlfA506ylVdbc2mODHT813Luo1D25LfaaPLDW9sNXh4/qZZezeOsyBdI+DR
	 ULONzLa+QQDp6tfJ2u+iUHSjL0jAZuXmjMafpXjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 149/154] net: pse-pd: Fix deadlock in current limit functions
Date: Mon, 24 Feb 2025 15:35:48 +0100
Message-ID: <20250224142612.880033740@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kory Maincent <kory.maincent@bootlin.com>

commit 488fb6effe03e20f38d34da7425de77bbd3e2665 upstream.

Fix a deadlock in pse_pi_get_current_limit and pse_pi_set_current_limit
caused by consecutive mutex_lock calls. One in the function itself and
another in pse_pi_get_voltage.

Resolve the issue by using the unlocked version of pse_pi_get_voltage
instead.

Fixes: e0a5e2bba38a ("net: pse-pd: Use power limit at driver side instead of current limit")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Link: https://patch.msgid.link/20250212151751.1515008-1-kory.maincent@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/pse-pd/pse_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -309,7 +309,7 @@ static int pse_pi_get_current_limit(stru
 		goto out;
 	mW = ret;
 
-	ret = pse_pi_get_voltage(rdev);
+	ret = _pse_pi_get_voltage(rdev);
 	if (!ret) {
 		dev_err(pcdev->dev, "Voltage null\n");
 		ret = -ERANGE;
@@ -346,7 +346,7 @@ static int pse_pi_set_current_limit(stru
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
-	ret = pse_pi_get_voltage(rdev);
+	ret = _pse_pi_get_voltage(rdev);
 	if (!ret) {
 		dev_err(pcdev->dev, "Voltage null\n");
 		ret = -ERANGE;



