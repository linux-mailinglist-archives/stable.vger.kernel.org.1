Return-Path: <stable+bounces-165502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D32B15E82
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 12:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183E5563448
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE92690C4;
	Wed, 30 Jul 2025 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="pAiEjjti"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF71A83ED
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872870; cv=none; b=EfvPBWV8Sai/NtcQygeXRJwywA1n4cZGqNKJ199W0LsTtj4UoAtINWLrWKBrrzUSwTGGEXGCq8ImkXOVBH4tiScES/TJxwAdt0f5FJfZpjMTA/tC7lEAfzc9PJVfJBEr7tkwcv4zm0im2uaoiEwW8TYy2/AavXyuQRhIPUh15DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872870; c=relaxed/simple;
	bh=6kgAWTrsy8tcfMWpM58jGAQr+rQnpahcSEbye4YkNfA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DZNXqqZHFe8LehXqChy9dR6MzphYOctjuXzsT7AzWfALBNFZp8zRloGXRGipwu8Y3HzEifkjrqBD8NPFgRpvt7PhPR6uT2fq8rAHRFa/uVKD+N6LLhHyeCt09RbJKnNLiLDWdizRPWCkT7GR/P+BX1E6fcb4x2cvKr9qZXa5XAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=pAiEjjti; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1753872869; x=1785408869;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=NuVZUzDGSawYmBeVLvzEnmb4lRBfWOjfBmp/0WfH2gQ=;
  b=pAiEjjti6B0ST77WCVp9ADwqFytoxLjabCj5bnB8wt/U2dscNiU0N0Bg
   TQGdpzIzMb7ojinqVDZvjAuFA4/iRJth8M0g5TayskATwx6GvqOFXJdSE
   WSNpRaS3NLiL7fCZ+e0rm/6nU447fnfag8mYmkMXTOEB4JAxDA5HE/Dsu
   YurDhfr5v/gabqehQr3zKDP4ypI56DhlEdklNplg/NwCtYsZiZWKCvGIu
   /T1cHJBEc2e2x2afENsfvrU/vo935yVY4CEhJ2ZXu3oP0H7pZck/T4Ip+
   3RbavLbj4+wMCQ45la+PeAzkm8qZ6CgYa0QCsJDP9j0ERN1/zZtngmY3h
   w==;
X-IronPort-AV: E=Sophos;i="6.16,350,1744070400"; 
   d="scan'208";a="519441583"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 10:54:26 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:31872]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.198:2525] with esmtp (Farcaster)
 id c0f31615-4fd4-4f97-aa6b-9319b63d102e; Wed, 30 Jul 2025 10:54:23 +0000 (UTC)
X-Farcaster-Flow-ID: c0f31615-4fd4-4f97-aa6b-9319b63d102e
Received: from EX19D015EUB002.ant.amazon.com (10.252.51.123) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 30 Jul 2025 10:54:21 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB002.ant.amazon.com (10.252.51.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 30 Jul 2025 10:54:21 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.1544.014; Wed, 30 Jul 2025 10:54:21 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nianyao Tang <tangnianyao@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, "Roy, Patrick" <roypat@amazon.co.uk>
Subject: [PATCH 6.1.y] arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits in
 ID_AA64MMFR1 register
Thread-Topic: [PATCH 6.1.y] arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits
 in ID_AA64MMFR1 register
Thread-Index: AQHcAUBONQXj/76f20GQvs41XuzDEw==
Date: Wed, 30 Jul 2025 10:54:21 +0000
Message-ID: <20250730105417.18254-1-roypat@amazon.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Nianyao Tang <tangnianyao@huawei.com>=0A=
=0A=
[ upstream commit e8cde32f111f7f5681a7bad3ec747e9e697569a9 ]=0A=
=0A=
Enable ECBHB bits in ID_AA64MMFR1 register as per ARM DDI 0487K.a=0A=
specification.=0A=
=0A=
When guest OS read ID_AA64MMFR1_EL1, kvm emulate this reg using=0A=
ftr_id_aa64mmfr1 and always return ID_AA64MMFR1_EL1.ECBHB=3D0 to guest.=0A=
It results in guest syscall jump to tramp ventry, which is not needed=0A=
in implementation with ID_AA64MMFR1_EL1.ECBHB=3D1.=0A=
Let's make the guest syscall process the same as the host.=0A=
=0A=
This fixes performance regressions introduced by commit a53b3599d9bf=0A=
("arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected()=0A=
lists") for guests running on neoverse v2 hardware, which supports=0A=
ECBHB.=0A=
=0A=
Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>=0A=
Link: https://lore.kernel.org/r/20240611122049.2758600-1-tangnianyao@huawei=
.com=0A=
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>=0A=
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>=0A=
---=0A=
 arch/arm64/kernel/cpufeature.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.=
c=0A=
index 840cc48b5147..5d2322eeee47 100644=0A=
--- a/arch/arm64/kernel/cpufeature.c=0A=
+++ b/arch/arm64/kernel/cpufeature.c=0A=
@@ -343,6 +343,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] =
=3D {=0A=
 };=0A=
 =0A=
 static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] =3D {=0A=
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_E=
CBHB_SHIFT, 4, 0),=0A=
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL=
1_TIDCP1_SHIFT, 4, 0),=0A=
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_=
AFP_SHIFT, 4, 0),=0A=
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_E=
TS_SHIFT, 4, 0),=0A=
-- =0A=
2.50.1=0A=
=0A=

