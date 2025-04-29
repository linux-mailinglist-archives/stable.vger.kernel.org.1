Return-Path: <stable+bounces-137161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB6AA1217
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD2F9805B7
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3DF24728A;
	Tue, 29 Apr 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nKw/xlkN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1D24113C;
	Tue, 29 Apr 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945245; cv=none; b=LyXnc9SJg5t8y/gZoT4aAt0JZ6Yqzb/As3By6Afv1A4P5DfJ+/6DnM2mLIOEF4SyRgtHXNEBxq3t0ZDZ/Yu8KJHGBjvCLPu9bRQer+wT9GlXoDheNueanYmwBn5GauOgZpS2DqBsChT5sPd2MVvD6RflKnQwwa47DTKFYKXOZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945245; c=relaxed/simple;
	bh=3Ro4PwmzZkqAng6HwHedycz2mKRYeYZf4QdcKcSJGlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxsJuxZDvUSn5TIWLpOuhRwKrUXsDuHD77UvamknbPeU7NmyNJ6RF5PvaUw8w1i1Bt11uRGg5roAMMBYU+RgDI71RVwPjrkES4mMKv4iWoBzk7Z33ghESuyrekEhMfJXwixzQliyWeBOIGxHY1F1gW3RvHo6A5ICWHEKGVlpaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nKw/xlkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB0FC4CEE3;
	Tue, 29 Apr 2025 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945245;
	bh=3Ro4PwmzZkqAng6HwHedycz2mKRYeYZf4QdcKcSJGlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nKw/xlkNx3KYpjoGm+P7+yOoaQqyUKGbXgLqUaLlqQRX3hmugU4sxckX3neyo/B4D
	 XmeabARTrQFF05Ommst3XmDwkopwpGMXJFlHF65FtuXuQguTUmJGQEzYrEwi/ZgBOw
	 UzKecEzvqWwNZ9G6M2Wog9HR/ioc9OOMjBhYYdMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.4 048/179] xenfs/xensyms: respect hypervisors "next" indication
Date: Tue, 29 Apr 2025 18:39:49 +0200
Message-ID: <20250429161051.345063876@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Jan Beulich <jbeulich@suse.com>

commit 5c4e79e29a9fe4ea132118ac40c2bc97cfe23077 upstream.

The interface specifies the symnum field as an input and output; the
hypervisor sets it to the next sequential symbol's index. xensyms_next()
incrementing the position explicitly (and xensyms_next_sym()
decrementing it to "rewind") is only correct as long as the sequence of
symbol indexes is non-sparse. Use the hypervisor-supplied value instead
to update the position in xensyms_next(), and use the saved incoming
index in xensyms_next_sym().

Cc: stable@kernel.org
Fixes: a11f4f0a4e18 ("xen: xensyms support")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Message-ID: <15d5e7fa-ec5d-422f-9319-d28bed916349@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/xenfs/xensyms.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/xen/xenfs/xensyms.c
+++ b/drivers/xen/xenfs/xensyms.c
@@ -48,7 +48,7 @@ static int xensyms_next_sym(struct xensy
 			return -ENOMEM;
 
 		set_xen_guest_handle(symdata->name, xs->name);
-		symdata->symnum--; /* Rewind */
+		symdata->symnum = symnum; /* Rewind */
 
 		ret = HYPERVISOR_platform_op(&xs->op);
 		if (ret < 0)
@@ -78,7 +78,7 @@ static void *xensyms_next(struct seq_fil
 {
 	struct xensyms *xs = (struct xensyms *)m->private;
 
-	xs->op.u.symdata.symnum = ++(*pos);
+	*pos = xs->op.u.symdata.symnum;
 
 	if (xensyms_next_sym(xs))
 		return NULL;



