Return-Path: <stable+bounces-74185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D42C972DED
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A36B22B28
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B38D1885A6;
	Tue, 10 Sep 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tkxNl+W4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB90188CC1;
	Tue, 10 Sep 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961063; cv=none; b=jm7ZEw2+g2W3MRc7PBf28CcPXkhLeLVzt4bTkz3YNPMB8tw3hhT4iGothFYQFSDcYpm125n20Vm13ULcbZepmpMhbQIp8C3r9RA0ugmh3GNESOHzyjlINOu+4em7sUDeONkoTlYmWZPs4ZRUd7TJrsCpDmAB+rOjBTHi9RsPEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961063; c=relaxed/simple;
	bh=zi4q78+M+og8lZOgAvaPpZqAlT3vo3rwcyQTujruS+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuqJhQJIcw7EK/CRPslvAogasGGJ1Aa4n0uaGSWeU7011WBzT3120Ok5qnsISUVDOOYytAavMbAN9K/GM+pQdCDaGS0hYu+vNlYfWHc/HrIYMlLiHB024BCi3DS/fwWGHhMOGpEw+jimDZF1iQg6Wna6R0D59+0VWBomoZogs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tkxNl+W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB68C4CEC3;
	Tue, 10 Sep 2024 09:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961062;
	bh=zi4q78+M+og8lZOgAvaPpZqAlT3vo3rwcyQTujruS+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tkxNl+W4ZWk1qJ5JvfYMW/WU7lxczs4Nk76K/pyLq8pM9+U+lUCtiWpY/BWdGHBbY
	 t9rtFsfP8dNgMLOQcayGtNPzbCuAJ3w+USs06oo2dJ7UEQoI4gBqnjqHdYu89DK0JL
	 WYTHINOOJGz3aCXZEso3Jzpowd/IMa/5cFeNfflQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/96] media: qcom: camss: Add check for v4l2_fwnode_endpoint_parse
Date: Tue, 10 Sep 2024 11:31:35 +0200
Message-ID: <20240910092542.974374606@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 4caf6d93d9f2c11d6441c64e1c549c445fa322ed ]

Add check for the return value of v4l2_fwnode_endpoint_parse() and
return the error if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 669615fff6a0..0fc7951640e2 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -431,8 +431,11 @@ static int camss_of_parse_endpoint_node(struct device *dev,
 	struct v4l2_fwnode_bus_mipi_csi2 *mipi_csi2;
 	struct v4l2_fwnode_endpoint vep = { { 0 } };
 	unsigned int i;
+	int ret;
 
-	v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	if (ret)
+		return ret;
 
 	csd->interface.csiphy_id = vep.base.port;
 
-- 
2.43.0




