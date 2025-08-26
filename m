Return-Path: <stable+bounces-176132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF6CB36C01
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DDE565759
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59F35FC10;
	Tue, 26 Aug 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+AqHig3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA335CEB3;
	Tue, 26 Aug 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218864; cv=none; b=a5eD9rnQTgue+snLN9LEADLBQT65h0FE8w7T4TokOXjx1k3Zy2WV6JFhpz9ZSs7GqurVe150yH2SJyrSHE/VT0bvDEEImnrqQS6EtQfIPH6jykRYBWrzBIx2QKx+vTFiYd3iP5TgTFIT7c/WDSN90CkVzfJjRAVyMx4GZArJX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218864; c=relaxed/simple;
	bh=0qjg/4704ParXVyGPBMCnYiEQsRlKcn60Yjr4GGUCjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeT5Cn7SrvAoZ1/9sCnz7cfogbntee3By6IVeIRNc+WGrjIDZPyFO1wr137IxZqZRgN/Yc0mY+Gi1/Yn8oW1ixof8Q7qf2w3lNeScqHn5IStO1AZ/teoKo8x4U3NaTME4hyy8FC2svB769Xg/uXraUnq4YfJ4VZzWvvv9ESJzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+AqHig3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7306BC4CEF1;
	Tue, 26 Aug 2025 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218863;
	bh=0qjg/4704ParXVyGPBMCnYiEQsRlKcn60Yjr4GGUCjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+AqHig3cCH1UmpUD9luNp1itCOli95oMrjXQcebG9vq/J/LubDc9jV2LolAst/+K
	 6qNfVjxxkTe5kOsTuewqvy034KqpGvvXjbeHUG3nicuI0/qkjPPYMXPbXVj4zWCBJv
	 jdoim3YnThevUQsYDr2fflLMPTba90U+x5zWj+RU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 163/403] sunvdc: Balance device refcount in vdc_port_mpgroup_check
Date: Tue, 26 Aug 2025 13:08:09 +0200
Message-ID: <20250826110911.394681255@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 63ce53724637e2e7ba51fe3a4f78351715049905 upstream.

Using device_find_child() to locate a probed virtual-device-port node
causes a device refcount imbalance, as device_find_child() internally
calls get_device() to increment the device’s reference count before
returning its pointer. vdc_port_mpgroup_check() directly returns true
upon finding a matching device without releasing the reference via
put_device(). We should call put_device() to decrement refcount.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 3ee70591d6c4 ("sunvdc: prevent sunvdc panic when mpgroup disk added to guest domain")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://lore.kernel.org/r/20250719075856.3447953-1-make24@iscas.ac.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/sunvdc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -967,8 +967,10 @@ static bool vdc_port_mpgroup_check(struc
 	dev = device_find_child(vdev->dev.parent, &port_data,
 				vdc_device_probed);
 
-	if (dev)
+	if (dev) {
+		put_device(dev);
 		return true;
+	}
 
 	return false;
 }



