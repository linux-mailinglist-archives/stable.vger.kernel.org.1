Return-Path: <stable+bounces-164658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA6B110BB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E542587338
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908A2ECD1B;
	Thu, 24 Jul 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="fkNti+E8"
X-Original-To: stable@vger.kernel.org
Received: from smtp112.iad3b.emailsrvr.com (smtp112.iad3b.emailsrvr.com [146.20.161.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A742EBB81
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381032; cv=none; b=QgdRwAI0eSiZ7aBC2i2iw8wuth4uONPUDnOLpovQJroHIbY0SrKWk5vdCAec1921Gp13Zn1CvlO9h4S4yI5SphvxuBJva8Wzl4xv1eC8GJmDafaZEFPcmxev8gA9YzdGsaYGBmYuf39PSpUitiFm8BJyh+d8iwnDMc+Cc/mWPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381032; c=relaxed/simple;
	bh=wFrrcK1j/3tlBW0ozY33Xh9T3AQnbUAewBabrxgaNVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6PK4QbnmcRQdNma7fBXZCy2oY4+YZX4Z6ocn0C4KuXZLg+qNjj7aDtlWB2st1A154ozEIm2QYo2JEezh8M96KJ1I9uwViAY/FZWByLxrYBO+eqUN7C1zS3+rydgauOhCKCoAY3C/VusclSP0nYn7rp5ObwNc8nEETXRDcHxMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=fkNti+E8; arc=none smtp.client-ip=146.20.161.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381024;
	bh=wFrrcK1j/3tlBW0ozY33Xh9T3AQnbUAewBabrxgaNVg=;
	h=From:To:Subject:Date:From;
	b=fkNti+E8R7AA+nVqGfc0cYZRcRAR3bU2MVmCirKkPg6yEb/rcT9NgOL9HnNy+Ar3I
	 ykNcnKeWySJrdSjsVWmJAenalhAEOFuhGZCrsq7FZNFJlRA6ZUS7jnQ8PCfU/QStnQ
	 Wb2oc47xHQLn8SNFbvuTGIostKRHdp1wZsXOX4Lo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D2F2E6011F;
	Thu, 24 Jul 2025 14:17:03 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: aio_iiro_16: Fix bit shift out of bounds
Date: Thu, 24 Jul 2025 19:16:42 +0100
Message-ID: <20250724181646.291939-5-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: d9dea1d7-0c3d-4a32-a1eb-78b88e148596-5-1

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
---
 drivers/staging/comedi/drivers/aio_iiro_16.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/aio_iiro_16.c b/drivers/staging/comedi/drivers/aio_iiro_16.c
index fe3876235075..60c9c683906b 100644
--- a/drivers/staging/comedi/drivers/aio_iiro_16.c
+++ b/drivers/staging/comedi/drivers/aio_iiro_16.c
@@ -178,7 +178,8 @@ static int aio_iiro_16_attach(struct comedi_device *dev,
 	 * Digital input change of state interrupts are optionally supported
 	 * using IRQ 2-7, 10-12, 14, or 15.
 	 */
-	if ((1 << it->options[1]) & 0xdcfc) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0xdcfc) {
 		ret = request_irq(it->options[1], aio_iiro_16_cos, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
-- 
2.47.2


