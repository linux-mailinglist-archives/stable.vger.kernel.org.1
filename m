Return-Path: <stable+bounces-44876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971828C54C5
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D6D1C23710
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C66EB45;
	Tue, 14 May 2024 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0xf+Dyuc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3A54903;
	Tue, 14 May 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687434; cv=none; b=DdBZtXU1KBnr/HBh4/7zs4wKxnK5Wjxzg84t3tjVk2pqGMrrS/mbfKznI2yuYv5rH+LZWzQqdzeIpTbuLMXNIbVyd6H/A6PUPPZOJeHUdGDeP6z2UoHVV3siLOSsfBtAQKdS6pfF3MWv4mJsUesFaDysI1ZufO8I5mIBjpWEZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687434; c=relaxed/simple;
	bh=THcLFfwniJoCmmI2WO8C3v/z8k1yEuQkL13irXc03+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoWTeJRN394oyxxuSAoUFTlo2JRXdYFKfBp3p+xEAchQJ2EYpSkeHXz6YYTrGngP3WHGX6koJCSqvklKFpGfnp1dSxOHu2LCiSzq+5+rtAzrmhyNT6Xop6mcnLbYYejDJbS/TJ3jKamq7EN19f+8dZ+7+WIgEk/EePPzVjvzRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0xf+Dyuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC7BC2BD10;
	Tue, 14 May 2024 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687433;
	bh=THcLFfwniJoCmmI2WO8C3v/z8k1yEuQkL13irXc03+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0xf+DyucJydogLeo31QaCB2+oBGJupCzO0E9iF1xtwQ1z8XA/Icd6q5fFMplXtz7s
	 RtTnn6JhvLkzyzQusP8eeOGCDh7+BdKteJmZkouclXSdaIl+aCWemwje0IeDNJ3G1b
	 +IKW0N3LfozoGLvvuE+wzLPqLYrrc0gQTKn9F6gg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lee Jones <joneslee@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 063/111] selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior
Date: Tue, 14 May 2024 12:20:01 +0200
Message-ID: <20240514100959.529106960@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Stultz <jstultz@google.com>

[ Upstream commit 076361362122a6d8a4c45f172ced5576b2d4a50d ]

The struct adjtimex freq field takes a signed value who's units are in
shifted (<<16) parts-per-million.

Unfortunately for negative adjustments, the straightforward use of:

  freq = ppm << 16 trips undefined behavior warnings with clang:

valid-adjtimex.c:66:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
        -499<<16,
        ~~~~^
valid-adjtimex.c:67:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
        -450<<16,
        ~~~~^
..

Fix it by using a multiply by (1 << 16) instead of shifting negative values
in the valid-adjtimex test case. Align the values for better readability.

Reported-by: Lee Jones <joneslee@google.com>
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20240409202222.2830476-1-jstultz@google.com
Link: https://lore.kernel.org/lkml/0c6d4f0d-2064-4444-986b-1d1ed782135f@collabora.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/timers/valid-adjtimex.c | 73 +++++++++----------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 48b9a803235a8..d13ebde203221 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -21,9 +21,6 @@
  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *   GNU General Public License for more details.
  */
-
-
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
@@ -62,45 +59,47 @@ int clear_time_state(void)
 #define NUM_FREQ_OUTOFRANGE 4
 #define NUM_FREQ_INVALID 2
 
+#define SHIFTED_PPM (1 << 16)
+
 long valid_freq[NUM_FREQ_VALID] = {
-	-499<<16,
-	-450<<16,
-	-400<<16,
-	-350<<16,
-	-300<<16,
-	-250<<16,
-	-200<<16,
-	-150<<16,
-	-100<<16,
-	-75<<16,
-	-50<<16,
-	-25<<16,
-	-10<<16,
-	-5<<16,
-	-1<<16,
+	 -499 * SHIFTED_PPM,
+	 -450 * SHIFTED_PPM,
+	 -400 * SHIFTED_PPM,
+	 -350 * SHIFTED_PPM,
+	 -300 * SHIFTED_PPM,
+	 -250 * SHIFTED_PPM,
+	 -200 * SHIFTED_PPM,
+	 -150 * SHIFTED_PPM,
+	 -100 * SHIFTED_PPM,
+	  -75 * SHIFTED_PPM,
+	  -50 * SHIFTED_PPM,
+	  -25 * SHIFTED_PPM,
+	  -10 * SHIFTED_PPM,
+	   -5 * SHIFTED_PPM,
+	   -1 * SHIFTED_PPM,
 	-1000,
-	1<<16,
-	5<<16,
-	10<<16,
-	25<<16,
-	50<<16,
-	75<<16,
-	100<<16,
-	150<<16,
-	200<<16,
-	250<<16,
-	300<<16,
-	350<<16,
-	400<<16,
-	450<<16,
-	499<<16,
+	    1 * SHIFTED_PPM,
+	    5 * SHIFTED_PPM,
+	   10 * SHIFTED_PPM,
+	   25 * SHIFTED_PPM,
+	   50 * SHIFTED_PPM,
+	   75 * SHIFTED_PPM,
+	  100 * SHIFTED_PPM,
+	  150 * SHIFTED_PPM,
+	  200 * SHIFTED_PPM,
+	  250 * SHIFTED_PPM,
+	  300 * SHIFTED_PPM,
+	  350 * SHIFTED_PPM,
+	  400 * SHIFTED_PPM,
+	  450 * SHIFTED_PPM,
+	  499 * SHIFTED_PPM,
 };
 
 long outofrange_freq[NUM_FREQ_OUTOFRANGE] = {
-	-1000<<16,
-	-550<<16,
-	550<<16,
-	1000<<16,
+	-1000 * SHIFTED_PPM,
+	 -550 * SHIFTED_PPM,
+	  550 * SHIFTED_PPM,
+	 1000 * SHIFTED_PPM,
 };
 
 #define LONG_MAX (~0UL>>1)
-- 
2.43.0




