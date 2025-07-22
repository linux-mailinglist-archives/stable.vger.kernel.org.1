Return-Path: <stable+bounces-163843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A577B0DBE9
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E321650B8
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E45A2EA491;
	Tue, 22 Jul 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V7b6ezS0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C62B9A5;
	Tue, 22 Jul 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192394; cv=none; b=ttSKp9RBqdILc8P7KWeIUcuJYqL3zNsIE8ZJYPAkn06FuhIIOb56xV4tL35rZGedQsG5CgaUVr5QTP+Ph4dJZqrSCsTdYxhWJa5XPwyCOTSVxynimkWsCLPaRgW6/dGo17S45JCNBXbQgYdwWhI4xWayEdkQAF6eszbdMhpAJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192394; c=relaxed/simple;
	bh=0K3xKkXoJ14GwvFi7HMsfidptH3vGbLlVFa2axNvgnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqWcx8hvYHsjg3iYFgzPzjpP0lrXk+ddorX8ZUKul5oCaTdRogxiZ3JHnaonJkHrwIwaBE0Oxo08X9t3AIXexBXISeb6or2SaRg+tDXu5asjqglQW4g8N/nhV0Jlnj3u0PWEG//AvWRqmedJIk/r/LuwyuKx2OAqMAHOorwbxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V7b6ezS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5661FC4CEF5;
	Tue, 22 Jul 2025 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192393;
	bh=0K3xKkXoJ14GwvFi7HMsfidptH3vGbLlVFa2axNvgnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7b6ezS0gr8knHN5StAnWKuvaJ3UQ7BqTOHOOP6zqOAx6WzIt/GdpAaiu4SOP/ufd
	 LRTk/Os6HneWYaWu4w8evHgGscdBVnGLPmw0uoMVev1+s8y0g5J92cbTMeg/xOTN9W
	 OBhUJrfaxoOG8qgNCvvtjqM87aSRJgrvHZ9L7OQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 6.6 052/111] comedi: aio_iiro_16: Fix bit shift out of bounds
Date: Tue, 22 Jul 2025 15:44:27 +0200
Message-ID: <20250722134335.322885086@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
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

From: Ian Abbott <abbotti@mev.co.uk>

commit 66acb1586737a22dd7b78abc63213b1bcaa100e4 upstream.

When checking for a supported IRQ number, the following test is used:

	if ((1 << it->options[1]) & 0xdcfc) {

However, `it->options[i]` is an unchecked `int` value from userspace, so
the shift amount could be negative or out of bounds.  Fix the test by
requiring `it->options[1]` to be within bounds before proceeding with
the original test.  Valid `it->options[1]` values that select the IRQ
will be in the range [1,15]. The value 0 explicitly disables the use of
interrupts.

Fixes: ad7a370c8be4 ("staging: comedi: aio_iiro_16: add command support for change of state detection")
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707134622.75403-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/aio_iiro_16.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/comedi/drivers/aio_iiro_16.c
+++ b/drivers/comedi/drivers/aio_iiro_16.c
@@ -177,7 +177,8 @@ static int aio_iiro_16_attach(struct com
 	 * Digital input change of state interrupts are optionally supported
 	 * using IRQ 2-7, 10-12, 14, or 15.
 	 */
-	if ((1 << it->options[1]) & 0xdcfc) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0xdcfc) {
 		ret = request_irq(it->options[1], aio_iiro_16_cos, 0,
 				  dev->board_name, dev);
 		if (ret == 0)



