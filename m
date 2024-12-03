Return-Path: <stable+bounces-96292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8119E1BB1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC358B2625C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431991E47B4;
	Tue,  3 Dec 2024 11:45:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841391E3DFF;
	Tue,  3 Dec 2024 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226305; cv=none; b=amxYrgEmy1PiSHzMFSLxlVtCoRugoQmlV3DyQsuMiBsZAffdcsK7xcci+yvHNZNT6pt65wkuur1uYyas+Goez+fX4cmUOSM5P6oE1P3GfCXbdiu08CubN+Xi8gjHBlsEpajOtZehLdQU0QCUYTVL69JHOgDrWj+NoFX6jVwfhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226305; c=relaxed/simple;
	bh=R39Lqh4Xa8GuodMNvqRsWUMTrN0xRgZQZtiEd5nXfOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpK/X6Fi5H3QuBDYe2+YWXmfqrF0MoHzD/5n3e9dNVz1WAArNTj+TVh2GdDdL1Qxniv/2t3hS1w7vPhcZFZ/mWY5ZdqGRcqRbhIRnga5ncyymgoBtutvIGxMgRA/AWywZXFEW3YtmKfeJztoR3nBs5YuMJJmEdmvCk7C9sPySJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 466E62F25C4;
	Tue,  3 Dec 2024 12:45:00 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8VtyKen3NMH2; Tue,  3 Dec 2024 12:44:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DA52F2F25C3;
	Tue,  3 Dec 2024 12:44:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lXYm7QGBvPwX; Tue,  3 Dec 2024 12:44:59 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 933E42E612F;
	Tue,  3 Dec 2024 12:44:59 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	kinsey.moore@oarcorp.com,
	richard@nod.at,
	dwmw2@infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] jffs2: Fix rtime decompressor
Date: Tue,  3 Dec 2024 12:44:39 +0100
Message-ID: <20241203114439.6256-1-richard@nod.at>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The fix for a memory corruption contained a off-by-one error and
caused the compressor to fail in legit cases.

Cc: Kinsey Moore <kinsey.moore@oarcorp.com>
Cc: stable@vger.kernel.org
Fixes: fe051552f5078 ("jffs2: Prevent rtime decompress memory corruption"=
)
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/jffs2/compr_rtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/compr_rtime.c b/fs/jffs2/compr_rtime.c
index 2b9ef713b844a..3bd9d2f3bece2 100644
--- a/fs/jffs2/compr_rtime.c
+++ b/fs/jffs2/compr_rtime.c
@@ -95,7 +95,7 @@ static int jffs2_rtime_decompress(unsigned char *data_i=
n,
=20
 		positions[value]=3Doutpos;
 		if (repeat) {
-			if ((outpos + repeat) >=3D destlen) {
+			if ((outpos + repeat) > destlen) {
 				return 1;
 			}
 			if (backoffs + repeat >=3D outpos) {
--=20
2.47.0


