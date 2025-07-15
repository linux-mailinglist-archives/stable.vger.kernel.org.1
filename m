Return-Path: <stable+bounces-163027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF7BB06753
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 21:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B014E80EA
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 19:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC8526FD8E;
	Tue, 15 Jul 2025 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgzB3jOL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60B26FA62;
	Tue, 15 Jul 2025 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609388; cv=none; b=sMNZeMG/KWvZgQ9dNlHWCbvJpoLeCxlxTsg33be12g1EecZmDOJNShH2DzqQ0CgZPriSd4UOtTn5ykFvoNFCUgbRcXpJMyYwRGjzgGecrZPI/CyQRQ0ksBbuKNjhn6PQb5LiUuuDGadi1Ax2wgQ9iLl9ok4E73sz72rKI2NMQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609388; c=relaxed/simple;
	bh=oAy6A6mELtflf/ApVsSLfMjrB+jaFLQJRW6V2oKwI9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S2LpNOXd5UvMTlBUMNy0pu7Dj8YMVZmmq/zX000JCeGubUcY2NGiFCTsDOyHim/XbImLNC/vHmuigohvKJMctIGWVHHHBzWkII8Sk5jzR0HmTGTwftSmDwMTOQAnSeXXYGfWGhcLNDA2cCrgWFEyLwbUWvLZIo9p5wGQKqx3JCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgzB3jOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01F3C4CEF6;
	Tue, 15 Jul 2025 19:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752609387;
	bh=oAy6A6mELtflf/ApVsSLfMjrB+jaFLQJRW6V2oKwI9w=;
	h=From:Date:Subject:To:Cc:From;
	b=tgzB3jOLILsMd5Nq1+AeB7fzwTKZbi2dG5oK9hGRT+f5vSZ7FOKVd8+H4JnjaycgS
	 yVGnhLH6vPLSKJO4CcaJEpmHdMbZbAgfAVFHyv+E6GkhnbzOf+YnFGuYIfN2ZwoNVw
	 OyvRR1sD5aUlwcUtxn0AsolDXfijyGLkH00x/rXVRsk3i+JUgowH2DbQeO/xgaCz2s
	 sZec0lJl3UPyobGz7l41emiZZYJwIQur5mygIw0nCcA41KoCQcwehlYAzOUv3NARQr
	 UQMNkkprofauGKv8ki3WHsr/nt1fdyLGJwKyPm/2QpRc1JRRemF9HmeQg/eq6X2jTo
	 UvydW2T4/HH8A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 15 Jul 2025 12:56:16 -0700
Subject: [PATCH] mm/ksm: Fix -Wsometimes-uninitialized from clang-21 in
 advisor_mode_show()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-ksm-fix-clang-21-uninit-warning-v1-1-f443feb4bfc4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF+ydmgC/x2NSwqAMAxEryJZG7CFqngVcVFr1KBWaf2BeHeDu
 3nMY+aBSIEpQpU8EOjkyKsXUGkCbrR+IOROGHSmTVYog1NcsOcb3SwtaoWHZ887XjZIGLAla2z
 elmXuCGRlCyT6/1A37/sBzADgAnEAAAA=
X-Change-ID: 20250715-ksm-fix-clang-21-uninit-warning-bea5a6b886ce
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
 Chengming Zhou <chengming.zhou@linux.dev>
Cc: Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; i=nathan@kernel.org;
 h=from:subject:message-id; bh=oAy6A6mELtflf/ApVsSLfMjrB+jaFLQJRW6V2oKwI9w=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBllmzIz57sqnMziE1A98Fp66YRVHkU7okRCwluTPI4Kz
 zxq3juno5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAExkyzGG3yxLets5X3ExBGYX
 aT6U8IovseB75PP+lLDu1A2X52nzBzMyPObz322U2x/5at2J+w37W/muCzrzvNj+o+Mfi1nOxQV
 63AA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent change in clang to expose uninitialized warnings from
const variables [1], there is a warning from the if statement in
advisor_mode_show().

  mm/ksm.c:3687:11: error: variable 'output' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
   3687 |         else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  mm/ksm.c:3690:33: note: uninitialized use occurs here
   3690 |         return sysfs_emit(buf, "%s\n", output);
        |                                        ^~~~~~

Rewrite the if statement to implicitly make KSM_ADVISOR_NONE the else
branch so that it is obvious to the compiler that ksm_advisor can only
be KSM_ADVISOR_NONE or KSM_ADVISOR_SCAN_TIME due to the assignments in
advisor_mode_store().

Cc: stable@vger.kernel.org
Fixes: 66790e9a735b ("mm/ksm: add sysfs knobs for advisor")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2100
Link: https://github.com/llvm/llvm-project/commit/2464313eef01c5b1edf0eccf57a32cdee01472c7 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 mm/ksm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2b0210d41c55..160787bb121c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3682,10 +3682,10 @@ static ssize_t advisor_mode_show(struct kobject *kobj,
 {
 	const char *output;
 
-	if (ksm_advisor == KSM_ADVISOR_NONE)
-		output = "[none] scan-time";
-	else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
+	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
 		output = "none [scan-time]";
+	else
+		output = "[none] scan-time";
 
 	return sysfs_emit(buf, "%s\n", output);
 }

---
base-commit: fed48693bdfeca666f7536ba88a05e9a4e5523b6
change-id: 20250715-ksm-fix-clang-21-uninit-warning-bea5a6b886ce

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


