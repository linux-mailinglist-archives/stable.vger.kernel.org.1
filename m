Return-Path: <stable+bounces-92374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC7D9C54E1
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9CEB35C46
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E121442F;
	Tue, 12 Nov 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MezTWUsg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1E1210184;
	Tue, 12 Nov 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407451; cv=none; b=eYT4rbPRM/Ck+kqjP3EYmkEtPzKFfJ8B5YoQjT4CCQh/I3kdM/2zqlIeo6kHFt/ysa2mPDEeBBfd0VN6ODpPk1zZ9icjtrjldi0se6BG0ov6b74PCnt5Gn879gvIas3lcds5UkON2Nyzo7C58CmaI/J6cXToLB6bx3SaiPEXejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407451; c=relaxed/simple;
	bh=2/RGji/5KUnWNxZYTEG0CCU7vCYq8yfwJZUMuYyLBhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGbpxSMFwCc8neD1+IYlIr1jx6wgzdvFGoYOAQcnMd61MoSKYlN9dCt9fsaBDodscOAX5I4gY71ATT2HrCoFeYke5Ryi21rQHC437laLFUpnKZLZEuJuvlMDq2i12Gn3/ZUhSmeZQivwtIPiFGKRUZ5baPx4ISDwtPn5uw+M5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MezTWUsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025AEC4CECD;
	Tue, 12 Nov 2024 10:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407450;
	bh=2/RGji/5KUnWNxZYTEG0CCU7vCYq8yfwJZUMuYyLBhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MezTWUsgJtIlz1jg7dM7eqp58cZHaIWQE2bkoXTUDMn76ViRgCuyjxuRzEIaB092F
	 JHRa6R3zeVEK4JYunzU0FVPBXQ4WU5pFtdmmFcjfE/Hd58MnS3Fn0dZybWCItPJzi6
	 +pxp+U0zEBk2cabHuWEdOcfKKg4J76+d18liPTCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.1 48/98] media: v4l2-tpg: prevent the risk of a division by zero
Date: Tue, 12 Nov 2024 11:21:03 +0100
Message-ID: <20241112101846.100102566@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
References: <20241112101844.263449965@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit e6a3ea83fbe15d4818d01804e904cbb0e64e543b upstream.

As reported by Coverity, the logic at tpg_precalculate_line()
blindly rescales the buffer even when scaled_witdh is equal to
zero. If this ever happens, this will cause a division by zero.

Instead, add a WARN_ON_ONCE() to trigger such cases and return
without doing any precalculation.

Fixes: 63881df94d3e ("[media] vivid: add the Test Pattern Generator")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -1795,6 +1795,9 @@ static void tpg_precalculate_line(struct
 	unsigned p;
 	unsigned x;
 
+	if (WARN_ON_ONCE(!tpg->src_width || !tpg->scaled_width))
+		return;
+
 	switch (tpg->pattern) {
 	case TPG_PAT_GREEN:
 		contrast = TPG_COLOR_100_RED;



