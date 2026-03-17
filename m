Return-Path: <stable+bounces-226734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNxTKoiUuWnKKgIAu9opvQ
	(envelope-from <stable+bounces-226734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:51:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBF42B039E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DF38325C68E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039BF2FD69D;
	Tue, 17 Mar 2026 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3IW2cmb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8B2DF132
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767998; cv=none; b=DACRmtBBlckpeOnld3XxJTHoxgPyIHCGD1+Pwmt0upMo47BS2tWUoB+tTM8UYqK/sZfD7W1Moa0y4wjKkSx98T3VCQCIF9799JtvJ1MRJsfoy54qUEA7V5gqRvSWCsBS/FEM0E8USlQwhCidTcMFyO+uffHPVlpO3ZwZXOsz/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767998; c=relaxed/simple;
	bh=Kw+lr/2seNJHc0ca0HlfQxXWUMVkVHwilNAFqDBTsuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDUWiukSMMQ+FTwoUgm6Up5/GgYie5P0dELW5sv2NqaEC2Y08MauTocLlYoZ20zSVS1uyL7zTC3F6XmAish2kzWa4Rd7khc7mxkyrVUptYQSSmSAYbCSnAyKJiEHzqbhL8Sm48EI7kVZvl2trfx7eoFDpkLIWl6fTmfeJBgMgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3IW2cmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC73C2BCB0;
	Tue, 17 Mar 2026 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773767998;
	bh=Kw+lr/2seNJHc0ca0HlfQxXWUMVkVHwilNAFqDBTsuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3IW2cmbqI+tmM6vKyfcigOPjmiNroLtxox3ADJlppDsHYWN9zqXcJJZ2Wvez/hHT
	 kOu/J8nfcA2D8v7a3Xu5qgc4A0yOMrDiKkI9+wYlxJcNv6Hqr8JR8TONDo5xcDkTgb
	 +kKLR5egM1e3KEw2O4H38cWHCbnAkvw0h3H0uSPEwBtvew3Q3ZntSIOF2t3wnQqVJR
	 l20KsA+6P5nFl6cpJU/cHylIP9KR9+TiDKnnNZXDWFTSNFSzy0aY8RR1BMEG5LfbHt
	 +2wNkyowBwQVTnMfAOjcT2F5lakvoHYo1psk8ySq3UutjuX3YgaKY0tClAnPb8K0cA
	 b6YlsZ5Jrh/pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/8] media: device property: Return true in fwnode_device_is_available for NULL ops
Date: Tue, 17 Mar 2026 13:19:48 -0400
Message-ID: <20260317171954.238398-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317171954.238398-1-sashal@kernel.org>
References: <2026031703-caravan-bladder-c63a@gregkh>
 <20260317171954.238398-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ideasonboard.com,linux.intel.com,linuxfoundation.org,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226734-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,huawei];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,ideasonboard.com:email]
X-Rspamd-Queue-Id: 2FBF42B039E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Daniel Scally <djrscally@gmail.com>

[ Upstream commit 5273382d03763277aaf8c6a2d6088e2afaee0cf0 ]

Some types of fwnode_handle do not implement the device_is_available()
check, such as those created by software_nodes. There isn't really a
meaningful way to check for the availability of a device that doesn't
actually exist, so if the check isn't implemented just assume that the
"device" is present.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 9b28f8233ef21..80686d4a2bb35 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -837,9 +837,15 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
 /**
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
+ *
+ * For fwnode node types that don't implement the .device_is_available()
+ * operation, this function returns true.
  */
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
+	if (!fwnode_has_op(fwnode, device_is_available))
+		return true;
+
 	return fwnode_call_bool_op(fwnode, device_is_available);
 }
 EXPORT_SYMBOL_GPL(fwnode_device_is_available);
-- 
2.51.0


