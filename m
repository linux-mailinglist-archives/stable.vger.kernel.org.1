Return-Path: <stable+bounces-178414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CCBB47E90
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26506189FEE7
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549E9212B2F;
	Sun,  7 Sep 2025 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eme1GIfa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A68D528;
	Sun,  7 Sep 2025 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276760; cv=none; b=N9Ff8qaiIMTNxRCukZhxrJUQRbqAkxH+rhV/iTjetXXYn5bj+WeTgP7GiXxv8Nvv20RL58Z0K5MRrmtlY/6M5ijWp/zc1zP7ZzvAQ5LIWrsAMcukKg7pNBTa7lveD33QWfzowHKN2cFsEY+zjVA+WjgTcl29ZBoaRpame5L/V9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276760; c=relaxed/simple;
	bh=vIXZZ/kaHL3g7jghCmhJ/nNZ4cvSZ5WyrF7/+FdDYgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6s3xbEwd/c/k2pqPqB5nm0f5vKtxGg4ZwSyvllFTnHw1rn0uWKwtv4Gnr/mv0jyJWFIPlrA6dhJBdMk7L0ml1kQOcPEcpOhBcrEhWIsI95cDtwNWIu1F4ESjkOkmajD4GBEycBgYxpxVCC7dNBdlvCpIQg9VDrQGT1TA3jYktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eme1GIfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85182C4CEF0;
	Sun,  7 Sep 2025 20:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276759;
	bh=vIXZZ/kaHL3g7jghCmhJ/nNZ4cvSZ5WyrF7/+FdDYgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eme1GIfa/Tepua3R43Oii8cFIDGh51/TWqXTDBIRfIDUQkgWj2pWLrhUBoPgQcT5F
	 eZtxUn3oMX8GQ0ONbvFBIwU8HSCswl4+UEPZKuLfSlNxXJkEZq2tdtMS4Zls4Hld+g
	 YRGuid8wYKunkrG3F0pMyahcHQy1dC88TsTld00c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 6.6 054/121] pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()
Date: Sun,  7 Sep 2025 21:58:10 +0200
Message-ID: <20250907195611.217385052@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 44822df89e8f3386871d9cad563ece8e2fd8f0e7 upstream.

In __iodyn_find_io_region(), pcmcia_make_resource() is assigned to
res and used in pci_bus_alloc_resource(). There is a dereference of res
in pci_bus_alloc_resource(), which could lead to a NULL pointer
dereference on failure of pcmcia_make_resource().

Fix this bug by adding a check of res.

Cc: stable@vger.kernel.org
Fixes: 49b1153adfe1 ("pcmcia: move all pcmcia_resource_ops providers into one module")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pcmcia/rsrc_iodyn.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/pcmcia/rsrc_iodyn.c
+++ b/drivers/pcmcia/rsrc_iodyn.c
@@ -62,6 +62,9 @@ static struct resource *__iodyn_find_io_
 	unsigned long min = base;
 	int ret;
 
+	if (!res)
+		return NULL;
+
 	data.mask = align - 1;
 	data.offset = base & data.mask;
 



