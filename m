Return-Path: <stable+bounces-59254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CDE930BB9
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 23:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEFF1C20919
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 21:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29713D502;
	Sun, 14 Jul 2024 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzNu9N00"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B239FFB
	for <stable@vger.kernel.org>; Sun, 14 Jul 2024 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720992153; cv=none; b=DnihlOxOw92jMoYWO79cyzhQJ0K5Qrt8VkOI1PdVSDePqgtIw1xncNTO/40PPHqikkP5pa2vIvHhPpvbQd7mKMVyqkwsUYcmOjH4JjhCS5Xfl43FB8TB+ycjsJhXKg/2sdCTml6iIPNHUMwAKlRZZfcnJPwSFhbJ49Z2N5KOmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720992153; c=relaxed/simple;
	bh=vKD/TNIuSbtKYd6Zp56DM7HlFS8eYqYF5AU7zSkqk28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLDhF5XEyNBWu8IwuUtj9GF7T3ik0OTWojUTDA1MC67Qu2WwCvkkycUwTyLfaJHyskqubCqwhZSU+0CKsRBOctno+asvqH9dKQFkKPhJZGRMhGA2Rsj2S18EDY0kV19+PtR8lt73XRrC668YYjDp3KiEaR7CclYfv4sS0pcqY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzNu9N00; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720992150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Jsf3Y4yAASGYlRBZy3z4CBbem53stHoJnpwOr/q7Pw=;
	b=CzNu9N00TBBgMR8lGeiP24xWHb0M3xkCjGJjrOSX4Qmo44bLUTO9o87cRBWLkbNAQqHJ11
	W2X9XQ1Qi45aD32wlwhZaG9paOMJkNsFJVtqEBa/x/C0e8XWJyynd/bOxBXDIjp+h/ylMj
	BIu2yhTmn8nXyoyip728GrrbB+gzMc0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-6J9ZapRkMbKYyIGbdPmJ0A-1; Sun,
 14 Jul 2024 17:22:26 -0400
X-MC-Unique: 6J9ZapRkMbKYyIGbdPmJ0A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5B92195608F;
	Sun, 14 Jul 2024 21:22:24 +0000 (UTC)
Received: from [10.22.64.27] (unknown [10.22.64.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72ACC1955F40;
	Sun, 14 Jul 2024 21:22:22 +0000 (UTC)
Message-ID: <fff79c2a-d659-4faa-83e2-e36c2e2bda2b@redhat.com>
Date: Sun, 14 Jul 2024 17:22:21 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ext4: Forcing subclasses to have same name pointer
 as their parent class
To: botta633 <bottaawesome633@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-ext4@vger.kernel.org, syzkaller@googlegroups.com,
 syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20240714051427.114044-1-bottaawesome633@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240714051427.114044-1-bottaawesome633@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7/14/24 01:14, botta633 wrote:
> From: Ahmed Ehab <bottaawesome633@gmail.com>
>
> Preventing lockdep_set_subclass from creating a new instance of the
> string literal. Hence, we will always have the same class->name among
> parent and subclasses. This prevents kernel panics when looking up a
> lock class while comparing class locks and class names.
>
> Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
> Fixes: fd5e3f5fe27
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
> ---
>   include/linux/lockdep.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 08b0d1d9d78b..df8fa5929de7 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -173,7 +173,7 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
>   			      (lock)->dep_map.lock_type)
>   
>   #define lockdep_set_subclass(lock, sub)					\
> -	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
> +	lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name, (lock)->dep_map.key, sub,\
>   			      (lock)->dep_map.wait_type_inner,		\
>   			      (lock)->dep_map.wait_type_outer,		\
>   			      (lock)->dep_map.lock_type)

ext4 is a filesystem. It has nothing to do with locking/lockdep. Could 
you resend the patches with the proper prefix of "lockdep:" or 
"locking/lockdep:"?

Thanks,
Longman


