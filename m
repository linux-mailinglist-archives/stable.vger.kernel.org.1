Return-Path: <stable+bounces-236082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJzlJrvr3Gk0YQkAu9opvQ
	(envelope-from <stable+bounces-236082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:12:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351373EC6D2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E666300C0FB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599C43CB2E7;
	Mon, 13 Apr 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKnUFuCl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E93CB2DF;
	Mon, 13 Apr 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085945; cv=none; b=I8sfMuxM3L10ikvGScwOQxJXTD9pDBfvRVmFJL723K7ejXefOWgeVM7uB5KXjr8Jxk4bibN15qwwxLlL5UHVXYPsryJKTa9+6dxqmqYnoP2OSh33eKl+WIegEEi6ESgaFc0+CkcuNxsAQHhZYS3FyKJaq4PV99U0QXBahwJMG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085945; c=relaxed/simple;
	bh=UHZFVzdoCXmQFRk9A/R0zhGTxhJDLka4M03QOaOa4UM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dde+Zazp34bSXX+IXLCwDn10IqbJnURoiHB7N6dINkRxRkpxIOTyUg8Re9NDfalIAVMbFcVlrh+v8oZhEr5ERAIt+gPIowjP9RPPCgLKPNBgJJwmJEDkRv0dfI1FDfrFrTebXCeJi1U6wW9K2Xt1Y7sYZW2aadt/t/FpoIH1Kho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKnUFuCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A980C2BCAF;
	Mon, 13 Apr 2026 13:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776085944;
	bh=UHZFVzdoCXmQFRk9A/R0zhGTxhJDLka4M03QOaOa4UM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aKnUFuClJm5nwOF+zkveF8qfYQ7Ffsj/x2C9dffwv6qelVzIk1T3nOBpfVSceyx5L
	 wg6hLxRqIP0o+j6c+E9iAlGLwuOkghGx5M8JTgc3p0dMl/p9xhM6PFZCIfQHzEIfDa
	 Tp+3rjWZB9cVV85FvM9CApAW43XsByMcfmYez91QaOMpeQEEmb3IOdZaUVSs+iE5KN
	 FIuNfYTfC7MkhbgVD5rjTwwBHYHSO1TksOhJa1QUqepCvRqz6d6jPc2BPfYo9j6SYP
	 0l8bwCikVLUh7yhf8Vb6QK8vf8LDr8O+g/gd9Y7S+dTxHPiCuCi0QsGqsSsBIVtMVj
	 fJWrzfLGuJa/A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kernel-team@meta.com,
  stable@vger.kernel.org
Subject: Re: [PATCH v2] kho: fix error handling in kho_add_subtree()
In-Reply-To: <20260410-kho_fix_send-v2-1-1b4debf7ee08@debian.org> (Breno
	Leitao's message of "Fri, 10 Apr 2026 02:03:03 -0700")
References: <20260410-kho_fix_send-v2-1-1b4debf7ee08@debian.org>
Date: Mon, 13 Apr 2026 13:12:20 +0000
Message-ID: <2vxzy0ir80nf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-236082-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 351373EC6D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10 2026, Breno Leitao wrote:

> Fix two error handling issues in kho_add_subtree(), where it doesn't
> handle the error path correctly.
>
> 1. If fdt_setprop() fails after the subnode has been created, the
>    subnode is not removed. This leaves an incomplete node in the FDT
>    (missing "preserved-data" or "blob-size" properties).
>
> 2. The fdt_setprop() return value (an FDT error code) is stored
>    directly in err and returned to the caller, which expects -errno.
>
> Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
> out_del_node label that removes the subnode on failure, and only setting
> err =3D 0 on the success path, otherwise returning -ENOMEM (instead of
> FDT_ERR_ errors that would come from fdt_setprop).
>
> No user-visible changes. This patch fixes error handling in the KHO
> (Kexec HandOver) subsystem, which is used to preserve data across kexec
> reboots. The fix only affects a rare failure path during kexec
> preparation =E2=80=94 specifically when the kernel runs out of space in t=
he
> Flattened Device Tree buffer while registering preserved memory regions.
>
> In the unlikely event that this error path was triggered, the old code
> would leave a malformed node in the device tree and return an incorrect
> error code to the calling subsystem, which could lead to confusing log
> messages or incorrect recovery decisions. With this fix, the incomplete
> node is properly cleaned up and the appropriate errno value is
> propagated, this error code is not returned to the user.
>
> Cc: stable@vger.kernel.org
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

--=20
Regards,
Pratyush Yadav

