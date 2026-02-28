Return-Path: <stable+bounces-221020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEb3DBldo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:24:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1BC1C901F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3DB03372F7F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C714BCAB9;
	Sat, 28 Feb 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGizQ4i8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829C29E114;
	Sat, 28 Feb 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301363; cv=none; b=X8k5MC8ZSn2XriVzplAap/Zrtm+wu9VuYIa3VAT2ATrAf1XIk5ywBCHHUldlf2rQYPQbNMpAN7WszURldLBaLzCLxs6eq5SjF9+etI5Rs8we8EoU6+QJZfJKhRzjbYQiBgCpgiK4CXUrdG3CqIgGe9XgNgf5PapEV36Gs0/dNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301363; c=relaxed/simple;
	bh=AILmNc2NOtZL77kxlQkF82GxIgCfmUK+qQkkpyrH21E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNvBhkg0MXUSlZnqLDWz7zrx0YDn7eqHFg81K+o5HwQWlcefAa+OtMnDcbd9c8lzf7pgAz1ZNVOIlX+GakB7pBnuyprb1xny1+v36Mvj8/uz3Jzpn8Wqe+m51rOMVQ9Stvl/cstYWZH5S4i3yIkpliAbYWujiY33RTFpk+hJdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGizQ4i8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D19CC2BCB1;
	Sat, 28 Feb 2026 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301362;
	bh=AILmNc2NOtZL77kxlQkF82GxIgCfmUK+qQkkpyrH21E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGizQ4i8XIZwE8s8UaGBMjmNsWyhfbRt18Fm1yzIWdjALoilgs0hzhmJflq7tf8It
	 tWn2mEhwM7bAgBGHMQ9y07fTYrSKTQFkBk7DSUkDfTJpoc64EZzheGvf6/aNJjUrCC
	 x9Qyi8LwTJfx6qFocO6h36MGK6TaH4kdevNBp+95hvBYCJbK9jzInv5hQcR2+cn63T
	 fgo6LFVkXvQsz2JymiIAFIrxYT9nA2wNtKDF42jc05QxuHL/pHclFuZwcRpE3mDjZV
	 A59IglKkZfTu1NGPxzEbJ6LKuG1o+PMdz2nVSijYcGqhN6d6NO1LGNdQ3PyFN9QSW6
	 O6kuIOmuj1mwA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 551/752] media: stm32: dcmipp: byteproc: disable compose for all bayers
Date: Sat, 28 Feb 2026 12:44:22 -0500
Message-ID: <20260228174750.1542406-551-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221020-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: AA1BC1C901F
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


