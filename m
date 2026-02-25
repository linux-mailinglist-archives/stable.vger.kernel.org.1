Return-Path: <stable+bounces-219716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBpXOgppn2lRagQAu9opvQ
	(envelope-from <stable+bounces-219716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:26:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04F19DD09
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B0A93030494
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471B8312834;
	Wed, 25 Feb 2026 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MyL2ScJl"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D35310620
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054790; cv=none; b=djQ750Pgtcw12gE0G+gzw45PIMUZcUFWzoJUYLGny/w5Gwq1Xl+uAZMDJ6RJhryK2TQbMekX3MlW5VeKKAIWSNW9K07D0IlTA35vvhWbp40eKjSdMA6jaUe44y9ynShJR0SpodXHZExSr9MkbXyML9+kt7mcWWjw7XADJ3Raygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054790; c=relaxed/simple;
	bh=+ydmNp7GWBu4jBQSgl2WgzbAyCTBFZT+mtycEjsTL60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNX4Z88TKZGyWBShXzM27+OLYcueXWeX4qbT07lmJQuTvh+Ha8Z3GRdlJp3QqkjGM7q8tl+OrT/4SXcnoeO/ohE9kY8++9Jbr/75ug1wZZ7qJtX6VYloZhTGDRHiBi1pky4XJrqvwRnEq3WyIrFjWvTqUyPFF3dTdqC7gXmlEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MyL2ScJl; arc=none smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so211855eec.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772054788; x=1772659588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIAuSTqg6XzfE5AWShTLVGoIycxpWfo7f6rfQls/YmU=;
        b=ma6KH5BTDmhaRnv6GybDEcNYsLUcjmh8UlOt7IxzumRewVnTA66yPFtxBQ+yeAu0SO
         +I7nSa1dquITWL+emI6nYo4a5WOA9UxzlauBCfyF2uEEoBdoRxRZEjV7fT64I653vDIB
         yj9u97ejExibOzQ2qJrUzgBCibchET0lAJbmwAQNXeS80aWmjQsju9GEX+KL8TMPLN5v
         Wh7MtYtxYByNORCW7V7/TduSJLVGtAMxgUT4258tqru4oRyw6x/DBYS05OBZCS9NELkt
         4VDHho8O2nN7gnsGJgljSevri7syZ62RaTxcDIisZRuRBc/00zlFTEM34hCwcY64QMGd
         xyUA==
X-Gm-Message-State: AOJu0YyYfJGaVC8duzlClKAUBbn7i+z0J/mqg8isyWhxW+EG4EXXg4HQ
	MnNKD3KBIb4fzyyk9c+MYHPo8dKbpcieMV/yYJtwexFL/WP/P5U3Uww2gqZ+DqAJJNNHa54Otug
	NnqIYeYPJ+5rnIAEl9+pexCbaPyXDFyBlIRHTXA9yV7Okt42201RaR1AA4uS/2Gi8vC7P8WTk0J
	UZ6EPNT94xFaAtGDSKMhwFtHe8Jy7Dtu4egl9U1MaQCPjyEUQrQ3r+ok4pBGRAMY+IHx47U+sS8
	sZOCxrv3S1IYdi+Cg==
X-Gm-Gg: ATEYQzxZOSbQjtZyZtOwuVZJV4EIaGBxSOf2axd8pSI6W6LYZeVv6rWM21iYg4dxkbh
	1xJJdl/L1/Ly3POGwK2eBrH14xDD6BmurupU52HU1+8fB8ukmC+KkObXCs5xi98zWWnuSBDYjyi
	v/b4KH3jGu2/I48+nYba9vGA1yvbWR1sFURnPcmo1K54AgvgCbYi+3AwA7RlxcnrvTEcsO5dkIt
	0zO6dhi9s3iHMrvpsa6Sk3fFt8J0YNw2BXJ43iQKkEOclgRINgQdNPI5QVNgQEdPlc2D+J1fSK8
	aI+qmIhD68hWyKNQtqccS08Ox6fFXeAMiDsFxM2iiFJOFOh4PFjwqx36n9tcSSUES+XnR1TnwSu
	9O20ZHhMgmI9gBKYtGG/EIy4/Dh+2e1j5uUXmi+BFENjbGop2K6GjHI8c00CfaN84fMaOdvTm3d
	2M+hn7e1dlN3exUjB5oDjY68Dw5fpSTTVGC8M9PXBhgQiUVA10Z8AXTWJ++lnBzWmKwQ==
X-Received: by 2002:a05:693c:4098:b0:2bd:c883:5f8c with SMTP id 5a478bee46e88-2bdc88361a9mr1149811eec.36.1772054787690;
        Wed, 25 Feb 2026 13:26:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2bdd1be2efdsm22738eec.1.2026.02.25.13.26.27
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 13:26:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-896fe47cab0so2471036d6.3
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772054786; x=1772659586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fIAuSTqg6XzfE5AWShTLVGoIycxpWfo7f6rfQls/YmU=;
        b=MyL2ScJlGb20+QROUpnbAotOEAyA7FEzntvgYXegaaEIvSyuSl1Ao8o8pap8xiyQI8
         zala231vT8AsZcqiWEUPbhiIpNJmMaN64rYIdWr2VcE6VITlJs2yCQL8T3559UySqEgh
         7EfXxWsSy/6MNqpSn9K7tC/lscRHyWVUybraw=
X-Received: by 2002:a05:6214:1d08:b0:896:6c2b:2937 with SMTP id 6a1803df08f44-89979ca5c3dmr241078556d6.28.1772054786084;
        Wed, 25 Feb 2026 13:26:26 -0800 (PST)
X-Received: by 2002:a05:6214:1d08:b0:896:6c2b:2937 with SMTP id 6a1803df08f44-89979ca5c3dmr241077926d6.28.1772054785282;
        Wed, 25 Feb 2026 13:26:25 -0800 (PST)
Received: from photon-blam.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c73a2b7csm799306d6.51.2026.02.25.13.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:26:24 -0800 (PST)
From: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	tom.leiming@gmail.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	David Gow <davidgow@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Subject: [PATCH v5.10] drivers: base: Free devm resources when unregistering a device
Date: Wed, 25 Feb 2026 13:04:25 -0800
Message-ID: <20260225210425.2006074-1-brennan.lamoreaux@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,broadcom.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219716-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brennan.lamoreaux@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.960];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A04F19DD09
X-Rspamd-Action: no action

