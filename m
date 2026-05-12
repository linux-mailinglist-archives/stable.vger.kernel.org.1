Return-Path: <stable+bounces-245443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFBlMJ8WA2p10QEAu9opvQ
	(envelope-from <stable+bounces-245443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:01:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5E51FB75
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C5B53019E79
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48B35292A;
	Tue, 12 May 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQM4/MhH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3A2FFF8F
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587286; cv=none; b=CsQjyOsEF88ljNu4FDajMrIFqDUbhy2PE+VqhvqA0aU8ercXSvZL4O9DGPu1x4Z5qqVcjdaLhjNk7tLLfg3Pnu9Mdcxtkq/jV0358c1ER1DFsPwrgxWdKM39mY6T2Nw442D20k8v1a2O0xgpZ7qQgfxxjZr/e/DcSlyP4wE788Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587286; c=relaxed/simple;
	bh=0No6IID8rm6fS0X4sFuM3sxj0XtDEFhUS7zpgr8FZ9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvo63EThp865Bn9fJI+ynRiJaR3MVJslbPyNs9BTQiJHRsVb5frUgugRk6vW1wazG1ZQX/qWOoythg/yd+SlhKhSumviMwcdI1zp7h402JgtBGzepOF6Iht6PM6KtlGoLndeBk1cTs6mm2mS355Z5bfW4A8NGEWKQDiSEox8Xbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQM4/MhH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45562c41ec7so2223853f8f.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778587283; x=1779192083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9oOjzdEiOZwRxatdzHF6+rvqVpfWsUCo0ThZozNxD5g=;
        b=VQM4/MhHSIQNegIGBD+ZjszkY1u7kGQr4SlJ6JK8eKyVcDDuaSOC23Zs62WmbK4KsM
         TWkqeuVcVt6VInAMeO+tZI3IoEwDCUEzDmgnUSa0yk3VXuSAI/efDbul9VCETVrGi+6o
         aDhYLa4r7PG5Uk5W9AwWTerb99wXZnBcVcihvN3QDoDLWTRqP1NgAsElgVvP+py0Exee
         PXfGiMQtY/4INEdkLo65vxROFFuMmItpv7lmqbrmYFXhNIs5iQgtn8aP9I70BSaN2KgG
         zod/JA+pI7hKlsY1ohnNC202pV35ODHHbQc2BsgHGm06pTwE7mm34EBFMxX6VIaGoc95
         il2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778587283; x=1779192083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oOjzdEiOZwRxatdzHF6+rvqVpfWsUCo0ThZozNxD5g=;
        b=Et42gg7nmWXVdMwVtdR9e1uzTpJHe15PBBA40yfzUnG0fd+82AbuSGLHJT3d+AmcBz
         8rZ85zRB1bQbJJePGI+Y7HINL5seLkhcLfXX6bG4mHPpkr1Jm9D1dDAOI3agk/2ybCqk
         YCnenitKMS/ix1XZhvEBR9DSJVEksknA6FcrdTyOqk951eFqHXHnPM5WdlSQJMx493rr
         vMGU1SHri6ARymusN7HcooVg/p4fMSCai2IgiZAigPnj4dreN/N0hvWZuMkEZ2I2VnEO
         wQ8QnCsyg8Dxzk29PcEJPVsWSk5xjKDJuK92+IY/gYD+VxgHbJDwZoH0Vz5Uw2eg6q8F
         lnPg==
X-Gm-Message-State: AOJu0YwbLbUyrepWBOuN3FdlM0zZ5msErT6uJeucrWqP9ULIyEJPqz8p
	Upo38XLp0VVKGm/UNjM12TLtLRTT7lmSssS18ueJkwogcdyW/iYNHJVk
X-Gm-Gg: Acq92OFaKyrL0R9UO6/e0nmPXxquUG/EQd6OKYERtk0qkMGLeLc8owujKsP3KRKf6JV
	toon1epVosnKA4NCUwOI/dAx4fgWUcmeFfLUyDUXuXioz+eNOZtlRsWbJL1AzmzNgbzDmXvjfcu
	7RDDMhVGo7nJlKvL8Z5Zp8WQcydv8OrKNTTwj/W5OGxZfvaLXOvXlkGKJw+t9lIv9ICvzheETDb
	rPqv8JfNu0Egl60EniXtMr8u0A8fKW6R3slF8O5MiB6lQd1nCrpFnWcMwcfhNJWl3En0vJGVA4f
	Tr1buMkibVQ5xKfUpkqNXkD6Zh3vTLkGtC5kkPF2CdkEehGYfUZpR7E3Htvtc4FOtgDq4qR5ra/
	PamMEpnnyx+ReDb0cjVQKMdGCX2Vd0L/wZjxUDrCBvTW7NAswF6dHWWs+H1pJzDyM8tNrSVUnJ/
	gse/WwyFW0lSZPdg2FlWOZ7Z1lVvnPuMJczr7UNPQF05V5TsbkLI+To0Xfbnkkle/3kHRvfQDQU
	8xnJRaTNeJZlCHZ1FHMBCmeTdYHgUzaOIfqd58RpZg4l9bKBaEZlC0HNSDojL8H9WU7ST0Y6kJi
	iaHop66j5lq6S4LlqAwGJ1OFHgarLn2cAftI7m4sfjnBvGEYZcGO2Q==
X-Received: by 2002:a05:6000:2f81:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-45b14adbd25mr4058105f8f.22.1778587283109;
        Tue, 12 May 2026 05:01:23 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00850765ba98b5d107.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8507:65ba:98b5:d107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491cab9c2sm34014175f8f.31.2026.05.12.05.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:01:21 -0700 (PDT)
Date: Tue, 12 May 2026 14:01:20 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: Re: [PATCH 6.6.y 00/10] bpf: fix precision backtracking instruction
 iteration
Message-ID: <agMWkBRLad7Znbe-@mail.gmail.com>
References: <cover.1778516196.git.paul.chaignon@gmail.com>
 <20260511220000.stable-reply-item002@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511220000.stable-reply-item002@kernel.org>
X-Rspamd-Queue-Id: B1F5E51FB75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245443-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 08:17:53PM -0400, Sasha Levin wrote:
> On Mon, May 11, 2026 at 06:21:22PM +0200, Paul Chaignon wrote:
> > This patchset backports commit 41f6f64e6999 ("bpf: support non-r10
> > register spill/fill to/from stack in precision tracking") again, but
> > this time with the subsequent commits that improved the efficiency of
> > the verifier. In addition, the last two commits fix and test a
> > regression that was later found in commit 41f6f64e6999.
> 
> Queued for 6.6, thanks.
> 
> I also separately picked up 69772f509e08 ("bpf: Don't mark STACK_INVALID
> as STACK_MISC in mark_stack_slot_misc") as a follow-up to patch 3/10
> (eaf18febd6eb).

Thanks! I had missed that one. I can confirm v6.6 BPF selftests are
still green with that additional patch:
https://github.com/pchaigno/stable-bpf-ci/actions/runs/25726612531/job/75540955361.

> 
> -- 
> Thanks,
> Sasha

