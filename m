Return-Path: <stable+bounces-116617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B96BA38CB0
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 20:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594DD1892AE8
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F857233D7B;
	Mon, 17 Feb 2025 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="iW8Osr9B"
X-Original-To: stable@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272E198E6D
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821573; cv=none; b=PvcLZkM+3Njr5kAjt1Qhdc/XDdrniqfqcq1PdWIwoLA2uxXOsrCoAE0w6o4OMzqVMDo0Pfh+jUFey/ly2QIP1qkXAQ2DZUAiJytGnUeY7Swuei/MNbHI2yBmppKeC0pFjy0QBT+eqoukrfSIZ6+rWU1z4YadWXCs0RlEgTU/NIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821573; c=relaxed/simple;
	bh=Jvpl4e2kTA2BjtsoNl/JaVnKq/mGFfybRCrnvtF4Lk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKtier6nV6gXCGmcbWcJlEQpywY4IbgZlpV3Un9hZQitTWhPHNuywZ/KswmkbFDQAUvZeWVH92bQGgBW7jaHH+Opw+rZLdi2CfwT2HKwXGcBbKJEMxmwci1UAG5O/HQ4mtRBS/fiKRx272egfpwxXlC135Aff6uA8peP86JGqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=iW8Osr9B; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tk74C-00Ec5K-RA; Mon, 17 Feb 2025 20:46:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=UtnNLBavpDfR4PoGCVQC6Xy6NA3yJJlyyOk/O5j/Bz0=; b=iW8Osr9BwROtuiGyKUnhDRd7gO
	rUVRnpFF8WYjhPkif7AMqo/IE4IHKUqNRXAn+AiVWWYAx6L66JxXZm8BsaksPbMdFPgyrToWdiX3/
	kQ0ngnPqm/09Y1CNpaCJsAu8JBscE4suWwdBPJ4dJp5E+55Je/mmpBp+QBBnmjEjuIkxOVduLa0rO
	E6Nat9qo+w0p3mXkfp7N39MyaIw2q9RjHpld+eoUHSk3LTGG8sxSp9/h3Dk8QU0FB0peKfLfvnGmQ
	j6O7oRcg50xHz+RK3e9rZYuw57AoLzaQzQWs7NsOCQ6fQBrMLZQgy8cb7Vj70OmYEClnghc1ywkzs
	9eMT9R1Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tk74C-0005jW-7b; Mon, 17 Feb 2025 20:46:08 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tk743-00HFNo-Pz; Mon, 17 Feb 2025 20:45:59 +0100
Message-ID: <cf0ef7bc-4da9-492a-bc43-0c3e83c48d02@rbox.co>
Date: Mon, 17 Feb 2025 20:45:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] vsock: fix use-after free and null-ptr-deref
To: Luigi Leonardi <leonardi@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
References: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
 <f7lr3ftzo66sl6phlcygh4xx4spga4b6je37fhawjrsjtexzne@xhhwaqrjznlp>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <f7lr3ftzo66sl6phlcygh4xx4spga4b6je37fhawjrsjtexzne@xhhwaqrjznlp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 12:18, Luigi Leonardi wrote:
> On Fri, Feb 14, 2025 at 06:53:54PM +0100, Luigi Leonardi wrote:
>> Hi all,
>>
>> This series contains two patches that are already available upstream:
>>
>> - The first commit fixes a use-after-free[1], but introduced a
>> null-ptr-deref[2].
>> - The second commit fixes it. [3]
>>
>> I suggested waiting for both of them to be merged upstream and then
>> applying them togheter to stable[4].
>>
>> It should be applied to:
>> - 6.13.y
>> - 6.12.y
>> - 6.6.y
>>
>> I will send another series for
>> - 6.1.y
>> - 5.15.y
>> - 5.10.y
>>
>> because of conflicts.
>>
>> [1]https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co/
>> [2]https://lore.kernel.org/all/67a09300.050a0220.d7c5a.008b.GAE@google.com/
>> [3]https://lore.kernel.org/all/20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co/
>> [4]https://lore.kernel.org/all/2025020644-unwitting-scary-3c0d@gregkh/
>>
>> Thanks,
>> Luigi
>>
>> ---
>> Michal Luczaj (2):
>>      vsock: Keep the binding until socket destruction
>>      vsock: Orphan socket after transport release
>>
>> net/vmw_vsock/af_vsock.c | 12 +++++++++++-
>> 1 file changed, 11 insertions(+), 1 deletion(-)
>> ---
>> base-commit: a1856aaa2ca74c88751f7d255dfa0c8c50fcc1ca
>> change-id: 20250214-linux-rolling-stable-d73f0bed815d
>>
>> Best regards,
>> -- Luigi Leonardi <leonardi@redhat.com>
>>
> 
> Looks like I forgot to add my SoB to the commits, my bad.
> 
> For all the other stable trees (6.1, 5.15 and 5.10), there are some 
> conflicts due to some indentation changes introduced by 135ffc7 ("bpf, 
> vsock: Invoke proto::close on close()"). Should I backport this commit 
> too?  There is no real dependency on the commit in the Fixes tag 
> ("vsock: support sockmap"). IMHO, this would help future backports, 
> because of indentation conficts! Otherwise I can simply fix the patches.  
> WDYT?

Just a note: since sockmap does not support AF_VSOCK in those kernels <=
6.1, backporting 135ffc7 would introduce a (no-op) callback function
vsock_close(), which would then be (unnecessarily) called on every
vsock_release().


