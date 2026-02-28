Return-Path: <stable+bounces-220694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EESAF4VDo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:35:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 007701C7290
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9B531B384A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C5A3F9337;
	Sat, 28 Feb 2026 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsk51/MS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDA3F932C;
	Sat, 28 Feb 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300574; cv=none; b=KgUzrLg7ch6vA72fzC9DZkgzoTqhAp0tdVlleP+QCGIlfsQUTrDUM3DCF0MMRODFRMY7ohgfEa14DFWJb/pYyqSq9IhDzjqiwPCiNffFQaLfuWeWTq/ad4ZBulZzd28wEAKu7aBgK40rsq4wUyG9FkSmMdnXlALZehPEds3QRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300574; c=relaxed/simple;
	bh=AILmNc2NOtZL77kxlQkF82GxIgCfmUK+qQkkpyrH21E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtfuwcOeRAnu4j0uRK+xlHIk6Z4vzIC4l6vlgbo5EcI/GRDXfvcHOnqdH7K8ekyPfcqOXvOgq5M/em73S+3GU0aMVmcxHnrDggtUL2Rgby+KXthH0pPPDo3+q8vIAiSHC+3R5eWgYWeDFTciJjIvyLskHnKZZSZutFRjL57Wj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsk51/MS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ACEC19423;
	Sat, 28 Feb 2026 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300574;
	bh=AILmNc2NOtZL77kxlQkF82GxIgCfmUK+qQkkpyrH21E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsk51/MSJpTkmM/pN7W+9F9+CNImOTiLNICTPxfUeCFlHLhouWrDAREtNqIDul8AG
	 2eQ0F8avaZCZZtdS9TMiNcBoFBIJ/i68dHx9AqLDUyBo0pYjMSgguggF7De4f7/68d
	 DymzeQlS2wnJmSb+96+P3xevf+rBq3fHnJyIi8ImVpCGwC9Or4IvKHMAfxC2u4zXFj
	 ayekJOG1QnR/HJT108XXNzNjLmmVMVNeMOJObfkdd1v/TuAvbXjYWtKn3QT0VWU1HV
	 FH9kIPw3QI9r/NczTmXZv3w9DFXO+sjJTL6sE79qSzwvJBRdWkWRAq2mN9LZrm0xIK
	 i0FHdRj8yDecA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 615/844] media: stm32: dcmipp: byteproc: disable compose for all bayers
Date: Sat, 28 Feb 2026 12:28:48 -0500
Message-ID: <20260228173244.1509663-616-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220694-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[st.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 007701C7290
X-Rspamd-Action: no action

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit 3363aa2640f1738ad7fc56ea56f5e0301ad97196 ]

Avoid possibility to perform compose on all frames which mbus code is
within the bayer range or jpeg format.

Fixes: 822c72eb1519 ("media: stm32: dcmipp: add bayer 10~14 bits formats")
Cc: stable@vger.kernel.org
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/st/stm32/stm32-dcmipp/dcmipp-byteproc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-byteproc.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-byteproc.c
index db76a02a1848a..ec1d773d5ad12 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-byteproc.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-byteproc.c
@@ -130,11 +130,8 @@ static void dcmipp_byteproc_adjust_compose(struct v4l2_rect *r,
 	r->left = 0;
 
 	/* Compose is not possible for JPEG or Bayer formats */
-	if (fmt->code == MEDIA_BUS_FMT_JPEG_1X8 ||
-	    fmt->code == MEDIA_BUS_FMT_SBGGR8_1X8 ||
-	    fmt->code == MEDIA_BUS_FMT_SGBRG8_1X8 ||
-	    fmt->code == MEDIA_BUS_FMT_SGRBG8_1X8 ||
-	    fmt->code == MEDIA_BUS_FMT_SRGGB8_1X8) {
+	if (fmt->code >= MEDIA_BUS_FMT_SBGGR8_1X8 &&
+	    fmt->code <= MEDIA_BUS_FMT_JPEG_1X8) {
 		r->width = fmt->width;
 		r->height = fmt->height;
 		return;
-- 
2.51.0


