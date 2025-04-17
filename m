Return-Path: <stable+bounces-133871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4FDA9280F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD591703D0
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFEB258CF5;
	Thu, 17 Apr 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eR7nyvtw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933D258CD6;
	Thu, 17 Apr 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914399; cv=none; b=bqmlEWvxqvTj1VIlSHupurIwn9fonCIsX4/gMjMzoIMbYvrUBLnehxpwLHtPuwqF6GTKbkZ+ACgkGx6tTLsXx/3kEEbEn0zG6w1UpxEPK8dMxxUCXv7iKtxP6VnFofXhmZc43LTyy7azDA0t6kKOPaw78u2m6LDo+xMsvqH+h94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914399; c=relaxed/simple;
	bh=9VTRe5LXWdlsPSmtucjyjCpVSB05EV9cmlf2VloSqw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTec8Nq6DL5CeJiwYjSc+Jl+IyJV5I6bHpbFIsDg8gyFhSjcdVNovIvunjhR5AqEc5ibIjm3tlDlTeQ8fb0Z7804Wwq1zwyrdaU8waRq6B8YfZlCz/Bcqw1xgksR45dl+isz5U9YNTcOsqSncq4xsgXDg/VsauPV48/rk3M7GpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eR7nyvtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A31C4CEE4;
	Thu, 17 Apr 2025 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914398;
	bh=9VTRe5LXWdlsPSmtucjyjCpVSB05EV9cmlf2VloSqw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eR7nyvtwQZwkif+ud45DgPYlPqIscEmszMTL6sdbcCA1d4s8LfFfUdy3mxTVcG6xm
	 rPzv/CFunqqrhCdWCAljEm0KXDUeuHU6wusdi6x1HqoCvoXS0m3lmAdpIuYyngs9uc
	 F/s77Ihzs1o1loycNI6kQ7joc7FE4M2fEgGy4cpA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.13 202/414] media: mgb4: Fix switched CMT frequency range "magic values" sets
Date: Thu, 17 Apr 2025 19:49:20 +0200
Message-ID: <20250417175119.566119898@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

commit 450acf0840232eaf6eb7a80da11cf492e57498e8 upstream.

The reason why this passed unnoticed is that most infotainment systems
use frequencies near enough the middle (50MHz) where both sets work.

Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/mgb4/mgb4_cmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/pci/mgb4/mgb4_cmt.c
+++ b/drivers/media/pci/mgb4/mgb4_cmt.c
@@ -135,8 +135,8 @@ static const u16 cmt_vals_out[][15] = {
 };
 
 static const u16 cmt_vals_in[][13] = {
-	{0x1082, 0x0000, 0x5104, 0x0000, 0x11C7, 0x0000, 0x1041, 0x02BC, 0x7C01, 0xFFE9, 0x9900, 0x9908, 0x8100},
 	{0x1104, 0x0000, 0x9208, 0x0000, 0x138E, 0x0000, 0x1041, 0x015E, 0x7C01, 0xFFE9, 0x0100, 0x0908, 0x1000},
+	{0x1082, 0x0000, 0x5104, 0x0000, 0x11C7, 0x0000, 0x1041, 0x02BC, 0x7C01, 0xFFE9, 0x9900, 0x9908, 0x8100},
 };
 
 static const u32 cmt_addrs_out[][15] = {



