Return-Path: <stable+bounces-101524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEE19EED01
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A68169C4A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A282206A5;
	Thu, 12 Dec 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KbOZYSA/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35766F2FE;
	Thu, 12 Dec 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017856; cv=none; b=Mqnx/NtRb+1f+vqlXr/wUTEukWyHkMVAmepQwR63Pc02wbbNE19u8PO8s3xwRtj6AMxtLGpVGvv0vZwIY+/53LKl9M/bdoNfTSpF4ZxgFJo8OAYPRofO+YR8PrEWc0v7aTySa9j93IcA/qIGYnqsHtCf3nV6WnaLbFeIcRmJEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017856; c=relaxed/simple;
	bh=lx/szwDoenTbAVoZhEMO4/3zbbxVRirA46zV9ylCaL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ger5LoGC9LV4G9GtykQ//hGQGLPCXVMAi5FoAAqla83wTHOEOT02Z+hgjnF3t+IZCwGC1mORkTWVvNkM0CLTbss4iG9N779WvCc0ixghWs7YCEBtJC7yoRf1yp5IAxQhf7aDjLt6hH0NkIzW3abn5tMaTfDakJPNz5uV1iQFtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KbOZYSA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99EFC4CECE;
	Thu, 12 Dec 2024 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017856;
	bh=lx/szwDoenTbAVoZhEMO4/3zbbxVRirA46zV9ylCaL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbOZYSA/GSC6kYu/saL911E7sSZNUWIBJlIpw0taaFsLD1v9/BjHGdjznVoZg70YR
	 lsaFknBlQgaLTgmkNRYwaKFPK5VSyJpyypiWYE7c+NRUYvu6LkPXH78MyFHx1R+3ZV
	 ljAIx/H8IZDdDy/ZKQrs/tP+KFOJB4V5hYe658XE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 100/356] i3c: master: fix kernel-doc check warning
Date: Thu, 12 Dec 2024 15:56:59 +0100
Message-ID: <20241212144248.569722976@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 34d946b723b53488ab39d8ac540ddf9db255317a ]

Fix warning found by
	'scripts/kernel-doc -v -none include/linux/i3c/master.h'

include/linux/i3c/master.h:457: warning: Function parameter or member 'enable_hotjoin' not described in 'i3c_master_controller_ops'
include/linux/i3c/master.h:457: warning: Function parameter or member 'disable_hotjoin' not described in 'i3c_master_controller_ops'
include/linux/i3c/master.h:499: warning: Function parameter or member 'hotjoin' not described in 'i3c_master_controller'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20240109052548.2128133-1-Frank.Li@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Stable-dep-of: 25bc99be5fe5 ("i3c: master: svc: Modify enabled_events bit 7:0 to act as IBI enable counter")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/i3c/master.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 65b8965968af2..1cbf0baca65fe 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -426,6 +426,8 @@ struct i3c_bus {
  *		      for a future IBI
  *		      This method is mandatory only if ->request_ibi is not
  *		      NULL.
+ * @enable_hotjoin: enable hot join event detect.
+ * @disable_hotjoin: disable hot join event detect.
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
@@ -467,6 +469,7 @@ struct i3c_master_controller_ops {
  * @ops: master operations. See &struct i3c_master_controller_ops
  * @secondary: true if the master is a secondary master
  * @init_done: true when the bus initialization is done
+ * @hotjoin: true if the master support hotjoin
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
  * @boardinfo: board-level information attached to devices connected on the bus
-- 
2.43.0




