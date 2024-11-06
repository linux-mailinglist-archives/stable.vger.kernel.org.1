Return-Path: <stable+bounces-90261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186169BE76C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A812836FE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DF1DF25D;
	Wed,  6 Nov 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vFUExNfY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDF1D416E;
	Wed,  6 Nov 2024 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895250; cv=none; b=MiDqxp6ECQNK/0yZcQupqcvT7eZSc27Z2aBXvNeyXG8h/qyLHGKszD9RcbUJnbwCSyLlOFwgIi2Um4xbKhSSI/t4PbeiJ5LTQbGdDx4cDjvwcSR7PPJSFkQLPJXqk1B27cgQFGT2RNg7ynyVQwt6Z6c2dVCqhhOCsZ8RMS3fcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895250; c=relaxed/simple;
	bh=2sXHKFKmduNgdnOycRrkc1diyD9EOY6W7Pk5DbAoRS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dby1E2imsXQMiz6S7QDryqr9GwHbxpedWmoEM93+iD/xU1Wkooj2TNqQfFnJ2eqSlhw47RuJXm8knQldYdXLS/BK2szar7/I06vvANam5JqUYPbmuNdTY0e+galQELoEtBgDb9jinxV8/HHbpMsVyKZq1V/95BEFD3AAH2m2Ojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vFUExNfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BBAC4CECD;
	Wed,  6 Nov 2024 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895249;
	bh=2sXHKFKmduNgdnOycRrkc1diyD9EOY6W7Pk5DbAoRS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFUExNfYGD2BvFAyCW0cpfE54k30Nxvo0ONZmYGqMdKwfFaJtHKZl+gFR/37PFhqF
	 AfUc2/uu/cnQdbcEtRePZfXpKKS3ecbNIDBBklhx0OAyNnjvWBv64pVbyoy4SgoObv
	 eOJPguP6iOqm31fdpJIHFU53sQThq7CD+nL90bYg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pei Xiao <xiaopei01@kylinos.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 154/350] ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()
Date: Wed,  6 Nov 2024 13:01:22 +0100
Message-ID: <20241106120324.723893668@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit a5242874488eba2b9062985bf13743c029821330 ]

ACPICA commit 4d4547cf13cca820ff7e0f859ba83e1a610b9fd0

ACPI_ALLOCATE_ZEROED() may fail, elements might be NULL and will cause
NULL pointer dereference later.

Link: https://github.com/acpica/acpica/commit/4d4547cf
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Link: https://patch.msgid.link/tencent_4A21A2865B8B0A0D12CAEBEB84708EDDB505@qq.com
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/dbconvert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 9fd9a98a9cbe8..5255a0837c82b 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -170,6 +170,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
-- 
2.43.0




