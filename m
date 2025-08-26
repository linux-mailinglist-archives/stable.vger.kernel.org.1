Return-Path: <stable+bounces-174421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4682B36349
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A30E8A6764
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A5C345744;
	Tue, 26 Aug 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zGXYX+/b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09A8635C;
	Tue, 26 Aug 2025 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214345; cv=none; b=gX5Rr9WtchF2ZjW9zvrJfPG4fB/DWULhFWLfddT4NUzzIwOjdE07yfN0YniZnz9Ls3xp9UmZ5LyVnH7rfGXEFQXNLqS8vuM9PEDgBgrXDbBXpoCtX/Tmhx8aCAj/hawg8pq4FlFwEICgMVBtRmTAD8xRhzj9DSocbG9sicB5ia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214345; c=relaxed/simple;
	bh=OFkHCtw0CNoy5ErqMuOFdxCpsPjzf253kXOMMmayJZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dsngq9QzcBL1CvpfMcJH0FJELLYbKCf8mLF48A5De60kOKBjxzspUP27lwIyQJjrd8bjcBcz2SIZQzrpv3kDfSSHPD9GhoEU5bc51uw6ToS4VqPTbZlb7bIzp2YIA5deI4g1MOPdZaKarJRW/0rr+KesMsT25dzcHlltLUGJZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zGXYX+/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC1CC113CF;
	Tue, 26 Aug 2025 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214344;
	bh=OFkHCtw0CNoy5ErqMuOFdxCpsPjzf253kXOMMmayJZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zGXYX+/b0klAnGfPf6gL6j/o/CAaubB5Y6JZ/v3qKG7nw7Om2qPwpQHgmF3D80ArE
	 49N52YVM5+ZB3JzRrzn2fUh0IMRCasC1k3djl13JuHpVh2SwBRRP9MjeQHGljm/CYs
	 xS5ud7NUSRpgRYnxglgFX+uvUCYJwwjElSS5h9pU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomasz Michalec <tmichalec@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 103/482] usb: typec: intel_pmc_mux: Defer probe if SCU IPC isnt present
Date: Tue, 26 Aug 2025 13:05:56 +0200
Message-ID: <20250826110933.374722745@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Michalec <tmichalec@google.com>

[ Upstream commit df9a825f330e76c72d1985bc9bdc4b8981e3d15f ]

If pmc_usb_probe is called before SCU IPC is registered, pmc_usb_probe
will fail.

Return -EPROBE_DEFER when pmc_usb_probe doesn't get SCU IPC device, so
the probe function can be called again after SCU IPC is initialized.

Signed-off-by: Tomasz Michalec <tmichalec@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250610154058.1859812-1-tmichalec@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 87e2c9130607..a6936fc59d1e 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -667,7 +667,7 @@ static int pmc_usb_probe(struct platform_device *pdev)
 
 	pmc->ipc = devm_intel_scu_ipc_dev_get(&pdev->dev);
 	if (!pmc->ipc)
-		return -ENODEV;
+		return -EPROBE_DEFER;
 
 	pmc->dev = &pdev->dev;
 
-- 
2.39.5




