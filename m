Return-Path: <stable+bounces-239229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PJqaNvlE5mkfuAEAu9opvQ
	(envelope-from <stable+bounces-239229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:23:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53E42E1AD
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DC783535341
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF83D88FB;
	Mon, 20 Apr 2026 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+CpgxP9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sKsuRCg8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977893D88E6
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692694; cv=pass; b=n7wY1Td0354QROfw8RbwyX7ha9/AXNr1VDdplw7vgky6wPgFvdRx4SpibxIg7ETJ/l2Oc4Ol8nN1ObMb6z+Al8mNNJ/VBcdOfCA6KMtH/9B5eQH59pROF9IppX0zqMEOvZqx9u9jhdVsIou6D/z0Fsq05oEd7V8HgiCb2vqJdv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692694; c=relaxed/simple;
	bh=C7ZkUintBNR+n78eHUpXeuDHLGAWIRDXrwfIjjftvQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+fLn7M+zy1ncW97/9oW/bHb0WyMfJd8J6Cg0D3wKuIZT6cMhc4/rVvbZ6uO4l+iZHIBrvUInyNkmA8joVrXZ3J3XLLdqYZfsLjefwVM4UVtfYqvDPFi6Ts76jMq4J+svOu/vTlfCHA3pkMuDgK9j+SETzcaI4pGpfz7SezD/rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+CpgxP9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sKsuRCg8; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776692691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+/nKR8khsmc6e6yq/Nrf/JA9GPxtBwZwZ1LoRnfnx4=;
	b=V+CpgxP9svb1fEAS2iLwo8Duj6PukDwvav4mHp1pwiwVCvPhxpITUIWLu1ptUYIxfJglcZ
	Qrk+5ULsysVSLsksH9hINhEpVRmHtjdKaeJhWCZphzBZMuOLB/z5r+kFu+hfkIFarszVQh
	9xmCS1Ak41OKyYntR7lsF5tlvaVZcFU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-WmFKzqSWNFGEf4S6DU6Aeg-1; Mon, 20 Apr 2026 09:44:47 -0400
X-MC-Unique: WmFKzqSWNFGEf4S6DU6Aeg-1
X-Mimecast-MFC-AGG-ID: WmFKzqSWNFGEf4S6DU6Aeg_1776692686
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ff0eb2b2aso919872f8f.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776692686; cv=none;
        d=google.com; s=arc-20240605;
        b=TBevPbBzUoCczLkeCdhSLijeymj3QAc2fn8oAYYfJNYiz976d88Si+cnRbrQpa+MkB
         vA3P5SFMhUVpobiRwQ4XHLhXD/ouvAKq10/0DZKjUd/0PqT5PCjLorgH5vWz5tLufWTK
         TpdE4XdbBjCifVJoiO1Eo2fxLeHqCXxmFvKPewN7ME6BYzRR3Ou8X5slEfTWtUFE/UA5
         gNGSKcleyoyG7aZEJ8xQceKvzS5JX8Zx1U4/XP3JrLawdLadpYZwacUv3/ug99otHqI/
         cntF2ew0JQgOyaHKznZQyrBZbs6LOVIhUdEZTzO93TSKel+uYgAxtvfTX6NZqeQ7d9y+
         WrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j+/nKR8khsmc6e6yq/Nrf/JA9GPxtBwZwZ1LoRnfnx4=;
        fh=Bt3EczImzroKWEAQXAAeMCR4NLvh9mDOWdOJ2AQf22c=;
        b=AafMajEYu7IyP0DSBPO3B9tiyIu6bbEk/8UxBtdOYPMH0bktTtG6l4vm9+4ng63d7D
         fqyZbqRuFrCMcDOwnGRbaxHvka1sVKQtk6TPr39W0RtERGXOg4qD5L65zFUI+yD1Oha6
         OruBtEtumITfId8Cz+Is80Js2QKjXVqZPaIyo/POqs6io6BA1VtIUtWSfvzWGpZjAk2+
         bI9AEDdHFHI0wFdeyQfqg/tjxTuXXtB9zSvbre9DQwGSsdlE+Y5gQouuJOkXMmiqJ43R
         +i4Q/sYLdkgDBJVqR+Ce37ME/R+sjIg2/RF/M4+DbLTURHiR8DbrgDtn0B7zCcexTr0f
         LAsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776692686; x=1777297486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+/nKR8khsmc6e6yq/Nrf/JA9GPxtBwZwZ1LoRnfnx4=;
        b=sKsuRCg8CHMzrxWu6coSQ5QCKyaV/9BI4rhWkw3457nrAU1Vo0dn8B7j+RYKy51+mu
         ghx6RMdJiRLvEJqnmxsgqphdLoKLFT3/oYZ9ucR3qokB/b574K8QORq36iTpE/wt9zZe
         E9IucwdOjWoxUFeXBkbBXY67MmqRvtcH0GXQawXzkU2kMtAaay46ltG3Dg3Ua0MLBpB8
         4AvvuAXQ+WytrZukmpkCnCeCX90AeH2cssdS/OJQ4fe3ZAEeSfCfnzvnhnEhrbSLaO36
         f1zkym1Y4QxrOMZ9/wyTR6sSzCKAO0eWnmUZiUfkF2sJfw2MVNm3LHtg1fcgYN0BPdFn
         D3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692686; x=1777297486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+/nKR8khsmc6e6yq/Nrf/JA9GPxtBwZwZ1LoRnfnx4=;
        b=fPhRf++etzuKptyCgt+YsXEnDWUI2YZ/Zokug2au866p0phIBDuEGYjoXOzajLJs14
         +zJU2nbbUxaHhLO87oeq3nGvO4CAlvvMJTj20i0czXNqziwi87IyMwbZLfbeUecTBGc7
         ULZzx231wC5Ih+0GfKlMnM58geagovx1BrvuZkTtZ9RDLLtjMACDTWTv7MXCNBt+P4aZ
         TW6wgv8yo9Vxzq4S+W8xPFaxmmEdKvg6t9ITXDTtcymLuJ4I2O5QivZpB6ya8Zn0mYlb
         raI9dMHh4r91bSqxNPqzeIpmsljhZ7I+BQlI4QsTgNPjjfn89Sf+wAPTKsUjtmPRgr/3
         KS1w==
X-Forwarded-Encrypted: i=1; AFNElJ8wh8ZPj0oZi4cv52r616efr8Gm0+TsvvN/RsaToWeWNM0UsLY6WSqwnvcqvlDDZLDyRRKsnVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4g7KRMXHuLxTESDiuGLG5e99twdbXi4LqI3rUYSFv4GRzj/NF
	pqFQu5znbqXvJNG8hMXm9jnvB7ZpFqMD27h0N5FYqwpEXV8tdBgLdgsAhY7YsrKF2HlARFvYxe1
	V0AE3dUh2Yl7ATLNhMB4f2H8wkBsoy4WhgUpNIy9JNmMJqvHYOstg3Osxt1O/zObes4q7rl0oGG
	7DRjQw597atCQBPQuaGcYyCe5y2SAZz0UO
X-Gm-Gg: AeBDiesMkQjXisheDqqs63fvEKL5AQquzFr/eQIlHYbs3t1CnJzWUxBf45gsAgtcWTx
	kJXQljyessAVxsk0534oLfjPtl1yu+1wE3qcw/rlvMLOYQ9MS+LLPHK22nyN8fhuaFg1mJFmmMz
	GgJVXfh2KXkJ+ATdcICdrdZNat+3tjKVJU2XVB83xVnqxAD3L15gPHE+ezVIyHl2Dy5SYpwHEow
	qY6KmLOxMBWjmV3xPCPOob9A7ZPPDpYUK4yDH7qZbjWktZQrXGaoL+GBx68O8aEUebC/HlNzIiD
	c/pPVOsWtFLaBxw=
X-Received: by 2002:a05:6000:1acf:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-43fe3e23c0emr20516830f8f.43.1776692685800;
        Mon, 20 Apr 2026 06:44:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1acf:b0:43c:f1a5:56f6 with SMTP id
 ffacd0b85a97d-43fe3e23c0emr20516790f8f.43.1776692685324; Mon, 20 Apr 2026
 06:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420132314.1023554-1-sashal@kernel.org> <20260420132314.1023554-334-sashal@kernel.org>
In-Reply-To: <20260420132314.1023554-334-sashal@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Apr 2026 15:44:16 +0200
X-Gm-Features: AQROBzDobIMPDnE7Fi6IMXXk8ozHKwMYsB0F5MzEPgxvyvUL_mGRNveHXmVGu_U
Message-ID: <CABgObfbWk_AxsLB6v6RJQY6VfA3mwH_tiuobFrb94XBD=PdVXg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 7.0-6.1] KVM: x86: Check for injected exceptions
 before queuing a debug exception
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-239229-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 0C53E42E1AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 2:34=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
> From: Yosry Ahmed <yosry@kernel.org>
>
> [ Upstream commit e907b4e72488f1df878e7e8acf88d23e49cb3ca7 ]

