Return-Path: <stable+bounces-244929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP/dD5j5/mng0gAAu9opvQ
	(envelope-from <stable+bounces-244929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:08:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E01C4FEEA6
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B75AD3021EAA
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5A396D2E;
	Sat,  9 May 2026 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS03eU+f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E47394798
	for <stable@vger.kernel.org>; Sat,  9 May 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317682; cv=none; b=Rm6zyTYTbveufBsUsuE+lzR+uph2oSnmk5qc+QdM56LblFuRpb2OKWAGZnvlEXHAn5kxKBxH3Y9W9KeP9rV2Wa7KLF/2YfK5PLN1OUoVklxvke9efY2RShr/nxwO2k4chvZOIFftEjly84swYeg+KEYgOWB8KYakZIRyLEY8BNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317682; c=relaxed/simple;
	bh=53cYyYht/soeuO5KFqJFX6vHx2UoqktFa4Lu7Fk2vjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+Vf/eLjV/kGH/v/j3br7dhNcL2WrxRVOnEN+v8ZBXJ5xt39h+RAhsfriYNuEOpuMdrthaAwi6Y/mBJvJomnRC17dgPgQSP7fBEB2B2GF888noywZJ3uQo8vPIAaHMu3uX1uMmTcwLaesOR1+WOQdfWhRNFufwagYmzZmQdpQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS03eU+f; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7ffe8eeaf2so1081903a12.0
        for <stable@vger.kernel.org>; Sat, 09 May 2026 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317680; x=1778922480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdT4OBJcuomd9E3A4aT3gb4oBTIrTjenadY5V0QZCts=;
        b=dS03eU+fEB9vNU4sSb9P0isOpRZXDWdD+UxTU8RBBGvNosDb6/JOWjjrv47xHDyYBW
         qNsPOxJov8LzP+/qmH4JDINm1/bJ+/PFL9UrzPh2YI6Q8q9MJs1oiBL75QL1CFTkVY3p
         aIIqJEkSSOB4qZ9ALw2PqMmpWgElOFb/9hXmhKLS+BUQrPX8wyYJVn02Jh1pJ50kWih4
         LyaiAthU7iuRK3C0+Bi7VJVxziRwh3AbFcrgSvcEgrcbJhvJy7AA/eTwu4R3oL+EG0iP
         cL5bqEaUttltJAA5NugLvMPsWHsPN/NvbURREWHnYb0GGjxLC5vPw7Duw7yfvE3t3ixt
         eHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317680; x=1778922480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VdT4OBJcuomd9E3A4aT3gb4oBTIrTjenadY5V0QZCts=;
        b=SoRcGiJXRv18Q+Z9R0mrynG70GFVzEen9lOTXJZ8/jy60Ud4Num6OUYnd1pY4HwhqU
         bZ7o5WZD3E5tJHgMsrLuRwqDFmtGg5FAetxo6F846c92tFMgga+1xII1fGNkXLSVGG5k
         DeNYlHDyd6qPwRggsn2DBUZwX5wRFN9oHIilu5onargbe9+ai4QuGB4MQSsE+AJOi75E
         y0ePixM2PCuWigf/fWIJD6votn4cNJGycMHHXjbGbYfm0anP8pmHFUb0ASPIzzhVgweq
         JbtkBUvgn/1VFm+RSbEKwPtz48QAwHG7nxZSFk46K2P7+xxRCqjIRtHu7kxwG//5aNnL
         j0EA==
X-Gm-Message-State: AOJu0YzeL45iUVnDHHuQoVG7bphAgbWLPFe+57EhcEBe4tMiFZHIxFu4
	ptajHy4K7pHN4zeOwCP98bbbUvNCJ1RIwZ0G2Zw3WHSgEdRkk2b1GHeq
X-Gm-Gg: Acq92OFDbTR7tn+Ray3sRH0dO5HqyVypkWRvICb0UnRx1GvLlYOsV1MpWd7GXvk5N92
	EzW1TOocrrzOyWFVwxsqBIHwaFxQ6vHwjJyLP+crBVlAzES4uHE8OTF8PAge0IuLwKpR92mG7Lh
	FYJSnuJpcbgfq5HJBs+7KplpEuK+cHBI5zV95vcB2WECG+yJuXtMZ35ISkE2ZvoJ27QOKLFaMak
	+SwISIQDrVZrekaP/6yixTDV+ifuIc2NifMLCp0MROMxbSdGSItRX15y+8tutU2tya/kF2CJb4g
	Eq8PEcYzl2z0c1hTWb4gEV6bPZZcbkxnuAqSeZqWf4O28ZQcAxIiSU7l66kQzI0mnlDc2EtW4gy
	Js7VmG12GERUa8pikXSDrnQmDm5lmtYZ4yD9Cisz655GXBYSFnoE3l4v2x8P+SJPd/RABGISlFN
	HSAnfpdEyE+BBa3En3/egZf+Wuo1v0IoQlgAZMdct80mY0RaNJC+XW+ldGaenTfg==
X-Received: by 2002:a17:90b:1350:b0:367:bc89:5470 with SMTP id 98e67ed59e1d1-367bc895568mr4211331a91.12.1778317680117;
        Sat, 09 May 2026 02:08:00 -0700 (PDT)
Received: from PC.localdomain (softbank060090219114.bbtec.net. [60.90.219.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d687bedesm2140510a91.16.2026.05.09.02.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:07:59 -0700 (PDT)
From: Rion Kiguchi <kiguchi.r.sec@gmail.com>
To: kiguchi.r.sec@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3] staging: vme_user: validate slave window size against buffer size
Date: Sat,  9 May 2026 18:07:21 +0900
Message-ID: <20260509090721.1136091-1-kiguchi.r.sec@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050935-designing-glancing-2e16@gregkh>
References: <2026050935-designing-glancing-2e16@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E01C4FEEA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244929-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiguchirsec@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The VME_SET_SLAVE ioctl in drivers/staging/vme_user/vme_user.c accepts
a user-controlled slave.size and forwards it to vme_slave_set() without
comparing it against image[minor].size_buf. The slave-image kernel
buffer is allocated at probe time with a fixed size of PCI_BUF_SIZE
(0x20000 / 128 KiB), but the configured VME window size can be made
much larger via the ioctl.

The subsequent read() / write() handlers (vme_user_read /
vme_user_write) clamp the I/O range against vme_get_size(), which
returns the size the bridge driver has programmed for the window
(i.e. the attacker-supplied slave.size). vme_get_size() does not
consult size_buf, so an oversized window passes the existing bounds
checks, and buffer_to_user() / buffer_from_user() then index
image[minor].kern_buf with offsets beyond the actual allocation.

Result: a local user with read/write access to /dev/bus/vme/s* can
trigger out-of-bounds read and write of the kernel slab adjacent to
the slave-image buffer.

Fix: reject slave.size > size_buf in the VME_SET_SLAVE handler.
With this check in place, the existing bounds checks in
vme_user_read() / vme_user_write() against vme_get_size() are
sufficient to prevent OOB access; no additional checks in
buffer_to_user() / buffer_from_user() are needed.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Rion Kiguchi <kiguchi.r.sec@gmail.com>
---
 drivers/staging/vme_user/vme_user.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 11e25c2f6..6fd051f49 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -394,6 +394,14 @@ static int vme_user_ioctl(struct inode *inode, struct file *file,
 				return -EFAULT;
 			}
 
+			/*
+			 * Reject window sizes larger than the kernel buffer
+			 * allocated at probe time, otherwise subsequent
+			 * read/write would access memory beyond kern_buf.
+			 */
+			if (slave.size > image[minor].size_buf)
+				return -EINVAL;
+
 			/* XXX	We do not want to push aspace, cycle and width
 			 *	to userspace as they are
 			 */
@@ -401,7 +409,6 @@ static int vme_user_ioctl(struct inode *inode, struct file *file,
 				slave.enable, slave.vme_addr, slave.size,
 				image[minor].pci_buf, slave.aspace,
 				slave.cycle);
-
 			break;
 		}
 		break;
-- 
2.43.0


