Return-Path: <stable+bounces-185161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E6BD4F9C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3FF3E39D4
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E2230AD00;
	Mon, 13 Oct 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6j/I3QF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79030ACFC;
	Mon, 13 Oct 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369506; cv=none; b=M5HK+Fz4krjllu//MT0J5vJwVn1eCeWNeESvgS4A40WWEpf/fYNGnPYcsMJEqBNgEanjRwp2OkmE7tQ+tcp463SjjbJb4vFBrdUX3ODHaPznJjhEh7Aln5dpZDhGVYV2nyfwBTUYqpM04ogarvTagbzSm5u5hkeEG2/fWmlOnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369506; c=relaxed/simple;
	bh=Jg/GGeajTrhB6tamZCpLHj7g6gYyLVl1kC+UnEa3L/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTOfJmH0spM+1SinorV7jFsdh/xjH1mUxEZSIZcTJ1zHuaeZQ3ec80h3uj4IQRanYJkLq8dAa4InAvXdou0EOPjosdJNByTxZuCbLyQGG/IBKWglLSKhNy2p/jeLVsD1eAwosPu9Kuv/j4trKrRzy9lfThzxYOKwjcGyud/cAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6j/I3QF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C10C4CEE7;
	Mon, 13 Oct 2025 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369506;
	bh=Jg/GGeajTrhB6tamZCpLHj7g6gYyLVl1kC+UnEa3L/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6j/I3QFXKnS36/S9AI22rMPyqpF+NF5JAfGw7Mfb9q6M5ZoBYALtnFOfIsi8rroK
	 ODgV0rFtwJAnoDz5onE0gTG3aMyLxmbXeS7cIa9AEaJM++0xreT8AwoXXLw/+eRy73
	 PHFjJNvClO8/fIneIiDBbyFajR480BIi26A1NABc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 238/563] serial: max310x: Add error checking in probe()
Date: Mon, 13 Oct 2025 16:41:39 +0200
Message-ID: <20251013144419.909119463@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 672a37ba8af1f2ebcedeb94aea2cdd047f805f30 ]

Check if devm_i2c_new_dummy_device() fails.

Fixes: 2e1f2d9a9bdb ("serial: max310x: implement I2C support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/aJTMPZiKqeXSE-KM@stanley.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ce260e9949c3c..d9a0100b92d2b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1644,6 +1644,8 @@ static int max310x_i2c_probe(struct i2c_client *client)
 		port_client = devm_i2c_new_dummy_device(&client->dev,
 							client->adapter,
 							port_addr);
+		if (IS_ERR(port_client))
+			return PTR_ERR(port_client);
 
 		regcfg_i2c.name = max310x_regmap_name(i);
 		regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
-- 
2.51.0




