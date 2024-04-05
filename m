Return-Path: <stable+bounces-36094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A5899B2D
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EF21F21D5C
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00743163AA7;
	Fri,  5 Apr 2024 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJCgy5C9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE81474DC
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314081; cv=none; b=KclYLA/D4wa2qEJL54IrQhbYd783ugzD7rz22AseEyvbXlvriYoraXhl6ZSldfpR6rJIgpYLnQ8fypJitIJ2Ju/NfCH9xd1YcLGKesdwXBYTZAjaRv0UstxWSa06CKphw+5R892zvaXwRjt/FiQSrnMR3PPlFtOn1pJny1w5J78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314081; c=relaxed/simple;
	bh=eijLs9uij5DambMd6+Slbq7YsoWrdQaYGpcUuGJ5M8c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X7uZZu1R2arNul2+zPf14DQUjzemG8FEUTXZTpLH/jFQyref424vPlF4/tfMZFw9H13F9gtayt/ipBeY6uU1kvKRjGg4iea7zSZKO4QDX8iDLFP6m6RNy6QzwD5+KTdtcMVqzyzzJKy0kWJf/HL+C396NPaktMLzMyCH1Sw4RGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hJCgy5C9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E83C433C7;
	Fri,  5 Apr 2024 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712314081;
	bh=eijLs9uij5DambMd6+Slbq7YsoWrdQaYGpcUuGJ5M8c=;
	h=Subject:To:Cc:From:Date:From;
	b=hJCgy5C9as5HJ65qJV55aFyVARCpSsoC5WG1199Sfv7aynssgyunK/q9PF4hyJhjx
	 bG3h2OxOJ1q+uufMcVJSf8OTFdRlTYqjPlqWwGxmKvdBGkY/0WiK/PZJZJK2rgroif
	 iElVpbJpT+BJrLZqajjVDILfMw9HJbWcP0qhLNdM=
Subject: FAILED: patch "[PATCH] octeontx2-af: Add array index check" failed to apply to 5.15-stable tree
To: amishin@t-argos.ru,davem@davemloft.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 12:47:58 +0200
Message-ID: <2024040558-trustee-garage-e392@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ef15ddeeb6bee87c044bf7754fac524545bf71e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040558-trustee-garage-e392@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef15ddeeb6bee87c044bf7754fac524545bf71e8 Mon Sep 17 00:00:00 2001
From: Aleksandr Mishin <amishin@t-argos.ru>
Date: Thu, 28 Mar 2024 19:55:05 +0300
Subject: [PATCH] octeontx2-af: Add array index check

In rvu_map_cgx_lmac_pf() the 'iter', which is used as an array index, can reach
value (up to 14) that exceed the size (MAX_LMAC_COUNT = 8) of the array.
Fix this bug by adding 'iter' value check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 72e060cf6b61..e9bf9231b018 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -160,6 +160,8 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
 			continue;
 		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
 		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
+			if (iter >= MAX_LMAC_COUNT)
+				continue;
 			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
 					      iter);
 			rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);


