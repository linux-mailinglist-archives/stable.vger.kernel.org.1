Return-Path: <stable+bounces-220370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGDwA/Vio2kABwUAu9opvQ
	(envelope-from <stable+bounces-220370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:49:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CA31C9466
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E1C1312336F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03273A3538;
	Sat, 28 Feb 2026 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="EYCmKYb8"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C813A3504;
	Sat, 28 Feb 2026 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300266; cv=pass; b=UWhVEBPAoIordrQ57sZUDE7iLHQVuXBdqxlIe4j26KLcxRk1YfnrkgE+olYyZZqRtDIpy5GMIAMQNKNv0UoCqwqvK32c/VnHLzbrBBcYqL4MEZ3d4r91Cq251CI/RP53O+tNxsWlDyyGZatGkP635sEovBSpI3qai2tC3hfWLWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300266; c=relaxed/simple;
	bh=1BJMdPqUAZ4ILPIPkmlYmVhrSric75D5wmL38+wWBLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0AVSxgBzgmHKC3DbybKI4+UUyNfxp5jy92oagTiPskfkE2OFQK1pMrB1ewXP1Nlp3D3eFFc1DPrF15/jMdzp5Ml/LvDJHl2T2rXLH9DtzeamzU/t9Kkax0pB05vJoVs0m27VKfATYf3sjegFkg8ISwP7p45vtNNeYpn8d4MS9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=EYCmKYb8; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1772300246; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hh0lCz+wccDqhmVMWqN8vv7siQVDwraFYbKp/1v80G0w/4mY1VHrE+h2mkO3f7REohjzlHK7gZuCmbWi/nRqsIoDs0ny0nhML3jSCc62iakej3kMtKjvQHNVNUD86oImY2lL1xHSCjLAJgqxtl13T/LlD+XXpkY9/zI0six66ME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772300246; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V0iAzLvH235YmaKmJafhDbAzj392OrkWanaiH+LgkYU=; 
	b=e1CvowAq/MvE8lxLCi58gS97yFi90QOjNxdHNpFXl/N0bve8hKLpQmIYLD1d23vNGeaB61GhrtLziPHqlKY7YlfxI2zpTuy1e87s0zWvqY1kTjUfG9b7Be/nQm3n92x/hj2gyvlGNxQpuDHbY8hlIlmSyffo7j+STpywcndU3Dw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772300246;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=V0iAzLvH235YmaKmJafhDbAzj392OrkWanaiH+LgkYU=;
	b=EYCmKYb8XL1SNTY03vjsTnS5EKl6aUDLeLN2d786oYOoUs83KxaaDQUz2eZaSQ8Z
	5KosPeMBtZyYqWi0/ZWiyDcg9vyY/FfinjkwbwPhf9MfzqP5DWIX3oqJh3SkAw9AB2B
	eF/mAObSDMU62P/E94kIvdDhVP1w97MRtU/C3wns=
Received: by mx.zohomail.com with SMTPS id 1772300243723849.1494629034747;
	Sat, 28 Feb 2026 09:37:23 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <me@ziyao.cc>,
	stable@vger.kernel.org
Subject: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin C4600
Date: Sat, 28 Feb 2026 17:37:04 +0000
Message-ID: <20260228173704.62460-1-me@ziyao.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:mid,ziyao.cc:dkim,ziyao.cc:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-220370-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	NEURAL_SPAM(0.00)[0.942];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2CA31C9466
X-Rspamd-Action: add header
X-Spam: Yes

Zhaoxin C4600, which names itself as CentaurHauls, claims
X86_FEATURE_FSGSBASE support in CPUID, while execution of fsgsbase-
related instructions fails with #UD exception. This will cause kernel
to crash early in current_save_fsgs().

Let's disable the feature on this problematic CPU and warn the user
about the quirk. x86_model_id is used to match the platform to avoid
unexpectedly breaking other CentaurHauls cores with conflicting
family/model ID.

Cc: stable@vger.kernel.org
Signed-off-by: Yao Zi <me@ziyao.cc>
---
 arch/x86/kernel/cpu/centaur.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 81695da9c524..3773784ba6a9 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -108,6 +108,29 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 	}
 }
 
+/*
+ * Zhaoxin C4600 (family 6, model 15) names itself as CentaurHauls, it claims
+ * X86_FEATURE_FSGSBASE support in CPUID, while executing any fsgsbase-related
+ * instructions on it results in #UD.
+ */
+static void fixup_zhaoxin_fsgsbase(struct cpuinfo_x86 *c)
+{
+	const char *name, *model_names[] = {
+		"C-QuadCore C4600"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(model_names); i++) {
+		name = model_names[i];
+
+		if (!strncmp(c->x86_model_id, name, strlen(name))) {
+			pr_warn_once("CPU has broken FSGSBASE support\n");
+			setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+			return;
+		}
+	}
+}
+
 static void init_centaur(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -201,6 +224,8 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 #endif
 
+	fixup_zhaoxin_fsgsbase(c);
+
 	init_ia32_feat_ctl(c);
 }
 
-- 
2.53.0


