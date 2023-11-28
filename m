Return-Path: <stable+bounces-3075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A63A7FC80E
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B45B21736
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5446BBE;
	Tue, 28 Nov 2023 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PQPg8MN/"
X-Original-To: stable@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F091BE6;
	Tue, 28 Nov 2023 13:35:40 -0800 (PST)
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 17E966606F5E;
	Tue, 28 Nov 2023 21:35:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701207339;
	bh=Q18yxCAMZdN7nqiu9m/OAbtpx24RwZE3q1MsbEWOa8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQPg8MN/oxUvLf3w9cigr+CJprQ51vuDvEvd7dBzVyh2GmC768EDHjK34zK12p2pg
	 MWM0fgDPctMPdp8qmtZEXizuZ0N/9r4Sx80Ftv2JaDuGw9h1E0QHEi5ruHYXxVgFNO
	 Nlr6k+GgQeNIMGML0bjvpp/NnVVFnzUGEPGb0JaQJn9ZnSZPfD85c/qOTLcLB99rFk
	 KiUtXt+7u66CbkWmOvFDmufFLSe4FNwlahCURVjY/PZR6BFT70ILoN52NctfvN+H/2
	 2yElwtwyghTzgPNBkZ3orF8iQ1L5q0DvwaNBAC1h1mPHIzBZ7LZQY5oVBdS8ExwjOW
	 +WlSqvvisScSQ==
Received: by beast.luon.net (Postfix, from userid 1000)
	id 4C16E9676CFC; Tue, 28 Nov 2023 22:35:37 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	kernel@collabora.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] bus: moxtet: Add spi device table
Date: Tue, 28 Nov 2023 22:35:05 +0100
Message-ID: <20231128213536.3764212-3-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128213536.3764212-1-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The moxtet module fails to auto-load on. Add a SPI id table to
allow it to do so.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Cc: stable@vger.kernel.org

---

(no changes since v1)

 drivers/bus/moxtet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 48c18f95660a..e384fbc6c1d9 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -830,6 +830,12 @@ static void moxtet_remove(struct spi_device *spi)
 	mutex_destroy(&moxtet->lock);
 }
 
+static const struct spi_device_id moxtet_spi_ids[] = {
+	{ "moxtet" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, moxtet_spi_ids);
+
 static const struct of_device_id moxtet_dt_ids[] = {
 	{ .compatible = "cznic,moxtet" },
 	{},
@@ -841,6 +847,7 @@ static struct spi_driver moxtet_spi_driver = {
 		.name		= "moxtet",
 		.of_match_table = moxtet_dt_ids,
 	},
+	.id_table	= moxtet_spi_ids,
 	.probe		= moxtet_probe,
 	.remove		= moxtet_remove,
 };
-- 
2.43.0


