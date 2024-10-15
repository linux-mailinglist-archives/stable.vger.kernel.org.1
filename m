Return-Path: <stable+bounces-86102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D71999EBAC
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047C51F26C6E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE441AF0B0;
	Tue, 15 Oct 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o4tHAURv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19D1C07FF;
	Tue, 15 Oct 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997777; cv=none; b=angOkeUWqhRTqK8boLM+YG29IQdM5DPgibjpoTSwFp+CNc3o8P3FYncrxIrwcOEg6CHVZeQCorbcta8nNIw7Y+D/umhEk2EQFgVhmYeCCfaLwKG8+EyJm0SUGAB4Osw3VJtQzzFC80xynSRIxWuNCZtsNmL3o8cDIm0W2aV/2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997777; c=relaxed/simple;
	bh=FfuUR6ZrySQCajFd2t4N8988uDbHovVCAU9yL2oLB8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WESmab6+ZjVZFb20X0GGzzmV3WFGW8hf9k6i6LoRX45BTDS75nfDdTInUe91XkBJrN6zcAdJwVyPPt57niebAB25h7Kok8OrlAVPUwXctEP1m3jPNhNr0w1PcWZapPzYFhQ46cWEIazyBkG4TPqCemNaN38wyEqcuVRns/rEE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o4tHAURv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C899EC4CEC6;
	Tue, 15 Oct 2024 13:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997777;
	bh=FfuUR6ZrySQCajFd2t4N8988uDbHovVCAU9yL2oLB8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4tHAURvtde5bk4R3cyg2LWnDrXxBmhgMJANuhP5wRZZYeEOKZHY4Hw79sNwdTmNh
	 NXFuJq29VfzqSzcLAHC3RqQCZ4x9EY6d6Gb26WZ6y46zd07PdqJebeSGay7DitNWsy
	 YMLp0/mlnzO5/TfRbjf4kz6GumoKN5+5nUGHiEHY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@amd.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 284/518] i2c: xiic: xiic_xfer(): Fix runtime PM leak on error path
Date: Tue, 15 Oct 2024 14:43:08 +0200
Message-ID: <20241015123927.950849328@linuxfoundation.org>
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

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit d663d93bb47e7ab45602b227701022d8aa16040a ]

The xiic_xfer() function gets a runtime PM reference when the function is
entered. This reference is released when the function is exited. There is
currently one error path where the function exits directly, which leads to
a leak of the runtime PM reference.

Make sure that this error path also releases the runtime PM reference.

Fixes: fdacc3c7405d ("i2c: xiic: Switch from waitqueue to completion")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 1d4a1adbed25 ("i2c: xiic: Try re-initialization on bus busy timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-xiic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index b91ea900aae3a..bd5fc4ace0667 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -744,7 +744,7 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	err = xiic_start_xfer(i2c, msgs, num);
 	if (err < 0) {
 		dev_err(adap->dev.parent, "Error xiic_start_xfer\n");
-		return err;
+		goto out;
 	}
 
 	err = wait_for_completion_timeout(&i2c->completion, XIIC_XFER_TIMEOUT);
@@ -762,6 +762,8 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		err = (i2c->state == STATE_DONE) ? num : -EIO;
 	}
 	mutex_unlock(&i2c->lock);
+
+out:
 	pm_runtime_mark_last_busy(i2c->dev);
 	pm_runtime_put_autosuspend(i2c->dev);
 	return err;
-- 
2.43.0




