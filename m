Return-Path: <stable+bounces-223028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC01LgYRqGk8ngAAu9opvQ
	(envelope-from <stable+bounces-223028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:01:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03EC1FEA1C
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4960F3033537
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF271390219;
	Wed,  4 Mar 2026 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nd8woyYt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482E344D92
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622081; cv=none; b=JQtDmza8pqVy8huDo0L+ieTeek2rzp5Ar/jharuzerSqMUU+nzPRPXLBCfLxS8WUqAFzdSujVzcilwXbC7VsHR0Wm8VpH5tpnCSCJdWaRL+3EwqV/gOl7YJAKm/c4kuSEZL7sZx0JZ2Kbe7o6gLnOWWEAVXuefUBv/4Xk4itT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622081; c=relaxed/simple;
	bh=cKZR252fdSUvuNQFUcCBTUoWI0/zB/XocAsUnuIVaDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k1n4KV5oN0pDkjNyWHlb7rNQ1jEYWpApRWWw8q4R/5ZxJ/7NAIE99MZ3BbM8TtsBssAIXS8rkLwLbOReNjBodEUzG/Mv5sc2unhy0oQCRrIEPtUmvHmPRH6bvhCv51mcDsxxrfTnbY2sWn4yIDYMsdm/k+LtjpBAGvTwyk8mDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nd8woyYt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3595485abbbso5285660a91.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 03:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772622080; x=1773226880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3xCIEoo6ZEEEZ/p1n43Fi5RBMS2/xMTyiLoj4cZCz8=;
        b=nd8woyYtgioWNbyvQxS0KGuakq0aQHJVOhxn4GD3Fi9wU9x+VVDkzo4Z5jfaoYFx3g
         yRb+gTezV1rUwfcIhWZ2ffEBi1DYlyalaGx2SAoAVCz32HQu8eZtUUj62VttOB/hqtr4
         PJlNZw+DFqAgltOWTYMfTt+g66/+9lTCOHYvkQ64PZKVpuyY5OF23yGLpZPJNtg2Ueky
         KT21FXFQuNdPKF0cuOZLrm9Ax12EQ65ZqkdUhlO6PFdfCxvwCcEjdfJXUF80z7z4/lXk
         l3vI3b56BjR6wdv4OjBHELchjHBRf5dGsSNFFS1PGYvBTvFJI94GOExvRvlyrRBudcys
         EYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772622080; x=1773226880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3xCIEoo6ZEEEZ/p1n43Fi5RBMS2/xMTyiLoj4cZCz8=;
        b=ifaqYkOWQ7aS4J9IGA2NwCC9ehYpvTrbfIOp4D0Is0Skz2WkespOzf104BX7WMMZnh
         vBLC+Pse1TTPQ+nXLfCJYUVHb3UYGWUI/ZQYUIkNSL+C5iaCWcbLJnLL4Lys/+qd+/yy
         B/eEgyk+ec2ETjtfOe/dQBPSiV5quprVc8FLGLb9Kr+orYE+LGFf5jvV8aNlLiOhp8KK
         zg2BCTZJBa6HlyvH81N4ZNrJZwUnm9UusRjQKeBYUzEv6jfJBwNOdjVA1MozHhfUgT+4
         YJ8DlaABddfMCdEje6L7oifNycoPhfLxykq7ltCS6vVmcuOwlB21Eh77LPebaiP/fKcL
         d6jw==
X-Forwarded-Encrypted: i=1; AJvYcCUxbVIxgAMOi44RkIRMexYv/fYQB/z8Cda2sx4qOxWzU/okm8Aeym9cvMo7CJEwxcCdO/dU+QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxEX/wOz1CiEuiGNm5FY1pADbM0G0Mp8623Mg06cjHaaduFJA
	CAu2OhftZqQOTfezLLyG3MlIFDOiddg+YUzmpuTudNRE1qD/hO8LwTK4ZKJ8oNMdivhhEiVQ2xB
	phXUEtHgwsq4DgB+iQyCzJZ0y/w==
X-Received: from pga3.prod.google.com ([2002:a05:6a02:4f83:b0:c6d:c043:2cb4])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:164c:b0:359:84e1:ba2e with SMTP id 98e67ed59e1d1-359a6a4a3a4mr1598087a91.18.1772622079611;
 Wed, 04 Mar 2026 03:01:19 -0800 (PST)
Date: Wed,  4 Mar 2026 11:01:17 +0000
In-Reply-To: <2026030417-shudder-value-27ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026030417-shudder-value-27ca@gregkh>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304110117.3317293-1-joonwonkang@google.com>
Subject: Re: [PATCH] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: gregkh@linuxfoundation.org
Cc: jassisinghbrar@gmail.com, joonwonkang@google.com, 
	linux-kernel@vger.kernel.org, sashal@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C03EC1FEA1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223028-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

>> [ Upstream commit fcd7f96c783626c07ee3ed75fa3739a8a2052310 ]
>> 
>> Although it is guided that `#mbox-cells` must be at least 1, there are
>> many instances of `#mbox-cells = <0>;` in the device tree. If that is
>> the case and the corresponding mailbox controller does not provide
>> `fw_xlate` and of_xlate` function pointers, `of_mbox_index_xlate()` will
>> be used by default and out-of-bounds accesses could occur due to lack of
>> bounds check in that function.
>> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Joonwon Kang <joonwonkang@google.com>
>> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
>> [ changed sp->nargs to sp->args_count in the code and
>> fw_mbox_index_xlate() to of_mbox_index_xlate() in the commit message. ]
>> Signed-off-by: Joonwon Kang <joonwonkang@google.com>
>> ---
>>  drivers/mailbox/mailbox.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>
>What kernel tree(s) is this for?

Sorry, please ignore this patch. I have specified the proper kernel tree
in other patches.

Thanks.

