Return-Path: <stable+bounces-181865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CFBA8920
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 11:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DED3AB6C3
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769B286D4E;
	Mon, 29 Sep 2025 09:15:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D955286885
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137356; cv=none; b=fyop5iFleLC5H5LXi9TLDR8SLfweY8D0h41KFV6HVBFx/J+HpM+uTE8JzyXCu8AoM1/mH09yffIpv+MFa5hEjqi7hranBpIN7p6QoAXKlZalV54uscD7u+GXbLEYrPv+yQ9bbklwGxo2+DBRw6Qkig0JHQZEXbI1M8yi4RnEJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137356; c=relaxed/simple;
	bh=R9u55K8LEYMCF9T8YoRD0SE7dnNGouw1ZbsiBle69qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yyk9kaZ0oyROvo9sdkx9plQrAPcDtYieGf6olIJPoJX4ZBF7Bn+vyA1ezhZfs//aGUwhEQqLFmjEWQ8DD2L5yDGfHhTOoqDhLz01Z/uk1V3Go+SAq/33s9UofvO74C77nDVHrXkz3+PyyBr+J9EEmFWxP5goUZWLP4Dm8LJUVkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3d80891c6cso171790466b.1
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 02:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137352; x=1759742152;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/ySJWiSpFmZf4ki4sz6ItaQY50Q4llbhd6F9+5mYqA=;
        b=apmuh/MzIXrSfZNJ5FgwRsWskhXLSmI1EiSNS02Mkru4P16AjaF/xfPJKxQjfOyXFW
         6bqj6QjVlch1YPkkrdsmZo4ruTx8/3gLWph2ZQ39zbN2+XWbQeR5PEtf8ujTnSsNPVUo
         lPEd5FbIbbGTMVf6TD9iAN6vq52N/wlxLZTS8BvHzErqA+17Rmnkr+U6mjcNnqCJV+rK
         JlZu1453oEhs8y3h5LZULjVwcuhATBTC1Iuofx6/qWVaQToL6ij741943H7q7E/HKUA2
         bTclNf8qGuAeqgtNIy6pK4HgFk5eNo5GtPZHWoOKwvGb7YtMIwo+mNZszm5g3BVayoXe
         3Etw==
X-Forwarded-Encrypted: i=1; AJvYcCU1csDOT4m/IlUmYUGcRRkgJucsakl1mAOGQu9ew+xYNpspMwl40XDA5mptkHFimyyHf4YjY5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2WRevCagoWnOB1gYNYI/U1yO32l5oZcnIYn6aULpBh0Ps6SVr
	9njSl1I4kHjajuNkz5Rq+26K4jsyshh7T+HNNsuYv5zaLyZXaYivUcS/7kKjDA==
X-Gm-Gg: ASbGncs2TupWNN8StP3ZMgLnCbZfe7bNdhOIhFKXvlkfR97nPzoyHO2vib69oQJuIaK
	gqZO+oLeHF3kHjIVmfkBbkOeL060jz7jkoXHCkGUu93upmo9eOkduu4hFOv47EPDIfHSFlfQZeL
	dvDpdKvDyvHJP4j9u6Tsfb9QYP1QKCPxfHaoRyOOo7+D387oyPg1Am82kr13tJjPqSGGOVGnBna
	oZ9C8kYn8NB8yxXg0rij77wl/ECCut9O6xl0n5Wrxzm7ZB0Ti++ZhPYp9oa0BpguqZOpGlpYwwf
	Q2UOG6ONonIbZQnMWgT/iBcKRK5zZS9nCbXTnlP4HiABph/Y147B7t2L7VKzpu/JzCFnv/7k6oe
	AMCpxXjHq1NR6EhyemCBdVEeo
