Return-Path: <stable+bounces-193436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F928C4A4F4
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C46024F6631
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5C342CB1;
	Tue, 11 Nov 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JEeNEYZ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62D342CA9;
	Tue, 11 Nov 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823179; cv=none; b=KX0Q4yEyKE3yzx8A7wj+kqDiJaeXo+pJUOecmR3f6E3zgd4xdIAcC1pNz9ozZ50vViGRjMuXlw4NtPFXpDSszRmi48LLNZsu99VbpreLGr0S1xbSkveOj5fHLJ+IH+CogG7FFVWQOCU8HreoNoFavxxb1VidtJQVaOSpYZQf7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823179; c=relaxed/simple;
	bh=mqDGC/Yq0TJQm+mPe30IH4RiGtPpLJeJ+SL5OfbIPLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gqjw7CLyH+2KF79A3pYPxh4xc+Ydve381B5bgyZtJxW9qR+v99I3SLEcoQxSTyFsXfjjX8wbPBIhw9T/HnqtP8eJ7LjSf84WM9GnweHvZKacqhi4ZRsbNyKwAzRa5KikLbMFfWOeXBl5tfnkU45DRbYbzZmxv96ArjqQfn4qO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEeNEYZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6963C2BCAF;
	Tue, 11 Nov 2025 01:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823179;
	bh=mqDGC/Yq0TJQm+mPe30IH4RiGtPpLJeJ+SL5OfbIPLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEeNEYZ1EO05yOBR+YHvAzo+aHMW/OcIFnbn9tqyiu1PQ/k8WJrCpWncfVJBC2Q/4
	 7OwMvbsvSPWEGv8yncOKdBbltqeRpO7fiFIjuihk5fVASWhliGcmPKrxgbKCqsrBw8
	 r9CwZtVyvKoyzuj5eUN1/LsiGZ02Z2Nv5iu9/QfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 149/565] spi: rpc-if: Add resume support for RZ/G3E
Date: Tue, 11 Nov 2025 09:40:05 +0900
Message-ID: <20251111004530.292473970@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit ad4728740bd68d74365a43acc25a65339a9b2173 ]

On RZ/G3E using PSCI, s2ram powers down the SoC. After resume,
reinitialize the hardware for SPI operations.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250921112649.104516-3-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rpc-if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index c24dad51a0e96..43e829251af59 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -193,6 +193,8 @@ static int __maybe_unused rpcif_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
+	rpcif_hw_init(dev, false);
+
 	return spi_controller_resume(ctlr);
 }
 
-- 
2.51.0




