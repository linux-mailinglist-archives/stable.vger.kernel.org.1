Return-Path: <stable+bounces-49535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47878FEDAC
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6284BB29367
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821751BD009;
	Thu,  6 Jun 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LYFrGwzr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E6D19E7CA;
	Thu,  6 Jun 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683514; cv=none; b=mG7Xo9HyIGmqiFpGAXt/h+A9lc8Z2aZdaGCGNSIZ80shnmm+kP5C22mpJ9IrnIUC2nnbjV0VoL7dtGodwykTgev1hLHlUsh7nGm/yffk1LqpRCbw8myYUEcI4LzEuiKATici8szm/osepdTTHKpwwa46u5KqjVLQzF6WIE0EgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683514; c=relaxed/simple;
	bh=1X410vDOZGnuuwhzj8fcpOZwLWHhRaluLbuzQoPpS1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEAs5yGLfikWExqqOc/pS4ogNUufyMaxUpXR30Et9JyJsxyHhbxPmQusHiLBcx8x15BTO2+5L+RbKErP3FN+XgUvPiY9wQFm0Isl5Hx2XWh/jwekwN8oVoSebhd3c8kldB5EShT+QUd13bm730CzUKNZvalS+uIT3cjxDXQJUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LYFrGwzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF520C32786;
	Thu,  6 Jun 2024 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683513;
	bh=1X410vDOZGnuuwhzj8fcpOZwLWHhRaluLbuzQoPpS1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYFrGwzr2rRRasbXIhGdODBBho7uzQUZw5EOmmF0OoefIMjnKfvDZJtKYXgSyqE2f
	 Han4dQXFxEGMOjPlHUUBix8cnYeBKJqSgvteJdE+GsIrjXYNux7rE/BfiE37To/HGv
	 /lfKbvtCJbw8mg7QF32FxqDEXNjhJ3hAELVBMeGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 375/473] um: vector: fix bpfflash parameter evaluation
Date: Thu,  6 Jun 2024 16:05:04 +0200
Message-ID: <20240606131712.281793915@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 584ed2f76ff5fe360d87a04d17b6520c7999e06b ]

With W=1 the build complains about a pointer compared to
zero, clearly the result should've been compared.

Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Tiwei Bie <tiwei.btw@antgroup.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/vector_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb295767..94a4dfac6c236 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -141,7 +141,7 @@ static bool get_bpf_flash(struct arglist *def)
 
 	if (allow != NULL) {
 		if (kstrtoul(allow, 10, &result) == 0)
-			return (allow > 0);
+			return result > 0;
 	}
 	return false;
 }
-- 
2.43.0




