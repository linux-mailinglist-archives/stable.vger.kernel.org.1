Return-Path: <stable+bounces-216240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KIIM283j2n2MgEAu9opvQ
	(envelope-from <stable+bounces-216240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:38:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4EF137217
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43EB93069D68
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7006436166B;
	Fri, 13 Feb 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXoIh8yS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C4361666
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993500; cv=none; b=GmCM5QSy4xdc1giuDbpYho0JeIdEGhoVuBj/gWAz3jJjGYcKO39x3O/BVHCwyIz3n+PwBZjKdwY2O8dTHC7IQAycmGBmfIZOR5dVLqm6/RXg+lGxx5vvb7lntVTenGvlupOC5+bA6fygVgto8yQXd7PkRuDrK4PCnvBPWo8+IVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993500; c=relaxed/simple;
	bh=CBGX9joKWS1ZTVo7NrOlT+lG2W3Inq1FjMPAVo9hcsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NLAiR36QkWmFHNB63z0vufvJvuf6lOO86rhjdBRWUvq3btLfpUlaOaFOkw3gVzjv42xi0/g/Eo2ki9Ta0cDu4EulisPVsytuRDnvZOXIBOLDmhBHLMkppYv9C9oubGGhiye6bU+iYNzj/wwz4sjG998eSId/SOWn95W+7zxn8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXoIh8yS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso13209565e9.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770993497; x=1771598297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI3PiRBCJaOtbE31TrtopwnjhpEV4zI9W7Z3S9kmPS8=;
        b=xXoIh8ySqQqJP2Zyi+dUAeOGW3ovD4OjGptfsvDOwfqZlsu5K34vAGh7SXOgzXLH46
         BWbEdJabv9AGPnihRzAYVg9P1TO7vVt/55tnAhGYIKA23mizllDaueHM4bAtifPYOCM9
         pBIMQMMBrDaroYc2EcBnTMwRZSS39ir2IrwVmKcYVvQfsePesnOGRlhD6frJ0nvDGujg
         tOFZVO0T3+g8+evf1gQEjm3xH90oqT25eoud0rWiG7BN7pXuakWIXbhN8oDR88pi8nw2
         TXXVS3O7G+Ah4/tApR4jX/TsENGaM7YZyXjB6rcY5EL8hl6K02XetGGWsZGYyILF/8ro
         2gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993497; x=1771598297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI3PiRBCJaOtbE31TrtopwnjhpEV4zI9W7Z3S9kmPS8=;
        b=rdMfTlV4oNWCApCxK5lYE1v4nc+xMZiV7scTJrC4nHFoqz6OuVjLzgUNdIkm2Encoo
         hhUzSRFKsMuhejFVuB30ibE7Di3RezgQeeoCpThmU2Seg6GMiiGPU1kaSWVqTX+hmtqW
         FgH/tGzcSNwhjoW0X9SyvpvtCvuAmU9c61QNGhtuB24zDyQGzHjhEODCwq7AdncaFV3V
         qPCp8+18TV377HqxGatdX408XedXMHbWO4UGj0C0yTzH76mXuywevYHwT0qourciLo6F
         8u1U4RruH296MDPoBhF9plVEpkdQ7+wnJ9zQOVql47MPwP6JjyCE5lU/gtqj0n5iqESr
         r4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHc3tjw9Ukzeyi5xT8fewoU/leJ00B0gMVSIsfUwm8TOWAT7SdU4Y7Oz3OAqyZ8XM3ZkmUI1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxymBtgAzHNhefYB/GXA0IlklWBLXc0tiTF7NPQu7FaqOHCRehx
	cGoM4Ixsr+i+DAUfWzhtUgsYFYZxXBIFwS5Er2WF3hC/2tzazRWgPZUI80jxfmLLRjys4FcASXn
	RCA==
X-Received: from wmbz20.prod.google.com ([2002:a05:600c:c094:b0:47b:d5ad:dd7f])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:474e:b0:480:4be7:4f53
 with SMTP id 5b1f17b1804b1-48371095fa6mr56214175e9.31.1770993497276; Fri, 13
 Feb 2026 06:38:17 -0800 (PST)
Date: Fri, 13 Feb 2026 14:38:12 +0000
In-Reply-To: <20260213143815.1732675-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213143815.1732675-1-tabba@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213143815.1732675-2-tabba@google.com>
Subject: [PATCH v2 1/4] KVM: arm64: Hide S1POE from guests when not supported
 by the host
From: Fuad Tabba <tabba@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, tabba@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-216240-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C4EF137217
X-Rspamd-Action: no action

When CONFIG_ARM64_POE is disabled, KVM does not save/restore POR_EL1.
However, ID_AA64MMFR3_EL1 sanitisation currently exposes the feature to
guests whenever the hardware supports it, ignoring the host kernel
configuration.

If a guest detects this feature and attempts to use it, the host will
fail to context-switch POR_EL1, potentially leading to state corruption.

Fix this by masking ID_AA64MMFR3_EL1.S1POE in the sanitised system
registers, preventing KVM from advertising the feature when the host
does not support it (i.e. system_supports_poe() is false).

Fixes: 70ed7238297f ("KVM: arm64: Sanitise ID_AA64MMFR3_EL1")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/sys_regs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 88a57ca36d96..237e8bd1cf29 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1816,6 +1816,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		       ID_AA64MMFR3_EL1_SCTLRX |
 		       ID_AA64MMFR3_EL1_S1POE |
 		       ID_AA64MMFR3_EL1_S1PIE;
+
+		if (!system_supports_poe())
+			val &= ~ID_AA64MMFR3_EL1_S1POE;
 		break;
 	case SYS_ID_MMFR4_EL1:
 		val &= ~ID_MMFR4_EL1_CCIDX;
-- 
2.53.0.273.g2a3d683680-goog


