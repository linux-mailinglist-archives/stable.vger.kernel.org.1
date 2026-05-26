Return-Path: <stable+bounces-254271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ2+CS9WFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:13:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 762D95D246A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C7C3014C26
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A618F3CBE74;
	Tue, 26 May 2026 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj7A7cr/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612903451A7;
	Tue, 26 May 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783210; cv=none; b=NNbKIPOuJENfqEiFrImtoGQ34hukrmmWjEi7eIlMB+8LaO3TIeqS4rke00O0LfkeIzDeKe+4tZZLJmSFZjW9EqfKDmNZuUqp+TtFu8bTCg0xvlFZYrLr1LlqYatSBZYmRxyDhmU8oQJ1pRTZXwRdTJ2Y3U4LRbKiv40iFQV71/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783210; c=relaxed/simple;
	bh=gNFotZlUn7NOxnUtv8cc5GGjTN7uQeITMDr/R2YTNV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pRWVf95rJhMJFZKkWAccGX925A3ERl+tJBnFnMOzDb1AT0vVlQ5dZ9m33OvKkXGvOIjBpWwc6CALBCxjHWjN9AhzM6HuTp8RZyeATFNt1xgLMr3HerqPh59KZyMKcJGN4jDpFLoE5N5aFxcpGp5OF8NwG8eUDPV/+YnX6R7wmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj7A7cr/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA23F1F000E9;
	Tue, 26 May 2026 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779783209;
	bh=9VfrhdPCKB6wZtOv0TCXHtVXnKJzthg/PA3HN52ynpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kj7A7cr/O5YRznNGiCke31+F3QzAX30XYATNgSuqJ3tffmO/SgkbjcCfagokkQHLP
	 q5RYYTOEnvaCQvc6hUZy0k3gSYgKEfpyZM/aQMj4LBm9k3ZGsRqtxmLSegvftT51hp
	 YxARg9ouzjB1rH8ZjT2/lYwBiCMVyrvZKY4DuY5Ay9cS3PAZ1MNqe3RbAECzf6Saya
	 m4FlUgWKQUBrxxIifHvxXMNij/9flLcDRu0ytj8KQXdCQruo6x7sWwCpF/gLT8XzpB
	 nq9iWUxzU+TccGDPSQ54+4Hvx+UNjFcmUFSQwoZQ/PDoJOerPMKvzdbaCgvseWoG//
	 Yenh2M6oJWyxw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Pratyush Yadav <pratyush@kernel.org>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: validate session type before performing
 operation
In-Reply-To: <177978294141.4088010.16047486364171482805.b4-ty@b4> (Mike
	Rapoport's message of "Tue, 26 May 2026 11:09:24 +0300")
References: <20260519122428.2378446-1-pratyush@kernel.org>
	<177978294141.4088010.16047486364171482805.b4-ty@b4>
Date: Tue, 26 May 2026 10:13:26 +0200
Message-ID: <2vxzldd66121.fsf@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254271-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 762D95D246A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26 2026, Mike Rapoport wrote:

> From: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> On Tue, 19 May 2026 14:24:26 +0200, Pratyush Yadav wrote:
>> The sessions ioctls are not applicable to all session types. PRESERVE_FD
>> is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
>> valid for incoming session. Calling a incoming ioctl on an outgoing
>> session is invalid and can cause file handlers to run into unexpected
>> errors.
>> 
>> For example, a user can create a (outgoing) session, preserve a memfd,
>> and then immediately do a retrieve without doing a kexec in between.
>> This would result in memfd's retrieve handler to run. The handlers
>> expects to be called from a post-kexec context, and will try to do a
>> kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.
>> 
>> [...]
>
> Applied to fixes branch of liveupdate/linux.git tree, thanks!

Thanks! I will test the selftest update that Pasha suggested as a follow
up, since that will be content for liveupdate/next.

>
> [1/1] liveupdate: validate session type before performing operation
>       commit: da7f658ccc8da60d836051a7af1c53e643f4bd11
>
> tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
> branch: fixes
>
> --
> Sincerely yours,
> Mike.
>

-- 
Regards,
Pratyush Yadav

