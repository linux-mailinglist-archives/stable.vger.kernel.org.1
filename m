Return-Path: <stable+bounces-92568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1919C5623
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F74B3EDA4
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E83B1FFC61;
	Tue, 12 Nov 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CD74oqDB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8BB1FFC52;
	Tue, 12 Nov 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407895; cv=none; b=dRAeP5rwpLZpXlHCn+a123i8TWtnmbCBeJS18cUg0QLohWe23VhmvwFD3T2JPLjwUzdMG2aXruRAJOL50H2GbPnfCuxbPKbASJqKgRY/9Dn6T+ezubdR84IllxrIOIJYLSBaxhSdBHoYAzr5tb9xYiUTLbLNHuYS6VRNnRQBBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407895; c=relaxed/simple;
	bh=lhxL405+BOf8GaQ65S0M82xCobfPR2s+mT/xcvWR78o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc+Oy6kCKjuvqD8+SMQigu/NmGTGj/epKjWkDzEcULcO4YhmZG7JJ21mTT8oD88fI1wTZp3wNBHeLe/qGk0KY+4fBE4Lz7WRBzXo7QtWxiFvJ4cxhKqNySL2yn6j0sMQnylDI+KZ2QycXNxxxUXQXIBW+eXwiA0fMu0VgDLa/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CD74oqDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6E1C4CECD;
	Tue, 12 Nov 2024 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407895;
	bh=lhxL405+BOf8GaQ65S0M82xCobfPR2s+mT/xcvWR78o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CD74oqDBhsvFe+kub58eqDBfp5EgRHMM4Py4wLmKJLNs57ZT6Tymb2ORYyPSgua3v
	 GtT2SCXEh6KlWYqY8SfT4/H0CptPHttCugeljvf+NuKVef9Vl6H8VmFrV0b3InSWkJ
	 hWjJBMeqKuryr+CV49KiMPnNoCUxM2IGqbErSjYs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrei Vagin <avagin@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Alexey Gladkov <legion@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 116/119] ucounts: fix counter leak in inc_rlimit_get_ucounts()
Date: Tue, 12 Nov 2024 11:22:04 +0100
Message-ID: <20241112101853.149164576@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrei Vagin <avagin@google.com>

commit 432dc0654c612457285a5dcf9bb13968ac6f0804 upstream.

The inc_rlimit_get_ucounts() increments the specified rlimit counter and
then checks its limit.  If the value exceeds the limit, the function
returns an error without decrementing the counter.

Link: https://lkml.kernel.org/r/20241101191940.3211128-1-roman.gushchin@linux.dev
Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
Signed-off-by: Andrei Vagin <avagin@google.com>
Co-developed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Tested-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Alexey Gladkov <legion@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Andrei Vagin <avagin@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/ucount.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -319,7 +319,7 @@ long inc_rlimit_get_ucounts(struct ucoun
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
 		long new = atomic_long_add_return(1, &iter->rlimit[type]);
 		if (new < 0 || new > max)
-			goto unwind;
+			goto dec_unwind;
 		if (iter == ucounts)
 			ret = new;
 		if (!override_rlimit)
@@ -337,7 +337,6 @@ long inc_rlimit_get_ucounts(struct ucoun
 dec_unwind:
 	dec = atomic_long_sub_return(1, &iter->rlimit[type]);
 	WARN_ON_ONCE(dec < 0);
-unwind:
 	do_dec_rlimit_put_ucounts(ucounts, iter, type);
 	return 0;
 }



