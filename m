Return-Path: <stable+bounces-43789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB48C4FA0
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA7281F69
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCDA12DD98;
	Tue, 14 May 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x79MeNQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE986CDC8;
	Tue, 14 May 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682239; cv=none; b=WJwjwgyDCYsH/s8XameU/4OLyNT9sbHPiZXKv2bqEnHYXDytyhQ/Y5AnBlzTCA1+eZfHhdwy97eckaBeLddakLO6rNwPf4DbLXXWkX4Hppscld8/Rz6sBG87I204uzxSZisreiBdkkLsnAdi5SU+dd8Rq3MvZZ1d0IprWeOcfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682239; c=relaxed/simple;
	bh=gzk43MCmfc1o6ogHGcWZ6/tSTjLJuG8dIjuNmP/PFFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJZ7Qcsd71LMah1BzZeDnpe20o+0ecVGgy9yR7Oxhryt4BOWlimtrFkuk1PceBUwwShk/28oY4YDRJPFnYFSmZWptSBT2uSQsvdpHxpy2eIwoyBwublevmZ1Pqc77ImMffLweJWd7N8NkbAJWkP4NBPwFLmDnK0LpmZE8Fc4ZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x79MeNQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D6EC2BD10;
	Tue, 14 May 2024 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682239;
	bh=gzk43MCmfc1o6ogHGcWZ6/tSTjLJuG8dIjuNmP/PFFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x79MeNQQzCDj/aMeY/uRQnZDOsxzLgLnxC1SVUbQlYiCD9eFCBzQQKjTcBjQ6RS65
	 ztNrFZRUxEObAXln4AA4ALgohciN8QPpXDtlTn3TEpRtN6sqZlhEeTtN19vCjlhp/U
	 V9h9MY1KPusjxpqtdE6lyy00URUeBZtcGHqbdeFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Devyn Liu <liudingyuan@huawei.com>,
	Jay Fang <f.fangjian@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 033/336] spi: hisi-kunpeng: Delete the dump interface of data registers in debugfs
Date: Tue, 14 May 2024 12:13:57 +0200
Message-ID: <20240514101039.860044026@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Devyn Liu <liudingyuan@huawei.com>

[ Upstream commit 7430764f5a85d30314aeef2d5438dff1fb0b1d68 ]

Due to the reading of FIFO during the dump of data registers in
debugfs, if SPI transmission is in progress, it will be affected
and may result in transmission failure. Therefore, the dump
interface of data registers in debugfs is removed.

Fixes: 2b2142f247eb ("spi: hisi-kunpeng: Add debugfs support")
Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
Reviewed-by: Jay Fang <f.fangjian@huawei.com>
Link: https://lore.kernel.org/r/20240416015839.3323398-1-liudingyuan@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-hisi-kunpeng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 35ef5e8e2ffd2..77e9738e42f60 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -151,8 +151,6 @@ static const struct debugfs_reg32 hisi_spi_regs[] = {
 	HISI_SPI_DBGFS_REG("ENR", HISI_SPI_ENR),
 	HISI_SPI_DBGFS_REG("FIFOC", HISI_SPI_FIFOC),
 	HISI_SPI_DBGFS_REG("IMR", HISI_SPI_IMR),
-	HISI_SPI_DBGFS_REG("DIN", HISI_SPI_DIN),
-	HISI_SPI_DBGFS_REG("DOUT", HISI_SPI_DOUT),
 	HISI_SPI_DBGFS_REG("SR", HISI_SPI_SR),
 	HISI_SPI_DBGFS_REG("RISR", HISI_SPI_RISR),
 	HISI_SPI_DBGFS_REG("ISR", HISI_SPI_ISR),
-- 
2.43.0




