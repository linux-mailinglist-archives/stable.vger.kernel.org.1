Return-Path: <stable+bounces-190149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F6C10077
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923AF462C15
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF04320A33;
	Mon, 27 Oct 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIvQ3cje"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30633320A0D
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590569; cv=none; b=CrqFgAEqYGX6RDreM5Sd7aWJSVJ2GsGN3DFdF/YBHsWe3b7/JZa9HgpppM9yODSbsKubVJZ/5q5rLxL8Md4ZD/gXwqdfHz89nVGHoxq+moueDK3sGse3IMfdoQyuCXbNLMB0P0APq6Bg2v6Xe2/JtUZ6HsTYg6hFnQtNqzFaxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590569; c=relaxed/simple;
	bh=EKxwyn/d7HnFKrBgrdUjGIMxtqsZe/54qqcOYZmwSq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb5moDCpblP/U2fj7Fh4OSqnX0aMF8v30Jb/yur+Nd9lugWyus/k22coLgVW3ubztNI9BSqdF7VSPHtStYqDAxom6cDNiMHInNFZaKmcUUkQVzcjaFoPvWpgfOJ+AGNH5c4NJvBUmMKnQyYPLACEXwLe2qXEkVviTGhmvVVFta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIvQ3cje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7046CC116C6;
	Mon, 27 Oct 2025 18:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590569;
	bh=EKxwyn/d7HnFKrBgrdUjGIMxtqsZe/54qqcOYZmwSq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIvQ3cjeYKy9OqxxyAVbkEp1N6skNcH634rBzPanI8xOi+vcsMM0CKnwb21lO1MB4
	 ch24NLTXCo06EKe5liF3qYbp6oNKE5VvK7mEfCCvywb6+sqkEBqbCifIDy+kyzqpN5
	 6IY+T+GpdZVS54zYn9R7d/lCDpHx0oypKtTtdRWpX7kZS1kHaFUgJbGn/V0NNWpB6o
	 Dc3uvfcQ7qhazQDril5cNmhwFDFDRE6N8JmBCjMer93S6AUly2HoER2iUWp8IoV6Mb
	 5BPSgJNZ/NM3CqsoI6/Vx82YZNFmFDXLs/ccmsZqCHYqVWc1rDDFXwPE+FHlQ5juEn
	 /zIE3XlqyVdcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] serial: sc16is7xx: remove unused to_sc16is7xx_port macro
Date: Mon, 27 Oct 2025 14:42:43 -0400
Message-ID: <20251027184246.638748-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102739-casualty-hankering-f9ab@gregkh>
References: <2025102739-casualty-hankering-f9ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 22a048b0749346b6e3291892d06b95278d5ba84a ]

This macro is not used anywhere.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230905181649.134720-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1c05bf6c0262 ("serial: sc16is7xx: remove useless enable of enhanced features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 66a88bba8f15b..847ed5b155aad 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -358,7 +358,6 @@ static struct uart_driver sc16is7xx_uart = {
 static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
 static void sc16is7xx_stop_tx(struct uart_port *port);
 
-#define to_sc16is7xx_port(p,e)	((container_of((p), struct sc16is7xx_port, e)))
 #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
 
 static u8 sc16is7xx_port_read(struct uart_port *port, u8 reg)
-- 
2.51.0


