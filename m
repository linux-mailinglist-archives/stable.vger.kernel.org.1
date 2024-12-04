Return-Path: <stable+bounces-98304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E99E3E17
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7270C16625F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F220B7E4;
	Wed,  4 Dec 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so4yfvkv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C7216BE20;
	Wed,  4 Dec 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325744; cv=none; b=jF2LekQWKewt8ekNPLcdIwbYcwlp37Lgz/MKKecgJiKCvUtO0XH4ahyxLCdCMGy/F30VZaVP6LicwIkVYU6zfKz1JOILb8LYoF2oXnANYOLvBaKH2TVf+j1to7S0s5/Zh5aFiPXotc/XxJbEA8WO49sVafWVfWyjGTmz0yj7RfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325744; c=relaxed/simple;
	bh=YxbdLK0hPdinmJ7aseN6ZxvZEvKSnXJP4oKfttGQxMg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GQj9kFpqU2Y5k3Ab57J5ndQxKfHbegDhWOmrOlvZylEM9bKHejXQ/phvrbOQsR+UUNiDbN8Cr5LcUrO4cxH5IPI+IisKJxo4jn0W4sjYsX28+UK0EWFMYFODv1od32H1RebDPHwC4XyT7Rsk+pIX6+cfAYdnXnwZCe4DBCuR0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so4yfvkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79C0C4CECD;
	Wed,  4 Dec 2024 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733325744;
	bh=YxbdLK0hPdinmJ7aseN6ZxvZEvKSnXJP4oKfttGQxMg=;
	h=From:Subject:Date:To:Cc:From;
	b=so4yfvkvN9CDgMc6hEnOllf8Nm3zaqsK5NEJLHvCdhz31RV7sTx/cq/2nSN8Dku7t
	 23F6IN8Gad0ycca3IE/TPM3lwhxI7iNC2BH1NAJVtJHwhtFwaQwFha6HJxkiA7y6jY
	 AaDRjIFCQ9T0G/pwyJ4cI9YpG28v7YJt0+vsQIsL+fF536WuodGM9uyl8tS8QKPG7Q
	 sslqF9neGm6Ws1LyD1yspxyYr43IkTWrfSzyxp1MfAkvQKUwIcGsXJeWXP3ZOWkHyp
	 K2eneCiB2Wko+9nX4bWJlBHZy3ARSAXj9wwRxypcpDL7q9wADVPGEKCYqmhA6UcaCc
	 Alv9sv6d3sEGA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/6] arm64/sme: Collected SME fixes
Date: Wed, 04 Dec 2024 15:20:48 +0000
Message-Id: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBzUGcC/22Nyw6CMBREf4XctddQqDxc+R+GRYERGqGYW0M0p
 P9uJXHnZpIzyZzZyEMsPJ2TjQSr9XZxEbJDQt1o3AC2fWTK0kyrGGxkLjT7GSyAM+0ErisUulO
 FMhUoDh+Cm33t0msTebT+uch7/1jVt/3p8n+6VXHKfXXKdVn3qi3Lyx3iMB0XGagJIXwArzVMW
 rUAAAA=
X-Change-ID: 20241202-arm64-sme-reenable-98e64c161a8e
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YxbdLK0hPdinmJ7aseN6ZxvZEvKSnXJP4oKfttGQxMg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnUHOoeQbPc1HbfhMEJ6VMwbqGljtgzH/xL/utSJwc
 BuyUoruJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1BzqAAKCRAk1otyXVSH0BawB/
 90OIzPt6j6CGU6RuSdHVSMeewxBU+uf1YFk4npaIu9/p54fletxj5NfLw3xCyb3bdsFlmpFpk3S/AW
 Wx/8C6TMHj/2Iuohrqgm5pUK+h8LS1WET6CSqFh45R9N1+V3MvfuLr7Z7L1mMMBd+VbV733ZiEJAFO
 sg/pNDrso2ZbqEDbog4svL/AwhmtkaL+uIUSdikXRrNzc0TPGvQ6w4pgzXlau6eTRbuCUrPP/8rfRy
 AcS1URPzbJ7KoSmU00K9d0c6OY2NCH7une+m/R6lM5SZcLdY23cnuE/TWDFDNO6K5DHaxpZJ2IUBnz
 wWdJhYdYKubtbJO5c4aQUCD979PDH2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series collects the various SME related fixes that were previously
posted separately.  These should address all the issues I am aware of so
a patch which reenables the SME configuration option is also included.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Pull simplification of the signal restore code after the SME
  reenablement, it's not a fix but there's some code overlap.
- Comment updates.
- Link to v1: https://lore.kernel.org/r/20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org

---
Mark Brown (6):
      arm64/sme: Flush foreign register state in do_sme_acc()
      arm64/fp: Don't corrupt FPMR when streaming mode changes
      arm64/ptrace: Zero FPMR on streaming mode entry/exit
      arm64/signal: Avoid corruption of SME state when entering signal handler
      arm64/sme: Reenable SME
      arm64/signal: Consistently invalidate the in register FP state in restore

 arch/arm64/Kconfig              |  1 -
 arch/arm64/include/asm/fpsimd.h |  1 +
 arch/arm64/kernel/fpsimd.c      | 57 ++++++++++++++++++++++----
 arch/arm64/kernel/ptrace.c      | 12 +++++-
 arch/arm64/kernel/signal.c      | 89 +++++++++++------------------------------
 5 files changed, 84 insertions(+), 76 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241202-arm64-sme-reenable-98e64c161a8e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


