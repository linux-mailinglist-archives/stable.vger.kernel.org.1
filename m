Return-Path: <stable+bounces-240977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGi4KNR562npNAAAu9opvQ
	(envelope-from <stable+bounces-240977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:10:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C5646008D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0AC9302BA31
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90D3DB638;
	Fri, 24 Apr 2026 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5B4seTb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227DF1862
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039700; cv=none; b=QexSYyQQtwJPTOjUVvMQxGldcKHlJPgRkKY8SFT9GpgzuldtefQ/937EU2DdiT8gODJW6hCu0bVlP0afjxTieIKgabTWiIAD71LBvz4yljjM0lllsVvbODOGebxZFzWqrIGLG5lweZrpVqQ+KovWb0m6FFrs2sVgSAPJFJ8IxGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039700; c=relaxed/simple;
	bh=n3rAzCUHkxW2VPQkPsU+9d2UlslHroyk8lag8y9MI20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VbDRtA1dIZTIME6hjKXm1AJDTmSuHL0ijkzNuACF/Y6ZCurytnbh0T+i6buSsRWE4YK325PAAo4WFoaePSPMw4j6EzV9Su/4TnHvUqoFFXHO8K5XAxM6NZWtfhKMhC8K2oPrYssyxrpo+kJdVNnGpT3dzquAbSgvg/l8pU3K2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5B4seTb; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dcdca9dd6cso3815577a34.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777039698; x=1777644498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YAH8g2v2vBsoZmgPxB7XwrigYCMZajRhN5tYq8MvnA=;
        b=T5B4seTb+UPyvNGE0J58uTz9LChneC3ZAcaz8Hj6DoPGbBF5cdIU2aEvgVo99vG4jv
         7R0l6xsaLdFU74uLN4OwysetUGaKJ5pS+pVYGiEMuBzBMFkK2r+mA75d/9DGXFQ8Y0Yn
         jUtyX78Gcr8+Raizy4o7OTufDSwsRFk6mkw6Fzm5q1msuR6cb0Cbl5n46iVsEGo5O7sq
         x9w2MH07ecZuVl0jRKprosJZttaBL9K7p25259S06P5UV1C9k6zEpJehAXXrnSfdcmEB
         f/Tiq5ElExh8xq7npVVnbtZXyu98HjHvydZJin0JejKKLJXG29zryveYVVP+Yn/je9cf
         qykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777039698; x=1777644498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YAH8g2v2vBsoZmgPxB7XwrigYCMZajRhN5tYq8MvnA=;
        b=nccFS1Bi7bb9XyVtMUvDNKOyC/g91pb1y0uCsn4BPY8B0R1eRRAhypbQi3TkSQuM/P
         NdPc65XlVzRc7gsio3u+ZuCkMAhrrbuHSZTnUByyEsLAz+FGLt868aRVah0SueSEDRr+
         2KawFULXHqdjRSWWt/cKx/cTl+KOYIlLdPSE7zRyVUL+W/pW5IkSzIOtZAn7Tsibd5s2
         gsMYKodRCn8cjFtgQ/WBUvSHcSKj2TKIYvBQHYGCSZ+iOsiFjZEuJI91APCMdHBkNdLp
         iPB4NBTIgxiIk8zCQEr2r2onWjeE9tINQ7YBTBkAyPQFlPj4l03l4laYmdfyxr4XlqJh
         Ngkw==
X-Forwarded-Encrypted: i=1; AFNElJ/I7Ihi1y5FFxKSqGjkfymIGvm7tLr1dJ4i6gAxdrNky72r4jP/4Se07VY8zwHB606UH5ypKIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC69Z4afXsflXGbFniOMtvKE8NEzSSyV4jh+TC9vOpbOtVhf07
	XCCKS6Y07jrAlUp4S32+qMFMHTcAL9OsHRndSbUOfOsfaCVmDdcnjAFwuiPW6FU=
X-Gm-Gg: AeBDieuBVL25r+K+u645v8AlX0nP2NgEfuvRp21XvARlVtGbMn194TZaJZYmDOOyClG
	ppW+TdBY76+mNMyqGqTw0QY+YpFG+9MwbHncBbinGmFcDX3yE/FvIsxUGVo2xQgquVH3cetXasS
	HyuWkegSxNrxknfVX/69dAnvuLzDzOHo5uYumqBea6lI4vOw2Vh4wn8p37TjZC86zK/DT9CuoIl
	JgE/09rU3lHNgQxSFL8IMiqUjMU6qVuubGAmmE/kciWV2whXtfMNwMStkupVrzoPRtVjAS5/7gM
	CIabEtCg4TGMTb2Ol/wL35fMd3m0wGMnWkTZqD4NqxCNWga/5YoH0kzjkMX2zcoNzFgKwkQUW7K
	pJ8EueoiGSuQcLUnRu4spcLb7nwpU95c2vcmGB59PLzwkgzR4EpxqlX1Jzz0v9VYRPEguCglhss
	wr5PvsFXp9EfrJ0NGlTOeSnE1dPSCrPlLQdYqp9TlnzVEA/ihDHlJ19QG/WKxSBCqR+6v/FWoSG
	OX4JEwj6IUsXDWdL0iDCkrKUOBe/w/spCOo1pHUTJ6ELw==
X-Received: by 2002:a05:6830:6483:b0:7d7:4639:43ee with SMTP id 46e09a7af769-7dc94f97a1amr21338986a34.3.1777039698033;
        Fri, 24 Apr 2026 07:08:18 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2dd1sm22228653fac.9.2026.04.24.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:08:17 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	stable@vger.kernel.org,
	"John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v2 0/2] drm/amdgpu: reject misaligned IB addresses in CS parser
Date: Fri, 24 Apr 2026 09:08:14 -0500
Message-ID: <20260424140816.43766-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20C5646008D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240977-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Userspace can submit command streams with IB addresses whose low two
bits are set.  On all hardware that amdgpu supports, those bits are
reserved (they encoded byte-swap mode on pre-amdgpu legacy HW).
Today these addresses pass through the CS parser unchecked and hit
BUG_ON(addr & 0x3) assertions in ring emission callbacks across
gfx_v9 through gfx_v12 and sdma_v4 through sdma_v7 (35 call sites),
crashing the kernel.

Patch 1 adds an early -EINVAL rejection in the CS parser before the
IB is allocated, plus a defense-in-depth WARN_ON_ONCE in
amdgpu_ib_schedule() to catch any that slip through from other code
paths.

Patch 2 is a trivial cleanup: removing a dead BUG_ON(!bo_va) in
amdgpu_cs_vm_handling() that is unreachable due to the NULL check on
the line above.

A follow-up series could convert the 35 downstream BUG_ON(addr & 0x3)
assertions in the ring emit_ib callbacks to WARN_ON_ONCE, but that is
a larger change and is not included here.

v2:
 - Rebased onto amd-staging-drm-next (was incorrectly based on a
   local branch in v1 — thanks Christian for catching this)
 - Split the dead-code BUG_ON removal into a separate patch
 - Moved the check before amdgpu_ib_get() to avoid unnecessary
   IB allocation on bad input
 - Added Fixes: tag and Cc: stable

John B. Moore (2):
  drm/amdgpu: reject IB addresses with reserved byte-swap bits
  drm/amdgpu: remove superfluous BUG_ON in amdgpu_cs_vm_handling

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.43.0


