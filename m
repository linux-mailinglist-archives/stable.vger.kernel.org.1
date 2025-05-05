Return-Path: <stable+bounces-139767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E0AA9F1A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731A31A81E12
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC9227703D;
	Mon,  5 May 2025 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0D+6xHv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2027E1B9;
	Mon,  5 May 2025 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483296; cv=none; b=oFGE9/c5Kexr64n5Z6pJP+ZaBybwQ08jpA8w4CWoAcmOxthyApohjYkQKahibVEb4tbgar6lDjp0Gc49ibLICzpanEU6UViGhghi+yH9WGKdzh+pwlcpYvEIRMFgWrauQWd0tt9NuPOASG7nZPZN3wXnDWwe86DnJkROupNmJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483296; c=relaxed/simple;
	bh=RmknoLkIOzZEd4IDcW5L2WIxSDhD1l3uF/XpnvBeFwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bg6k5osf04imtBDNGo3RgCNjxgoEJe6iDwmEZqWWc60riSAcXQgtfC0WkdJcmuPk145ifyfvXIWaAWbnE3AzmoS7GmgRQJBnIAAszqsKJByqXuGO9hZ0vBfqLW+ZCA0iUPSKTqKzi7aSygwl7VQtgWASPJ/2iUEPXXKNPAmdmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0D+6xHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E379DC4CEED;
	Mon,  5 May 2025 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483295;
	bh=RmknoLkIOzZEd4IDcW5L2WIxSDhD1l3uF/XpnvBeFwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0D+6xHvdgVLhGqWI9q6dZMoK85qum2oMx50u7GN0GjdKBrhtVIDf/iEnp6isbn4D
	 k7UYp3o5cDCFnLXM6iY0Xe/NGk6MxUC5NXm0eReAaJPyLzDNmMonb0CnML3cI21lv+
	 Mfzdz4uus3dmUEHeLUv+MljoYOtv5Evz0bfh6coNMQjnEXn+dZqcbEym+dJfIkd5p8
	 h7PjGi5KoXAhUURrT3hx2X7bgmtCCFPrlii2mBiwvHea1zNMOlKu9a0I3Nrb/yN1Fw
	 d7Qg3xhcEI2lSegkP+N/FVK5dcI1qq9vRQ9adfy3iuo+pYqkabOaZmnJm8iDFronzX
	 yNCYHmqPJfxcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan McDowell <noodles@meta.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 020/642] tpm: Convert warn to dbg in tpm2_start_auth_session()
Date: Mon,  5 May 2025 18:03:56 -0400
Message-Id: <20250505221419.2672473-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jonathan McDowell <noodles@meta.com>

[ Upstream commit 6359691b4fbcaf3ed86f53043a1f7c6cc54c09be ]

TPM2 sessions have been flushed lazily since commit df745e25098dc ("tpm:
Lazily flush the auth session").  If /dev/tpm{rm}0 is not accessed
in-between two in-kernel calls, it is possible that a TPM2 session is
re-started before the previous one has been completed.

This causes a spurios warning in a legit run-time condition, which is also
correctly addressed with a fast return path:

[    2.944047] tpm tpm0: auth session is active

Address the issue by changing dev_warn_once() call to a dev_dbg_once()
call.

[jarkko: Rewrote the commit message, and instead of dropping converted
 to a debug message.]
Signed-off-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index b70165b588ecc..3f89635ba5e85 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -982,7 +982,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	int rc;
 
 	if (chip->auth) {
-		dev_warn_once(&chip->dev, "auth session is active\n");
+		dev_dbg_once(&chip->dev, "auth session is active\n");
 		return 0;
 	}
 
-- 
2.39.5


