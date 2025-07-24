Return-Path: <stable+bounces-164679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D52B110ED
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD283ACA27
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDBB20487E;
	Thu, 24 Jul 2025 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="a03UVU1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp87.iad3b.emailsrvr.com (smtp87.iad3b.emailsrvr.com [146.20.161.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036EC2B9B9
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381924; cv=none; b=iv01XpFDP0xXV1f19HvDaUelU2syNjFV+Da/lMIx6db4Ap8tgpHMQYS6z5RTY7mB5kNI7L55YNgu//9YfslAg/d4VA3yGAzYMS9HMHvXxJQIJ1YipXTjM6zKDp+XDt2z1UCqzj+2mD6v9lBX3oMsdbcfmBAfLwkh4YLibb3OjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381924; c=relaxed/simple;
	bh=4VFrwlqsYErXVczb16k9uYupKAwbM+u59219PEibJ78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Du54muk+pvb8vdpPs7ejfs9U/GchVzQitZTytf3jBWajprcB05T4L++Bj1voryO+4kUlU/qn7QUtKLyDEOSI39tEkReceA7lNemduQfiQcqbLEvM6/elkV5ITuf4NRKGapd5sf13vChgVdrwW42ldJg1H995SuDVgiyAXurcgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=a03UVU1V; arc=none smtp.client-ip=146.20.161.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381354;
	bh=4VFrwlqsYErXVczb16k9uYupKAwbM+u59219PEibJ78=;
	h=From:To:Subject:Date:From;
	b=a03UVU1VV3OKcvO5nV9ciusyPbcxLq8wN/TCsvl1m9aBQIyTrzEx+gl4S7EUGJyOG
	 ztDTWiZllTLbK/julY0aO9HZ4dVs8v9y4m95Q/DyGe3FB6fvr+4HSKmdcuvOjqcETI
	 WmhCBsWYjUyCtXviLy+/ZCtJoZXceNmCUa39rIx4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 197B240175;
	Thu, 24 Jul 2025 14:22:34 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] comedi: das6402: Fix bit shift out of bounds
Date: Thu, 24 Jul 2025 19:22:15 +0100
Message-ID: <20250724182218.292203-6-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 37f560bb-803e-4662-97aa-d3cd335e777b-6-1

[ Upstream commit 70f2b28b5243df557f51c054c20058ae207baaac ]

When checking for a supported IRQ number, the following test is used:

	/* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */
	if ((1 << it->options[1]) & 0x8cec) {

However, `it->options[i]` is an unchecked `int` value from userspace, so
the shift amount could be negative or out of bounds.  Fix the test by
requiring `it->options[1]` to be within bounds before proceeding with
the original test.  Valid `it->options[1]` values that select the IRQ
will be in the range [1,15]. The value 0 explicitly disables the use of
interrupts.

Fixes: 79e5e6addbb1 ("staging: comedi: das6402: rewrite broken driver")
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707135737.77448-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers/das6402.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/das6402.c b/drivers/staging/comedi/drivers/das6402.c
index 0034005bdf8f..0cd5d1b1ffde 100644
--- a/drivers/staging/comedi/drivers/das6402.c
+++ b/drivers/staging/comedi/drivers/das6402.c
@@ -569,7 +569,8 @@ static int das6402_attach(struct comedi_device *dev,
 	das6402_reset(dev);
 
 	/* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */
-	if ((1 << it->options[1]) & 0x8cec) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0x8cec) {
 		ret = request_irq(it->options[1], das6402_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {
-- 
2.47.2


