Return-Path: <stable+bounces-232865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENL4Bk6NzWlfewYAu9opvQ
	(envelope-from <stable+bounces-232865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:25:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A28BE380999
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D341830373CD
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28E737C0ED;
	Wed,  1 Apr 2026 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtyQc9yL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0F2DCF4C
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078729; cv=none; b=cfMER4UqPgx5MvJt/hlZlpjfQ39xwaWgjiUbuF9OYOEGqwEeHsgZqpkkazrUaV1SfO2nxYtREDgbAQpZEyCsVPZWbKm0FgIlizdnUooMAPH7nO3UC+JbPeqYT0upb7I8wRCovkOM5xNPrmWZY18nsRuyiXfYKAh+7hg0q81NiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078729; c=relaxed/simple;
	bh=4/mgDyjPGAtkIBXlEDxDzqlEKPAaHfdoKm73NtKeWGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iGnAfyUzHy546IxgUr4+hghWPabWQnRBJRn67n6IUay9ycSJ/+5ntJ986c2EnEvOiSqr482zzsSrGiYHP3YWmntjiblYm+6GGC/fk/mWK/MsOeFJ/i3ptVdtDr51PWAHs05tdHa9snkgV0PjnKgIrlm/REEyk/AuFI9EWtVmpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mtyQc9yL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c709551ec08so266180a12.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775078728; x=1775683528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztlDOl/pnqN7J3P9fUr7zQ9Z9muBSWpUGEThXybJWdU=;
        b=mtyQc9yLTossFh6O++SxHWX9qfeDJ7kxiGVPSwNFwtTxc/DKaA+U0pdw6zSNZE1W1+
         V+LzSiRZ6FQObmNzKE0BYpmBPhaYJ4AMcJppMFkpisfCau3T1Di+UFShyM/3cHpFGNl0
         UkQoSXURXxTlDodYmo5tfy2iEfSplmpfO1kGCGthDUXUOosAh9Q36AcvI1Uv8i74CIke
         sWRm/gO1iAClaemqSv5yfbsdBGdL9T3mIFdwE6YnFe5wOGQQbbHmJs5pDVf4OWF2734N
         iUWTAgMChl8nCRgFT3KJuMEaodcw4kJCEjKk7WsFP8q2egDoTuxluaTWnh7cmlHaSI7X
         RXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078728; x=1775683528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztlDOl/pnqN7J3P9fUr7zQ9Z9muBSWpUGEThXybJWdU=;
        b=lovw9UtZfQGG/NPlxLzf14IHyO6URQn3LLu8K9LHxjj64Gu05iobFbYu90oELZmg3/
         gcTpIug4aw2VqnYAvwme+JqNp5kYihB/epvIVGjwjuNbMUPeJrBmmlFJ7LPS3EJvSK/g
         IVBxj6qYOjbJ1vfE8J97JO9LK70sOpFdz6OE440/jTCdD1dRkv8iucxZN2sMT+lLhiX/
         DRIQwwAzvHsGPjhq3M/JGRQjIPj8JFXc8B/knk5xApMuxdoVFe6JOleqI6nE9SgFuXDc
         keBO6n6HVwGriTiIC8Fxxmurchva4QLmBh0sF9JfeqQ8DKbsZkYwdvIzYmQlWNEAFATX
         kpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo1+SmqJSKl+rShnSB02/rsL0p7O/8yzMoEi1DvoCLjJBlLH0DJv4aYEIeUENSHIZ57FMIo4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QAyAYdbelgjbmHU0/MKvW289VM5MFcUjCvlMDA2Q5EwMbHZ4
	FKgh76sjBtk3b6r2/c8TWg8NiXKJIw1spjI1FnSFrzqcYffIG3BqvWFlESpJNy82pXlRrOpPVPe
	5Sp3t6A==
X-Received: from pgax38.prod.google.com ([2002:a05:6a02:2e66:b0:c73:9c9b:5823])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f92:b0:39b:c10a:beca
 with SMTP id adf61e73a8af0-39ef77174c9mr5307339637.44.1775078727623; Wed, 01
 Apr 2026 14:25:27 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:25:25 -0700
In-Reply-To: <2026033039-occupy-slush-db02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026033039-occupy-slush-db02@gregkh>
Message-ID: <ac2NRUTLk-yX13va@google.com>
Subject: Re: FAILED: patch "[PATCH] KVM: x86/mmu: Drop/zap existing present
 SPTE even when" failed to apply to 5.10-stable tree
From: Sean Christopherson <seanjc@google.com>
To: gregkh@linuxfoundation.org
Cc: bkov@amazon.com, fgriffo@amazon.co.uk, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-232865-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: A28BE380999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.

...

> Fixes: a54aa15c6bda3 ("KVM: x86/mmu: Handle MMIO SPTEs directly in mmu_set_spte()")
> Cc: stable@vger.kernel.org

Partially out of curiosity, partially to reduce the probability of future goofs,
why did the tooling try to apply a patch to a kernel without the Fixes commit?
5.10 doesn't have a54aa15c6bda3 and so doesn't need this fix.

I assumed that having an explicit Fixes would implicit scope the backport to
kernels with that commit (or a backport of that commit).

