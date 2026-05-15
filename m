Return-Path: <stable+bounces-247742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBslOCoUB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:40:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03754FBE9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B209C3086568
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D15947CC83;
	Fri, 15 May 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHeGxc4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656712BEFEB
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847474; cv=none; b=Yarnq+xZyJUMHX9WQk8o0dC2eU7xCR1TaBaPSmE3VtGnPvYIP3LSGxdTodzPBWIrDl1gfldU21Mo0Z1XvWVgYS1HWliKfEtxmZGUSWJWcgtSIFUqNYJBwhGJGcLUEpnxsAVfxU6pAWsR1E7PlAWPv/8dpha0Vt9JLjZ4+DJnE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847474; c=relaxed/simple;
	bh=N9ikYvwVeWzWt/2mT3//uTQ7f/hAfrfWxWay4tNhY9s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cLBYVCadIcxnWJXTz40wNIszE68k50lvjzJf1GegkSyPHSvxClEbSC6O7QN3K2W2r3MTNBQzS0Wa9j5OI1QIf3GiKoN1deRhD9b4s5VFzrz8zLTlYHaB3KvAbB5XYnb+meXgrHuTpbeRb9mDRkdRxJvKi5znLu0GNn8kKaZSizw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHeGxc4O; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-38e9589b7c7so9626081fa.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778847472; x=1779452272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dm/zJLbbgDSNoqLaVbuam14QZYRwWJXjLg7s4Fbg50w=;
        b=sHeGxc4ONOyQ65jC/GYZ+AVDGaKgDIJs7e5ccxnNv8J/9jB39uWZdt1YV9CskvKVt2
         plJJcHga5aCqHtbwc+M8Kd8UW6zXS54T/9Azkwy3peuc7tNdzAgzcL6ODkqGSPacnPd4
         nRCrghG1pgvzKFAcaULLZAGA5tmvNWM29UFSgs5HLOTekg9xdZL/O8FKjIBIvO2Aq/pF
         X8uceFNKkN//4510QZyt2vWhHUhGkU8l4wT06pRz3PI4gdLoILzXFiu4Q7MxZ5MlUJJ3
         10xlRbUWZO68KJoUJeK2ljTanExsNUSENcu2JkNV9I6M6lu/L8I+aK9C3J7KGHYo7nwz
         qpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847472; x=1779452272;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dm/zJLbbgDSNoqLaVbuam14QZYRwWJXjLg7s4Fbg50w=;
        b=JLs1lS9MmDNibFJ44yhyDALw7jRhnehPTyZfZ+8GyoyDy/kYBttzKyjRzZgva5eDs4
         anWZixNxliD7OEISaX8Ni/WAftQMMoakvTaSz6pC2OGxRq1/I0ywUuLWaLfYe85sPPLr
         TmaFqQj4s4hXyxHyWUyWI3oeJblESeHJsCWe/c1LsW5iJFneCEnhBE2Aw8QpY/3AGMpZ
         CyTzh4Q5RarXrlp5SFrHmIuYtU/vBABVdgvNTe94h7WfRVZLq1azhWK0hRKk+5kdqouu
         LuW9dyfCVXHWOUI8Qjh90FHAGEAzzjGOJ0aHhF9Ft2YuGoTdgBOMtQ6D38wEnyxTUHGv
         hnOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Oj/+HXTswpmLjLV8tbF/LzQAjP2l2iMIEBOKjl+P32dzWLSh0QW7auq3MGHTm+eH+jIW6FHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxio1xKUBx4VEvCFYDBfGbbCsCGozaXImWfDcKFSLVUn8yjLNaX
	hiav4QVJidXwA/BQuYAGkwOr2JwhJDV3Wmfj/jS5Fzt/PNtJtfgCQ7jPy/92dvBmydLO7Q==
X-Received: from ljbq23-n1.prod.google.com ([2002:a2e:a017:0:10b0:393:9f55:d15])
 (user=rnj job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:3507:0:b0:38e:ae31:f0a5
 with SMTP id 38308e7fff4ca-39561c3db53mr8723811fa.9.1778847471538; Fri, 15
 May 2026 05:17:51 -0700 (PDT)
Date: Fri, 15 May 2026 12:15:38 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGoOB2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NT3bT8opLMtMr4glwLA90kUyPzREODZAvLFAMloJaCotS0zAqwcdG xtbUADVjNBV4AAAA=
X-Change-Id: 20260515-fortify_pm80-b527a10c89d0
X-Developer-Key: i=rnj@google.com; a=ed25519; pk=QwUkB1OONd7dk9zV4pLRQRehoWHHsLcRZD2QcswqHTc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778847470; l=1021;
 i=rnj@google.com; s=20260515; h=from:subject:message-id; bh=N9ikYvwVeWzWt/2mT3//uTQ7f/hAfrfWxWay4tNhY9s=;
 b=33hkqcbK6GMpl9qSkXZ0k6mkZQRpQZxwGylyQ4UaSKzkpTQHMIyBg4RdOBg8kZErs3RNunxjo aIFWbJ8AAa9AvhCKbxy01yPw8eQBG5giNeInJR5845M3O0C3i60kPx1
X-Mailer: b4 0.14.3
Message-ID: <20260515-fortify_pm80-v1-0-2863187f6d4b@google.com>
Subject: [PATCH 0/2] scsi: pm8001: Fix struct layout and FORTIFY_SOURCE crash
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
X-Rspamd-Queue-Id: 5C03754FBE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247742-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rnj@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

This patch series:
- Fixes a crash when the driver is built with FORTIFY_SOURCE=y.
- Aligns the struct layout of hw_event_resp to what the HBA believes
  it looks like.
- Simplifies code previously required to work around the incorrect
  struct definition.

Testing:
- Verified I can still read from disks using the pm80xx driver.
- I do not have pm8001 hardware available to verify against.

Signed-off-by: Ronja Meyer <rnj@google.com>
---
Ronja Meyer (2):
      scsi: pm8001: Redefine sas_identify_frame structure
      scsi: pm8001: Match hw_event_resp to HBA data layout

 drivers/scsi/pm8001/pm8001_hwi.c |   6 +--
 drivers/scsi/pm8001/pm8001_hwi.h | 103 +++++++++++++++++++++++++++++++++++++--
 drivers/scsi/pm8001/pm80xx_hwi.c |   6 +--
 drivers/scsi/pm8001/pm80xx_hwi.h |   4 +-
 4 files changed, 108 insertions(+), 11 deletions(-)
---
base-commit: 98f69975d4c0434ca2e6e8cfa1d8d51647a20593
change-id: 20260515-fortify_pm80-b527a10c89d0

Best regards,
-- 
Ronja Meyer <rnj@google.com>


