Return-Path: <stable+bounces-35436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7BD8943ED
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2F11F2751A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13C0482DF;
	Mon,  1 Apr 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nZWWoLaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016747A5D;
	Mon,  1 Apr 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991396; cv=none; b=TVwgRHSmZfVI0q/lqrNUh4TNYs4edslN5dgx8qX82zr1Sc72W0kBtVGZviNcnVDYmbml+WPd5KTTwSzHH2X5c1/f9hvluh+giqJPeweKSbSKkHMDChKFu/4MTcer7QzJL27qZdZ5sXiQKfUsXfD6nQLekL7jQGGKFb/C10Ia69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991396; c=relaxed/simple;
	bh=GezibIH3PjgdQpbBahxSLPTI4iYnIkEnfGNrnMjsOMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GV2IMGOjXB4ubGDiW8/Pb4W2paN5BkAgZxlipQgsk3tzHZhs+NBjtvzAqGhCm6mpb55KX5QTNgT+NSNGMIreMcaW0lwJeAfaHZi2wSVI6RjiVHDZ+wiaqmOJWP4syDEaFjJ+2hbPrxTa2N1L4lNEEwIcYtJe0VmkevFDUOaOl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nZWWoLaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D034EC433F1;
	Mon,  1 Apr 2024 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991396;
	bh=GezibIH3PjgdQpbBahxSLPTI4iYnIkEnfGNrnMjsOMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZWWoLaK292wPUjaEPvuJdzI7BGd9OniGsJdJwIgEgcvtqOlM0MUYQE9Jh5eOZaYW
	 Fib/aw2kfHABtbrLMdgpe7Sci5DDN/HOnpe/xwb/aMMhfsWF/mz89JX0dES6tifXpj
	 DWHZjSwzWU/YHbvRJCW2Qc0Fc0tD1mMqdUA5PI9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 6.1 252/272] usb: typec: ucsi: Ack unsupported commands
Date: Mon,  1 Apr 2024 17:47:22 +0200
Message-ID: <20240401152538.899754221@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

From: Christian A. Ehrhardt <lk@c--e.de>

commit 6b5c85ddeea77d18c4b69e3bda60e9374a20c304 upstream.

If a command completes the OPM must send an ack. This applies
to unsupported commands, too.

Send the required ACK for unsupported commands.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Cc: stable <stable@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Link: https://lore.kernel.org/r/20240320073927.1641788-4-lk@c--e.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -138,8 +138,12 @@ static int ucsi_exec_command(struct ucsi
 	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
 
-	if (cci & UCSI_CCI_NOT_SUPPORTED)
+	if (cci & UCSI_CCI_NOT_SUPPORTED) {
+		if (ucsi_acknowledge_command(ucsi) < 0)
+			dev_err(ucsi->dev,
+				"ACK of unsupported command failed\n");
 		return -EOPNOTSUPP;
+	}
 
 	if (cci & UCSI_CCI_ERROR) {
 		if (cmd == UCSI_GET_ERROR_STATUS)



