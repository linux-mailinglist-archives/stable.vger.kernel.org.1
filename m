Return-Path: <stable+bounces-245178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI1NHs61AWr2igEAu9opvQ
	(envelope-from <stable+bounces-245178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:56:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95B50C57A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A16F3043C15
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173E3C7E1B;
	Mon, 11 May 2026 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTyVZyDr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD0344DBD;
	Mon, 11 May 2026 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496756; cv=none; b=EpGkSZAcdsq3Bwry6paJUCygqB7GpJWwVSdbyrfbtHXbBd5m8PsPWPd00iWSyaRmh0xo3y9ftZiDw5oJrFt1Xa0wcaZF8KPMN1QRhTEFv+EfJGJspSeQ16HcsYryeZ5av1sL63jUygdlxPCAcWBQfycXMqhwgkGsMcG2rTY1Dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496756; c=relaxed/simple;
	bh=TK8vbFo3IPPLv3mDTVloWgVI8sIHrIme4x6bk2ipAk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RjvGaY4kXPAASle6ei6sDAg07BdfVlan2u4+wyh2OlVyb0D/m1UFAdhfnaE0hn2guuCXojr910dxI9XRweHkIvFp28sq43nujwTNbPs4JYiiyta17O4Ug/WMNfcMctTQVcY4Jg3N3k4Mtg52OPGVTKzLYuJn5Ezp0A5uMpho8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTyVZyDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC26C2BCB0;
	Mon, 11 May 2026 10:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496754;
	bh=TK8vbFo3IPPLv3mDTVloWgVI8sIHrIme4x6bk2ipAk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bTyVZyDrH7UkNmmXFlL5FS+6s4zqf+bpazGJAlPXifeAZ8X7sE9DaU/pNI1v4U9eb
	 kCQAWT/UzEjcN1f0/2/D2zFRQSjI77sYkCBhPwIBy7Z61/4WsVNDwHLALipDGzHujW
	 9BX3FGtxDjvy8cB9VAVWXUQv5e58a8nGVydKNnvoFe1iejsfAj7tlLI3ndwbuOJGcx
	 r4Re3dc954Sz3OAYCGPnF/vjVVw7YTLutZVXnX9lB6vFr9wqtiPdD82RYvhRtWbZpP
	 izQlWj02ahPVAq9st/RSBiDTxWgqlI7hW71LT68PPIpf/nA0Qgp+Nw/9563oeqXFlG
	 17tMMKszYRzyQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Hugh Dickins <hughd@google.com>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jeff Xu <jeffxu@google.com>,  Kees Cook
 <kees@kernel.org>,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Brendan Jackman
 <jackmanb@google.com>,  Greg Thelen <gthelen@google.com>,
  stable@vger.kernel.org
Subject: Re: [PATCH] memfd: deny writeable mappings when implying SEAL_WRITE
In-Reply-To: <04a4e82a-2479-45e7-92e3-047ac8365ae4@kernel.org> (David
	Hildenbrand's message of "Fri, 8 May 2026 11:37:13 +0200")
References: <20260505133922.797635-1-pratyush@kernel.org>
	<04a4e82a-2479-45e7-92e3-047ac8365ae4@kernel.org>
Date: Mon, 11 May 2026 12:52:30 +0200
Message-ID: <2vxz8q9qdxqp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: EB95B50C57A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245178-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,man7.org:url]
X-Rspamd-Action: no action

On Fri, May 08 2026, David Hildenbrand (Arm) wrote:

> On 5/5/26 15:39, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> When SEAL_EXEC is added, SEAL_WRITE is implied to make W^X. 
>
> I don't quite understand that.
>
> I guess what you mean is "SEAL_EXEC implies SEAL_WRITE if the file is
> executable, to prevent W^X after sealing".

Yes, exactly. If the file is executable and SEAL_EXEC is set, SEAL_WRITE
is also set to make sure the executable code is not writeable.

>
> Because if the file is not executable, there is no sealing of writes happening?
>
> It's rather odd to combine both things, though. Likely the callers should just
> have requested SEAL_WRITE.
>
> But I guess we are stuck with this mess.

Yep :-/

>
>
>> But the
>> implied seal is set after the check that makes sure the memfd can not
>> have any writable mappings. This means one can use SEAL_EXEC to apply
>> SEAL_WRITE while having writeable mappings.
>> 
>> This breaks the contract that SEAL_WRITE provides and can be used by an
>> attacker to pass a memfd that appears to be write sealed but can still
>> be modified arbitrarily.
>> 
>> Fix this by adding the implied seals before the call for
>> mapping_deny_writable() is done.
>> 
>> Fixes: c4f75bc8bd6b ("mm/memfd: add write seals when apply SEAL_EXEC to executable memfd")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  mm/memfd.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/mm/memfd.c b/mm/memfd.c
>> index fb425f4e315f..abe13b291ddc 100644
>> --- a/mm/memfd.c
>> +++ b/mm/memfd.c
>> @@ -283,6 +283,12 @@ int memfd_add_seals(struct file *file, unsigned int seals)
>>  		goto unlock;
>>  	}
>>  
>> +	/*
>> +	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
>> +	 */
>> +	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
>> +		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
>> +
>>  	if ((seals & F_SEAL_WRITE) && !(*file_seals & F_SEAL_WRITE)) {
>>  		error = mapping_deny_writable(file->f_mapping);
>>  		if (error)
>> @@ -295,12 +301,6 @@ int memfd_add_seals(struct file *file, unsigned int seals)
>>  		}
>>  	}
>>  
>> -	/*
>> -	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
>> -	 */
>> -	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
>> -		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
>> -
>>  	*file_seals |= seals;
>>  	error = 0;
>>  
>
> Given the weird semantics, this makes sense to me.
>
> Do we have to update documentation to reflect this? But staring at the man page
> [1] we don't even seem to document F_SEAL_EXEC?

I discovered the same when trying to read more about F_SEAL_EXEC. I've
never written man pages but I suppose I can give this a shot.

>
>
> [1] https://www.man7.org/linux/man-pages/man2/F_ADD_SEALS.2const.html

-- 
Regards,
Pratyush Yadav

