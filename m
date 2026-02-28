Return-Path: <stable+bounces-220669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPtnC20+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A11C6B64
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBDB93138551
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF948BD58;
	Sat, 28 Feb 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekk9+jcl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5B3F3254;
	Sat, 28 Feb 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300551; cv=none; b=iD/iJylXyc72cEAXEyJBjIT0tn276jXEWzOS0H4es0gJjvIwgGducSwevl7mDZkljcfiM8TFlCdTWTWcEnVl8mXeXMgcpxSzQ28siVxCDqXMyM4EwVi9T8V7y7IOqovjo/UzZWUOZJmIGfPX//fOctsrmlnS1OFNDDmVt00+rw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300551; c=relaxed/simple;
	bh=C61+88oPQ2DdJ12m9Oocrh9SBD0mftXNOwo8mXk41Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAWR8+yplkU3rKflvMhpLkC0PRfvmL1LGNAkXtqYYSOP21hnX3xfwFgeEZJHkgkImgIVL+wLR3bFwhVQLtoClmyV3HSO9slocwT07uKqRbIMMXI5mqExWNh+y9aJn65C6zxV32M4sbjoLHPVaYtiiJ6LsAPVcAD2HT5dzk6tBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekk9+jcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD95C19424;
	Sat, 28 Feb 2026 17:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300550;
	bh=C61+88oPQ2DdJ12m9Oocrh9SBD0mftXNOwo8mXk41Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekk9+jclZhSC84aAzOnnoetbuQkhurQBK6X6vqCQc8j0qj6lWFN+e4XvppSSR9GxB
	 M+mza6teMScpeZkyGcXxbaw65Qj4tfDrjB8lSHi/8G3IK3R8G/erFgrMIc2qIVnPHM
	 oOrV7hJrA2Ad30xdRH822jrvivQqiKLixZUec+4pDIr5gRZgOHH6wY/DerqFdhM0Cg
	 p2uUnSfmAIY53j7e6moe0iGPYOMTlauI+6Vfy2jUmUKPrFdoMOfao5wnl65H1Q3O1E
	 Nx61QFWRjpk8oPkI8iL1wZXc2Rl0j0fquiw/5xsaFTPgqdCAtoo9PrL7cDAP4t32oq
	 CWYkhkcRuVuuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 590/844] media: i2c: ov5647: use our own mutex for the ctrl lock
Date: Sat, 28 Feb 2026 12:28:23 -0500
Message-ID: <20260228173244.1509663-591-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220669-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,windriver.com:email]
X-Rspamd-Queue-Id: CF9A11C6B64
X-Rspamd-Action: no action

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit 973e42fd5d2b397bff34f0c249014902dbf65912 ]

__v4l2_ctrl_handler_setup() and __v4l2_ctrl_modify_range() contains an
assertion to verify that the v4l2_ctrl_handler::lock is held, as it should
only be called when the lock has already been acquired. Therefore use our
own mutex for the ctrl lock, otherwise a warning will be reported.

Fixes: 4974c2f19fd8 ("media: ov5647: Support gain, exposure and AWB controls")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
[Sakari Ailus: Fix a minor conflict.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5647.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index bf5b0bd8d6acb..5fb10e02ba6e2 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1291,6 +1291,8 @@ static int ov5647_init_controls(struct ov5647 *sensor)
 
 	v4l2_ctrl_handler_init(&sensor->ctrls, 9);
 
+	sensor->ctrls.lock = &sensor->lock;
+
 	v4l2_ctrl_new_std(&sensor->ctrls, &ov5647_ctrl_ops,
 			  V4L2_CID_AUTOGAIN, 0, 1, 1, 0);
 
-- 
2.51.0


