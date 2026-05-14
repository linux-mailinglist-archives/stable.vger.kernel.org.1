Return-Path: <stable+bounces-247059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q5ViLG8VBWoUSQIAu9opvQ
	(envelope-from <stable+bounces-247059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:21:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B453C4BA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBB56302F762
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997425B2F4;
	Thu, 14 May 2026 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMLRDoOt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8751B86C7
	for <stable@vger.kernel.org>; Thu, 14 May 2026 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718056; cv=none; b=RzBul9aCfOgbtXycwKABwoy80N4BLQ1DSPLykArZINVyzb7aqQHNxChqZ6IKaAiJkK5P2oVGNvaiDRG2xUKUVJHx23GsdtWUeECngUA/Q1xWhiMny1zYeTVAie/55P8IrFDB4Zbs51Ycej7MZlhz9I8uIn1yLb6U1vQpA8NvbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718056; c=relaxed/simple;
	bh=bv9X9C6ybvBXVMAO8U6jO4EDYmS8S3AlJGFSYWl4PTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u7ZuUUBaLVWqfEG1ekt6XA9B3GOOkljoaEKtpsWU3x86F2lho+/2gpj0X4YANQxP3YqWqHI2IHjANh+DwlXHAQk8BRM0CfBhHfS1ghwBsiOSc/nR5m4kAAaJcGGirmY6cDR6XM0FS9R4YhPcu/qgGH/pjpKeumbVSy7vG5GgkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMLRDoOt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so3844102b3a.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 17:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778718054; x=1779322854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OP4TJnoSOJJLQkWv+kPmUFMD5Nz5E/Le8rvbutXj/wM=;
        b=NMLRDoOtQADaXjlatXW4cWY/7SiKGT8P3xTqlN1PjTVuaaf0ycwCTDYX+9/px/TEw3
         +74S+0Fk7QYgLHWDPp+LNVrTfXZ+37u4AL7wJUsH38WBYSbGhIsiGkk2OLnZW+/nOO1+
         QamTZ/T3XY186kx2QaBRJSdyvrqFBTBWNY1SAKS5nNbRQMBilkkuz1ixTfJXHdaaKv0h
         9b+PVlznyKv6SF3gmwCAlG4hyJ9KpOIWz95Hx44KhQr7WzzjsoB2JajLwcseRMuavHqp
         OEi4HDCylPC0Wvx39ON1yEi5RNSA2vguG9LAlB+THso0lvkAC4Pc/Z2r04L42Ut6VZ0b
         7jIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778718054; x=1779322854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP4TJnoSOJJLQkWv+kPmUFMD5Nz5E/Le8rvbutXj/wM=;
        b=gJ/o7bH9BHuce3VPWz5n2CsG6aHrUmnJRp+VcyuIo8EqS8WafvJ9S/fpbOSg+6w1Nl
         ubpXn6q4I6GiVSpznq+EO6IdrvNXwc04ne0/aqegLxImpKJae3FY4lMF9EGaYYx9hop2
         Vfn2guetEVmV3mRNfcHJNv4wplBZR/tEZYq7497kv1ukNX7RGtqSveGVxG1aOhLGk9mu
         VER7eV+KKwl0OFVLIhl0prsOd45SvfXHC+9X9hkoXnTN5nbetLJf/WFusmte55tbYevJ
         DhH/9JZdjroys26edl1TpuYE9XBMs+mb7NLqM7p9PXWsQEDGxgy7//UN4LWg0v04kVdD
         pceg==
X-Forwarded-Encrypted: i=1; AFNElJ+aFhI0Njfz5jJ/LLkTQVr3FTqc+C5y+zAbBCqG/uhFidEZTUp4+Z0A+wgY4Hv5a1P9rsZ4xW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cQQW+sstjHnhGqq2tbwQRqVgxZaBa41o6KUpopKO7v8gtEa7
	hfDQQTTDhAnT5XlHf+GCiHKh9dewYA5EHbVVlsYlTSNrJiHfcG4oy8shv8JJtSyU
X-Gm-Gg: Acq92OEorTf3l/59twT1Wz7xDXM2fgXycylig0hQOre2wFp8kiNQ6sXzuSaRrozXHLl
	k56dgs75Cv8U200+j2Ix6d+thHV+ZiwMBnVmPI5LkXz//NZSKDJqJBVJoSH8dMQ4RhAcFrVPgtE
	it0pvzCCvT381Lh8Sfq6swCMTHQwfncx9vDoi+F2A79cNd6tp5/zO7pHXrBHOaN4qIR3zQhdIo7
	8vnPjjfAfZUtvPQJc+rodXm3R0vXJOSaowJR0grQON+kfGSJE06WHa6P+tbHZwdIAtox9M00NxH
	W1sBuVKVzdhVK8Vw6IDJlkIjwHrKMBejs55kUPESgISb5wzUlAhOS7hWvPoO8mqeBxmleFzGo10
	sX7svlpiLrUImXFXTSTGEjJtXu1uSQEZVwkmvy1QjQir0JsR3kEJ8zwVcWEeQnCvgj5LyFl/Hyk
	AB4XXKs4knAXFKbDT7PoEpeIhDrjM8Z1hWGYSAYfRVhCrVb37ms7ARKPYgiHvbZQK5fZzFXeocw
	ofKzT6IBRHQyS3+
X-Received: by 2002:a05:6a00:10cf:b0:82f:49b5:cfc3 with SMTP id d2e1a72fcca58-83f18e6700dmr1291999b3a.18.1778718054293;
        Wed, 13 May 2026 17:20:54 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([203.194.102.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cca8sm668181b3a.56.2026.05.13.17.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 17:20:53 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: linux-media@vger.kernel.org
Cc: Moksh Panicker <mokshpanicker.7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] media: mxl111sf: fix null pointer dereference in mxl111sf_ctrl_msg
Date: Thu, 14 May 2026 00:19:13 +0000
Message-Id: <20260514001912.10580-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 171B453C4BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247059-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[mokshpanicker7@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When mxl111sf_ctrl_msg() is called during early probe, state->d
may not yet be initialized, causing a null pointer dereference in
dvb_usbv2_generic_write() when it accesses d->usb_mutex.

Add a null check for d before proceeding with the USB transfer.

Fixes: d90b336f3f65 ("[media] mxl111sf: Fix driver to use heap allocate buffers for USB messages")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/mxl111sf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf.c b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
index 870ac3c8b085..9908675c355e 100644
--- a/drivers/media/usb/dvb-usb-v2/mxl111sf.c
+++ b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
@@ -56,6 +56,9 @@ int mxl111sf_ctrl_msg(struct mxl111sf_state *state,
 	int wo = (rbuf == NULL || rlen == 0); /* write-only */
 	int ret;
 
+	if (!d)
+		return -ENODEV;
+
 	if (1 + wlen > MXL_MAX_XFER_SIZE) {
 		pr_warn("%s: len=%d is too big!\n", __func__, wlen);
 		return -EOPNOTSUPP;
-- 
2.34.1


