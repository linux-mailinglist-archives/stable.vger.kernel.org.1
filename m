Return-Path: <stable+bounces-189927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43962C0C1DE
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8473BD3DB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2AB2DE6E9;
	Mon, 27 Oct 2025 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fneasfxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFFB2DCF6C
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549913; cv=none; b=ryMMemcdO7KlO2FfQjzWEGLRJotK9P9JHtVGxg1zW/erSAKpr3Y46XnJA+Wfcnpc5WHfaFVks6zqyR0L1MIeiqycojxApVRiLJtfLAel/7Qnaw9sPk4EIl/vLqyPrrvxjgdbBcl/tbipjAhBGq6jP92Pb9mn50gxYo0ZLsYx7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549913; c=relaxed/simple;
	bh=8FYfYRN5PFZy+DjtYdE5YARaU8TiuaAwLX6PwOLerEM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GID0wPhcfjRJwpuvxhjOdGwYNpRKbYVoCqtJJwVfCql7oceCWizTwW6V8RLILFIpX+lE54zxfcY8+3I9W5ddMGrbxDQCUEOcPP/SIeIg7PsFBuaaIgTMza9OYJwQ0wJg5ivLtbIQbEyUG54cRuEU+LH3WJ9Vb0l/Ez8NHywwUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fneasfxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15869C4CEF1;
	Mon, 27 Oct 2025 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761549911;
	bh=8FYfYRN5PFZy+DjtYdE5YARaU8TiuaAwLX6PwOLerEM=;
	h=Subject:To:Cc:From:Date:From;
	b=fneasfxUvSw5/Ioueb7C0HNtcHM0Omd+WTluHxd8WB2wv813yS9CCp6NayVkbyXhR
	 vx+EYhLKrUtrslR8NrWqDDfiazA7XpPmQysxQh1P9jcfsnM2Cl0RgG+iBkzEf+fXqm
	 phE3FsAQTuc5J+jj0p1kRZ4XRCRqxT7cwvS/KAwg=
Subject: FAILED: patch "[PATCH] serial: 8250_dw: handle reset control deassert error" failed to apply to 5.10-stable tree
To: a.shimko.dev@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Oct 2025 08:25:00 +0100
Message-ID: <2025102700-sleep-robotics-c9e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x daeb4037adf7d3349b4a1fb792f4bc9824686a4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102700-sleep-robotics-c9e3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


