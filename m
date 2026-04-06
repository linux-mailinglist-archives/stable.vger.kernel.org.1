Return-Path: <stable+bounces-233459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ION5AKs81Gl4sQcAu9opvQ
	(envelope-from <stable+bounces-233459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:07:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F873A8097
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12C30300406E
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 23:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE538C425;
	Mon,  6 Apr 2026 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="H9pLV6+V"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F7280CD2
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516834; cv=pass; b=P5kgqkaO0kl1/tWntJyoFaf8Y2izBGKOOeA/8afy/1z0RBy87nyaiOMZEmsMl09IXu1zQSxSFEWtEZYlT8rFf9vR2wgfGGYMa+Pehtj397rmBXDBZMQpR9e6S7baWzatV4FIaImO73K9Dmpu25eeJaeK6h0/9LTLMWd/1t9VYog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516834; c=relaxed/simple;
	bh=CbERZQC17/1PoShTGE/NPjrUpQC94UvYfWpdVNsODS8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ggh5CBjYEnAsvjW4bp8q5uv4kFmk9tPrfC49E0dpRKwJjNN8uYJJPjaKRWjU+cEfm7LxXXMGXJKugUXGZHYq8/bmH6ofEBerb6HvoXSsJwe0+gDA8QRZEFj92e8COFPpO6H6l4Z/M3+KUVQvPlds8QIznXTRZJcY7wAfHRggEO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=H9pLV6+V; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79ee5037d44so59229267b3.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 16:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775516832; cv=none;
        d=google.com; s=arc-20240605;
        b=UerW0Qlq56V9rIldvN3kqnzv1fqjwtJ4+kbR2qVbXxISbeFlI2uJCXOhMEObiAMm/b
         9KP4MGYX7gPNV8NltYW09ViomafNxGjqZq+5pMAX7j6QPdK23JWPDs9wqG85X2+ZjmTn
         gDuQt4Hb40+F0CdYuETX1SNCbHAKx19u1ByJyMW0Zo5Chj20Umb3LFvqc9Fs95YOr+ON
         wtmyKWP+7jOXf016niXEPaOhq9mqx4+vfvZnLvCENVgL/Nso3+Pfrsa3qu/jaa70GGvd
         7SxjjUs4fCy093QtMxC0W4Fm3uzEiQ0LNSGR3irxmIJ9TOFR74GqfnVDoHxPmv67ENj/
         1dSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=L3Od81lft/9iTZV5t8cEzGB2LzR86DDU9DJfU96Ox18=;
        fh=IFl8yfcw6Gdo0AyuAUXihfZ5qhANYdDVy6KahIVi/d8=;
        b=Kqcy4o4wsDelR0QAizLDAXVNgeCAPPnQIBEc3umxHvczgEcceNqRe2R3wKmVjgPrmt
         wRn3vmFyqLBdn9CnLuzVFjV3sHZg5K4mstXzoEvqK8a3Ehe8iQO7YkaDtZl5fRlokjue
         A28P/t8HHwWEX+YCxUUKqrz2joIekaR/47UW0AZzZFR5QmXjCJwdIoITn2aCNwwWmsxP
         V8j3Z4hqXuQl8wE5qQm8EoJzNmXQ5us5qEGLcBKqVsgSc7bH8wiNx7Fo2bwvb3js65Wi
         zsnB9gkE5PtWx2p45VYBvOCufWDqaSpTovfpIcpBrI7JM6CQ5u20+3emy5sir2VHvrMq
         TXWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775516832; x=1776121632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L3Od81lft/9iTZV5t8cEzGB2LzR86DDU9DJfU96Ox18=;
        b=H9pLV6+VbAWRwR51pZS+4P62w1Ygb07yFuj/Lv/7+ddzt+90UJWncpxO8zf0r3htOe
         o7u/0c3VQHmuXdmZWZ/CpjyoldRy9Lq9wg2jGFt/1urVaBM3T5CaIk1H2xIqw6FQbRGL
         1jOZ/W5Jw0ieCLR6AVme34aHnqjeXs1M5meqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516832; x=1776121632;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3Od81lft/9iTZV5t8cEzGB2LzR86DDU9DJfU96Ox18=;
        b=S6iDYGhCdRhxmeP44JFd5CbC1srdZMAGYQxuGU9H5zOQ649X7SfXzlreN0wS5I/Z6m
         vExjDqkNGDx0sIHbzmHnT07zJw4fXo6XihKQT/LNA0tqa30Ep2ILnBFd3uYi2ZPxXI7+
         R2lquXC9VyTCA+vs6CC972307ZeVuoolF+Jt5cc/JwDTfbkuRTFlmFzxaJykedU8Yc6J
         /OdXF7SuQES61s8tvajb1LR/HXNnd7ZdV2VMkjqjBTuQhHqnTJPJl7E4qOqrnRJinGCS
         VanpxHjlGD1kDM0r/W1uq7G5LDbVI3u2pxuJIg5Pm1QoPCdXCy2MQCgmD1xy34H0QFXW
         Yrtg==
X-Forwarded-Encrypted: i=1; AJvYcCUnVF24vyM/wtSUIc9ZL06QiX+wVjv/r/eeRpDe5eOAjJiGuNLFmuKInN5Lr5llKGc49iKLc0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/w/cId9cEMS7pFWBbwdkzeQNvo+jrEEN7UgMhNSAdL7TcOGsq
	PbVsl0X5QI/ASS6voXhT+xT6+aX7haQdqvpZDmzRmnRXziLPVJkkCaFPckJo56wpj6sYwQEhoK/
	9G2wjkhJryaNCPBjGvCxStuBVf817xjCd3M8C2NWMmg==
X-Gm-Gg: AeBDieuYuBWw78ivboGGHJAcwGGxjrA6ZhnckTulM1JFfnODh/fHfHf/Ubds9/yBtZz
	0YHNlMD1Fwg9fx8ZGzrbqrJtQ0CTUopg0BVnrvO22ZS/9PseNIebFnPi0d8NhWoz7RCkbkEopmf
	L0C8zYer0/jksGqIYbLL+3WnRa8ip6OMbE7o/isJErjNdLe+6AW2Ezw/2xbIUHK98Qsh7r0pih7
	Sl3ywsUX12fO7mshtjeFwZ7HovwWncctYZ1TrJ9ffMZHTfjuaMUWDZRMBiZvxJpYSuNhV/pR/bv
	OVuPs4vJZQsughFtM5XsS6Wl5A8algAeyAZQ5iDv9BBb7R30K+dtl1QaEMssrBv8wmLwp89j7Iz
	GTaWDwbdBHcHhjqxpjUMa38cliJI/5coik/jxcXyhW39ETcpZB+17ahtJYyo21AQ=
X-Received: by 2002:a05:690c:f06:b0:79b:82b2:f284 with SMTP id
 00721157ae682-7a3bdd8177bmr137403337b3.17.1775516832586; Mon, 06 Apr 2026
 16:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 16:07:01 -0700
X-Gm-Features: AQROBzD2O2l_CHT8-ax6fGxbh3AX0FfbqXbleB2YomgxanwhD99Y69vm8oR3hmM
Message-ID: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
Subject: [PATCH v2] Fixes a race in iopt_unmap_iova_range
To: jgg@ziepe.ca
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233459-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sina@openai.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:dkim,openai.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 07F873A8097
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
body when getting to the more expensive unmap operations. This is fine on
its own except the loop condition is based on the first area that matches
the unmap address range. If a concurrent call to map picks an area that was
unmapped in the previous iterations, this loop will try to mistakenly unmap
them.

How to reproduce: I was able to reproduce this by having one userspace
thread mapping buffers and passing them to another thread that maps
them. The problem easily shows up as ebusy errors if you use single page
mappings.

The fix: A simple fix that I implemented here is to advance the start
pointer after we unmap an area. That way we are only looking at the
IOVA range that is mapped and hence guaranteed to not have any overlaps
in each iteration.

Test: I tested this against the repro mentioned above and it works fine.

Cc: stable@vger.kernel.org
Signed-off-by: Sina Hassani <sina@openai.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c
b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..c69af341219a 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -814,6 +814,15 @@ static int iopt_unmap_iova_range(struct
io_pagetable *iopt, unsigned long start,
                unmapped_bytes += area_last - area_first + 1;

                down_write(&iopt->iova_rwsem);
+
+               /* Do not reconsider things already unmapped in case of
+                * concurrent allocation */
+               start = area_last + 1;
+               if (start < area_last) {
+                       /* Overflow. IOVA ranges do not wrap around so we can
+                        * exit here */
+                       break;
+               }
        }

 out_unlock_iova:
--
2.43.0

