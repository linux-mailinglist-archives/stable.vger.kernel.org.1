Return-Path: <stable+bounces-215089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HbOIRzyiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:41:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD39F110B3E
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940F7305F7F6
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E9285060;
	Mon,  9 Feb 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHsjMeIm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C911AF0AF;
	Mon,  9 Feb 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647639; cv=none; b=toVKoocTJPMO0IAowA9/zxELWAWfEEfC4M5dJHqd8+6zptIoK5Tk5HYHxuJHRNTCWFK+rkRPTwyQ9+2YGGRQxtQUOtT32xHImkTwbQQrlwCCACOgoIk95oFc3b1JtJsFr9djuLQRiIH4fqcnsc2TLQbk92CrtibD30WVB8Fh/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647639; c=relaxed/simple;
	bh=ePq5dkMqrF6EMbNJryRhyCA4CAWNNMTlUoIgYsWFTGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg++qcYXmrOV8LzbyCjNTESf7KLfJbZYuNzN7qyJ/HLY2aREQEBhOH6AxjtY2J43a15kVE7UtvvMdD5rdMy91EhgE8ddm/pB5g4oQ61h6mengwbbaaR9VMx2uzSfLa4y+jKOAvtsgWcP/inSFnkGWksh21vDZ/o6l8UXvOYcSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHsjMeIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565D3C116C6;
	Mon,  9 Feb 2026 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647639;
	bh=ePq5dkMqrF6EMbNJryRhyCA4CAWNNMTlUoIgYsWFTGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHsjMeImn30j4KOttVIYQLTJ9GMvici7qav6byMtfkZ2iHpbj7QyQMV7xnnjMwJ+4
	 vI8++C8y6nW6mehAo0zt67xssPPFPlj/0wEU/rNSjXrIux1jIZeB7YhAnm0IQZxrEC
	 1c1NSF8JbY+48sQ/C2m0Sbk6ubK82bS5yStvy1yA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 158/175] firmware: cs_dsp: Factor out common debugfs string read
Date: Mon,  9 Feb 2026 15:23:51 +0100
Message-ID: <20260209142326.177995005@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215089-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cirrus.com:email]
X-Rspamd-Queue-Id: DD39F110B3E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 78cfd833bc04c0398ca4cfc64704350aebe4d4c2 ]

cs_dsp_debugfs_wmfw_read() and cs_dsp_debugfs_bin_read() were identical
except for which struct member they printed. Move all this duplicated
code into a common function cs_dsp_debugfs_string_read().

The check for dsp->booted has been removed because this is redundant.
The two strings are set when the DSP is booted and cleared when the
DSP is powered-down.

Access to the string char * must be protected by the pwr_lock mutex. The
string is passed into cs_dsp_debugfs_string_read() as a pointer to the
char * so that the mutex lock can also be factored out into
cs_dsp_debugfs_string_read().

wmfw_file_name and bin_file_name members of struct cs_dsp have been
changed to const char *. It makes for a better API to pass a const
pointer into cs_dsp_debugfs_string_read().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://patch.msgid.link/20251120130640.1169780-2-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 10db9f6899dd ("firmware: cs_dsp: rate-limit log messages in KUnit builds")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/cirrus/cs_dsp.c       | 45 ++++++++++++--------------
 include/linux/firmware/cirrus/cs_dsp.h |  4 +--
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index f51047d8ea64f..58e41751dbc19 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -9,6 +9,7 @@
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -410,24 +411,30 @@ static void cs_dsp_debugfs_clear(struct cs_dsp *dsp)
 	dsp->bin_file_name = NULL;
 }
 
+static ssize_t cs_dsp_debugfs_string_read(struct cs_dsp *dsp,
+					  char __user *user_buf,
+					  size_t count, loff_t *ppos,
+					  const char **pstr)
+{
+	const char *str;
+
+	scoped_guard(mutex, &dsp->pwr_lock) {
+		str = *pstr;
+		if (!str)
+			return 0;
+
+		return simple_read_from_buffer(user_buf, count, ppos, str, strlen(str));
+	}
+}
+
 static ssize_t cs_dsp_debugfs_wmfw_read(struct file *file,
 					char __user *user_buf,
 					size_t count, loff_t *ppos)
 {
 	struct cs_dsp *dsp = file->private_data;
-	ssize_t ret;
 
-	mutex_lock(&dsp->pwr_lock);
-
-	if (!dsp->wmfw_file_name || !dsp->booted)
-		ret = 0;
-	else
-		ret = simple_read_from_buffer(user_buf, count, ppos,
-					      dsp->wmfw_file_name,
-					      strlen(dsp->wmfw_file_name));
-
-	mutex_unlock(&dsp->pwr_lock);
-	return ret;
+	return cs_dsp_debugfs_string_read(dsp, user_buf, count, ppos,
+					  &dsp->wmfw_file_name);
 }
 
 static ssize_t cs_dsp_debugfs_bin_read(struct file *file,
@@ -435,19 +442,9 @@ static ssize_t cs_dsp_debugfs_bin_read(struct file *file,
 				       size_t count, loff_t *ppos)
 {
 	struct cs_dsp *dsp = file->private_data;
-	ssize_t ret;
-
-	mutex_lock(&dsp->pwr_lock);
 
-	if (!dsp->bin_file_name || !dsp->booted)
-		ret = 0;
-	else
-		ret = simple_read_from_buffer(user_buf, count, ppos,
-					      dsp->bin_file_name,
-					      strlen(dsp->bin_file_name));
-
-	mutex_unlock(&dsp->pwr_lock);
-	return ret;
+	return cs_dsp_debugfs_string_read(dsp, user_buf, count, ppos,
+					  &dsp->bin_file_name);
 }
 
 static const struct {
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index a66eb7624730c..69959032f8f51 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -188,8 +188,8 @@ struct cs_dsp {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_root;
-	char *wmfw_file_name;
-	char *bin_file_name;
+	const char *wmfw_file_name;
+	const char *bin_file_name;
 #endif
 };
 
-- 
2.51.0




