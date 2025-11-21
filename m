Return-Path: <stable+bounces-196047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D661C79B40
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7499D34A72E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435534D4CF;
	Fri, 21 Nov 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vxq2gVbK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618633A291;
	Fri, 21 Nov 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732407; cv=none; b=RPdoQagOTWLKzyhK4q4RQu7vhRlv4hK/jJlTtNHVHJvMisG+LXDb0WhoXMYQpW8UOQEjtbQgyBzkuZzAytsgiw26GgFyj1lE2tIU3f62VoKc/BqSnEnlFjVy0mywsfHClEshQhLE7tNkkmhk/6tZ5cFZEfaMK7I0nG3KwNOZyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732407; c=relaxed/simple;
	bh=ZSyU5oghc8m2sKzzY2a9B519BpHQS3/fdy0vesgGl60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBSrhLGSWxrlJm8uJasJtRz8Ya3iDB2x9+XnabRIRr0rDmV82F9bRiu9ZckAyI5fbaCIzgaScQC+V9hLsZGsYoUvxdc590MeAK4ya04A561xRSR9z23nlbd7ZihrQE8/k0rhXDn/i2UGg0A0/AUw8D0+Kw34PwMwKnQ0rvHGoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vxq2gVbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BBEC4CEF1;
	Fri, 21 Nov 2025 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763732407;
	bh=ZSyU5oghc8m2sKzzY2a9B519BpHQS3/fdy0vesgGl60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vxq2gVbK8gbwHpeTZ3QkLAgmgys8IA8wAO9oyNlkwowuFaVPn/sUvwsJIEGV2MAvl
	 TRnw55Z6mggLEVyn+tO8GWBT+bHOK+CtEEDXAbS1vge5NxRyz1H7KZZkx6PibHXBeS
	 hjl1vLLiA4B/C3m3LXTtm/PovJUcjEjKTRMMCGDo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 111/529] mfd: stmpe: Remove IRQ domain upon removal
Date: Fri, 21 Nov 2025 14:06:50 +0100
Message-ID: <20251121130234.975874810@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
References: <20251121130230.985163914@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 57bf2a312ab2d0bc8ee0f4e8a447fa94a2fc877d ]

The IRQ domain is (optionally) added during stmpe_probe, but never removed.
Add the call to stmpe_remove.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/20250725070752.338376-1-alexander.stein@ew.tq-group.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmpe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 9c3cf58457a7d..be6a84a3062cc 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1485,6 +1485,9 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 
 void stmpe_remove(struct stmpe *stmpe)
 {
+	if (stmpe->domain)
+		irq_domain_remove(stmpe->domain);
+
 	if (!IS_ERR(stmpe->vio) && regulator_is_enabled(stmpe->vio))
 		regulator_disable(stmpe->vio);
 	if (!IS_ERR(stmpe->vcc) && regulator_is_enabled(stmpe->vcc))
-- 
2.51.0




