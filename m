Return-Path: <stable+bounces-162353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4FB05D62
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D163A3EE1
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4112397BF;
	Tue, 15 Jul 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJGyIUqw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C572E3AE5;
	Tue, 15 Jul 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586333; cv=none; b=iEu+Cxnc8YbDwqW86zdMTFJ2gxvKlmHazfhHxuMOGkPMG9NTvP5h4Hq+o6ZAvxa1xaeZnSHGndqhX2bmhMYTFnmLO8bjlAC7SRtXrfGY1MHrAgenpcxSSIf1UgWOwsX4xJIf/uCPVs4vzJ5XRsa3raZdk04eiP6MC58BHZ9G6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586333; c=relaxed/simple;
	bh=No43g16yquKWyxuaS8aQ4VnwcyQuKrTywxQqqVOfsXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejw8dgXDWTZdchgNVL+FpNpwugrn+vPk3/TOinFBsNXmV0Pgy74Rx4DC9/RwYIkZ3kYL3oj39FXTAVG6kSb0VwQ/6kJDVcRTOWDIehoDodo2llkeAnyTPIe5JOE+woJsGdI8DKLH3DcCFirLQ3pa2HHC4bA/8ssf0zSudDs0fy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJGyIUqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5C2C4CEE3;
	Tue, 15 Jul 2025 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586332;
	bh=No43g16yquKWyxuaS8aQ4VnwcyQuKrTywxQqqVOfsXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJGyIUqwWWaKdNVA2o7cy34u7uLR7fdw8xUE3CAV2fcaLE6gUx44O8BPo4NiOGmh4
	 vYmrcfriLEa2VT2TrUrsQKF9MT1luiL/ywQck157Y41wntEuy9Wh6t7GCAijWCFPOo
	 H4lxypddk+8r44Qwimbde+OboSGJKHUt9oKABKTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 025/148] of: Add of_property_present() helper
Date: Tue, 15 Jul 2025 15:12:27 +0200
Message-ID: <20250715130801.326099907@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit 9cbad37ce8122de32a1529e394b468bc101c9e7f ]

Add an of_property_present() function similar to
fwnode_property_present(). of_property_read_bool() could be used
directly, but it is cleaner to not use it on non-boolean properties.

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Tested-by: Frank Rowand <frowand.list@gmail.com>
Link: https://lore.kernel.org/all/20230215215547.691573-1-robh@kernel.org/
Signed-off-by: Rob Herring <robh@kernel.org>
Stable-dep-of: 171eb6f71e9e ("ASoC: meson: meson-card-utils: use of_property_present() for DT parsing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/of.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index ec6b8a1af73cf..728b9df20a521 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1044,7 +1044,8 @@ static inline int of_property_read_string_index(const struct device_node *np,
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
  *
- * Search for a property in a device node.
+ * Search for a boolean property in a device node. Usage on non-boolean
+ * property types is deprecated.
  *
  * Return: true if the property exists false otherwise.
  */
@@ -1056,6 +1057,20 @@ static inline bool of_property_read_bool(const struct device_node *np,
 	return prop ? true : false;
 }
 
+/**
+ * of_property_present - Test if a property is present in a node
+ * @np:		device node to search for the property.
+ * @propname:	name of the property to be searched.
+ *
+ * Test for a property present in a device node.
+ *
+ * Return: true if the property exists false otherwise.
+ */
+static inline bool of_property_present(const struct device_node *np, const char *propname)
+{
+	return of_property_read_bool(np, propname);
+}
+
 /**
  * of_property_read_u8_array - Find and read an array of u8 from a property.
  *
-- 
2.39.5




