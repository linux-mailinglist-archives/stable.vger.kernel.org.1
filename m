Return-Path: <stable+bounces-235656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGpZAMJC2WnCnwgAu9opvQ
	(envelope-from <stable+bounces-235656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:34:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8144F3DB7BC
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885C9303012B
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6FD3E4C73;
	Fri, 10 Apr 2026 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="MEz3EUGX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4639EF0B
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845978; cv=pass; b=XxIZm7OhAtl9Fho0QNSUuUK5mQ7LwRV9g+vLxG9OaQVVHNhJbjiqmajWVopMLMCkWQbsvIJE+umc9HWwRZ8eUUQGxu9Ac67rFLzpmgc1C50WeQzcLGXDNfDF4rifn1siUgU2ZQlMTaXNTFpDusqnueEBSJrl7VZ0GONX7nJH/HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845978; c=relaxed/simple;
	bh=wuYI0RLFVZ45HYeDNdgJJ6D8GwLuqkaCkFsDbEpgJpg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uO7DQ5NCRcbRuFZVWziWS3OvAC5/KURu81Y2f8dl7acE4Ya6uEBYB6G/Q6yLaXgOmm4sfMyq8IS0aqOUjThuiFiHpBqWqfZD36HICpM0Jo28/32EftxxCvi7ukVtCzsVv/PCxKrPMZxHxT9igU1mxNr4H6TH3Fpv96TGUgxdlYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=MEz3EUGX; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7982c3b7da9so21783587b3.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 11:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775845975; cv=none;
        d=google.com; s=arc-20240605;
        b=Kokbnw1S5wH3mOJNlk15cppP1inv0zkNnp3y8bNvy44NT07LKVnm2ix6Te1Qxyr8Yo
         EtOH5cNWtOvKVcFWaAFfy6PzbjVVy0x2CF83KMhIj8bJ/gjq+ilY8ntOk8KBDG0J/FSh
         3h7rOXB0DLvXfHk0BMBCRKxi9dMtXZ7RjG/oeRZjBQhiN3j3tiasWX7lFKsI4gOqC86V
         lkEvz8BDOoa79rsThoLEAEV0Wd40T17nXtdqw/lVj8ooVg0PClW3jUr43KXgLtEoG85+
         HPGpd4bG+fG1shLAdNt8nRHlXz32Fi6JbJlh5YIXcvttQPdRR/wFZZe2gcbtvYC+5/vb
         O/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ja5DFvBssG/HcQK4svdiTesOu+yaQKgasZ8owUN2Nvc=;
        fh=zM5A3c2sVmpw7pDId+L2tjfF1Y/W5lReHZf1TbAqLXw=;
        b=MLs6HYhP6XDrylMdy2e/Ifv1i9LFj7vJTkScqofh1azzRJJBYj9mYPEdQejfHv73UX
         oZz6TjmFkJbvoGq63emMiW0nhW0WbLATv4l1Q2M/CAY2Dm0wIW/eD5nXkwB2G1fRJmut
         VOAeZzZkwygkNtAqxOdPhF47ZdOkADh56dhop39o9ZyexkvsNClVt51RgLRJgzC4zNfR
         abP8oigm2gAxJuY0VRdU07Kmxon/57PRliO8QXsIDaMFQKEJq8jAFR2/IEzO6e0fucTY
         KuIUNHnc8u4ViVoO8tEnxZb8YSTArWX2cGLq1zN42+JiRVmv76Rx48nXyfYtFwH8QhAo
         rW3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775845975; x=1776450775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ja5DFvBssG/HcQK4svdiTesOu+yaQKgasZ8owUN2Nvc=;
        b=MEz3EUGXZLZgvyHCbAQ6WGTDHT05JSoT1WqX2qnKIhE3+BleIElU/2XGVlkEYPUT1w
         jv0d9tmUQHMhCPt6xjrxB3A/Uz1VjKb3iQSJIFi67Ln2tAXb9j254Fw0Lt8rdrSwbiBy
         aCUFAtmjZjf3X8+gSfEAy4S33ubvkUKFtAd8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845975; x=1776450775;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ja5DFvBssG/HcQK4svdiTesOu+yaQKgasZ8owUN2Nvc=;
        b=rUc73gDqloikyibfucSamZN8sjaW1OUiKjjd3xgQLnoDfBFT4OMGnQosug+mq+Z+et
         bjhudm91EftJEoLYJPm46mpRrX7VJKP6H1NOMbs1lIp8EAivATduo1+XJdsq1j7QBWbo
         Ft4duhsXJxjrsMz2W5zZyy+J9++pRkiFABjIduteq89ONgdCp9ARGzSbMZwkWdBpJAHT
         Ah2Sro8cxOX350bDAL/2k7wkDtghxS6Ez4SU/dN91dk43loVF0/nHQL7KxQy5JxOPAi6
         7Vwj8VGC+fWcnxuQsNL6TPjtZY0QYsSSO/Ir0tHRBXL/HMuDIvPCCMTIr9qtlKWlO65j
         9BDw==
X-Forwarded-Encrypted: i=1; AJvYcCVBzwL99ZGV8wqXwF9tWZDwl/Pxn+GhTTTEdFTDcO51WSnSyHIt6OBXI6ERU75UBvWdGTMKxnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywke2STlXGxdy9el3etrGlYCFUfSCIW6eAUSbBqa9tODPgvnMqK
	Ssd/PY+lZnwiuXQS8X6omGKKdblfcS7MrRrY4C0hM6v+qmoLBRttFqxGnzB9q4Mx2m2o6XTcb+w
	GETTxu9Jb9/z76seEo6wtWE7uPIB57hhgCfZzVN47OQ==
X-Gm-Gg: AeBDiesaSR8WpDH/PTzshcfhuT5Bi+/BanGT5s83puFCo9K7sZzxdkXP8gXICGVfNsM
	6BGoQxjPeVttP9lIAzvcrTNSZ40H/Kg8Yck69K1H3Mn8RtuiTvm7A767AuqfLks6KsJ33SA37D/
	pFsLV2fSxAgXZh5ugj5tztzJo91Pvj2G+tRoW/kGXLXYABbNQc+KodPq7CZrbWZOzLObHW/ZTWc
	ni/A7Ehd3GQuAYtaydG47fx3XujVYnGNu38GnVZBB9O7Ey++mE+tyOfJsbEMqcwzXbiP9fGG+ZZ
	I3IN/D+gNijQUpAgblSbdd+/osIk8AAw3z1kbUhPAnBhULydOhMGz3lGDHt9M4++2DjBzcVrLts
	w2Al8p/qjOmemJ4OPMp17CXEVHk66Zqa56Yu4dZaD4lO71nZuMynPgoBSP5M/W2I=
X-Received: by 2002:a05:690c:386:b0:79a:c396:bfd with SMTP id
 00721157ae682-7af7282e484mr46611397b3.53.1775845975495; Fri, 10 Apr 2026
 11:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sina Hassani <sina@openai.com>
Date: Fri, 10 Apr 2026 11:32:44 -0700
X-Gm-Features: AQROBzC0kt-YXtizzhgXbBbxbP2jPMd7-xT0-_zTfAyjyTIg0aNxYbMeqSKenFY
Message-ID: <CAAJpGJSR4r_ds1JOjmkqHtsBPyxu8GntoeW08Sk5RNQPmgi+tg@mail.gmail.com>
Subject: [PATCH v4] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sina@openai.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-235656-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[openai.com:+]
X-Rspamd-Queue-Id: 8144F3DB7BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
body when getting to the more expensive unmap operations. This is fine on
its own except the loop condition is based on the first area that matches
the unmap address range. If a concurrent call to map picks an area that was
unmapped in the previous iterations, this loop will try to mistakenly unmap
them.

How to reproduce: I was able to reproduce this by having one userspace
thread mapping buffers and passing them to another thread that unmaps
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
 drivers/iommu/iommufd/io_pagetable.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c
b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..355f7227305a 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -814,6 +814,12 @@ static int iopt_unmap_iova_range(struct
io_pagetable *iopt, unsigned long start,
                unmapped_bytes += area_last - area_first + 1;

                down_write(&iopt->iova_rwsem);
+
+               /* Do not reconsider things already unmapped in case of
+                * concurrent allocation */
+               if (area_last >= last)
+                       break;
+               start = area_last + 1;
        }

 out_unlock_iova:
--
2.43.0

