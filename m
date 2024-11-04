Return-Path: <stable+bounces-89627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586C9BB1C0
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D351C21C52
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E01C4A1C;
	Mon,  4 Nov 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5l6FOV4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5881C4A0E;
	Mon,  4 Nov 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717487; cv=none; b=tNh5TTOrXAPemYh9rFYOoFW1njaIDemuUHibxvGDLWhjtWrY8kWsY85sZyoE13BrJEf5RQWpUfbQd0y6dL3d37lArlNqWWNNcsco/wMKR2cSCRaL4kMOJUyLDp7Gf1OZpohKw4IAXqGC1ilw8rFox1hW1O3LvX3UQ7WN1m7QZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717487; c=relaxed/simple;
	bh=ZhbeKWqnCYGhlnAaTqSjkmY5Fpob19aTol+nPNcs1/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGWaMQs/HCyZxj72NOHPCtHWi0mz9JsmhAb3orCkP9MGlp3UkWaYXhDsfDXnJSoniIujgAdfHJAK2IAo7sNzWz/+em+uHBSvs8MitrpAoeInjFT/n36rfav5wvrrKZlc2o9ezvUk0QDi3wbpJ/0LSMtxk7L6vhWR20seh/Sa2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5l6FOV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5106C4CED2;
	Mon,  4 Nov 2024 10:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717486;
	bh=ZhbeKWqnCYGhlnAaTqSjkmY5Fpob19aTol+nPNcs1/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5l6FOV42aqXB1Sv0/rDEyQ4m2oS5CWFZlSK+4EcFuWXlDmc4QC3lNBMVvFcZGLCT
	 w6o6q521OaMxqyzPoiCLF8QTSgiF9Y6DvbmjeK25crTZjJG06e8SZIJN8rXOX/UHn3
	 I4XIfJI82lcm3+kppe8VzAM8eWGvcdRBTsHTU+5px3zgFcUh6ny/Pc05ZT1c0PjRGh
	 5C39hgFYJKT+QcJSeDrg6ElEp1wj3G7NQ9SpbxbTN+uCTTwcNS8uvXQv2i1wtTWAZW
	 jQQfZl09XcHHvFmek0hSpEOqnMPQCMSoJv5t8LLeiJm9+mdnVcfCbpJhGRLg0rEEdY
	 9unVWPLa7pKUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 14/21] usb: typec: use cleanup facility for 'altmodes_node'
Date: Mon,  4 Nov 2024 05:49:50 -0500
Message-ID: <20241104105048.96444-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
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
index d61b4c74648df..58f40156de562 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2293,7 +2293,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 	const struct typec_altmode_ops *ops, void *drvdata,
 	struct typec_altmode **altmodes, size_t n)
 {
-	struct fwnode_handle *altmodes_node, *child;
+	struct fwnode_handle *child;
 	struct typec_altmode_desc desc;
 	struct typec_altmode *alt;
 	size_t index = 0;
@@ -2301,7 +2301,9 @@ void typec_port_register_altmodes(struct typec_port *port,
 	u32 vdo;
 	int ret;
 
-	altmodes_node = device_get_named_child_node(&port->dev, "altmodes");
+	struct fwnode_handle *altmodes_node  __free(fwnode_handle) =
+		device_get_named_child_node(&port->dev, "altmodes");
+
 	if (!altmodes_node)
 		return; /* No altmodes specified */
 
-- 
2.43.0


