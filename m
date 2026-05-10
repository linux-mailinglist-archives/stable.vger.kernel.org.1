Return-Path: <stable+bounces-244991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF1zNe3d/2lP/gAAu9opvQ
	(envelope-from <stable+bounces-244991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 03:22:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC39B5021A4
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 03:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D60213002D31
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 01:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8E1A680F;
	Sun, 10 May 2026 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rtg7dumC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85354768
	for <stable@vger.kernel.org>; Sun, 10 May 2026 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376168; cv=none; b=H2T41EzFzSXB+JJAFoDml83yKHVmXpQ6nOq+YEChUpn3rNYu6hTx/A3w/x1kBYE4EsE0HH39kxOxvmpwYHtf87eD1s76Tp9IbsOEWq1/IKVeapeyfUHdOlUhADtglwRejqPJK4tirWvDlXrWPKmc8iY0mmNL667LhwwczGDPKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376168; c=relaxed/simple;
	bh=gaiCjuvl6DWIm0UPof/Di7bSB9es7/VNQSw7PLPJRyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeudvywTl+fEjMk1k2aLCVJTipkI8H9Ew5lMRv3pPb/VepUpgF4vKDyVLou+xB0eIoTvIzHo3f4v56V3h6D5G1sn4PnBSupiKJjsV6HAJRcTN+mYeSM8pI3m1SePuAbohBza2Bzs+WHN5VsTeIN8h9aQSOcbhy/4PNER30iZjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rtg7dumC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so5974981a12.3
        for <stable@vger.kernel.org>; Sat, 09 May 2026 18:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376165; x=1778980965; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIhWSVTY403il12RL/w6eCME3eB95/PHvNgqJ5h0N+4=;
        b=Rtg7dumCj1kM5g15LVSKn/ByQmj6WhMQ5s/zwDvmXub+EXUvq7PozEX1NbEetBIFhu
         VnUVNyqCrAT1E0I31olyYsbQnJIhxK/C4ZlzwpFuOebScSxUKzBhWCqRiLlP8po48Ak3
         NvWPOxW+AhMthC88eRyO9mBCsJ4TNXb9eMV5WUjzou2GFnVaSxFDKizW4dPfVJio9mHK
         2iLih7AG/RRsfTGRAUFstx1fjpRF6j+yD1eNN1zImfa60f69KDsAP9zVDNfe/LSuYxRz
         dKiqdyyxCb/X2DAKGAOyxmuhKMAnTZYkQpIe+qS7E7hg/BEHm3Cb4lhqjRVtmz59p1l4
         Wepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376165; x=1778980965;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIhWSVTY403il12RL/w6eCME3eB95/PHvNgqJ5h0N+4=;
        b=fW9IEOiHlimuYPyqtooWxrLA5c9nigm96VKPHsX/eCEeDLtQbvwUEeQC24XdK6ueVJ
         J2p3MMTZr87mKQox6Iw9X/OwPpDXi4sqhePnFueMzWMzsqk5QDCliizwYERHsUNMFy6y
         r9DBdEICEjpGggYk4RQZKAr7A8D+61KGBg6srE8iowM00A/zGUaZHR5WBDr24Zkf3Q1+
         pWsu4c9fvKuj10XzmzTzZfnQw4/xirf+JS/+XkoP84VqBGLnYQ99qAZZsbr2L7qcuXwy
         TdFdctliT7GPrc6B4wzzaZiZ4I89YVyeU38Vis7U9OXZel6g+z9LDuR1Gbn1q0Exv1ZS
         l7sA==
X-Forwarded-Encrypted: i=1; AFNElJ8QuvxDNwJ4ospMqbcmSgT/lOFFnWwM+Kg/314F0j3nAJxKyY8bBrusKHXl72c9AL4RYNHc0Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+D5TUHniDHwmS8/PHlAPTghLOVGQJJRlFQr2ZSaNb/e1Ceip
	fTMNgsoiQbL/KVUv0sjhSuHgu3rrxafejuHAHUJA+Br0I2ue3AP12HM2
X-Gm-Gg: Acq92OGbs+MkNdVnfAzWW5aUFTVC4pba9On7QujSkVvRMCHq8d8dw6O7KU3+NIT7BSa
	4zisaYMFuc+eqTGBgI4IpRCSYWmObQEG5onvcaSi+rXs41jdXa6cJtgaNvuvvE2BhbJ4bMNbJFe
	xXHs5RcySGCX1V7rCP40G7ZZvlY1IZkF/tzqyPeJmbOg82IC34Lb/YTR285lEQht0MxZWa5I0pC
	NxC8C0BHfkkjeN13NjDh47FZPvhFseTGpn+rVG5ZxL0KqzoZ/7GPDSLIeeJDR7Lg74XAzBPAGXF
	F/jYwEdRCN+GKn4nPAdtnOp/GAA/UaFDhg53i8cse38Rl9DrXDaU0GCXa7Ic9mPR1A75r40Dt6g
	UXwQRBA5/rr8bGKi4Cb8rw55g0j6tvcWf5XcptdUxbr2ZgL2cM5NubFrBFjMI7ae163uX9JJmJ4
	kT+vkOeCr10CvxGKJePAYhVMpgDwd9qwxi
X-Received: by 2002:a17:906:4787:b0:bb9:36dd:cd3d with SMTP id a640c23a62f3a-bc56ae2ca84mr1094557666b.4.1778376165369;
        Sat, 09 May 2026 18:22:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcb706b7631sm219272266b.61.2026.05.09.18.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 May 2026 18:22:44 -0700 (PDT)
Date: Sun, 10 May 2026 01:22:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, david@kernel.org, ljs@kernel.org,
	riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
	harry@kernel.org, jannh@google.com, sj@kernel.org, ziy@nvidia.com,
	balbirs@nvidia.com, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260510012243.sz2ex6hzlmdckmmh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <20260508145121.35e2552d403b94ea6f748b90@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508145121.35e2552d403b94ea6f748b90@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Queue-Id: CC39B5021A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244991-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,surriel.com,infradead.org,google.com,nvidia.com,kvack.org,oracle.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 02:51:21PM -0700, Andrew Morton wrote:
>On Fri,  8 May 2026 01:37:28 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>> before return the pmd entry:
>> 
>>   * re-validate pmd entry
>>   * check PVMW_MIGRATION
>>   * check_pmd()
>>   * handle on pte level if split under us
>> 
>> But for device-private pmd, we just return after pmd_lock(). This may
>> lead to improper situation.
>
>What is "improper situation"?
>

For example, in remove_migration_pte(), page_vma_mapped_walk() may return
device-private entry which is not a migration entry.

>> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
>> support device-private entries") by following the same pattern as
>> pmd_trans_huge() and pmd_is_migration_entry().
>> 
>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: <stable@vger.kernel.org>
>
>If we're to propose a fix for -stable backporting I believe we should
>fully explain to -stable maintainers *why* we're making that proposal.
>

IIUC, we may do migration on a wrong pmd entry, which may corrupt data.

>IOW, and not for the first time(!), what are the worst-case
>userspace-visible effects of this bug?
>

Got it, will pay attention. Sorry for the trouble.

-- 
Wei Yang
Help you, Help me

