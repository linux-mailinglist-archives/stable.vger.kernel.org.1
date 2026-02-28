Return-Path: <stable+bounces-220117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHboGdApo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55681C5143
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2C0C30F4A75
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C55B480323;
	Sat, 28 Feb 2026 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUkIuBlh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC233A9D1;
	Sat, 28 Feb 2026 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300028; cv=none; b=G0DFRerakwKgrVD4IaJGkjqjoZcqoonVQC3X+Chd3dHO5oQXU1KkHzPjCC+nZtFtJhHb0epu72TdqW1daLI+dDS9qVBbR/VhiTsSSHTS4NP7zlyry+6cPx65FBlFNXOgpF73psUJH2jdxpMUQ/XzCIR4m5+tuo6PGe6/5WJ0i2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300028; c=relaxed/simple;
	bh=OuM3R714gkSYXJVa0MHO55s0U6lgQYUyrnpXyQvuiPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVHxdu4WN3oWS3Cr/BKbHJnUu6GlSDKxdPbRPdiXEA+9O09AkjC9G41coW/mnGExCC+8uGp9ZgpkDgKafjD/rWR1OEQG8FtgzVYXgQd8yyUu+mnTt5/JL418EbNxAltWK0l0laMgc6KUAaTOPR70hZ0WRXU/rvU1rvn11Vhn9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUkIuBlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41525C19423;
	Sat, 28 Feb 2026 17:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300027;
	bh=OuM3R714gkSYXJVa0MHO55s0U6lgQYUyrnpXyQvuiPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUkIuBlhp0Mzxet/p4bMXjAfkqVwqPx9S9f2c+NYI4p1doDuxaHTwlw5mqc7f6/oD
	 jIyfKoS8kE0ASgejnx7yQXhnne8ECU1sj5EMfhXZhyprAAfk1TwpLPmOiqFt4pRTea
	 JcVyJjSkZrxjyeJ0qdeaATXAvOCTgDVhj+x1Nkh0VtQWDnEIFt74gCkuc3whPoWr0J
	 zfKfcxLuntLiXz9CYwRUgbSv80c2mbYQXTKrYLYB4NJbjBvQx5BlVet9ZMJjq0kOjI
	 Pz10RisqBHKljcMDYSDtjt+trgQtLZJ89RZxCqj81mOJz1ExRQieA6HLVN4Y+OiTjF
	 esgRhwqO8gWyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Clint George <clintbgeorge@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 039/844] kselftest/kublk: include message in _Static_assert for C11 compatibility
Date: Sat, 28 Feb 2026 12:19:12 -0500
Message-ID: <20260228173244.1509663-40-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220117-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D55681C5143
X-Rspamd-Action: no action

From: Clint George <clintbgeorge@gmail.com>

[ Upstream commit 3e6ad272bb8b3199bad952e7b077102af2d8df03 ]

Add descriptive message in the _Static_assert to comply with the C11
standard requirement to prevent compiler from throwing out error. The
compiler throws an error when _Static_assert is used without a message as
that is a C23 extension.

[] Testing:
The diff between before and after of running the kselftest test of the
module shows no regression on system with x86 architecture

[] Error log:
~/Desktop/kernel-dev/linux-v1/tools/testing/selftests/ublk$ make LLVM=1 W=1
  CC       kublk
In file included from kublk.c:6:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from null.c:3:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from file_backed.c:3:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from common.c:3:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from stripe.c:3:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from fault_inject.c:11:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
make: *** [../lib.mk:225: ~/Desktop/kernel-dev/linux-v1/tools/testing/selftests/ublk/kublk] Error 1

Link: https://lore.kernel.org/r/20251215085022.7642-1-clintbgeorge@gmail.com
Signed-off-by: Clint George <clintbgeorge@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ublk/kublk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 8a83b90ec603a..cae2e30f0cdd5 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -223,7 +223,7 @@ static inline __u64 build_user_data(unsigned tag, unsigned op,
 		unsigned tgt_data, unsigned q_id, unsigned is_target_io)
 {
 	/* we only have 7 bits to encode q_id */
-	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
+	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7, "UBLK_MAX_QUEUES_SHIFT must be <= 7");
 	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
 	return tag | (op << 16) | (tgt_data << 24) |
-- 
2.51.0


