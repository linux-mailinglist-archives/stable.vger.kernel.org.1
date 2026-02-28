Return-Path: <stable+bounces-220140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGo8LP4qo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D91C523D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 498C53083ADC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23248AE3E;
	Sat, 28 Feb 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCBxTsdC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C648AE2F;
	Sat, 28 Feb 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300049; cv=none; b=jdX5EPE2ses1tjg1OLBU60B+bNCmi36Ky3uFAbou6KruYfdXvp8x+vPoN9ItukoDX9UeA6uIAT0DuN27U2fBc8+B7BYQuuzL+lhtdKT/8/yW+tYINTf4uygsGaj0q2qnJfH4EiJ2ODRDrY2ZEBbMjlcD7KqYOwaSe2/jxVFlfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300049; c=relaxed/simple;
	bh=WbOc48pJBDDfUlPeP7anR7Ynv05Vmmb383+6hK4/yFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTxtww2j9oHzLZrH35iJhKx8JKir34tfiMUAB8CDJTei18zXEkEDEhzkoTHVRz6YxgcTgT22fUG8NBeM1egD7VXoD1JPFKUTDjSLp17pl/nD3Tj3RTcILJqiPdzSVe1YeXORAhlDdjJ3nxRprky8m5AGyoQ+uqBEDgCOd36JsSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCBxTsdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACCCC19424;
	Sat, 28 Feb 2026 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300049;
	bh=WbOc48pJBDDfUlPeP7anR7Ynv05Vmmb383+6hK4/yFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCBxTsdCRwysuESwwwM+p1pgjRIN9f8DQiCs3w2JYn45hwDL8X7JubkxkNv8RY58Q
	 aE+uGnXFISfSgq7cHekrIMs/lrzOqZ8JyVhikTNe6PvMiVtRpRzDjxN0IWGsWAuSWp
	 tgSlTCujKoMMA2DaoAY4QdEfeGVtr+tUg24aKW2AjGZWoPwp2tcHWohriUaSstFdlu
	 UqJQ9HZIho5ftrpbdODjgvaIHoc9VpreMIQN0Bmx5FSkD4skVhcKIQONtNJDD8nri2
	 ju3d96OeaJ1cfOt9zOv/ffQHRBrPj0kzHHVlCTUawtZuJ8tQYc9UvvwdWWXDHCJlBz
	 8xqh4KiKKHsLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 062/844] rnbd-srv: Zero the rsp buffer before using it
Date: Sat, 28 Feb 2026 12:19:35 -0500
Message-ID: <20260228173244.1509663-63-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220140-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 592D91C523D
X-Rspamd-Action: no action

From: Md Haris Iqbal <haris.iqbal@ionos.com>

[ Upstream commit 69d26698e4fd44935510553809007151b2fe4db5 ]

Before using the data buffer to send back the response message, zero it
completely. This prevents any stray bytes to be picked up by the client
side when there the message is exchanged between different protocol
versions.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rnbd/rnbd-srv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 9b3fdc202e152..7eeb321d61402 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -551,6 +551,8 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 {
 	struct block_device *bdev = file_bdev(sess_dev->bdev_file);
 
+	memset(rsp, 0, sizeof(*rsp));
+
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
 	rsp->device_id = cpu_to_le32(sess_dev->device_id);
 	rsp->nsectors = cpu_to_le64(bdev_nr_sectors(bdev));
@@ -657,6 +659,7 @@ static void process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 
 	trace_process_msg_sess_info(srv_sess, sess_info_msg);
 
+	memset(rsp, 0, sizeof(*rsp));
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_SESS_INFO_RSP);
 	rsp->ver = srv_sess->ver;
 }
-- 
2.51.0


