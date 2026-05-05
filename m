Return-Path: <stable+bounces-244265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPyzAiNW+mmNMgMAu9opvQ
	(envelope-from <stable+bounces-244265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 22:42:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 632584D3BE2
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 22:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD2993024A5A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A393D75D5;
	Tue,  5 May 2026 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E17BVjFw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0AA3D75BD
	for <stable@vger.kernel.org>; Tue,  5 May 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013616; cv=none; b=ZbIollDyP20GECax6CPzfh8eQ/IyRRJdxPDLvEgY1ys1wrvvOG03W0LZqKXwE/wvpLI5Z15MKFILWSTU39d7N9DKeNd7WbPWbrTB4kVWAXKgPSleJa3XUilIqjbmTLrn4hOWImOPWgS1ig6WRLMVU03JRg5bpBZiDT97vV6UF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013616; c=relaxed/simple;
	bh=EpGaEwKFGuiP4t9mZpBgQM5X2R+L9JBlxUfkrxWEs1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W+8jHZLoFOspYyB1Y417HfS1RVZBNjYFIRsnEbsRmYlvu0QNNFC6juHZMsx8tBD1q6wzepiknim15hqoYKpr4F3s3DtoIJ8P64tYJ/t0yU8XGYNcRzDx8h6XrbuGhCWwvTGqtq8kdeL93p1Y88wF0sRps/4IVGg260o2+9vvZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E17BVjFw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso5412110a12.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778013612; x=1778618412; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wP0T8HbpG/ezhgyMGr0ErCtPzM0+G4QaMUxS65Bsvbc=;
        b=E17BVjFwjazidPKo+yQvazT7ntagqGmaW2iQBE4Ipm/68tDyiBZHbTk3wm8hHnZ7si
         pj/yZbNwgBWC8f8FjiTGSy8zmnEVa5EqYIXbnX7UkDa0YeDe5jbngV1aNJ5dpZinabKI
         aZYs0gI9DRNrIQ9YXiLPu4drkhlhP2Cknn7w5qK/FxJVSiYEPWC5gdEELFi3klqZF8Yg
         D4wWPFpp2qLSBTAsZI6dlhP8YSgDTe3URQNerW86Pbbe51s8yuJbpfCGftaCicHgg5vP
         6qT3Fmr+n5wJx3AgAFdfqomj2Cb713yOstHBfP6/tQ3R+65hQeLUhDoMjbDSO+cXjc1Q
         tsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778013612; x=1778618412;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP0T8HbpG/ezhgyMGr0ErCtPzM0+G4QaMUxS65Bsvbc=;
        b=V43T/JuKmrhxe8oULGU3GbzBMwRiSyThvPkukqJO5agKysvtfOUOrHQZEVZwuWyeWZ
         UP3Swa2WCbvnMI/lfCrX2FeI6qkW5l1Jg3jg8DGwnghqMNL1M4w1btzZU69asZtCGxXW
         Kvjd+SwSYzBKJWVcrLNPGANyJV2LzE3PghDxc1Teyo46W+TnNgXHRtpVVe0sJfIPvKD1
         27PQBQGSPqQ9UjthAho/7ShxGFlcQr6Bs8tb1OM8TonQkR1NyBoJBjCoPhtbb5BBFD2u
         H6w6wDCh7EBykgUj9b8r60UtTIdOk+sNwGYlUw5VkXVAmO/CMX90HC10fBWrTD+xzhcL
         hj9w==
X-Gm-Message-State: AOJu0YyPfgjNiWZnnzFxDF3IpSoFms6zmx8KhHz1XY/HiWw+lAZqIovu
	Yr0mbScbk1U4G3Ivg5H2aDsaKUq3HHa31WXlkpOu6ylORyShb4AVkyjo
X-Gm-Gg: AeBDies6/YQcFcbfll0ZbpoWIuBPp6Wfw9rXSUKxaBem4ZCYJCxur5rR8XY+zgCmG+I
	koJqHXEIwscztGqU6z9a1HxmfdibP4IPNpots0LE4H7jHoL6iKw7d2aoijNOH0nccPK0pPzMh3w
	Fp3x6lnB8ZRk6NdJLuV3Eiy2U7rMU1cxHWFS4DkxyA0zHw5o0O2k3Sl8du9w55zRH5Jea5JyhpC
	DDPWCT+0D0YbEUPyYJIzwh3Tf/z9q1xzYgjbzuA29q4qtnTMyDAKyQJGEuEfKrv6462M2YIeso9
	BUFalaVsf53ztXhE74ZqxlGLQxwZNusQ79/TJGF7ortPUQxCJiYBAguGKDQhU6eJTxET8d5qc+a
	rwHBToIh55s/RHZY4c1hVhnVpBhs9A10Z+veCivMq98ctsn105IxerVRCIjLQ5j4cjtAEcDX0hk
	hcslFo9TLctk62y+x9YqcHlwuJxUjA6Sg=
X-Received: by 2002:a05:6402:2b8a:b0:67c:5935:39e4 with SMTP id 4fb4d7f45d1cf-67d638b1793mr68564a12.3.1778013611534;
        Tue, 05 May 2026 13:40:11 -0700 (PDT)
Received: from eldamar.lan ([88.130.212.107])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd91ea07dsm675870a12.31.2026.05.05.13.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:40:10 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 6A563BE2EE7; Tue, 05 May 2026 22:40:09 +0200 (CEST)
Date: Tue, 5 May 2026 22:40:09 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, regressions@lists.linux.dev,
	Ankit Soni <Ankit.Soni@amd.com>, Srikanth Aithal <sraithal@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <joerg.roedel@amd.com>, 1135313@bugs.debian.org,
	Friedemann Stoyan <fstoyan@swapon.de>
Subject: Please backport 9e249c484128 ("iommu/amd: serialize sequence
 allocation under concurrent TLB invalidations") to 6.12.y
Message-ID: <afpVqZDIRVmdV960@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="aSHEFBW7c4jh6yb3"
Content-Disposition: inline
X-Rspamd-Queue-Id: 632584D3BE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_ATTACHMENT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-244265-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	BLOCKLISTDE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:server fail,100.90.174.1:server fail,209.85.208.41:server fail,88.130.212.107:server fail];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--aSHEFBW7c4jh6yb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

After updating to 6.12.85 in Debian we got a regression report, where
frequently a user had "AMD-Vi: Completion-Wait loop timed out" logged.
The report is at: https://bugs.debian.org/1135313

While investigating it looks d2a0cac10597 ("iommu/amd: move
wait_on_sem() out of spinlock") got backported to 6.12.y but a
followup for it not.

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1135313#43 confirmed
that a backport of 9e249c484128 solved the problem. Now that one does
not apply cleanly. As an alternative the following two might work, the
first is a clean cherry-pick, the second on top needed a slight
adjustment since in 6.12.y f32fe7cb0198 is not present.

it would be though ideal if the maintainers can confirm this is the
way to go.

Regards,
Salvatore

--aSHEFBW7c4jh6yb3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-iommu-amd-Use-atomic64_inc_return-in-iommu.c.patch"

From c1eddc8c4ee7dc0ef651d87c51676fe4cd60a9df Mon Sep 17 00:00:00 2001
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 7 Oct 2024 10:43:31 +0200
Subject: [PATCH 1/2] iommu/amd: Use atomic64_inc_return() in iommu.c

commit 5ce73c524f5fb5abd7b1bfed0115474b4fb437b4 upstream.

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20241007084356.47799-1-ubizjak@gmail.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fecca5c32e8a..24e2de90ac2e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1266,7 +1266,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	if (!iommu->need_sync)
 		return 0;
 
-	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
@@ -2929,7 +2929,7 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 		return;
 
 	build_inv_irt(&cmd, devid);
-	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd2, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
-- 
2.53.0


--aSHEFBW7c4jh6yb3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-iommu-amd-serialize-sequence-allocation-under-concur.patch"

From c0e5ddae730cd75b2c806655a8ced16148bafa2c Mon Sep 17 00:00:00 2001
From: Ankit Soni <Ankit.Soni@amd.com>
Date: Thu, 22 Jan 2026 15:30:38 +0000
Subject: [PATCH 2/2] iommu/amd: serialize sequence allocation under concurrent
 TLB invalidations

commit 9e249c48412828e807afddc21527eb734dc9bd3d upstream.

With concurrent TLB invalidations, completion wait randomly gets timed out
because cmd_sem_val was incremented outside the IOMMU spinlock, allowing
CMD_COMPL_WAIT commands to be queued out of sequence and breaking the
ordering assumption in wait_on_sem().
Move the cmd_sem_val increment under iommu->lock so completion sequence
allocation is serialized with command queuing.
And remove the unnecessary return.

Fixes: d2a0cac10597 ("iommu/amd: move wait_on_sem() out of spinlock")

Tested-by: Srikanth Aithal <sraithal@amd.com>
Reported-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
[Salvatore Bonaccorso: Backport to v6.12.y where f32fe7cb0198
("iommu/amd: Add support to remap/unmap IOMMU buffers for kdump") is not
present]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            |  2 +-
 drivers/iommu/amd/iommu.c           | 18 ++++++++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a14ee649d3da..df2aa1c4fafc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -781,7 +781,7 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 *cmd_sem;
-	atomic64_t cmd_sem_val;
+	u64 cmd_sem_val;
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 	/* DebugFS Info */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e1816ae8699d..78e9ceda2338 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1742,7 +1742,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	iommu->pci_seg = pci_seg;
 
 	raw_spin_lock_init(&iommu->lock);
-	atomic64_set(&iommu->cmd_sem_val, 0);
+	iommu->cmd_sem_val = 0;
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 24e2de90ac2e..d0e53a03eff0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1252,6 +1252,12 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
 	return iommu_queue_command_sync(iommu, cmd, true);
 }
 
+static u64 get_cmdsem_val(struct amd_iommu *iommu)
+{
+	lockdep_assert_held(&iommu->lock);
+	return ++iommu->cmd_sem_val;
+}
+
 /*
  * This function queues a completion wait command into the command
  * buffer of an IOMMU
@@ -1266,11 +1272,11 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	if (!iommu->need_sync)
 		return 0;
 
-	data = atomic64_inc_return(&iommu->cmd_sem_val);
-	build_completion_wait(&cmd, iommu, data);
-
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 
+	data = get_cmdsem_val(iommu);
+	build_completion_wait(&cmd, iommu, data);
+
 	ret = __iommu_queue_command_sync(iommu, &cmd, false);
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
@@ -2929,10 +2935,11 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 		return;
 
 	build_inv_irt(&cmd, devid);
-	data = atomic64_inc_return(&iommu->cmd_sem_val);
-	build_completion_wait(&cmd2, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
+	data = get_cmdsem_val(iommu);
+	build_completion_wait(&cmd2, iommu, data);
+
 	ret = __iommu_queue_command_sync(iommu, &cmd, true);
 	if (ret)
 		goto out_err;
@@ -2946,7 +2953,6 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 
 out_err:
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return;
 }
 
 static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
-- 
2.53.0


--aSHEFBW7c4jh6yb3--

