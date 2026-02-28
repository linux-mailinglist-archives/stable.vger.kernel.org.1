Return-Path: <stable+bounces-220207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAerOlkso2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:56:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0F1C53E7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614EB3068144
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F64D98F3;
	Sat, 28 Feb 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0sbPQsE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E954D98E1;
	Sat, 28 Feb 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300112; cv=none; b=nmAysnzQmMWeJ8Z/DVlRRJH4ovnh7Dsx7ELHIVnXzc2qOtn0/REw9pX7FAnFuLdjOJTNbKJnijQ5eVnSdbBO9egYXhKBO5EwdIQvktchk+ucNHWWD2CuU7JEvw1zskCaDyEgPv2UHuEUhBME5rV+2ZKJt6S4kNLhi6GyMlm5YVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300112; c=relaxed/simple;
	bh=66nRdHdWaLc7C/fW+wYiSsFKUWY4bfYvWEp6G+IZgRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1Zo9ttRqbwpldqJhsRbtA5uodxC2oAPUGnxsuw1cgBQUJFd/vtcAhf3cV1oEBu/VbpwiM9NzbTAv9g6DOdsTCk6EuHmkQMyIrXjCeeYPoVVmbyFk+JVXbwhUDsLb89y2504cSZZio/vW5SlXKgBZi2Ua0+InGZvVuqQi9tZgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0sbPQsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AFEC116D0;
	Sat, 28 Feb 2026 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300112;
	bh=66nRdHdWaLc7C/fW+wYiSsFKUWY4bfYvWEp6G+IZgRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0sbPQsEeOZ9/VFdJOM+fzJkgygtDJKMucLlwgi8EZXOVSMutFo/PpeV2lTYz/Dbz
	 WTbTG0blw9M3ztx2Yoj4LR/ZU3QEyrEx4I/Va3zxtQ9DjWZqvqW8511cczuqE6SIxJ
	 gWIN68pNkNLvHIWAvvnZEoYpm6BCFIo6WYSqUK28ZLJe4L6F4a55YRIPbXvPij7s4k
	 xVShcNo9TH28wBvZidRRHf8iaRpfy+fZlLF+EWJpF5HONIj9a8A3eHMcN63risJVNV
	 pMIDlHbCUpBrZEZ7JWM0QWNNFZvBsd1Vwp4s6ghuhwgUvGrRRoOChzsnFfy+1zD1Tt
	 0uYCl2Bz2mpYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 129/844] accel/amdxdna: Fix tail-pointer polling in mailbox_get_msg()
Date: Sat, 28 Feb 2026 12:20:42 -0500
Message-ID: <20260228173244.1509663-130-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220207-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DC0F1C53E7
X-Rspamd-Action: no action

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit cd77d5a4aaf8c5c1d819f47cf814bf7d4920b0a2 ]

In mailbox_get_msg(), mailbox_reg_read_non_zero() is called to poll for a
non-zero tail pointer. This assumed that a zero value indicates an error.
However, certain corner cases legitimately produce a zero tail pointer.
To handle these cases, remove mailbox_reg_read_non_zero(). The zero tail
pointer will be treated as a valid rewind event.

Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20251204181603.793824-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 8b72cf6bd6e4d..469242ed82246 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -112,22 +112,6 @@ static u32 mailbox_reg_read(struct mailbox_channel *mb_chann, u32 mbox_reg)
 	return readl(ringbuf_addr);
 }
 
-static int mailbox_reg_read_non_zero(struct mailbox_channel *mb_chann, u32 mbox_reg, u32 *val)
-{
-	struct xdna_mailbox_res *mb_res = &mb_chann->mb->res;
-	void __iomem *ringbuf_addr = mb_res->mbox_base + mbox_reg;
-	int ret, value;
-
-	/* Poll till value is not zero */
-	ret = readx_poll_timeout(readl, ringbuf_addr, value,
-				 value, 1 /* us */, 100);
-	if (ret < 0)
-		return ret;
-
-	*val = value;
-	return 0;
-}
-
 static inline void
 mailbox_set_headptr(struct mailbox_channel *mb_chann, u32 headptr_val)
 {
@@ -291,8 +275,7 @@ static int mailbox_get_msg(struct mailbox_channel *mb_chann)
 	u32 start_addr;
 	int ret;
 
-	if (mailbox_reg_read_non_zero(mb_chann, mb_chann->res[CHAN_RES_I2X].mb_tail_ptr_reg, &tail))
-		return -EINVAL;
+	tail = mailbox_get_tailptr(mb_chann, CHAN_RES_I2X);
 	head = mb_chann->i2x_head;
 	ringbuf_size = mailbox_get_ringbuf_size(mb_chann, CHAN_RES_I2X);
 	start_addr = mb_chann->res[CHAN_RES_I2X].rb_start_addr;
-- 
2.51.0


