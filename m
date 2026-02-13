Return-Path: <stable+bounces-216241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IzbI2g3j2n2MgEAu9opvQ
	(envelope-from <stable+bounces-216241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:38:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2C21371FF
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2182F3063416
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9620436167E;
	Fri, 13 Feb 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gx/GmjSq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712B3361DD7
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993502; cv=none; b=W75OYhWLxN7KytpfJxwjVUjSDbPiU5k7sgP6bOzWlVg1NKqTP+1K6PJqEVx9WR0QkMm08YjtyWi31v2pbiFYCAdQ8KWr1XtHZoALdMx6tqwjSitGoMx2gynoFJO/oR182j0enzeYO8/MhJgImAWyV4nqDs1CC+NB8sCLyAQYL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993502; c=relaxed/simple;
	bh=nTibB9VvAnMArBkmdQHWooCRiGNpPUf8nLZ7D5ImAVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=drC8YA/0TXMQjGXhwgK9S0hUus6NDJO779luIj3DMGKiTwmxWxskv5t0Wy1O9Ch3h5Eu0ojDt1To4XW2ljUWqF1vjmYCHMIE3ZXqyT4uIRX/jTU9DvBLYYPXgVt1YZ7WtjfLCjUi8heKtZvJ2Z/MG6kemP5fuhp2ze5fmjVFFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gx/GmjSq; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8fbf7b70c7so22122266b.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 06:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770993499; x=1771598299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwg8k07MnblHsBD301KLHziw381Y4vRMO8Vvy4eyPOQ=;
        b=Gx/GmjSq0yDEqBviWvEbipl9nkUjCfYxOpHPCGt9uVCRd/kSYxE2OrUkz0mCVBpLwY
         FgHwJWMVuSVvr73XLlrCIf14cxXg4snfPqCsAueP24Ai+T6/3pcbPk/4NY4vTYcrr7xE
         kSe9YZEbWpUHEYNr5nPFuNxnes7luzNN0s0q/Lutg+4dPGrUlwblMC3a7teydjyi+2gv
         08KXyQwkHoBASP7zkp7nStBX8qQJI0v7+CaDLOm+ENOfnU9QCinXDTtV1nrlY5qEZyv3
         J4u+MImRZPM7oX/KURfyEWstLncoUq20m5ktsiKag01UwBhcg4GbgP9iY+Wi6NRJPeHr
         QnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993499; x=1771598299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwg8k07MnblHsBD301KLHziw381Y4vRMO8Vvy4eyPOQ=;
        b=YjEJ5g9kkbnCYj7E4fcdVHlUqDCJ9IfA975eEnKhE7P7hor9oaU6uvVgtZg0S0pNrI
         NtveJj2ta4eDP8v0jlzljEBkC8ha6JwJBZkx1dqt08sZnyLKXUx7Md+74EpY6JvGo6Aa
         RHID5sjs5oW5VNpBzCBaFFT8OzQ82lQ0OAiN9/hPLoPhuADBApAgLfKptS7CernK0iPb
         KYIayu3wQuIJkVY6uq8smB259/gUTXCdfgDa2ERfIQrUjtVFWI7UI2Y6rg8JrPk5/G1E
         ip3f0wdMc4Bn0xHEfYSujD0gXsIqaMxuiGOwePNHV/+BAO/6vHdK6JI05ujcwcvFR1fZ
         b5GA==
X-Forwarded-Encrypted: i=1; AJvYcCUSXnEEJbnJzaHYFcf3C4K4/TaR6TOOpoBAAhInkXfF5m5uE/tsZh7nUxtE5B7e/QU4g9+UKDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqxg1U9GOBdAjNQ18GnNyykhrSDUMPwMzQ4qWpqYidC7Fr5dsT
	ni75pngX9VVmtvI9pOH9uXxAUNYWWGaCzuUzy7O4gbXRLOjRwqhirNmm1R+G6aGP03ob089uGYu
	nQg==
X-Received: from ejdbe22.prod.google.com ([2002:a17:906:f416:b0:b8f:7a4f:842f])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:c104:b0:b8f:7014:48fb
 with SMTP id a640c23a62f3a-b8fb41ddfdamr117462566b.16.1770993498644; Fri, 13
 Feb 2026 06:38:18 -0800 (PST)
Date: Fri, 13 Feb 2026 14:38:13 +0000
In-Reply-To: <20260213143815.1732675-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213143815.1732675-1-tabba@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213143815.1732675-3-tabba@google.com>
Subject: [PATCH v2 2/4] KVM: arm64: Optimise away S1POE handling when not
 supported by host
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-216241-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F2C21371FF
X-Rspamd-Action: no action

Although ID register sanitisation prevents guests from seeing the
feature, adding this check to the helper allows the compiler to entirely
eliminate S1POE-specific code paths (such as context switching POR_EL1)
when the host kernel is compiled without support (CONFIG_ARM64_POE is
disabled).

This aligns with the pattern used for other optional features like SVE
(kvm_has_sve()) and FPMR (kvm_has_fpmr()), ensuring no POE logic if the
host lacks support, regardless of the guest configuration state.

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ac7f970c7883..7af72ca749a6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1592,7 +1592,8 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 	(kvm_has_feat((k), ID_AA64MMFR3_EL1, S1PIE, IMP))
 
 #define kvm_has_s1poe(k)				\
-	(kvm_has_feat((k), ID_AA64MMFR3_EL1, S1POE, IMP))
+	(system_supports_poe() &&			\
+	 kvm_has_feat((k), ID_AA64MMFR3_EL1, S1POE, IMP))
 
 #define kvm_has_ras(k)					\
 	(kvm_has_feat((k), ID_AA64PFR0_EL1, RAS, IMP))
-- 
2.53.0.273.g2a3d683680-goog


