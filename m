Return-Path: <stable+bounces-236479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAWSGaYa3WknaAkAu9opvQ
	(envelope-from <stable+bounces-236479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:32:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E6B3EF326
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 129BA31AB8F4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658962FE056;
	Mon, 13 Apr 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GquOo9bm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6624DCF6;
	Mon, 13 Apr 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097011; cv=none; b=m5Co84zsGcJXDMVn+XriJ5SRlYPZuB/RLx9OUAaHAvjayQZRN77opf/PlBaYn1S8KSAzWHazCvmoCSCF+geqqkHnte0d1knyPswtoAgRRrKAUPvrTfVGA357R8Jam56kJRUAmOcBboBLnvLmLW5QuCdece8GG7cMjgUq4YXjeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097011; c=relaxed/simple;
	bh=kHP0zIm6v84eNyoqHL4Q0O0ry6ugPJ15Lk0WtNSlfw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffpsSWhESs3T0Q4KRksJ7aZZpTlK8pVywoX05MjOZvUjSCrkagrK1L5/7oWDwd0LXnhlUSBnxOiT0AzGTj9hOy+jaETB8ZIwkddFIFzv+JirWODG8vki2lH9MMJjO9UixrYKQl3FMl8U0zVNunK7PJ+U1XLunTz+/xZvnFOuNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GquOo9bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3321C2BCAF;
	Mon, 13 Apr 2026 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097011;
	bh=kHP0zIm6v84eNyoqHL4Q0O0ry6ugPJ15Lk0WtNSlfw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GquOo9bmHtD27ojyrgsOdIx+5yfu/y+O9oEwF76grVFRi1xz+VlwaZM6PumDe2QUS
	 2BKBbNyfN4hzlh05xImEKVCBhTJuANy5gWLPNeIp75CnwiO5DfXIay2ZlCcPVoneNC
	 LCNu1jKnorONK3RpH0wSFWanA09yOS4VuPly4m3U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bo Liu <liubo03@inspur.com>,
	Simon Horman <simon.horman@corigine.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 28/55] rfkill: Use sysfs_emit() to instead of sprintf()
Date: Mon, 13 Apr 2026 18:01:02 +0200
Message-ID: <20260413155725.882514917@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
References: <20260413155724.820472494@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236479-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,inspur.com:email]
X-Rspamd-Queue-Id: 79E6B3EF326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bo Liu <liubo03@inspur.com>

[ Upstream commit 796703baead0c2862f7f2ebb9b177590af533035 ]

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Bo Liu <liubo03@inspur.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230206081641.3193-1-liubo03@inspur.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: ea245d78dec5 ("net: rfkill: prevent unlimited numbers of rfkill events from being created")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rfkill/core.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -685,7 +685,7 @@ static ssize_t name_show(struct device *
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%s\n", rfkill->name);
+	return sysfs_emit(buf, "%s\n", rfkill->name);
 }
 static DEVICE_ATTR_RO(name);
 
@@ -694,7 +694,7 @@ static ssize_t type_show(struct device *
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%s\n", rfkill_types[rfkill->type]);
+	return sysfs_emit(buf, "%s\n", rfkill_types[rfkill->type]);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -703,7 +703,7 @@ static ssize_t index_show(struct device
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", rfkill->idx);
+	return sysfs_emit(buf, "%d\n", rfkill->idx);
 }
 static DEVICE_ATTR_RO(index);
 
@@ -712,7 +712,7 @@ static ssize_t persistent_show(struct de
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", rfkill->persistent);
+	return sysfs_emit(buf, "%d\n", rfkill->persistent);
 }
 static DEVICE_ATTR_RO(persistent);
 
@@ -721,7 +721,7 @@ static ssize_t hard_show(struct device *
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_HW) ? 1 : 0 );
+	return sysfs_emit(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_HW) ? 1 : 0);
 }
 static DEVICE_ATTR_RO(hard);
 
@@ -730,7 +730,7 @@ static ssize_t soft_show(struct device *
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_SW) ? 1 : 0 );
+	return sysfs_emit(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_SW) ? 1 : 0);
 }
 
 static ssize_t soft_store(struct device *dev, struct device_attribute *attr,
@@ -764,7 +764,7 @@ static ssize_t hard_block_reasons_show(s
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "0x%lx\n", rfkill->hard_block_reasons);
+	return sysfs_emit(buf, "0x%lx\n", rfkill->hard_block_reasons);
 }
 static DEVICE_ATTR_RO(hard_block_reasons);
 
@@ -783,7 +783,7 @@ static ssize_t state_show(struct device
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", user_state_from_blocked(rfkill->state));
+	return sysfs_emit(buf, "%d\n", user_state_from_blocked(rfkill->state));
 }
 
 static ssize_t state_store(struct device *dev, struct device_attribute *attr,



