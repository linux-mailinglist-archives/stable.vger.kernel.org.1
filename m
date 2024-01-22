Return-Path: <stable+bounces-12748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8359083727A
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2261EB28D56
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1541203;
	Mon, 22 Jan 2024 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VchzTaeU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC83D991
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949351; cv=none; b=OXoaE9xNbISXlUgYn5hFSZk6JQ0DToNztpcVb0tckxmINrHZw2SFkhI0RqwHmjktSyyFurBdmA4SFtTlLDU0dDvvZ6zSWxkiVMnFhujx80UsiwYKg0e/HqYwDi/jZQ00kNNBk8HxVt8IkPjlxKEa3X9u7f8hC6avJQBkysl2byE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949351; c=relaxed/simple;
	bh=gHGoMtIseba54fVKe98nqv6nMqzJxO//oX/D1uOkb4k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c6XzFcpD1jO2UgklQs2emVS+Flj4ZKZyCkeYFo+gpgt43hWvet7jFGNv2+9UZI7i9jB1r4H3dnk6iV7v6EZG84ct1AMQ0B8lfrfKeVH08eYHLP2VwYnf81db8DBUqUk7xTznBHgv/A+bzrTRtLVRdw+TXwJ+D9IK4iewpSjOOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VchzTaeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C77C433C7;
	Mon, 22 Jan 2024 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705949351;
	bh=gHGoMtIseba54fVKe98nqv6nMqzJxO//oX/D1uOkb4k=;
	h=Subject:To:Cc:From:Date:From;
	b=VchzTaeUKggpdZEB5YH4M5dxFbtFqWhca9oE+id3svI3U6zsNh8+woWeje8CPs4y7
	 WE8HfY51cTDJvlBUA7CZoz0fcbC8cLcAJ6LDJc4yXi6dae2UwWwc/B4e0n0nyAi0GQ
	 qKxjf5KsIDnig6mR1hDAp+uRMyDEBFvyneDE5twM=
Subject: FAILED: patch "[PATCH] serial: core: set missing supported flag for RX during TX" failed to apply to 6.6-stable tree
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:48:43 -0800
Message-ID: <2024012243-scorch-bundle-08dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1a33e33ca0e80d485458410f149265cdc0178cfa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012243-scorch-bundle-08dd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

1a33e33ca0e8 ("serial: core: set missing supported flag for RX during TX GPIO")
7cda0b9eb6eb ("serial: core: Simplify uart_get_rs485_mode()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1a33e33ca0e80d485458410f149265cdc0178cfa Mon Sep 17 00:00:00 2001
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date: Wed, 3 Jan 2024 07:18:13 +0100
Subject: [PATCH] serial: core: set missing supported flag for RX during TX
 GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the RS485 feature RX-during-TX is supported by means of a GPIO set the
according supported flag. Otherwise setting this feature from userspace may
not be possible, since in uart_sanitize_serial_rs485() the passed RS485
configuration is matched against the supported features and unsupported
settings are thereby removed and thus take no effect.

Cc:  <stable@vger.kernel.org>
Fixes: 163f080eb717 ("serial: core: Add option to output RS485 RX_DURING_TX state via GPIO")
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Link: https://lore.kernel.org/r/20240103061818.564-3-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8d381c283cec..850f24cc53e5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3649,6 +3649,8 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (IS_ERR(desc))
 		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-gpios\n");
 	port->rs485_rx_during_tx_gpio = desc;
+	if (port->rs485_rx_during_tx_gpio)
+		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;
 
 	return 0;
 }


