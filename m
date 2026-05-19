Return-Path: <stable+bounces-249612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6APbGjV1DGqihwUAu9opvQ
	(envelope-from <stable+bounces-249612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:35:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAA8580A5E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36634303CC2E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B005335201C;
	Tue, 19 May 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieTKkMkI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70857409634;
	Tue, 19 May 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200991; cv=none; b=n5aqXCNTwXl2K3V6RNcTngpF0W0CK7cu9pvlA2DK1PYNEO4+4kGqLwp5rkBdgeV2vpYLWW/nMXwXQBkM4JYhEbtck478vfTOTAoKSd95RPJros94FHH0cUpPSXMe5aLMyaUAcVNFy3OkNTwhqEs5rrFn53mhLiRoFbSAB1LjC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200991; c=relaxed/simple;
	bh=wpYoLkXbZ09JzWdvWlJaLOcA/ezxAkZJMM14JmrXOeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBT4ZmDJr3AAAPR+1BT3Lq3v18Or6OXQDxFJfLG1BUhbB4pkYvLkljY352mn/fOHylhQHfD8H/CUh4TMpW/ifhnwyqOPyt/9iDIB5opYoSl+C0l/NS4TI8gUc/UbjqtUlPNlXyJJak+FrkWzeWTTepzrOYSMGrAPHQecDOZmf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieTKkMkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE54C2BCB3;
	Tue, 19 May 2026 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200991;
	bh=wpYoLkXbZ09JzWdvWlJaLOcA/ezxAkZJMM14JmrXOeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ieTKkMkIGrPorjzAIC4Qowt46zqplcOBeUNq1ZB3HqLlNbHueXrmtCW/ZkgG0EbTh
	 da9NpHNjB4JmLOePSe7mAZffwVia+K5LpQ+R9okatjch7uJynWL+BHhiJL8asUZN03
	 UGRfIveprZCY6DLtutBFKcGgDFP0DFn6m0pAmBfjqZm7qym1JF8c8XmeQQVBisXfNp
	 AVAVw7TFaLjdxxHF6O+rCUv+i9z2qy5tL7Y46XXddbgMP1fdmT3eHkN+B2qWsv5n7J
	 Wya8na+pgNRBx4iVhGW9AiQXq2KTI6SaZjljOl4nYEIpVQCFrGj4NJPIj6vwDU/6eI
	 FMom3pl8gSKrw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: validate session type before performing
 operation
In-Reply-To: <agxuNavjtB8T_xRO@plex> (Pasha Tatashin's message of "Tue, 19 May
	2026 14:11:26 +0000")
References: <20260519122428.2378446-1-pratyush@kernel.org>
	<agxuNavjtB8T_xRO@plex>
Date: Tue, 19 May 2026 16:29:48 +0200
Message-ID: <2vxzfr3n8obn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249612-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BCAA8580A5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19 2026, Pasha Tatashin wrote:

> On 05-19 14:24, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> The sessions ioctls are not applicable to all session types. PRESERVE_FD
>> is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
>> valid for incoming session. Calling a incoming ioctl on an outgoing
>> session is invalid and can cause file handlers to run into unexpected
>> errors.
>> 
>> For example, a user can create a (outgoing) session, preserve a memfd,
>> and then immediately do a retrieve without doing a kexec in between.
>
> Please add a self-test tools/testing/selftests/liveupdate/liveupdate.c
> to verify that outgoing sessions do not accept retrieve_fd ioctl.
> Option, you could also add to luo_multi_session.c a test to verifying 
> that incoming does not accept preserve_fd

Right, forgot about that. Will do.

>
>> This would result in memfd's retrieve handler to run. The handlers
>> expects to be called from a post-kexec context, and will try to do a
>> kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.
>> 
>> KHO catches this (thanks to KHO_PAGE_MAGIC) and returns an error, but
>> since this is considered an internal error and KHO throws out a bunch of
>> WARN()s.
>> 
>> Associate a type with each ioctl op and validate the type in
>> luo_session_ioctl() before dispatching the ioctl handler to make sure
>> the op is being called for the right session type.
>> 
>> Fixes: 16cec0d26521 ("liveupdate: luo_session: add ioctls for file preservation")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

