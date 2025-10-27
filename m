Return-Path: <stable+bounces-190401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E1C104EB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4DD24F8590
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F91331D393;
	Mon, 27 Oct 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvWWftMD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15DD32D0CE
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591204; cv=none; b=B0zxSWGI3efCTYGnpezTtFgAr/tJCXjh0pZufguiGGw6XQXWw/1hqLNEzSoGj+FiBmpk7HtqEg5r/hmbJU8T5iFFy9ZryC1yToS1xLuluaqsJujyUd38/2ETvKylon+xPDzo/j+kJjj6ATQx3dXEe6DL8YIK6pdLlxF/bMesfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591204; c=relaxed/simple;
	bh=t4qJma7uIjoy74DpEVdep1mKe+dYyibkekKPQqoiTyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhEPova9wFITlIZ57IZmYHyNg9Dnxsegn+O7bWTqM8889BGYGHgLtZ9cW597W1LWib3HE552eZ/wNftEXywkFsfRYAZaZ1ZhlGiz03lQaxp2K0myfkq51Pogfnu8r7MsQ0nRO7TbjGgK/CkRf6G7j5J1s0GuepeX1ysOF5Mv6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvWWftMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280A5C4CEFD;
	Mon, 27 Oct 2025 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761591203;
	bh=t4qJma7uIjoy74DpEVdep1mKe+dYyibkekKPQqoiTyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvWWftMDTckPQwxRXbfnpEm2QoGR7doJORaubV1k6VGPZVwsfpvxonHjhpuv9YNMD
	 cD67tjrViD9M4FnYg5QLJ3sX0pL2NHhYOMqPEGUbhz87W8bbe5AbWEdKzlDure9hYO
	 olh9N9CjUAOUX4FSZBRSPhYFsraJuVm329irTjodNDo02KMfySqiYpAdoeQTJPDgLR
	 KZd6mfbJ+7kYAzUaXzBt6opC/2fRkuEc2ZQNKeZDU51WSA1mKhO9SHylvRbbTprk64
	 zEWNcx84oY8K7t3+IOj2Kyj5aiB0/rMvE2LL7ADINH/7vbqllKN+t3VSlqbpp2rR7p
	 iUzKPpojlUDxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] serial: sc16is7xx: remove unused to_sc16is7xx_port macro
Date: Mon, 27 Oct 2025 14:53:18 -0400
Message-ID: <20251027185321.644316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102739-fable-reroute-e6a6@gregkh>
References: <2025102739-fable-reroute-e6a6@gregkh>
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
index 63573ef8b9142..a187ae217fc4c 100644
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


