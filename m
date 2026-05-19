Return-Path: <stable+bounces-249595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLhVCslqDGo8hQUAu9opvQ
	(envelope-from <stable+bounces-249595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:51:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA374580045
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43E6130346E8
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6E39D6DD;
	Tue, 19 May 2026 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpAJtIWq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA92D0C63
	for <stable@vger.kernel.org>; Tue, 19 May 2026 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198660; cv=none; b=b6oP++Itf7FbtcUPwRbfa6+PfPt2eZfhqLY4JKcQmWHG0Vo/dzFOxLsi2f2RHAHsl+wYf0TU7HBgE3duVVNDO+hcW0fxj/nYXmv0TH7a7D7X41p0w24N8sPVG8FtgplGP58SQtqqPqH7k1vvjRkF/Pytup03PqvkRVRBc6oC5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198660; c=relaxed/simple;
	bh=bG/QhvrDzqOyTT25ScqRVuCKWen5BPNvWMdOdivWRMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqP7KOyNsETu87Xd5+W1sdam3v08T7Rpyd8XCRiwFXKkU4HkY6V44SqZGvElJIIGaHFw3jtVAg7QU5PegvI+Dfta1TeR+ellhtV6vHthuh0vv3Bw++oaj5ZHwFwU06BCgVsios+cBhjwrvrgSvI2Oj9x51y7dRf7QokiW4foTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpAJtIWq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-512f750d4b2so44782481cf.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 06:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198658; x=1779803458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUcArKvUj1jkcs2OK6MvhEPcHSKMY4c3Dv90/tfztKo=;
        b=GpAJtIWqlaPedXXMydnT00OZTNIjv+WCoN11VCtC76YjXIj3s4SbneP/We2Wxylluw
         B1ddqzLhIjV/eLzYNe7/LntPCPfg+T+KlY4wvySWJuav198Bfda3N/Qs/lcOqAtWNP9a
         zmeCQH+UigUztUgAswslwh9AStbMYkTctecUF/dpwGTqN73CO8zaJIXpCuaaETkGskq5
         zo4XZ3298eANsmXOfXopXH8IwdkbK34k4BeTBbAZGl7DT2I9UTgXDHsXIpSdlxUt1Ld6
         UGU0j/rHu9u2+JodkwVKacqHDuceItlafFImLhtcirLMzgwfEjLMXsoixnZPiVK6KILG
         vN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198658; x=1779803458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yUcArKvUj1jkcs2OK6MvhEPcHSKMY4c3Dv90/tfztKo=;
        b=T6mLluRAuSqMzvRJqoK4nFv1qju8N1MP9SEw9xbH6tXo5VXAu8ndJqTfhTA9dTkJ5P
         j3XvYKY0HtD2+4kndFzYJBMGBU8yevt0Vfw3J+GsK8KJhTiIzTdrv2b5U/iEkQNb18sj
         LpUxnH/lBAGptR/5/tDewYU4fd/sOm1rue2ufdhmOSsjU33DtD0JJtFkrICsJOyNd74b
         2gtFl9URjgRDP3OvgHuforuRczlowy87Py1LYuDygbkynKVK6kaMkJ+xiIM01xZQoJA0
         Z3QvMsOtSHjmMticfS620hxSk7GZDEyZtHYsw3+JNaoTExQnSEIh7ao4n63Zaczi4fRl
         J84A==
X-Forwarded-Encrypted: i=1; AFNElJ9X6Unvcj1irvlkg1k7BsGXOgT/H3yG56ofS+iiF+k69iO82+6J9gpqiE91l9x2w3fjWVY10zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr96WDeFYi54/DBgfbOyLa+9iZsOZ2vANizBWMygifpQ9qbp/8
	HS1CEqB0s+LQZv1ORh7nfBp5PRM74pm0+66B2sXRb+gKABDqB76cgxUd
X-Gm-Gg: Acq92OHXkPT4sl0StbIkYIkZt0+6LSXRabvSuBFeiUmhtungfHbHnfK8YfZWqdWswz/
	+pB6+XlWLk9df80x/qwThH69euw0FRtU8PZg3thcvqljLvt+PO2exkq89LsJASf/Mk6TOo2IZAF
	PTf/yZx/fdXZEPjUtlam+oFsQxBzdXG8eyls9JFIh4dK67ZB0z7Vq2qfhHJlY89wVFweX4c4Cv9
	mTxAVyL6JL8S6f+qTXDMjUk54d0oaNBbFm2QnJvnx4siP710Pw+qiRPLHKeZaHy6gXvkFyAwCnU
	sDHAAQHCVWEe7HIl/kTZaVtIlMMQQ33UOAla6ka38FyjPQa+O9grNVFUz1Vipb2RxhMp1i2plh4
	oHdcNf5Xo2cpGGcWxD47hLdUs6LT9w2Ua3zB8dpLZTTh1m6fJrb7ljUO8YFhaVGg0WL4ELW8taD
	ztmOd6Vjpwejbmv+ZUjF6MlAPCVUeYU5MEJghr1sUM1DX3+t+O0bodVW7gA7DRFFDUSL6pNYsBI
	ABu95njPDp3CHkEi2y+
X-Received: by 2002:a05:622a:5e16:b0:50b:445a:4139 with SMTP id d75a77b69052e-5165a30cb12mr283906821cf.54.1779198658020;
        Tue, 19 May 2026 06:50:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516457da48dsm162585401cf.17.2026.05.19.06.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:50:57 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Yao Yuan <yaoyuan@linux.alibaba.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: arm64: vgic: free private_irqs when init fails after allocation
Date: Tue, 19 May 2026 09:50:42 -0400
Message-ID: <20260519135042.2219239-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517181331.367676-1-michael.bommarito@gmail.com>
References: <20260517181331.367676-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249595-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,alibaba.com:email]
X-Rspamd-Queue-Id: CA374580045
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Companion to commit 250f25367b58 ("KVM: arm64: Tear down vGIC on
failed vCPU creation"), which added the missing kvm_vgic_vcpu_destroy()
call to the kvm_share_hyp() failure path in kvm_arch_vcpu_create(). The
kvm_vgic_vcpu_init() failure path immediately above it has the same
shape and still needs the same cleanup.

Call kvm_vgic_vcpu_destroy() when kvm_vgic_vcpu_init() fails so private
IRQs allocated before a redistributor iodev registration failure are
released before the failed vCPU is freed.

Fixes: 03b3d00a70b5 ("KVM: arm64: vgic: Allocate private interrupts on demand")
Cc: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Changes in v2:
- Add the Fixes tag Marc agreed with.
- Add Yao's Reviewed-by tag.
- Trim the commit message.

 arch/arm64/kvm/arm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 176cbe8baad30..5d5e2f81b9c94 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -554,8 +554,10 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_destroy_mpidr_data(vcpu->kvm);
 
 	err = kvm_vgic_vcpu_init(vcpu);
-	if (err)
+	if (err) {
+		kvm_vgic_vcpu_destroy(vcpu);
 		return err;
+	}
 
 	err = kvm_share_hyp(vcpu, vcpu + 1);
 	if (err)
-- 
2.53.0

