Return-Path: <stable+bounces-231324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n4KBK/Fey2k/HAYAu9opvQ
	(envelope-from <stable+bounces-231324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:43:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E52364343
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC323074A17
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ABD36F42C;
	Tue, 31 Mar 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbKQHeIf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB41F09A5
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935566; cv=none; b=kbS520RJcq3auATU0Ft6PdFsCB3bC1y6heiFQDfhHG8TLLNmRk1ycTMh7p/xLcXSLZP1YIVpuOF+iZtLLPz8Iv0U2hHq7Ir0L/LK7OJ1ibgXnr6+muiU4JWH259rE/NtExsAbp/J0YrE45kjwXB25OJU60pe91Cu2TQ7zefs14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935566; c=relaxed/simple;
	bh=IRCcHxZE5vrRcel8klWBqk+hwn76HSWyQfvZSoxQlsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iovHB34SKQjq/X0iQW4RKKQ2dIzASfF4LsEV2Adnr1KYmPK8J5Hz+ozG1yeMZQZSYHnOAPRBnhElHpLz5m5YTRJ1RFhQeBU9jJVVqKmTLZXRqYUH+nPfg4IF+GhVkZLi1IYQpeaCe2EJxwi2lVRYNAo8YJY1yga+4i3joH5zlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbKQHeIf; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3324844eec.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774935564; x=1775540364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HV8dmt1HgzHPMJw/ZTQseF87igS3ZBKLE6u0ax+TN+8=;
        b=cbKQHeIfgKXH/z9j7RkbpWtwjEEO4gAGFKUB8bLeDeanreLcqxAR8TLC4vpXzJOs2k
         xkYRJfENbh8EsMxLH/AnfUOay1Y7ezbqdGRCczYEhQvPubQbj+wV2f5k8bP+7/oQfpG6
         yoMNrPnsrVFb4zaE8HE+Slltg00y8NsZj5p6FZ5/7XTgfxWwneQdBqNgZIWoqywuXDJI
         NrZ+g01fHn4co7m43/SBE7sNt3sF86QvRiJgmBFYntCsnPr0OWQLiVlAnOEA2P9odNEV
         5hwAoRhlcZKpgvG2dA+m9NqWmlKDqkscMhfdVbxKtEyjbZDz6epE8zhfLjRSf6x0tIOj
         KWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774935564; x=1775540364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV8dmt1HgzHPMJw/ZTQseF87igS3ZBKLE6u0ax+TN+8=;
        b=Yj1/pKkDbwMb0SfpyNqN5+/4gml1RTAV9TZjCubPeO4cUNRos2J/oh6Buy5MPiko0i
         O+t+AAjYL+b5l3Ht5kVO+5jJRxexvKp/L3vygqKLX4UrRKhyHnohCcdlEXwpXQpCBumn
         YHATWVcexjxqnslybfng9QbgSOQ8G+cOLinBOszEDEg8iJJEKKmpTkn/JvMVbSRDrAsK
         QswbirNmvkoLf396WmnMix46faESHO+3K/6bo/f/7QTA2Ppn6i3bBd8QbmPQd0uyuOTk
         fD6PRkh8P9tHXTs3vYW91gDn46phGhKLpa/6QtrqN5xlHKplrguySI2qqgB4K4yBL/s3
         nqOw==
X-Forwarded-Encrypted: i=1; AJvYcCVXUUKectuMvajUM5Dr7VpGhBmn42oxC+B3GRIcnbBsJgGjHgjr51vEFnLbOCFLxU7nKRelNtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkxNYOfe/U7kTxY4dxQSRLRGs1Gz6Di6K3/zj2VzXhHvoOvI1R
	k8gGwCk5k4/ljSAcU146rHfb5CmQ26E4qsztmVirNgbiH17Tg+NqBjEz
X-Gm-Gg: ATEYQzybOvus+/pv4MLyAUnjwesDvAn9QA57Mp295PrfPOtnm5qDpx8F0FojA+imgVI
	PzLP8XAghRRnTdTe/XjzQrTvgSri7nUvYhPwxYDITIW5dvB4MFYCqGblRDLVXEhVhXj70b4a6Jx
	Ir14l3pJxzAabK0geoNUzPZRcb1S2wpN8clgg4B5PEoUS/8l+vpQfXoumBwfNlGC9SRbDexybst
	dJLbZCxkq01VUngiYzBOSUf2A1CkLcghgkf1sziLeXyZ5L+G78E0iiJ0xKstg8AxVCJ3GTTVCCk
	sLq23gUtA57/iOhxH/vbPIvrfrKQdWRaSHUYLCBSo4Br+ju8e5EHcuxbMbg8v7bUDiM04hdCPMG
	3G4OQ9IYlsjscLUnM4u6pSSLq/dl/S7h1JfVGmBxPnn7OsdhVU/vqdaKPd3mNLDC3U9Pd5ZGGOr
	XgO/AyGg8vNkD7Dq6kh7CIz2UKQbIylXH1+5WGlPWsJYeJzKViSj74hBc/jpDtz7lGuA==
X-Received: by 2002:a05:7300:bc08:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2c7bc937c3cmr929977eec.14.1774935564304;
        Mon, 30 Mar 2026 22:39:24 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c747e410sm9271157eec.25.2026.03.30.22.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:39:24 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync
Date: Tue, 31 Mar 2026 05:39:16 +0000
Message-ID: <20260331053916.1856760-1-hkbinbinbin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-231324-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkbinbinbin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2E52364343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hci_le_big_create_sync() uses DEFINE_FLEX to allocate a
struct hci_cp_le_big_create_sync on the stack with room for 0x11 (17)
BIS entries.  However, conn->num_bis can hold up to HCI_MAX_ISO_BIS (31)
entries — validated against ISO_MAX_NUM_BIS (0x1f) in the caller
hci_conn_big_create_sync().  When conn->num_bis is between 18 and 31,
the memcpy that copies conn->bis into cp->bis writes up to 14 bytes
past the stack buffer, corrupting adjacent stack memory.

This is trivially reproducible: binding an ISO socket with
bc_num_bis = ISO_MAX_NUM_BIS (31) and calling listen() will
eventually trigger hci_le_big_create_sync() from the HCI command
sync worker, causing a KASAN-detectable stack-out-of-bounds write:

  BUG: KASAN: stack-out-of-bounds in hci_le_big_create_sync+0x256/0x3b0
  Write of size 31 at addr ffffc90000487b48 by task kworker/u9:0/71

Fix this by changing the DEFINE_FLEX count from the incorrect 0x11 to
HCI_MAX_ISO_BIS, which matches the maximum number of BIS entries that
conn->bis can actually carry.

Fixes: 42ecf1947135 ("Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending")
Cc: stable@vger.kernel.org
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
---
 net/bluetooth/hci_sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 45d16639874a..b84587061ae0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7222,7 +7222,8 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 {
-	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis, 0x11);
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis,
+		    HCI_MAX_ISO_BIS);
 	struct hci_conn *conn = data;
 	struct bt_iso_qos *qos = &conn->iso_qos;
 	int err;
-- 
2.51.0


