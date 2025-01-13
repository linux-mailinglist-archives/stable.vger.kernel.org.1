Return-Path: <stable+bounces-108409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EC2A0B49B
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29CF3A3C84
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DAA22AE65;
	Mon, 13 Jan 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bybcn/6a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39C21ADC8
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764136; cv=none; b=Z7d2c4GFvwRMEV5ga24bt4gX20AvcAPFw6OwDu7qU3J8Jgq+gqIAFwpGifZfTHjktIsqkpHG6kYOAFStQDsNwSFRPY0XVKy+fvNnQqGYokr68Dnz06zamJtB4DQF3URz0DofyrR6SngqqiompzuQRtGn/gr1YwASazVFIPJxW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764136; c=relaxed/simple;
	bh=rq2q+Tg7d1QJK7Sg0hvTiSAiBfhSiQmnS5L3+Gix+u4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V13wqBFNfOsrFnQ+1ZRqEmC06A+qzfth2Mxm9nA62aoPDME85xJqiEyyOJ8shI3s97vh7KIm4QHEVeL3DTaGsLut8GAKQj6StjNKaFSVirgTHo8vaj1L4hOH+Dc79XdB+zUdVEb3foWfnZVFhDRB7IzBLJq/lzSyloCueniLB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bybcn/6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892ECC4CED6;
	Mon, 13 Jan 2025 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736764136;
	bh=rq2q+Tg7d1QJK7Sg0hvTiSAiBfhSiQmnS5L3+Gix+u4=;
	h=Subject:To:Cc:From:Date:From;
	b=bybcn/6aABV0yxF5/CG/y3Ot7EO+wCS7TPrU8KZhEnbKk4F2gLXVNZZp+9jTuq8X5
	 ztcjMb3aXZ6YYRHu4xDp1L0AXo6AbZeT0VNYeqC6hbw8mHj4V7gkvCOqspyq6ixgSd
	 p0nQx5imAGk0olhUyUuDmV6jg9kxOBUiubsXKlpQ=
Subject: FAILED: patch "[PATCH] tty: serial: 8250: Fix another runtime PM usage counter" failed to apply to 5.15-stable tree
To: ilpo.jarvinen@linux.intel.com,bp@alien8.de,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:28:41 +0100
Message-ID: <2025011340-empirical-actress-7e43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ed2761958ad77e54791802b07095786150eab844
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011340-empirical-actress-7e43@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed2761958ad77e54791802b07095786150eab844 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Dec 2024 19:01:20 +0200
Subject: [PATCH] tty: serial: 8250: Fix another runtime PM usage counter
 underflow
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit f9b11229b79c ("serial: 8250: Fix PM usage_count for console
handover") fixed one runtime PM usage counter balance problem that
occurs because .dev is not set during univ8250 setup preventing call to
pm_runtime_get_sync(). Later, univ8250_console_exit() will trigger the
runtime PM usage counter underflow as .dev is already set at that time.

Call pm_runtime_get_sync() to balance the RPM usage counter also in
serial8250_register_8250_port() before trying to add the port.

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Fixes: bedb404e91bb ("serial: 8250_port: Don't use power management for kernel console")
Cc: stable <stable@kernel.org>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20241210170120.2231-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 5f9f06911795..68baf75bdadc 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -812,6 +812,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			uart->dl_write = up->dl_write;
 
 		if (uart->port.type != PORT_8250_CIR) {
+			if (uart_console_registered(&uart->port))
+				pm_runtime_get_sync(uart->port.dev);
+
 			if (serial8250_isa_config != NULL)
 				serial8250_isa_config(0, &uart->port,
 						&uart->capabilities);