X-Google-Smtp-Source: AGHT+IEC99o6I5U43x9BBzmjUVvHusJBZH+ekQ9yM0YzCDDYFnPxzInOLc7bxYYRuE1LOgqfOeyByg==
X-Received: by 2002:a17:907:72c2:b0:b2a:10a3:7112 with SMTP id a640c23a62f3a-b354c244b09mr1746488166b.24.1759137352124;
        Mon, 29 Sep 2025 02:15:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b401d3d4124sm73171066b.75.2025.09.29.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:15:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 29 Sep 2025 02:15:47 -0700
Subject: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
X-B4-Tracking: v=1; b=H4sIAEJO2mgC/1XNsQqDMBCA4VcJN5tyF1TEqUNdO7RjEYnJqbdou
 RRpEd+9IF06//D9GyRW4QS12UB5lSTLDLWhzECY/DyylQi1AYeuwArJetYuqE9T52zvKATHA0Z
 EyAw8lQd5H9oDbs29uV6gzQxMkl6Lfo7JSkf9efmft5IlO0Qsi9IFqnx+jtyLn0+LjtDu+/4FS
 7EPWq8AAAA=
X-Change-ID: 20250801-aer_crash_2-b21cc2ef0d00
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Jon Pan-Doh <pandoh@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=leitao@debian.org;
 h=from:subject:message-id; bh=R9u55K8LEYMCF9T8YoRD0SE7dnNGouw1ZbsiBle69qs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo2k5GJj10pwZeQhabxuZAbcMVQsml8bUkcz4E+
 uow6oJeyWuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaNpORgAKCRA1o5Of/Hh3
 bernD/wLDmkL54OkzUb+m61lGMHj30To7QCHn/pKBW3LjFUzHdsfPC/WPjAtG16FZUFGQD373ko
 vqogdRC36R/Cd3umTq7Rw+Vg0rKhmqaqdfGsKmWUQyNgDI3XwmKmNnBFHfWfMjAOi8bSjsN9PNj
 Y3cML4P2gFuQGkdhAcI/Hhyc43UvRAqZB/T2R+4uz/jQdi+6Icg0qPVzMOw6/AIhg6QPStFayZl
 9c8/LNHcphpjuH8MMz7H1PPEb5dkpotusBK20Wzakvo0rhtUhN/GDprXoILypTRlTlstl97JVSd
 3sdj8/maZdbMNLtcT1LFNqRg40L41Sfb2X8a90aIJe2JHnRKfiy4ja/ISGeOgc9fG0D9YCA3o8z
 rZTKK7jLhgd9hrkTp77nI6/gDoiKU/g5XXHYCtA5AEiD9mFFXW+2d/3UCm9+M9VJdKbdIpxU+8y
 HFVCz2x4TKz9vr2tNea2Md9/m1GUhriYdrOKT/qj7FUpt8/dKZwsIi99BYyul1P42u4UXerh6Hn
 j5UfcNFRODwlmCq+62PsRjUZ13UWAQK5CGgS5OGj/lslHqNmocE822/74Y66pITfKBAzun4FaUz
 XOOcyLobFtZQJVjhSnHcuAureBrxPBESEGKI31kGTArSOMVm4yhrp8ilJIWkI0O9OVKyUzf1dAf
 jPjB5zbIZkILgqA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
does not rate limit, given this is fatal.

This prevents a kernel crash triggered by dereferencing a NULL pointer
in aer_ratelimit(), ensuring safer handling of PCI devices that lack
AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
which already performs this NULL check.

Cc: stable@vger.kernel.org
Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
- This problem is still happening in upstream, and unfortunately no action
  was done in the previous discussion.
- Link to previous post:
  https://lore.kernel.org/r/20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org
---
 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e286c197d7167..55abc5e17b8b1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -786,6 +786,9 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 
 static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
 {
+	if (!dev->aer_info)
+		return 1;
+
 	switch (severity) {
 	case AER_NONFATAL:
 		return __ratelimit(&dev->aer_info->nonfatal_ratelimit);

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250801-aer_crash_2-b21cc2ef0d00

Best regards,
--  
Breno Leitao <leitao@debian.org>


