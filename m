Return-Path: <stable+bounces-87572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8329A6B9E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F4828123A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBBB1F427B;
	Mon, 21 Oct 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qq5dVfk8"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3D1D1736;
	Mon, 21 Oct 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519700; cv=none; b=ou/E52X4j68S54S9cIspL3/UufCIFgwrz7Zfp5VWSIQdkL9ukdWUWz7YOaPagn2gcCFKQakXVmnJdBZQxANBF/bLmufQNozJq7dVebKVplzBbBUxOM80elsyJK4Y2LOKXrlcXTAY8pPKGQi5Y3CD5aoHzQc9atkDiYuPqih6c9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519700; c=relaxed/simple;
	bh=1MgP2F8moCqzsOmnkKF7V1hfTU0FvZDmOEK1cyki77U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ONW1P6xQtICtI16Iykkn3B7z/rX4WoVqGxtCI339HifAH7pJjXMdAcIRS7wSQzfhoAii7PnVgOfjR3qxuEOY27ytnghT6uvdtWbkQBOsKDP3XeZVZh0My4Ps56WdpqIoKajCgpZ3MsHI0nITC51wYvSPh0fhIBXzWCn4I1lUG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qq5dVfk8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDA7C502;
	Mon, 21 Oct 2024 16:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729519590;
	bh=1MgP2F8moCqzsOmnkKF7V1hfTU0FvZDmOEK1cyki77U=;
	h=From:Subject:Date:To:Cc:From;
	b=qq5dVfk82X7Z+PF4NzgnaH5bFdE7UogRs2wyhYS0UF8dsCMpTlggVgl/9NYGh0DbK
	 uRM22If/eevwpRaIWlyBgCQplWVywpKdYCodnLbzVoSuWBvt9YWjZ42LxHg+1+GSv1
	 w6u6iFsJex/VON9cvzrTU77a3IAzdFlS2nR7dHng=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/7] drm/tidss: Interrupt fixes and cleanups
Date: Mon, 21 Oct 2024 17:07:44 +0300
Message-Id: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFgFmcC/x2MQQqAIBAAvxJ7bkFFyvpKdLBaay9WbkQg/T3pO
 AMzGYQSk0BfZUh0s/AeC+i6gnnzcSXkpTAYZazqtMOLFxHkdGLgB0Pj2knbzlszQ2mOREX/v2F
 83w/Bowa5XwAAAA==
To: Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jonathan Cormier <jcormier@criticallink.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Bin Liu <b-liu@ti.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=1MgP2F8moCqzsOmnkKF7V1hfTU0FvZDmOEK1cyki77U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnFmBIExpppKVyWBV2SrBM3cBXEDUR+rMt9YcPO
 DTwcqa6DuqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZxZgSAAKCRD6PaqMvJYe
 9UG3D/0RLXhn4OgmO2WJA/yg0cD+Z7zCxoTW/wYj+xhtBs1MAhInKBBWvayyF7MvbVk1yixDnl+
 EMXcr8TmN9ulW1RtBQ8is0/kaG3J3O5ISwGgPM+ghz91R8CvN5/p5SucwFIYG7AfYDbFQmIF31w
 JwS4X3HB/jjgUmAr+L1h+CdrO+8cobWyequNyfkFPARjaMFPWGuHDmpBcJURaga1KY/eZw9/aqV
 Q/v11Kcai5oNL+YBHJakvsxlFejEy9/RcbPW+DlkoCZ1govJuJOxlVEOcSaFrDJc7k3JPim6nII
 ++7I1UPhUrRdG0JMo/t+p9mD9SH/rVqWzrn2u6YZYyJRG9rcuva7IbgdPFsXZSdZRZpjSqK10pC
 5VIgc3f2YcDgMHdxidp8kLhVhkNG67zEOrNCWjqM2WyUiswFtyNUWx35dAkqoflC0uTmP8fdI0a
 SUu1OUIqsZGg7L1dsWeAJpkrEXXe54x3Q338LQDUOZ9sw4hMD+i7+JliHBP/eNGoaOqipIkmSbE
 +DBlvwaER2pqE/p3CjqLcMba2DB1rXy7URXyj8gzY83/DQo/maYqP31IzWkLsvpwuslg5+aArv+
 lGVIldRhNFOmFwV8Eb7SKT+w7Yt4CNVKSVW3ngz2gPo8SkZwWStxBFo/4b9hcbo56gPk2jwlbz0
 P0C1oHN/N+HoJdQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

A collection of interrupt related fixes and cleanups. A few patches are
from Devarsh and have been posted to dri-devel, which I've included here
with a permission from Devarsh, so that we have all interrupt patches
together. I have modified both of those patches compared to the posted
versions.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Devarsh Thakkar (2):
      drm/tidss: Clear the interrupt status for interrupts being disabled
      drm/tidss: Fix race condition while handling interrupt registers

Tomi Valkeinen (5):
      drm/tidss: Fix issue in irq handling causing irq-flood issue
      drm/tidss: Remove unused OCP error flag
      drm/tidss: Remove extra K2G check
      drm/tidss: Add printing of underflows
      drm/tidss: Rename 'wait_lock' to 'irq_lock'

 drivers/gpu/drm/tidss/tidss_dispc.c | 28 ++++++++++++++++------------
 drivers/gpu/drm/tidss/tidss_drv.c   |  2 +-
 drivers/gpu/drm/tidss/tidss_drv.h   |  5 +++--
 drivers/gpu/drm/tidss/tidss_irq.c   | 34 +++++++++++++++++++++++-----------
 drivers/gpu/drm/tidss/tidss_irq.h   |  4 +---
 drivers/gpu/drm/tidss/tidss_plane.c |  8 ++++++++
 drivers/gpu/drm/tidss/tidss_plane.h |  2 ++
 7 files changed, 54 insertions(+), 29 deletions(-)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240918-tidss-irq-fix-f687b149a42c

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


