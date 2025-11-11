Return-Path: <stable+bounces-194266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B21CEC4B11B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789E63BB067
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C4306B11;
	Tue, 11 Nov 2025 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1KZKGHPq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9026561D;
	Tue, 11 Nov 2025 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825195; cv=none; b=fxS5KrYQwluDT+GhZGHnBzfjDpDUnKmrAsotHXQl+PXj/EEA5rP+mS9q0FPDP4UDRU26pTSiBTZ/U4yK6HwgOgRZlPaIgED/pRr7DnYWZXvrORmjPEn2Clid1pYGxgd9THaobtwgnJsLfhA0H17RDx/WQyaPc84xB1X4fBfflqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825195; c=relaxed/simple;
	bh=si0nozLCxywrqVLcYY3y0SH8dk+8XF4jgwYUfuazFGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdOv6Lb521JxhkrWltxfauBXE87DVoqw6+73a9ko/smEHFWAQiqGnLs/8d6y5v4GPavogbIaNneDZkIhGfHWkGDkhP8ifBGVKIyTKQAqytrLTs5bN1/WLHxxJufJqm5z4n6syl8wS+gWImj1lKbRmxwRDvIKpokRsj4wDvByvj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1KZKGHPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E766EC4CEFB;
	Tue, 11 Nov 2025 01:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762825195;
	bh=si0nozLCxywrqVLcYY3y0SH8dk+8XF4jgwYUfuazFGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1KZKGHPqZACyHhJsEtnifEZxTCBJEYKMrTt41esePOJWGN7Io5lGEg1TZGY58RbP/
	 ltmRoQwp7tFXFnvzgOHgmAz1U+OnzVnBNhcDuL8+omdFugXUIdieXQ3qtZHdeQAaaV
	 T+O88jcNcnfQStiBVEeLLn38YMJoLNNW3J3lrACY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 700/849] um: Fix help message for ssl-non-raw
Date: Tue, 11 Nov 2025 09:44:30 +0900
Message-ID: <20251111004553.357208125@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit 725e9d81868fcedaeef775948e699955b01631ae ]

Add the missing option name in the help message. Additionally,
switch to __uml_help(), because this is a global option rather
than a per-channel option.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/ssl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index 277cea3d30eb5..8006a5bd578c2 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -199,4 +199,7 @@ static int ssl_non_raw_setup(char *str)
 	return 1;
 }
 __setup("ssl-non-raw", ssl_non_raw_setup);
-__channel_help(ssl_non_raw_setup, "set serial lines to non-raw mode");
+__uml_help(ssl_non_raw_setup,
+"ssl-non-raw\n"
+"    Set serial lines to non-raw mode.\n\n"
+);
-- 
2.51.0




