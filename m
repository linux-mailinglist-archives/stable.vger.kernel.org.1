Return-Path: <stable+bounces-65018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E6C943D94
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5394D281561
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7216F297;
	Thu,  1 Aug 2024 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwZkJV8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E71B32AF;
	Thu,  1 Aug 2024 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471954; cv=none; b=gbETjcfoRXh5mYMqJFn7ltBlt765hVKOKd1NLkACcLh7pDkmdWMbL0Kf7Knxs0cufMW4gc/SFYub8UfzmRHJwUkmmHv2d8z/F1geAldym5cfJ1T70cb6zijZ3Y0vl/gjBmCq6UV0/P1Po5UhKVpfnNXPwNux1m/4fOomBbOk+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471954; c=relaxed/simple;
	bh=lMtDDwjMzEvoyqQbFczBqC9w3VNXar/Xa5HXpkj92t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBrSmCzsWwlIzPP7Zt5jknMkk8Ut0OO8sVnlvm5RPGIpHv6QxdakolwKRK7A8oil84W2jBNxEaBjMfbmDD26SDBo0vOLFeGnDDOD8B2jQc/75DpyiuQE6IvDgLi925m8zWnkNoSKSXL2L2wtrKiI+nOXkZCrrqCsM4rQWu1a4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwZkJV8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94967C4AF0C;
	Thu,  1 Aug 2024 00:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471954;
	bh=lMtDDwjMzEvoyqQbFczBqC9w3VNXar/Xa5HXpkj92t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwZkJV8aTZIevwSfuoTqbcHVmvKfIpw+r4eMpAGwzgDjjg79yf6fOalstisRY7+fB
	 ZdLVFHbhpPw4v0OEZb/E1xdl9iCf2AaPsZ0HrUSFMsGboqc6CbxPK8wQI0NOChDIbQ
	 xerzq3168ZqUTE44eGeuDa2a9hvmBwqC6Xb2KgS3x+6DmL6vZTdW8fuU/MhE9+1aJ6
	 NM5g2F7yYKd5NyNpXXhrycEDZnQN93vaP4/eWq6RRHZ4fgowzDO8AXw95HMKwI2KDi
	 foVHJ5pS5QqdDMwskoWJ72pxHC9V9BpDKf/uVAIlGgSgWFKTAdhMRU9qc3KJof3dSW
	 3i8qqIbRxD6rw==
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
Subject: [PATCH AUTOSEL 6.6 72/83] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:18:27 -0400
Message-ID: <20240801002107.3934037-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 375200e9aba9a..2ba4e0d4e26b0 100644
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


