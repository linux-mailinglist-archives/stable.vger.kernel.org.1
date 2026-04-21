Return-Path: <stable+bounces-240173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J3lG3WC52mR9gEAu9opvQ
	(envelope-from <stable+bounces-240173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:58:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 748EA43BA51
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D440F30195F3
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE8D3D7D99;
	Tue, 21 Apr 2026 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDcg4gB2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D83D7D77
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779813; cv=none; b=dvo1R0szqeAOqC6RyNaQaQH+/rOvFdrtJ4O9yK8GTk2hcWGROouMzHVNsTHMdKrvx6e/ZdkZ+TCh/TuojFuibS4X3LRFsVU+i4qe4yV9DZaS7XBGeHnXjm/vjokkyr4XL7ABR+JVBQX2e/XDlQ0XAQ16dtx5/2TjtS4P9cV84kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779813; c=relaxed/simple;
	bh=vwLoDl/01Ero/HX80bWSxcdPpZ6rMTqaORYvlV9p+wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko3n50FEHlfz553e4VvXn05RSYQPeuWHVv2h93ayDSdVZls+MuBCDjmFWO3FPel47KkazAGwGNFFiEfcpaojSrieetKVBH4xm3P8gKib96N1VVofQWWCyuJrsjADPewTd4VWD2ZEqwhItsD14soSCmtfnRqSHIDi13mUCzDWWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDcg4gB2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c70b5594f4so470296785a.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779811; x=1777384611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggRf3YpZg1vH3MTEtXV+Gjte52f6naKFyzHWanBYOiU=;
        b=cDcg4gB2BRrI/uyLLe9dICAwR62owflM4f5OGxqf2gLzPhRIWPl/4geYxLtOX0mwYD
         Hl1p1FGRnhB2nXmqv6cnu6/OyGkOmUyvxltd+6vkMvnKmEixD4+kCS3+jQgm/ZM/5crO
         Q2OFaNtbJAsBos32VW4CRO/NrVTfjKN7Tl/VxoFeetlbp0gnsVGcxN5iW89OWv7S8Jgy
         ET1GoPvb6PIbfEHnVyBp+wat+zswBAQDh6Sqb87Z1NzvihEjtX1cqpLlU0+PtqZSMZBY
         vhphacQBQHSyGBrG8JV3f26GwPgE55H4A/lTepSjOvnGJgqlndgdek5HybRqpGkp+7CG
         Dt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779811; x=1777384611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ggRf3YpZg1vH3MTEtXV+Gjte52f6naKFyzHWanBYOiU=;
        b=FzFQiScQfu3VCLPTI9avJyyHN+AfHgiHoHYsjSpakayOO0TFnc/+G5x3mztzQot5/r
         9lj08u49jJfk8SfokWvZK6XgtWgCWe9t2t+Q+jtj8yeBZ2qAzMWANBxPTRb6GOv69RPF
         44/ehLUjHJgAyyxu9A6fP6YRHyOkgP0TsJ2qAtMiDsvwyFv0XB+QxeR6Gkvbtspy1LYq
         WdIHM4WhsDRChE0o22sU/yZfasYdnCTAwIYLH0LyNB3ia44wMMdn+w5c/7FIt9o016xN
         hL4bnqemULxynxZowzflpFF4FUNQNIIG3am9WzCmzSxZBx8fAX1HANgYUYSyVakorBYU
         X68w==
X-Forwarded-Encrypted: i=1; AFNElJ+j/zR/oVVwoLPfQF9t7l1LbQgwAT5i3eMC+uHQBH3K99tYwGGnowzKPheIzmZ7uFG341TI4wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqfPFh3bCrOm8+NmnTfiFR81qM9DyruT4Sd209SkJX4MX6cQd
	kMLM2evClDFfh9/Mjf0IDXPvYAW7ULQW3sV+64uruIXiIgt7+ECz92/U
X-Gm-Gg: AeBDievaqfd6yNFJY/YUxRBf0TnmtOJioYHx1SzAA9PJ0M/xSJX0Dhw/WYtt7k2K7nw
	x2CkVxFxmgIm0kBtNhuE5dwXgJhM6qt/QxYKpR2wqUN1Uz7/kaZpuo7ZSNC/BPGqLU99Xgr1OrT
	HyMXEqCwY/2eC06ukX3qr0M97SspVjc/44iCIv2+a44XtTzXCew23IY4hZCq/dWXCI7eHfCNHRc
	0wPBaiZkRQCv58QOyKJseVQBN/0xfUocE1sA5gB6msOVcfJSgdS0oks3bV9+cKYaTETGtaZ7Hxb
	T0GfYEeOogxGsrBo9V6fiU07XM8M+//EnpHMtDFVxd3N47TSgF5Mw9jwKZZgIod7UT+x5eQ4rq1
	4gQzlMcNj3GIlM7B8PdhecfyQPmBiA3wkSjIgeX3lnMS9T7mcy6i22UvnmDpyJgyyUGx/s+2tq8
	ZgzfbQBRKe7RleyYN13xdr3EsrCtZAS+AxQbRf7WoT80L3j5LwyJp3A7Rzequ9n1j/99muu2+el
	Oic8kkqkRFR20b3rWsi1jsVW6ZyGFw=
X-Received: by 2002:a05:620a:1a21:b0:8cd:8e8a:3584 with SMTP id af79cd13be357-8e78a335c8dmr2054535385a.11.1776779810366;
        Tue, 21 Apr 2026 06:56:50 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad48asm1033231385a.19.2026.04.21.06.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:56:49 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: L2CAP: skip ERTM re-init on repeated CONFIG_RSP
Date: Tue, 21 Apr 2026 09:56:39 -0400
Message-ID: <20260421135639.3185653-3-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240173-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 748EA43BA51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 25f420a0d4cf ("Bluetooth: L2CAP: Fix ERTM re-init and zero
pdu_len infinite loop") taught l2cap_config_req() not to call
l2cap_ertm_init() again once the channel is already in BT_CONNECTED.

l2cap_config_rsp() still lacks the same guard. After the initial ERTM
setup, any extra successful CONFIG_RSP re-enters l2cap_ertm_init(),
reinitializes tx_q and srej_q, and allocates fresh sequence lists over
the existing channel state.

Mirror the existing BT_CONNECTED check in l2cap_config_rsp() so response
parsing can still update negotiated parameters without reinitializing
ERTM state or leaking the old resources.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Changes in v2:
- split out of the original zero-txwin patch so the repeated
  `CONFIG_RSP` ERTM re-init bug is reviewed as a distinct issue
- mirror the existing `BT_CONNECTED` guard already present on the
  `CONFIG_REQ` side after commit 25f420a0d4cf

 net/bluetooth/l2cap_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7ffafd117817..fe98f4821a90 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4480,14 +4480,16 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
-		if (chan->mode == L2CAP_MODE_ERTM ||
-		    chan->mode == L2CAP_MODE_STREAMING)
-			err = l2cap_ertm_init(chan);
+		if (chan->state != BT_CONNECTED) {
+			if (chan->mode == L2CAP_MODE_ERTM ||
+			    chan->mode == L2CAP_MODE_STREAMING)
+				err = l2cap_ertm_init(chan);
 
-		if (err < 0)
-			l2cap_send_disconn_req(chan, -err);
-		else
-			l2cap_chan_ready(chan);
+			if (err < 0)
+				l2cap_send_disconn_req(chan, -err);
+			else
+				l2cap_chan_ready(chan);
+		}
 	}
 
 done:
-- 
2.53.0

