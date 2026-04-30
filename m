Return-Path: <stable+bounces-242148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKWMKPl482mt4AEAu9opvQ
	(envelope-from <stable+bounces-242148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:44:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E14A50B9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D1330547CD
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A4033C513;
	Thu, 30 Apr 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLmBbtJX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82999257824
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563666; cv=none; b=YpK7jwVehk4Kj6GQ/6eR5FVIpBcF+HbWYd4S2zaE/Au3EduKDtMKAwJpoglj1gknmCDAmnx+rUcOf566oEw/NL/iiYqMEhlzgBObB73QKSaDhJMWF17bBqS5LSXT/wZ6MUO2PP7t97AEXE3/15rIBxGAz+VvU2lUj8r5ctuu01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563666; c=relaxed/simple;
	bh=PiAnSonjJaWq5CiJY8X7CDckO8G53n6I27AbF9/GGe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgtbRmWxT/TMUbpQE7m/pl96j20jD23G0Cf0lpHtMT6tIozOQY1Ar3HpJHZl3G+JaTIgjiKgmVWMY27IJIPCkdaVPusQSnvtO9qNLApcT7rgpPhfmr7nzDTK1+aek2ULULWAC+f1LaF+cdu9CVQRH0lK9cLIBQjZ3kmmdNbwg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLmBbtJX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so10588455e9.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777563664; x=1778168464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f73giKg+NEaLkYLxy751gAAtXossjimz4mkZpQ+VXmM=;
        b=OLmBbtJXQJmctM8NpyUyEKkH8tsidif1FlSBu1E4vFHkgqtoj5Mub6QX+5wDDd9PwL
         Yns3rcvrDXN0NKLJRBuY6AjrIpWAviYbk7YuoBMm8im3QbMO3le0nDCLYuy4QoRu+lXM
         YGoj9/v6zIzj13IjlYSSTxCPB75aRaCNMVEBvrdYd/DPl+zc11KNwEW6Bj14NqlPs46x
         qTODPmKjPGJ+hc4ZM/naMIvENiH2w4RF7+38dcXSdEBS/EmgBabTe/woNGWvqM2czliC
         vosYrir5uGXhBUX0ELQlEfKZTsfpGR2FssEX22rb/10pysNZbmGt8o0tZo7t5UNeOB1W
         lP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563664; x=1778168464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f73giKg+NEaLkYLxy751gAAtXossjimz4mkZpQ+VXmM=;
        b=ACteXmrIIVbNYWFmU8j9MxQ6mbHS4+zhPt3+uIy45L8yaVI6jbg2GIPGd31ZWT0Yal
         /TIEXrH/e/8/X4n9rXMhuaAKPh6n9h071+sD/xUCB/k+aAx/aqABArYMDgHVBDLASFS4
         jR0vltL4PERoLrsNRnr+SCw/MVO6l8Ob0pB7C9Bu8kGpTRr2z3DObo4lnvkPW3jnShBt
         QP1NBjh8wMG7bZCBsgVWVlMsooovzgPGCP3vHIEUTU6/G5rniiD+HhC5jZRsHsrbx+Xl
         8bO51YGfX8xFq+RRgMH+OjaXcgM/VL967+bUaWmRikMW15UI3RFu8flU+ZlAxdBFIjE7
         h/mw==
X-Forwarded-Encrypted: i=1; AFNElJ/5ZAlNpb098A2jMjpqOjJxEY03n6p4ddkxlJEJQ82eh1+NpfBj4YfF7IK4DxNUAepA5MamfTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIcS755Fin1fOwhxi35JcZiDEFHh2tmAYXZE3Ot9DYrsXxHtL
	x14X5A+36sqwdQpmwmcnShAr7G/WPh+Pkk/8rJX06g6ocG4Ntk5Lg0KR
X-Gm-Gg: AeBDieu5PPis9wryd3D7eUfDaU58GgNspT2UbnDk9ER1cBQAFdnTxHe8e4dodMVYdjz
	llgxhXqZUhm1ZwyO4ZO+te5tFrDesbDN7shbFSv4PBdOJQNhnTgdbtvUMbxakr5q1NeDraYQlw8
	1nVNmiJ4Q9hwK2rTvJbAx2e/SFuxKc5YYnH8trqMUkqKpw9/Vly4fM6zNbilw+SV56w/S6/Pyz2
	awoALa70Rgjh/DIswZmV3TV0RRhJNUSJt0dE/oKt6RSEuG3mSRZPMped8O6DyuHD2dUtuj9Yr1j
	GR7saZSupq9vNdHBVvn85/i4VwK0eQNi4HEcYCkW5OGg5K6kQa93QS8gtKmDMkmkFRXLq+nWuSt
	v4sy8qL4Eamq2vykrSWmlpWf6jXY2qZWXqcU9OY2czGL2IQbAbRslVh7tSgo9OVYul/pPsE4o22
	6oerxrhzYcgEY5Sg3w9maikrxgBZ2aXQRziiFpPy6n0VzPpDZRkKsMelLd0hER9PJkt+L/YIx79
	15uaS20CxJ2kshMkoBqKs9Wd4OmmlTnXJyssQ==
X-Received: by 2002:a05:600c:1387:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-48a84459c6bmr60002635e9.20.1777563663680;
        Thu, 30 Apr 2026 08:41:03 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c71c8sm118472015e9.4.2026.04.30.08.41.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:41:03 -0700 (PDT)
From: "SnailSploit | Kai Aizen" <kai.aizen.dev@gmail.com>
X-Google-Original-From: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
To: jgg@nvidia.com
Cc: kevin.tian@intel.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>
Subject: [PATCH] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in veventq read
Date: Thu, 30 Apr 2026 18:41:00 +0300
Message-ID: <20260430154100.61604-1-95986478+SnailSploit@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 047E14A50B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-242148-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,SnailSploit];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

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
Signed-off-by: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
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


