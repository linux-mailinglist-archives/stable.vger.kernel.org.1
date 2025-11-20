Return-Path: <stable+bounces-195213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A99EC719B9
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 01:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C30DC34D0A8
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F313957E;
	Thu, 20 Nov 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I1rqVVGf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9856F2F2
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599809; cv=none; b=lgXSJIF2LDsxKFt5cCXD5YGzLbxO19wjsjs4yku58g/EEcYxLAt4LGldy0EKHYN4bl4tmw4sa1HNfBBvwO3ZpJeKgiLpd1XaPl2SaOOOv5FUnc6KwUIvajKywYDxke+aGN97Xr/oJQSub+SiOl0XX1g1ZorKyYnOCbvkCFb7eUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599809; c=relaxed/simple;
	bh=ViT1lghG8J8QIA9ZSDab0bZu2pW2FVQEhrwAZRyQlAI=;
	h=Date:To:From:Subject:Message-Id; b=X+KI3HLov0YQghZBpnDb9ipseh3QnJ9fw0wL6n1AHOxJATHRTrKBqShSxtODggDBmbS1tkDK+gLKeTignqaScrFon1wyWav+1UzT85ZmvfEk2ufL8VdSm2izSRtP7uB7Q2j+IW1Np17ZE60w8g0dFRSrpcWSebqsk8UZHKoNhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I1rqVVGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE61C4CEF5;
	Thu, 20 Nov 2025 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763599809;
	bh=ViT1lghG8J8QIA9ZSDab0bZu2pW2FVQEhrwAZRyQlAI=;
	h=Date:To:From:Subject:From;
	b=I1rqVVGf3Z2+1ypGOBn4w1H6gEMQfbO5gr9Jx0dhAzKzZ3grCIAX6RCilr9IxAAc5
	 jSqceP9osVoXCC6tDFkdeP3yi+xIKayJotgTNguIeACiiFGwaRO2o5xuyp89Z8YsEr
	 nLzi7C3sZ6vRWlY6im3m9Dk6GAWF6R7716hRmCkU=
Date: Wed, 19 Nov 2025 16:50:08 -0800
To: vschneid@redhat.com,vincent.guittot@linaro.org,vbabka@suse.cz,surenb@google.com,stable@vger.kernel.org,rppt@kernel.org,rostedt@goodmis.org,peterz@infradead.org,mingo@redhat.com,mhocko@suse.com,mgorman@suse.de,lorenzo.stoakes@oracle.com,Liam.Howlett@oracle.com,legion@kernel.org,kees@kernel.org,juri.lelli@redhat.com,ebiederm@xmission.com,dietmar.eggemann@arm.com,bsegall@google.com,ptikhomirov@virtuozzo.com,akpm@linux-foundation.org,brauner@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 1/1] unshare: fix nsproxy leak on set_cred_ucounts() error path
Message-Id: <20251120005009.4FE61C4CEF5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: unshare: fix nsproxy leak on set_cred_ucounts() error path
Date: Tue, 18 Nov 2025 14:45:50 +0800

If unshare_nsproxy_namespaces() successfully creates the new_nsproxy, but
then set_cred_ucounts() fails, on its error path there is no cleanup for
new_nsproxy, so it is leaked.  Let's fix that by freeing new_nsproxy if
it's not NULL on this error path.

Link: https://lkml.kernel.org/r/20251118064552.936962-1-ptikhomirov@virtuozzo.com
Fixes: 905ae01c4ae2a ("Add a reference to ucounts for each cred")
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Acked-by: Alexey Gladkov <legion@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mel Gorman <mgorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/fork.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/fork.c~unshare-fix-nsproxy-leak-on-set_cred_ucounts-error-path
+++ a/kernel/fork.c
@@ -3133,8 +3133,11 @@ int ksys_unshare(unsigned long unshare_f
 
 	if (new_cred) {
 		err = set_cred_ucounts(new_cred);
-		if (err)
+		if (err) {
+			if (new_nsproxy)
+				free_nsproxy(new_nsproxy);
 			goto bad_unshare_cleanup_cred;
+		}
 	}
 
 	if (new_fs || new_fd || do_sysvsem || new_cred || new_nsproxy) {
_

