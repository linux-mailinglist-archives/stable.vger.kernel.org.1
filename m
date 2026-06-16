Return-Path: <stable+bounces-263656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lq2nC5oiMWpVcQUAu9opvQ
	(envelope-from <stable+bounces-263656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 12:16:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F168E1AE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 12:16:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EAAmH78+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263656-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263656-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48D68300AD5C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B844CF4F;
	Tue, 16 Jun 2026 10:11:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603644CF25
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:11:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604690; cv=none; b=LCVbvI1HGs4viidLdJIsvA9C2PVbBbXJGP5TAVfVAlgmb1/GLe+kaHSoWM4b9bNfXgiKsEYKbWTnVaxjG3A0x6lhf/bWQwsJrgObmdGCGdWSHhjWkpp0TovUKE9PcCljPd93qTB4+W9OONTTqfVhh8o0pEVZMNNCjlTFgo75peM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604690; c=relaxed/simple;
	bh=EjK9bOT4HxhDpI2JWZDdTH2Qo6aFDccf6h//ov0/4Kk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=UF8N5NehNdM2ipxkrZJxKfCfsAQVqWyX03FqEju0XDLOW5d/qmcQGz5IYJDQfV97R57DX1KlF386+GISf7lzMyFz5DdnlZnsjypu8FVrWmzYQ5FYeMLlZb0HBaunWq785vgidSpd+TMGxlPybS8QVS5+0MPBt4Aetq8KSIWyuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAAmH78+; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c40397e746so26018265ad.3
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781604689; x=1782209489; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EjK9bOT4HxhDpI2JWZDdTH2Qo6aFDccf6h//ov0/4Kk=;
        b=EAAmH78+6LKt8AEpSpjsEorZmAj7+efTv6XZ6AEMFgWjBeZs2mJmIFD8gf00YhKd8n
         tF3P//0JAF6hUuSgMFMr6p6f8InVyT6CVeWEzN5hZZjm0jBDmSxmNJzZnD4jMsB2H8zX
         6JQXE3JouOedhaRgyRjGQf/jYW2VTrm2CGiHtsHcRJH83fA4x8ZrtVY3KAcQTBWi98Mc
         2XHVDRIFGxzXU7asJcN20SGNcF25twGeETd3aH1HSISMkY6huTwN0o3vYVH2eXzGTBm/
         Zw63cxbhLy9kuL1sSW1vB0guspBcpw4s0jdDaQAlfeu8m5KT3A3aHKloBMF0L4UwLUHq
         Cnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604689; x=1782209489;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjK9bOT4HxhDpI2JWZDdTH2Qo6aFDccf6h//ov0/4Kk=;
        b=q7Gz+zVZN/nZpUbLxiEob2xj3KaWnpa6zfcqw8iiHWb96xUCxslBCx+G+E8RlKGiGB
         iosETNVZWsbXIs3W46yEF/biB3AjFePqDqYBSamy+RZI37qIjzezO3qHyhhPI+7o/07y
         f3hIqvJnNYsmWl6P4iGj8vORKoSv9bjtSvB3abFvw/amrsM8cyPsLGvHfQPrHgM5HGwB
         ufbePSdB+jBDtK1SqDnUiWbZo+036MrZpPRvXUB/hKr5PId4asqUYS3MUPcg0s7NSiUX
         tBhQ4wlLVW42njoJ9qYO9q9ZIwTk25INDrBEu91en/mQNKMOCwUlNFeLjMF6JtCDVYME
         IXlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jC7lkM5O0tUSAGCW//Yv++flnyNvAVX6UqoFsXlSaSnjhQrlyHyFZOrUnWOEFlqpV7J7lNwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvk4BEpQTc8U5epro0P0JfupPWOduFISoDhlhv42g+sWaiqxhM
	kMc4abS24AtrGsKwB+PZyCeSqVMX7tp3WenSfNuDZMe4+g2mPcWmS0pI
X-Gm-Gg: Acq92OEE1HR9++VkbQzTcwpXhqpmABNhu5pml6M6Oq79D1OlO9KKn3NoMq3QOqwv2LD
	x7NySFU/x2ykpj+MD/6lELTfXfjIUvFOgacC6BzgwIsQY+LYbLshy6W37djmI0EeabSsn1pNCfu
	XZkOTec4OKXnjvLNxfzL1vRRFIwacZiW7oZOUtYOtp8TapyrUWEYgbeWatEDSTxXyZaPUvsGBZy
	EBBOhYv2NI02Vhk8K0qnNSsV6Ra3jH5q9AoOp6ppQe253z6tIbizmFlYsSU6DVZCmzmrHEUrWhk
	BOAWCpS0a7Q06zLq0VEcgJg1WJ8a/nOrZ3Z14jIY6H6hCmIV2GoRhopum/eYCfmwTZTjBjSxxUC
	+VYjKJVF8gJQpH7B07SH9kYGLQsoCHdDF/2pz2YD/6ixFhipMuBueuR1sjgLSI6Q9Jq4uOKJsQW
	UQ8N85SDOKf376GRd4H0sbe6U9KQ==
X-Received: by 2002:a17:902:ef0b:b0:2c0:f807:9bf3 with SMTP id d9443c01a7336-2c69a142023mr30873995ad.10.1781604688658;
        Tue, 16 Jun 2026 03:11:28 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8ce89sm128713805ad.57.2026.06.16.03.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:11:26 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v5] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
In-Reply-To: <20260615091120.84169-1-gautam@linux.ibm.com>
Date: Tue, 16 Jun 2026 15:39:39 +0530
Message-ID: <bjdaeqzg.ritesh.list@gmail.com>
References: <20260615091120.84169-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-263656-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gautam@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:seanjc@google.com,m:amachhiw@linux.ibm.com,m:harshpb@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 293F168E1AE

Gautam Menghani <gautam@linux.ibm.com> writes:

> Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
> cannot be used for KVM guests at all, unless explicitly enabled on
> host kernel.
>
> Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> being used.
>
> Cc: stable@vger.kernel.org # v6.13+
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v4 -> v5:
> 1. Drop the fixes tag (Ritesh)

Thanks. LGTM, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


