Return-Path: <stable+bounces-244806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMjDJo0e/mkRnAAAu9opvQ
	(envelope-from <stable+bounces-244806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:34:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82B4FA045
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D875F3047E62
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEDB3F20F3;
	Fri,  8 May 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SagMxUA7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244F37BE62
	for <stable@vger.kernel.org>; Fri,  8 May 2026 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261565; cv=none; b=Rb6ZYFWkS6oyYEdfX44ikL12WAz+wjjlGJU4qNyZ/mibv8unrr3qK5H3byNdXQ0EUzAQrGKMhsYncFmdZ5BNj73st+kWLw/Ar7zcVQKgnv14jaKFQgwcTydC5y8ncUKtcKjARNf9hKDb6C+eC0hTYfJ39gP/7ZGUaMOepdiwIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261565; c=relaxed/simple;
	bh=LplV3crLjJFyz1CKIX58/3G5oyVUNzkN7/tKutv6ISY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+MiApHmr3hv+w/FfQ7m8FX+UcxYflgWH18IrD1X6ExcyDKZH4A9Xs+RxZp53CE8Oc5rlSvbSmzCq5cs4pWpIVCqiQfhpgGBLXHTkg7yGRkTg138E8ob1+6hjbm6X2AjvcSXQ5xqlz3pGmzTD8STpmMvuLHZnSyYt36dWmBEkew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SagMxUA7; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e8292423fso16475681fa.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778261561; x=1778866361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKiWj7c3WOUi3B7MNwmGjdVqB1Ve1n7R+SIRjPXohtk=;
        b=SagMxUA7DK+tK3LCVK2O37xqlwyhcfZciQbXK6LT/efDfzuVN92NUthqKYR51g5am/
         k6npWXBITfrRzZTwnqCwnIV8niBV5lO7SYXXD2Gw9PeWWrmpYtzy7ZCajReHLIhzyA5K
         Fa6nQEnkUCXjpE5zf4sXHhBHGCgiROsnL2QKqESIHpTEDsOixoRlH62lhF4wcDXvK1kO
         lmsyr+tMUTwQOp3FryKYClaLMMfQyDCQIeZuUcfdblYhqUJnIXq1XFdgIrpXmWmdLiwt
         hESFk2okLYHoNJt90JfZKNoy/c4UQuP9C8OEmeMPCRiuKwT9EzIvLRmIP6CuMdtSqM5Q
         j0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261561; x=1778866361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKiWj7c3WOUi3B7MNwmGjdVqB1Ve1n7R+SIRjPXohtk=;
        b=SfRPi3ehoO5Y1+4ev0vTp0HvTFkvw5ol8/NP5JDjXYLKIDVmLr4TkSkML/cBv/DK7T
         1ibq58gQFMVE8wwx7L2+4+uKLMIM5mYOPGzZko4lmUPOOMfAH0WzBaE2b3vbSnKViyqw
         0MaHswBFSCAS3WCNiZ6wqOGAAq41T9l9x5ycBYvLCbN69hUPExKlTiKv9g9n3S+M384x
         o+S8xTWo31hJtjjmU+7T6Hk4kxOwcrMaapzVwIPY4uMMXzgrVyKcogo9ePtJ6UfUaMjz
         Uj1uuaY1Jpywz+TeLPCca8L7vmSd2E4k/NYbXeuQIMHRHfq6I9RCmP3N+jNoZAHboCFG
         gfSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DsQ3974fRqLdDblb9nB41d35HkJWU1ut1Brmq63dHqOmsr2+IGJftHqVQGUZh/dE2Ve0evuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XkBIkMGIFke3I20Fc/gnaYEuSRMtEmlD/OENgNAvr9wX89Gk
	2LLAHf7EEw3VJph2aWNy+To+IoE2UkEUL4HOJEqhhmMLX2oPGjBYS4q3qWVGECffZRiREqiajsQ
	=
X-Gm-Gg: Acq92OG8qVM9vUyqIjRWxxcZab5JvsgfQKI4tasgYJzDH0Ml34l4uo2NryuW3Fj106E
	VHZ3xIjm3gdt7D4lV9ZMu72ADkGpy8VjYNleS6r93JZkcbREtPLyvBgSpuL5AmSr7KyibAcuqHl
	RYJX2NSITAcV16HXsw+t8JvU5o8ON21CXT1uxTTAi0XQFu3CYjdUgRMgkPGGZWg1lb7aD/GF1PB
	DbiS1d/OasgDvZ+GH+9u3tgywnV55vdiaQzMmCjwzratOu7veRiK4vIyt1E7YbFgbDt4ij5TNML
	6pd3zCpoIDIKM/hrTwcsiL39/YsfT1rFljVqVU7nqmIC3BB0qu7e0/LaP3lBs7G1i+1uztkznXw
	aEojMVanlwJ5UzdofA2Oj46DpNYvtWmGfJSJw2FU3WsgyOaGa3QWonome8PIdyxgpSjN2OGBJOO
	9Ole159UJtDihfDfakyW+vPG5vYmCTagW0YxIW4zvHhe7h
X-Received: by 2002:a2e:98d0:0:b0:38e:90b9:ce98 with SMTP id 38308e7fff4ca-393c40cbb63mr38714761fa.6.1778261560643;
        Fri, 08 May 2026 10:32:40 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f6144071sm6162291fa.32.2026.05.08.10.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:32:39 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] Bluetooth: btmtk: handle FUNC_CTRL events without status field
