Return-Path: <stable+bounces-192705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCF8C3F818
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 11:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFBF64F3B88
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D970232B9AC;
	Fri,  7 Nov 2025 10:34:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D959328627
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511699; cv=none; b=b/mr3gEXyha28EKB6PI0uuKa7inCI0aB93U8YxcGOMfRRmWCgIWZ0GaboXh6z3TU6hITZ/2oJu3dlFO5468Iwl8KBefX3yCpqOifSTuQHphcRWDmkWSJ95Zr86prge9KTxpzoBnD8lqhVEptfyYGqLCFtQVuUAk4yIW1K7AQvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511699; c=relaxed/simple;
	bh=oQ5/oyVrQfuKOtcYvkat7Ovwmz/+jEdAHQRmwC+1FVk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QIDR3kpyWrlwKib6zXjY0p59XD7auB3KlqnXGT7YE4kRJ9yToSl4JEpOUaQnQiII1hIV2Sv7+VZ3qAb377bdCHJmHlBziasNV2M43IJJOFHglAc3Nx53mcggj9nxp9o7/sS16eZGrW+1wy8jtIU5lZUADolTgQZuSKmFwz0SsK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vHJno-0007dI-Uo; Fri, 07 Nov 2025 11:34:44 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH v2 0/2] media: staging: imx: fix multiple video input
Date: Fri, 07 Nov 2025 11:34:32 +0100
Message-Id: <20251107-media-imx-fixes-v2-0-07d949964194@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjLDWkC/3WNwQ6DIBBEf8XsudsA0VB76n8YDwir7kEwYImN8
 d9Lvff4ZvJmDkgUmRI8qwMiZU4cfAF1q8DOxk+E7AqDEqqRUjS4kGODvOw48k4JjaVRa6sHIxU
 Ua410FUXq+sIzpy3Ez3WQ5S/9v5UlCmxbqh9DPTZ2sK+V/PTeYvC83x1Bf57nFzDIF6CzAAAA
X-Change-ID: 20251105-media-imx-fixes-acef77c7ba12
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 Michael Tretter <michael.tretter@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>, Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

If the IMX media pipeline is configured to receive multiple video
inputs, the second input stream may be broken on start. This happens if
the IMX CSI hardware has to be reconfigured for the second stream, while
the first stream is already running.

The IMX CSI driver configures the IMX CSI in the link_validate callback.
The media pipeline is only validated on the first start. Thus, any later
start of the media pipeline skips the validation and directly starts
streaming. This may leave the hardware in an inconsistent state compared
to the driver configuration. Moving the hardware configuration to the
stream start to make sure that the hardware is configured correctly.

Patch 1 removes the caching of the upstream mbus_config in
csi_link_validate and explicitly request the mbus_config in csi_start,
to get rid of this implicit dependency.

Patch 2 actually moves the hardware register setting from
csi_link_validate to csi_start to fix the skipped hardware
reconfiguration.

Signed-off-by: Michael Tretter <michael.tretter@pengutronix.de>
---
Changes in v2:
- Document changed locking in commit message
- Link to v1: https://lore.kernel.org/r/20251105-media-imx-fixes-v1-0-99e48b4f5cbc@pengutronix.de

---
Michael Tretter (2):
      media: staging: imx: request mbus_config in csi_start
      media: staging: imx: configure src_mux in csi_start

 drivers/staging/media/imx/imx-media-csi.c | 84 ++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 36 deletions(-)
---
base-commit: 27afd6e066cfd80ddbe22a4a11b99174ac89cced
change-id: 20251105-media-imx-fixes-acef77c7ba12

Best regards,
-- 
Michael Tretter <m.tretter@pengutronix.de>


