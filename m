Return-Path: <stable+bounces-203819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A7FCE76DE
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990B03024E4C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4793314AE;
	Mon, 29 Dec 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ozVTUUhO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF753093C1;
	Mon, 29 Dec 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025257; cv=none; b=sBsoveLSPbxoEJli4f9KLUe1uyv1KClF1DyifFNFIOeK8NF76UZklvDMEp1sXNsHKYqh3mkXfFyrXXDE3TNaVt7zm6/42GVAveTFjodJh+ioonJI2fA27GAW9wUfd+Oh+AL4+ZPf0kIDWsbjqehEHt8m+7CohW9xhpWaI0uksdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025257; c=relaxed/simple;
	bh=s44YS8Vz34VgQTNiMrbsIGeFflsJzqExAkpiojXHZnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMdiYxoWplAURcUk1YBB8IrkGPe12c8qbEje0fivzUP6MZ6EXjIG0dtpuWDti0luvTgDOhuLUKK8j2WuTw9H86NR+npvmxdPWzQLLLFJ2YSgYMwrFPH0oUiFbFOgAvhDgiKrmAI31SuCHoVM89XYSwRWiyxgH6W4oxgg3YjSLp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ozVTUUhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBEEC116C6;
	Mon, 29 Dec 2025 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025256;
	bh=s44YS8Vz34VgQTNiMrbsIGeFflsJzqExAkpiojXHZnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozVTUUhOmgm9GbgzVHzRZL8Ajc+u4xS9pn2xmjpUPQPZ7K70ZryCiawd2WCnCGuGd
	 YNxYVY3PhnLKdHjfZgJxT5kDeo7pdQKDCDteW09l0cx0041IjGnpvson81EbFnoFy7
	 cc9wvgNEacJmxyHl+aJsiiJ9SWybWi1PnCmRtFs0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junjie Cao <junjie.cao@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.18 149/430] Input: ti_am335x_tsc - fix off-by-one error in wire_order validation
Date: Mon, 29 Dec 2025 17:09:11 +0100
Message-ID: <20251229160729.845196389@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junjie Cao <junjie.cao@intel.com>

commit 248d3a73a0167dce15ba100477c3e778c4787178 upstream.

The current validation 'wire_order[i] > ARRAY_SIZE(config_pins)' allows
wire_order[i] to equal ARRAY_SIZE(config_pins), which causes out-of-bounds
access when used as index in 'config_pins[wire_order[i]]'.

Since config_pins has 4 elements (indices 0-3), the valid range for
wire_order should be 0-3. Fix the off-by-one error by using >= instead
of > in the validation check.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Link: https://patch.msgid.link/20251114062817.852698-1-junjie.cao@intel.com
Fixes: bb76dc09ddfc ("input: ti_am33x_tsc: Order of TSC wires, made configurable")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -85,7 +85,7 @@ static int titsc_config_wires(struct tit
 		wire_order[i] = ts_dev->config_inp[i] & 0x0F;
 		if (WARN_ON(analog_line[i] > 7))
 			return -EINVAL;
-		if (WARN_ON(wire_order[i] > ARRAY_SIZE(config_pins)))
+		if (WARN_ON(wire_order[i] >= ARRAY_SIZE(config_pins)))
 			return -EINVAL;
 	}
 



