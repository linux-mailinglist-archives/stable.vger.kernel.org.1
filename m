Return-Path: <stable+bounces-237334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMtAFTgi3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:04:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B43F0AA4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2747830949CB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF2A3191D0;
	Mon, 13 Apr 2026 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sIgAOZVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22B31717C;
	Mon, 13 Apr 2026 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099186; cv=none; b=MHL+gHch8txDzya5GYB5U9Rrro7rJ3wxn8QnCn5DsNtO8bV6yeBBQLSnPTchL+6g165UGeP2QPS6xk2VUQOvD8g9h+5uIgCKJtUaMwJ3zDK8u3RgBjLjCJftcDlJQ+Iv8Y1eWYeUOY9iEtbN0xxvQGZk8QeouPIBSYWUb+tOjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099186; c=relaxed/simple;
	bh=gaG8/XDc9C83WVC6xS46X/6afRh4nahWGnPog6uqFoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mt3GI/bDPgGiyeryX5Na+rbT2T0XFrpe/1jelUlqlGYUoeXOVv2iP9iRAzsxHmv6qJCMDb7jkCFptS4gzflNM8wISrIdoe0oVfRLGIMC/vkFA3xII1KkhiKaE58W/EaAIeq90vCB+F0P4zNSg9aYq9aYKj7PZa0VKXwCnyZ54Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sIgAOZVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A87C2BCB6;
	Mon, 13 Apr 2026 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099186;
	bh=gaG8/XDc9C83WVC6xS46X/6afRh4nahWGnPog6uqFoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIgAOZVtYAOONA3RkXWWahUQvYsCvqmZErggdV7AqX48NczQVSb0qWkNTUt+I+mpM
	 Nt5Hzsd+XKbVuYorTFodHd3WZRvkFOtMhAPBSudC9RviQDcYeH6AXhmv/SuoCW4F5E
	 7KahyPXQdC2QBQjZjm+mNgWMfgoXXKbbdRjxExNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Romain Sioen <romain.sioen@microchip.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 242/491] HID: mcp2221: cancel last I2C command on read error
Date: Mon, 13 Apr 2026 17:58:07 +0200
Message-ID: <20260413155828.117045238@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237334-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: E91B43F0AA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Romain Sioen <romain.sioen@microchip.com>

[ Upstream commit e31b556c0ba21f20c298aa61181b96541140b7b9 ]

When an I2C SMBus read operation fails, the MCP2221 internal state machine
may not reset correctly, causing subsequent transactions to fail.

By adding a short delay and explicitly cancelling the last command,
we ensure the device is ready for the next operation.

Fix an issue where i2cdetect was not able to detect all devices correctly
on the bus.

Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-mcp2221.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 589f13ff0b606..9fb98c8e1ffb7 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -319,6 +319,8 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 				usleep_range(90, 100);
 				retries++;
 			} else {
+				usleep_range(980, 1000);
+				mcp_cancel_last_cmd(mcp);
 				return ret;
 			}
 		} else {
-- 
2.51.0




