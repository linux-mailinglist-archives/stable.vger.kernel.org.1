Return-Path: <stable+bounces-260237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0P6CIuTbIGo98gAAu9opvQ
	(envelope-from <stable+bounces-260237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 03:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4674163C515
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 03:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="gN8CmsW/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260237-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260237-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 947AC300846A
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 01:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF014E2F2;
	Thu,  4 Jun 2026 01:58:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF40222597
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 01:58:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538325; cv=none; b=JWQKmNpW444oZufjFhFjTK1JWANM4MjVfglrIPG/C6tcoyyz9soP4lzfNXShIw+9/4+MjycBdRdjHINRrEwblvfZVp4Alu4mvpCZ4r7zXCT5KLNAYMo6pOvaHb72BeurHKeT6VM6gKg2NUot8wUfrMlYs17A09BtdCALG20TNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538325; c=relaxed/simple;
	bh=hkZmL/iYek817aCTuWFm67KhXsOFfYP8ByDm0C5xZp4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a5aNIE34RrLHGb+8Pw50/Rc3OrENnyOAO9LOWx8+rSOLLtLcjy/594cl/1uUnjDXkFTYJbjeyiNhWHtOBwqOWnKUM1rN72vuTECa/wL/KeSOEGs+njvyzBYRF+Kf2pcE3evkWLXPX5GaE4Yji3y5PhmRlqaWtVBUjrh7f1VLUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN8CmsW/; arc=none smtp.client-ip=209.85.221.193
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-59cfbfe64baso40953e0c.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 18:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780538323; x=1781143123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gN5MY+IL4XBY0Bh8wFWiSfPnh4J40HsCgGJmRlj6QYA=;
        b=gN8CmsW/QVVplB9gTQdwq8T8lu384IMgpE2uE3BvsRKdM/w/Uo15ERMDnv9xil54pL
         ghDhSrGqLMDADVl12lgwkZQSvsicIaKW7KJgsXkzleTBvkBLcQCK236jIJimVoMLN5EL
         shWyclgGS0cyU7qSUbvAC6Ep2Rx1Hs9oaigiCM+01mu10LLYb+cr52yHa7xENDXxbzLr
         LNKjl+0kp/XS6eiZxzcqZegVbxaAkbm7PoraefFl//nv1Kvvwl0NFYxjhTl+lwc+VcT0
         XzwXKoWauKp8K1vc7oGtQtJeH63IZE8B6LF5h5A4ScWSiQC5CaStPrrk5L3JXD8AMnyp
         txMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538323; x=1781143123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN5MY+IL4XBY0Bh8wFWiSfPnh4J40HsCgGJmRlj6QYA=;
        b=QNSZV+CkXWbnXSGqQemWufZhu5FsLwh4fGbofQAZbVzUutB7vZ0ZClhmvvJFftACrk
         K8hPMH7KJcQ51iDI6YlzFnLRXTtVtpm0sPnOUVjnGQyIYsoZ/Todj56Gu3XayoWMpx5Z
         iwEMYTOEFxz1DVpwZ0jd0YnVgCpZw8WLjjmbGwV4Bi5HO4HcH/CNd1ujxlfy2RZCFX4D
         xjAeYGT4lOcq/e3pKeW6CIIwAnTr2iEqOvFL4H0APXBsAF+O/1eppl9gY7HUAXBkJ8y8
         4HbnEZOvTo/wAa9gXc+P/xmOw11ZBqKzzTGtX7WISqikZQubaj8dpR2YWuM68ZCZEAlm
         v1mg==
X-Gm-Message-State: AOJu0YwlHo4e/QxJqZgCW5O0GjBmE4NRRojIJIshfsKRWSzyLExxoWck
	uMcYwxSIJQUoB5YuTrSDH95Jzzpgq026KzuutulZDlZ64Kw/RQlSgreKOQuTsgm/Fj6d
X-Gm-Gg: Acq92OHeRGgGlJS1+HR7K4NMIPQsQxOJNKjzJnMhIwWzEjJOPpMyfh2/3TPl6WkIU+1
	dDQDL8EdA9XEjzrfetme4FQImXfNVlecF01NVL7yGqimrEe3kdw6KwIUS1fJu/WjhuQevMUgeVj
	b6KPSPvCTAkkX77C7xr+SmHr2MYhPaVOfEMENCh/1VgUH0FDCwXbGOO+2Cof0SO/UkNxSFfYSvC
	j0AYbS0AHXSdFHY13iFmscKKfn4b2MLv8vD0it47xTSOyAlZ7pcW7Z8uV7xTPDGBtcTBMPpu8Qk
	ZZYl+dy14OQTS6esjKSoAg6tOwcXOjP0BXkixQNGAW+FBlzzQAOcP3wr9oSjwsiVosI7AYmmIxv
	ERstRLYxnJMu7kOSc46dUwPxllFd8ccNJTXZ9yuKhKR2b+9t2JCdOWss8IGbl3F2kaCo9x/68YI
	hTJLB97mPvd7QOVG0OPERfqknphiAFn4RWVvgwJEG1+xhWdT/T++lREKsB5SfvPzk9qXrf1AB2U
	iXdbtaywvFQ3ykIGHzU7milqA==
X-Received: by 2002:a05:6122:829f:b0:575:44b3:300d with SMTP id 71dfb90a1353d-5a6e8b0d0f6mr3629270e0c.10.1780538322875;
        Wed, 03 Jun 2026 18:58:42 -0700 (PDT)
Received: from rainbow (2603-900b-4600-2f85-a2b6-fdfc-263f-5578.inf6.spectrum.com. [2603:900b:4600:2f85:a2b6:fdfc:263f:5578])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44d233sm3995088e0c.10.2026.06.03.18.58.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 18:58:42 -0700 (PDT)
From: Jordan Walters <jaggyaur@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
Date: Wed,  3 Jun 2026 21:56:14 -0400
Message-ID: <20260604015614.123281-1-jaggyaur@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260237-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jaggyaur@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaggyaur@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4674163C515

commit eec3deaeaafe upstream.

[manual backport: 6.1.y uses cancel_*_work_sync() instead of
 disable_*_work_sync() which was introduced in a later cycle]

hci_unregister_dev() does not cancel cmd_timer and ncmd_timer
before the hci_dev structure is freed. If a timeout fires
during device teardown, the callback dereferences freed memory
(including the hdev->reset function pointer), leading to a
use-after-free.

Add cancel_delayed_work_sync() calls alongside the existing
cancel_work_sync() calls to ensure both timers are fully
quiesced before teardown proceeds.

Signed-off-by: Jordan Walters <jaggyaur@gmail.com>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c6dec3c82f7..7ad3168c92d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2723,6 +2723,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->tx_work);
 	cancel_work_sync(&hdev->power_on);
 	cancel_work_sync(&hdev->error_reset);
+	cancel_delayed_work_sync(&hdev->cmd_timer);
+	cancel_delayed_work_sync(&hdev->ncmd_timer);
 
 	hci_cmd_sync_clear(hdev);
 
-- 
2.49.0

