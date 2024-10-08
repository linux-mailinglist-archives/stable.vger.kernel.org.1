Return-Path: <stable+bounces-82194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D0994B97
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBFF1C24DE0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D33D1DDA15;
	Tue,  8 Oct 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y2WVjsmn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFF71DE2AD;
	Tue,  8 Oct 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391457; cv=none; b=aNbEwvkzqiunIgxxLpwdmy0pwj3e7e16vV6YV5NzY/vPB6KsgCHWShDDGnjnZmgcz2ZhbtOS67hT8d2kE+HL70isTZ4vFyy4PlvFj0qU5A2CfqLvD/WyfwrdjkZYYOsxFOCzN+W+T7q5Y0Z7kW4pX2bPCh5wBbantwefVlnnIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391457; c=relaxed/simple;
	bh=UChQb1TGfz1y1XrkWfn4RY8IjjKD0jKsQRMkLo9UNTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyvtIKpFG7J5yh59TfnCwZjmEAzwS1PLZwmCYTyYVElwQpKCUpSBZr0uPKvgnnWeKH6QTHd6oN7Bdhqg6qfZmK3rTY0z+7B8AvaH8k6BGEbPhd6mVx+qZmt7SD58SIZrMzVF/DBDbY3gsQUrPFNjyDYvg22Rp5woyEWyq4AoSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y2WVjsmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F93C4CECC;
	Tue,  8 Oct 2024 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391457;
	bh=UChQb1TGfz1y1XrkWfn4RY8IjjKD0jKsQRMkLo9UNTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2WVjsmn1cCjqrxhpRZJ1+7/mb5Vvs5xLeDKo5ZmXIWSIAmHnJILYdGnInc6LTwrY
	 DGHzC6XR36zZIaUjxntBZkksOELq+XNbF6QDSSID7beYpR+a+qS8kVixSMYwTDmrzZ
	 YNekQxz3bt0IMeaGYhP47N1TwI3fjgnDi0ZSHxHk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pei Xiao <xiaopei01@kylinos.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 121/558] ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()
Date: Tue,  8 Oct 2024 14:02:31 +0200
Message-ID: <20241008115707.127964569@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
index 2b84ac093698a..8dbab69320499 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
-- 
2.43.0




