Return-Path: <stable+bounces-167157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB5B2289B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 15:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9C1567062
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE627F003;
	Tue, 12 Aug 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="cmU3yd3e"
X-Original-To: stable@vger.kernel.org
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB8AD51
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005133; cv=none; b=KVz+q9nNrn8+EhTK0UPyKJ9YDgm3th6RpXyExiWn4PsY00HeOz5/JCxnI9rurwJ1XXaCM7EEGSVfpQujB4Eimwg6ljTNioAA1+zh0iOWH4EWM2x7s4Uj8KSd3BpOFG8tUsK93AT/M7auPl1JS04wD+CYsQkuQj2c2CZXMV7BkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005133; c=relaxed/simple;
	bh=OWb+eIgrSbBeQwDYF1sSJlRfu7SDrhZWQ1XWI8XOtIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E10Z82iV9JdisgUS6cz2bisOIYBr3X7agAlCRhlkpikPk2R52wJmYvBXcm6v5uYKrrzAg5jp/we+9oRGII33XbvQwV1Vkfv51dbRhio1MVzQd6A2kd5Mwz19duiO4vFIOuV5VCKYVsCX9a817LBJbzix5XG7Y1gENkjrBLiv0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=cmU3yd3e; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id 1B5BC9A294A
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1755005118; h=date:message-id:subject:from:to;
	bh=OWb+eIgrSbBeQwDYF1sSJlRfu7SDrhZWQ1XWI8XOtIA=;
	b=cmU3yd3ejQQ6Cpmc2uEXLl18L4CCY+5463/KGmERFGKsDUJSZ7wj7uVs1epq03c49bEQCDP5iF8
	lDwbSZfH1sAUhZGp6MXmK/PSoGADlF5nnG6MKit60tNos/6G3xpkWYGri3btKzlKQ3QdD2EKnx9M7
	7BDRj+vvWuPnAc5Mar7zQJG+1+UdnA8GunwA9TgbdwYbnnFSj1NF11aRyZT2f+Rpeo/Q4XPrQVor8
	WjnDhv5ybHIODxYEz/3Ivn+Q87Dv1AC/LCMmAS3FdDHYgyPySeYrTEYa4s+QS7aoEXvm7/98P6+DP
	NHEPWTL39Y/DqscgzMh8mbqwaqZcTXqKEyQg==
From: Achill Gilgenast <achill@achill.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Achill Gilgenast <achill@achill.org>
Subject: [PATCH stable-queue] scripts/quilt-mail: add my email address to the 0th mail CC list
Date: Tue, 12 Aug 2025 15:24:30 +0200
Message-ID: <20250812132440.423727-1-achill@achill.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=utf-8

Now that I have a proper email address, add me to the CC list so I don't
have to subscribe to <stable@vger.kernel.org> only to get this mail.

Signed-off-by: Achill Gilgenast <achill@achill.org>
---
 scripts/quilt-mail | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/quilt-mail b/scripts/quilt-mail
index e0df3d935f..531d9fafb9 100755
--- a/scripts/quilt-mail
+++ b/scripts/quilt-mail
@@ -181,7 +181,8 @@ CC_NAMES=("linux-kernel@vger\.kernel\.org"
 	  "rwarsow@gmx\.de"
 	  "conor@kernel\.org"
 	  "hargar@microsoft\.com"
-	  "broonie@kernel\.org")
+	  "broonie@kernel\.org"
+	  "achill@achill\.org")
 
 #CC_LIST="stable@vger\.kernel\.org"
 CC_LIST="patches@lists.linux.dev"
-- 
2.50.1

