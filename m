Return-Path: <stable+bounces-191237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFEC11201
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ED65839A9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF6D32C925;
	Mon, 27 Oct 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z/3k/F66"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876C2D7DDA;
	Mon, 27 Oct 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593373; cv=none; b=BvVZbTF+fI/mlZLkHtnVeYdJkhRjj+PaUhQlJvSVjRIYCbdGOdFZQh14LIw2gYgLkbdzS0yQB9IEe7sZHJjEPmN0NROGqK0NhSSxbw70RO1LdArDPoOztNCZm0VnF1EwHrgfO/aQd9kftMrUHKDQueUeMs6iCaHKEe2uBUk6Gwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593373; c=relaxed/simple;
	bh=GN3wCsPYe1zwiKkJm2a6jvQbdxtnoyFmqqi65PHDpnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYXrVnd0YOHnXAMHLxqSykV4KPAZhsY2+71HwlIs1lwC56y4WbuyWdFLV+3h+5rPZGnPjaBvh7BeQYtvkqLTqFtz/DBNVW2IOWBvLRr9cHxbGrXrRqP6tp2jmS7Nv1AMTPfIrdZxjVvYoENMVixp9zWqyXGcdmf4pyC9W8ahBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z/3k/F66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC30EC4CEF1;
	Mon, 27 Oct 2025 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761593373;
	bh=GN3wCsPYe1zwiKkJm2a6jvQbdxtnoyFmqqi65PHDpnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/3k/F66Mbzq8nyKIVVzKJHU6Z0X0Dcf+S7YTg6wNsn9BcyWk0fGHUF0P5s4M5BHL
	 W/uCtx242sL+CfKCxGDJtqD9n16E/GKIhSTVGfRSRtA4A8EMgrwphU0n6kI9m9WfXM
	 iVDaKXjqfo54qg8SOuF7QIHa8lKmo/1lHy9FwwRw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saumya <admin@trix.is-a.dev>,
	Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.17 077/184] platform/x86: alienware-wmi-wmax: Add AWCC support to Dell G15 5530
Date: Mon, 27 Oct 2025 19:35:59 +0100
Message-ID: <20251027183516.974229583@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
References: <20251027183514.934710872@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: tr1x_em <admin@trix.is-a.dev>

commit 34cbd6e07fddf36e186c8bf26a456fb7f50af44e upstream.

Makes alienware-wmi load on G15 5530 by default

Cc: stable@vger.kernel.org
Signed-off-by: Saumya <admin@trix.is-a.dev>
Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Link: https://patch.msgid.link/20250925034010.31414-1-admin@trix.is-a.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -210,6 +210,14 @@ static const struct dmi_system_id awcc_d
 		.driver_data = &g_series_quirks,
 	},
 	{
+		.ident = "Dell Inc. G15 5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5530"),
+		},
+		.driver_data = &g_series_quirks,
+	},
+	{
 		.ident = "Dell Inc. G16 7630",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),



