Return-Path: <stable+bounces-64932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD4A943CBB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99FA8B24206
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303CC1CB31C;
	Thu,  1 Aug 2024 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeQx1zWg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9AF1CB317;
	Thu,  1 Aug 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471488; cv=none; b=Viwnc2vulSs0ojiDcjK67hTH0CvY2iwSXng8uaq6qJ8pYIhghHrmlbgR8tlohcTihk1GwPGZ9LJ9hwz7fjeDGE/cvPlc/1pjPzvARF7K8AJ4lKb68VF3HIyfgM8WlHEGegnon/arpsEl0VLd+yO4xINeJFOsA56k1VchjyTqEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471488; c=relaxed/simple;
	bh=MyxFag4pLvPdYkUcDlgL1xkABfBZqiGJ1mTFCb2NG5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUKmXvRnlPd9BG4qNSOjWpcFa5O1Ojg7aYRQ8ddWxSuEWkkATCOJNybg4gnpNazGcWo6WVd+iTFK88ZDB1vJ8fxBcLlMdGKSuZlW+txcCUpBY0kHH90B4HKm6VF4z1/KJ6VQngpwnZCSuaMl13ppzE3T5Zr1Pl/aOSOw1LmoqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeQx1zWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202CDC116B1;
	Thu,  1 Aug 2024 00:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471487;
	bh=MyxFag4pLvPdYkUcDlgL1xkABfBZqiGJ1mTFCb2NG5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeQx1zWg7F4z6ACwOJV2O3bQdPZB9Yi/Iwbj4tQfvGRdIlcc1rXKWliBl4pE5NJCh
	 8hPPa2Hj4/o5vypYKPlp8NqP3Q5wtEVQ4IVDjucB7SS2/vwmijv/i+XymojPp8Jiz2
	 IT/CQoUqnQKO6SfcxyMSkj9s3QeFIoNBREFXy8NHj1disVnmcCC9JiITRy2rwDciX5
	 6bFDRIT6yQm/7PeAHG0AVVYNg2KT6jkSzzBcmO/Ta1v1GYEZWr4bPqQaZhjM+RoIrU
	 nsgKi65w1dTeiVs4SSoly1MxFImFb7Ne1WGCu7D51F3NPKk+ZJyGhP4enyzyk9OTzO
	 nsqRzqa7/I7yQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	johannes@sipsolutions.net,
	jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	roberto.sassu@huawei.com,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 107/121] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:00:45 -0400
Message-ID: <20240801000834.3930818-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index d82bc3fdb86e7..43d8959cc746f 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -383,6 +383,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -406,6 +407,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
-- 
2.43.0


