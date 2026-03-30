Return-Path: <stable+bounces-231283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCsVI2HpymkkBQYAu9opvQ
	(envelope-from <stable+bounces-231283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:21:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5318C36164D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9251530117FF
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E139BFEB;
	Mon, 30 Mar 2026 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrCLeGET"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22B2DF68
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905693; cv=none; b=oXhJUUhu2olhEPMdKZ4HqRTccgr62azsC5t6ZDfaP3YBAfuz5vXUfk5Hwo48C9kAbrwne7I7S8hn/lCvccJ22seZ5e21Vo966TEV0KuUBGrk6I82sE05p+Uil+kMs0qPfWUBgbY11jzxkrWX9t7k+Z1WhoaznQqSejoXdyVk/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905693; c=relaxed/simple;
	bh=RKgk+a2ITsqi9XukOOzHKnfiIEpr6iF2PY9x6eaZd4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZD3E0LgrSxmDTrTgAtwMgNhXAsnRfbEvRlbMieO4swPNhDFpVCfZNqlJLA4e8GawOcu4lZwVydwabNn0J/Qv9yLRaOW5T6A2u4m13Z6n8CwGDWonmoKLtUmOqdO0PPTbgChxmJ02n4eGsJSO8JsFNKS9NV1nZblDtSCufngxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrCLeGET; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfc795ca97so446476385a.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905691; x=1775510491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgJhP5eB3Kjlb+gJEQE6up3YZMbKoV0ITM0rqeVdqjo=;
        b=CrCLeGETHA6FLFW4jl4qlJbnCiobOtdww/+4QNRhd84KupBBOm3VHdY2xS+XMYJsQT
         5VLtnLeTbgYUnZiltxEmQef3xrXkhJ6sZLQ+pB/Zb5k8Co71wOf0yGfJxtIy7uE3pmOZ
         UN12BjkBXurLGw0v5SQt3WmaphpEXH+egqNRNzcymacUliumfbMsFkgDtySGRPT8g0K7
         wZw9WXY2AHuV7zDYHp2Bh6UUl8zuPqU6Ru025mEk0/ejPtgqMN/lsA2JWxVBku/lyrNU
         cXgrjUxr2F8mJFyiYoln8+2wRqfloOAXs2sNtch6OQb9rD9inYlwax5Wtn9ZMCUXa81o
         nxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905691; x=1775510491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QgJhP5eB3Kjlb+gJEQE6up3YZMbKoV0ITM0rqeVdqjo=;
        b=Z8Cbmk9iJybN6gWkibQmIgubk52vAwfVaDw2SdE12vZqet8TtgeW6OQEgdCrAPsPhn
         Rt5v3ie/BpFuvaywwH9lpDK9RLWQHigodG+llcPJuWyJkZEw1xKRV5cq8Ckef9UkNECv
         L8vNGOYS8Ja5N+r/fpFBy5YYkWt65sqB4FUl9UWd7/2cX9psEtBsLy3IEM8n90J31ucE
         Thj8i38ivQwefJKOAuJWg4JulevOpmjyLharsjGiEFbdm6oBTjBDNf4sClxUNpIEXkch
         ZR6dUV6d8P9vYezBWUUVwKYlSVIGM0R6eklh44b6o7cZvwBDkC++/D9OeGYqLVP+Lwv2
         Xavg==
X-Forwarded-Encrypted: i=1; AJvYcCXeykxAsfUJKaXQCf6uysNzcWK1eS9vAncZ1eJHaKEVSq7DysWy8CHZwtub6a4ioNResblJft8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxeJN5RAKCxcHX7XPHEooPmxFKYvLLp5jlelE75rcwX6wWFMQ6
	lvTqGbwgxYJCziGWK89tkpYPZ9MUDjz+its5XaRD3AePrC5ZoNQb1OR6
X-Gm-Gg: ATEYQzxTjbQEaOgz8ba8MP4H/4zKsXBLqmSbsYonCFYW1XzZQdgdCMshLKc6w+AEHvS
	/KBjKQY0dIv3Uwcawf3lTpM+585AJGfm6A0IoDcNudAbD1yP9okAyp/OhXB+r/x+qWacm7ofKHa
	9vTYhKblTTmYjmUG1iKQvXAM6oAqBbIaLDkDTT7Iuhu7T0KAiodxDILMmDGvP7GHFCJlRNQMPLr
	n6x3BAKkyjiMMHx7i04pHiy6Ca5Ij5MEwI3KgK+RQ76hEc2EXXwwfH9sCfzbWBHCG47nPwIAGon
	IVZskYV2QDz4kSLtJQE8EqS8AYSiiN0o5oFYoc5nvnkxXwzDAYE3KzoZdrmjKpue5w+hGEptzLg
	JUmLD9dHTBhWoh0K1y8qhdmv93J1ayHph8NHcRZqNVWXB38E9K5EGwmAO9a7UmZqE6SvF8IoZF9
	K75E06tCV1CarQxKTCRyhHVDwilcKKxwp55yLY6qCFmzz34DpuVWuB3Sf/yO9t4DH89z9/mMJX1
	LO7a/Tg+rk+u/NoHQF7AswNzVCrfQj6
X-Received: by 2002:a05:620a:1a22:b0:8cd:8635:c031 with SMTP id af79cd13be357-8d01c60d473mr1783105485a.20.1774905690987;
        Mon, 30 Mar 2026 14:21:30 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb8d1sm672796685a.4.2026.03.30.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:21:30 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	kyungtae.kim@dartmouth.edu,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH v2] Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
