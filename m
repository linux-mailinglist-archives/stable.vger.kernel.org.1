Return-Path: <stable+bounces-65082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA48943E29
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5F81C2246F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1D1B9921;
	Thu,  1 Aug 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex1SRMYb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280F1A00F7;
	Thu,  1 Aug 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472280; cv=none; b=EdQ8ZMBOwfTSUF5XSe/vFYyzxG/RhF4plnBP9mOh1RDYEa4dmjypbONq5uc1Ihv/LMo0yqdw6YmQEStGqGcuX33yIv5tCo0EXvvCLE6yz5hqO0xYbwaBQVsfSNfw+SqTk1uL7CVbzKlxHi/liAt/BDkPZbFYr9BOm/3fpIpN5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472280; c=relaxed/simple;
	bh=uP4TlehPy0hVgRkfWi8usR0oWixCZMo03YZrwSkKnko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3hvNwUsGVl1+4xBZ3a3eAgf6q8H4c02E7m9RLts5lHeOcPA6CMZNGVVFJM8OsEuiPYj5oo2ujFrqwME5oe6qnTQV/FODgfl1AFIR2FuxstRaHuqGvqTIUjIH9Y63GwWXN7JSAAu+voERSUEb0BvlSHrKPhhfDmvXdRyM4dzR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex1SRMYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83577C116B1;
	Thu,  1 Aug 2024 00:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472279;
	bh=uP4TlehPy0hVgRkfWi8usR0oWixCZMo03YZrwSkKnko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ex1SRMYbgBd7k6IZKdADjh4EBFc83gdfztoa3Oi2fvDN6N/G5Se16M1JVLoKGVpL5
	 sKYkX+lWEPhMNIWoB7ISC1Kh/pDW5lW8VQHcG5Tnn808EjHodRK8tBoubH5N/V3jex
	 vc4qsIbB8ADqthxF1VpknXMzjSKWSwbEqASmA/Upu8oxMLyj6HYaQegoDDG35A6ig6
	 XYF7lkPQ1owFW87amsszHE7gQggEOD5gbwLGOde3+/3YfGQZwvrgYSCYnbOXIGQ/0L
	 Aeae6h0/qL73RO8JnxAM8dwZUPF1zqh7JdhZMyswRt8fQfBI9l+nI9bpS2UyYXfMoZ
	 B6SQ0cvkVtXaw==
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
Subject: [PATCH AUTOSEL 6.1 53/61] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:26:11 -0400
Message-ID: <20240801002803.3935985-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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


