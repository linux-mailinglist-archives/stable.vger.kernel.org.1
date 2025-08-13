Return-Path: <stable+bounces-169465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1535EB2560D
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 23:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757231BC7920
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94E22ECD37;
	Wed, 13 Aug 2025 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lxDS+N9M"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6781E89C;
	Wed, 13 Aug 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122343; cv=none; b=ofmysM2986igu4ycPI0LHhQT0W2SjUBg1tQzeFgciI34w1gDTChqnQwdjInl4oCG1JSyzzYlc9hswcqPzrOmKxe3gqq3ni26E0x4Moy6vI4Qvm0yGrcHKlpMwiFE/0AFUyN/tXiRIl/1gi6mZebQrVv2nB3TOm5c1PRyhkViBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122343; c=relaxed/simple;
	bh=7uGLGYdsjfx6KGSsceGFnWc45LxnvnvtnTpjtN4oVTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdEqTiWmVgCroOlQ0wNqCYQ6iFYYwnwjppomNCs4pw9pLLWWCunwvZK7CVlIcsleMU2PEBV8om8VvYgWAJYFXOAmu1/XloxhQ5yoiXLcvb2JRGvtquSHRYcKgR8GeuzCbbtR0ddk6XMuMSL4fTAIMPN12h6G0rbqjefFLzaDSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=lxDS+N9M; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:5b47:dac3:aa45:a64a] ([IPv6:2601:646:8081:9484:5b47:dac3:aa45:a64a])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57DLw06P765108
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 13 Aug 2025 14:58:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57DLw06P765108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755122281;
	bh=nXQBTwyqB9t6cpucEWceyx0dfvy5zDVB162E3UNuLpw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lxDS+N9MyCNsYt8DOQ+03VTIw/0a6vDSD868tOXlwtUOiQRqMgbWIsTtXb0tpDHWf
	 PuK5v/A6NwdLcZo8pw5ehl/yiQ4XCDayVljOQL33q7oEb/ZqWXTYhguh4ddqnoIU2Z
	 +QFAw4sXBsB7K2F1Utp67RbFIkDuwxfztN8LNn3whdfBNgSvfzSs6y4c1mEJcUv74Z
	 YR9EsQXQoofmgx2O5nmoNhoL26Da8k20BUt0OGyg/NNVJ2uNxsxSnubKPX0M0H0kfk
	 Na8Ctm+iHWuCIWyxljQ8S1/I6YliPqCVUWG1jHhBSEnc3pqMD9MC4j6ACiSBX4T3GF
	 eDLHd0vAOxcMg==
Message-ID: <d0cac7d8-3036-4241-b11c-f005224daefd@zytor.com>
Date: Wed, 13 Aug 2025 14:57:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/fred: Remove ENDBR64 from FRED entry points
To: Dave Hansen <dave.hansen@intel.com>, "Xin Li (Intel)" <xin@zytor.com>,
        linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, jmill@asu.edu,
        peterz@infradead.org, andrew.cooper3@citrix.com,
        stable@vger.kernel.org
References: <20250716063320.1337818-1-xin@zytor.com>
 <e5a7d108-f900-4a63-8116-c9eb54171976@intel.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <e5a7d108-f900-4a63-8116-c9eb54171976@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-13 14:07, Dave Hansen wrote:
> On 7/15/25 23:33, Xin Li (Intel) wrote:
>> The FRED specification has been changed in v9.0 to state that there
>> is no need for FRED event handlers to begin with ENDBR64, because
>> in the presence of supervisor indirect branch tracking, FRED event
>> delivery does not enter the WAIT_FOR_ENDBRANCH state.
>>
>> As a result, remove ENDBR64 from FRED entry points.
> 
> So, the spec is being updated or has been updated to reflect the new
> architecture, right?
> 
> Remind me, are there no FRED systems out in the wild today, so we don't
> have to worry about breaking anything?

Correct. The FRED v9 spec contains this change.

All production hardware and late pre-production hardware will have this.

	-hpa


