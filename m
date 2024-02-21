Return-Path: <stable+bounces-22896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8385DED0
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CAB2B22E6F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89047E595;
	Wed, 21 Feb 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y054UkXJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F078B60;
	Wed, 21 Feb 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524879; cv=none; b=TtvyXcidGwb+f+3JV3HFXZWQrNTd4hVFcrUYVVtlhsgtUBv37wPfDpk0521m16C8PNUC0HjCbrSgKCrZx0tNHb6z4sQlwcGKNwSS0GEJzsicCSIkyD9XDjedU+Q+fdtw8U15mhDeR0cpW7ev6wu3D+ON4UyqRYqzq8x1WGcHgaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524879; c=relaxed/simple;
	bh=4a+A3P5xrOY74U+H8UZZ9ifb7WyTUKYpj4brZTQKYeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaL7GJtxbJ1RsTtyG7OoCBxWd/m2OjNTdew+UIVtUfQlKA/evgqH9h3KBA+I9hIOxnpNjn+mfzaFvhlT7oC0gphZP0jgsuEc15TDcQzxChzFYxJ0F058jfh5kXJmDYdPDsLd5Z4uIdDCNoaDiKPwJ/fvGzfqWQ0qXlhKcMzEUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y054UkXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBA3C433C7;
	Wed, 21 Feb 2024 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524879;
	bh=4a+A3P5xrOY74U+H8UZZ9ifb7WyTUKYpj4brZTQKYeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y054UkXJoRg8rmmw0Zp8pcrLMkL9lYD3tkG9Ijfs3WLJ89McveVMfayda8ytGh/j8
	 tNAVLNGwbSwAGb8/3MwY83bNLFCKDej92sCy8bkE1Xt6COUSg8uYscPMS3teyAL70G
	 EkKI++sdyO2YZSb66533gMoMmBlKbM5TH4kF9pBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.10 347/379] pmdomain: core: Move the unused cleanup to a _sync initcall
Date: Wed, 21 Feb 2024 14:08:46 +0100
Message-ID: <20240221130005.263003070@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

commit 741ba0134fa7822fcf4e4a0a537a5c4cfd706b20 upstream.

The unused clock cleanup uses the _sync initcall to give all users at
earlier initcalls time to probe. Do the same to avoid leaving some PDs
dangling at "on" (which actually happened on qcom!).

Fixes: 2fe71dcdfd10 ("PM / domains: Add late_initcall to disable unused PM domains")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231227-topic-pmdomain_sync_cleanup-v1-1-5f36769d538b@linaro.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/domain.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -958,7 +958,7 @@ static int __init genpd_power_off_unused
 
 	return 0;
 }
-late_initcall(genpd_power_off_unused);
+late_initcall_sync(genpd_power_off_unused);
 
 #ifdef CONFIG_PM_SLEEP
 



