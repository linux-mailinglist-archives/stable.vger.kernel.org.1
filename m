Return-Path: <stable+bounces-93189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8668B9CD7D1
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3194D1F231AA
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F37188015;
	Fri, 15 Nov 2024 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hDzgC15Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F217E015;
	Fri, 15 Nov 2024 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653086; cv=none; b=Cy1CIuf8RyBER2MYEYxsEUCTD8NPwvQwObS6gRgIaGJUnXtTg6NpTV5swsM97RCKVaFTZyX5cWkAWdwZwbXpkA0o+6gpDfDa2KpvW/f+kVQGB4Z9TVoB3mC6MoUByYZe1AbRYLailgG/xHBlEb36qdw85vBgS4ZjTmOwI8yi4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653086; c=relaxed/simple;
	bh=tcaeUOVMUUReSH9zXJI9wrxcQnUZnx1xU7B3+c6R1Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ynj7EoNoE7S7NtXQaKx96pCmWEq1emQ2hD1pB1rpIu75pr9mLbFmPv+XaCUK3SKY5WOo4BikCFdgh5Z4kKfZAtMJO4O7BYe+iY3tXIcMYTbvG6v8b2mUYa8VgxkyT/WxhkPY1ec35us9d8YeTT/PJylvXnymBbtwGeoNc+mb3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hDzgC15Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3321DC4CECF;
	Fri, 15 Nov 2024 06:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653086;
	bh=tcaeUOVMUUReSH9zXJI9wrxcQnUZnx1xU7B3+c6R1Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDzgC15YIxf2Oj5p5fC5neCuTQBw9p4rqQ2v/Oa6ILxh2Fsm2AEz50KSVtHJrvLL8
	 t0fzZ7u2BkMLZZj51q0Uz66wMy0FRNX0/dHQjHuOFZ+OoNa775lcZMHPhcQNhizrTH
	 XfEX/eVloTlflChYRhf4Nx1Kyzv8OOVPT2b70DVM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4 16/66] media: stb0899_algo: initialize cfr before using it
Date: Fri, 15 Nov 2024 07:37:25 +0100
Message-ID: <20241115063723.430006039@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.834793938@linuxfoundation.org>
References: <20241115063722.834793938@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit 2d861977e7314f00bf27d0db17c11ff5e85e609a upstream.

The loop at stb0899_search_carrier() starts with a random
value for cfr, as reported by Coverity.

Initialize it to zero, just like stb0899_dvbs_algo() to ensure
that carrier search won't bail out.

Fixes: 8bd135bab91f ("V4L/DVB (9375): Add STB0899 support")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/stb0899_algo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/stb0899_algo.c
+++ b/drivers/media/dvb-frontends/stb0899_algo.c
@@ -269,7 +269,7 @@ static enum stb0899_status stb0899_searc
 
 	short int derot_freq = 0, last_derot_freq = 0, derot_limit, next_loop = 3;
 	int index = 0;
-	u8 cfr[2];
+	u8 cfr[2] = {0};
 	u8 reg;
 
 	internal->status = NOCARRIER;



