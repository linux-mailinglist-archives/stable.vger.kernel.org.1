Return-Path: <stable+bounces-267852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id isQyMqD3OWoGzgcAu9opvQ
	(envelope-from <stable+bounces-267852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 05:04:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 281126B3ACD
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 05:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qH9XSznw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267852-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267852-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F808302A044
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBB426ED59;
	Tue, 23 Jun 2026 03:03:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D1261B9C
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 03:03:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183835; cv=pass; b=pa640bmie4pBJC7yDrLw0wOgUj223ehimGY0ncmuMOyLcVnEjFaA4X/SEmHUyyS6JKxYyoQHN5JuWmSW/Cz35AJeZCrZ/zziDpSNmi31OvnYKo5nQ/rXYQvXvXSXUB9T2LqfZofN9+awIwDoMw8nDzfyUsx++FznRrDl+sndyjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183835; c=relaxed/simple;
	bh=hWycTV3EVLunskQOcFlzjWSy5WjEJ6trD0xzOQttKI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvwJKkZbUzNtMOKchj3LUaoymXaKROQYm6qYcntsJpHVEY5WfCRlKK0N6BJkudvwWfAjQiqOwc1BOpoXIXyY3xsQxqugR1zofDdeSNKqglQGQFzQYAHoTrLLzbhwA3q58ihWKyKrTb1iKdtqMhY8qW+sKHY1TVrj7ILhok1Zmo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH9XSznw; arc=pass smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec49f7e35eso732622566b.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 20:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782183832; cv=none;
        d=google.com; s=arc-20240605;
        b=RZ+CQ0HM5kprjH27ZP3c5rQNCeI166YxeQvhSYKhTyx+/9cEpxBvdW8h7P2oWsKkGx
         0D6yVIVRNxRghG9MZmOT33QjWRClbSegtkdtW8/fpBNgb9RjmkI5EdUbbKJQpKIjECuc
         siCaCCH6SIVmbEsZtBEN169NRdKlt4JScn0jK4/1/KtH3Nhu/v1cZBpKP9KzYEQ3eBjp
         ZlgsfE/S9KEgfWSPUyiN3RY1u3tSn5/0uCIqm9JK3idxo1gCkrHLxcsVvyaoIzGe5qdT
         R5SjXMrFdIsMLZjmHDno0D63usmXAb6OBsWikN0lbDkeLnYv1XzB5bP01Cp6SeMU//55
         C91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=923HKIu3/MEcds1uZKAzkAoXqlwhb/QKAYqjIoUohpI=;
        fh=ZTsCJ/HGRe3ayDBnRmdwRcu91yyoxQ/uA1o/J++kvas=;
        b=gEOmJQv2d2FDnBTScLEYmxGnb3Tx+eEhLcnO7vVElINIjNztqRu6j87L7Sf57bbldQ
         AFLL7aNMMviKDeosk7gg/U3/GpKXabMMykJHyzz9bRIWCknFly6Fog0ILPTBTWQFkysI
         L4RrEWpTVMuyCqyrXcLo+zdSMuJBnnk7VIkPS76okUuLtXpIDN7PGuf8q12aRfO61hJL
         aa8M4pK2cFS8OmzD3QqOJZjlIyjcCUmsug1wmBk4zh6C+wCsO3crH1X+aezdv2vzmbVB
         1vn/R1lbvayiGlh2Pyz7A3+Gcb3KbKKyTD3CKiMB0GhDM962/5yqUuXo/wmIYVri7whD
         R4BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183832; x=1782788632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=923HKIu3/MEcds1uZKAzkAoXqlwhb/QKAYqjIoUohpI=;
        b=qH9XSznw3Yf1XL8xgwjlPlsYit04Ju50/bKbp8MQaVzq/w4cB+S2Cd4wqBOPWXpEBn
         NBW6S0+uaRT7AS1JLtVKm/7IbMp6LHy4UhbFzf10ya4ZJOKPw/L6g71rrCDhJ3QXOzr+
         92W+5+UK3kXJLYcXg2rZIDgRF6DJ0p44uM56aE1nxEU/QOSsYkC91xk5ybeZoVZpQ316
         aMsLVZtD6Wg/ehkhjVS73DAuyHH7uZTssm7cWjgEnPxRmkm4mQpw9SH8TS0+L15usWTP
         TLBJVx8fPA5yP9xtgJynhpIf+Ew+W9RoIsSeK7BheprtEIadQiNXNBBXncVuRtjxnmJd
         mf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183832; x=1782788632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=923HKIu3/MEcds1uZKAzkAoXqlwhb/QKAYqjIoUohpI=;
        b=GGffcLUi2BF+l0sewqJsWEpKU+e5A7rZXvOBu25OZ72BeAJrTC78XdS1OC9flbJleU
         XtmVH6/kQqo6UzW/z4r3egY8dcvRJ/RZrSlGTcLotoK4c3UV6SIwEP1bK9nviGq2aF48
         yGLB1dRLRGGw3Gv3Wco8rkAyrOHi1SqGZtbzf6Z8/n9g+tAlguWTrjjeIWVl9iBMDMRx
         ACq6VHOqj/8jDgewaFW/M2AeIM3xA1+59J4yvYSkqd2fT5jYokDgD3LofrVFyfxUE6p+
         XyPNfTmjdnEE9AYAb5SuHN07W7+dLpSwFAPdiRI9Io/0lNQAPMAxEhEHrUPiK6E52rFh
         CeeA==
X-Gm-Message-State: AOJu0Yzn2tHdakvj9ko30grDavEX/b7b7oC6emVdsYZ4KZAYrFAJUf+h
	Nu7ja4XMvDtBdVf3tf2MyzLQvOgXvXcUBXlktRcRpV2GBYSoinv5r6k9S6YAd2cOvt5ZtgEXCMs
	9JXCJRmfvF0VX1B+Mu1R1kDM+3bKKGnY=
X-Gm-Gg: AfdE7ckfJUD29Gm7GifsXhro1KGrKYkJtyacnn/9bi28SdiSLjmuPSCN7zgx6CDxc1q
	HD41Z5NGRZNjery4iU19DK39wjQSD8Rh8yyhxDa1s5ygYI1TVcEFsgR6hW4I3VqdQsmzRX/LIOW
	5kXu16sElgyUgcOPbfOiUAh+3N9evePZhZeK23xuh8yb8kUPgFaUEXBnIFiGrVj4DND9S5hqSIm
	uyobl0PPGsHRbcj9Lz9s+cmcv28bs8SJubGVM1mIhyzlAQMvpBkEyV9p0BqBkiA9lf20M8=
X-Received: by 2002:a17:907:3fa3:b0:bee:9809:3ccd with SMTP id
 a640c23a62f3a-c108c7fdfa4mr26697566b.4.1782183831975; Mon, 22 Jun 2026
 20:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
 <20260619203107.2752678-2-main.kalliope@gmail.com> <ajnpFEwXcqw07XCm@google.com>
In-Reply-To: <ajnpFEwXcqw07XCm@google.com>
From: Admin <main.kalliope@gmail.com>
Date: Mon, 22 Jun 2026 23:03:40 -0400
X-Gm-Features: AVVi8Ce3yoGe_vqyZJN72zTb7OPP-SRSHNCgbf1VXBn6dg0x7MaKOa9OmyfLD-s
Message-ID: <CAJZwKkhcx4Zc_OJqevhvG=ifPS=VeDd5ycmGAy_8KhcEra_3Bw@mail.gmail.com>
Subject: Re: [PATCH v2 6.1.y 1/3] KVM: nVMX: Add a helper to get highest
 pending from Posted Interrupt vector
To: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, gregkh@linuxfoundation.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 0wn@theori.io, 
	mlevitsk@redhat.com, jmattson@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267852-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:stable@vger.kernel.org,m:pbonzini@redhat.com,m:gregkh@linuxfoundation.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:0wn@theori.io,m:mlevitsk@redhat.com,m:jmattson@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[mainkalliope@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mainkalliope@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 281126B3ACD

> This is misleading.  The helper is in arch/x86/kvm/vmx/posted_intr.h, even in
> upstream.  I don't know if I *intentionally* put the helper in KVM code, but for
> for whatever reason, I did.
>
> Commit 699f67512f04 caused a conflict that needed to be resolved in the 6.1
> backport, but that didn't have anything to do with needing to re-home the helper.
>
> That only matters because I was going to ask if we'd be better off backporting
> asm/posted_intr.h so that the helper would live in it's "proper" location, but
> the answer on that front is "no", because it's already there.
>
> FWIW, I got the same conflict resolution, it's just the blurb that's confusing.

Thanks, Sean. Yes I see it now, the conflict was 699f67512f04 not
being in 6.1.y, not the helper's location. Apologies for the
misattribution.

