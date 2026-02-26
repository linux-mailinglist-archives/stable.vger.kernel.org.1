Return-Path: <stable+bounces-219841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDKrMAScoGlVlAQAu9opvQ
	(envelope-from <stable+bounces-219841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:16:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FF01AE3E5
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83BE33003808
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0530544CF54;
	Thu, 26 Feb 2026 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ew7Gpeoe"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65833449EAE
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133377; cv=none; b=QH4H4DZ7VI8aAoVp6P7kxUl99CytKFEU1sQxGW04yfYULodwMMzV2xDCnqKgRFq3M7TtPwSap/tr1hqYrnyU/aZ++mqBlm6znPZX4CrC/geCagGdC8Bj2JnNWYGwy0lJltrhEwP+skEksOJm4un+oxieX78QSAsY58/JlJFqxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133377; c=relaxed/simple;
	bh=JMjBt5u7sej4DVzjxYdLv0Tmsl1bwwrLjR+ZWFoIyvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aP/GAZHPHEJBvhf2tPnUFmfhx2BJ8V+nzd74958kYTuBHtAoF8ku1pn4ggnV4IUllxTzuXucdx/TXLzXsNqXu+4vP15PDIi3KPSWuCUsGtddw5P1iJ1thiSuA6xrEH+WAcUp1SihkrWQBLTuNJxM2qLc8tQ38C9o4NoC+tpA1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ew7Gpeoe; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso1340208eec.0
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772133375; x=1772738175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6cgohktuZOIcDY88c+OYINW8j5SU2uouqkoEf/gCYY=;
        b=Ew7GpeoehlNqL1QTapNeXns3w3vWN7Y1uKLo0mQjbl8ITg+AWLdtka0PvGV4blo24L
         J/rMhGpD3Lvx7d0xp43kXpR42ZU8lbp2OgVtn1yP3QJZZgaj5ffl/VOafHr9eGZS0a5c
         hthIzD1Haize+dtoAh7Xwjqpkqhp+c7YjZjT1e3HfiU8Xifbl8ZqkJxNYueZ41bZoqpE
         6nycej0A1UHpJuN80SMQry1flH3NfCIIzuGg6t5HxPWDpB9MgxAzWHBqCOeEZX19zTbU
         SSfSPWKg7rfiwB59Kdx/kNY9xNscvtd1S0qe4WWW2e+SzPcZwLMkpbbQRY1VkHZjh0Xa
         WSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772133375; x=1772738175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6cgohktuZOIcDY88c+OYINW8j5SU2uouqkoEf/gCYY=;
        b=nRD60DEWqTjcFTlgG4eX/EeCE2ENL8EDJ9+TmxSXvpL75LElJTE+oZ1mjxcf2mILoE
         2ahLzRR1+Uc7jqajWYqU9mJMWTaBC88ICjbW0qPmFBJuN5hFoCNlLeM11DpZ8q0wHLDZ
         qLpjjgdTokOguI0PQggCk1cAp2tA8LmtA07JF58G3IC9zi58OoMTE7gw5kL8hKdtipWU
         nvgbqNgcskEt4QBOj9ytXvfJ37jSXiCQVYlxaPsTAy+A0grh9WRGveabEoOKEFQtKIJ+
         zhTYafxkZGF+vsHqtV+l2gbpSnKd5l5aWatYv/PhkSeznbFHTTnsqj5abqCmsTKWsxHo
         EBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCURMyGKHoVFY65krSGbKu9QelLR2KPH86+O89FQCA9cJ5yRcIyXi+C3kLGqTxOe84UtSS9pk5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTaK2cPSKZnPmMuyw40X43vz2CHCmt+wKmQLLot45B+kX1JZD+
	WCpbcB0VoJ8ONvf1aLS+rSgP/Kxrrj3fqoL5IBvN7kjk1v0vYkPg/csv+6Ftq35jtyusdN6vQ5Q
	cO6s76iNPYDubflCLMpAl2g==
X-Received: from dlbqc5.prod.google.com ([2002:a05:7023:a85:b0:127:5503:dc9e])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b97:b0:11b:9b98:aa4b with SMTP id a92af1059eb24-1278fb6859cmr37260c88.6.1772133375223;
 Thu, 26 Feb 2026 11:16:15 -0800 (PST)
Date: Thu, 26 Feb 2026 11:16:11 -0800
In-Reply-To: <5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260226191612.1962381-1-changyuanl@google.com>
Subject: Re: [PATCH] x86/boot/sev: Move SEV decompressor variables into the
 .data section
From: Changyuan Lyu <changyuanl@google.com>
To: thomas.lendacky@amd.com
Cc: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	kevinhui@meta.com, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219841-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changyuanl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 52FF01AE3E5
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 09:01:00 -0600, Tom Lendacky <thomas.lendacky@amd.com> wrote
> As part of the work to remove the dependency on calling into the
> decompressor code (startup_64()) for a UEFI boot, a call to rmpadjust()
> was removed from sev_enable() in favor of checking the value of the
> snp_vmpl variable. When booting through a non-UEFI path and calling
> startup_64(), the call to sev_enable() is performed before the BSS section
> is zeroed. With the removal of the rmpadjust() call and the corresponding
> check of the return code, the snp_vmpl variable is checked. Since the
> kernel is running at VMPL0, the snp_vmpl variable will not have been set
> and should be the default value of 0. However, since the call occurs
> before the BSS is zeroed, the snp_vmpl variable may not actually be zero,
> which will cause the guest boot to fail.
>
> Since the decompressor relocates itself, the BSS would need to be cleared
> both before and after the relocation, but this would, in effect, cause all
> of the changes to BSS variables before relocation to be lost after
> relocation.
>
> Instead, move the snp_vmpl variable into the .data section so that it is
> initialized and the value made safe during relocation. As a pre-caution
> against future changes, move other SEV-related decompressor variables into
> the .data section, too.
>
> Fixes: 68a501d7fd82 ("x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check")
> Cc: stable@vger.kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Tested-by: Kevin Hui <kevinhui@meta.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Changyuan Lyu <changyuanl@google.com>

>  [...]

