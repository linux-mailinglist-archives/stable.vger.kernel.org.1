Return-Path: <stable+bounces-227651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFEfNaoSvmnFFwMAu9opvQ
	(envelope-from <stable+bounces-227651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 04:38:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C862E3244
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 04:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2806F3021D17
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 03:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9041C31F9B7;
	Sat, 21 Mar 2026 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5IbJFLT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27851258CD7
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774064294; cv=none; b=NFDXCbkHNkCLjMnmEcesHWPVWjCQXp7WVkv3QYWaWWzAQBxFQOBy9sCrzyb6mNbPCMppzYi0buTUxxnTvllhBbbg58lSMsV7AU8vQgYE6o8EpsaPCMFzL+qiaww1VRdcHQbl7Umk8dhYpHrf17zxeClKSs+uWGtxTPBpruMKieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774064294; c=relaxed/simple;
	bh=Kz1ZCjKgB0sIdJi4IBnkiL2gSeKn6AkhNJ04EPbvHWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfgshJFuSSlByjJcPDJHn+ULfbgj7TnBcPxQI9WzBOKPcXA6LLHBGekgkJTZ9Y/Tg7yHWqXp92QiHov3VvECmdrSiBti57NADwxJZKov5T4qSuayt47LATDPwYWe6jeyFv9zn9Ltodyom9zvmA3Bjm9n5FX4NLe+MhbA98rbjRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5IbJFLT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506aa68065eso23896901cf.1
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774064292; x=1774669092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6B2CDNY7UG/sAWansjMq2Hcz4vu6SmMLIBCAlbIfga0=;
        b=Z5IbJFLTDooqFZ1Ad+Xyfga/Bmy2/EUbgeVDDqzh64b8eFmWuc0pe2uJxzp5T80UHD
         bJENOa1PeU+WtbUWnNJ8Bv8sjpTclorvubBwSkw2K76R3AO9Yob0bRWulfIG9CpOjoax
         LoVzRAuFBxC3d86MNu98cdU+Xi6eiVpvFFF2CsQL4A1OhQY2fH6niqggCVPOZnaCcWrp
         hXkE85tfCovAU77RxISmRaCcky0yChf0C0fXFSMAgt6X39OOmyTM8ZnNkIBa6a2IQ2re
         4L5i5juOrd9Np9nKNld10haq1Cz55GOWak7LG7fFhSTwN/a01uWOcaZHrgD0jTNcOM19
         e8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774064292; x=1774669092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B2CDNY7UG/sAWansjMq2Hcz4vu6SmMLIBCAlbIfga0=;
        b=noMMfRxpCWmjgM2avkNzWaBqJS5MefKt1ni6OjdpkOLCF1P75aafV6k4tjcAnxWjD9
         HqrAVwwkjlEp2TjHgB/bhUX2UdWWRr1e3M5kKmCrBA0D0QWDXJuZgIjoYDARlOtgo9+Z
         oX96DbONprTf3iXnRP3mSxQUkJIduOUYP2EjVRLZg4x3HL4Ys3HnMz283jeZxKWC6C5x
         Hz+t2iitbijUWwvM4kAGdAfqoFLKh57ediSKjqyognkyoAKPBss8NB4/kR6wn9xanI6P
         Jv2BzmvQ1DFEvYxjS69fdxgbuVVpuMpTV8XIpnyYoPvyLQAH7m2PDal5VTVIPy1eXgsF
         FZew==
X-Forwarded-Encrypted: i=1; AJvYcCW/6T8tOPk0oRdsSTC6Fwohj8y0Gwk11yy3R/W4l/6a2LWgy72yI+YkvOrqGhi6TYaB64jSB+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwRhs6a3lC4pN8InovZy2NqK2ZHb6wWx8BazDGMouDSIlMTnS
	mjpy3ViAQ09T+sHOldcJagr74xevPcW/xClGuuuAd/iBtcLgvDM+/VhD
X-Gm-Gg: ATEYQzy3JXcJDJh/L3xqUvyfphrkyANUTDLBaq/jx4Yb8RcrZgR4UHrNlKmWp42kK8p
	7WSx401qRpyOZ1SVMEtexBBVgbA1nBbbeMG7HfzP+jEwd8v4446cctWTe1eTMi4Qe6xrCoGjFuW
	6YYB+3UcvnRZUig0PBsHJrVCPpgGKO7kd/EumjmzYUAtB7Ix29MpfgiKDqckK/pEr2PmP1DX9FA
	d7xJieJgkzmWtEHh51ulhGXsLZy0Cx8OpFaGq8yf0kWbCLCjYF2v/5buckuu4rPjIsyY5s6W/zO
	8vy4Cmj5kgDhaiC6bs1nUG32sxcYCD/DubO6+MGHuyoW0DQrEis5ggLyuS5JErjGMPlaajHj3Cm
	AXQ+ueZO3aQtN9c0bwKcFs9GuW/ZHd04r4HF4Bq8YmI7mnXBDXDyoSoL1xwNuCPXElgLo5AjsKy
	RcR1qGNkK6uEy4KuuAp75/GvkU2DaJmObehAgF3dsLKRivy83AZtJGpBfTMMEcs/bA/BdRKN6ii
	Ur7
X-Received: by 2002:ac8:5a91:0:b0:506:8738:651d with SMTP id d75a77b69052e-50b37599714mr83159151cf.62.1774064292055;
        Fri, 20 Mar 2026 20:38:12 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e9abd8sm32406071cf.27.2026.03.20.20.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:38:11 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: tyreld@linux.ibm.com,
	martin.petersen@oracle.com
Cc: James.Bottomley@HansenPartnership.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	danisjiang@gmail.com,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH] scsi: ibmvfc: fix out-of-bounds write in ibmvfc_channel_setup_done
Date: Fri, 20 Mar 2026 22:37:54 -0500
Message-ID: <20260321033754.899928-1-LivelyCarpet87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[HansenPartnership.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,vger.kernel.org,lists.ozlabs.org,northwestern.edu];
	TAGGED_FROM(0.00)[bounces-227651-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37C862E3244
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In ibmvfc_channel_setup_done(), the firmware-supplied
num_scsi_subq_channels from the MAD response buffer is assigned directly
to active_queues without being validated against scrqs->max_queues, the
allocated size of the scrqs->scrqs[] array.

A malicious or compromised hypervisor can supply a value larger than
max_queues, causing the loop to write attacker-controlled 64-bit cookie
values beyond the end of the heap-allocated queue array and corrupting
adjacent kernel memory.

Use min_t(u32, ...) rather than min_t(int, ...) to clamp active_queues.
The firmware field is a __be32 whose decoded value is assigned to an int;
a value exceeding INT_MAX would produce a negative int that min_t(int)
would pass through unchanged, storing UINT_MAX into the unsigned int
scrqs->active_queues. Using u32 arithmetic ensures any out-of-range value
is correctly clamped to max_queues regardless of sign.

Fixes: b88a5d9b7f56 ("scsi: ibmvfc: Register Sub-CRQ handles with VIOS during channel setup")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index a20fce04fe79..5694530c4b2f 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -5039,6 +5039,7 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
 		flags = be32_to_cpu(setup->flags);
 		vhost->do_enquiry = 0;
 		active_queues = be32_to_cpu(setup->num_scsi_subq_channels);
+		active_queues = min_t(u32, active_queues, scrqs->max_queues);
 		scrqs->active_queues = active_queues;
 
 		if (flags & IBMVFC_CHANNELS_CANCELED) {
-- 
2.43.0


