Return-Path: <stable+bounces-238252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MUtJpJ24GkfhQAAu9opvQ
	(envelope-from <stable+bounces-238252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:41:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B23840A6BD
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09116303B4CB
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9571EEE6;
	Thu, 16 Apr 2026 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyAxBYNG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002933F595
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776317958; cv=none; b=ltHgS8Gle8Hbh9CR27UaxYUt1hiBjxrO/jzNhgfnS2Hu9Bd7Ymh4fLIjdQheEgKyXO0eIYFSBrCD/R1Wviplfxm5w4keK+ZV+8Elvxt9KDUWU7pX1I4nxghG8K6TtCm6tSMqP9BFnbEpCOyq3sIIqaSAi9wQRyJNwj2lgv5CZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776317958; c=relaxed/simple;
	bh=N0T590H9heaCHgH2KW+HuYix7auOVSrFYd7ngm6UIiY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=hxLrnTNwlWLtl6FEml36A8RXt9hPJlWFBk9mmiznuk1aSKJjn4v+UDP4DOZwulWElAz7Q6HBXSl7ksfNHtza3l+6apJOBtQ+UKhmg2c83wTfH+U6D0KX0WtRyZUWOqJQLemlOYf4qyTILoWj4uOLhjarpPyml9QqVeNLOYTeiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyAxBYNG; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50bbc41677dso103043871cf.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776317955; x=1776922755; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0T590H9heaCHgH2KW+HuYix7auOVSrFYd7ngm6UIiY=;
        b=gyAxBYNGO0944S9MKltImXjBJfUVrj2z22Kf4X/6PQ8oRHX98V+ApLFx7XHh7HrUaN
         lRooy+ms32oAXcHmeDQuZGdHdaQkyLiSGiR5L5hAjAMXcvTmTAZbCuuZjKkej0z477id
         1Zwb4gNFbX144sCb1LlNdpJHMQ9Y2kNsKQ/TOfaDRZEojYqBI6Jsj762nfPelHKWA/EF
         hxBVECjqr3whsNf969/qvCXdGng0azx64lcs0RuOAxXGBLcPSozryAq6JuU6NoLfZaPN
         qmpQWEZNh45nKABKnF2QdP9g4duwk6J0K0+YDLnf2FWqI6FiivS6lC71pse9QL3+Pi+E
         fDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776317955; x=1776922755;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0T590H9heaCHgH2KW+HuYix7auOVSrFYd7ngm6UIiY=;
        b=DIZSOiarRm0KIKDh8I8QjtSL2wl3ss42pQSmAruP5Y2C3pf1znX1AUi3pxKNY8zhz6
         939IV1ZdeR4pgbvy6SX3Dhpvza1FBtYxgqnadpL8Mn8s0p2luDb6sLL6NurPwpKKzdge
         ZXhxBJ/iaUlfI1wJr62iRq3dU73+7WuuoAuBaFMw7edf6Wdg8d4yKOdeU6qqQw7Vdz7T
         gHzrBOw9O27IyljgLrdBNus7a3PxFIuB2Mja/CB835mVLKVdUtryKE7mrMtwyceScNko
         pr57d7JMdJoYSCfL7E8Osw6LyGFxTHbJ8/QwLHXqiW6USX5bCRO4CU/Y4kAJlE3QwzyN
         T+5g==
X-Forwarded-Encrypted: i=1; AFNElJ+aWNZuATZLvbL9s6NY5CUBllvFkhtQEHO2JuS7es9565vgHxb/MTBYywNy1E5m6pGaWGfIhUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBGX3ktTEH+ZCGb5+Zj9Zl728hjeubAwsP1LmAXcRimJXJXtm
	QGsoPvMsiM7IgVO0LRI3dZFhTlIEnLMZKMIUKDSWwKujZy+xjyEpT5Y3
X-Gm-Gg: AeBDies372KpWyTGCAbtL8iF7m2+m6zeUJR5tbymQ/2AA+DCvgfcflKWw7oekJz3Cp4
	keAro/Co6Gs80cMo2eeRoUr1EsKLxt+QAX7KELLcoc/GsIZnlSQENKIcY91UQbV4rrquI6XUPfP
	vMLiLJgoZGdVA+sqxfOn3tVfcxAlzH7jM7nJLeJSwlUVTjDwJ6/ClVFZsXCnOqDjVy0c+zk3xGp
	Oi+uDOV1CQ1MAF6Pv1KXgyozEUadVVKTXTgAwImRCQV/f9BHK4/PgMnF6pqp3zJtjxLkocCXxtE
	HBRc5UBEexfT/AxXzDR25IEjoGYAwznipRb6F3y9Nmv0cOqnlEXkEmsmP2Rnut4JJGBNkTS4NPU
	LtKCkMjtsDlf8i737HgCXnMw0n4q4rzOAhk9osQvuq5jIYuMz6WS5KwTcwO6ISLh43kSKi9Gcc3
	Or6QBwqxDuSj6AoBvPyK3OQ1zRexk7GNhEpr8NV2KYqp6Yr9SOIe3H/VWQIRzmwtCl4zRYUkRZt
	h6BX78qMA==
X-Received: by 2002:a05:622a:1493:b0:509:68c:634d with SMTP id d75a77b69052e-50dd5b95a14mr387417291cf.10.1776317954583;
        Wed, 15 Apr 2026 22:39:14 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1afc597fsm30185571cf.24.2026.04.15.22.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:39:13 -0700 (PDT)
Message-ID: <69e07601.c80a0220.2f9024.1e0b@mx.google.com>
Date: Wed, 15 Apr 2026 22:39:13 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, jreuter@yaina.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] ax25: fix OOB read after address header strip in ax25_rcv()
In-Reply-To: <20260415085921.757b48a0@pumpkin>
References: <20260415063654.3831353-1-ashutoshdesai993@gmail.com> <20260415085921.757b48a0@pumpkin>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238252-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mx.google.com:mid]
X-Rspamd-Queue-Id: 4B23840A6BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 08:59:21 +0100, David Laight wrote:
> Is it just worth linearising the skb on entry to all this code?

Thanks for the feedback, David.

skb_linearize() on entry is a nice idea for simplifying sanity checks
overall, but it wouldn't fix this particular bug on its own - the issue
is skb->len dropping to zero after skb_pull(), not non-linear data. We'd
still need a length check regardless. pskb_may_pull(skb, 2) handles both
in one call.

That said, linearizing on entry to ax25_rcv() as a cleanup to simplify
future checks sounds worthwhile - happy to send that as a separate
net-next patch.

