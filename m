Return-Path: <stable+bounces-262463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VlQpEXM6KWqsSgMAu9opvQ
	(envelope-from <stable+bounces-262463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 12:20:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B8F668332
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 12:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YWiRa1Ba;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262463-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262463-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FCC7313970D
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695BA38F236;
	Wed, 10 Jun 2026 10:15:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F43B5319
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:15:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086545; cv=none; b=SfnjyXBFAN6aNQdo+TpXlhu3A7bUWkOHtKHZFsR99sUU6OXXZubPrSvkZk+TKc5E1vJD4TWDW3lvSMAIn7Jb4IicIdDaeDPxGUTVy8E5W4dSM4LHuzTNbkZ9XL+E/xxRjniKSEM+szk//Ysmwq+20/HReY/qjitHk9QmwLGu8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086545; c=relaxed/simple;
	bh=WaosMbjfwHRBHBEEDV3W8lJK6/4vapnN1+pjcrONctQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7n49YUwGJAFZQ2J0zbd86RjMP1r++3BvqpqTpGgImdh2xHUEDiXTpnXSGQC5AgQFhxdP4h/AQ1QGiD2sjpELqUAFn67AJWeXfsTInsZTc9b+rHqm3wE1ZmgVQjgg+r/WKUmzYbx7g7HORKwaLKJjMCLFu9k4Gt29q1GmDGNgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWiRa1Ba; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423610ec93so5135898b3a.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781086543; x=1781691343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPY6kv+qAU78zF0fcea5dJTa14wAhSte/v9aqMKiagg=;
        b=YWiRa1Ba/DgHVAEgfKEuU0hPWyliqox8d+xMCfRYp0kw2E/vQTbImxTQl4wIpHb+2s
         a7rXScQdNNCmqkSwAn4iduW6EoJwcPzuq2CYXGsTThROtnO6E3FTY5rVcKdqgb/+ufRT
         XERyMLyRKLyTfXgqLvtB600D+B7HoDkGukourquGacFkuAq3LOBwAhOZCjJmgjEEFImU
         VO1KQyNJCTzlRCYZ9h0jpws4AtxjutRvrJTBqIxiZAMLtGBxOSLEgn3TDuoc0JEVuN3P
         NfiDGuhDTaPrHasf4zmvddP1w2YAe1GZex4Ut9nUGkZ2LwKnOCYMGuXi5M7IclHZqpOM
         jfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781086543; x=1781691343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPY6kv+qAU78zF0fcea5dJTa14wAhSte/v9aqMKiagg=;
        b=WFtVDw9GMkxRZsMlE6Kg7YEjXmjPn6qOv9Z66xwJHfXzJsvmrj8iXA7zFQzjVxhN0r
         3o1TNct58LDgH2Kat8laLL+1XeXKloJVJumbmvD1T5sY69vFLQvk4ErU7lO/4WGSmLNb
         9sQ3M2DxBkVY1t5wHYnqOODccBNYebMduvequ4/xvoeOfZtvvD4mLtG7fW9nH039902t
         pRpZO1HUVN4WpslsK8Rg5kSMF8OPdI/TIOXyo9P1gUYXDcEomCiUls2/joIj7+PL5Ohg
         fhiCwJi80ro1U59Ay9WENzn6iMWlgWwSCpHLkdg3lDVP0Uo3SST/0bhB29VkUTkvJyec
         D91Q==
X-Gm-Message-State: AOJu0Yx4IAurfgj1BbYhOKTbUfXshanm3FfWnk5PuzcbEznQ1H+qMLBX
	m1XXsuefQQMxZQs7Ujp5Lwj/LhLmxF2dDuPYI9po5GUBKKmMGybOhrwb1STn77WWOuK1tg==
X-Gm-Gg: Acq92OGbS0fMOypuj+0JxlPHhGZQ/grURQy/XofkMfqQFx4DtxFLBIQMB6FppaSYoT3
	b3FRjd7H5cfkI8SeGj9OhKCzr8MFCQhVmlLvG514huJRTP/b3hwVS/UzbGIuw8jxhMW6q5gbZE/
	WkCvSUuVauU0l/E2K0Kcp/YaYHamX7DmXHokoPqEFMtkwnFqqwQGNneWanR90ykxiP6VgyIZL/P
	IuBlD2fMG9DTX45v7ufmR8Kxf7VMI7ZyjjdcJg7YvaU56UTMCuvNk0+iU3XTSAz5PtlPjeBOCAr
	qgLY0yQkndcvlNG1OGiYoZDnFluRokSf2a3ATEhvCVHloVI9Eu0U7C3UAtL3yJPvQToora/WTYS
	lkPEfUcifooPuEjrNfhFZNEiNW2WjKYACAtwwLBcyy7kP+ekr3zlankL6rQOAXoI3drQ+o6nJOL
	quDR1HC+RxNK1Epic9b0KsDU03mn82kn/3JkScs5u6HeJ0yHGPLIGBqtDG5ag5NN8lopg=
X-Received: by 2002:a05:6a00:3c89:b0:842:7e71:ba2 with SMTP id d2e1a72fcca58-842b0eb50ecmr25171430b3a.27.1781086543355;
        Wed, 10 Jun 2026 03:15:43 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e5638sm25091576b3a.50.2026.06.10.03.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:15:43 -0700 (PDT)
From: Yuguo Li <cs.hugolee@gmail.com>
X-Google-Original-From: Yuguo Li <hugoolli@tencent.com>
To: hugoolli@tencent.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] PCI: setup-res: Guard against bus->self == NULL in _pci_assign_resource()
Date: Wed, 10 Jun 2026 18:15:36 +0800
Message-ID: <20260610101536.1511979-1-hugoolli@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hugoolli@tencent.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262463-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[cshugolee@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cshugolee@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91B8F668332

_pci_assign_resource() walks up the parent buses looking for a
transparent bridge to retry resource allocation against.  The
termination check dereferences bus->self->transparent without first
testing bus->self.

For SR-IOV virtual buses created by virtfn_add_bus() via
pci_add_new_bus(parent, NULL, busnr) -- which happens when a VF lands
on a bus number different from its PF -- bus->self is NULL.  When
__pci_assign_resource() is invoked on such a VF (e.g. via
pci_assign_resource() from userspace-triggered LTP coverage) and the
allocation fails on the first iteration, the !bus->parent test passes
because the virtual bus does have a parent, and the next term then
NULL-derefs bus->self.

Add an explicit !bus->self check, mirroring the established pattern
elsewhere in drivers/pci/ (e.g. pci.c, probe.c, pciehp_hpc.c).

Reproduced on mainline 7.1.0-rc7+ on x86_64 with an SR-IOV PF whose
VFs span multiple bus numbers, by triggering pci_assign_resource() on
a VF that lives on a virtual bus:

    BUG: kernel NULL pointer dereference, address: 0000000000000860
    RIP: 0010:_pci_assign_resource+0x63/0x130
    Call Trace:
     pci_assign_resource+0xe9/0x370
     ... (LTP tpci test-case 12 driving pci_assign_resource via sysfs)
     do_syscall_64+0xab/0x500

This is the same SR-IOV-virtual-bus / self == NULL pattern fixed for
pci_read_bridge_bases() in commit ("PCI: Bail out of
pci_read_bridge_bases() for SR-IOV virtual buses").

Fixes: d09ee9687e02 ("PCI: improve resource allocation under transparent bridges")
Cc: stable@vger.kernel.org
Signed-off-by: Yuguo Li <hugoolli@tencent.com>
---
 drivers/pci/setup-res.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 991d3ed543f5..e8bd3d4ff923 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -353,7 +353,7 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 
 	bus = dev->bus;
 	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
-		if (!bus->parent || !bus->self->transparent)
+		if (!bus->parent || !bus->self || !bus->self->transparent)
 			break;
 		bus = bus->parent;
 	}
-- 
2.43.7


