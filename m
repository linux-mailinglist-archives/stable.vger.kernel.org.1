Return-Path: <stable+bounces-78634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E9C98D16E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267B01C21BA3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BBE1E764C;
	Wed,  2 Oct 2024 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHXCvHI/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCD1E7646
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865570; cv=none; b=UhrvGeu5lFmNYWBcoPD/5K4rE3KiJ2e3iZmB8RERK8dkFwPq2oJ5/KndhOjnSfDn1bWeRr+FAqLMgWEKTciDA91JFTGVjHW1/azHW+mfI/2/I26hGU/ipDrNH5YUK0PEp27dRro4Rh6otdA0nznxf0BQ9I4K6LkxNH8W3tFTD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865570; c=relaxed/simple;
	bh=hAWlAejjYeeyLmIQezkD8FIPCHLp4Xq2t97l4gFun1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFpHRUsxNh5nLV0S03ClFP0zbU8Rt1FChRGMQDrIc6ch9Wg/A1G3a1ecy/7Hn7mH35vRUfWIGIpVkSThWFYVXcT4g9BmgrB8uNzzGBsuFtgWBb4RBy5/Q+A4yEcao0rPNpg3Gq0vs6B/iwJW24e0M0G6avpxtQ95vpR9YtOZRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHXCvHI/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727865567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Juwea2KXG/dxe46pCjYOQbI9mJQSMUi0QeoYayyGqCY=;
	b=AHXCvHI/RSvikzJ/YJRVdER7jzjXS8fyMVKsRfyG04dGd8s99h2r367Gyfj87JiXl99pm7
	WJkW/e1+TSIvwFJlesl9PL3C+sHht4O1jwMmkxgvbd/clo33BmD1Uqbq1Pmq9VT23zIKUG
	TISjkGQcMv8jZZXhNVN+c2RygoDkBvU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-UC07f9asP5y_Mhwif-Y_nQ-1; Wed,
 02 Oct 2024 06:39:26 -0400
X-MC-Unique: UC07f9asP5y_Mhwif-Y_nQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA46B1955D5A;
	Wed,  2 Oct 2024 10:39:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.196])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 675B519560A3;
	Wed,  2 Oct 2024 10:39:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Oct 2024 12:39:10 +0200 (CEST)
Date: Wed, 2 Oct 2024 12:39:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: gregkh@linuxfoundation.org
Cc: andrii@kernel.org, jolsa@kernel.org, peterz@infradead.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] bpf: Fix use-after-free in
 bpf_uprobe_multi_link_attach()" failed to apply to 6.11-stable tree
Message-ID: <20241002103905.GC27552@redhat.com>
References: <2024100247-spray-enjoyable-b1d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <2024100247-spray-enjoyable-b1d0@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

On 10/02, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 6.11-stable tree.

Please see the attached patch. Should work for 6.11 and the previous versions.

Oleg.

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-bpf-Fix-use-after-free-in-bpf_uprobe_multi_link_atta.patch"

From 69238e2134d57bd7d55c02e1e19fcea75121f21c Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 19 Sep 2024 15:28:53 +0200
Subject: [PATCH -stable] bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()

commit 5fe6e308abaea082c20fbf2aa5df8e14495622cf upstream.

If bpf_link_prime() fails, bpf_uprobe_multi_link_attach() goes to the
error_free label and frees the array of bpf_uprobe's without calling
bpf_uprobe_unregister().

This leaks bpf_uprobe->uprobe and worse, this frees bpf_uprobe->consumer
without removing it from the uprobe->consumers list.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Closes: https://lore.kernel.org/all/000000000000382d39061f59f2dd@google.com/
Reported-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240813152524.GA7292@redhat.com
---
 kernel/trace/bpf_trace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..af7669a70f2b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3485,17 +3485,20 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 					     uprobes[i].ref_ctr_offset,
 					     &uprobes[i].consumer);
 		if (err) {
-			bpf_uprobe_unregister(&path, uprobes, i);
-			goto error_free;
+			link->cnt = i;
+			goto error_unregister;
 		}
 	}
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto error_free;
+		goto error_unregister;
 
 	return bpf_link_settle(&link_primer);
 
+error_unregister:
+	bpf_uprobe_unregister(&path, uprobes, link->cnt);
+
 error_free:
 	kvfree(uprobes);
 	kfree(link);
-- 
2.25.1.362.g51ebf55


--nFreZHaLTZJo0R7j--


