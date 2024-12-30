Return-Path: <stable+bounces-106351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7EC9FE7F9
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355DD1882F03
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B814F136;
	Mon, 30 Dec 2024 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RNCNXYti"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5542AA6;
	Mon, 30 Dec 2024 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573677; cv=none; b=H6a9H4E/QqKJkhDHvz2m7qaSpR3dadlXyN/lX6RMjWGiKN3H6TCLgk0QLzA+BxzuJzq+4BFDj1sDzlqx6twZpwxhK5H+RjZqi+EUdhwh7T2fXkbIbSvZKA5NlwWPRvQaFPb/j91bo+/6SIpjEVQ9rT3CusOb/MNkX/tbQ/KyUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573677; c=relaxed/simple;
	bh=U+aJ/PEdYe4jRXPD4LSolji1Th1QMeRKfTnqHYnnUkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROZTk1fHOmoCo2ENPahGEKcaZ7/JswbSHgXMGW64tUcius+BkhdwiAj/goUBa6x2tmP49blk/Ge/7rnpFwDg2qGL25379Ts2sqdiWFP13CncUZ3S9fbh+wGPEphIvhNUY+YWNjpPs+quhUT5cxAESWgJ1bUV8GWOKu5e3CBXI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RNCNXYti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00CFC4CED0;
	Mon, 30 Dec 2024 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573677;
	bh=U+aJ/PEdYe4jRXPD4LSolji1Th1QMeRKfTnqHYnnUkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNCNXYtiFWiZPQm+PzIun700w6Vn6U100pObtjLLBjLV+SsqDnlhIEmhiXmzd7yaV
	 m4q3jpf3GF5doMYYbWdJVgwFdfXOTEJ9eCz88OLi7qOI8iwFCCEXL7v1LttVlNxy1u
	 kcGGMEtHBdZRrgZWiBz6C+4yo0zHq834Q0JODGkI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.1 55/60] power: supply: gpio-charger: Fix set charge current limits
Date: Mon, 30 Dec 2024 16:43:05 +0100
Message-ID: <20241230154209.362258317@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154207.276570972@linuxfoundation.org>
References: <20241230154207.276570972@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

commit afc6e39e824ad0e44b2af50a97885caec8d213d1 upstream.

Fix set charge current limits for devices which allow to set the lowest
charge current limit to be greater zero. If requested charge current limit
is below lowest limit, the index equals current_limit_map_size which leads
to accessing memory beyond allocated memory.

Fixes: be2919d8355e ("power: supply: gpio-charger: add charge-current-limit feature")
Cc: stable@vger.kernel.org
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Link: https://lore.kernel.org/r/20241209-fix-charge-current-limit-v1-1-760d9b8f2af3@liebherr.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/gpio-charger.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -67,6 +67,14 @@ static int set_charge_current_limit(stru
 		if (gpio_charger->current_limit_map[i].limit_ua <= val)
 			break;
 	}
+
+	/*
+	 * If a valid charge current limit isn't found, default to smallest
+	 * current limitation for safety reasons.
+	 */
+	if (i >= gpio_charger->current_limit_map_size)
+		i = gpio_charger->current_limit_map_size - 1;
+
 	mapping = gpio_charger->current_limit_map[i];
 
 	for (i = 0; i < ndescs; i++) {



