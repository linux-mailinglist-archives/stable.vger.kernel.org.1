Return-Path: <stable+bounces-212592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I1EAd47emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:39:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42064A5F67
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F56323115E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F9286D4B;
	Wed, 28 Jan 2026 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tkKD9A7C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABB81AA8;
	Wed, 28 Jan 2026 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616035; cv=none; b=c6/S3cyPUBXtJB8wHyjX0Dy1+6QDm/XlFfWKYmNlLgP6C9wykU04+nsTuAN4vYIzBoi3EEPEZFJxEaQNSwJjxhK35AzKBAIsyXTdRCT20enSwmvEJgrcQV4uyKenpr+KTYIbwN1mBKJck2QL+1i7aF9zWBwdhcJqLng+oBEu/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616035; c=relaxed/simple;
	bh=lD0QduN87EJ/+R32hA+u3D/v8/+B9rOZ8lb2frC1VRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmcVPZg/52aBvDCMlcVQtCtjSolAAWNtpzCogqcDcsSooobCIsJiT/SQpaou1IiSco9TBWQT+AYg2xQYCZ+IxSCWY7oF3EWpUEzXdTggqGOey82ZQ3OTyqWzrMl8Xo3mEn6vIcO4e+Ie+7lIBn+XZupwGO9ZHTWR+mqq1UpFU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tkKD9A7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD02C4CEF1;
	Wed, 28 Jan 2026 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616035;
	bh=lD0QduN87EJ/+R32hA+u3D/v8/+B9rOZ8lb2frC1VRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tkKD9A7ChjoJAsO4OGzQOQ16VY09hRUgEyzTaJsYhxGD9r2zRut0r2weo42bXJ94m
	 JVQ/w7QJN/w0gzBy5Fq6xUEyULNK6lPOfjeLBNn/Yoe4jueJVSX7OT13G0DtPcU4wj
	 jRlm9ygJnHj6A9o0tC6+FXgtkareyF0O9xt4SYMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.18 187/227] intel_th: fix device leak on output open()
Date: Wed, 28 Jan 2026 16:23:52 +0100
Message-ID: <20260128145351.174564265@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-212592-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 42064A5F67
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
 



