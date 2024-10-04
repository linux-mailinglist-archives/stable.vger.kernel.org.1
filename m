Return-Path: <stable+bounces-81082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C9D990EB5
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA12280A78
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE8229EE9;
	Fri,  4 Oct 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdIDD30B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2F229F17;
	Fri,  4 Oct 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066649; cv=none; b=KgkM43eIxWeeRDSa7obGimfq3lIPtez8irPEKtUz6tAIcU3dkSQVX6WmbUgBYjwI2LgKFOJSQOg67/vmPvyjjhYf2xu98ycn6v1rEh3qrM5oaWJEMcNPE6dVD5VWYWwXZS6Oz5kacDDpkLWzMsg9e4j2dR78ictvR0qBzU6Dzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066649; c=relaxed/simple;
	bh=t7y7fDgvx4WWZEu/f1f45OI9g4OBLQG8MlllvwvWtYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m75ts/V6VpTvdzPGaRyENj5MvJ8+YNuWLEuXmhXM0LVWDDsq2s0ndT3lKzj2+gavTASRvNlLK1sV8KGMquKv7jtoNXfaibJt4wS7aBr8M4+gHJiYFiRTA5UV9EfFt3quGmcQHLBjyYQ2kfjYE5/E2Zi3e5/G2oZLf9JNQBKX+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdIDD30B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D994EC4CEC6;
	Fri,  4 Oct 2024 18:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066648;
	bh=t7y7fDgvx4WWZEu/f1f45OI9g4OBLQG8MlllvwvWtYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdIDD30BLz65J8BjWrkCWtWedyOqR64ZIlEzWisuczOabW+HIJ+HuhpXN9lzrOM0B
	 klRKl9lpkxSUhOStpqxvZdlOxqVxKOl7GQfitlHdYOESKZ79I52ljcECNuiojXB0JG
	 0BB6bnOpwVXVfD3y4NwwatP9XKOVGIxIaI1Sv56hkaVmojdFIzpSsFQgX8z7athx0H
	 I7UJW0wkNuAmmBrW2D0+Bbqv4NPF3oaOwN3cvFvFZVOkSDCCXZV89xBoDLSvUM2E4a
	 KQqay1n7UL8/PSQNJKMgoWnnrdZ/YRbcXKxm0Ua7fChqoKs+PPpvtmQjixtLfptBg6
	 StLlOkIMgYPjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 24/26] driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
Date: Fri,  4 Oct 2024 14:29:50 -0400
Message-ID: <20241004183005.3675332-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
Content-Transfer-Encoding: 8bit

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit c0fd973c108cdc22a384854bc4b3e288a9717bb2 ]

Return -EIO instead of 0 for below erroneous bus attribute operations:
 - read a bus attribute without show().
 - write a bus attribute without store().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20240724-bus_fix-v2-1-5adbafc698fb@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index df85e928b97f2..47ab755aee949 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -104,7 +104,8 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for reading a bus attribute without show() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->show)
 		ret = bus_attr->show(subsys_priv->bus, buf);
@@ -116,7 +117,8 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for writing a bus attribute without store() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->store)
 		ret = bus_attr->store(subsys_priv->bus, buf, count);
-- 
2.43.0


