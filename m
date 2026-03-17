Return-Path: <stable+bounces-226732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPb5LO+SuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:44:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E50702B00F5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7135F300C6C9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E12A328B61;
	Tue, 17 Mar 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd9m84w8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421862D5940
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767997; cv=none; b=EcnG21UD++1sFioHqAdqh65DHGBHvjJva/RTTh+5zZkQMolMV4rKfVPPhtL5hnpBvcuuFmikyGas4TZgktBoInV2uRI/E2K0xuAB7p/uM/INVunc2JL77Orfo8rPO60DZNDD1sLyi+/ShGPcufRPPxd5eDxR/gPjexI49dOuCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767997; c=relaxed/simple;
	bh=rzyzpinw27Int9fTQiGgILxspGOSnH07odpZkw8U1X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNnJaYdO2ghkG/p33wE9O+VC4qY/iK10EH1bg62hK0jDkAZZvSw46XhuwGwIHqxolZIP+15o9unJUaUJ7uZzrkCHY7BaIjKu8h2HRMevdlA8bT0G9OZsQRk/dW5KoqByAzSkaiiYHp8l3MtOBpi+MboyEyGwllPuJhhhzx4gErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd9m84w8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4FFC4CEF7;
	Tue, 17 Mar 2026 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773767997;
	bh=rzyzpinw27Int9fTQiGgILxspGOSnH07odpZkw8U1X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kd9m84w8lDcmc+GzRxYx45Tyfqjpiab0E8cxu4JxM8y1qX90h1hgRMRbAbOTjRHqE
	 pjACoGv8cmlUCO7JZ9X1Pnn1Bp0T0fo9CLmcf2Gk/czPOYyoO03cM+xi2Xn8/ctdJX
	 mb2o+Q+XrerZllQUHW137zJMKJLygzSLgHkDZcoBznPTFGcev0MkBkIlW/rOdxY9RI
	 Gmm3u61DI5kU8XoUWTeocPiJAWbSWk3Ns1ZgkQXdYwe7AOWWYrRuXLKRxaxGa490L6
	 r7D2MKAAsbFR5SMG9u2lrwQZ8rA3Ya3jteVKeskJKSVKNrxWf//Vn3wsR44ZWXj2qO
	 xmnB5q6+bqnNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/8] device property: Add fwnode_is_ancestor_of() and fwnode_get_next_parent_dev()
Date: Tue, 17 Mar 2026 13:19:47 -0400
Message-ID: <20260317171954.238398-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031703-caravan-bladder-c63a@gregkh>
References: <2026031703-caravan-bladder-c63a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226732-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E50702B00F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saravana Kannan <saravanak@google.com>

[ Upstream commit b5d3e2fbcb10957521af14c4256cd0e5f68b9234 ]

Add fwnode_is_ancestor_of() helper function to check if a fwnode is an
ancestor of another fwnode.

Add fwnode_get_next_parent_dev() helper function that take as input a
fwnode and finds the closest ancestor fwnode that has a corresponding
struct device and returns that struct device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Link: https://lore.kernel.org/r/20201121020232.908850-11-saravanak@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c  | 52 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 55 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index e9fdef1f45175..9b28f8233ef21 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -614,6 +614,31 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
 
+/**
+ * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
+ * @fwnode: firmware node
+ *
+ * Given a firmware node (@fwnode), this function finds its closest ancestor
+ * firmware node that has a corresponding struct device and returns that struct
+ * device.
+ *
+ * The caller of this function is expected to call put_device() on the returned
+ * device when they are done.
+ */
+struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
+{
+	struct device *dev = NULL;
+
+	fwnode_handle_get(fwnode);
+	do {
+		fwnode = fwnode_get_next_parent(fwnode);
+		if (fwnode)
+			dev = get_dev_from_fwnode(fwnode);
+	} while (fwnode && !dev);
+	fwnode_handle_put(fwnode);
+	return dev;
+}
+
 /**
  * fwnode_count_parents - Return the number of parents a node has
  * @fwnode: The node the parents of which are to be counted
@@ -660,6 +685,33 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
+/**
+ * fwnode_is_ancestor_of - Test if @test_ancestor is ancestor of @test_child
+ * @test_ancestor: Firmware which is tested for being an ancestor
+ * @test_child: Firmware which is tested for being the child
+ *
+ * A node is considered an ancestor of itself too.
+ *
+ * Returns true if @test_ancestor is an ancestor of @test_child.
+ * Otherwise, returns false.
+ */
+bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
+				  struct fwnode_handle *test_child)
+{
+	if (!test_ancestor)
+		return false;
+
+	fwnode_handle_get(test_child);
+	while (test_child) {
+		if (test_child == test_ancestor) {
+			fwnode_handle_put(test_child);
+			return true;
+		}
+		test_child = fwnode_get_next_parent(test_child);
+	}
+	return false;
+}
+
 /**
  * fwnode_get_next_child_node - Return the next child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
diff --git a/include/linux/property.h b/include/linux/property.h
index 34ac286db88d2..3c2031c2c3034 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -85,9 +85,12 @@ const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
+struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode);
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
+bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
+				  struct fwnode_handle *test_child);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.51.0


