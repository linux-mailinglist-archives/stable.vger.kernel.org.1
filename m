Return-Path: <stable+bounces-244294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CZ4OIQSg+mk9QgMAu9opvQ
	(envelope-from <stable+bounces-244294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:57:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DDB4D576F
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A52C30262E2
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 01:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8E5270552;
	Wed,  6 May 2026 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFblWHjK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E022FF22
	for <stable@vger.kernel.org>; Wed,  6 May 2026 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032640; cv=none; b=BLL5PoCSQEXXSWPXyB4bjl6n/5H0R3mFDOh11jX2qQ2F8alz07bveOmmtshZwPCjBvzHA7oFR18iEPRrWvMZTwoKo/bTx+QshCPeVR7ROhj2OapwQ0BOH4jsZgyLsCR+BS8h5eJr4mW1Wy43zudHbBBUZ0aIDP6Ex0Yp5QpOegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032640; c=relaxed/simple;
	bh=IdQ0mV528iDfyT6R6LbbRJiWvBVtIbptQF53wVgrLbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1pfzCIj0XHr3hfn2WWrfHcWBFBX/8zAcGEMYkigiwDLKzYLLYqeViFAiKBG+eyHUi5yOzVNJL7zZNJN6ii1PGyXsxIK18brjRQGUDCfBrEcwGIcVquqiWnVRSLkXpzHNS3xrb54rBTE3UVhKm43CUtt8ncRH2yswFiEbM7rsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFblWHjK; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dea1272943so3566109a34.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 18:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778032637; x=1778637437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22WTcveuGSrFj/GQ74ZxpS5we3jLZD0DQfUWzvBtg/4=;
        b=gFblWHjK04dCBmkiKXCFU3czY1dZZ/k9xEELwrzJ2giDsCJNKhV/wvdn0/sdsxmjJw
         rWUu4zlPi1v6pFg3IMpImbHkq9UMkC6Vi/j3+CRxqYwu0ftifp6DsJfipI4vmr0deMC1
         7OSG59DtF0fIq/JW373p1OfL+DKq3DLbaNFpGZqCA8OIz1cpRiXgVvba5M2vDRoTi62N
         E47tDSZHqw2AqhZ8jrH8KOdPdYOMmtCU60NR8IGsjzGHG3kM0Nr6tTpSs1RQ0Kl0bI6h
         IGkAUvgBjBfDQLCsOY9d6XkD1hLyf59j15HJngvZ/213Osx9uy7mkdOKdNzElSg/jXic
         tdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778032637; x=1778637437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22WTcveuGSrFj/GQ74ZxpS5we3jLZD0DQfUWzvBtg/4=;
        b=fazsGqHevFgz48MhjlFbKTTsB2fGK8GDGLfoi/R+rZ6Jo0zdX3iCBVwqBPGBe7mIvK
         X39wj6z4+5Q/oC4xaM2KqYP1cgT0osB1DWLegIf1LPAxyofQ7US1sCZ52uP3TzJt76sY
         E8t9n+dfqJdGilhTHGLjyUTxhQ39dHvN3aSMfJOjSWreiFsj1ROXeDA7fTBPCqHS+glj
         zSKbU54qtJyTjjiES/BO6g42r9WMsaHB6ZVo2VJYnqBiZf1iT3zhjJjjzyb7LvWfKN+H
         8so6bCVnTINEKwdaJEthakYnbGInehL3OeuQU3UNtAgsC6xI5mydyzm+J5bX2dTln5Lt
         mtBw==
X-Gm-Message-State: AOJu0YzwCshLbogfKMM8txN2+f5JMlJZEAV+LG0VImDi5fU6w0yW4z72
	+5SKXp3E7JMCKuRUQq83itg1kGKn3PzEfzjLJDUywQsMKxIr2NdWT5LsSSottQ==
X-Gm-Gg: AeBDietYjUOX+D6BJuAhGXXYNqlm9YCk5318x0fNDjqm/BzRpzL/RBohJ9iNJ4aJTNd
	+UQrRj95BOehLrpuPceHJp2iqfguWEuy1OPOM+HQSrbisSFO7piwPayWIMnpl53i5vlj/bfwovl
	WfsR0axIyImI89TCckis9nn+1IrFaUPePFfLw4oGROMjbmzH2eXhVzTIIIQ7hK5b6X1auBKb75U
	ynW6WA2ZFwsUQNvOFTADcjnZbqEdeBVJizBn9fwJTjZguqTDii3tiND4hk1NmvlrowOC7tUZC6Q
	Zg5nSYsXmPZmYNBTQna7KFWequfTcM1H4Srr3mchFTMp9H2GrG7U/joeOcWp1L6woWMyE31hDZf
	zafjhXR6yO4G+VtYN1SwtNxELqY7veRqSD2lxElUkGGHF4w18Kh6PyL/K94ryuSEAlmoB0KG+/0
	ojKG4O/G5rXByv9sHrMUV3GffY4J6eelRHUXWb5PXMUXtzdG+G6oZbR0aQ3NUeY6/OKm3nJw==
X-Received: by 2002:a05:6830:6d29:b0:7dc:e37b:b5d2 with SMTP id 46e09a7af769-7e1dee9c9a7mr783687a34.8.1778032637383;
        Tue, 05 May 2026 18:57:17 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7decac8ef53sm11452756a34.21.2026.05.05.18.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 18:57:16 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: stable@vger.kernel.org
Cc: Sam Edwards <cfsworks@gmail.com>,
	Sam Edwards <CFSworks@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.18.y] ceph: fix num_ops off-by-one when crypto allocation fails