From: David Gow <davidgow@google.com>

[ Upstream commit 699fb50d99039a50e7494de644f96c889279aca3 ]

In the current code, devres_release_all() only gets called if the device
has a bus and has been probed.

This leads to issues when using bus-less or driver-less devices where
the device might never get freed if a managed resource holds a reference
to the device. This is happening in the DRM framework for example.

We should thus call devres_release_all() in the device_del() function to
make sure that the device-managed actions are properly executed when the
device is unregistered, even if it has neither a bus nor a driver.

This is effectively the same change than commit 2f8d16a996da ("devres:
release resources on device_del()") that got reverted by commit
a525a3ddeaca ("driver core: free devres in device_release") over
memory leaks concerns.

This patch effectively combines the two commits mentioned above to
release the resources both on device_del() and device_release() and get
the best of both worlds.

Fixes: a525a3ddeaca ("driver core: free devres in device_release")
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/r/20230720-kunit-devm-inconsistencies-test-v3-3-6aa7e074f373@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
---
 drivers/base/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 82eb25ad1..3f38e4aa6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3194,6 +3194,17 @@ void device_del(struct device *dev)
 	device_remove_properties(dev);
 	device_links_purge(dev);

+	/*
+	 * If a device does not have a driver attached, we need to clean
+	 * up any managed resources. We do this in device_release(), but
+	 * it's never called (and we leak the device) if a managed
+	 * resource holds a reference to the device. So release all
+	 * managed resources here, like we do in driver_detach(). We
+	 * still need to do so again in device_release() in case someone
+	 * adds a new resource after this point, though.
+	 */
+	devres_release_all(dev);
+
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_REMOVED_DEVICE, dev);
--
2.43.7


