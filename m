Return-Path: <stable+bounces-188274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00646BF4278
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 02:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A232F3512A9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 00:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E761898F8;
	Tue, 21 Oct 2025 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOpphDtH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D316CD33
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761006866; cv=none; b=YXZUuUTD7RcJmuCMZ8TMLG59zzmKfiQOJ+wYaY5R0zOHWb5AcZjebga6psPEp/wF2ruKz79xarBLc6KhxN2HQWZM2yhsy6kZXOrYqFvVtTVSNdki4n9ALBeQYjL1PHH//HwcfVSK30PC116pCggEbjxFSG8TuZpWL5kCIpF2iY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761006866; c=relaxed/simple;
	bh=n0/kHP720TsRHcl5iRhXAwARkF2sXYurSSPr5BWY53M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc/6yUshF1MpfpknumWfaWFuhzKzQ80xFh82Rm6FQuUE6GzAZP3AG1MgPrCeznoB4Kk1DEZxpeYGt6FDmnfXbXYyOWlzdlSuYFibrIwy6DfmixNt9bqzyqIvas/tP0L0aXwvUWF+sbJ4b+3Wr8gqvorLwqBeEBAS+xEE15hp1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOpphDtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28301C4CEFB;
	Tue, 21 Oct 2025 00:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761006865;
	bh=n0/kHP720TsRHcl5iRhXAwARkF2sXYurSSPr5BWY53M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOpphDtHnki2+6+hU9hAiPEUaZmUJCieozXHJ5+Z7wjBBmM8oRYThOyGcXUtUJk/T
	 SsefGScSgb8RoLXvbNAxxX5Z9U2D5I/pAP2ciJbk6ePvVc38vzXDxUfRCfTsdPBoVM
	 gFJmwnJK9eqV+RpvJ2eG1nneQWr5rTYhNmS+3l0iillwrXlTIeVoThk8BaF7KlJT1I
	 oDRRGF1l6+bt8X5jxnWZ8bWBhkcgYFVzMDM8z4nJLTRDv7If7vBd7P61g/0wmSyYW9
	 YqEi57TsHoLx+EhEOp11wSLU7QFoAv5YXFKMhJS9cltnqlgU0MdUcXyWOvBow4GLCz
	 g8WsIwPV+OFJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Thomas Haynes <loghyr@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] NFSD: Define a proc_layoutcommit for the FlexFiles layout type
Date: Mon, 20 Oct 2025 20:34:23 -0400
Message-ID: <20251021003423.1954898-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102023-trade-spud-e81a@gregkh>
References: <2025102023-trade-spud-e81a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 4b47a8601b71ad98833b447d465592d847b4dc77 ]

Avoid a crash if a pNFS client should happen to send a LAYOUTCOMMIT
operation on a FlexFiles layout.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/152f99b2-ba35-4dec-93a9-4690e625dccd@oracle.com/T/#t
Cc: Thomas Haynes <loghyr@hammerspace.com>
Cc: stable@vger.kernel.org
Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ removed struct svc_rqst parameter from nfsd4_ff_proc_layoutcommit ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/flexfilelayout.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index fabc21ed68cea..041466513641c 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -125,6 +125,13 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
 	return 0;
 }
 
+static __be32
+nfsd4_ff_proc_layoutcommit(struct inode *inode,
+		struct nfsd4_layoutcommit *lcp)
+{
+	return nfs_ok;
+}
+
 const struct nfsd4_layout_ops ff_layout_ops = {
 	.notify_types		=
 			NOTIFY_DEVICEID4_DELETE | NOTIFY_DEVICEID4_CHANGE,
@@ -133,4 +140,5 @@ const struct nfsd4_layout_ops ff_layout_ops = {
 	.encode_getdeviceinfo	= nfsd4_ff_encode_getdeviceinfo,
 	.proc_layoutget		= nfsd4_ff_proc_layoutget,
 	.encode_layoutget	= nfsd4_ff_encode_layoutget,
+	.proc_layoutcommit	= nfsd4_ff_proc_layoutcommit,
 };
-- 
2.51.0


