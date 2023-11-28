Return-Path: <stable+bounces-2979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05F57FC6F8
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AF5286C0E
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91942A96;
	Tue, 28 Nov 2023 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcWvhUWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2C44367
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 21:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC2BC433C7;
	Tue, 28 Nov 2023 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205648;
	bh=qSIOZxomh9bqGqVlenPpEsVcBxrve1a1I35FfYRsidw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcWvhUWltC6MD21iyFocM32U5tv8iU8jBPFvk6Q7w+Nj3hXLjPDEH84+oVaW9VdQh
	 mAPEUJYcf/j3LBsJziKnc7JqtJPGXCFoTbrhR1h7AEsirGFIest594QeCIVN8npsBA
	 eiDySeWlv+DutR1oDh0sHnUGBx24IHyXyUb9mJ5tINynSQNcBjoGd2s1knXNubXvTE
	 VP5kNMoLF/ua8KMJWQ3ALqOckNULPfjrMwXE1BQmdkjw6o8hk/nrkhfrdd0QGjF4iw
	 sUrWazbo8Pk3nCOR1SC2LJfis1QEE/o0O2Sl07aq+FJV4mO/KaNqJ8PbYZWDwOEWIG
	 KH6RWCimd0TJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	glaubitz@physik.fu-berlin.de,
	rdunlap@infradead.org
Subject: [PATCH AUTOSEL 6.6 33/40] scripts/checkstack.pl: match all stack sizes for s390
Date: Tue, 28 Nov 2023 16:05:39 -0500
Message-ID: <20231128210615.875085-33-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit aab1f809d7540def24498e81347740a7239a74d5 ]

For some unknown reason the regular expression for checkstack only matches
three digit numbers starting with the number "3", or any higher
number. Which means that it skips any stack sizes smaller than 304
bytes. This makes the checkstack script a bit less useful than it could be.

Change the script to match any number. To be filtered out stack sizes
can be configured with the min_stack variable, which omits any stack
frame sizes smaller than 100 bytes by default.

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/checkstack.pl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 84f5fb7f1cecc..d83ba5d8f3f49 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -97,8 +97,7 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 		#   11160:       a7 fb ff 60             aghi   %r15,-160
 		# or
 		#  100092:	 e3 f0 ff c8 ff 71	 lay	 %r15,-56(%r15)
-		$re = qr/.*(?:lay|ag?hi).*\%r15,-(([0-9]{2}|[3-9])[0-9]{2})
-		      (?:\(\%r15\))?$/ox;
+		$re = qr/.*(?:lay|ag?hi).*\%r15,-([0-9]+)(?:\(\%r15\))?$/o;
 	} elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
 		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
 		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
-- 
2.42.0


