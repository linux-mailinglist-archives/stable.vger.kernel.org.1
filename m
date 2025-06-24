Return-Path: <stable+bounces-157828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA57AE55CB
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13904C1C36
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2BA226CE6;
	Mon, 23 Jun 2025 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="laezHdkN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66A226533;
	Mon, 23 Jun 2025 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716819; cv=none; b=BGcxE76swRis+7rvt+IF2W1HzERm1b9eBkCWnkL0C3+gF4aWEerYxdclQt9Aw4Dt9cHiR91oFtiB7YyQDNSH3LhZ9+sHecGZ+LhVdGP7AfxmOGcpe0nRGpv4WFlsm+8x0t85AeR6LRdYbZWXSOFkvMsCzJav1NA57Ba3SCpZdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716819; c=relaxed/simple;
	bh=vb8omzoIpFisVPT6R1k7Qi26EXAkRhQBH8zYlP3fyY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMvucW85tnygHMzdSPlPrMoqMYA1h1HBJzWyw19xIC1KL66NUx2XJNBJCWqoYFjJFrtBXgZ1IUoIw8JkRz0LJStToplRUSvYdsA0rVX3SFqLX8nABhvD7bc+NKd8WcIZYcoUIYUl7vVpqnhZUZPPfEMrAkj/3eR+eghpi/bQob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=laezHdkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6C1C4CEEA;
	Mon, 23 Jun 2025 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716818;
	bh=vb8omzoIpFisVPT6R1k7Qi26EXAkRhQBH8zYlP3fyY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laezHdkN88byZvxqGpuMcA56V1joHiHsfISSvD9eKRvu7ZnhzAhQd6BSVO7GeUNMe
	 wxHJFzKD0Pq7KVcAwdeipVH+K8GJaRYnNNr9fZzA7d/wcURBIBCa9J6mc5cqvZpQaK
	 SbhNlxX0Velcj8QcPIelSbxOkrPCXfsGS18zBlro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 362/508] regulator: max14577: Add error check for max14577_read_reg()
Date: Mon, 23 Jun 2025 15:06:47 +0200
Message-ID: <20250623130654.268345134@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

commit 65271f868cb1dca709ff69e45939bbef8d6d0b70 upstream.

The function max14577_reg_get_current_limit() calls the function
max14577_read_reg(), but does not check its return value. A proper
implementation can be found in max14577_get_online().

Add a error check for the max14577_read_reg() and return error code
if the function fails.

Fixes: b0902bbeb768 ("regulator: max14577: Add regulator driver for Maxim 14577")
Cc: stable@vger.kernel.org # v3.14
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20250526025627.407-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/max14577-regulator.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -40,11 +40,14 @@ static int max14577_reg_get_current_limi
 	struct max14577 *max14577 = rdev_get_drvdata(rdev);
 	const struct maxim_charger_current *limits =
 		&maxim_charger_currents[max14577->dev_type];
+	int ret;
 
 	if (rdev_get_id(rdev) != MAX14577_CHARGER)
 		return -EINVAL;
 
-	max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL4, &reg_data);
+	ret = max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL4, &reg_data);
+	if (ret < 0)
+		return ret;
 
 	if ((reg_data & CHGCTRL4_MBCICHWRCL_MASK) == 0)
 		return limits->min;



