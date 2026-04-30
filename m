Return-Path: <stable+bounces-242183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBYaIuiX82nz5AEAu9opvQ
	(envelope-from <stable+bounces-242183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:56:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936B4A6A7D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C3713026C90
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86529477E3F;
	Thu, 30 Apr 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dccP4yoa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA647A0B8
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571802; cv=none; b=JV3fDQkg3H2cd/Wae7tJjWMtD6SfLqGNi7hqMnDBQ9k/AfehRo2MjqcVx9twGRgsz8fmBNxmOzmDx5nyJVCRgeKj9L6ccECNM/KKc1mz2nCNhUUjBiRzUvLXz1zOGch0gF119CrjBk5WQqSEGJQI5ehjrDXNAWKdQLu8NwRLi3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571802; c=relaxed/simple;
	bh=PgyIGO4QsM4KV1Du4VlHXHzQFCBNwgKqEe/8D4lHGK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGovPQ8szuXH2lFwkSkwxLxy4jNZ4po/pV0mcxZ0awiTdzw4xudJMUs3DqglkhI3k7OajRVYjtp0EzDgred8GDc7qofOGDmwVb7GM1LtOA/1dkqIGT59ptf+5kkrERPqn22hPt/tRg7s5dm49kTzG3n7xnD/Et/bsSbiOVy1eZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dccP4yoa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48909558b3aso12962465e9.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777571799; x=1778176599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZnlNVGtRIcLKS9B1pTP87NWhA3Tq2w3mutdZXirEiQ=;
        b=dccP4yoaucWvn5FfFkZXCtM0K6pjyZeIqUhHCgkiJTfzLPC4s+/BolOyQQfLxX9ddF
         daRdSVCzUWBbzu7z+QX796NCzf4aTqbVhFx2TkvMwE1h+zMasqgY1JaPd9naBjxWlned
         Ept386p1Lh3SkhIUvF/Si8BaJuA3j3MvhcMxHYV1pb8PbzdJ/KbZz1jAoSWaG/qnwA6h
         JRvVcPYxmsl6V43KOOjPM+VA5p7wIgBj2uGOPD0p7HVdXF6wsabdHUTSUHL8faFKz0Nw
         NDwfbXoBxBdeOGvZx899DZj4pKDxfZlrTRO7WAaCQVn0YADBteXx1Gn+Fr1m/x7VPZlA
         cSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777571799; x=1778176599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZnlNVGtRIcLKS9B1pTP87NWhA3Tq2w3mutdZXirEiQ=;
        b=Xc6RbpArhWm2s/9/rZ+rOQt//pniaSX3CzdPWvCrIHnveLx1KNQxLeidO/t2xtFvqK
         VKxYpguomWChRVIq15mHcUz2viqV3/GArJ8end2efeuRAxiS4vNfOMZvrOHzLtM0N3gr
         nkCdHYQqFol3U/imj5x/c4qhUPwbIKU5TpzqYYpKgDJpZNq87qyv9kmopKHMYPYJgqXr
         XiTQ3bLdYX9BHGd3GT2IHDc+LeNo/kPpXcMWcNKbsZMtT9VrbLb/TZ+r/liedQQV66Zg
         e60GxPc1ob3rRU7AV91P4y/6xJ5PxoLa2zEx0dzU3C8C7H09TVZVm2nfSxPYaHFMU044
         jhhw==
X-Forwarded-Encrypted: i=1; AFNElJ/QltGq6LXgs8WPGyz858Qcrin2KYehej0WcnjLVs7Cak169rQ5I1ZPd7id68vfKRSeb+4aFEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aCLds2gmAkpYM9W9jSUwd+pxcNULw0g9DXtClxrFujCE+yVV
	AWmS+/NIKOEnrmNIu0te6Sfh+Rgg7vqek3DoaME8I1FQ9EsP7Dg44U35
X-Gm-Gg: AeBDies2BXfntrsOrU3AZWz3hDAXE1UIXdnY/9wusbISXtvHZsY4odVG86z3hFUuRIN
	qR7/H4KM+InSafPAHeAJXtdmFT0PYkmMyrzsLAGGtzhiWw3zlyBhBnDdvUhQFbY7xYFE9Z51QDd
	uGLAFCxbbEkM6aoYWUI53ZGPeVxqtownswUEMM3wUuztORkj/Xusbe41Fea8QE3TYebySik1kDP
	isLTCRu0hlFRNI3YHHSOyOwIBdlol/0NFzgQowAve587iI2J/YYSyI90aldS8WYnTG3duSLWkCO
	d85iNqwJYxsEPt7NokNmzQAzq1AngmMUrIhcK+yh4Z0JCaAaoglS5OwZ1dcjklF648NiEtWni4J
	txUnQuL2gXO0n45nFaz7uhaR+qFbl9fXdVIygX+zioTbUzhUC9t0DrWdGhnhDXd2/kgHfZva2dQ
	F5l/+Q3Odm9PVoXAK5STJlOeviaTj63B+gRMMETSZ78M+y1zGrY9qp317P7xdx9lDz/KTSxLtO9
	8UWvPUkNZlUk7PLaQzV9pBiEW7S4nvY/rR9NqOWHIoecWSD
X-Received: by 2002:a05:600c:8b35:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48a84452dc3mr64100315e9.11.1777571798476;
        Thu, 30 Apr 2026 10:56:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8d17269csm1143095e9.3.2026.04.30.10.56.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 10:56:38 -0700 (PDT)
From: Kai Aizen <kai.aizen.dev@gmail.com>
To: jgg@nvidia.com
Cc: kevin.tian@intel.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kai Aizen <kai.aizen.dev@gmail.com>
Subject: [PATCH v2] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in veventq read
Date: Thu, 30 Apr 2026 20:56:30 +0300
Message-ID: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0936B4A6A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242183-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,kernel.org,arm.com,8bytes.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The bound-check in iommufd_veventq_fops_read() for the normal vEVENT
path uses sizeof(hdr) where the surrounding code uses sizeof(*hdr):

	if (!vevent_for_lost_events_header(cur) &&
	    sizeof(hdr) + cur->data_len > count - done) {

hdr is declared as struct iommufd_vevent_header *, so sizeof(hdr)
evaluates to the size of the pointer.  Surrounding code uses
sizeof(*hdr) consistently:

	if (done >= count || sizeof(*hdr) > count - done) {
	...
	if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
	...
	done += sizeof(*hdr);

struct iommufd_vevent_header is currently 8 bytes (two __u32 fields,
flags and sequence), so on 64-bit (sizeof(void *) == 8) the two
expressions happen to be equal and the check works as intended.

On 32-bit (sizeof(void *) == 4) the check under-counts the header by
4 bytes: a vEVENT whose data_len causes 8 + cur->data_len to exceed
count - done while 4 + cur->data_len does not will pass the check,
then the loop will copy_to_user 8 bytes of header followed by data_len
bytes of payload, writing past the user-supplied buffer.

It is also a latent bug for any future expansion of struct
iommufd_vevent_header beyond sizeof(void *) on 64-bit; the check
should not depend on the type happening to match the host pointer
width.

Use sizeof(*hdr) to match the rest of the function and the actual
amount that will be copied.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Reported-by: Kai Aizen <kai.aizen.dev@gmail.com>
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
v2: fix From/Signed-off-by to use real name and email address.
---
 drivers/iommu/iommufd/eventq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 710eef0b6..78689fb52 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -321,7 +321,7 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 
 		/* If being a normal vEVENT, validate against the full size */
 		if (!vevent_for_lost_events_header(cur) &&
-		    sizeof(hdr) + cur->data_len > count - done) {
+		    sizeof(*hdr) + cur->data_len > count - done) {
 			iommufd_veventq_deliver_restore(veventq, cur);
 			break;
 		}
-- 
2.43.0


