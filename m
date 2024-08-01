Return-Path: <stable+bounces-65130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65093943EF9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A31D1C23088
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4CF1A7F78;
	Thu,  1 Aug 2024 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE+z+1tW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2C14B082;
	Thu,  1 Aug 2024 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472527; cv=none; b=Tp0kVenmTefqHEAsdUVq9Z5rakDComY7yNEBd+7hn1+mH9hXoSUATxxw+x1OxSNRYgZLzKkV91/0rhAYPzbtoDz8JnFfpsEeLVrD4lmBvp9zFW+14ujrnrzJJyiJY0aDvn7P7FV+HKpuNWm8GF2BIn0a+LRAHIfuVb5G5pBeG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472527; c=relaxed/simple;
	bh=uP4TlehPy0hVgRkfWi8usR0oWixCZMo03YZrwSkKnko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PralqZHI418mypJ6nP564cL4ppZ7ro4UayatMDmRCr/YRFVHppvNs5PefkZIU6CSb2Qxz7J6gRCRdpyBKL5H8v3W2xExWoTAGdsSdnmRFQEjQxhjdYShIYrIG6v6D8p4rX2Xp/a45Usq8w6veYKv9uTr0nLuFtrGz1QIZnjAOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE+z+1tW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07698C4AF0F;
	Thu,  1 Aug 2024 00:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472527;
	bh=uP4TlehPy0hVgRkfWi8usR0oWixCZMo03YZrwSkKnko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cE+z+1tW6Zghv39FLJUoqQHJNs6yd1U4A3pUEtppzKOq6k63O8cp0rzWGlxo6ytut
	 BnDMlQ94zZvV3NwrOvbps11+Ui/CdWKOERmwyOeGlpasT9guYAXVQBlT3QGNN5LK3Y
	 Xyzp+qk9jnXJGlZ2GkP8YcUWbnaLZqPacbaEmcZlW44vP+91pUEYBfbnAztfm/G1ac
	 WoYZEj7y72uF2wGiZqL1ZfTg5fzz/V8UbIkXR8xxgVdg6iBYTok736+ilBPbd338RK
	 hogjX0QGEvWnNPpkmxY5UdONAhjIDpc2FYXYgEGTEDvU3u4XwdlLxafr+t3qiWl2Es
	 h28hq9R4aZaxg==
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
	roberto.sassu@huawei.com,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 40/47] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:31:30 -0400
Message-ID: <20240801003256.3937416-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 95ad6b190d1d1..6b4faca401ea1 100644
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


