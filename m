Return-Path: <stable+bounces-197456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB8C8F2B3
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2B03BDF12
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B928135D;
	Thu, 27 Nov 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EoBi01PT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7833115A6;
	Thu, 27 Nov 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255871; cv=none; b=T/5JsFuPeUalPQPNdPsPYMnGRnAxIrl+X99H4JTeOgiJ0kQa71Tk+A3EAmc7dkKqT9FyJ3rahLd12K7suZ1xzTbEAQ241wOIXuc/8SKnDpn51WaKopdDH+5JwDQjnJDPmDWzXDopErMeWP89U1gWweZYVM/i88kwDo7Qhzeouek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255871; c=relaxed/simple;
	bh=Zlhx6Zr58a3PkDtOZoVLjzwbX44Md/oJM1nqJaMd3Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1tCafx915zDyFdUI80geKVQgCi2Z4Q6GwYc2KKDU5cu7odppmvxEW9sl9jXrpRUFMAGkSHKXrcmbV+lX+14YA69jvGV1cj9l7SGwSp4K/5NY1c+vi1je9xJ81tf6CiloFu/xRh7hDdbxA2aFG33UK3rGs5hKYPjLc0IPLtFPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EoBi01PT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA0EC4CEF8;
	Thu, 27 Nov 2025 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255871;
	bh=Zlhx6Zr58a3PkDtOZoVLjzwbX44Md/oJM1nqJaMd3Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoBi01PTRYcGskg56JS0S3/sf2mZuHBdn7C225zobJ9qwWOjZppI/Elm8Ajt8vhaJ
	 H3fAcK/IRfLfVynE0zXJ5NuVKJ08H1Cnq73E1qTcTFe+6FnatamEthPPnGO5g6g+xf
	 KwNWItn4G/LmbHIY3gt0NTnR3gFULHhXktGsPY6Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 144/175] x86/microcode/AMD: Limit Entrysign signature checking to known generations
Date: Thu, 27 Nov 2025 15:46:37 +0100
Message-ID: <20251127144048.215615738@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144042.945669935@linuxfoundation.org>
References: <20251127144042.945669935@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

[ Upstream commit 8a9fb5129e8e64d24543ebc70de941a2d77a9e77 ]

Limit Entrysign sha256 signature checking to CPUs in the range Zen1-Zen5.

X86_BUG cannot be used here because the loading on the BSP happens way
too early, before the cpufeatures machinery has been set up.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/all/20251023124629.5385-1-bp@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/microcode/amd.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index c5363e6563798..ff40fe7ef58eb 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -236,13 +236,31 @@ static bool need_sha_check(u32 cur_rev)
 	return true;
 }
 
+static bool cpu_has_entrysign(void)
+{
+	unsigned int fam   = x86_family(bsp_cpuid_1_eax);
+	unsigned int model = x86_model(bsp_cpuid_1_eax);
+
+	if (fam == 0x17 || fam == 0x19)
+		return true;
+
+	if (fam == 0x1a) {
+		if (model <= 0x2f ||
+		    (0x40 <= model && model <= 0x4f) ||
+		    (0x60 <= model && model <= 0x6f))
+			return true;
+	}
+
+	return false;
+}
+
 static bool verify_sha256_digest(u32 patch_id, u32 cur_rev, const u8 *data, unsigned int len)
 {
 	struct patch_digest *pd = NULL;
 	u8 digest[SHA256_DIGEST_SIZE];
 	int i;
 
-	if (x86_family(bsp_cpuid_1_eax) < 0x17)
+	if (!cpu_has_entrysign())
 		return true;
 
 	if (!need_sha_check(cur_rev))
-- 
2.51.0




