Return-Path: <stable+bounces-249429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHC5JZy2C2oCLgUAu9opvQ
	(envelope-from <stable+bounces-249429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:02:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0135C575E73
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52AF3031330
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C125A640;
	Tue, 19 May 2026 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCaZ1ps7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5531A6802
	for <stable@vger.kernel.org>; Tue, 19 May 2026 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152467; cv=none; b=sK41Wwaoub7OcA0b5NIH0BppikV6xEG4WMNU+xfR9cpnf3C3a2gkO5oXhl5jGPi6GOv/H5B32d9mqB1qhVYK5L0gaD3tbhmutTiQWC6RWf59BIQijnGj1+JbJpSUp9kIoyasr4EjjGaKpxfw4oufmf/kllza6ExwPUPSjHHvb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152467; c=relaxed/simple;
	bh=w73//z+ksqLYZY7XAV6NM87fwXUCu0O1TweAlcOUwYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDoImSBJ1QKGH7s7SkmxlLW4MbS2DErfKPUAvt8nHq+gdDs4biIWNDIjnM86f7uVtCx1mwb1ywKooAVXuHYOar2H0mybAUsHYvXN40ASZ0fmNfWmN7zS0mr/uYGvmfa1Lxby5BF7fwfRKz3xyD5EU03B72l2ClpMP0t9ZjZXlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pCaZ1ps7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c827bda3052so4698426a12.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779152466; x=1779757266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w73//z+ksqLYZY7XAV6NM87fwXUCu0O1TweAlcOUwYI=;
        b=pCaZ1ps78imKzEB9NS+XNI/ugLU33HrXqMPzQmlqBkBwiR8bG5gTjpVX4LcvQnjAKY
         poGjV1UJVDWK3r//jnke3nlt/lbp6JahZp1Nup2h+E5rKcv00HWJXWbkYD+wbAS7v0jA
         KZ82uQZGLdKf2IWuOcwzFml7wRdtuF+bqjO4lTtS2Bn2KLa/wEEaHUFICM10uOj5xbJp
         sOKU1tRDtjno3B4pyxiCVR0tn4QOxKzq2ErNiEDodqg06m6G8Y0XAgx9zeL+RiiS7QkG
         GSqcNW1/6BoXmJXBFulP1pyIm5DcC3vkwLz/gNLntASVIN4w6cltD1uVGEssmlkVAtaR
         dTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152466; x=1779757266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w73//z+ksqLYZY7XAV6NM87fwXUCu0O1TweAlcOUwYI=;
        b=O3r4GZGPpAJiBmNzcVNHDLXJoEw6DHYV+gi3dZtZjPmRP/k2gKUb47t4JkfMCYHY5S
         9zrFq7C5XiAjxzbXRu9TAyyPNeKdHULr68PoGEhgWhped7IaEj57WESsQWZYAA/TnTJE
         9qvEy96S/CyOqfRmh+OPhjrkd2Uvo2qiGh1INwLpJbG50OZWSZ3uTOy3VPYNLu6WqZ6V
         JemfHiqboQkZD6jezMwjfPGD48Ub7ZgwrSKrRvLYL/15Rkq0W+L4KsJjxIeY0XXpwWJL
         j4Xx8sr0RtE03mXkfKEkfto3uORhBgVmL8H7sPzpeXkfuEE/V57GuqxhkUG/1slRt32f
         umNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+G5MdRBH6OfE56dcHUV05YwTA1vuXi6QLTwPnquwmi7bTd5ERAGXe6pmjro5YT2YoQ2bLIVow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPGYpagSDZQ3zdWEYzYn5BvwG93Uwg7/tAfuwD3GoqUX68b3So
	Wvca0qmxnaXK9EzWIt2A25olGhCFU2JQC+HUFXY0GpVzl62HkNPS0SAEHbfDxCun3J0uNndhonk
	MImAt+Q==
X-Received: from pfiy14.prod.google.com ([2002:a05:6a00:190e:b0:838:dc32:5349])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c0e:b0:83e:d52c:e6bd
 with SMTP id d2e1a72fcca58-83f33c9bc80mr17829172b3a.38.1779152465512; Mon, 18
 May 2026 18:01:05 -0700 (PDT)
Date: Mon, 18 May 2026 18:01:04 -0700
In-Reply-To: <20260518044150.34632-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044150.34632-1-gautam@linux.ibm.com>
Message-ID: <agu2UAi6lWclxFYh@google.com>
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
From: Sean Christopherson <seanjc@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, atrajeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,gmail.com,ellerman.id.au,kernel.org,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249429-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0135C575E73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026, Gautam Menghani wrote:
> Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> vpa-pmu driver cannot be used since it is not enabled in distro configs.

That seems like a problem to take up with distros, no?

