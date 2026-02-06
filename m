Return-Path: <stable+bounces-214578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJV3IPVBhWmA+wMAu9opvQ
	(envelope-from <stable+bounces-214578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 02:20:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BBDF8EEE
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 02:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DA9302880B
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809E23E330;
	Fri,  6 Feb 2026 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM26NsTG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736023C39A
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770340828; cv=none; b=PgQdDbqsldill1T1avqwtkPpHEOJG6nI48MzedcYA3gzh58pvRcsuCYRHDbK6xRZTShjkjaERE97+9zvQgeUQKk7nP7gi5UQPHyH9JlqTfLjPCZPPfi6i+N4afrC5/r9GDyvfvLLN/fWNCCfG3/064gvsrBFG1HvJnW+MOcHxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770340828; c=relaxed/simple;
	bh=aXXx4a7HRCOQLrHiRmrwTqtV4sqi2oXBKeSkyKaj3tc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R1s3DFnsLygtjLLi2nBjuetuy5MDAov8O5IFHQA82JKeryZDoUrC9M3eyA1u29jRgddCrA+wyTRkoKZOU4djaigfophdtW1++TQv3m3Fbfq6uOnLnXPJyXlMPjZcewF8KK9sniW9euBYz3nVI16GiCSg0bQetL5lS6NMwpmbOd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hM26NsTG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a8fc061ce1so41495335ad.0
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 17:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770340827; x=1770945627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaNLpZPtKqlc/2giLWuacVY9PXV/N+L9JNqLWxBwmqk=;
        b=hM26NsTGr5YMvPZTyoF/ed5Mn8+IY4Y56w1dr4EgAr0m6dOfa+29rp3DsUc3MAl7WM
         GfMHsqqvd23EzCOzV9jFJFtGJYfH3F1FKqA2HdAesjR9/73trLSBVJP+I1t0L7JE16aM
         vK40Jnb6pMGh4r8yHykePbbeBegt9fsSj2d2LLdCktNta1rDXaAlpe5T+MtCJcnGMKNi
         wx3Dbt+1cQ5yDMVsA82SRH6MKp2YQshSXU8dE2DOg4kyt8a/PGUragyRstwE5pTRrT5J
         JhiA/9cHfsLTR6ZUw3IdaE8NgDG32NmiSplDK2WQhEWbkDTRyFjWFxnOwuCjGzGhqpcJ
         pYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770340827; x=1770945627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaNLpZPtKqlc/2giLWuacVY9PXV/N+L9JNqLWxBwmqk=;
        b=w04yGYVpSY9Vd46f9HCvhwZzcw4QgQZdwFDexY1PEb5JvFnsv4Uv9hb22mJZUHflVp
         5VtIbKl1qFB3C5uEXEK99WpmYhGogE8jq/5epmKoN5f3xfeC7ltpQPjdWh86dJo2SeB9
         QbJlFYuFA9SaCcW+p72UoI1tGW0+yaARVQFCSqIQegD9CGdkT3YYhVlOOjp70diaDOXI
         817zaprj6/YER/QCAY57AjNozqPKnErdBcrsO7BhWgeLyRdZR7BUmxfB/aIXsLJht54A
         4951LvtUL8HkpdBtxtYJX/z+ZBOxvhdVKVurYpGCq7zj/MWGyxPwJ+Gmj6RlpM6Wk77T
         kAsA==
X-Forwarded-Encrypted: i=1; AJvYcCWS8ONCjLWdBrybzpRVktX4y3hozILAwRckYjNgkMfAwj4rYdAwMr2kgIXNMoRMeObA2JmMEmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWK6rRjJjXkB0lmwtRUPOgcZaPiWxZhb2a+OrvJuHOJeS34Cg
	XJcP70G62KSlDqME1q0ImA9VOqN5GLa4Ux4U5DooA2H86FjObt8VgFxoAjYIbfrnLN+YHJuoZjZ
	rI4NRRg==
X-Received: from plbms3.prod.google.com ([2002:a17:903:ac3:b0:2a9:4460:be67])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74e:b0:2a9:411a:c5c6
 with SMTP id d9443c01a7336-2a9516fcf5dmr12129195ad.39.1770340827335; Thu, 05
 Feb 2026 17:20:27 -0800 (PST)
Date: Thu, 5 Feb 2026 17:20:26 -0800
In-Reply-To: <20260115011312.3675857-14-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115011312.3675857-1-yosry.ahmed@linux.dev> <20260115011312.3675857-14-yosry.ahmed@linux.dev>
Message-ID: <aYVB2qYZh1smeBBL@google.com>
Subject: Re: [PATCH v4 13/26] KVM: nSVM: Unify handling of VMRUN failures with
 proper cleanup
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214578-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2BBDF8EEE
X-Rspamd-Action: no action

On Thu, Jan 15, 2026, Yosry Ahmed wrote:
> There are currently two possible causes of VMRUN failures:

Might be worth qualifying this with:

  There are currently two possible causes of VMRUN failures emulated by
  KVM:

Because there are more than two causes in the APM and hardware, they're just not
emulated by KVM.

