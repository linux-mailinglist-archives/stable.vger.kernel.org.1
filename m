Return-Path: <stable+bounces-192570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DA8C39221
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 06:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 938A44E2DFB
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 05:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD92D6E66;
	Thu,  6 Nov 2025 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWvVjZaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B17E0E8;
	Thu,  6 Nov 2025 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405646; cv=none; b=S70k6UTacrRLoEd+ZCHre16IZv8CM5TGM4y/+SUpaU5OxEC7RwZpgZDKSu5voY08JybeSd1fMWGqUFlCaeYpHtMneVuXmMxRl+My0MJsDzjtmmBZrHKfhK2tFwv/OYWH6yIavqredbYqjGf/Hd7SL3coDnccahXW1z/zTRu6284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405646; c=relaxed/simple;
	bh=9vEWJIQ0oDRYaJ/9CpY4a+GPTLeOZZDUjTMFSkxtUcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mw/2aZkbTKlgvX8yh6e0K25zgiT/5tDDdwAkXZHHo8qgaGNaDE+cEsLa2N33hK9CoImQLddPTA5xP/NVfJdD+mDOr0W8y/X2APM5+vyB34ozVAYOztugnj197/bIHLsCWvC8596tyTlqGxzPC2OePF317S6TMFsMI+yEljFaaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWvVjZaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3466C4CEF7;
	Thu,  6 Nov 2025 05:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762405646;
	bh=9vEWJIQ0oDRYaJ/9CpY4a+GPTLeOZZDUjTMFSkxtUcY=;
	h=From:To:Cc:Subject:Date:From;
	b=GWvVjZaNgSNpkIWecfdporgIlOruyaKzDn3DkOseffcywXpJigcDGCjsITMcIHTWw
	 s7QYJAO74V1HyNiNdlIF9heZxTYRxJbfZp8pQJ7pc4wsUwKpJ7oOus/WcYbJsXX8k9
	 Hx2jkUwKmlLYQWOA1Uh4dVm3/jHu37qmfB5IxMC2OmdL6JRSll/GZ+Ylr3wpf0ughU
	 CYJhz0TvqjLVhT8RRC14eD2T46r1DKWstp4ZT5OOlLIZX5IrASW5vAYj4tBTGWW+S0
	 tbL4GIcDLeMFYsOBdfZVi95Qb52qz4b8I5T+cIY7eLU7c3wDv1umxHMawPqeznRf11
	 VnyNw70LQV1Dg==
From: Dinh Nguyen <dinguyen@kernel.org>
To: gregkh@linuxfoundation.org
Cc: dinguyen@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] firmware: stratix10-svc: fix make htmldocs warning
Date: Wed,  5 Nov 2025 23:06:25 -0600
Message-ID: <20251106050625.5588-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix this warning that was generated from "make htmldocs":

WARNING: drivers/firmware/stratix10-svc.c:58 struct member 'intel_svc_fcs'
not described in 'stratix10_svc'

Cc: stable@vger.kernel.org
Fixes: e6281c26674e ("firmware: stratix10-svc: Add support for FCS")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..d9d84e2ca434 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -52,6 +52,7 @@ struct stratix10_svc_chan;
 /**
  * struct stratix10_svc - svc private data
  * @stratix10_svc_rsu: pointer to stratix10 RSU device
+ * @intel_svc_fcs: pointer to the FCS device
  */
 struct stratix10_svc {
 	struct platform_device *stratix10_svc_rsu;
-- 
2.42.0.411.g813d9a9188


