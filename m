Return-Path: <stable+bounces-267866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LhXICrEpOmpu3AcAu9opvQ
	(envelope-from <stable+bounces-267866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 08:37:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C376B495A
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 08:37:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M8uTxDUz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267866-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267866-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2738D3059E22
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 06:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E656331EAE;
	Tue, 23 Jun 2026 06:35:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EFF1547C0
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:35:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196533; cv=pass; b=Tu9wDClJm/UR2OwbEbruZsa8x5yN/q+BJYoo2HFmEakySOklJ7rM+P85wZYpXN8qAgq43vpqV7b+xxCG4DoCfWhKyWzeGP48pYzGBiwbitOjoLaXxOrvCqc3EWpI4M5vUmh4gXf+aL0bIr5+BvoZnOzr5KEFvnj8HWPld6KBp2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196533; c=relaxed/simple;
	bh=Z/OUKD7p/xfKxuUSc8kB3ejA0URcXCyiF3u2ZEIIag4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kwf7YWIyPFiTmABUcwWZk0sOyHSfDad8PRtOTU0IDSSjkeya50oGfM2orsbopYl9KemnX/6khEMJlmA3wCzfpOzbDz+flBHx5BrwVkZjdPJBZoZWNblop+yUW47BxNfvuRoAbKZt6kgJ5+dN3ExqFzouK78eqgriZ6MVHxCBO8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8uTxDUz; arc=pass smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso6722231a12.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782196531; cv=none;
        d=google.com; s=arc-20240605;
        b=O8lv/KmB2/4DYeQYhd3lL9l9B7Wm4t1oK/YrUoWVkxLVwhNnI5BRKFcH3EzKL2scvf
         yYXXcNTN4SmyPGndrgKXT65m+98ORsU8zuP8OakWx4kRDjBaa9kUYcs1Fl5P+RKDNwkK
         IlT3eAh4rjWm5/gIB36ZX4/xsl/UBMZt9I9l2hBv6OGzrY+nAKXUvCfAuGPl+5Jh9IJw
         NLksxDNMsUNoyyTwReeikj2+ovBzFFoQvct5lTmDdJ+4p31IESQRAVxNlw5tBomUS9A0
         JnuuVMjlGJf8C/RkkeyEcqmXA/WavyNhuEoFPb/cSIb/wQgy6Bfz7vVpi0sXDHWraOLh
         eDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Z/OUKD7p/xfKxuUSc8kB3ejA0URcXCyiF3u2ZEIIag4=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=D1SdqYKBEtuIuiGe35pDiEXQxz7SnJul6NVLrzCSSNKabxslgw6fyekzgPmSUv36j5
         xcO81rtEiUOwHUbH6MPZE22d4JGv4OSBZIZVvYz/Q/RDx+i+MqPEkPrgvfsDS40fdwhE
         me73mfbNsveq8qLYzMmrnBfKoSrnE9319kq/KbKKp3lEdcnrqP0UKBxnKJLw+zVZvch+
         tf1dFyH8AAZrzcAj98V1ybhQ/ew3ZLNWRqUXWaXvX63lKSF27GDUguyOJqo7ljJsd1Sk
         JJ4l9AD2n6MZ/grdB/zuPDITYWO/EMwx3aAFTiNZqmR52Bn4FLt6QQ7M4v3/ieCLGi6m
         z5iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782196531; x=1782801331; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/OUKD7p/xfKxuUSc8kB3ejA0URcXCyiF3u2ZEIIag4=;
        b=M8uTxDUzZzzgGKWDzLETCXd7eK17w/xydVYUmnuEvoeBpWR4MPRscWaIJ2QccgLxK2
         KzOhuTKr3WOzBU4pj8CeVtikQcg3UETs8Z61wBOIoNUzG9ZtMQkouqlP8za9GslG4LlG
         g3jhlXiTxa1vbp2F9vHuzaHb++f1pVwSE489fIwzQgSTh7Sz6mhEdHf6Fe4gJy2MzibS
         CU3UmXyUvpcdIjqkzB0TOiLq7mYxxmjXcE/Du8aZ9EqF8ANRzT79ulgblIghoywByayB
         C0anS0M15uOGKzCnqRYefeDw76EaM1kjNedOLpGlakH0G/4sTgKPSyJBDigXkyDytSya
         Fk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196531; x=1782801331;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/OUKD7p/xfKxuUSc8kB3ejA0URcXCyiF3u2ZEIIag4=;
        b=alqLnI3vHMxQHtVSepoWe90XtC3xvE2gOSk5PPBHgmhLV8GsSoXK+9zinexLwojlXn
         sI51ViNeL6QoO61VprWEcDxP/2HFBSvUTKpzDgy6Pa8GZQCBcv0Bzi0+XiQZtros6aeK
         WPtxuhPup17d0V/VLk7FzlK/ekm2qytd9K6UJtvHK6GXqyF6bLfXBCL0f2EOVejEJuAE
         Lvgk0eIsa2pq55q03mjnXaFQqdSbM4XvuUNF8RSpzhepnPBHJzIJnhCSfM4YFkgu2zKX
         Ve4+ozr8OjhlPD1OGO3dzpIZXawr0zsxHL/g3in27ELnldsGzsvNQm+/3k1BphjWlPkE
         BxiA==
X-Gm-Message-State: AOJu0YyHanMoFMqDmD4aaqRGxU6WRD66fMFi7fnLpPN48ARv8zbL5UdM
	hUd8eNyHtw3ZZ2+SLLZLGZcTxX/frOinhE5spqdRHh6J6qfJKBaXg82JgBpbiBG06jDltezQtJC
	KA3aWVlpryOxFO0W762cRFnp176jDBD+FKTkbomU=
X-Gm-Gg: AfdE7ckSWm8gLQ+Fv+gVfGRgLLwB2CIr73yxWJ7sTeai/vIWD+Jh2dY53FOvLtVRqHW
	p/RH6OOyZ5FaEXgRFNkbviSyI8PZ6SWs/RPAMPb/UIfmpuutL3CB/UTkfAWg5lmSIrS/SFeIiCA
	pX/GhY+5JLBNwcqXFKGNwxCA/JpIjXxMcsJsHp0GA5ClkWPBRtO1DgdxhFvMY3MTSUiVcXlSZgi
	ygafDCQJRFyEvnnrCBNjnIEk34Q8/gj3+1BWw3BkYJ/dBy2TFv4BURWketx17f/qvwvg1U=
X-Received: by 2002:a05:6402:50d4:b0:679:223c:d191 with SMTP id
 4fb4d7f45d1cf-697035021e3mr8500771a12.13.1782196530678; Mon, 22 Jun 2026
 23:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Faicker Mo <faicker.mo@gmail.com>
Date: Tue, 23 Jun 2026 14:35:18 +0800
X-Gm-Features: AVVi8CcsjVGlr-awroWbVgPmzgJH2KhxupyQ_2aPJKihLzjGfA6nJ3u3btXB88Y
Message-ID: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
Subject: need the upstream commit to be merged to stable kernel
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267866-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[faickermo@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faickermo@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72C376B495A

Subject: net: net_failover: Fix the deadlock in slave register
Commit: b84c563
Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
26.04 (LTS) uses this kernel. Thanks.

