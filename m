Return-Path: <stable+bounces-117405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14072A3B6A6
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CAB162D10
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921E1E0B66;
	Wed, 19 Feb 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A2MOtg66"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467C1C5D69;
	Wed, 19 Feb 2025 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955176; cv=none; b=UFhrcnu9s5Lvn1dK9qCmRTChz7MMzLHuOiZAUcCjCh5h8sfQWhi8AcLTsmjx2d9lEpO2YSTumjV4eUp9yMp0SMT5wr3KqxP/lLmercrtmbMLEaOrmFB2teDHGYung6+9vdRXSrDui5kSIEbfdYnVShWHyybzFbbcesjNoR40dDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955176; c=relaxed/simple;
	bh=KhPSRv6ZrioGQ34uBJDJ/KNZ3YKMEIrMJtP0TrbjmL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbkSzY1/J9DZPS1IX3o7ni8QlWJx4MFl8H6mWhPRSVrqO5+KR4NE3w7pP5GCEVe8YUJdRY84GMsviPrv4jRE7eOXGX29jPCS5L/r611RKKTYuydb9sfhAG+dYC6Dr0QhC7Y2/uwDrn9pRW0q1x/joTyqNBRy/ALJF5ZSx30QzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A2MOtg66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7144BC4CED1;
	Wed, 19 Feb 2025 08:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955175;
	bh=KhPSRv6ZrioGQ34uBJDJ/KNZ3YKMEIrMJtP0TrbjmL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2MOtg66T31gqskF9f0172GTo3YtURt5riHyDBvELytweo4ul0mLcYwUN4OsVZGD2
	 4uU2im19Osultr6Hfa6PSe+jiiHURfOuVBjEqK6S5uNt6PYz5RWwEjnsma7GzcBG8c
	 f27FHzNg8dHMm2IpLBns4XtT0BgVWeNBixHJCwgk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 156/230] regmap-irq: Add missing kfree()
Date: Wed, 19 Feb 2025 09:27:53 +0100
Message-ID: <20250219082607.797074993@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

commit 32ffed055dcee17f6705f545b069e44a66067808 upstream.

Add kfree() for "d->main_status_buf" to the error-handling path to prevent
a memory leak.

Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register support")
Cc: stable@vger.kernel.org  # v5.1+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Link: https://patch.msgid.link/20250205004343.14413-1-jiashengjiangcool@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regmap-irq.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -909,6 +909,7 @@ err_alloc:
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_buf);
 	kfree(d->status_reg_buf);
 	if (d->config_buf) {
@@ -984,6 +985,7 @@ void regmap_del_irq_chip(int irq, struct
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_reg_buf);
 	kfree(d->status_buf);
 	if (d->config_buf) {