Nacked-by: Paolo Bonzini <pbonzini@redhat.com>

> - NO Reported-by: (no syzbot tag directly on this patch, though cover
>   letter referenced syzkaller repro for the series)

This reproducer is *not* causing trouble in the host.

> **Step 2.4: FIX QUALITY**
> Record: Obviously correct; surgical one-line addition of a boolean
> condition to existing guard. No risk of deadlock/regression - it only
> adds another case that returns -EBUSY, which is existing ioctl behavior
> that userspace must already tolerate. Aligns with architectural
> behavior: you cannot queue a new exception while one is being delivered.

Debugging a guest from the host is not architectural.

> **Step 3.2: ORIGINAL BUGGY COMMIT**
> Record: Bug introduced in commit `4f926bf291863` ("KVM: x86: Polish
> exception injection via KVM_SET_GUEST_DEBUG") by Jan Kiszka, Oct 2009.
> `git describe --contains` =3D `v2.6.33-rc1~387^2~10`. This means the bug
> exists in every active stable tree (5.4, 5.10, 5.15, 6.1, 6.6, 6.12,
> etc.).

It's not buggy, just incomplete.

> AGAINST backporting:
> - No explicit stable tag/nomination on the list
> - Impact is guest-only (not host)
> - Requires specific user action via KVM_SET_GUEST_DEBUG ioctl
> - For pre-v6.1 trees, minor adaptation is needed (inline the helper's
>   check)

Bigger: manual reviews are needed for all these AUTOSEL decisions.
Please don't DoS the maintainers with this stuff. The most stable KVM
is the top of Linus's tree.

Paolo


