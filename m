Return-Path: <stable+bounces-177203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4DB40435
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D5A1B62FC6
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891BE2DA751;
	Tue,  2 Sep 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j8oh4+3E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467223D7EC;
	Tue,  2 Sep 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819906; cv=none; b=s4uCtCLvlcQYx2qfH732nQnsjUXVT4SmO8Dgo7DKr+yScmb6FQAXlq2ncrL7SUM4VPm6AUryXcrLVet4QMzTxEDar3TRhUunK5veQd67YF4f6vcAVfKVQ9dGyvg16NuFHSMVdTGJku92DKzW4+6tpHqPE0oiHxcaVYdmC1XkRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819906; c=relaxed/simple;
	bh=JHvl+XH3Vs3RQuO5rbX8nZ2M4xy4KcEXVa1s86KSobI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uhj63IIZJpdD7JF6EZPfM/FKgzq0hyYvVaQWoJjUnW77+9e5mb5FuNOwpXXPcfL9j8smCkXDEyIT0oCoZywLy3wbCmIhKb8/CY2VuIIv1jWpvfCtAeMHzbJ7yHPtLyEl4WEPeF1glykwjyggGYhDIDHKIWGzlsTzwAo/N5vZHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j8oh4+3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28DDC4CEF4;
	Tue,  2 Sep 2025 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819906;
	bh=JHvl+XH3Vs3RQuO5rbX8nZ2M4xy4KcEXVa1s86KSobI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8oh4+3E0WAiVB+nNP8i7LDJVbER4oNMVkcHdrl74ZJxvQLOJ1EciufwrB6jxJJvO
	 IfOXkrGcvLrUj1CTsANiQL52+Cc4l1NoHt+WjkN3XbhXQ5BOMONDxTnoiCKqcNN+z2
	 A0cdt3R0XqNJM6dG0tDs3R+KpnzicyoT2hQFcDE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 08/95] of: dynamic: Fix use after free in of_changeset_add_prop_helper()
Date: Tue,  2 Sep 2025 15:19:44 +0200
Message-ID: <20250902131939.932828330@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
References: <20250902131939.601201881@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 80af3745ca465c6c47e833c1902004a7fa944f37 ]

If the of_changeset_add_property() function call fails, then this code
frees "new_pp" and then dereference it on the next line.  Return the
error code directly instead.

Fixes: c81f6ce16785 ("of: dynamic: Fix memleak when of_pci_add_properties() failed")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/aKgljjhnpa4lVpdx@stanley.mountain
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/dynamic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index fcaaadc2eca1d..492f0354a7922 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -935,13 +935,15 @@ static int of_changeset_add_prop_helper(struct of_changeset *ocs,
 		return -ENOMEM;
 
 	ret = of_changeset_add_property(ocs, np, new_pp);
-	if (ret)
+	if (ret) {
 		__of_prop_free(new_pp);
+		return ret;
+	}
 
 	new_pp->next = np->deadprops;
 	np->deadprops = new_pp;
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.50.1




