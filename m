Return-Path: <stable+bounces-168958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23A9B23776
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4FA6E618D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9310B2E11BF;
	Tue, 12 Aug 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pEVtr/UO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5521C187;
	Tue, 12 Aug 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025902; cv=none; b=V7OXvywhbZCafC0pPJjKFeRHHd/Du8HhXRcwtogW0I+13ahhHd/EPYvS9wHpYUIvbiTTmBr3W76jcizdRzV/x3UMCyvJ5H0LL7Am8FD58NXj6lUMD9iXOKxMHSpndiuazYLa5+JuULt77qyDaZT7btInRjdNSfyVo0dYkwtWtIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025902; c=relaxed/simple;
	bh=r08GINLgh7Ohde41bHO+VKeyyO/4Zd/5O/lowmgru40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpLnUPFkT3OEpWSGdJnMhkkxtL9vA5Lso8/JxFnyn3ogwtyYpPXuV9YvMYnbjyfT6oWmNBsA2AB7c9faP6f11UMIGyj9q4vTyLYT6onYOIq73JjzvgPAP5MZ8PYCVwlQZx6RMXLcgteIAoZtXFnX7dH2YI5+VeZEXNegwt31JBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pEVtr/UO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF189C4CEF6;
	Tue, 12 Aug 2025 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025902;
	bh=r08GINLgh7Ohde41bHO+VKeyyO/4Zd/5O/lowmgru40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEVtr/UOrAHEIo+tRyTm7ZmDaeQIslI2NqGzYYuQiTCOdjOISafScELCNmioD1iNz
	 353m3mBnv3JmxVrox8+FHI/W3ygCYnstLVHXn8Px1Lov4neuiJcPbMwLJNhD+WPymC
	 BS5mEwCL86Y0330Kxi5SK1Tzyuw+ohZI0w0MOVdU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 151/480] um: rtc: Avoid shadowing err in uml_rtc_start()
Date: Tue, 12 Aug 2025 19:45:59 +0200
Message-ID: <20250812174403.736535193@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit 4c916e3b224a02019b3cc3983a15f32bfd9a22df ]

Remove the declaration of 'err' inside the 'if (timetravel)' block,
as it would otherwise be unavailable outside that block, potentially
leading to uml_rtc_start() returning an uninitialized value.

Fixes: dde8b58d5127 ("um: add a pseudo RTC")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250708090403.1067440-5-tiwei.bie@linux.dev
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/rtc_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/rtc_user.c b/arch/um/drivers/rtc_user.c
index 51e79f3148cd..67912fcf7b28 100644
--- a/arch/um/drivers/rtc_user.c
+++ b/arch/um/drivers/rtc_user.c
@@ -28,7 +28,7 @@ int uml_rtc_start(bool timetravel)
 	int err;
 
 	if (timetravel) {
-		int err = os_pipe(uml_rtc_irq_fds, 1, 1);
+		err = os_pipe(uml_rtc_irq_fds, 1, 1);
 		if (err)
 			goto fail;
 	} else {
-- 
2.39.5