Date: Fri,  8 May 2026 22:31:21 +0500
Message-ID: <20260508173121.27526-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED82B4FA045
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,talencesecurity.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244806-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A WMT FUNC_CTRL response shorter than struct btmtk_hci_wmt_evt_funcc
(9 bytes; WMT header plus a 2-byte big-endian status) makes
btmtk_usb_hci_wmt_sync() fail with -EINVAL.  This regresses Bluetooth
initialization on MediaTek MT7922 (e.g. USB id 0489:e0e2; reproduced
with firmware 0x008a008a, build 20260224103448): the FUNC_CTRL response
from the controller is 7 bytes long and the second skb_pull_data() in
the FUNC_CTRL case returns NULL, aborting setup:

  Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
  Bluetooth: hci0: Failed to send wmt func ctrl (-22)

Reverting the offending commit on top of v7.1-rc2 restores Bluetooth
on the affected hardware.

The pre-existing code dereferenced wmt_evt_funcc->status out of the
SKB tailroom in this case -- the original out-of-bounds read that the
offending commit correctly closes.  The byte pair read OOB almost
never matched 0x404 (ON_DONE) or 0x420 (ON_PROGRESS), so the else
branch ran and the caller observed BTMTK_WMT_ON_UNDONE.  That value
lets btmtk_usb_setup() proceed: for func_query it means "not yet
enabled, issue enable", and for the enable command it means "treat
as not done", both of which keep setup advancing rather than aborting
it.

Preserve that effective behaviour explicitly: when the status field
is absent, set status to BTMTK_WMT_ON_UNDONE instead of failing.
The OOB read remains closed, since skb_pull_data() still validates
the length before any further access.

Fixes: 634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
Cc: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> # MT7922 (0489:e0e2)
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/bluetooth/btmtk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index f70c1b0f8990..fb4875760164 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -719,8 +719,10 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	case BTMTK_WMT_FUNC_CTRL:
 		if (!skb_pull_data(data->evt_skb,
 				   sizeof(wmt_evt_funcc->status))) {
-			err = -EINVAL;
-			goto err_free_skb;
+			bt_dev_dbg(hdev,
+				   "FUNC_CTRL event without status, assuming UNDONE");
+			status = BTMTK_WMT_ON_UNDONE;
+			break;
 		}
 
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
-- 
2.54.0