Date: Tue,  5 May 2026 18:43:03 -0700
Message-ID: <20260506014302.4261-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2026050453-gesture-wrinkle-173c@gregkh>
References: <2026050453-gesture-wrinkle-173c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1DDB4D576F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244294-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ibm.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

From: Sam Edwards <cfsworks@gmail.com>

commit a0d9555bf9eaeba34fe6b6bb86f442fe08ba3842 upstream.

move_dirty_folio_in_page_array() may fail if the file is encrypted, the
dirty folio is not the first in the batch, and it fails to allocate a
bounce buffer to hold the ciphertext. When that happens,
ceph_process_folio_batch() simply redirties the folio and flushes the
current batch -- it can retry that folio in a future batch.

However, if this failed folio is not contiguous with the last folio that
did make it into the batch, then ceph_process_folio_batch() has already
incremented `ceph_wbc->num_ops`; because it doesn't follow through and
add the discontiguous folio to the array, ceph_submit_write() -- which
expects that `ceph_wbc->num_ops` accurately reflects the number of
contiguous ranges (and therefore the required number of "write extent"
ops) in the writeback -- will panic the kernel:

    BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);

This issue can be reproduced on affected kernels by writing to
fscrypt-enabled CephFS file(s) with a 4KiB-written/4KiB-skipped/repeat
pattern (total filesize should not matter) and gradually increasing the
system's memory pressure until a bounce buffer allocation fails.

Fix this crash by decrementing `ceph_wbc->num_ops` back to the correct
value when move_dirty_folio_in_page_array() fails, but the folio already
started counting a new (i.e. still-empty) extent.

The defect corrected by this patch has existed since 2022 (see first
`Fixes:`), but another bug blocked multi-folio encrypted writeback until
recently (see second `Fixes:`). The second commit made it into 6.18.16,
6.19.6, and 7.0-rc1, unmasking the panic in those versions. This patch
therefore fixes a regression (panic) introduced by cac190c7674f.

Cc: stable@vger.kernel.org
Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Fixes: cac190c7674f ("ceph: fix write storm on fscrypted files")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---

Hi stable team,

Beware! This is my first manual stable backport; I followed Greg's supplied Git
commands and read process/stable-kernel-rules.html, but novice mistakes are
still possible. Please scrutinize appropriately. :)

This patch does not substantially differ from upstream; I only resolved the
`rc = 0;` conflict.

This fix is currently unnecessary on LTS series other than 6.18, as on those
cac190c7674f ("ceph: fix write storm on fscrypted files")
has not been applied: there is no panic, only degraded performance.

Cheers,
Sam

---
 fs/ceph/addr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 390f122feeaa..3af6795cb3c1 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1373,6 +1373,10 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			/* Did we just begin a new contiguous op? Nevermind! */
+			if (ceph_wbc->len == 0)
+				ceph_wbc->num_ops--;
+
 			rc = 0;
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
-- 
2.52.0


