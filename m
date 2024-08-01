Return-Path: <stable+bounces-65169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D587E943F5C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7B283D97
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D71C236A;
	Thu,  1 Aug 2024 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeQTXA+U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A301C2367;
	Thu,  1 Aug 2024 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472720; cv=none; b=kyGf4xgxEYx3xdKtRyP1DwhpwGdcknf0QUut23MDFDlB1lYHFh8pa13OJFLLr7UNH9oa0UZnYhydjnTherxKITA16Gb9E1yb5C1+YSz6SvLBW+ugWqAFg67TzK68Tt4pzgKMfJ4l3OaZcA3n61IUWrC7FHDoAnkwhh09FDy7o3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472720; c=relaxed/simple;
	bh=rqDUbOVXDFFtEVVtQDyq3JIl6HOKBMmf6+UCPAyyNfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvyysxK6w6eCgyAjYpN79xbAIRBof7q5yOI5/Kxj5OlA5FUO+tiZ0BdujU88HdX5upgvYmhy9xBgLkHK1BunEJz7lGZPXfTGAOahQrjUGExICXeiTJBcoJV6CwtdA4JHrqEFf64ehhQwve7A/EWyedkcDiot4loJzwq+iJB+s0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeQTXA+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ED5C32786;
	Thu,  1 Aug 2024 00:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472719;
	bh=rqDUbOVXDFFtEVVtQDyq3JIl6HOKBMmf6+UCPAyyNfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeQTXA+UwNMMGVNa1fE1EJq7gKEKuH8ohiYS4OX3bmeYprcJefDpovlekdC+EKPEP
	 Ffqw1v8HKFEGBVQ0E9sc1PdBe/XV7mZfwYi8UJywHufx2dCyD/g5MVbspOC2ktYdpG
	 DmjTEQEUe71tiF3gGdtdZ/E6E6Hr/rJUDRuGDKBzZpw1KFFEq63+VKf5meD5TE8pjK
	 V7SieAdNwB6G1HV4avM2vTPsNG1HvRl9ByMx9IPcolwtjfYOOd5WLsZ6wI0w41e+2d
	 XsC9zo/bbyxxeEzLFDSlePNbyjDsi3HdVuuNd/RSk9bhleIy4AYmGqY+DJ9V2vUdqM
	 eiiGBXDW1oToA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	benjamin@sipsolutions.net,
	roberto.sassu@huawei.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 32/38] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:35:38 -0400
Message-ID: <20240801003643.3938534-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 824ac4a5edd3f7494ab1996826c4f47f8ef0f63d ]

The pointer isn't initialized by callers, but I have
encountered cases where it's still printed; initialize
it in all possible cases in setup_one_line().

Link: https://patch.msgid.link/20240703172235.ad863568b55f.Iaa1eba4db8265d7715ba71d5f6bb8c7ff63d27e9@changeid
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/line.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 37e96ba0f5fb1..d2beb4a497a2a 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -378,6 +378,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -401,6 +402,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
-- 
2.43.0


