Return-Path: <stable+bounces-98627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3DA9E493A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8CD283EEA
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3082144A0;
	Wed,  4 Dec 2024 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7bgI0sJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D22144C1;
	Wed,  4 Dec 2024 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354931; cv=none; b=cVVjKW1qzGT+dcnB4SGvf23ivrJKJGQUVYz+/pyEZfuRhZ0ew1CkT1E7TUebUn0FyNFZgN6QzSk3kinp3D7MKzKXG45MD7Q07zoLK0I2Dmqul355Fs1nTaFKE1VWr/gd/wERQGG0nceBweYyjoikw8tY7Rn6bBN3SzgzS0/1X8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354931; c=relaxed/simple;
	bh=aMyVwZKE/J+HTyLBtwcw66qT0e9TcG3WljKc+1MM2Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5NhnYRnqpN2KC2XIU15xypKGYWcFIkXOh8D+Us3gVFe3RV1sW4Y3+P/hKJj0+NrsMTSN//CotWiZBFkGvAv6D5sL5kpreuadCt/6hL0xAhOWGu374BH0GdH/55y9RhzVBA6Hn2VTxVf+dEwj0e5h1VqEuxtPErmqtG0dqOas9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7bgI0sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10986C4CED2;
	Wed,  4 Dec 2024 23:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354931;
	bh=aMyVwZKE/J+HTyLBtwcw66qT0e9TcG3WljKc+1MM2Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7bgI0sJH/wxgqFX4UnbXVMtol85dEL0ekijScri1ecpTid90E69i9M2c4Iexop9q
	 6MGqnGy5s3/03DYo0/Yeth6zIBA8Bm2nwKjwhgMmu4f/F1YhW5HqVK3VqBz/uNFeED
	 pjMkThDFDqG1/XRrETwf6JS268gjIn8d3UOWvTerWCEx9Fyk1I9chsc7uerAMekqP1
	 O+zzOiucJ8EkWsZ6GFiKoGX4J51yEmxNSRaK4e7pJvo78lchJKQ3YL1K6ciW3uAcdE
	 csIFNXbN/D5Q1YO6E6hoC3slAXhmFXbve5/ldXGfaD5fBbB9rn+LisI5QxT34D0I7T
	 VWUVSaVZ78j+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 04/15] usb: chipidea: udc: handle USB Error Interrupt if IOC not set
Date: Wed,  4 Dec 2024 17:16:58 -0500
Message-ID: <20241204221726.2247988-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221726.2247988-1-sashal@kernel.org>
References: <20241204221726.2247988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 548f48b66c0c5d4b9795a55f304b7298cde2a025 ]

As per USBSTS register description about UEI:

  When completion of a USB transaction results in an error condition, this
  bit is set by the Host/Device Controller. This bit is set along with the
  USBINT bit, if the TD on which the error interrupt occurred also had its
  interrupt on complete (IOC) bit set.

UI is set only when IOC set. Add checking UEI to fix miss call
isr_tr_complete_handler() when IOC have not set and transfer error happen.

Acked-by: Peter Chen <peter.chen@kernel.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20240926022906.473319-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index f0fcaf2b1f334..fd6032874bf33 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -2217,7 +2217,7 @@ static irqreturn_t udc_irq(struct ci_hdrc *ci)
 			}
 		}
 
-		if (USBi_UI  & intr)
+		if ((USBi_UI | USBi_UEI) & intr)
 			isr_tr_complete_handler(ci);
 
 		if ((USBi_SLI & intr) && !(ci->suspended)) {
-- 
2.43.0


