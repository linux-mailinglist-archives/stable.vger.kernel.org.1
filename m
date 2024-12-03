Return-Path: <stable+bounces-96301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A99A9E1CB0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4111228499F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE891EBA12;
	Tue,  3 Dec 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noSR49HA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243EF1E8849;
	Tue,  3 Dec 2024 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230088; cv=none; b=ANPLD9L/MaL+FAVkOQIcpc6gT6PiwMKIu4PKCwzBOdpqvMRPw6loPv3gw2vTAkEP+v7GbmYqxMWAI/J+eMFPyvGJw0XGkDNpToVZkYDmUv5/sTb5Q7d9pJOSe9Y2uv1DipJn+Oegb1MWd0lzQ3zAtFnCgW/GAr/WYPMiWaACeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230088; c=relaxed/simple;
	bh=hUhkDJMd6hgc8nFH5J2k6Ct3EbWCpkiTzHeH8+7iWyE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aosJ6zlbGDEu1YKFRSAKny6lD37rniqiY8wLiZWiJJRB4s6zl66iv65lP2jk37q03kIKgsUS5JAo8UrZvLn4Td4F4oKHiYiLAnMBYS3tUHHRV3aK2lTS8Bj81tMQnAHX4CWnXUfgANcXCS2azNoZ3EsZKk2GgOjQsYP5en+/qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noSR49HA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A49C4CECF;
	Tue,  3 Dec 2024 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733230087;
	bh=hUhkDJMd6hgc8nFH5J2k6Ct3EbWCpkiTzHeH8+7iWyE=;
	h=From:Subject:Date:To:Cc:From;
	b=noSR49HAbUT52tj/WTvh8Ly59C4mWU3tFJUHQ3EEdsg9VqsgTkyYgwnS5xjM/fyN0
	 Nn9kwAKb07OBTVYKkoFjg6L+6/hc93AoiLspBnwWqtxVJd+pLsyNvywsEgKLFCsT6o
	 HtIvkICLgR31xaJ+8zEFaqj5VGWNfo+/ISAyJBK6rGIaQ6GGY19LwXrb+A/iuGGIq9
	 8MiWmE5VKuL/knlywr85ooXupYKX0uZsE3TYZT8ZOv8pweIPUYXpPyMU6ivXs2GHDH
	 GMbEsEkRvlsDxdz15roDmfyupJU0/zG/hxPon7KdlYx01QESTUXdFCII1zHaNuyJoh
	 w62HF6ao68wGA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/6] arm64/sme: Collected SME fixes
Date: Tue, 03 Dec 2024 12:45:52 +0000
Message-Id: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAID9TmcC/x2MQQqAMBDEviJ7dsFKKepXxEOtoy5olS2IIP7d4
 iWQQ/JQggoSdcVDikuSHDGLKQsKq48LWKbsVFe1NRnsdXeW0w5WIPpxA7cNnA3GGd+AcngqZrn
 /aT+87wd6yZpnZAAAAA==
X-Change-ID: 20241202-arm64-sme-reenable-98e64c161a8e
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hUhkDJMd6hgc8nFH5J2k6Ct3EbWCpkiTzHeH8+7iWyE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTv3/XvODq4EdoPt4webzJUAwhfutXI2IVlatkT69
 XtSrsFOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ079/wAKCRAk1otyXVSH0Du9B/
 4q0qp5ZLV0GHKhGbpjQCdHNnjtg2vEXE3Cp0R7Fbk6Sf/1EnZ6BU523FIlFvoxB5mK2hC7NnYCSitX
 yWifk1i+AYKN84DAmX2zT0vubitt0lOlQ6CDi4klMJRhEWXXyR3+Ol6ta+3NGUOPX4oIEaBHq2wjFG
 i2kDjQAVEbwAbp4er7pguBjVj6vusJC/BjNl96sm4dQSkkegKgdFqwgAORyy6eR83Nz9U/PjQOm911
 8LH2kce+iQqqULpLSSqZqX4d+5QDwmZp8nO/4Jv2+BCHsfYEJK2Ugti8tugl21OGER251GQYeDk6bb
 Oats3tuql3BgX+fyDkBMFGq0yyppZb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series collects the various SME related fixes that were previously
posted separately.  These should address all the issues I am aware of so
a patch which reenables the SME configuration option is also included.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (6):
      arm64/sme: Flush foreign register state in do_sme_acc()
      arm64/fp: Don't corrupt FPMR when streaming mode changes
      arm64/ptrace: Zero FPMR on streaming mode entry/exit
      arm64/signal: Consistently invalidate the in register FP state in restore
      arm64/signal: Avoid corruption of SME state when entering signal handler
      arm64/sme: Reenable SME

 arch/arm64/Kconfig              |  1 -
 arch/arm64/include/asm/fpsimd.h |  1 +
 arch/arm64/kernel/fpsimd.c      | 49 +++++++++++++++++++++--
 arch/arm64/kernel/ptrace.c      | 12 +++++-
 arch/arm64/kernel/signal.c      | 89 +++++++++++------------------------------
 5 files changed, 79 insertions(+), 73 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241202-arm64-sme-reenable-98e64c161a8e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


