Return-Path: <stable+bounces-238342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AndDr4c4WmmpAAAu9opvQ
	(envelope-from <stable+bounces-238342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:30:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7C412BD0
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B6D6302081E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D0232ED58;
	Thu, 16 Apr 2026 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWFOuna4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C032AACB
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360633; cv=none; b=jajqUOG6VfbSCvPj6BJdY34N5j0uuKXwWFg6LbfoOmucLlhkaKfeux2MXdbfjoV0/ev21iTCcE8zhW8ua4jSHRr7u+zv+g2KjdGraMpVcFtSGOyh3378Z4vajk79zV9oHDmNF1Eorir6/oYt4Ip+rleaIl7PODE08TaWwcxJ2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360633; c=relaxed/simple;
	bh=AOK7AYkvv1obcIpouo3ENPG0MhGWbHfwfKB3qaKofQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO1sIkUapSGgmWExel8ykICgJpWKtMDHVeY2YtUueWN+Kmu2npr239UuN7o7YHXFJ40hDt6FB1cpMF9HH7p7luuaee7GRV7cW0qHbBz+BI5qfka6lZ0duQokrDutqEHlPbWQiNhdLczFl3K+YHI44SYwO/Zg8jemynaiAhV7QEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWFOuna4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f83bd32efso393173b3a.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776360632; x=1776965432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSU4s/m9nFxmJ8D1T8BXP5KkkEUp3UCaNpB+YyLW09Y=;
        b=BWFOuna4MIAwtAoo1LUGn/YmYW3F4gWzg0+N3JJWSoH6lsJhuRRzHKwBG3yHLCdnPn
         tpqCUi87kHqXfYFOULBVngpzpYGM20hxnJ+/iGKF315uXI+0l9ZJwoV40u/bo4Cke+aZ
         pd5Y2Qg8Qsz3xum/Z9l4+lrzucMnU7jxuTZbjC97yx8/cPCXxTsUIQKnaYlrFKLIjvog
         D9sxhSfmkSnUP1JFRK/6LyjOSEeHEMeU3kfg6dj+EeqmH2b4fU+jDxal0qeccLtrCEUB
         Dg+VN1AHY4GVPXweu5Ej9KwNwLwlz2FN5tIlNMLZxk21HzHd7lh47QqdUxfAuFn9Fr8I
         7y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776360632; x=1776965432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSU4s/m9nFxmJ8D1T8BXP5KkkEUp3UCaNpB+YyLW09Y=;
        b=a0tUrCM1ai5eHImUYG3+eXPrFReiCcHu1OPTIs2Jur0ZWFVW2jsFXxzjSI3s+bXlXw
         FYlX47nfgCLsYGxBzUyFp/OJobJ7OlQBbM9dusQOhb0oPKBmz561wE81RjKc70neelGK
         H9EfJIP9BZor2ye4QPEOlK7QvnKbsUs3XtAAola8tNBf5M5mygw+DqbiFVbsqE8g5vV5
         aLbNxBvtialVNw1Q5M1DjXPWJghW2vYEWiJGyU93ntTdsaKx6xuUWWytKqrh/NcmaR0f
         6RR3vS0rREcGuqXXxrdOG9DVHEr8ea57LBzvw5BIWusNzQITWifIW1rszNQcz5yzI5ur
         4S6Q==
X-Gm-Message-State: AOJu0YzjN+3JUSccBZBaYKA22Xfa0HvRENc3GCbfAYVErzBWKjuxBEpf
	2rJBPaiUuJ8vwnnRDeSYEdyefOC4tjRABSNuet3XS55kzsCsWudVe/tB
X-Gm-Gg: AeBDieuThEkrLHSCXuKzXvqZb6shAsdp1lHaLejN1QbjZQXYTsUFPrkCOTWPchovD5R
	8qTwklVIbLOKtQyNXnNy5CLg+moceBE6CVDQNYmj7v0qpSGBUfKM+hMF7sD7D41NPqM1LTu+imP
	z2F1fr5KCKV8f18D5w4oXCcVK7WByLXjUEWjPd0S7aqLyDuUb/nJCvT6E+cbeSOBMmNtMDS8erZ
	d+K/dK3i7uIqtttaeeYQQpkVDYyObAaneUEAuWixFna8CrS+xmSD8Ez35ByuVtK6WpcT5SJCEI+
	sYBxZ+bFQA879TlW7tFUnlz0FS4IHoqhA3fOxXL8jBvuzMl3gNUeaMibBIN/gtHzzTkYWXiSTpl
	89XRM8qk8Mj6Yx0Zu/gCu3upDoDF7kHidELuoHMXWEVPifMr3hFF2J3QicfxPBrjquJpUGaUIln
	yx51YHcUt0weXscEp9hcUHOnw8SYIpO9OGDru5
X-Received: by 2002:a05:6a00:8011:b0:82a:6461:6d15 with SMTP id d2e1a72fcca58-82f888ad495mr218697b3a.46.1776360631546;
        Thu, 16 Apr 2026 10:30:31 -0700 (PDT)
Received: from lgs.. ([2409:893d:11a8:8d82:9994:1f65:38d8:cb81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8571893esm729229b3a.16.2026.04.16.10.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 10:30:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] [media] marvell-cam: disable PCI device on remove
Date: Fri, 17 Apr 2026 01:30:15 +0800
Message-ID: <20260416173015.3981161-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238342-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,lwn.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8A7C412BD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During manual code audit, we found that cafe_pci_probe() enables the
PCI device with pci_enable_device(), and its probe error path properly
calls pci_disable_device() on failure.

However, cafe_pci_remove() tears down the controller and frees the
driver data without disabling the PCI device, leaving the remove path
inconsistent with probe cleanup.

Add the missing pci_disable_device() call to cafe_pci_remove().

Fixes: abfa3df36c01 ("[media] marvell-cam: Separate out the Marvell camera core")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/platform/marvell/cafe-driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/marvell/cafe-driver.c b/drivers/media/platform/marvell/cafe-driver.c
index 632c15572aa8..22034df6cba9 100644
--- a/drivers/media/platform/marvell/cafe-driver.c
+++ b/drivers/media/platform/marvell/cafe-driver.c
@@ -609,6 +609,7 @@ static void cafe_pci_remove(struct pci_dev *pdev)
 		return;
 	}
 	cafe_shutdown(cam);
+	pci_disable_device(pdev);
 	kfree(cam);
 }
 
-- 
2.43.0


