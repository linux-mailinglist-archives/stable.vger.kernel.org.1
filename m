Return-Path: <stable+bounces-245005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EIqMLoZAGo3DAEAu9opvQ
	(envelope-from <stable+bounces-245005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 07:38:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 408FD502AF0
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 07:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FBF6300D72B
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 05:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6033537CC;
	Sun, 10 May 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNd+xaMW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3225A2C6
	for <stable@vger.kernel.org>; Sun, 10 May 2026 05:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391480; cv=none; b=OWR1AlRUYoNCvt1oK/kq/XcMXr91t1ZNua5Rehxy7KWxrcSkaGCxjWzlLKRDqOsDi0PVISjoD/Nvci7i9ResMCUxqajZK1QzQqprYgNpSjxX/VHf8floNYhzB8Z925+qbXDAa915qNRCbrQ8gFSd1+w06mCZvuBdP+OJxUECvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391480; c=relaxed/simple;
	bh=gdmIrgkQpbSvx+vY1CE+F9rcXTqRDzZf/sJ7uGwny6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dwv7Ex1peT8NtYoOeKkTVUCVWokMWOemNpYlmFQPG5Uml5OUbnGIv05GSPHdkin+lTTvQ8eMCSND4kqc86MUhikbkD9gnRFPGvDq1ks60PtBnEsWn853lHgj6lXXkVee3/owfjuK/uGgfNuhu/iwIhgyVkzR0pXHg2nr0vSjS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNd+xaMW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b7c904d476so36367905ad.3
        for <stable@vger.kernel.org>; Sat, 09 May 2026 22:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778391478; x=1778996278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdmIrgkQpbSvx+vY1CE+F9rcXTqRDzZf/sJ7uGwny6o=;
        b=ZNd+xaMWqGz8i63ndSSl5EzqebHTI5ug5UHwfx7P8IKSf/NTCQnaEdaOLYGuMv7u28
         zl10hOmDnUh2x3HrMt1MFAVI0Q62CSqqBsd7oQ5Ye9cRWsdW3GY+50FhFZi0Io7xFX3+
         GGnDuJNqEjqd5vIcnZViK+d9r0Q08GYKFE/ZCwpPz/80lIy4CbN52JGdgxRzdEw785W+
         J1liBOwJ7d+ZwIduHcwCQz1kPuxE/lGKOtTeBKnEUCZOeOZ4oWOq6YDDZixngCK2Fj24
         /AuLAZZ5KsDNQj4zwvpcSYsWnimEQf8BDIM0HC6mdGkaPgUr1XFgErKpbwrFwy5ZnHmC
         LBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778391478; x=1778996278;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gdmIrgkQpbSvx+vY1CE+F9rcXTqRDzZf/sJ7uGwny6o=;
        b=kBdIq/5x7IjpCIt6dfxI+joYdo/A2aTUFiQTQQrWaHeWVRfroM/a4NfEdU3IX1rUd2
         wzz3rqg6qClhhOsuJOjLP7YeLtHCJIfIeeBuTEBsygbkbHi7Q+zmUQAU4NH+Z97obvSd
         lBzSQNiXIm8ft/eqAcADQDfcaqYXH7WW8r62wRMvwu3lfRLS4TRSviAZrzw6RLNs/rG0
         RQMHhxcpBRqs4vFePyTWJUZ82GOc8kjhT+ykTfdSswSPKYlNxgW1ptRmILnmR0lD1Cht
         XpWbOIBrfF6E6p5bsIMgLHRFhnVovHafIyP6e4T8a099ptJiQC8AYCB7k8ypeX8Gncw9
         5/qw==
X-Forwarded-Encrypted: i=1; AFNElJ/DHGK4besAszCcB0QMJCFygQjbkE7uknvFurvHqq9FGc91qaH+Vwy/mKAqpqjtfssPv1RYPHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhMBFdhID+iuemCi2osm6qNld2/N823EXQG+I40rWXeHsGPEU
	UW9ZQzPdhYwzxnhH1jO39+hTD0amT2mWyRx64BUxofX6WmD3eQ6qDpXUcMEu9PQXQnKwi/DXcvX
	nw3GZ1Nj2q3h6owRe06HBn2u3gw==
X-Received: from plsa9.prod.google.com ([2002:a17:902:b589:b0:2b0:ada8:a666])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:7d8a:b0:2ba:4749:c9af with SMTP id d9443c01a7336-2bc7ac8fd0amr30707285ad.40.1778391478144;
 Sat, 09 May 2026 22:37:58 -0700 (PDT)
Date: Sun, 10 May 2026 05:37:55 +0000
In-Reply-To: <CABb+yY0Y0YHKviAaJiC8ZbJKCPnfJnQ2S-ifcsB-HFO3JzKJCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY0Y0YHKviAaJiC8ZbJKCPnfJnQ2S-ifcsB-HFO3JzKJCA@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510053756.781317-1-joonwonkang@google.com>
Subject: Re: [PATCH v5] mailbox: Make mbox_send_message() return error code
 when tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: akpm@linux-foundation.org, dianders@chromium.org, joonwonkang@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, sudeep.holla@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 408FD502AF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245005-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> On Fri, May 8, 2026 at 4:02=E2=80=AFAM Joonwon Kang <joonwonkang@google.c=
om> wrote:
> >
> > When the mailbox controller failed transmitting message, the error code
> > was only passed to the client's tx done handler and not to
> > mbox_send_message() in blocking mode. For this reason, the function cou=
ld
> > return a false success. This commit resolves the issue by introducing t=
he
> > tx status and checking it before mbox_send_message() returns.
> >
> > This commit works with the premise that the multi-threads' access to a
> > channel in blocking mode is serialized by clients, not by the mailbox
> > APIs, since the current mbox_send_message() in blocking mode does not
> > support multi-threads.
> >
> > Cc: stable@vger.kernel.org
> >
> Not sure if this should go into stable. It is not a bug fix. See
> stable-kernel-rules

Alright, let me remove the Cc tag. Will try merging it to a stable branch
when needed later on.

Thanks,
Joonwon Kang

