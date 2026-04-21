Return-Path: <stable+bounces-240172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAIPIniE52m+9gEAu9opvQ
	(envelope-from <stable+bounces-240172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:06:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2817B43BC1D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53A3A306A80F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA683D7D81;
	Tue, 21 Apr 2026 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHovYTnk"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7B3D75BC
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779812; cv=none; b=O16MhBTO0rps2fvXdPcHYyyuezDWEF9Br4f1WEWaES5umWsm157k2prww+ntG4ufZK+wNcEhvyufgmdtazZZP2hT8pHwmaL104mMpv6QsiXLkIEwp27ak2ap/1/VMvvfFiJ2AJHcoloYMJW/Z4V2ZhdNu5TFiwplvg2R7+uFSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779812; c=relaxed/simple;
	bh=nYU4fnXvJnfceEaKFU1kKDN/vmUIeBcyup447IWCgFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsNUpzZjk9Jp5RYviXxlZYsI89MR+4wSEvk07r9q1utMsXOR5gSDjUPNf4LN07zU1ACCeKW/ey49lnVHFYbKZL0HfFMWN/KSTBFY6ALGPMCwP+FVSLxBhl4qJzGa84HuMljdYz9/zqzKe9BzpLaXpNGFl2yfiO/TWEIK78Q5P9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHovYTnk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d7e7f48499so474572485a.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779809; x=1777384609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Rq/HLyYIOXuijt0EBIF+AOgprIQBVUvhx8WQw17WEI=;
        b=WHovYTnkYVZmumgh7eRmBSiCT5Mz1bn0Ozk7hgB5V2vNWqzJKl1URmX1+Ii/vazqym
         teUEXQ9fgIqyC4hUREvJdNCkNMz73wEEs2F92XRVJrIss+6E9Z/pw0t7guNJTdzU8luT
         EhZkem+GNwsk55OzOeeUTUWX01QW4PRGqWde+jBS4BNZS0SQ7l+gIxd8VmOOVrazQxrB
         +dV3zxWFdYp7Dj6+lvnioCeuOPpOHSj0Te7U/L0tTUi/xcLHqD2nNMyfXWZIcAv62Nr+
         /YF9yGL167xsAsaTZw+4tCoA/bu2imgstHrC//WzZCDYmIcDNCpOOPsuqVdB1qV3Yqik
         r8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779809; x=1777384609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Rq/HLyYIOXuijt0EBIF+AOgprIQBVUvhx8WQw17WEI=;
        b=ATBNT/+qvH/5xQr1MVGl527o45V3NJPdz0H6AUZocxkIMBaO2ynnkwcBEi4qW6v0Y7
         GLpcadmNPR4OG/D4Sr00ZEIB70iOVR/jdGp028LFFeVaWiSR+YKl0MXIziszWE6z4+jP
         jszhJCaHdGHd9pDRR0zkLye5MvabgtDLzW1yaFrdWlo1VZBJSB/vi+nJ3AcqXgc0fK78
         /JYfzxrHfxGSp0/u8ukuY4PR/heCU86eRQdy1a0nFiV/Q88Pjl7gDfFAT+HPN+Cm9Bqn
         vHDiIqr+MdDiN64wvvd48Jj9ldiEu7rBOCvjtYNU8itHX89TG9kKzN1hZ+0kVLl6LvJ1
         Laiw==
X-Forwarded-Encrypted: i=1; AFNElJ8BM03uTXbUKRaaNvk159qLYM55y4dwufn6I3eUBXGZbT9cgUWKUSTZBpkbuYgJvEDdZMRxE0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMdAQpmIqXq2XkU2YcymZS9G3fckVH3hejVatVQsYRbje9kRH5
	8t1W3X1LK9mKk+jock1khJ0iVNYJYAELG57FEH/fdIajavbHn+98eYib+9d/H6IN
X-Gm-Gg: AeBDiesJtQjPW5kD0ouG0Lyb9BG6AanYQc0SXzp8yiHP7ZR9hTXCPDfG2ClDOaEKr3Y
	gzI411hjk3DarrK/orbQUQVjLnJJQMeMGbmlyVPW4xBfmy5L4PcDV1RQZfaIIxP5GSnleRYciEN
	criuSG02ODtywyh52ZvvYvCGAjvpOGIo6nKow3/vgNirFhsqFtxzQxiKGhztKB3a2FA4cT90SL0
	zlUqrwcjv3c7CHiSQKVk8uKMekQG8AjpA88AFX0uD+I2f2FY+9BG9Z7xJr6WuVzV/TW5kqO0ckk
	eOfqUfuDiVMkehg62evcoCz3khGFiL907aZu0Y7zzlE0Ftm5fSxXDTPXX+xuWn9DqUfUTY6fzjt
	v1b0ywzJlGlVgSU6EdLvff33f/lFkXreqogpfWYyaLyzXqcKjUR8YlwWsyYmqNxofeC6/Ks4MF+
	FH9rEMexM1uYnCoBifXOfHUdp0phTUAxjWKlkphus7HBUas+WCg+o9llqi89Z/oJKu70FIh1Kr/
	j5dVTYLYkNLrW6Tg91LKRnkCZhus3U=
X-Received: by 2002:a05:620a:4722:b0:8cf:db04:8a31 with SMTP id af79cd13be357-8e79295cffamr2554011385a.55.1776779808936;
        Tue, 21 Apr 2026 06:56:48 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad48asm1033231385a.19.2026.04.21.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:56:48 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
Date: Tue, 21 Apr 2026 09:56:38 -0400
Message-ID: <20260421135639.3185653-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
References: <20260417221628.1674866-1-michael.bommarito@gmail.com> <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240172-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2817B43BC1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Peer-supplied ERTM RFC txwin_size = 0 can still propagate into the
ERTM transmit-window state, and the same invalid value can be
introduced locally through L2CAP_OPTIONS. In the request path that zero
reaches l2cap_seq_list_init(..., 0); in the response path it can shrink
ack_win to 0 and leave ERTM sequencing in a nonsensical state.

Normalize zero tx window values back to L2CAP_DEFAULT_TX_WINDOW
wherever they enter the ERTM state machine: local socket options,
outgoing tx_win setup, incoming config requests, and config-response
parsing. Also make l2cap_seq_list_free() clear its metadata after kfree
so an init failure after freeing srej_list cannot be freed a second time
during later channel teardown.

Fixes: 3c588192b5e5 ("Bluetooth: Add the l2cap_seq_list structure for tracking frames")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Changes in v2:
- drop the v1 `l2cap_seq_list_init(size == 0) -> -EINVAL` approach
  and instead normalize zero tx window values at the socket /
  request / response inputs
- clamp the local `L2CAP_OPTIONS` txwin_size = 0 case back to
  `L2CAP_DEFAULT_TX_WINDOW`
- make `l2cap_seq_list_free()` clear its metadata after `kfree()` so
  later teardown cannot trip over a previously freed list
- split the repeated `CONFIG_RSP` ERTM re-init fix into patch 2

 net/bluetooth/l2cap_core.c | 23 +++++++++++++++++++----
 net/bluetooth/l2cap_sock.c |  3 +++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..7ffafd117817 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -345,6 +345,10 @@ static int l2cap_seq_list_init(struct l2cap_seq_list *seq_list, u16 size)
 static inline void l2cap_seq_list_free(struct l2cap_seq_list *seq_list)
 {
 	kfree(seq_list->list);
+	seq_list->list = NULL;
+	seq_list->mask = 0;
+	seq_list->head = L2CAP_SEQ_LIST_CLEAR;
+	seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
 }
 
 static inline bool l2cap_seq_list_contains(struct l2cap_seq_list *seq_list,
@@ -3234,8 +3238,15 @@ static void __l2cap_set_ertm_timeouts(struct l2cap_chan *chan,
 	rfc->monitor_timeout = cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
 }
 
+static inline u16 l2cap_txwin_default(u16 txwin)
+{
+	return txwin ? txwin : L2CAP_DEFAULT_TX_WINDOW;
+}
+
 static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
 {
+	chan->tx_win = l2cap_txwin_default(chan->tx_win);
+
 	if (chan->tx_win > L2CAP_DEFAULT_TX_WINDOW &&
 	    __l2cap_ews_supported(chan->conn)) {
 		/* use extended control field */
@@ -3593,6 +3604,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			break;
 
 		case L2CAP_MODE_ERTM:
+			rfc.txwin_size = l2cap_txwin_default(rfc.txwin_size);
+
 			if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
 				chan->remote_tx_win = rfc.txwin_size;
 			else
@@ -3715,7 +3728,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 		case L2CAP_CONF_EWS:
 			if (olen != 2)
 				break;
-			chan->ack_win = min_t(u16, val, chan->ack_win);
+			chan->ack_win = min_t(u16, l2cap_txwin_default(val),
+					      chan->ack_win);
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
 					   chan->tx_win, endptr - ptr);
 			break;
@@ -3756,7 +3770,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
 			if (!test_bit(FLAG_EXT_CTRL, &chan->flags))
 				chan->ack_win = min_t(u16, chan->ack_win,
-						      rfc.txwin_size);
+						      l2cap_txwin_default(rfc.txwin_size));
 
 			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
 				chan->local_msdu = le16_to_cpu(efs.msdu);
@@ -3970,10 +3984,11 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		chan->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
 		chan->mps = le16_to_cpu(rfc.max_pdu_size);
 		if (test_bit(FLAG_EXT_CTRL, &chan->flags))
-			chan->ack_win = min_t(u16, chan->ack_win, txwin_ext);
+			chan->ack_win = min_t(u16, chan->ack_win,
+					      l2cap_txwin_default(txwin_ext));
 		else
 			chan->ack_win = min_t(u16, chan->ack_win,
-					      rfc.txwin_size);
+					      l2cap_txwin_default(rfc.txwin_size));
 		break;
 	case L2CAP_MODE_STREAMING:
 		chan->mps    = le16_to_cpu(rfc.max_pdu_size);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..3b53e967bf40 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -765,6 +765,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		if (!opts.txwin_size)
+			opts.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
+
 		if (!l2cap_valid_mtu(chan, opts.imtu)) {
 			err = -EINVAL;
 			break;
-- 
2.53.0

