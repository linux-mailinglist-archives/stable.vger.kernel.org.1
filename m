Return-Path: <stable+bounces-48711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D954F8FEA28
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52321C23D4A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB25196DBF;
	Thu,  6 Jun 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kAWMZXe1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A81019E7E7;
	Thu,  6 Jun 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683109; cv=none; b=YUkfc0u4cOMkqxvExnXv0qkPrYZp4UhqJBFIWZA95qLqsESU+MYh/wM6xDWY1YnEIqv6sutRshEqhmApL5VmCl0GQBJAErwACHd3ODxKr4lgPz0C+IvzSGFCTqkzG1YS5H/a2T3NXIHq3qo938EJXqgfu5tN28gAi4aNlJ86U7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683109; c=relaxed/simple;
	bh=rN4lmhVS+QD1CzfEWRisbc7RSYrlF9bVrKCNZdnd5i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3HMaINfGF2p53RxHbazb1TEcMeyqx1C//Hziy0O7Ed0JR/we3FzXahBiBPwcqoRModcKwv72D9dLgRsRSW5qZm/M8tGUO5GsNjEvt6T602h/8xiaAPxFI+mb/YQMLDG0v856nx+OZCZQyMZRyAEtURq12MqdZ5n6cD41LXHOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kAWMZXe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA5EC32781;
	Thu,  6 Jun 2024 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683109;
	bh=rN4lmhVS+QD1CzfEWRisbc7RSYrlF9bVrKCNZdnd5i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAWMZXe1TuY8VCKJiO4dq64SAtphl9aEMo62SlYtBOqDZsd1ZX0MM9OPAOAJbRZ57
	 HhMNZMNKX2N77e68kz80yF2ggex+rwpEqlhLdnpBRqwh3fvX9p0QuS1qEqQlgURZeE
	 SwvS9gRn85Q2vXRAZ5WxzTaNtQU2DWtnHkY6uykc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 6.6 006/744] speakup: Fix sizeof() vs ARRAY_SIZE() bug
Date: Thu,  6 Jun 2024 15:54:38 +0200
Message-ID: <20240606131732.658011291@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 008ab3c53bc4f0b2f20013c8f6c204a3203d0b8b upstream.

The "buf" pointer is an array of u16 values.  This code should be
using ARRAY_SIZE() (which is 256) instead of sizeof() (which is 512),
otherwise it can the still got out of bounds.

Fixes: c8d2f34ea96e ("speakup: Avoid crash on very long word")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Link: https://lore.kernel.org/r/d16f67d2-fd0a-4d45-adac-75ddd11001aa@moroto.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accessibility/speakup/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -574,7 +574,7 @@ static u_long get_word(struct vc_data *v
 	}
 	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
 	buf[cnt++] = attr_ch;
-	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
+	while (tmpx < vc->vc_cols - 1 && cnt < ARRAY_SIZE(buf) - 1) {
 		tmp_pos += 2;
 		tmpx++;
 		ch = get_char(vc, (u_short *)tmp_pos, &temp);



