Return-Path: <stable+bounces-98546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBF79E458B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6DF168296
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B41F03E6;
	Wed,  4 Dec 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFHyT/qR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC61C3BF5
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343674; cv=none; b=MFGzWyY93AhGK4bJ2weg7Cjy5WbR7U1d9gItIlVOqmIHlGI4DTpvt4NrOM+weEV1nkBxoyUsh8wJyhNz5e9lj1+ya5ZsTcikIzD7ulOlxMSlrzU9MOQviJik/1FUP2PoLBmmxF6Fpgo+Iy75u0xPZ5ecuY5/Q7b/JOwbvfwvHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343674; c=relaxed/simple;
	bh=WfQHvzrY6qzP7pVrHT1AS38K5kyhSj/smgOAtycnS7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RSlRYJ4iz5d2eS/siFRJrdIiB5w2h8YLPwF83ZzOwSkT+x27E7+5pIIRYGqrjorhS/+cfHGPixkkiGls0uA+tE3CxmdH+H/+eNtGqW2bh6FP180GkzNhFeEifujPQDazqyix71D7JRNUPAHN222G6ePtqLaIOWwRKkfGRdw6Zpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFHyT/qR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72524409ab8so150600b3a.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343672; x=1733948472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GyBEX7xgbm3nL6uVDnlaxlSqNtFmUPqQIDnxeWDIyc=;
        b=RFHyT/qR/ciJiApkI7OvlDLdYI8dQtohBX9gF++hoLbVr1zjnYeFEKT2E7SbWoBlVg
         wC9wivD7lrBh63lesYJYjE7nw7EYy89Cwcv0Z7sbUDNaXJKILeSrN6keuf7DxSDnqt/I
         /zAZ6pvZNfPLTQX3/7QyN4ONTpevOJEYwLFaWObi6ADKbGGJ/NalrnfbUdYx9yn9mI/P
         F03s073UTrOTIk04ToqQlX5siL5ycM8LQQvj6Fi0hqm+1j/oQgr4BwQxcCNJg9s8aMlx
         N7XxB+v87K8KRGrz/FjuVzfmtuM5BPf9lA+FbqSOaVoMvf8mjz1nJwugtOucySCXUExq
         Oe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343672; x=1733948472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GyBEX7xgbm3nL6uVDnlaxlSqNtFmUPqQIDnxeWDIyc=;
        b=oDlbvrnjx1QJNtd2RZhm2OQ00W+0BPdydTf4lz6RiEYeLTRK5q3QrP+qTlpL3+Sb2f
         cpPz1ZVrFSRzfajQin8+HbSPU2vxUXG2VsrqWMWXiu5V9ZZ1+WFGqNY4KkX+gecOrpVg
         1ciBXGxdq1m/8KQeAkNtoCxI8RRau0h29a03BPVV/N8EsVieCEc90zo42P9gWN/dK1vH
         AoNuKTsgHgKbrXKkNBLJ8SkLYiHqJp90l4F6mHtNJDn5HHRDB8l1PAzaOxOLuUF/VLAV
         rBvMqOj0wLg9JiF6FcZXdrMiE3X1OjZiPv4H5wvmu/8dhUwi1jBmkNChLETOJAH5xs5V
         YRuw==
X-Gm-Message-State: AOJu0YwjjFoqhZ1CwzF0tLHRyipbu5xHSkSep75RJuFRaBYoy3RxHRG9
	JmeOL5REEnGgVNiPbMeDfpUwSyHSH0mwXJlPPgJCiwAcXkMgpaBfMykJ1J1V5OED64Oavw7SQAF
	bh8up/+n5jSwbQHpjzrydVDtp5Yp7dL63+ScO4pKJylul/raGbXZL3+D9Q6oV6dd9ThQvCQdqHq
	OkKX9abuMOQPavCwkr5LNAYBi6OfqXyuID5QR8ul86yDHrXhCwB4GgwK0la6o=
X-Google-Smtp-Source: AGHT+IHNi9EGrZ7MAtVE70EbcmUcbdpGbFiS/SMV14HlB57akD5PpMu5hBfK4ya493brQlHljGHHrIynpuOaAAcMog==
X-Received: from pfbjc18.prod.google.com ([2002:a05:6a00:6c92:b0:724:f889:5b94])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b86:b0:725:e6e:53f3 with SMTP id d2e1a72fcca58-7257fb7c70bmr10045580b3a.12.1733343672555;
 Wed, 04 Dec 2024 12:21:12 -0800 (PST)
Date: Wed,  4 Dec 2024 12:20:38 -0800
In-Reply-To: <20241204202038.2714140-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202038.2714140-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202038.2714140-3-jingzhangos@google.com>
Subject: [PATCH 4.19.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees
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
 virt/kvm/arm/vgic/vgic-its.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index a7895be3866d..42753340b5b8 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -714,13 +714,17 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 
 	ite = find_ite(its, device_id, event_id);
 	if (ite && ite->collection) {
+		struct its_device *device = find_its_device(its, device_id);
+		int ite_esz = vgic_its_get_abi(its)->ite_esz;
+		gpa_t gpa = device->itt_addr + ite->event_id * ite_esz;
 		/*
 		 * Though the spec talks about removing the pending state, we
 		 * don't bother here since we clear the ITTE anyway and the
 		 * pending state is a property of the ITTE struct.
 		 */
 		its_free_ite(kvm, ite);
-		return 0;
+
+		return vgic_its_write_entry_lock(its, gpa, 0, ite_esz);
 	}
 
 	return E_ITS_DISCARD_UNMAPPED_INTERRUPT;
-- 
2.47.0.338.g60cca15819-goog


