Return-Path: <stable+bounces-242143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC2kLK1282ng4AEAu9opvQ
	(envelope-from <stable+bounces-242143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:35:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 187E24A4DE7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E8130B3562
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC32FC881;
	Thu, 30 Apr 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMYmvvID"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EB2FF672
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562825; cv=none; b=SYV0Zh6QMvJfsm0N723llL3A1laq/1434sM6dDPu8q+5eRump+F7VrBFwlUxP7ZW/ABLFoVWFAozjiUjLBWkfSBRuzexxYI/Ej7cg8WRYzI0l0qkLS7bnVRWT1CfBmC4zKP9QxNZKc4XlGala0HqvEMD9rUoVA9i0uRJq4psf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562825; c=relaxed/simple;
	bh=PiAnSonjJaWq5CiJY8X7CDckO8G53n6I27AbF9/GGe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKt4Tovs5kmJNILI6j2moIZ9GkICRB+kM4GYG1G/JMGAOlATPyfFPiqfDKh+nkb0LTKMSvbWWyFcaoem5BKJ3oTxXMe94/hBYAAO4a3a/ZHfCPEqtrDs8X9qR/1tYOMQ+GcSuyby5hBPcshhBRpRZUiZ0oMiLGrvTEjiwsixvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMYmvvID; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so12162615e9.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777562821; x=1778167621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f73giKg+NEaLkYLxy751gAAtXossjimz4mkZpQ+VXmM=;
        b=gMYmvvID6732zYI5UzaQmjju5GYQ6r38wcZR+C37zGFUl4sgRUSJyB2nUa2xBM4yX4
         RKz1H49eGOhP7Ufv1aPx1kxns1Rc64fZNVtr/sbTrquWJVoNvvy0gf4ad55yw2IAQO96
         j1LzzQW44Jg3TtQo519LBXthaif/kx4RaAjdjtZrY4dLarEdSx7xaZB7KCXdI+vf1RTh
         tJDU+zfnAyDPqsw63zytoqI+fvEsjFu09XW8DVD2YNybJnvjk3kDvCZuDCOkogySJ0j6
         VZSo68Cl9zpE2Jka6OQWSwKvFrW/dQFXf+99nLRiqNekmiy503m3VcOTyPhkqU5ETOX9
         q8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562821; x=1778167621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f73giKg+NEaLkYLxy751gAAtXossjimz4mkZpQ+VXmM=;
        b=ZE2JVHP0A+z6qsB62z9lLN+vxeelPguw24cQD2nZ+nrolygQoruJlZif0JcRyyMc0X
         gx4ek2CSSSmIkPdXCZf9yrBXCXAu5Apl5WjoXolNMGHnqFLJmehgS4tHV7TZAQky/bG+
         FWrr1q5o8hpa5D8bwVBLHuhQ/CqNsJdWdUZWvdQYQtXEjE5XQBfy+id4pn4RDxhE5yIL
         HzgfKEKcYOk839gi9ScDzA//dtXKy0Cf1Th717WHSR0Spw++RBlF7nFN8RdUOtojteT8
         jFm6mFemoFqbUoO6Y5V/iOC+e6fwf/tc56V0mUo0jAG5Lwjw+OQ0eIFJubmZy1Uz1Dtn
         tqzg==
X-Forwarded-Encrypted: i=1; AFNElJ/mVd9km5XdkNbOUeWHS3l+/V2cg2DDbYZo8v7fPe+bgJtV4ElJ5vVUejm8pZ2enALI8iGauEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+K6kZ/7Wn4oQ4HJK+3mtOCyCfrpRS/IPCpubixN//ggXz6Yje
	9GbQdRJutRJrpS32iOb4hbVkIXLr+IvhvjQLSwHb3LoMK/6QOol8c3tSf9os3YOHZ4WobQ==
X-Gm-Gg: AeBDietDuXkG1QJKmquW2wUi6kfKjoW14hFDahWQ9d1pSuHp7W7KS0QGYz27VUQ4PK6
	HB7q/8kfzzUznIHNaqa4LR+LdcikOHKe5E3PCChjSrigVZuAO0d9lmiUVWPPeu2axINSJpQMbPe
	97XoMS1418Vn6qDPhoZsyzhIRsJDl3FAcDZ8ap70b6VSNTiZF9XQmiulMBgn/ONThPeD9BXk40d
	kML2E8yptqIHq2ABPdfpWOS+DYPRGEFFaPa0lPTIocsgID+/qGmxOk0C7f1HI1h40nZG6/mkSju
	lKiKqIM0pWKXGNoBZ2gzasUJ/fn0NjcaHGxqtsKNI7oNo//dC2x2HXHIWjo0rCfzUaykgXN4UZY
	nwoIYcV/rSIRyuTn84tvgz8xaQ1oG4vBF2eFh3WE0d8RyYIqSvhZ3pN2aitwd+EbH5H3OB1zK4u
	Z8lJeAfpLBTGGZ8V8BVC04Ug0o6l7pGcB03e7TJ++4lYixJPIhBP86R/asO68ryFGMIGmuZ4Nak
	Ypf8vYUsahPFYb+5OaUh43xwyQQiq9qSWpnxQ==
X-Received: by 2002:a05:600c:34c9:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48a845291femr61472765e9.22.1777562820856;
        Thu, 30 Apr 2026 08:27:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a824f9f0dsm68616475e9.15.2026.04.30.08.26.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:27:00 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 18:26:58 +0300
Message-ID: <20260430152658.60745-1-95986478+SnailSploit@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 187E24A4DE7
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
	TAGGED_FROM(0.00)[bounces-242143-lists,stable=lfdr.de];
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


