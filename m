Return-Path: <stable+bounces-198104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ECAC9BFCD
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 16:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F201C349080
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613628A1F1;
	Tue,  2 Dec 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rB3udiw4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754152727E6
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689900; cv=none; b=TBEcRxn8/oTZ2yAFBWq7b1G6fLoObkPVMWH3NFSVgzZFfBfeI6X9oi+uNvV3MRv1Rtv8bCbSmv1Bqj3WZQr8Hp5gOT9ahb+U5Cuxblpd5Vxu2lqkkrq5iiDwd/JHvspbOML5sd6KjxhphjxS4Fo1aIdt9XOPARTZrQPv/Fnr6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689900; c=relaxed/simple;
	bh=kYMBnut+RKfi3UCghCiDgWsCHGsjDV9JWsfsqkqa22Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VWh5joqjvQGGyN/aSG0FFhV8VfCVLKtHdZhqtqFTx6n+zrRIn0MoNEqL2VZOM0TkQtXG46cHCbMnXzNcHzdO+iZyPL7UK3LyrR4HRpyXZCTmJq48GMA74ejnhCflPFgV3AIWLpGL/kdfMTxP1GqRHCDrycQgZoj8xKSqENXnGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rB3udiw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD061C4CEF1;
	Tue,  2 Dec 2025 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764689900;
	bh=kYMBnut+RKfi3UCghCiDgWsCHGsjDV9JWsfsqkqa22Y=;
	h=Subject:To:Cc:From:Date:From;
	b=rB3udiw4L7N4rhm2wU+HxV7wlUfkxkBnVSfiZXV5b5o4enUOZTVIgOlm+kfurodfw
	 rtaeWQdCIEU3mvwMFf6ed/ncI2lJ5P4ATfz5qrj53hPsuWf1rfKmbEkV4NMUMt+XGQ
	 lnvmociijL3tzMHlLnVmTYy9+g5tvr+tdBTIdtWk=
Subject: FAILED: patch "[PATCH] net: dsa: microchip: Don't free uninitialized ksz_irq" failed to apply to 6.6-stable tree
To: bastien.curutchet@bootlin.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Dec 2025 16:37:58 +0100
Message-ID: <2025120258-cupid-regally-5bc2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 25b62cc5b22c45face094ae3e8717258e46d1d19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120258-cupid-regally-5bc2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25b62cc5b22c45face094ae3e8717258e46d1d19 Mon Sep 17 00:00:00 2001
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 20 Nov 2025 10:12:02 +0100
Subject: [PATCH] net: dsa: microchip: Don't free uninitialized ksz_irq

If something goes wrong at setup, ksz_irq_free() can be called on
uninitialized ksz_irq (for example when ksz_ptp_irq_setup() fails). It
leads to freeing uninitialized IRQ numbers and/or domains.

Use dsa_switch_for_each_user_port_continue_reverse() in the error path
to iterate only over the fully initialized ports.

Cc: stable@vger.kernel.org
Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Link: https://patch.msgid.link/20251120-ksz-fix-v6-3-891f80ae7f8f@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e684568a4eda..a927055423f3 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3082,7 +3082,7 @@ static int ksz_setup(struct dsa_switch *ds)
 			ksz_ptp_irq_free(ds, dp->index);
 out_pirq:
 	if (dev->irq > 0)
-		dsa_switch_for_each_user_port(dp, dev->ds)
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds)
 			ksz_irq_free(&dev->ports[dp->index].pirq);
 out_girq:
 	if (dev->irq > 0)


