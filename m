Return-Path: <stable+bounces-187388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A59FBEA77A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE3E9483D3
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B785330B21;
	Fri, 17 Oct 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yTkHLT2s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FF330B11;
	Fri, 17 Oct 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715927; cv=none; b=uX0xiYU8TfGgyDZykrci/NKaFJv8aU3lnvwWYxnmi+wrsEw5DRPMSgcDudESpoTN2eEEAsZtXJhp4KDWwi5QTphB73W9Ci4lcVO05VGFqIBGgxSVU17rc56w3fVyW4FV9iA4Oji6nbOuNzIYop7uCMI0ni6q2TiZMh6hdDfEEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715927; c=relaxed/simple;
	bh=cV5lJ8jz7ajbLmn8IRCgc9exwQuS89fwMJpjcTEyoEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyVbddLxIF+/IeOMb5keOILKulOA7Ay+wnAoMhDL8FuGlQe2ITXpBwx6O9mI0POLL0n+tfoLxp/TETH4jKUUcNKCMcyYmSfDPqlc/HN9ZA72cYZACWRk6+ZpXmdoiOWrJhbHfhy6U0ezGLsy5c28FO2gZm0dZszkZgX9RmRwpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yTkHLT2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5CDC4CEE7;
	Fri, 17 Oct 2025 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715927;
	bh=cV5lJ8jz7ajbLmn8IRCgc9exwQuS89fwMJpjcTEyoEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yTkHLT2sUHtZVjN9yTvUMwnImGm03HjLEy1w64T2s6enrrfpDrFjq/J3fg6TcE3NY
	 P0jtLHsJTTY0VliKYyTifh5AxKMFXybxoXdKaqjNCSUureVGnyJWqoboRBcTya1ydB
	 Mylu5Je4+hfuDVa+qfREIhSyQ2MYwfVkhmawS688=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com,
	Arnaud Lecomte <contact@arnaud-lcm.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Romain Sioen <romain.sioen@microchip.com>
Subject: [PATCH 5.15 014/276] hid: fix I2C read buffer overflow in raw_event() for mcp2221
Date: Fri, 17 Oct 2025 16:51:47 +0200
Message-ID: <20251017145142.920827807@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaud Lecomte <contact@arnaud-lcm.com>

commit b56cc41a3ae7323aa3c6165f93c32e020538b6d2 upstream.

As reported by syzbot, mcp2221_raw_event lacked
validation of incoming I2C read data sizes, risking buffer
overflows in mcp->rxbuf during multi-part transfers.
As highlighted in the DS20005565B spec, p44, we have:
"The number of read-back data bytes to follow in this packet:
from 0 to a maximum of 60 bytes of read-back bytes."
This patch enforces we don't exceed this limit.

Reported-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
Tested-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Link: https://patch.msgid.link/20250726220931.7126-1-contact@arnaud-lcm.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-mcp2221.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -791,6 +791,10 @@ static int mcp2221_raw_event(struct hid_
 			}
 			if (data[2] == MCP2221_I2C_READ_COMPL ||
 			    data[2] == MCP2221_I2C_READ_PARTIAL) {
+				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 || data[3] > 60) {
+					mcp->status = -EINVAL;
+					break;
+				}
 				buf = mcp->rxbuf;
 				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
 				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];