Date: Mon, 30 Mar 2026 17:21:29 -0400
Message-ID: <20260330212129.319339-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
References: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,vger.kernel.org,dartmouth.edu];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231283-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5318C36164D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ISO_CONT case in iso_recv() properly checks for unexpected
continuation frames (!conn->rx_len) and oversized fragments
(skb->len > conn->rx_len) before accessing conn->rx_skb. The
ISO_END case lacks both checks.

When an ISO_END packet arrives without a preceding ISO_START:
  - conn->rx_skb is NULL (never allocated)
  - skb_put(conn->rx_skb, ...) dereferences NULL -> kernel crash

When an ISO_END fragment length does not exactly match the
remaining expected length:
  - the reassembly is malformed and must be rejected

KASAN confirmed the NULL-deref on kernel 7.0.0-rc5 via VHCI:

  general protection fault, probably for non-canonical address 0xdffffc0000000018
  KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
  CPU: 0 UID: 0 PID: 72 Comm: kworker/u9:0 Not tainted 7.0.0-rc5
  Workqueue: hci0 hci_rx_work
  RIP: 0010:skb_put+0x27/0x1a0
  Call Trace:
   <TASK>
   iso_recv+0x5e0/0xee0
   hci_rx_work+0x226/0x730
   process_one_work+0x633/0x1060
   worker_thread+0x45b/0xd10
   kthread+0x2c6/0x3b0
   ret_from_fork+0x38d/0x5c0
   </TASK>
  Kernel panic - not syncing: Fatal exception

Fix by adding validation to the ISO_END case: reject unexpected
end frames when no reassembly is in progress, and reject end
fragments whose length does not exactly complete the expected
reassembly.

Fixes: ccf74f2390d6 ("Bluetooth: Add ISO Socket")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
Changes in v2:
  - Tighten end fragment check from (skb->len > conn->rx_len) to
    (skb->len != conn->rx_len): the end fragment must exactly
    complete the reassembly, not merely avoid overflow.

 net/bluetooth/iso.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e273..ee87341a1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2587,6 +2587,20 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
+		if (skb->len != conn->rx_len) {
+			BT_ERR("End fragment length mismatch (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.43.0


