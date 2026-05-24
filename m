Return-Path: <stable+bounces-254030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hXRsI6ICE2pR6AYAu9opvQ
	(envelope-from <stable+bounces-254030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:52:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F75C29FF
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DB43300C9B1
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A539890A;
	Sun, 24 May 2026 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyY+gvSV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0CF397B06
	for <stable@vger.kernel.org>; Sun, 24 May 2026 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779630731; cv=none; b=QH6rB9nmh/6Xydtrj+rop7REw0X/8EbJ0bA2Ajxf/dKBW1Rl7XaWhORZR5HOvwEcATzDtdCvcuzgqRhcGc8gQfOWiWzd4NruIBHERQfrVXi/+u2jLN+Dy/4deB9T84rtyO+PqGh6e43ff5PLapU7b863UhMwOsM9I/wSV1Uj+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779630731; c=relaxed/simple;
	bh=ZgbH/mYUb/Nhi5/awpSI/okcaOUUQIeFVWLGt9Vv3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8d/HuXiNtBs9OOQDlRlIW5nb5ZTbc8ppwi5tt9LguGnGAdAUspiPyfEIZU1FdKAoWX8+nsk7JTh2Cngd/xYnHIb+VO3uM/wGy6Mk8A5YG3OdVD651F2ao6lXTZdZufT5DJZboqR4riK78xBxHYLZ4zDYfT3XnoZpnvZDst8NGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyY+gvSV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so7990204a91.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779630730; x=1780235530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDBQfFLHNH4Mc08Xf81Bh0XesibRVNF/v0oW8QDjjcY=;
        b=GyY+gvSV2MWdyLkCMLNrPgL5l+9X3MT/lCy5Gj5rIYWufcjttEoU4txXApyV/pLGIy
         eg7s4Vd5zp7CFz+1d4PwFJzb7PuxvnKg+T9lMT6IKjsZZj34FKzTeJ3Gm6JM9tJPyix6
         dVa+Pnr4bz1VpJ9rVR14rDmp7kpm5zEM0UIwLI4fK+e9iwCbirdJUkhn+v4zRiO1w8tL
         b77n9HpQ1z447urws8H2EBemvGLe2b4BhmejFjcAnjQbwIFTS8cjitgGB3xSkP/03Fpv
         qO/sicmX/D5Ag0fC8IIUWlZvQoIabW2GxPsE1KZUgj5pC3rj3THBbU3BN3t0/1/jpAJM
         SyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779630730; x=1780235530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDBQfFLHNH4Mc08Xf81Bh0XesibRVNF/v0oW8QDjjcY=;
        b=tLQgAFpcJ0zMvHje7aS3cwJ69m/zLgVNLqRKPc71gJkq2SNWmvTwo885Q+oCqxsMWE
         SjHWBrsPjtNSOSpDDxhNKKwrqZDsby5Yrchi0kLTCVMzX2G6sc2P88NOHK7g5rg0V4ME
         XK3ffhBlpOKMEuFsyF8xLNw142Ux1kxm1mhECUUunwNiYRBfTLUwBUtrGehdok37i04E
         KuqwjxjAcKuuNjGaOe86MOyY7jdWhSWMqeHq3fCampTs21UFDTmM7iivtss3XXvBgDml
         1wSCCST7iGPaXRB/Bz2LCG4vPQunDZeslCdJm0vFkZp+YcxWPqC14WZ+aLDss0r3Ls24
         cKBw==
X-Forwarded-Encrypted: i=1; AFNElJ8+yh7A+hsPKd3/twclO4adXT3HGvGNQbwyhrgo8tHRdXtRdQ5Tsn8lxH5+PUU8mWsVbvQuC4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5+WNvlVammawamCHxp8bMzajzvuCRuA1QWYAV1ENWAyySfOi
	O6WVrkoZHykf6JZSNwHb9e3KThzNpGIFuEXQfQXVvHQdxt5oseaMqTxk
X-Gm-Gg: Acq92OF4kAB2ivxLkZZ37R3ANUWg91MFAynMscPslOKT6e6qngK3LIF89QvZ9zG+rhc
	HqQEZ1rjcfCNOVDoE+AD/mAW+nhQiuQYv0769sbzX5GP+9h8kp6f/EAjtHem8xDSwOD52WoXo5G
	ZN54ca0EmovWyFYBTJ8gq+UVFnN6vV3aSxNqoEi3keTz0HsKUMqSdLFEnasYOOLSq+H5GJHe9w+
	avI3cct1xQh9QuTs8i8odp5IHvDCECFIFBU45YcU7XwtVkEh8zP7YC2IZ0Hx5lGufV50M00p8Mb
	peKzLeBm39Ej8BAh7AmJxq6/BfELgmewqx3giHQlfCHP7eFNzpzxtPnO5K38Khetd86YQhx1Q/O
	J6wCo98jbUf2Tmxb7puSQfEAwBQnPA/PKbJx6ykjTtC8kApYoYgvbdD8bfmqDowWVkUjo5+NIRw
	S7dQogE5wjkshdvpcmUtydBcnNqDeOvKTk1zlg6+e5qfx0Zd3k
X-Received: by 2002:a17:90a:c110:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-36a67616959mr11020845a91.23.1779630729720;
        Sun, 24 May 2026 06:52:09 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c4ca35sm7073833a91.9.2026.05.24.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 06:52:09 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Jason Gerecke <jason.gerecke@wacom.com>,
	Ping Cheng <ping.cheng@wacom.com>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] HID: wacom: validate report size before kfifo insert
Date: Sun, 24 May 2026 22:52:03 +0900
Message-ID: <20260524135203.1996265-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254030-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4A1F75C29FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

wacom_wac_queue_insert() passes the report size directly to kfifo_in()
without checking whether the report fits in the kfifo buffer.

Since commit 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX
limit"), the kfifo is sized dynamically as min(PAGE_SIZE, 10 * pktlen),
which can be as small as 256 bytes. However, reports received via
UHID_INPUT2 can be up to UHID_DATA_MAX (4096) bytes. When such an
oversized report reaches wacom_wac_queue_insert(), the existing
kfifo_avail() loop cannot make room for a record larger than the total
buffer, causing kfifo_copy_in() to memcpy up to 3840 bytes past the
slab allocation.

Add a size check at the top of wacom_wac_queue_insert() to reject
reports that exceed the kfifo capacity.

Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_sys.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b..cc82c6f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -54,6 +54,12 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
 {
 	bool warned = false;
 
+	if (size > kfifo_size(fifo)) {
+		hid_warn(hdev, "%s: report too large (%d > %u) for kfifo\n",
+			 __func__, size, kfifo_size(fifo));
+		return;
+	}
+
 	while (kfifo_avail(fifo) < size) {
 		if (!warned)
 			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);
-- 
2.53.0


