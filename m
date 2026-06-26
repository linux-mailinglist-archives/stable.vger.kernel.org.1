Return-Path: <stable+bounces-268918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K2vVBUiDPmpqHQkAu9opvQ
	(envelope-from <stable+bounces-268918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:48:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E8B6CDB38
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:48:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=U4OrkqWO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268918-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268918-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E22F3161A9D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27103F7A8C;
	Fri, 26 Jun 2026 13:42:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452663F7899
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:42:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481350; cv=none; b=AZuAQ99eb2wTc7/7vI2f3vxY5b9hN8ShPRZV8pB3PoJ//HfdYv6SnNDh0sNCQWpKGY6qDL3IE6K/tcY/FyrIEY9dO+nwBf5frSW6ft8M0ve4ewgo6e3EZbI27gFThtxWMHzTKs3A79CxgKTTzqMa6Kr0KAU+NT3iYZWszjqNdVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481350; c=relaxed/simple;
	bh=NCklkokdvmbYOYomiBZQpm3ulDs/oMA5t4gf7jJtFIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UviEt/K4sRM04qnEyK9qKLWc+8ubYMQ57e5erOYZ7BJJqrtKmJZhBjWzL5jQngL62b8AhhBwGPt2gT3riQvF2YzfM8q5w8kUBd6jhyHYRcCBnCBUpAgMmQ6hVBbmqbel5LG+eu5ibGQryIrQuKtvj2ZXBhdAUrHvd2RMzA8VW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4OrkqWO; arc=none smtp.client-ip=209.85.167.51
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso895128e87.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481347; x=1783086147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7qA3QCgngkwupOanC4fj5zvyRgNy6GXvi+NFYgoU0Q=;
        b=U4OrkqWOZa2o3/uFnjeUw66KP8z5feZttkxdMRbkxIixqFAnKdaZFf0V4c+CcSiwzq
         ij9KpoAuw7FiDr15W3jy6zlLAFwssvYSs//6AopuVMxuKcc9oybGmmAkzMnmxwcOxQUF
         O0kweyL7Vdbd0zxdc7ijyxbQCT6YUq105fcQ3hEL/5kXhu2KHGxHk/waTClpqO/EacDx
         8WCFaOHshuOROqadtAIW4TOFzbBiaEzfb70X2anOQA1QGx2b2djDb70l0z5muK/lZPIQ
         zi4Yx13mEWmIAtOKaXg3tXGSLP1dkmdQpZgDVgol5Ny0oasg7O4XAvjeeDDMEhGTaHqO
         XlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481347; x=1783086147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7qA3QCgngkwupOanC4fj5zvyRgNy6GXvi+NFYgoU0Q=;
        b=AF6DTV9uGcbJj03TMY5WerGZkOUMVwJ4cN05+Wi2ciFy4iM3d2eCWh4dUFnj5/VcuZ
         hrFkQ7mthHnNwt02kfbkP6JCTeGZWhb38WWzf54rH+6V9N3aT3R3pxFehz5iEwF9AnOP
         KWqDvu/ONm7ONYTwXNDK5N1wnQqjaY7eP/C3n8Y/GlwiIZKtVU/w9GajIxpXdGFbdZZP
         5mc9SU5fnusihjFMuo2cC/n8ZYn7s1/wqpRcxd6iOyn2m3x4NyvAz0B6gaSeFjrduww3
         UU0jXb2QVleiL+l2IK9Xk2XsYgL9pAKtl/PwAMonGOXdH/Vd+OsFyyZJIqxcGWgcx2UE
         Njwg==
X-Gm-Message-State: AOJu0YwViUqeDMGF9pE9Xzjo4HDZMdXaKceOwYl2kLHWqMhs43jbqXod
	wWrZeDuqbzfeBhhEn0S3nLrA8bCxhObrXL85T5WBfglSDVq4LolaupnlVOu5HgNnAOc=
X-Gm-Gg: AfdE7cncChLalg8lwGQGVLcY/N5dszX5dZiTQZFTcJL09FKcTDDPOoE0mtEdI81gScz
	lR/4SnFMv8a6JqWzbjQa2Qf5JwKeP1AIl6RACTULtSn5Ui9ZfEghcx0n8SpnLsxlMRvv6IGR9Qy
	saSPoqHde5cWxK37Fd4eviOi3Z7YvzdNQBHBnO7h2TH7jJgDZGY1pfyHzDt7K5YD5IFv09T4DA3
	ps3mibv8/U3K+aS6VhO7fBDyH3u9Hk+SzsP3dz31JsjmnXokk2GR8Dq15PHC/0wDY5j5foi7l2V
	RlUQY2IH3zBecCw3EIbJwaAV1+3MvLI59KjVXfbw/9I6mNMoeE8FVPCIpA9Dz6KSzciRmrtuK5F
	kTtPbaPy6h5I86kQeo31WRJudzmGKJ7Q7nqCFkKXXGew0+xqbur6d0cFKHlnrkiiv8rKdZJQzdg
	9eFAWuWZMOeJCpgAQ0ewyApxVp08yr
X-Received: by 2002:a05:6512:2521:b0:5aa:68cd:8367 with SMTP id 2adb3069b0e04-5aea1f51f08mr1686486e87.37.1782481347149;
        Fri, 26 Jun 2026 06:42:27 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69580fcbsm3476839e87.67.2026.06.26.06.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:42:26 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oupton@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 6.12] KVM: arm64: Take the SRCU lock for page table walks in fault injection and AT emulation
Date: Fri, 26 Jun 2026 16:42:07 +0300
Message-ID: <20260626134210.228892-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.dev,arm.com,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268918-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:maz@kernel.org,m:oliver.upton@linux.dev,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:oupton@kernel.org,m:imv4bel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82E8B6CDB38

From: Hyunwoo Kim <imv4bel@gmail.com>

commit f2ca45b50d4216c9cc7ffabf50d9ad1932209251 upstream.

walk_s1() and kvm_walk_nested_s2() expect to be called while holding
kvm->srcu to guard against memslot changes. While this is generally
the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
respective walkers without taking kvm->srcu.

Fix by acquiring kvm->srcu prior to the table walk in both instances.

Cc: stable@vger.kernel.org
Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
Suggested-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/aiAZfdeyanIvP8SD@v4bel
Signed-off-by: Marc Zyngier <maz@kernel.org>
[Alexander: __kvm_find_s1_desc_level() not present, patching only __kvm_at_s12()]
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 arch/arm64/kvm/at.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 39f0e87a340e..8192bc0bbc87 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1087,7 +1087,8 @@ void __kvm_at_s12(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	/* Do the stage-2 translation */
 	ipa = (par & GENMASK_ULL(47, 12)) | (vaddr & GENMASK_ULL(11, 0));
 	out.esr = 0;
-	ret = kvm_walk_nested_s2(vcpu, ipa, &out);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = kvm_walk_nested_s2(vcpu, ipa, &out);
 	if (ret < 0)
 		return;
 
-- 
2.43.0


