Return-Path: <stable+bounces-86103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB6699EBAD
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB481F26CAB
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D01AF0B1;
	Tue, 15 Oct 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ti9fnZC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901371C07FF;
	Tue, 15 Oct 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997780; cv=none; b=ETtLDLh+h4iaA1uyGpTRpyzHy78uI5PgJxLywtBdlgBxGH3l3kV4mGufllnVh4g6Ukh//2za0lgP9cx7TpFGULDjdid9d3CnOJZRA/N8nyZb9ZNuUoQLfaxUJh2mbAg2lnCul/EacgMJlKqr80kV3r0vUS95PqiBaRuD9AGh2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997780; c=relaxed/simple;
	bh=45vxPLvSZirvK2tndphoxtioIjl+usbIpdTLrNN4zt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFKZEYxLs40Aywz6lOuCSzUMhc/tk55PV+Xy9mRA1J9I0BrJkGqdqmhxu5vvEbW6HhvxaHmFE0F8LpuEqVAeS27qAa8dg5FEljrKH8YD6k/ZhMEzSMSOFeGctShhm4qow45bjWKjIe+40Y0Qy7CWNgFdkd21Pj/l/SAkBOO3RJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ti9fnZC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2327C4CEC6;
	Tue, 15 Oct 2024 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997780;
	bh=45vxPLvSZirvK2tndphoxtioIjl+usbIpdTLrNN4zt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ti9fnZC9Wq8x7ToiZmE7Xkh+SSRDZuky3EpdGwGsh0QBO4keLTWotEQ6I5NqvEYRi
	 OwY++gDWLEsqTWSJmgh12Pkd61o8t2B66VoJZv7D9O8C2XeVqG+opEcS2nfLdwafX/
	 e0DRRFg6eI23nTqWej27XbNDCWmLQVIlN2A3cxks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Ferland <marc.ferland@sonatest.com>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 285/518] i2c: xiic: improve error message when transfer fails to start
Date: Tue, 15 Oct 2024 14:43:09 +0200
Message-ID: <20241015123927.988254228@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Ferland <marc.ferland@sonatest.com>

[ Upstream commit ee1691d0ae103ba7fd9439800ef454674fadad27 ]

xiic_start_xfer can fail for different reasons:

- EBUSY: bus is busy or i2c messages still in tx_msg or rx_msg
- ETIMEDOUT: timed-out trying to clear the RX fifo
- EINVAL: wrong clock settings

Both EINVAL and ETIMEDOUT will currently print a specific error
message followed by a generic one, for example:

    Failed to clear rx fifo
    Error xiic_start_xfer

however EBUSY will simply output the generic message:

    Error xiic_start_xfer

which is not really helpful.

This commit adds a new error message when a busy condition is detected
and also removes the generic message since it does not provide any
relevant information to the user.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: 1d4a1adbed25 ("i2c: xiic: Try re-initialization on bus busy timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-xiic.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index bd5fc4ace0667..41104f9f6f0ae 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -711,8 +711,11 @@ static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num)
 	mutex_lock(&i2c->lock);
 
 	ret = xiic_busy(i2c);
-	if (ret)
+	if (ret) {
+		dev_err(i2c->adap.dev.parent,
+			"cannot start a transfer while busy\n");
 		goto out;
+	}
 
 	i2c->tx_msg = msgs;
 	i2c->rx_msg = NULL;
@@ -742,10 +745,8 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		return err;
 
 	err = xiic_start_xfer(i2c, msgs, num);
-	if (err < 0) {
-		dev_err(adap->dev.parent, "Error xiic_start_xfer\n");
+	if (err < 0)
 		goto out;
-	}
 
 	err = wait_for_completion_timeout(&i2c->completion, XIIC_XFER_TIMEOUT);
 	mutex_lock(&i2c->lock);
-- 
2.43.0




