Return-Path: <stable+bounces-164678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF140B110EE
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2906E7A7503
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DBE1FE461;
	Thu, 24 Jul 2025 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="eRcL0l1q"
X-Original-To: stable@vger.kernel.org
Received: from smtp75.iad3b.emailsrvr.com (smtp75.iad3b.emailsrvr.com [146.20.161.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F632B9B9
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381922; cv=none; b=OYT0Vfzy+c+H4AYT4a9srSe4JoJ6pZSog4DTs04DaYW4xsbaFimS7+FopSTBsQ3d9+mtq7H67Y1rOu48AtApNCJb1lE3JjMvnr58KGH5LWxEYEKii70CKt44ebsZFdCkBUtVCtr8hCeGJL6kmCqWFmwrgbkyyyj05ZUqbvFSVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381922; c=relaxed/simple;
	bh=wFrrcK1j/3tlBW0ozY33Xh9T3AQnbUAewBabrxgaNVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTU67X3VbpmKkKMvd/zjmXRc03PRUVpupdWpZRidX07XG5nNz2uZaNu8C3I2wR2TnUhlC/RtN73ScTqyURA1+Jh63oOzTNUHFbctSOy1gA+Zh2A8h5ayXZkziA3omRi84mEHxr5bBz1gCsdyZJSedRb4LS/c1Pt8Jdai4idYmsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=eRcL0l1q; arc=none smtp.client-ip=146.20.161.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753380808;
	bh=wFrrcK1j/3tlBW0ozY33Xh9T3AQnbUAewBabrxgaNVg=;
	h=From:To:Subject:Date:From;
	b=eRcL0l1qRB1FEKvXRoPoRgsCxbjcaOhnLRaKo18goQCQq4Z6QSsfhXK+QveeABD2J
	 pDO+f6tcGDcWevFYQiSu/NnYwxGHWhJhptWN0zOKYbAZfw0hTheAsa11fgfJcyabRC
	 0CsmyLm29DTVrESwX2YU1u3SkXQZl21eHt2kNaGs=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EED8DE01C9;
	Thu, 24 Jul 2025 14:13:27 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: aio_iiro_16: Fix bit shift out of bounds
Date: Thu, 24 Jul 2025 19:12:53 +0100
Message-ID: <20250724181257.291722-5-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724181257.291722-1-abbotti@mev.co.uk>
References: <20250724181257.291722-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: e379e1bc-6f74-4a9e-9d5c-30262cc57a91-5-1

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


