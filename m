Return-Path: <stable+bounces-89643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCC09BB1F5
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123DA284B73
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62871D1F63;
	Mon,  4 Nov 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiPYW3CL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B01B85FA;
	Mon,  4 Nov 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717575; cv=none; b=HPwvI71254i1PBqFsiXEotM2G/aACkiSeGHSYCyIBXNUaG88yhq0C2e/jdQ91bBBR6JGH2va0IUg668SuGpo04RUpqmr0PuKvmZ7GnpgorxvDvj4YLlahATV4AY+zjCUDNyEEr+kMA97nce7G9W20E4Ajd4TlbRQNrfY/68iUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717575; c=relaxed/simple;
	bh=W1q0XuIGZT0Uu6QYu/enQNtoSs+CtNsNCwXFGna+awg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWISqEDbENVhTQQgKZhw+jJ0E36HdCNwR2SgSpEsDYV67cNTO/Y2GbJsR139eySvUKPk/TYClxAbLVjBTwqi5xNpz7ZKeRvrVP5m7OX+EakZsHDbhD5qQF4rEEl8IENUjEWNMN4x6ddf2AlOuUWjV8WPTT2WMUWFZxMx68SZN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiPYW3CL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C4FC4CED2;
	Mon,  4 Nov 2024 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717575;
	bh=W1q0XuIGZT0Uu6QYu/enQNtoSs+CtNsNCwXFGna+awg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiPYW3CLEpbr6EmGzanwJd3WLn3dcRw6xv/d0Rp1U7HN1v8oEI5CqXMgIOvg+Qr3F
	 5jIXBQ5Rxuh6wVa9u837l/vZwfJip0ZYUM68Zwn2H+eojIQs95bguVrVSCG6BMsPFl
	 0ocaXXuyRsKI7zN9hsiIIZMbDR4sRrqUGQT2RKCDH67c0toLYd4bZmPlTHDJbT1MK3
	 i2avC3dddpx2TgQJOGQR1qvA106cJ2E7DNeLh1AswG8OVCHZ7aW0WojRYqQ/m/GA43
	 a9qyFhs1pxee94IUseFPCRSHNLvc528R0IBUlvCmYlx8XR7QbUP+IpNlpDvoJHasje
	 zsVAi7raOOTHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/14] usb: typec: use cleanup facility for 'altmodes_node'
Date: Mon,  4 Nov 2024 05:52:01 -0500
Message-ID: <20241104105228.97053-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
Content-Transfer-Encoding: 8bit

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit 1ab0b9ae587373f9f800b6fda01b8faf02b3530b ]

Use the __free() macro for 'altmodes_node' to automatically release the
node when it goes out of scope, removing the need for explicit calls to
fwnode_handle_put().

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20241021-typec-class-fwnode_handle_put-v2-2-3281225d3d27@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/class.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 79cad8d61dacd..00e7b095adcc0 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2147,14 +2147,16 @@ void typec_port_register_altmodes(struct typec_port *port,
 	const struct typec_altmode_ops *ops, void *drvdata,
 	struct typec_altmode **altmodes, size_t n)
 {
-	struct fwnode_handle *altmodes_node, *child;
+	struct fwnode_handle *child;
 	struct typec_altmode_desc desc;
 	struct typec_altmode *alt;
 	size_t index = 0;
 	u32 svid, vdo;
 	int ret;
 
-	altmodes_node = device_get_named_child_node(&port->dev, "altmodes");
+	struct fwnode_handle *altmodes_node  __free(fwnode_handle) =
+		device_get_named_child_node(&port->dev, "altmodes");
+
 	if (!altmodes_node)
 		return; /* No altmodes specified */
 
-- 
2.43.0


