Return-Path: <stable+bounces-189928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1FAC0C1E1
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B218A258F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07B2DC34E;
	Mon, 27 Oct 2025 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ImeDa62q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427CC2DC32E
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549915; cv=none; b=kxJUP2/oYVULeE/KqFEaIAOilIStw4V5W/Puffte8HLSn+IMlfQG95Qjl38hZ2wR1+PWKm49IQSsbBhQf0TKYU0+e4+lWmYD3SFPD60P47CDxNmYz4y7rUnxymzrSh5xLcy/IoT9EZv2gOjs/l1CxA9BHrinrsrtJkrE1aruWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549915; c=relaxed/simple;
	bh=9FtKemEP0Ifj7ewKMC1xjYIi109L+NYjdmvbt0HOVdQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cElLn8PTXI1QQkGmj362SHDPs7fFGkOIK1F4xzVtuizY5TU6d0jojhkFNSpy9xUt95ke2wZ024Ij/83rSTi4+jgHNpib3x4PNE8p8HYhnYqNJ2QHkXdQPeY7ob/6Ymx3znRu0mKtgSvTzCvTaZoOBqQo/oaZadLQHSxgPK6pLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ImeDa62q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543B1C4CEF1;
	Mon, 27 Oct 2025 07:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761549914;
	bh=9FtKemEP0Ifj7ewKMC1xjYIi109L+NYjdmvbt0HOVdQ=;
	h=Subject:To:Cc:From:Date:From;
	b=ImeDa62qIh10MGnT6P3aS0W9twQuJnv6mMweQJkzkyJ6GrMXE7cFqXV6cvWlnLAWO
	 hYxh5fT/cCSHYpwrIcg3ZSoYjaRhRyJ0/2MO+9KPfoR1Q6Y+TgQbN09WsYBiidq/Tp
	 84XHWgt3UklUnPbObvF8M9+FcWPVlkXpF3WNa/HY=
Subject: FAILED: patch "[PATCH] serial: 8250_dw: handle reset control deassert error" failed to apply to 5.4-stable tree
To: a.shimko.dev@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Oct 2025 08:25:01 +0100
Message-ID: <2025102701-scabby-entrust-a162@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x daeb4037adf7d3349b4a1fb792f4bc9824686a4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102701-scabby-entrust-a162@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


