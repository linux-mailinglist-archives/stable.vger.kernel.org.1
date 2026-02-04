Return-Path: <stable+bounces-213664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFd0Ajxhg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:09:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3B1E807F
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0476331B9BCD
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C242189A;
	Wed,  4 Feb 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lFchV/kW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033342189E;
	Wed,  4 Feb 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217093; cv=none; b=Et4t2Mrw/CARhmljFViKgd+XoYo/1obHIV99RLsUOrphADyOCCXKW/r5l+YEhpjIIb22YegZ2Smb4z6Rn6gH4kY94YhMpHKW0FqyygNud8NAmCkUuTfSDfn9A8Xz7BZn96/3ePmW45DyDsBz15JVcrHh1wD0Kzg9KMWCSsZSQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217093; c=relaxed/simple;
	bh=cFUWboxcQWUu2I1/fbBFGI1MRO+A11JOtvwLJPaHiOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqQvRdjKQQ1HyvZCh1LJ1pEBUujcrwSqzhXUvCaaxiTRzA4jkrKoBjUf156nvi3kpKxUdp1/zRf5ApWLJYDFV86A1Hg/Q2KigwItqmvE/lOJ10YM6zMCTyASs6nUMurWvve94dfb5g7lHYrmKN7OamafJmJ1hJKZdMPGC5w+muY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lFchV/kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6EEC4CEF7;
	Wed,  4 Feb 2026 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217092;
	bh=cFUWboxcQWUu2I1/fbBFGI1MRO+A11JOtvwLJPaHiOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFchV/kWdWeEANTYUdOnkGgJ/pJXvVxXx1Y8yrRMFl2/wfuFJ2bHHTRa8FZVq+QEh
	 MwIyIIqoA/K/PvaPMfdWg3P7V5YIZ65A+YH/1ZWEE3Ug9vGYlyP1aegmfmGyrBxjqI
	 CEAJ4d95AfY+bblwZrYoOfoWT9cMvClA+6UzpaRA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.15 121/206] intel_th: fix device leak on output open()
Date: Wed,  4 Feb 2026 15:39:12 +0100
Message-ID: <20260204143902.559841597@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213664-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 8F3B1E807F
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 95fc36a234da24bbc5f476f8104a5a15f99ed3e3 upstream.

Make sure to drop the reference taken when looking up the th device
during output device open() on errors and on close().

Note that a recent commit fixed the leak in a couple of open() error
paths but not all of them, and the reference is still leaking on
successful open().

Fixes: 39f4034693b7 ("intel_th: Add driver infrastructure for Intel(R) Trace Hub devices")
Fixes: 6d5925b667e4 ("intel_th: Fix error handling in intel_th_output_open")
Cc: stable@vger.kernel.org	# 4.4: 6d5925b667e4
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251208153524.68637-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/core.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -810,9 +810,12 @@ static int intel_th_output_open(struct i
 	int err;
 
 	dev = bus_find_device_by_devt(&intel_th_bus, inode->i_rdev);
-	if (!dev || !dev->driver) {
+	if (!dev)
+		return -ENODEV;
+
+	if (!dev->driver) {
 		err = -ENODEV;
-		goto out_no_device;
+		goto out_put_device;
 	}
 
 	thdrv = to_intel_th_driver(dev->driver);
@@ -836,12 +839,22 @@ static int intel_th_output_open(struct i
 
 out_put_device:
 	put_device(dev);
-out_no_device:
+
 	return err;
 }
 
+static int intel_th_output_release(struct inode *inode, struct file *file)
+{
+	struct intel_th_device *thdev = file->private_data;
+
+	put_device(&thdev->dev);
+
+	return 0;
+}
+
 static const struct file_operations intel_th_output_fops = {
 	.open	= intel_th_output_open,
+	.release = intel_th_output_release,
 	.llseek	= noop_llseek,
 };
 



