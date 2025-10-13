Return-Path: <stable+bounces-184900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58441BD44CE
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3826E1884957
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFCE308F39;
	Mon, 13 Oct 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JrwmS5gl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDD322A;
	Mon, 13 Oct 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368759; cv=none; b=OI8N0Z/PnY+3b3x8EoJ+q60baQXqIPjKSjyNbZckB6RUe0lQygxxNYsgLBJTOJ84wQppJJploOM2uPGY692/AycDveozjMx+HeFEgaeGAlu5IyLFL5HekSaQzsC5EpBwJOvjjV1U4Dtg/iYaKgF+f14fpvv8afIBEQlQ1v/8w2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368759; c=relaxed/simple;
	bh=W8vlfNt3o0qKQWL6hrZeJikf/6Y1JmTeCNRrJtoICh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp4CSA9uUUe0oYXQzz+lpL0Kf2pZwwg6nHmSUFoQRq+FG7IBCZu3A2B1jwd0kbxw2J4eo1z1u2FoLdYwrmOA05NM6fQRR6pTYoxy6x+I4/M5PyyPkOfdo3G4j6yJSr24xRZULb8811hAEJ48FuTNgHikjCYh1om0j4A4Ee3x9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JrwmS5gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AADC4CEFE;
	Mon, 13 Oct 2025 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368759;
	bh=W8vlfNt3o0qKQWL6hrZeJikf/6Y1JmTeCNRrJtoICh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrwmS5glPCzy+3avoWEn53a3DMOxCVBnOICuVatgn6yCR7dwvuWG1xM8VGliBLYR3
	 vkHmltFdTHNa347ppJ92wFEtGf8thgWIJOwoJr1+9PivgzXUwlf6q3wH9rvf3kvaKL
	 3xsYax3IjM5DTPUVrHWciel8Zr8GMlZCa/eA0dd4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 010/563] kselftest/arm64/gcs: Correctly check return value when disabling GCS
Date: Mon, 13 Oct 2025 16:37:51 +0200
Message-ID: <20251013144411.664848776@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 740cdafd0d998903c1faeee921028a8a78698be5 ]

The return value was not assigned to 'ret', so the check afterwards
does not do anything.

Fixes: 3d37d4307e0f ("kselftest/arm64: Add very basic GCS test program")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
index 54f9c888249d7..100d2a983155f 100644
--- a/tools/testing/selftests/arm64/gcs/basic-gcs.c
+++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
@@ -410,7 +410,7 @@ int main(void)
 	}
 
 	/* One last test: disable GCS, we can do this one time */
-	my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
+	ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
 	if (ret != 0)
 		ksft_print_msg("Failed to disable GCS: %d\n", ret);
 
-- 
2.51.0




