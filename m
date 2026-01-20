Return-Path: <stable+bounces-210480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMzSCppNcWkahAAAu9opvQ
	(envelope-from <stable+bounces-210480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:05:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E75E76B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90A2750ACAC
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D517D3F23D0;
	Tue, 20 Jan 2026 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3lM8UTA"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9F3F0762
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905711; cv=none; b=V8gKUI7sGJCXowhCv7OGgZLnPOQtOmoDJPG3GbAZN1Lc//Y9xDNQvBXox56XuLvbHw2XLo44x6pd4v8aRpVOEyIvvqvsOCcpr+srjUQ2UtAEO+JlJ7oqopqKyglX6QDXLPhYezmD3hPf+ZZa1bxLBzjK2sQhv+Slw3DKspStGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905711; c=relaxed/simple;
	bh=Ohb12pnkwdIT0Jne9UD+YNvgkmu2s71UxSfrE5BWiRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTqCGwrw9WiD3HGFBbbYxI2ezihdXctwh/Iuz1ueTnFNUNSNAAkAkB0TsQsj7s0/ac02lyuKVZPXis5s5D6GHy49kkdlrZJRLos5D79B6kscPurMg0qlow7jPV3oA84VYI24330Xr32dugC+mcrn3HBFNOZsx+YvlF+pAQJg1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3lM8UTA; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so2984758eec.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 02:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768905708; x=1769510508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fV/jHAHpW8XRaZZ0Qo+rv9A5isuApYKvNLSlJGZZqHI=;
        b=S3lM8UTAhiG+Fabdt5BFQhczEsxaAFfcpUZ2wIVXmw/QuHHMdYtpd0lrn1bzVIvpAl
         yVn4WiQagiDVcDGYioIbhfHAvjfIiasLDDm3jW+mN5xVn7/lS6kfDUZMpSo+HcM2UCip
         OJJDxDzSBUSHJK+PAHQVXGmcaJz/Ttp2DvNbSx0Hp8yEmAr+UFZhiBVQUfyhIKF02dH1
         SZdQ6V+gJ+So3tZzRE9wReWX3zhjkoOW4dxQd20crlzfEDBFhG+S2SYRa/8eL7yIZwWw
         OBQaRIdHth7AtVwZrm+ASKUiI89vI8pBwF3lM1HwItQdTPRMvboeYpPbzC9WvnDK5qcI
         XJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768905708; x=1769510508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV/jHAHpW8XRaZZ0Qo+rv9A5isuApYKvNLSlJGZZqHI=;
        b=hgP+hJSfdsG0qCIyW3O1sDe/aUqSPsvfyx/gU0TprW24PALe4wZ1pzCHhNKaSUTURt
         15qLFEta2anglWsJuklZxJZ5FQPuLIArGXPCIjhYNpFBzD2aYbaOfOA9sAkFiHb9QhhO
         WGhZOc8hIaO5QMrtW8JUqJoQpOWasUu525nJQRmdggLKaZZexifyfvegx3SkV3y/w0ri
         wMc2jdeNozNt94U59Q01ZE9yeW+9KjzRchkkZpnWe6erHRMduCh78SSzmgPr5w1fsA4V
         fg68ECW3IaerDlds724mao/wmjQQUm2bTEkDvT3JDhVYb0LPkyv0LJJ4DCNwt38WZeKZ
         8eFg==
X-Forwarded-Encrypted: i=1; AJvYcCV/mtQk0fiQ0/XGg0fcE7+I7SoXfx/BAnJXomzwcTGfyHewZQ4Ev4iR3KhSXhIkpxfRn4rep48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx19uIWmptQwpimt2iUDcmUB3Upp6Us/TVJD+EDrAgDIPeibL3R
	CCUP7OC32jrkdQsBV2MbYS6C4N9hScW2Ch9fDZyzJFc8gVcOsvHC87wo
X-Gm-Gg: AZuq6aI0cX1IEvW0mGlx7R0xOaLMnRqBFKBxLzxpmnQ3h/9A97px24uK1vqoOpW1XCv
	9es594yUe7rzHIaJePur7UW2kC52+nUNMknYNAwbLDLZD/VbwbQWoR4Smbl3vbhLff0y1M7iDWi
	Y8gmu2dA5mxNdJlbH46UVbivIUcTQb2Nu3UyFmhEhvIXFu+ETpV08bM15mbcm+S4QDlrHnjcl8V
	abIRoHgilxEw1OWnJcNsnPPnjyFAh8JVIucG5CvNFt4/UB3Q9bjLKfYCFVEafGZyP2PoK6LfGSL
	8rqlIdOVii7g9tW5H7W3v0ibOKelbaANzHcZGxNiQU4+jLoWIiJFSHuOVvCl4cQSmn5FFDiOJPK
	OQbe7o/wid2Q/l8S+3DQYIAFIbfQUqoTwbJ1ee9U0ext9/tFgJjdpAObfCLmb8toTKYCX7cJ+a4
	CtRCfaSLeaKZ8MFZJBLYlNJmBockU0fpsQuxr3FmpnMoE5gt6LksvHG/LoBzDsBs7zN9sw6wxTm
	/IkHILCegnXcWJFp62/MC28Rd8yiKoZW/mXxLhAJZDVbFc1CP1W3zyIag==
X-Received: by 2002:a05:7301:9e43:b0:2ae:56ef:c85d with SMTP id 5a478bee46e88-2b6b34b2b47mr9729558eec.9.1768905707610;
        Tue, 20 Jan 2026 02:41:47 -0800 (PST)
Received: from 2045L.localdomain (70.sub-75-229-220.myvzw.com. [75.229.220.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36564ffsm16521853eec.28.2026.01.20.02.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:41:47 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: mchehab@kernel.org
Cc: hverkuil+cisco@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: dvb_demux: fix potential TOCTOU race conditions
Date: Tue, 20 Jan 2026 18:41:28 +0800
Message-ID: <20260120104129.105079-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[35];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210480-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A69E75E76B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dvb_demux functions handle frontend connectivity without holding
dvbdemux->mutex during checks, leading to TOCTOU race conditions. In
dvbdmx_write(), a concurrent dvbdmx_disconnect_frontend() can set
demux->frontend to NULL after the check, causing a potential NULL pointer
dereference. In dvbdmx_connect_frontend(), a concurrent connection could
set the frontend between the check and the lock. This allows the second
caller to overwrite the existing frontend, leading to resource leaks.
The dvb_demux module should use its own mutex to ensure thread safety
for these internal state checks.

Fix this by extending the lock scope. Move the frontend state checks
inside the dvbdemux->mutex critical section to ensure the state remains
stable during the operation.

This possible bug was found by our experimental static analysis tool,
which analyzes lock usage to detect TOCTOU issues.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 drivers/media/dvb-core/dvb_demux.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
index 290fc7961647..e9e833285f0f 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -1147,15 +1147,18 @@ static int dvbdmx_write(struct dmx_demux *demux, const char __user *buf, size_t
 	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 	void *p;
 
-	if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE))
+	if (mutex_lock_interruptible(&dvbdemux->mutex))
+		return -ERESTARTSYS;
+
+	if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE)) {
+		mutex_unlock(&dvbdemux->mutex);
 		return -EINVAL;
+	}
 
 	p = memdup_user(buf, count);
-	if (IS_ERR(p))
+	if (IS_ERR(p)) {
+		mutex_unlock(&dvbdemux->mutex);
 		return PTR_ERR(p);
-	if (mutex_lock_interruptible(&dvbdemux->mutex)) {
-		kfree(p);
-		return -ERESTARTSYS;
 	}
 	dvb_dmx_swfilter(dvbdemux, p, count);
 	kfree(p);
@@ -1208,11 +1211,13 @@ static int dvbdmx_connect_frontend(struct dmx_demux *demux,
 {
 	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 
-	if (demux->frontend)
-		return -EINVAL;
-
 	mutex_lock(&dvbdemux->mutex);
 
+	if (demux->frontend) {
+		mutex_unlock(&dvbdemux->mutex);
+		return -EINVAL;
+	}
+
 	demux->frontend = frontend;
 	mutex_unlock(&dvbdemux->mutex);
 	return 0;
-- 
2.43.0


