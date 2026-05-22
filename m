Return-Path: <stable+bounces-253729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN8NO9ghEGpzUAYAu9opvQ
	(envelope-from <stable+bounces-253729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:28:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B78E45B12DB
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C79A3045A99
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756FA3C3BFA;
	Fri, 22 May 2026 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iCYWYN5l"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A65D3C583E;
	Fri, 22 May 2026 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441880; cv=none; b=hvpfKwyimqSKNAvgdeD+2aQ68m1gSMfCx0GpJ+5mbx7b2oKp2huyCcIAGMhewcQCd8kUxOvD/z78M0EUxyTVkWXRCpLA4JJOCtMb1TUD0zC/Yov9mxadw2uDKYzrRDM4wZdE5/8eG4UopSgUe15ulTTVWv9FSYf4s9fCiCWcx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441880; c=relaxed/simple;
	bh=IlIT09SoPl+Nbv6R7Drfam2i2Sx2BotaTLGM67AHgfU=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=kgcRvgvTGspCM11DySfDc+nXMj6M+dlQk1KNixcgS6o9ntrzIMuH49BQJfQ/3gQ6uZu8dcjQBAE+G9vXQypmskUlIMVqDJH2VidvEldEamoPR0g/KEGLs+NcxOXwXrow2/QuZtZJLJ8xtnNcTgjmshc99kKL6nC2VDpwnOxsTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iCYWYN5l; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=Yvz3W8qeDJQgLOm+dd/eWz+WbU65vy7qaLT2vCMPAXU=;
	b=iCYWYN5lR0jexGLxqsVqBYZdfRd+zfafKN7tINhrq1uC8PDedc6yC2bNKeHZ2A
	CNB4t+gzSXe9vlVTbOv4tIVQTQvedR6p0m0S+XxzZgaBNNejn8JWz9pAEWu4hqtZ
	6FFm4gj7WUwbqipoWIHtkrpu4Jg/KuzPyNN5k3PBsWhJk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3F4iXIBBqe8hBAA--.15141S2;
	Fri, 22 May 2026 17:23:36 +0800 (CST)
Message-ID: <6A10209C.9000602@126.com>
Date: Fri, 22 May 2026 17:23:40 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Mateusz Guzik <mjguzik@gmail.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
 thomas.weissschuh@linutronix.de, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: Fix lock leak in replace_fd()
References: <20260521074934.49256-1-zenghongling@kylinos.cn> <m3xus4s4xup32v7ijjolq6p3tlrj3bpwettldpqwxcwxanfvyt@5ihbtgch7liv>
In-Reply-To: <m3xus4s4xup32v7ijjolq6p3tlrj3bpwettldpqwxcwxanfvyt@5ihbtgch7liv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F4iXIBBqe8hBAA--.15141S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1kJF13JF1DWrW3XFyrZwb_yoW8Ww43pr
	yFgayvkr4UK39rXwnru3W5X3WFv3sxJr45Xr1Fq3WrCFyrurnYgFW5Krn09ryIqrn7CFWF
	qr4qqFW3ZryDZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4Q6LUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrxjMnWoQIJjxmQAA3M
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kylinos.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253729-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongling0719@126.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[126.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[126.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: B78E45B12DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

   You're right - I missed the __releases(&files->file_lock) annotation
   on do_dup2(). My patch would cause a double-unlock bug.

   Thanks for the correction. I'll verify warnings more carefully next
time.

   Sorry for the noise.

   Hongling
在 2026年05月21日 22:45, Mateusz Guzik 写道:
> On Thu, May 21, 2026 at 03:49:34PM +0800, Hongling Zeng wrote:
>> In replace_fd(), the function acquires files->file_lock but then has
>> two return paths that don't release the lock:
>> - When do_dup2() fails (returns negative error)
>> - When do_dup2() succeeds (returns 0)
>>
>> Both of these paths return directly without unlocking files->file_lock,
>> causing a lock leak and potential deadlock.
>>
>> Fix this by making both error and success paths go through the
>> out_unlock label to ensure the lock is always released.
> do_dup2 always releases the lock regardless of return value, so this
> patch cannot be correct.
>
> that aside, there is another consumer which would also need patching if
> the issue was real
>
>> Fixes: 708c04a5c2b7 ("fs: always return zero on success from replace_fd()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>   fs/file.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index 2c81c0b162d0..d0f019fb0568 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -1361,8 +1361,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
>>   		goto out_unlock;
>>   	err = do_dup2(files, file, fd, flags);
>>   	if (err < 0)
>> -		return err;
>> -	return 0;
>> +		goto out_unlock;
>>   
>>   out_unlock:
>>   	spin_unlock(&files->file_lock);
>> -- 
>> 2.25.1
>>


