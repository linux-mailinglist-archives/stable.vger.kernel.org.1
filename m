Return-Path: <stable+bounces-240969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EmpLGR262kQNAAAu9opvQ
	(envelope-from <stable+bounces-240969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:55:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B340945FD9C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E536300AD5D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9D3DA5C0;
	Fri, 24 Apr 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+JRRqZg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE943DA5D2
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038917; cv=none; b=b4yx46yLD3B1qalKdsP/veV2PJjsNdv+WUVNXuYo7bykC2I4xisFETBmiCoWOdZwpYEkGvvy1JCLMzyFP7oyLmaOlhkIJ9tM7gA9TEJLh6+3HrvD/9k8Qzw5F3NnbJxiRjxCm/zQdXXAia3RW631+hTsmlRaKOusvwIa0GFExxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038917; c=relaxed/simple;
	bh=d4mxzTO2Ltl/eUXMBRQNyDiMx5nB3UU/ry0cuOPEU7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ol8kjrSbdvd02AZiKL13SiAb/Fpd5Zg35OWV0EB+ql9iso99eE6K499nvuPaY4Qk8YnKgwu4fy5ALtuOkd0huaTA67CeeDXLRnxbuGlOvX+Etyean6swYIZSDo5jyAk9SFxyi1jpBJwDgqyJt8FEzRHPb0cSoMWsrlEPujRhlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+JRRqZg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso4960620a91.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777038907; x=1777643707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kMeiAHdTbFhy7JXd41HJZsYauWdI9RVH3tSuSNB+WCI=;
        b=d+JRRqZgBWm5eHzCotkrGA1DvbtNAj0yNxMFMHHbY40U5UKLx9RVRziBJmu0658wRd
         KAjrmzDMbkyPMCKeWDbQO/dmuGs5j0VhEhrWsy92RrHHg9Q67dy8B7BC5oCt0+dENMty
         wgTEg7DLvak2JCUKyNUv5xCQOyjyH4smLEcsGuHA9e1blvpqycokR0h4+8TQwcULT2Ud
         zuFySnxLJl/H9wfyzBHDTduJ0rujzZbPhaoX/Y9utJt3wjuElRdqNyXK6VpRiGBihlfF
         lo0vA7c/RKVav+x4cIp3/6aUfMyK5OVpaPAPEw3mjln7itI4PT5qRHdZ6zaXV1CYrVl+
         n6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038907; x=1777643707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMeiAHdTbFhy7JXd41HJZsYauWdI9RVH3tSuSNB+WCI=;
        b=QfPTpBX7MJb87z3UbpyjLRqsS070pwWtCvLO8Ti/cchTrlnDatZLtP2GT/nMM9qjzA
         wjlJRHKv8bsS03XSwP53pp7RLOM0FxrkvxToeBpEQG5PTswTZirZGpvKaE5qGoqcl0GB
         DAeU5xz8t6QBJTPYLLG6qARtUDJeegGHh8X5AOOIIw9yc2UCgy3X7qstM/CgAw1n7Pt5
         pLvmwd5unbkPOrIH0MW+JmsZvE9WegDSOh1SBPFDXK8wO0ZOlnLH9jVATg0hmtsYcbR+
         jrGXWF3MPUf6IV8/WDPp/9nXxVbjLHAwoDqP2tABwU1Z9Le9qQtAL7GwJyS2A/3PlBTg
         fO3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9A2JVuR3TClkBrmsFJny/CgxhkSRUYW2kii78zaw2NlEx/QlJKbdYxL6uuY7HtzQU+61MlXtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5yxAuKfLxCPvCUjEI9NaBbST0ocSt0DW/HvXqMCUb5XzI0fi
	xi9rP2obtf+N8BySkmUNNCcUQUJCAU+yquZ3K+r/N4oP17r4NWXYrjE=
X-Gm-Gg: AeBDieu6hrI93W9nwhzi8kLf7/gVJwg0sc9R0wj8dknHLGy1I2CQa0a2R0teYzKx6MR
	KXq/bi50pXiXXp7lFFDPNy88v4ZTHNhkp6pS9aMn4weg/OnddoRC1C6gevWDUAqkoJ5zH4fFeVq
	o4nWkre7SeJGjTXiVUUegOdGAWBKr0mRIXNptDP5rLh1DU0Nrop5ve2JHruh/Mdj+IWwIcADjYl
	DLifyGQhWyJbb2H4Y8Fr+/rHLGKLgt2n0mTQVS+QjflwcxJrbQYIT3wLpk+Fi6zKCx+l/v1BGns
	xwHk6+NMdCWZrSaiGyyjy/WGr37c7OwuYha5tE96eIeoQxHUK3X7YdBD0JWoG+4wQuuXVD0SjKG
	0uG/nazPasvxSixXfxWpbPXxpcF4IqassZyBXKU8fW9sQ1zcdkOLpXWgFevv2X9O9rMCvXrcAuW
	+IqE3ybkZUgWnDeLDs0bg1k6BR0MTRWGyjtJ1CXKrold7WmYL8iV8Sgp+ui5+9qu0mT/UczBPtP
	A1bnE+I4iRl/y4=
X-Received: by 2002:a17:90b:2dc1:b0:35e:30bc:96e2 with SMTP id 98e67ed59e1d1-361403f1901mr33384481a91.10.1777038906954;
        Fri, 24 Apr 2026 06:55:06 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141990bb6sm24427479a91.17.2026.04.24.06.55.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 06:55:06 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bochs: Drop manual put on probe error path
Date: Fri, 24 Apr 2026 22:54:42 +0900
Message-ID: <20260424135501.18483-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B340945FD9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240969-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

bochs_pci_probe() allocates the DRM device with devm_drm_dev_alloc(),
which registers a devres action to drop the initial DRM device reference
on driver detach or probe failure.

The error path currently calls drm_dev_put() manually. If probe then
returns an error, devres will run the registered release action and put
the same device again, after the first put may already have released it.

Return the probe error directly and let devres own the final put.

Fixes: 04826f588682 ("drm/bochs: Allocate DRM device in struct bochs_device")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 222e4ae1ab..5d8dc5efec 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -761,25 +761,21 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	pci_set_drvdata(pdev, dev);
 
 	ret = bochs_load(bochs);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	ret = drm_dev_register(dev, 0);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	drm_client_setup(dev, NULL);
 
 	return ret;
-
-err_free_dev:
-	drm_dev_put(dev);
-	return ret;
 }
 
 static void bochs_pci_remove(struct pci_dev *pdev)
-- 
2.39.5

