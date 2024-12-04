Return-Path: <stable+bounces-98558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F89E4658
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 22:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725F6B31C84
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EA91F03CD;
	Wed,  4 Dec 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUFwwsdc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB61F540C
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343845; cv=none; b=Km8YhvBc7yvs3BxDcIr+5SemylouWpw+u073GwrWs2++NSgMnCh0GUTizOn69tlAiQiTXUDQxDfqomoOZylimQEzMbAQxQSwFNKSmaId1w1Q+rS20KE4MJUrdQ9/KQpAmGI+quKjAYolWUtNJrhdQYVl7GS8p6YQVKSZCWTWhv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343845; c=relaxed/simple;
	bh=MXOiCACkpVOc6mcNafOGPJ4hyrXbRoMooLVv45LWQUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r4qjHzV0qprM5IY6hr68aClCzjqk1JYg3dnQEHWJzKLh+as6G9FjIBWy9aD4x6swKLmSUxTmdawakszXN2w7oiBzmY2AU4ZPSHOZ44eVe1evLUqFKQT9aP5ll3kwGS0qxIsukl7WqsEx6Jt3LML7MJ47bgn3GmhjWKIF+XIvcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUFwwsdc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7259a7fd145so144581b3a.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343843; x=1733948643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Urpq4ZoTz0zlhdaes7Fa3+xbfU+e0tOc7pcRLcJtc8=;
        b=HUFwwsdc+gHYWTOwh1FongCPeOzO5y5uvD8yBtov2BuwoMAUbW41xvTzInk5SPbnn/
         7yIQLFbLrCkHpUOeLgP//yL6obIXgnCWR42k50tbmPH+3hynwp8JE6gy5DV/oyIGRhhZ
         AsdTQU0lrayZxeOYOmu6uJI5bX1ChoxWiGiNZSRbc3vqNyK3KBfwduPC9pa94u4QR6Ak
         YJuYlFWFsQUu3r58hbB+hASxqk9e/zA66oiTvZIuOoq1lGVo/QwnwSgQi7gCGC83prAc
         r1ZrG7x550SqDfOT+9plM92J/OJILLdkAKijQQik9t+m710QTyNL/h7GeGxFb+3unyE2
         yoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343843; x=1733948643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Urpq4ZoTz0zlhdaes7Fa3+xbfU+e0tOc7pcRLcJtc8=;
        b=APGRayutog40f1TE98diaeCrnWLyGSnNDHgh9+2AEU1PMDoLAcT/pI/C/gHBRRcyOc
         U8Z90QMpix1l0rQ+rS8L2m7/o0NvKfgJzh+u3uIO0BTPAjLguV1TBmaDuqSO5s7GxXO3
         GnBU9kfzJoBa+bH6/OzJ84sOfTcBax8eT4Mv/oKX/FJG2gDfVr8HdZDWYqR/eFfx7T/y
         KkbcH6XMVIblA2HH1hduveGSwDMLsfaPOmQEHVmzNsZauDT3kzPoBiwUBjJSvmTXvnAf
         5fD5YkEPRB0Nu5ChpAGzvqCC61/FYB4YoPy9zDOPfugS0tAOgvFmoKnt04Pd8LzJaSeF
         WdRQ==
X-Gm-Message-State: AOJu0Yxff527oQ8en0+oXKhyf0MGWwmuDR9/pQhtQMzLPSTPVGgXStc1
	jIhJNAwnND5EmkG54OGRqH84Id6BAPI0AjAmWvmJqGal8cMzGqcuo266C0Hf51tZo+vtlbJruKe
	c/1rfRVH08OTCVQ9jP2zsxq+ATmlpdueahr7dYn4K9m661SJmUnRMNzTFMTeTaemxK3emkAoV2V
	4fQ1xqLshZ+vQWyKJcuyFvgx1rrmiijJ98s3rp+h81F4ciU9hP3PqDFTTAI8U=
X-Google-Smtp-Source: AGHT+IHH6OFqXpyPi8C0yfCQwnDXJAzhiEtnLdmByQh9n74PQdlopfO8TiWs2x9Rc2ZO26mGluCkQ0+HdW6pU0Kzcg==
X-Received: from pfbcu14.prod.google.com ([2002:a05:6a00:448e:b0:724:e19a:dfd1])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5d1:b0:215:ba36:7b35 with SMTP id d9443c01a7336-215bd10eeb8mr88104945ad.32.1733343843509;
 Wed, 04 Dec 2024 12:24:03 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:57 -0800
In-Reply-To: <20241204202357.2718096-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202357.2718096-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202357.2718096-3-jingzhangos@google.com>
Subject: [PATCH 6.1.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees
 an ITE
From: Jing Zhang <jingzhangos@google.com>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Kunkun Jiang <jiangkunkun@huawei.com>, Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kunkun Jiang <jiangkunkun@huawei.com>

commit 7602ffd1d5e8927fadd5187cb4aed2fdc9c47143 upstream.

When DISCARD frees an ITE, it does not invalidate the
corresponding ITE. In the scenario of continuous saves and
restores, there may be a situation where an ITE is not saved
but is restored. This is unreasonable and may cause restore
to fail. This patch clears the corresponding ITE when DISCARD
frees an ITE.

Cc: stable@vger.kernel.org
Fixes: eff484e0298d ("KVM: arm64: vgic-its: ITT save and restore")
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
[Jing: Update with entry write helper]
Signed-off-by: Jing Zhang <jingzhangos@google.com>
Link: https://lore.kernel.org/r/20241107214137.428439-6-jingzhangos@google.com
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-its.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 7a1569b9d10e..5a8a181cf219 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -855,6 +855,9 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 
 	ite = find_ite(its, device_id, event_id);
 	if (ite && its_is_collection_mapped(ite->collection)) {
+		struct its_device *device = find_its_device(its, device_id);
+		int ite_esz = vgic_its_get_abi(its)->ite_esz;
+		gpa_t gpa = device->itt_addr + ite->event_id * ite_esz;
 		/*
 		 * Though the spec talks about removing the pending state, we
 		 * don't bother here since we clear the ITTE anyway and the
@@ -863,7 +866,8 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 		vgic_its_invalidate_cache(kvm);
 
 		its_free_ite(kvm, ite);
-		return 0;
+
+		return vgic_its_write_entry_lock(its, gpa, 0, ite_esz);
 	}
 
 	return E_ITS_DISCARD_UNMAPPED_INTERRUPT;
-- 
2.47.0.338.g60cca15819-goog


