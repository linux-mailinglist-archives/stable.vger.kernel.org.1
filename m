Return-Path: <stable+bounces-68268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226C695316D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F900B23E22
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589251A00EC;
	Thu, 15 Aug 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8CJ6TR4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A3F1A00D6;
	Thu, 15 Aug 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730028; cv=none; b=bm5w/p1Sj3GCC5kr/IukegW4uT8sA+9trlM8JkByfPZsKabIzNHKs93wJ0e7kstWJjDS+S1LNKvHCCi0pGzrdNBEBeVilJHlYHYCmKLggfjteG+sfNYstlto+IIT6u8vVyaqWp9JXUZ2ZVbuHrGZCG2R8TEZP2bqXHujuWd/+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730028; c=relaxed/simple;
	bh=vWx2AoPmIkoDIRSzObZIuJ1vksIK6ZTTc7xDmQScHxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsHd4oS+AGiqYU0mKnTl3b19VTXMm+kyeXJqDTPdbR6IdYgWhnQvwj9XZWUEyfwC1oHEY+wOnK3TUyMGo8FA5fIIUohXHYTT6o4ix9lbjHB1KkY74ZgvriED3UaC+QC9qw8aQCKuTI5tunovd8/fkoHN7sMyYZppnLqEum/ymBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M8CJ6TR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803BFC32786;
	Thu, 15 Aug 2024 13:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730028;
	bh=vWx2AoPmIkoDIRSzObZIuJ1vksIK6ZTTc7xDmQScHxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8CJ6TR4UJqHaSHUvgz+d37iYGAYnTy0JosOB/JUXj7LuteJESNSfRSUqU3Z3pepC
	 qdhKMUYeX8hMdOtUxFc8O1FiZ1LOyDItcASxSQYGAsKmThdqHhOzHFHqhEGsedWLiv
	 rpXLar/M4OjdGXVlQVp8Mdl4tyNipt2tawmEexR4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 282/484] spi: spidev: Make probe to fail early if a spidev compatible is used
Date: Thu, 15 Aug 2024 15:22:20 +0200
Message-ID: <20240815131952.301252936@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Javier Martinez Canillas <javierm@redhat.com>

[ Upstream commit fffc84fd87d963a2ea77a125b8a6f5a3c9f3192d ]

Some Device Trees don't use a real device name in the compatible string
for SPI devices nodes, abusing the fact that the spidev driver name is
used to match as a fallback when a SPI device ID table is not defined.

But since commit 6840615f85f6 ("spi: spidev: Add SPI ID table") a table
for SPI device IDs was added to the driver breaking the assumption that
these DTs were relying on.

There has been a warning message for some time since commit 956b200a846e
("spi: spidev: Warn loudly if instantiated from DT as "spidev""), making
quite clear that this case is not really supported by the spidev driver.

Since these devices won't match anyways after the mentioned commit, there
is no point to continue if an spidev compatible is used. Let's just make
the driver probe to fail early.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://lore.kernel.org/r/20211109225920.1158920-1-javierm@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: fc28d1c1fe3b ("spi: spidev: add correct compatible for Rohm BH2228FV")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spidev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 922d778df0641..75eb1c95c4a04 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -760,9 +760,10 @@ static int spidev_probe(struct spi_device *spi)
 	 * compatible string, it is a Linux implementation thing
 	 * rather than a description of the hardware.
 	 */
-	WARN(spi->dev.of_node &&
-	     of_device_is_compatible(spi->dev.of_node, "spidev"),
-	     "%pOF: buggy DT: spidev listed directly in DT\n", spi->dev.of_node);
+	if (spi->dev.of_node && of_device_is_compatible(spi->dev.of_node, "spidev")) {
+		dev_err(&spi->dev, "spidev listed directly in DT is not supported\n");
+		return -EINVAL;
+	}
 
 	spidev_probe_acpi(spi);
 
-- 
2.43.0




