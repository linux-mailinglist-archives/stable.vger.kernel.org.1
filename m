Return-Path: <stable+bounces-254372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN5LEqKwFWpxYAcAu9opvQ
	(envelope-from <stable+bounces-254372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:39:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C1E5D7C11
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0523A3064087
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792F93FF89A;
	Tue, 26 May 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8q9IkJ1"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199F3FFAB6
	for <stable@vger.kernel.org>; Tue, 26 May 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805789; cv=none; b=Dye+p/+cBkhKnqdBL0JxwXH6FWA7O3LQ36gCQxtN/MWY3+Qng4oyO9wxyhxrsaZHfB33cQRoEKFsuKxlFXbzX38WW+Y/ylOIiODqwIsES3uyFCm9onr5RmnMGF2sPYhSQXXPcm77wvAvwKk2fzBZj3fW6KhSMPadJ5WbXny0Sxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805789; c=relaxed/simple;
	bh=t8iULvrUFjdfHnddacmqp3ZwHRl8owAMguuh6bqpWXw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cXBHVJpTHXbSjfBtTjgMZ9KjoAAryqv7VhiFuvc+NO7o236g1EQtr9BVsSCuN4AGP5ceIXBRI3DwUYG/oaTIB6Y50CkzqVZBmkmnI5RiMeJ68IU5y9L1h+j6onXA2sA3IKSs7O1bQJNOIkG/bJdLtFLBkt/9U1VMGMY0sWScQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8q9IkJ1; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-393964e2aecso39711411fa.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779805786; x=1780410586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PT3pEfkfxVmH8RSCJKQXWybdiAmWTUp2RzVFlPVXXfQ=;
        b=j8q9IkJ1FnZlCj9wMfCKgMnlpDbxFEfAWyWdGQleBawo4F8Vtx6hctLh065o3ZbHuB
         Y1ZHDIXtXkrdKDJorpOCbddWC3nRKVE+QDsUWozoV35VsEMiYz/5nJ/s+Gfpo17T23IL
         mXj2lZMM1mQ/4pXwF0UzIiypm/whX/OcEkwKGijCr0QsF/eSk8HBKldqwzsVt7WwUXWk
         x7jA9IQvlDh+yOw550WCtOfuObTe9MJl9E0CTSZrqtFwg3Htz90vGYLF2DhSwSxcHb2J
         qUfZGvmA8CKSrouQdFSuleOewHOsYFqf4A1K/Saia1YsjUu5xjNEUa/XBV3SIPi7YeW3
         9MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805786; x=1780410586;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT3pEfkfxVmH8RSCJKQXWybdiAmWTUp2RzVFlPVXXfQ=;
        b=rAdraAChyKrxH1mkba9klpDeWStKuDPEentQX58aTuBiwmpvSVSpfcrKYk9xtReTIe
         YECw2UWhfsouY2R057QYT/rawq4z9oIupCcJ9OXZhvLUxtqxE7spJbQRshX9POm+Bn9a
         /hN2Bo/TzvMB83jVRTBnLZtmh5NhJohfRuaHw3lI/Q01Yw7vIpsIXcDIQLesY6rr7abZ
         0EcQZ4M/fkLXN2koFUii9CAFTX4ZPb0woVy2doeMrq4M6Pz4EPC3qUqvn7rNWOCOcurZ
         iKFkXM+bDCXmTejG7Cr+qljz+fc2pNMXoosQ7XgDHP//N5eWJ712xz55cujZxbDSXnKZ
         x6uA==
X-Forwarded-Encrypted: i=1; AFNElJ8x8537yuEcnPISFHsD3yNJXsa37v7amH1eHmHc4sYM+phCEuVSfSwkbX+SOSvJuFrAy9OV3vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO36Hx8Ene4sgVcioi5rsA6U+BrNYsRk0HWi7XOMo7WBvVeI2g
	RLuXsyWtoyIdcr1V3sR6b5hmdqeQzsP04qaSn1w/N1sb6PQnMkwmThVKy3WDRZ3bUNJRag==
X-Received: from ljgv26.prod.google.com ([2002:a2e:925a:0:b0:38e:8a9b:c977])
 (user=rnj job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:bc90:0:b0:393:a2ec:da3f
 with SMTP id 38308e7fff4ca-395d8bd3057mr66188811fa.4.1779805784717; Tue, 26
 May 2026 07:29:44 -0700 (PDT)
Date: Tue, 26 May 2026 14:29:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFauFWoC/3XMSw7CIBSF4a00dywGUCg6ch+mMS2v3sSWBhpi0
 7B3sXOH/0nOt0OyEW2Ce7NDtBkThrkGPzWgx372lqCpDZxySQUTxIW4ottey6QoGQRve0a1uhk K9bJE6/BzcM+u9ohpDXE79Mx+6x8oM0IJV/LCVOukuQ4PH4J/27MOE3SllC9AxICIqQAAAA==
X-Change-Id: 20260515-fortify_pm80-b527a10c89d0
X-Developer-Key: i=rnj@google.com; a=ed25519; pk=QwUkB1OONd7dk9zV4pLRQRehoWHHsLcRZD2QcswqHTc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779805783; l=1362;
 i=rnj@google.com; s=20260515; h=from:subject:message-id; bh=t8iULvrUFjdfHnddacmqp3ZwHRl8owAMguuh6bqpWXw=;
 b=60heXesYHrd0tjquVnZnz6fuW08YKkDYOOgSc5mRXSZIBEe4SgxTIm8iTdnKCHDLgCZ/V6kbv vkDzOXIj5cgD5VdyrjMj9M6vYmTQ3LWqXPbP/gRyGwJ+8o9EcWgCv/Q
X-Mailer: b4 0.14.3
Message-ID: <20260526-fortify_pm80-v2-0-359b743eb97a@google.com>
Subject: [PATCH v2 0/2] scsi: pm8001: Fix struct layout and FORTIFY_SOURCE crash
From: Ronja Meyer <rnj@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Tom Peng <tom_peng@usish.com>, 
	Kevin Ao <aoqingyun@usish.com>, Lindar Liu <lindar_liu@usish.com>, 
	James Bottomley <James.Bottomley@suse.de>
Cc: jack wang <jack_wang@usish.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ronja Meyer <rnj@google.com>, stable@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254372-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rnj@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D5C1E5D7C11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series:
- Fixes a crash when the driver is built with FORTIFY_SOURCE=y.
- Aligns the struct layout of hw_event_resp to what the HBA believes
  it looks like.
- Simplifies code previously required to work around the incorrect
  struct definition.

Testing:
- Verified I can still read from disks using the pm80xx driver.
- I do not have pm8001 hardware available to verify against.

Changes in v2:
- Define sas_identify_frame_local via struct_group.
- Move pm8001 phy_start_req _local change to patch 2.
- Don't mess with whitespace unnecessarily.
- Link to v1: https://lore.kernel.org/r/20260515-fortify_pm80-v1-0-2863187f6d4b@google.com

Signed-off-by: Ronja Meyer <rnj@google.com>
---
Ronja Meyer (2):
      scsi: libsas: Define sas_identify_frame_local via struct_group
      scsi: pm8001: Match hw_event_resp to HBA data layout

 drivers/scsi/pm8001/pm8001_hwi.c |   6 +-
 drivers/scsi/pm8001/pm8001_hwi.h |   6 +-
 drivers/scsi/pm8001/pm80xx_hwi.c |   6 +-
 drivers/scsi/pm8001/pm80xx_hwi.h | 100 +--------------------------
 include/scsi/sas.h               | 144 ++++++++++++++++++++-------------------
 5 files changed, 85 insertions(+), 177 deletions(-)
---
base-commit: b71cb088b2e3427924a470fc43e7aedb8a40d2e3
change-id: 20260515-fortify_pm80-b527a10c89d0

Best regards,
-- 
Ronja Meyer <rnj@google.com>


