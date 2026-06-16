Return-Path: <stable+bounces-266581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WkWmI3HNMWoiqQUAu9opvQ
	(envelope-from <stable+bounces-266581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 00:25:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DBA695901
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 00:25:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=e2utSYpf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266581-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266581-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 106EF3185D87
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2E23AD510;
	Tue, 16 Jun 2026 22:25:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A639C637
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 22:25:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648728; cv=pass; b=q4yJ7e0woTTMXFDer3YyKXoJTUopyfFrw2H//76ZDGzJFXrKHsgmhdqZOrMXSme2UkKF6nuGBy5O/2I+yloEdZcM8rSSTuTd17Uqo9ZwKJMK29UwZP0wa9NWhXA6iMCd0qM6e4H+xdQx5UOcDtOmDhDnqmvc7OMFIcc8ducX3Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648728; c=relaxed/simple;
	bh=jKgvyKk7P9bNKSoGDvu/vOprsRoiXdKCkcTH/POdpsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWbCthu8DLbtfEIlHEsoQ8KHiIcicUe64RHSMS30rZAjHFAyT5EqgygzNvuWjrYMEYYps5X5k+SXsYDHfh/xF5Q+emb365WHYr6JPgaL2XDPfr5JUgXad2D4+sIRukfaywlFsawl98CC38+oG2t2K4K3UDCy9AjhCOHveuxthn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2utSYpf; arc=pass smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-695469b574eso1875a12.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781648725; cv=none;
        d=google.com; s=arc-20240605;
        b=cbgUy9Vh94Z3/Pa+t2+M8TeoYvYlhakHyi2sZLOCPvIjhwkWvoynHv0Z4MYomyXf+Y
         9cHbi/osjpl7CVWPmdOESSZkW9SXu3PviGCkzyGlz2BKza+6KjYrZQ3HzGCK85PfOKf8
         wecO/uQR8I7ExkDrnP/rRfoUJ70iNbdfAQ1K2h2tXY7J5rhxS3f1uWcl9xuAtpCn91IW
         jFG3OToLF+z/2Bk0yOb7P+YaLDd+AxQugZrO5MCzNHrblm91bx4V8ObcoLlaTdmtX/Z/
         wXClyfE6lbnau1LAOWcpid8b78xERjuf0jeFj3dlYouJ3aNIdWC8IRqkMYIdRjKqEOF7
         1TIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MV2HmtTBtTO8uZxXNcBM0C7QSI5cDV9ze8SL4kFOQSU=;
        fh=fN6cuuRRtRJjk1VSa0ZkR/Zo2pl0eyjJ3f3jsvqXqcI=;
        b=QnOd+c0fCfRic6a+KYxN4WXSrYyPyQ0OYnKe9DeWyzHCbD6gijfHdsz2BViQ0vMDq3
         wwD2OgNQCQBuUJa2hG1KfYP52jIInEGUdmVF34xNJwkhMSpfIN+6PpD/bq182QG2JBUc
         TL0iHR1VleJzIWNr+V/BlOpW5iKA3D1Z1vkVpCGhSWejnebDgnAJTQ/iKfMgCQ1ftx+V
         Ca9Rf7GoL4vb2FNIhumtV0EeIlw3oqJjJ1Yd4T3suIdqH68+l8QIq7FXctsLkwky/9pL
         LePpp6txNS8x12AQcFceBHyV3sn0CwArn87KjctsRq7vP4MIqxADW9IzrKkYrmKxzIXI
         4d+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781648725; x=1782253525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV2HmtTBtTO8uZxXNcBM0C7QSI5cDV9ze8SL4kFOQSU=;
        b=e2utSYpfSuR3d2QIao9J1KDrBHAJtsE59G5p89sdZGExutjIx1WMXdfdkGBVhP4ahe
         +ImdluIKfy7lk1M3SteXG6h9Kt7Qd9iNAoCDBuI8GZf+1sAnYz7hSWsSeEeuOvbabV1i
         rP8MHOQ7QXkXNc8KSxdpzHmVnXl5EIST49+QaN98F616SqL3UKV5rxFxekSXQtQNMqX2
         kiNFgMK0rbHLs5kzwdIIP57JVo3uDqGsMwe2Xu8W7flUsGaLenmOVwilUozY4zEbAA7Z
         upyeNXDElcNgUpyr50cV33uD1A9dIzMTjh9snOWNRmYLaho1MBZ7xZa9zj/hlPFo8jxT
         C2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781648725; x=1782253525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MV2HmtTBtTO8uZxXNcBM0C7QSI5cDV9ze8SL4kFOQSU=;
        b=VDy8cYvTBvk3onY59Iu4PJL9OTiQisJIC1VDW0lbLQiAolfBuF0rITFtWL5pyT14ln
         diw56LyG+JMhAKMeNLiDjPthi4ezmgnotlTZcB5roE25jM1nNChPMI/ZY+M5tFjWHrKc
         r2Chcl112DoQ1rgo8AipGxLWnUZxJIQ4b+6hLS4E5gOia5JI+pQqsvE2/SXopmcfCFTv
         FRRX2JpFserLKoVsIpRGM6sYEBJbVbQivikpnzMmWfkaIWyqTnO/asr2oq+Jj5sGdSux
         zftiOJ3v6uitT+lwAmMoWQTQleyzofaWAOqk3DPCE0ZE7cw2PI5uTZ0gC+ryV6P226Ni
         nlyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6ywba0QwX+sK4J0ttEOmjmvfR8gGzdym51j7qMTSvT6HVWUn8YhoPLQqoTPwY5oIDu9ctokc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSWuC5o9RgDekWwDZLvWpW43q3rDcvn3paU/ZRM7WtzwMPT7m
	QOujMvqadmms+Skh5Pc+yK00nbay6aqPsZ4npDs+bmKberHNPySM5SO0Kn60v2VqF011k9+u0cZ
	x/U/wjOA0U01wKmqC8/R8u1FtuTGHpYHVZyBV34P6
X-Gm-Gg: Acq92OGIovTWNF/P/R8KiiMi86SGCkSkuBJTv87dSZhFFdxUqsUnFTSUEcDlcAuDtft
	gsjrflHdqX5SCk2YeBPzhVV3abPlb76ypvxZF6gsEipolRmRD4hW2w6gP9n38StAlckUceeHSQS
	pjopMs8TGOn5TKE1zCSl4XLIwF8uAjNbaP9D1dYOrbpmrQqwC0CtQA8N+pErA4/cKUa70H7mXId
	4c3H6sX35cqnPvSLZRfZTd4zWOl4UaoWIdM8nWFZpvRs+0kLP54WDbYKY3vI669Xwnm1A0x96/W
	NKFfeig=
X-Received: by 2002:a05:6402:a244:20b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-695475741cdmr17062a12.0.1781648724795; Tue, 16 Jun 2026
 15:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org> <20260616214652.2157032-2-yosry@kernel.org>
In-Reply-To: <20260616214652.2157032-2-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 16 Jun 2026 15:25:12 -0700
X-Gm-Features: AVVi8CcXw57Fy4yvePc-el3RpLouLJgA5KfacL6pFCwGL-zOTuYKp6Sw3PIaXR8
Message-ID: <CALMp9eS0=dKsYvVwRpBy0dxv_Zn79L0UM6k+x7ezeiUTZdSzFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jmattson@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-266581-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmattson@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2DBA695901

On Tue, Jun 16, 2026 at 2:47=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Make sure vpid02 is always flushed on first use by setting last_vpid=3D0
> when allocating vpid02.  nested_vmx_transition_tlb_flush() will always
> detect a VPID change on first VM-Enter after VMXON, because VPID=3D0 in
> vmcb12 is not allowed if L1 enables VPID.
>
> This avoids using stale TLB entries from a previous lifetime of the
> VPID, that might have been associated with a different vCPU (or a
> completely different VM).
>
> Note that last_vpid is already being initialized as 0 when the vCPU is
> created, but it is not reset when vpid02 is freed on VMXOFF. Hence, the
> problem can only occur if L1 does VMXOFF -> VMXON, runs an L2, and KVM
> happens to reuse a VPID that has TLB entries on the physical CPU.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>

