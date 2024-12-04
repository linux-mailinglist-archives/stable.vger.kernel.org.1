Return-Path: <stable+bounces-98549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70F89E4598
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A243C164807
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5123A1F5414;
	Wed,  4 Dec 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqOIas7K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70881F540E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343790; cv=none; b=T6zAaW2yW4XbHX4nW5nM77HobFko0lG5EcNWidqjIMdCGMw4W3fefXXmF9W/bhfVGz5q67ynFLeAGVE5nRBXY3Yymk717/RIOi+P/Qywp8MG9kgQHXSPoliKvhgQT86e3TYzyfaWi95JTgWrzmSxr9Bws3vCukDw8VtiJqPpdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343790; c=relaxed/simple;
	bh=NlOpZ+BPgtnXhjo4CLmyVoEWAPY2XItVR0IA8DkKV8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R4oh+KtBCdfjwRSGZxcSps5Kk1aTGYbQ+/rP9JkePTQIPdtA8oCnZt8wVh1u4+S4IGie+hUvWvsnLXFlUOil1xTt4FlOgc1zGPAkGJscjqFSmB8SofpOa2GyJbrXa3jopYWBrDIQZjEyQxdkoDwc2gKT1EJXGZKmCc/Qw3P35Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqOIas7K; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee0c9962daso239573a91.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343788; x=1733948588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXuMzIuGHuPyiMjfR7MFZH/isNz94m7GQQ/lJ4B6iGA=;
        b=sqOIas7KVqIV5yrOGw3gR/UWF+YVz6YTSPv5BQF+hRvrnz95W/KhqUVZO7qOQofivL
         qRaXKXbX0BAJZLS7jX17447ix0QmW79wZI8nPxhtryYRhlaxY2czvt83dmxN3promVFn
         Ax1Mznchi0NfycR102iaO/MkDRmfQoo6tI8U7F8AGG3WHsWFTafFcmYxXzfFLQyCKlqN
         LHuUdr3k9w+UVQnYR2s88AF1qeQm1TZTU4gfNtr/YLllqo5OeyYhFKcl6Kuwhw00d1Vd
         kEkszPlgxe0A0dN70yIfQUfxMSed91srUKAKO5+SkIqsMSD6oP/+iHRsGiJBuj0EXoON
         WElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343788; x=1733948588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXuMzIuGHuPyiMjfR7MFZH/isNz94m7GQQ/lJ4B6iGA=;
        b=YJU8p8AM4VdZ46ODTUqWKUuUGgilUIOoShBsdXys4KO/UPl8XArkx0BCKHHuleLhfE
         FGjneVbMO5jAujpFV1z2HWDPhOLlOrKY00chh9kMrJrwlsJ0CAUOm+aVNpg8dq9a+ZLE
         D1SFj0ovcBocKTMr1NoegFBWIijRsHzn/TGYob0HvTYrdaWczxU4ftW9hdgKXSS02yf0
         oQ3jEFmPxSOwcdTZqjEJMzsROWSt3KUVyrx2/CuNNwf8ovBXmmA9O2jBITyMz3rhHjHM
         YQOc2bemjniKssXl1S6jJkNKFtxYUOkOn4HSDAFWLj4PEP8PNqaRbiq1O5ks1C7QuOyL
         gUyg==
X-Gm-Message-State: AOJu0Yxs0cA3GM9wZTFFoQf17Pxt06cYTzsm4T5BYGJg1j/Rm69tWE0h
	aapv+2JICYvhbBz3khQ0LW+Eek/nbLk2JzOtcrYaUAar3HVibjgg9tya8Miu7q9kr7Xq+Lr3lvg
	VHGAq6HUhqKR6EejJxJzGNEpIOxkXrdgmKhgCrym/BZMSXjHCxEFx0dW8os8RZoHbVXAoN7tDap
	jqorys3cwt8s7/GKopht3WxffdOFzlgWkhGfqzgdz+FPcqd3jrvI/PMNlQHuo=
X-Google-Smtp-Source: AGHT+IECeuCdmrAcIbs8klA/hd6UhaKRm0edCoxBzD1zD+cIZ8wVBL7xrDe7b9+SQscHxdyOeE1SfrmJvW7nBm0+KQ==
X-Received: from pfbf12.prod.google.com ([2002:a05:6a00:ad8c:b0:724:f17d:ebd7])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c09:b0:2ee:3cc1:793a with SMTP id 98e67ed59e1d1-2ef0124c720mr10571240a91.29.1733343787765;
 Wed, 04 Dec 2024 12:23:07 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:01 -0800
In-Reply-To: <20241204202301.2715933-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202301.2715933-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202301.2715933-3-jingzhangos@google.com>
Subject: [PATCH 5.4.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees
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
index 682ff15e3eb8..6e136b2e8de5 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -854,6 +854,9 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 
 	ite = find_ite(its, device_id, event_id);
 	if (ite && ite->collection) {
+		struct its_device *device = find_its_device(its, device_id);
+		int ite_esz = vgic_its_get_abi(its)->ite_esz;
+		gpa_t gpa = device->itt_addr + ite->event_id * ite_esz;
 		/*
 		 * Though the spec talks about removing the pending state, we
 		 * don't bother here since we clear the ITTE anyway and the
@@ -862,7 +865,8 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 		vgic_its_invalidate_cache(kvm);
 
 		its_free_ite(kvm, ite);
-		return 0;
+
+		return vgic_its_write_entry_lock(its, gpa, 0, ite_esz);
 	}
 
 	return E_ITS_DISCARD_UNMAPPED_INTERRUPT;
-- 
2.47.0.338.g60cca15819-goog


