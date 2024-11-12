Return-Path: <stable+bounces-92577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238C49C553B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD06E28531E
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4931B22D3B8;
	Tue, 12 Nov 2024 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5AN6yxm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC422D3B3;
	Tue, 12 Nov 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407909; cv=none; b=itIawKykmzrBFPNTg3PJ5y6UYHZlNbJiUNLx0nbEftVnZo89cZwGde8eE42E19hrWUujFn5H72wbtlGhXQbUaeu/KF63VhKPwtb5o1btlvrYEs019+pxWzDxX5zokM81ACDSVpHPhpIgrjz7GLPhVlliDHXXEN/vzXmlqIKOnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407909; c=relaxed/simple;
	bh=yebHsAXqfbl656prO2aC4p0UcKCC70BQfQK62CArc3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN5DFOfJUGcKp8CXiD6mj9neAPxaeEc/asKL4G4YAtRroPBvhZhxhplIK40g85GiTUWuxVyFaGRXwtiPFYoYAJPFWgy5vZEdi1DMPBt8agnd322EvfT5YxjsISpFPboePiaYIEpxNB/ji+7irZ3qc1UrLT0LONPkw3wMwPCVVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J5AN6yxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C609C4CECD;
	Tue, 12 Nov 2024 10:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407908;
	bh=yebHsAXqfbl656prO2aC4p0UcKCC70BQfQK62CArc3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5AN6yxmKcMoQMOtPwXgN5tvG9cqNZVBGeLLOnhrndXQyDtskfl//6Uejy2F5BiP5
	 83Llh0K+cReFH3VSIOghxIubdovlVRxMLyuMlNimw1pv/UbgvHSm9MXDfq5qT8yaiT
	 M3u5V4GYGb5t43QnpVdmz3D3IaFRCjvYJG+uTli4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.6 095/119] arm64: Kconfig: Make SME depend on BROKEN for now
Date: Tue, 12 Nov 2024 11:21:43 +0100
Message-ID: <20241112101852.349476283@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 81235ae0c846e1fb46a2c6fe9283fe2b2b24f7dc upstream.

Although support for SME was merged in v5.19, we've since uncovered a
number of issues with the implementation, including issues which might
corrupt the FPSIMD/SVE/SME state of arbitrary tasks. While there are
patches to address some of these issues, ongoing review has highlighted
additional functional problems, and more time is necessary to analyse
and fix these.

For now, mark SME as BROKEN in the hope that we can fix things properly
in the near future. As SME is an OPTIONAL part of ARMv9.2+, and there is
very little extant hardware, this should not adversely affect the vast
majority of users.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org # 5.19
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20241106164220.2789279-1-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2167,6 +2167,7 @@ config ARM64_SME
 	bool "ARM Scalable Matrix Extension support"
 	default y
 	depends on ARM64_SVE
+	depends on BROKEN
 	help
 	  The Scalable Matrix Extension (SME) is an extension to the AArch64
 	  execution state which utilises a substantial subset of the SVE



