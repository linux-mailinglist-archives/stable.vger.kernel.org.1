Return-Path: <stable+bounces-198730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3370C9FD16
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A862E3098F87
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9E834404D;
	Wed,  3 Dec 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOAWyKBi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3B3446C8;
	Wed,  3 Dec 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777496; cv=none; b=MHaIq3hJorPF4HaebwQKvLapFZzPzBWlZdQ7Fkc4fVP8ZoQ1wkbPSbru1v4oZmr3CdkEAI7PNE7CbvP1wzAJtaOgJ/BD+fy3wONN2kZYVasKDPD/Olw9xXtXWyBr1dkuCClZ+RwIfF8XBTuQeE4EkHI+0x2aPrFrLTcATHmqHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777496; c=relaxed/simple;
	bh=RklfoSLQDebRLrMgAwdP+coalvTP1p1NEqdlTNZiWZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGXaOaHWCf7HgmGpa8BPJMj3Ij6u28SgDFDWiCM+NgK+EteLcLb8C4JwFoW4tl68h9UHqlbZGdsbvM6WwR9FixrpLlfwpaxzIx1fWziWYpPY0jkBNkCynsv5BoenXi/mcrh7vRfos3b2E0sKANCPW5z2a0wr7HjZZCyXXSnm5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOAWyKBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893A4C116C6;
	Wed,  3 Dec 2025 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777495;
	bh=RklfoSLQDebRLrMgAwdP+coalvTP1p1NEqdlTNZiWZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOAWyKBi5HRpNhnL6FVWve0acXKw8HeMwd1qHkTeBuxvgEB2B/aabD5IpWEuPO6o9
	 JIyQnFY3RH71t1AuokJNJVeO55XhlKOgMIkddVsIbkTj23Zkro36i6l5fqhUmkHVfT
	 iQ3n1QLmhBQIaVleqSN7HiKb0zpnuopw3MAP1RuE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 055/392] spi: loopback-test: Dont use %pK through printk
Date: Wed,  3 Dec 2025 16:23:25 +0100
Message-ID: <20251203152416.138161687@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit b832b19318534bb4f1673b24d78037fee339c679 ]

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Link: https://patch.msgid.link/20250811-restricted-pointers-spi-v1-1-32c47f954e4d@linutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 89fccb9da1b8e..556118c931092 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -409,7 +409,7 @@ static void spi_test_dump_message(struct spi_device *spi,
 	int i;
 	u8 b;
 
-	dev_info(&spi->dev, "  spi_msg@%pK\n", msg);
+	dev_info(&spi->dev, "  spi_msg@%p\n", msg);
 	if (msg->status)
 		dev_info(&spi->dev, "    status:        %i\n",
 			 msg->status);
@@ -419,15 +419,15 @@ static void spi_test_dump_message(struct spi_device *spi,
 		 msg->actual_length);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		dev_info(&spi->dev, "    spi_transfer@%pK\n", xfer);
+		dev_info(&spi->dev, "    spi_transfer@%p\n", xfer);
 		dev_info(&spi->dev, "      len:    %i\n", xfer->len);
-		dev_info(&spi->dev, "      tx_buf: %pK\n", xfer->tx_buf);
+		dev_info(&spi->dev, "      tx_buf: %p\n", xfer->tx_buf);
 		if (dump_data && xfer->tx_buf)
 			spi_test_print_hex_dump("          TX: ",
 						xfer->tx_buf,
 						xfer->len);
 
-		dev_info(&spi->dev, "      rx_buf: %pK\n", xfer->rx_buf);
+		dev_info(&spi->dev, "      rx_buf: %p\n", xfer->rx_buf);
 		if (dump_data && xfer->rx_buf)
 			spi_test_print_hex_dump("          RX: ",
 						xfer->rx_buf,
@@ -521,7 +521,7 @@ static int spi_check_rx_ranges(struct spi_device *spi,
 		/* if still not found then something has modified too much */
 		/* we could list the "closest" transfer here... */
 		dev_err(&spi->dev,
-			"loopback strangeness - rx changed outside of allowed range at: %pK\n",
+			"loopback strangeness - rx changed outside of allowed range at: %p\n",
 			addr);
 		/* do not return, only set ret,
 		 * so that we list all addresses
@@ -659,7 +659,7 @@ static int spi_test_translate(struct spi_device *spi,
 	}
 
 	dev_err(&spi->dev,
-		"PointerRange [%pK:%pK[ not in range [%pK:%pK[ or [%pK:%pK[\n",
+		"PointerRange [%p:%p[ not in range [%p:%p[ or [%p:%p[\n",
 		*ptr, *ptr + len,
 		RX(0), RX(SPI_TEST_MAX_SIZE),
 		TX(0), TX(SPI_TEST_MAX_SIZE));
-- 
2.51.0




