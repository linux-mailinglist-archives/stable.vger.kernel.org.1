Return-Path: <stable+bounces-272946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RIIDED2xT2pjmwIAu9opvQ
	(envelope-from <stable+bounces-272946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:33:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E717324B0
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:33:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=gwfqtdxV;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272946-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272946-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B178C3029A51
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 14:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D033ADA8;
	Thu,  9 Jul 2026 14:26:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF33358C4
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:26:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607202; cv=none; b=W1Fg5l862HFcpcr76Dq4TV87BhAYxIPZVVZZO+yWRLDehDWukqGmhvwIC0iWbnuJdzKiogfxD+Af9+Vel3CHt+0VnQCXTFAg5Kjny1aKHdSBBt9QwzpCx50Wke/LZXfJihT4s6VYfwZqVrWgCpkcw3kzvXx2JGkPuFfxPZaMsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607202; c=relaxed/simple;
	bh=AvDGGIFdvfyG48a0v2fwoMwweojtQzzrwLe+oLl7Eo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=khit2MleCEo/7OlPgX7cMGXsSe19AFPqGLpQp96OX1XhAvVlFcdR399KTwM6yCVTUTufIl/m+kmEt4pd+UJ+vfTIQHLAHENqzdslL4cnC2NTmEbzdc2yy6n6pwGCPyvynaf1PoHrj+y6ICnLzNCcnNWdKa2pcc7eV64CzCUM1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwfqtdxV; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c89956023dbso3023037a12.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783607200; x=1784212000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hrl+gJrrAEntwoqn7ozuJTPwa0HC/rx+mLWUc50gGHs=;
        b=gwfqtdxVb8/nuFkd12pVFB6KdmBx+KBLM34ItGOclL2m+hCycU0IDobHjPzrRkIor6
         4gwxA8V0MsUvuiJhzKMgQb5KQHeGz4Qyzl6YYpeTmRe3rusNwsds88RoxSLpodvKlAJ0
         5qVb4v4mNi0upUIQE7hAIZmFiMUZ2TinsIeKkptCAVCLP09adXQokQbtgT4/ZwaiNkmN
         44VPpKeb+sBe9ETYG27gpMASQHq1gtzIPn+1kwROcYq0BG+D0Ae8TfGg3NR5BIkaHGYa
         gKlW31NvogoIa9FnlPfSfRdWRLgkoOhj5C/LWMO2i6QR5wHGXp3P5+0v975mYYHPwr2l
         TL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607200; x=1784212000;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hrl+gJrrAEntwoqn7ozuJTPwa0HC/rx+mLWUc50gGHs=;
        b=potMkX+ilv1r1+vKyJnMfxJpC67jEta0XeRLH9Qg8KzUwbx9rl6r/jud9c44CKhlXK
         cBucNZjRxpNFSnPxJGemvGmjBLOnCcEZYRkEqSlc7w+tLFyG350quchjYu25uZnUP3xG
         c1onFwuOowBqEfwVeMz1fqcmcl1kakmKXNXFg90/3Y+LPBZBq36ubIy1mARxUwOQcZhy
         DFvN7SwKkACv6yP1kdHrdW42jkcq2/VF8jN3EYIj5zXydlyZsvbnfY/QHDV50dE8YcDc
         G3VeLQ3KN0iWNfMoMOl9qXHiJ6geNxajevccNKTDl5bZavDoqCL9Kk42rXNR+xwp9EZr
         Fx1Q==
X-Gm-Message-State: AOJu0YzH9e6D3K85pULi7t3lBVLWSwNkAEhekUljkGYWvPavjgmoRlP0
	W5clyDsMgH2Z8IEuihSjJuZ9hm/OqqK9JEmeojP6WATDls9Febz4A5aB30k/xo9b6lu0WBoD1Oe
	aVlG2HQ==
X-Received: from pgjm22.prod.google.com ([2002:a63:fd56:0:b0:c9e:1b4c:6a93])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6d8b:10b0:3c0:bfd6:965c
 with SMTP id adf61e73a8af0-3c0bfd6a519mr5310537637.10.1783607199901; Thu, 09
 Jul 2026 07:26:39 -0700 (PDT)
Date: Thu, 9 Jul 2026 07:26:39 -0700
In-Reply-To: <20260709132109.3423488-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709132109.3423488-2-clopez@suse.de>
Message-ID: <ak-vn-wFtHZW3PBd@google.com>
Subject: Re: [PATCH 7.1.y 0/3] KVM: x86: Backports for VM entry failure due to
 stale CR8 intercept
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:clopez@suse.de,m:stable@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272946-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1E717324B0

On Thu, Jul 09, 2026, Carlos L=C3=B3pez wrote:
> Backport for bb365a506b1e ("KVM: x86: Unconditionally recompute CR8
> intercept on PPR update") with two prerequisite patches.
>=20
> Carlos L=C3=B3pez (1):
>   KVM: x86: Unconditionally recompute CR8 intercept on PPR update
>=20
> Sean Christopherson (2):
>   KVM: x86: Move update_cr8_intercept() to lapic.c
>   KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest
>     mode

For the series,

Acked-by: Sean Christopherson <seanjc@google.com>

