Return-Path: <stable+bounces-176023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8E5B36BEC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994D0A03B5C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B735690E;
	Tue, 26 Aug 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jiVvJnZY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336D35690D;
	Tue, 26 Aug 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218583; cv=none; b=JaaRn+mK0adY7kzd9TUACTbYGt58iob5YFTig++ROmU3qMeR9M3b0QQOJuhUS/oBzpqxlxAh5nZ4DwR5s2HKYZtkLOatfweABpwuJ2P/2J6ZYR4VvxBxF+kCU6b8RVv3oJ/BnLJPMOJ91JiVILjlmybO9i5lbykrKmB2L+gTU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218583; c=relaxed/simple;
	bh=vmYZNKVtSpBzizZZgpCjTqDksBn1HFliqqyU9Pm36aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9+Ae3XDgQDR4N4EbJ9G0FXq8FCs8VVLZWj13SHzg/w4n1YgWypg8LuZa2d68IXtjpjEHpeHay2p/Xrw0IGxWg8IP3Jvd3kiP43/uyUGD6/jnLh8BC/Nf9JGiLIwknWkd1e7sjo/w/VBoGIA2JBWICMFisouaM6Yv2jpy6D4wqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jiVvJnZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B155C113CF;
	Tue, 26 Aug 2025 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218582;
	bh=vmYZNKVtSpBzizZZgpCjTqDksBn1HFliqqyU9Pm36aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiVvJnZY9xQHgC2gqETzxV2QBA1WYjUIYVsEuU0y3UshAwClcAAYGDppMuOeU18Pv
	 u8zJcej/a20YajbqPejoedbX2LZ0VxFnJasCuYrvVa8dEMY41zCHCSTRuhxiVc/fey
	 x62XPrYu5MGHUSRr8DZuK8vClPNK5UfIMMAm1yHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alessandro Carminati <acarmina@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 056/403] regulator: core: fix NULL dereference on unbind due to stale coupling data
Date: Tue, 26 Aug 2025 13:06:22 +0200
Message-ID: <20250826110907.416027491@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

From: Alessandro Carminati <acarmina@redhat.com>

[ Upstream commit ca46946a482238b0cdea459fb82fc837fb36260e ]

Failing to reset coupling_desc.n_coupled after freeing coupled_rdevs can
lead to NULL pointer dereference when regulators are accessed post-unbind.

This can happen during runtime PM or other regulator operations that rely
on coupling metadata.

For example, on ridesx4, unbinding the 'reg-dummy' platform device triggers
a panic in regulator_lock_recursive() due to stale coupling state.

Ensure n_coupled is set to 0 to prevent access to invalid pointers.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Link: https://patch.msgid.link/20250626083809.314842-1-acarmina@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a01a769b2f2d1..e5ce97dc32158 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5062,6 +5062,7 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 				 err);
 	}
 
+	rdev->coupling_desc.n_coupled = 0;
 	kfree(rdev->coupling_desc.coupled_rdevs);
 	rdev->coupling_desc.coupled_rdevs = NULL;
 }
-- 
2.39.5




