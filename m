Return-Path: <stable+bounces-48470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F224B8FE924
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EC21F26B43
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E58199228;
	Thu,  6 Jun 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y0oduuME"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA25196D8E;
	Thu,  6 Jun 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682984; cv=none; b=KklIRCHIGyVpdwt9h48gNYhuaUC9jPoR3ZfMqF6WlmXmxCV44xGpBOvHXVF6hmEcdNP0pWbD1LI4c6mD4N70A8UJx/D5WlAckvpdR1X+6lMx0hHZRjxbX6vk7MxrGMlZaD5EFzg6T0Ymk7ERpzMnA1k0KzKXEOGcCyAHnI8+7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682984; c=relaxed/simple;
	bh=3enp6nYqIasOnHHHZsVvjq2wWFdT+F2ib/+cwqLV8+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLrNRaIUtrUn2Q8QDlmBTDHhVl4/2QIEJmF7XV1zTpLUX9HO76wBQHgdzCHRUa3RRxun9KW4ek781I4SQ+y2MRPkvVe6hotiqcDInbqu8WAH9bMPfX4BMQb0DLLTBQNiMzLZmtajO/9dMmM0NFLrb29AF0pVm2nqyFhhAFQdB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y0oduuME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC7BC2BD10;
	Thu,  6 Jun 2024 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682984;
	bh=3enp6nYqIasOnHHHZsVvjq2wWFdT+F2ib/+cwqLV8+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y0oduuME+fEaYxPvbrRgxnin4YKo5ehaRbVEKjXTzgeIBYQKyUA5hW3U/Gd1JWtSI
	 IMLS+CqdfZ9zNWl9llfGIV935QhGa38aK65y4Qn6NdOmiRqvg6RK+4czDYt2FkNZrT
	 ozGqOlWI7sq6OEZA/QZwprxeW+OVahexq9PA05hM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 169/374] um: vector: fix bpfflash parameter evaluation
Date: Thu,  6 Jun 2024 16:02:28 +0200
Message-ID: <20240606131657.556749153@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 584ed2f76ff5fe360d87a04d17b6520c7999e06b ]

With W=1 the build complains about a pointer compared to
zero, clearly the result should've been compared.

Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Tiwei Bie <tiwei.btw@antgroup.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/vector_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index dc2feae789cbb..63e5f108a6b95 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -141,7 +141,7 @@ static bool get_bpf_flash(struct arglist *def)
 
 	if (allow != NULL) {
 		if (kstrtoul(allow, 10, &result) == 0)
-			return (allow > 0);
+			return result > 0;
 	}
 	return false;
 }
-- 
2.43.0




