Return-Path: <stable+bounces-164730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3077B11D0E
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 13:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B058C7A1422
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03B923D2B5;
	Fri, 25 Jul 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="DitFApnb"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E11BD4F7
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441398; cv=none; b=h9U7Co+z07RhLHsQYv6fABBT27/YnMtgpkOYt8nD4eSsxfvKVM/dZkX7SwchOiVLPO+/tyypl6DWnW2uoyqPkCy00mlvLWQzMphSCA9cGPA9+8uOxktXHuFTHmYvm/tDP1H5OeY+wptdfW+Fa6NJWqgfE7SxSV9/b9Y43FRPGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441398; c=relaxed/simple;
	bh=BDdE8vSbzR0oK3tm6OHLf/79TJIjeruYg6g8xcBnIO4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B3ECyqn+d3llE+T/ZEux1chvDjej6dQWrfGFqvmfalaISXRSys1k/aEDIGJwd1xEvTUGcSU/E5I3ZGgwyk/f3TW1Db26Kza3D20bJ65ofVsdl9KTKuv35/qyIa8ZVCKklFT5EfEZQm3QTYIpn7vD6d7nDxNh7X9yMuhorF75sSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=DitFApnb; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1753441396; x=1784977396;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=N8zaNTUsekB54AjaIYdR7MO8Ua47vRgfTSv7gDjgyt8=;
  b=DitFApnbPevB23lKnt9sDD7bypOsua16SzYpLOrUkT5ikMoZcjK5W5QN
   OQzAAmuQaPCpWTMIdKFfTfQVXwLx8HpcHwEH/XAnoNN1pWuWysLVNPYve
   /AOXpnDmUw0vafYFsTBpkw8vDGJ7TAlYdRsifJiQqrkLU5c5yYUGxg2N9
   D05pW0exY666IBC6jXlWQSA3BiUKNK/zIdaAr+a6bl6Npe6KiiepkquFW
   Nd96eGxVrPZr49VZHNmhN5ozUwimvZKRkkLyFKJePZm+y/erB61dhVeec
   KM/8O4OoFGbNc9MQY0Z/PNgPIi1OdlhGt6vAYxgjfKiFRxb/fhNMvrRTh
   A==;
X-IronPort-AV: E=Sophos;i="6.16,339,1744070400"; 
   d="scan'208";a="39608532"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 11:03:11 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:24664]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.230:2525] with esmtp (Farcaster)
 id 7a81bfce-0650-4503-a016-d4d93d525731; Fri, 25 Jul 2025 11:03:10 +0000 (UTC)
X-Farcaster-Flow-ID: 7a81bfce-0650-4503-a016-d4d93d525731
Received: from EX19D015EUB002.ant.amazon.com (10.252.51.123) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Jul 2025 11:03:09 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB002.ant.amazon.com (10.252.51.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Jul 2025 11:03:09 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.1544.014; Fri, 25 Jul 2025 11:03:09 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nianyao Tang <tangnianyao@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, "Roy, Patrick" <roypat@amazon.co.uk>
Subject: [PATCH 6.6.y] arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits in
 ID_AA64MMFR1 register
Thread-Topic: [PATCH 6.6.y] arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits
 in ID_AA64MMFR1 register
Thread-Index: AQHb/VO0AzKSYf/tZUq7X/B4eU+c2Q==
Date: Fri, 25 Jul 2025 11:03:09 +0000
Message-ID: <20250725110227.13309-1-roypat@amazon.co.uk>
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
This fixes performance regressions introduced by commit 4117975672c4=0A=
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
index b6d381f743f3..2ce9ef9d924a 100644=0A=
--- a/arch/arm64/kernel/cpufeature.c=0A=
+++ b/arch/arm64/kernel/cpufeature.c=0A=
@@ -364,6 +364,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] =
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
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_H=
CX_SHIFT, 4, 0),=0A=
-- =0A=
2.50.1=0A=
=0A=

