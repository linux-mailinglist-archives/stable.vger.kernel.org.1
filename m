Return-Path: <stable+bounces-189926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C286C0C1E7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02EFE4F052E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC62DCF6E;
	Mon, 27 Oct 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Y580H7s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216D2DE6FA
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549903; cv=none; b=fUPIvtzyJH3cSWgdMvVLZ7rmHkeMk1tH7uyQZQFl7BRE2YPoW3CqawCOGGnZK6ndLzsLyNQuo6vnp/SdrxLCzaxeDz9Fh6vo3tcp/n5RFdD7JuH/TQLicNzX6teonaJ0me7pRssRbkE45fYf+5nRh3tE5sQ1jUZl5xxEX3XkS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549903; c=relaxed/simple;
	bh=7FknM1xm7Tb4t/sSuIvwCntjkSAzb5j6t855sL4gowg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RNm7cmRBnYFgPNl3NlR9bd4sE3mGuZxgIbJzb02l24uquPxQ+C86N7JmjBsqkeWfneKppakvQ08NpZ8yZ9G4D9WihiyYvYC+0RVNePVZX8aFvoERGnc5aP+sDIuxgHT/wMzL3v0902WX8vuoEktx+XPO/ee+T2iOvz7SffQPDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Y580H7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DCDC4CEF1;
	Mon, 27 Oct 2025 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761549903;
	bh=7FknM1xm7Tb4t/sSuIvwCntjkSAzb5j6t855sL4gowg=;
	h=Subject:To:Cc:From:Date:From;
	b=0Y580H7scDoD2mdjJF5b/zN2H0jl4yWSj0X+KqGWoN7q49IK9dXCjfPvM8VInEvnJ
	 Aagd5Xor7aAwUTBGmTtzgXlxnW2luBBxyugEBnp/3HEStDGU6+TezdHK+8fSCPTXU1
	 gioMUqSrdS0o6FAM/gxreZL4EXZB6kLn9VtB+cZc=
Subject: FAILED: patch "[PATCH] serial: 8250_dw: handle reset control deassert error" failed to apply to 5.15-stable tree
To: a.shimko.dev@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Oct 2025 08:25:00 +0100
Message-ID: <2025102700-impish-precook-5377@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x daeb4037adf7d3349b4a1fb792f4bc9824686a4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102700-impish-precook-5377@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From daeb4037adf7d3349b4a1fb792f4bc9824686a4b Mon Sep 17 00:00:00 2001
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Sun, 19 Oct 2025 12:51:31 +0300
Subject: [PATCH] serial: 8250_dw: handle reset control deassert error

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

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..710ae4d40aec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -635,7 +635,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)


