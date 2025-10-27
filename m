Return-Path: <stable+bounces-190990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3DC10CA3
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A90E3527B4
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60F320CCE;
	Mon, 27 Oct 2025 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYsRQ3hC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF722C3749;
	Mon, 27 Oct 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592728; cv=none; b=cjzxwlSQ8rL+G5+YG6iEQZn+G5Ems2SZQScffNfjxdRteL6oqZjDeeptDjGkFMeTPcOoO3g80UJ/o1JKsKS8Fvts5K4jddof+TKoxOJwfxnZEuwPW0TG2qRD20zFRwKsL3rDSBTg3zCO4nMV+QkyGkR68OieDkizGJTnZoimmMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592728; c=relaxed/simple;
	bh=7l2S9W0Cxy9E1RAppVvvzOwYZ2psOGsL7PKMunfOOZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9ujChaFD8IOw1RbvGPm8uGwk5wcFX+KbhqTSL99DJLo8bXZ9HvGtE/5ZevGLBeOuY8TkZnS9O4PhmGWOaSNLcsRSys1wrzlHuxt268YYqZD0hF2joE7N0vxEP5piu8xQ3KJZFbk//hrJFCYvK+6cRzXqMJLQIoYuWojrotr6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYsRQ3hC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54785C4CEF1;
	Mon, 27 Oct 2025 19:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592727;
	bh=7l2S9W0Cxy9E1RAppVvvzOwYZ2psOGsL7PKMunfOOZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYsRQ3hCXQH82Up4QGG0/VSIN8af/ApCt/UUs0QbM9fNN6MeU7pnoMMsaVwaTcECR
	 0MK/Nzj3kWQrc+WD5zJ8DqMmjKUMzWT0fq2/qnQA57EDhZ7RCZ9m+6v90bZbVBo+AA
	 sTejuPJu0AHTI8+/mv+0tyjs35PRGSdmtfDIGoSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Artem Shimko <a.shimko.dev@gmail.com>
Subject: [PATCH 6.6 74/84] serial: 8250_dw: handle reset control deassert error
Date: Mon, 27 Oct 2025 19:37:03 +0100
Message-ID: <20251027183440.779523017@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
References: <20251027183438.817309828@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Shimko <a.shimko.dev@gmail.com>

commit daeb4037adf7d3349b4a1fb792f4bc9824686a4b upstream.

Check the return value of reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Fixes: acbdad8dd1ab ("serial: 8250_dw: simplify optional reset handling")
Cc: stable <stable@kernel.org>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
Link: https://patch.msgid.link/20251019095131.252848-1-a.shimko.dev@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dw.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -653,7 +653,9 @@ static int dw8250_probe(struct platform_
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)



