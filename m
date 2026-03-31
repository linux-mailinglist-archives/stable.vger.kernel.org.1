Return-Path: <stable+bounces-231327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP+jOcVgy2lZHAYAu9opvQ
	(envelope-from <stable+bounces-231327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:51:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C163643F9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E68D6302C304
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448636EAA2;
	Tue, 31 Mar 2026 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPOqQ5LC"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8A362156
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936242; cv=none; b=PtHKPydOpNzSdwoB7EFZleFdtyCilt7YDTxLmLEtojPEEqdALDatBrqqLnMStAQX8gCesT1QlwWdUh21jOjC/mxL0ZzWF4zf8KZutsrkzYeT6o5KGZJqz5wCei1vWDBzVmQVrVwv8x0m6OeEeMbPodASNGLkkorjl5sHL24LJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936242; c=relaxed/simple;
	bh=cVM85kBUixxEDF8geGvobDd+lyOPWvPL/3rV8qXg6Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTQg4vAYVw6FvIwtEq72jl6pYNP8SP53IeI1Ce+mQz/v8sm9dfVUfdj16wloxYve4acH0tHIMX8WBJh+ivFIzhKP4qCrCenbatLOZEgFcysCrayD2Z3ugZDNn3O0oJjGxL484kuoqMYVYzrvTFCoJigHmvMobjMvF3hD+PUL/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPOqQ5LC; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12a71ade78cso6269712c88.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774936240; x=1775541040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eJ1yAEb3cUbVO4oLsTAGit5fCasX3X7SEleR3AgWXs=;
        b=lPOqQ5LCW1IGHvI1IQ+tQoASoZ+NcKBlDz64tchBQUkyEB6YwUgpEAWXDfn+mKgFsL
         RAQidk4UGaaGJ7nFwxupipE7uFH0Sk793TrvWq2OzsSdNWYSOe0FMVifAgwRhrTMc1x8
         VvSvF5hd/mZJ4YTqldZASKdf18clnmOWm5SNypjGPPhFZcYBKRai7qYY8u2MqCzoQNzH
         GCI8Yt5947TyubXYtDTwNmoIRIDT1Ki4hJNbbOX9ra7YP0k1tq8+Jy6sf4WMboDOOsdc
         WxTbrcMiLSY2Nla9Hf4577QWliOyWsLFsSzVgGJskBE+Og+et+/pdOphIRQqde8pvF4/
         CHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774936240; x=1775541040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eJ1yAEb3cUbVO4oLsTAGit5fCasX3X7SEleR3AgWXs=;
        b=goSJMd/9UZNx8JLAjIljUn277QR/i/3p4yHZJPo5woEYptVk6MTTsm34TUeEqR1PJw
         YYbDOUxPQmPH7pFhnE3tat1n2LoA/lympP9EoRsBAXKkRGI/EUpNt1JD3572deIPkYLz
         jt6zYqczjbY5YBE1YMOQ2Me7ky89DklHS8jgqx8gRRKqQHCa0XQSOuHtpGCFvyyrC3wZ
         IcKwCmLerE2RttOPRm0PPQZibHmYGofTM8OdFcU9+r9G9ZNd3HLD7Cjev04BmRocQCh7
         5O+cokfKkpm+BKXvuP4uigLlOB6HdNTp81GLmyDPOwu4++Eny4gMYkEJewgzxDhghXUd
         c4vg==
X-Forwarded-Encrypted: i=1; AJvYcCWyyawDBcW8zgIIn9OfrltLW288pZ1gYaArMdOPHsx54P4DE7DEWMk8ASQsyiVbUHEyS4DxQEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznvR/hNW2ul9J6jmtU0pDVEbs3K9hKCrrtXju18q/xfGnI/sPT
	eyrmn/wKnHcYTP5erwlOZxLYPLSDTnvBIf9MVZimsjpnn8/Gjy80ULLj
X-Gm-Gg: ATEYQzw6gNlJz0kT/itpwVfnQtEerHN6fX4qypA/BaXvtJ8lhfB+GScdjYvlTlVWm3X
	H4KvCYXBFd25pimMTExPoTx+N0orqpWuMl1c+fc2nMyf9XNJayFlEOVkuKNQZ5ICbdfIGpM30FE
	eItCNjmHHCYksgYBmW7fDHB55U+5aDo9nA5FY3Hxft04viCTJ2Bwl/m4Tif1C7B3EI/ApWuWsFy
	APWWstV0uGI6eV2ijCoY0NVZmpg9YKYdicJUqG97eHzQ5Cue0RYzroRNqIth4m7MVWRTOjZ7eN8
	OfRZIbdaAZoZJh7u5lKhCb+xd6oho//wXJZ1jnStw8a6MqksnlHGrjqgOUQLPI8bbC5UudvrRUB
	ETJs5HsKbWpWwkKvf22w0W/FyunXbdFRldKj6zRPT7lAnGO+iPukarnCBPfRS+TVUju+9ueGqY/
	FxQzFUmEyFYG6XVZknoFDurcMxW8diKvSwzEyIo5axH3B+XphLGLrfgVBA4yqCF4LFKA==
X-Received: by 2002:a05:7022:62b:b0:127:380e:ff5a with SMTP id a92af1059eb24-12ab287e6c4mr6942873c88.17.1774936240096;
        Mon, 30 Mar 2026 22:50:40 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm14497560c88.4.2026.03.30.22.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:50:39 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: fix OOB read and infinite loop in hci_le_create_big_complete_evt
Date: Tue, 31 Mar 2026 05:50:32 +0000
Message-ID: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,linuxfoundation.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231327-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hkbinbinbin@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79C163643F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hci_le_create_big_complete_evt() iterates over BT_BOUND connections
for a BIG handle using a while loop, accessing ev->bis_handle[i++]
on each iteration.  However, there is no check that i < ev->num_bis
before the array access.

When a controller sends a LE_Create_BIG_Complete event with num_bis=0
while BT_BOUND connections exist for that BIG handle, the loop reads
beyond the valid bis_handle[] entries into adjacent heap memory.
Since the out-of-bounds values typically exceed HCI_CONN_HANDLE_MAX
(0x0EFF), hci_conn_set_handle() rejects them and the connection
remains in BT_BOUND state.  The same connection is then found again
by hci_conn_hash_lookup_big_state(), creating an infinite loop with
hci_dev_lock held that blocks all Bluetooth operations:

  Bluetooth: hci0: Invalid handle: 0x6b6b > 0x0eff
  Bluetooth: hci0: Invalid handle: 0x6b6b > 0x0eff
  ... (repeats ~177 times)
  Bluetooth: hci0: Opcode 0x2040 failed: -110
  Bluetooth: hci0: command 0x2040 tx timeout

The value 0x6b6b is the KASAN slab free poison byte (0x6b),
confirming reads of freed/uninitialized heap memory.

Fix this by adding a bounds check on i against ev->num_bis before
accessing the array.  Connections beyond the reported count are
cleaned up with HCI_ERROR_UNSPECIFIED to prevent the infinite loop.

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Cc: stable@vger.kernel.org
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 286529d2e554..ebd7ae75b133 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7085,6 +7085,12 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		if (i >= ev->num_bis) {
+			hci_connect_cfm(conn, HCI_ERROR_UNSPECIFIED);
+			hci_conn_del(conn);
+			continue;
+		}
+
 		if (hci_conn_set_handle(conn,
 					__le16_to_cpu(ev->bis_handle[i++])))
 			continue;
-- 
2.51.0


