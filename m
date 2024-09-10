Return-Path: <stable+bounces-75025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE649732B8
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF6EB2179A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53451922EF;
	Tue, 10 Sep 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9hbXMuE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73324172BAE;
	Tue, 10 Sep 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963529; cv=none; b=rj34UaUe5N+aF4oekWhQbTJi3NN9GcYMVlGAZRGulmk8uGvb88xB9NQxLSZ7cI8nzkR4iE1mxnC8SXbc2DC9Qx+50iPLeKYul+KuMUMIYRGtIZa0ARWaIvlncPmlqzvdhNdcWCkj27Mrlfnj+FNNyY4KJLgo/K5y8rALlyNXDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963529; c=relaxed/simple;
	bh=YRRO+M0oLbR4ioU2mslAHWQoVaKELPMTVjdfquHMNnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzqcuybNiKCNHzweBDuBY6LRP7QUhoTO8rJnxF0PYJ7M1P2D0uPoAbOgkPOIM4NrXzIQ6Ew+b0dN+mzvNQ+wDij7jiUQ1s1QXreb3icknMCuh7TJB8n1QLD3aWQJAhnuyLO2DQ1iibq4J/EwpeMUG4XJYRzmtzTyqyeA39iLE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9hbXMuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48EEC4CEC6;
	Tue, 10 Sep 2024 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963529;
	bh=YRRO+M0oLbR4ioU2mslAHWQoVaKELPMTVjdfquHMNnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9hbXMuEj9XblNBdob6rKEtm1/DRgD8GojJyMBt3Lt3ApMVlNjnHcETR5/gimlvl1
	 3tlRwcco5oaMKlGpRGyWoJ/q6lrS3u0AYTlhwx5Ga7u+xLs36/mUTaArjaR4/yzc5p
	 WtNpi/EF1HSnFPb2MmL9H+b2SWiagO/XiQfM4oLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	kernel test robot <lkp@intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5.15 061/214] i2c: Use IS_REACHABLE() for substituting empty ACPI functions
Date: Tue, 10 Sep 2024 11:31:23 +0200
Message-ID: <20240910092601.265077999@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

commit 71833e79a42178d8a50b5081c98c78ace9325628 upstream.

Replace IS_ENABLED() with IS_REACHABLE() to substitute empty stubs for:
    i2c_acpi_get_i2c_resource()
    i2c_acpi_client_count()
    i2c_acpi_find_bus_speed()
    i2c_acpi_new_device_by_fwnode()
    i2c_adapter *i2c_acpi_find_adapter_by_handle()
    i2c_acpi_waive_d0_probe()

commit f17c06c6608a ("i2c: Fix conditional for substituting empty ACPI
functions") partially fixed this conditional to depend on CONFIG_I2C,
but used IS_ENABLED(), which is wrong since CONFIG_I2C is tristate.

CONFIG_ACPI is boolean but let's also change it to use IS_REACHABLE()
to future-proof it against becoming tristate.

Somehow despite testing various combinations of CONFIG_I2C and CONFIG_ACPI
we missed the combination CONFIG_I2C=m, CONFIG_ACPI=y.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f17c06c6608a ("i2c: Fix conditional for substituting empty ACPI functions")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408141333.gYnaitcV-lkp@intel.com/
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/i2c.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -1025,7 +1025,7 @@ static inline int of_i2c_get_board_info(
 struct acpi_resource;
 struct acpi_resource_i2c_serialbus;
 
-#if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_I2C)
+#if IS_REACHABLE(CONFIG_ACPI) && IS_REACHABLE(CONFIG_I2C)
 bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 			       struct acpi_resource_i2c_serialbus **i2c);
 int i2c_acpi_client_count(struct acpi_device *adev);



