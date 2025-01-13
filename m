Return-Path: <stable+bounces-108408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99796A0B499
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAEA7A5CAA
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B921ADB1;
	Mon, 13 Jan 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PsNq7F+n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83122AE44
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764132; cv=none; b=HBS9rGu1Xex2W86HS5Ib+NL1Jzj2yy2qCNBQPcTk4n2nzZ6EmrbF5NvW78TPJM0HeHJU6UdV87H5tevFJi+tSY1YnLec8A7zB+j5u0r1pLGALaz/7nn47qfqw8MHielUdDcqnF+gAcssMGmTlA+275ETsYNpijrq1ePn0R4GJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764132; c=relaxed/simple;
	bh=g7an6YS7fC3Qgq+UTPpD80Q4rS8XI3d76lIaH4h7d84=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B3VVA61hsDc9K7stbVOjBu+pTXrmVsvWjgELKV6hpAMTC/6CbLKIC17CLu0eELZbEvcoZFC01ebfHHauq62RLwS0E/k2Hj/KhM8O6tNX3d0UKx9EgxlvXgnQ+9kZrKMQtZsqzAlBE5hagkZjcKIL4AxM2DdehL6bRgnq0ToSqVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PsNq7F+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E60C4CED6;
	Mon, 13 Jan 2025 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736764132;
	bh=g7an6YS7fC3Qgq+UTPpD80Q4rS8XI3d76lIaH4h7d84=;
	h=Subject:To:Cc:From:Date:From;
	b=PsNq7F+ntcBz6n6O7lML6TlI23hXSACR7UvxOluCJNb8kV5h1LXBKoRmaPXSuW+qz
	 DYaOUOwobWBD65zz7m/y6NyloxneZTf2EBJSnBv9HyVqZwCS78QZo/Sa3Lgz2vMVK8
	 tnd7HmaCQRW+TPsHFhuVUwK/KWvHm7MpwVlg/LSM=
Subject: FAILED: patch "[PATCH] tty: serial: 8250: Fix another runtime PM usage counter" failed to apply to 6.1-stable tree
To: ilpo.jarvinen@linux.intel.com,bp@alien8.de,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:28:41 +0100
Message-ID: <2025011341-kisser-strained-c171@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ed2761958ad77e54791802b07095786150eab844
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011341-kisser-strained-c171@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


