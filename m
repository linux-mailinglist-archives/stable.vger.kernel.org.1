Return-Path: <stable+bounces-268826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WTcIBoliPmoLFAkAu9opvQ
	(envelope-from <stable+bounces-268826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:29:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 145BB6CC71E
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="ZXEK+s/I";
	dkim=pass header.d=redhat.com header.s=google header.b="B/eAChh1";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268826-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268826-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B13523019B01
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792443F20EF;
	Fri, 26 Jun 2026 11:26:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155B3B6370
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473173; cv=none; b=HmT3DuYjcoKWGU+Xp7HYEO5FvEUerlMaf+wUVFtYCKdqIgqPxgrifz2955TDObH0TEoYDTF7jEi5qRGgiG8i8yGNhIIIKkxYWl9mq7yps1cVw3DQsI1rO8q/KjC0eHBGcsGecjyjoUxMTkRy66uQ3XIwYyFuPJSZDJkJtjttpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473173; c=relaxed/simple;
	bh=BTiqQUMSOEddQlfjzEIoKxPz+WQyffoM0Q7k5NHxz2Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ugzc3qFkPisNV0LGR+MVSmsgqKs8v9TSRUP3lQX7LKaOcKCv668ztV3XT2KkT0nSKLGoqyCOrFzp8EoF20PF8/0YDRm3UX8fRL4iEP66juJK36ZW/q/O8da4lQr/lHVpD5A2WqOezE8O7PTcVvYxMuRIhRNemVYVsy2QX9eFRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXEK+s/I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/eAChh1; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IDkCCiuhicDXUaMKnHvG6FIuaHyDZj0eZT+W0/+GqVA=;
	b=ZXEK+s/IZsDosO5GyOVIYOVmH6nLXkbra2rWbVSkOA3u3BXQ+GmN3t03ci3OhZsSI/B9T+
	c3fIa31MMiOjIVpg85SQmPqiML1Kz9buBjD8s4xZKvubStsgcmBOVPSPEht5oNpiUtM3tq
	MKvdVzfh093jBElwkeb2hDyh5RQt2ZE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-rrMjIfClNf24EvOmsTRBGQ-1; Fri, 26 Jun 2026 07:26:09 -0400
X-MC-Unique: rrMjIfClNf24EvOmsTRBGQ-1
X-Mimecast-MFC-AGG-ID: rrMjIfClNf24EvOmsTRBGQ_1782473168
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-464f7476bfeso655103f8f.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473168; x=1783077968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDkCCiuhicDXUaMKnHvG6FIuaHyDZj0eZT+W0/+GqVA=;
        b=B/eAChh1KmtPciU4H0EGNFhWZcxVw50NotImw/fy2FyfDuDDLgtT7g0PZlRDTXupbr
         hHKGJw4KvY2qPrJZ/EfE7nRkHNzf17h2G0cft8p7bO40TrOysVCssuhapfwoDB9MFETQ
         prJy1q5mHj2q1L8Y7biUWPxYl8MNsiE//T2tgfwF0LeFAfw4mbY/aUu9KWaubb1Tm9hD
         LsmlUBsK5HzomP/t2BwTh1PrPzOMR14yc3xlACB7keuxVEYlaa8HHZCfp3npLlAj3uLq
         Jh2SnhJQvAkdj/oIQenkfMVVfk0iEpi1w044npjxn+6VQYh+/MoT1CJuCG2gxp27zT4S
         Y0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473168; x=1783077968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDkCCiuhicDXUaMKnHvG6FIuaHyDZj0eZT+W0/+GqVA=;
        b=f9FXbzybkcNk370RpN+rSw9e0yFxHjc4YSIjSxmbXBUBxPA0AZ8+MYB8OSyf/QaIGs
         c22wsjxYFrlAr02Xr9xfPxH3hwHLA7kP0uYzEwnpP3hzf7TDIcWhJPnIElbE0gncDMNt
         vpkbdf8ol1nWUclIJirKQgZzHcWhbZUhGHpT2ffQmEh2a8yBlVrjGeS5oeB1j82XLJXz
         vY+1ogvloAkASq450WaYE/FKX0qooPBBV1IKYr7nJOJZ8p5Nlzs+wtQQkJwJYEmT/OoT
         06lxS74uJj5lmqJc7MTh5MotTfvKg6yGmBkXzdOK4+WTYU+2izS7Fwwq8FLOpU8kEW1a
         N3YQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVV0xlk2HIQIx1P0zcEI+ZNu7F4eZCLa7eO4K+p6g6EeShhVsL3mcSKFeOFF0g7SgfPJGpgBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFN8oOkqGGjorHcD4uM2Sx+YK965zAbFT5xPmksgFsKrUiGZa
	LxyZGf1N9xoug+lyh5BepPWrsTxJARv60MXUCLPTw0wb0Zd7I+he6SvF6jDL0ILuczd5Yqx4Tcg
	Oz9jfExSDyLrEWuETyMlWMZ+uy2a0kEl4jzgJ0DGYk+VPkOkhkN3mOlGekg==
X-Gm-Gg: AfdE7cmy0RZ0ypXYcxVFPT3F9tTxm7rwIJUkeVuyNYTEwEiHERawX009MwMe2JR/aWD
	0auq3JBEN6791iHUVaF2Q8kGxH3K2/NZ5TsxiF+5EKkO3AnMl1EBxZWuBxe3zzneIW5QV00+gls
	lV/HnGQ2OCNJd955lYoKtMTNVaue+DXAjD7KquVK6WN9gGSa9Xk1iI8ClGj3aKxwitk6lUQpEpD
	B10xuD2kVrranw1j01zf0m8kuRQtcd7xz5HlckpXTIs+U+MEctpTuUowMR+UZPR9FBesT9plzUb
	UmBBoiktuArEv7D6jw68k5/HC9pa76XfPxOmSmInZx7BDYFSEdDHdWE5iuBX/GqFX0On7e51qpR
	3XwZmPsNvQwdOO+sgXDyGpHl9IhOaJSxta6YyxY90hhxeVVl6zhzg7m9Q9UQu9/2+kzI2s7P4jw
	ypYzhxBt4dqTyMtquo
X-Received: by 2002:a05:6000:4383:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-46dbf9bf20emr11218157f8f.14.1782473168463;
        Fri, 26 Jun 2026 04:26:08 -0700 (PDT)
X-Received: by 2002:a05:6000:4383:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-46dbf9bf20emr11218083f8f.14.1782473167946;
        Fri, 26 Jun 2026 04:26:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c680fasm24687840f8f.34.2026.06.26.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/8] KVM: fixes for CVE-2026-46113 and related issues
Date: Fri, 26 Jun 2026 13:25:58 +0200
Message-ID: <20260626112606.1778248-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268826-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 145BB6CC71E

Sasha, Greg,

this is the backport to 5.15 for the above CVE.  The fix was relatively
simple upstream but only due to years of refactoring and cleaning up
of the code; fixing from scratch is not really feasible so start by
applying the patches that are needed.

Paolo

David Matlack (2):
  KVM: x86/mmu: Use a bool for direct
  KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()

Paolo Bonzini (5):
  KVM: x86/mmu: Derive shadow MMU page role from parent
  KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
  KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
  KVM: x86: Fix shadow paging use-after-free due to unexpected role

Sean Christopherson (2):
  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
  KVM: x86/mmu: Ensure hugepage is in by slot before checking max
    mapping level

 arch/x86/kvm/mmu/mmu.c         | 192 +++++++++++++++++++++------------
 arch/x86/kvm/mmu/paging_tmpl.h |  30 +++---
 arch/x86/kvm/mmu/spte.h        |   5 +
 arch/x86/kvm/vmx/vmx_ops.h     |   3 +-
 include/linux/kvm_host.h       |   7 +-
 5 files changed, 147 insertions(+), 90 deletions(-)

-- 
2.54.0


