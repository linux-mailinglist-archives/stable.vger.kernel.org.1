Return-Path: <stable+bounces-271928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FGrEDzuvSGplsgAAu9opvQ
	(envelope-from <stable+bounces-271928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 08:59:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E60C706E31
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 08:59:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bToDJkzm;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271928-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271928-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F84D3024110
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 06:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B613126D6;
	Sat,  4 Jul 2026 06:58:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04831327A
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 06:58:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783148308; cv=none; b=cf1H2+eDNxx+kc7Wfn9Ks3zge9hmZkNnxULHPnBKzT3nYoxdM8KmPaz0dLGQbyFbyjFiAFNnYUV7nz1g704C2vkUL9yOzrKLAOgkED/NYmV5fu2biN2dc0V5ZFiiGHAtoSGSdLWmBA19v8gVNYLDi4AlMmE1hUFfEJhXjh16vG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783148308; c=relaxed/simple;
	bh=0Ql7R0chKKnSTLTalEhgSVivzAge5FzmNSZ6cbj00i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSMcLtXygmuysG4c6LF5Tcjc0vOGCzvxh0x69l+5YAKffjR8hNChikmbguI6k22OKLlCiDspAMomkpXou7T4Vgdr8ab7mQyq7LFUGNVz92J13JPrrWMFwhhfoIS4uvXpSalPo0hn/DVaLCoV1zX1chUxYp39lfcTT2Q1DjdVMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bToDJkzm; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cad4170e8eso13955065ad.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783148306; x=1783753106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk1gsSzNyvLyGL3wQhMLxqEWyeTVD6LK9bSQUeXZaTk=;
        b=bToDJkzm1rkmGGIrN413snhCtC09ATYl8Dwq1GD1sCQDeKU19xvRdQnCPIkGCwPLhA
         c5oW7NfKk7cx7IGMKP0yZDRWR4UC/CYVwld4hIM23PnmPI74oFMW3snXNQyV/URBPIxF
         h6sTR2yhNnzRE4VHogHBpeHZ/Wodggat5OKGqxdwqDLvG3prmaCMHCzkM0U7jvoOL5IK
         p6PD3occxP8Nc6eS8pk/mQGB4qrs9xmyPgsKa8LUq6oBK0q9EAmwyacl6JbURSSSH0ib
         FjQvPfAUx/lkqYpyQPHLcaWytIUSSIMf6XWTf1WchCtWR+aD5Gao1qSpGVQr3RtZcdnq
         O43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783148306; x=1783753106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pk1gsSzNyvLyGL3wQhMLxqEWyeTVD6LK9bSQUeXZaTk=;
        b=LWlzeVNRn5KkioWHJf0Leudb4GiKUCFY0LQeAM/QlziO87818MziTdHLLAONVMChhg
         1sYJVvQl9gy7/m+QmPFFxvEFEGare4vpSDcAOyhoLhEuxjKTtOim+DxYWhsUaXI8hTd4
         qgz6iEVVfvqSQiGuO1lGvPIUyiO7gsbh+l+4DdBWvAxQtCVDs3HI/8/UT+VvQbBuY64/
         7fIKvtBaIicDoLEeVLnPaWPFhDQRFGV0YJ04b1w0JOBizB1xLW5pAE+emG9pqw3yc75k
         U/DQuwzFHcpz5NRdRoPeSdnZi/D/xq+UeyZgcj1DDATcSw8lGI4gZqy9LSjvsJHfJ9sN
         ht7Q==
X-Forwarded-Encrypted: i=1; AHgh+RotqRBZoMmQgMUWL40gEfYvoEYuRiYcniAocEJJOrEA3eTQ+OqDTkl+7oHmCdHo5LgoCAQsoNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybX1jkmPr6rG6Cw+azJ8ZX56UimkGV6RfiHM2OUn8VeZNKr/GN
	SmDLUgkyBPZAjD1fOlEzoutpzP8e/e1wtxS4Wm+Oq0ikNXg/EgU9+yF6
X-Gm-Gg: AfdE7ckwqP7UWD0lGNP08WjAxA5+4yrAhUulXV5Q4BoBngaxagfMSeRyHte+/rW+UtP
	L+MiNs9Z+0Ycdufxn1qs6RufpvlErrJmPAmdWQEW7S5HYIJXSlXmVU5ACjDgLVJ/qTi9KIOozcm
	RTLZwbahq6K1Hjqqj52qB10kQCFBc5JQbGGZG3/Qdd4u7RKtSCfknBFZ6xUm5I5tIDVFHBmFRJp
	+ewNU2g2z8F8bejEFuTEf+yrYJx0D04GYlHQGUWp/u3bt6aznMdbbCIsRlvkh9pl1BtgmYuuzdc
	VhZkZPIPTRA6+fE2NzKWHt3cGTGZaikcpEUFrkLgYfvn3DwihY1/yR8uM1FWW8Q0GzJ8cLU7q8z
	Jr+unXTfy56Oxl+P2MYlbn1sMrkSksbtl1zbSyW2THF6AO8RBkJdnEP0D4dQwD2Z6v9fOwZFs/y
	V26qwTNXKeDH7XfSaJFNDKlV30xY2ss4xeFg==
X-Received: by 2002:a17:902:ffd0:b0:2ca:feb:303b with SMTP id d9443c01a7336-2cbb9ee4ecdmr21754205ad.25.1783148305926;
        Fri, 03 Jul 2026 23:58:25 -0700 (PDT)
Received: from Alvin.tail8ccd9a.ts.net ([101.12.233.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad712ca17sm19526275ad.28.2026.07.03.23.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:58:25 -0700 (PDT)
From: Hao-Qun Huang <alvinhuang0603@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nadzeya Hutsko <nadzya.info@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hao-Qun Huang <alvinhuang0603@gmail.com>,
	stable@vger.kernel.org,
	Martyn Welch <martyn@welchs.me.uk>
Subject: [PATCH 2/2] staging: vme_user: fix location monitor leak in tsi148 bridge
Date: Sat,  4 Jul 2026 14:58:16 +0800
Message-ID: <20260704065817.403111-2-alvinhuang0603@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260704065817.403111-1-alvinhuang0603@gmail.com>
References: <20260704065817.403111-1-alvinhuang0603@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.linux.dev,vger.kernel.org,welchs.me.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271928-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:johan@kernel.org,m:kees@kernel.org,m:nadzya.info@gmail.com,m:linux-staging@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:alvinhuang0603@gmail.com,m:stable@vger.kernel.org,m:martyn@welchs.me.uk,m:nadzyainfo@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alvinhuang0603@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvinhuang0603@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E60C706E31

tsi148_probe() allocates a location monitor resource and links it into
tsi148_bridge->lm_resources. The probe error path frees this list, but
tsi148_remove() only frees the dma, slave and master resource lists, so
the location monitor resource is leaked on device unbind or module
unload.

Free the lm_resources list in tsi148_remove() as well, before
tsi148_bridge is freed.

Fixes: d22b8ed9a3b0 ("Staging: vme: add Tundra TSI148 VME-PCI Bridge driver")
Cc: stable@vger.kernel.org
Cc: Martyn Welch <martyn@welchs.me.uk>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
---
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 4cf3486646ce..c695ad9b4ca2 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2534,6 +2534,7 @@ static void tsi148_remove(struct pci_dev *pdev)
 {
 	struct list_head *pos = NULL;
 	struct list_head *tmplist;
+	struct vme_lm_resource *lm;
 	struct vme_master_resource *master_image;
 	struct vme_slave_resource *slave_image;
 	struct vme_dma_resource *dma_ctrlr;
@@ -2590,6 +2591,13 @@ static void tsi148_remove(struct pci_dev *pdev)
 
 	tsi148_crcsr_exit(tsi148_bridge, pdev);
 
+	/* resources are stored in link list */
+	list_for_each_safe(pos, tmplist, &tsi148_bridge->lm_resources) {
+		lm = list_entry(pos, struct vme_lm_resource, list);
+		list_del(pos);
+		kfree(lm);
+	}
+
 	/* resources are stored in link list */
 	list_for_each_safe(pos, tmplist, &tsi148_bridge->dma_resources) {
 		dma_ctrlr = list_entry(pos, struct vme_dma_resource, list);

