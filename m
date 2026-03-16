Return-Path: <stable+bounces-225575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIDAOY0huGmdZQEAu9opvQ
	(envelope-from <stable+bounces-225575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:28:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6740C29C573
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14B3F30A8710
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4E43A6F11;
	Mon, 16 Mar 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmnHLrXY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263DF3A6F10
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674182; cv=none; b=HNILZwUQJw+CF1JoEZ06IGB3eX0OCC9RW2AwSQSNYUz6TFHYVANunCIfuTypARFRNZHlFLG4UIvZbuU/U13nhLbxBl+oOjla5KW3xNXbP6x6EnB1w1LKt/g/aA0+V7tQBhgl9FwGT2H9M0kdqPZZ8+rDO98k1UZbP4mF+wpCX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674182; c=relaxed/simple;
	bh=zaGpMN5MsHeRI5IgLx3OK1qQQFMq33LxzGPJO5RR2RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8subOa6IoZLsrv/hVIr3PEFiHxz3Nboq5DPDAbFVkali3wjYuGNxwWU/3OiA99msxZmn5bLwRfSpgGIMqHA0dKhPyBeK1Vajnh/BfNSlM3zrIbe0ibKptB+37FQkwwAem9e06IE2rbsCP6hSsrOcD6nADNUhLNnzGK4CBLAIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmnHLrXY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso39939845e9.0
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674178; x=1774278978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGf7yZtpUu5J1lX6HR+56oGmyUxqirhDSxD8uYe+Tfg=;
        b=nmnHLrXYZbLWxruy8c4BPXT28GPqzFsEyJEIUgmKXwwyW64IjOXusgT2bwmOVj7NX7
         1ElGJRF8RMzQIkZdabbHy8CTYraV9ulEIBPgVLW20XVa0XJUwfvCkWo3LyyjjMzPyK9i
         CMc/9lV5JabUSB3SBttxu0XHGr6D+wU6tbyfOOanv9Y5SSqvCK2BhGbV7bT821ge9wp9
         CHB1rw0SuNC/BYtIxfsDLhEPi0wbb/HE7V0fwJWjYhc4Ci2H6CrCrj/EU6Oy0GRfmXRk
         +0yiDVNcu0driJvhri3lQULVjNyX01Oyk0xknByQtjNQ3gO/hdXWmu8hCkyx31uCCqx3
         XrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674178; x=1774278978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGf7yZtpUu5J1lX6HR+56oGmyUxqirhDSxD8uYe+Tfg=;
        b=ilK6foxG8IdfrMPQW3ux2h2UrTwb+yTMU0Ev6TBv65jcB4rLizBT7zzXK4kIAfvKxi
         WkxhPbPkrl3siH+T9SR3HHJ/8je+UwA/6urfvv2nrcb1wk56sZ64Yxx/3xbrbvyWEIQC
         wmmMMa9qr3ePa2IuG2E1dwnArJcZrkA10oSJBFUZhlzYJpqlc5VOMTjd94SjhkbuRzbT
         jj860rdcOrPvHv0vIBaME1PbGql2D2vAx4cD7pukkwML/O4av7eaceey9HBFI7Cn9lZL
         LIhSLqp652vpsnQjhf8APsc3njEWledC6poEZvuVx+dHUw19VUX72O8oGnhVa7cUBYqW
         H13A==
X-Forwarded-Encrypted: i=1; AJvYcCWIYA1KYoOEGYliPzkSPg83GclwmA+C/KdEPAlMB+boW5AuwNcYaTN2XvRjG7VHLOYVXFlQ+Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOGUmgfQg5QCqkrixXExdnAojb1mrkJK5E1dxhqpttxy4dyHW
	8VLjE2G4NbyE/+yx21FZdCOcPfFOXy1xIGiV4PuFEEKu5z/ukvy70sJ3
X-Gm-Gg: ATEYQzydMoMQjPmKc3OxoSYnF+dvSCrm2Gxb0KtMNvLM1Jziz4tZR5wH8TmFSabghP2
	rYkTVAEQINDWjOCpg9v+vKCi5CMgFl+eyiz4ua7SSjzlmQ4IyU8NHC7Zwo6Pp92t2wupqvd6Vkp
	wNRs8OUc0Z7muI6cfSllDzuUW8MyIEo030PVor3f9TdmGcHdmNTCR6v4DbVJSHRwJbIhv3DbMQz
	F/fygwym7/aCJyd++1nTkxKNncEOBlN6ScXZB21QmYuQHjBoD+NX/GdDsOW36AjLGgOMDqcxGqW
	7ZdE1bBq/dct3UysXo3Lf9+JIzKwhUBXzg0yEuRmnDr3imsTcSJvuZJjxEQIfFekudiCgdPeTPW
	q+r8QfV36QhuOWvr+asYXi/DKblXipmRaktAw6QR3rf9Ig4B5f7905oBNjI8tn1zvPXGZO24Dut
	m3vnvZKvWz1dN/yE8qC8UC3vT9jdUExanygM2SkmRdaB2QnqcqSVgKCBKw4w==
X-Received: by 2002:a05:600c:c162:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-485566c94a6mr221915275e9.2.1773674178274;
        Mon, 16 Mar 2026 08:16:18 -0700 (PDT)
Received: from osama.. ([102.46.166.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556422338sm99206145e9.7.2026.03.16.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:16:17 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vincent Chen <vincent.chen@sifive.com>,
	Andy Chiu <andybnac@gmail.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] riscv: kvm: fix vector context allocation leak
Date: Mon, 16 Mar 2026 16:16:11 +0100
Message-ID: <20260316151612.13305-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-225575-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[brainfault.org,linux.dev,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,sifive.com,gmail.com,vger.kernel.org,lists.infradead.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6740C29C573
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the second kzalloc (host_context.vector.datap) fails in
kvm_riscv_vcpu_alloc_vector_context, the first allocation
(guest_context.vector.datap) is leaked. Free it before returning.

Fixes: 0f4b82579716 ("riscv: KVM: Add vector lazy save/restore support")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- Add Fixes: tag
- Add Cc: stable@vger.kernel.org
---
 arch/riscv/kvm/vcpu_vector.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 05f3cc2d8e31..5b6ad82d47be 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -80,8 +80,11 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
-	if (!vcpu->arch.host_context.vector.datap)
+	if (!vcpu->arch.host_context.vector.datap) {
+		kfree(vcpu->arch.guest_context.vector.datap);
+		vcpu->arch.guest_context.vector.datap = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.43.0


