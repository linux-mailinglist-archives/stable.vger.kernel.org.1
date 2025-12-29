Return-Path: <stable+bounces-204001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295BCE7982
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B74430492AA
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F9D330B31;
	Mon, 29 Dec 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/uA0Yf6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99733066C;
	Mon, 29 Dec 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025772; cv=none; b=C/px6MczNSv76ZR0MfevSeFV5pklVD6eJS1Q5SEP5PR/HGhQCYNOGU2L59OX0HUw3U3y8sMLB3nQ0pkp9qd3YH6IG5wZASg4R0v3In0Bd+DCFNUB7xLylpL0DwVRer2oUtWxgzDBWUzI9QM0NG0qSpH7UHhtoGdx8wC5oQtS7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025772; c=relaxed/simple;
	bh=Bpo4nFpIwTCNnZ2epJGLPnyxw7dazz22xkgsHGgDUXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Syr92sL1UU75IeRQf/fUcWV5M7m+6k9fjiYNeY3PGVwO83fDf3nI9PE2SVfqsWndXzjHmsf/L8JG6RO1tZPNbmYNhXIoUz+EIYcWKUtzBtdnVqzOEhVm9wP9IfJWqgrWdlibuuQCJ2EzJcQokUcer3gM/tP9P+5T1dlKqkrJi28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/uA0Yf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEC8C4CEF7;
	Mon, 29 Dec 2025 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025772;
	bh=Bpo4nFpIwTCNnZ2epJGLPnyxw7dazz22xkgsHGgDUXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/uA0Yf6iAvdvFaqlCJgQJcVljJ4MHS1lfVb17+qt2IMX7z3Z2aS9pB0DYg2gu4e/
	 owvlbE82Cq6D6+d7g1a3Wh8iwTLFlD0lKmD4dJv0SS4Zbc4mtPMyYb5q0uG8Z4/Xmn
	 pGSk7WRR6bCZN9HiVxe7p8tqbOqKlLPtwpg2CP94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 6.18 331/430] platform/chrome: cros_ec_ishtp: Fix UAF after unbinding driver
Date: Mon, 29 Dec 2025 17:12:13 +0100
Message-ID: <20251229160736.509098527@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tzung-Bi Shih <tzungbi@kernel.org>

commit 944edca81e7aea15f83cf9a13a6ab67f711e8abd upstream.

After unbinding the driver, another kthread `cros_ec_console_log_work`
is still accessing the device, resulting an UAF and crash.

The driver doesn't unregister the EC device in .remove() which should
shutdown sub-devices synchronously.  Fix it.

Fixes: 26a14267aff2 ("platform/chrome: Add ChromeOS EC ISHTP driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20251031033900.3577394-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/chrome/cros_ec_ishtp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -667,6 +667,7 @@ static void cros_ec_ishtp_remove(struct
 
 	cancel_work_sync(&client_data->work_ishtp_reset);
 	cancel_work_sync(&client_data->work_ec_evt);
+	cros_ec_unregister(client_data->ec_dev);
 	cros_ish_deinit(cros_ish_cl);
 	ishtp_put_device(cl_device);
 }



