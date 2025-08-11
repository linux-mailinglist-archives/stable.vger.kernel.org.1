Return-Path: <stable+bounces-167079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36424B218B7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 00:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B87B1D88
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8CA22E402;
	Mon, 11 Aug 2025 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="h9u9GPdv"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD711F0995;
	Mon, 11 Aug 2025 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952599; cv=none; b=NHG2Q2vYBL9SZdlIi92kote2/mxcdU1nDpCIfXupHmucniRJJ0Yx5LWDoW1Rgx0UYjlOza2EWiLkAvMpEn3teUkHy5H+f+B6GRGlD+ACyJ4/6+sLq0u8nRV+L9VZ6IT8j2EC2vc1N7L5ZROuhF6JPA817OW53iV47jh5mGAzr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952599; c=relaxed/simple;
	bh=e5VIQ03PVg7DinULK61jFhZHb35q6TV/zW5GagE5124=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ELaYO42tf9MuvHu1jAqMr3gArNFVOLF+ES9P60+qeWReulRrqglLW8ssdmlatqHFGBYyvnjifGGE/m+Knma28R9rokUVZZVTkoTx1nU6yngyGoZb4rSoTDBlKjHauffBaBEa+Tpj+j6OPeHs97L3ej02O2puyNzXIUMD3AM80kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=h9u9GPdv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57BMmmFF3225581
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 11 Aug 2025 15:48:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57BMmmFF3225581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1754952529;
	bh=rTR2gbYg8prPJPsfDl56c+D6F4g0IZXnpgvX3kmki0o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=h9u9GPdvNR0ElftakLufpf9mHKlErVrcyDDV2jsss4vCqrBJJ/AIfIxyUtYqYki+B
	 5AZMMVzgViW/+KZiiqGc/KKV8U+77/iH6qmxeRAq6U20prPu27LZsDDlWPKTR6fWu9
	 6ICr1JBdXyiW8nq88GGwv6L1w17v4sowt29eoig22ISkBf3NqKvOs2IrOpWvIZA14g
	 CXSGTVlJ7PpGgWY2rxcOL3tUhBpe2fGKhJ+GQNYR/0is/sjnsCjt0QIhyuDFHuuXxf
	 IwS+0P69F+Ar6m0NcKw5Rw18lYqb/JyXr3qzF3BSbVgCep537ppLEasuG9YprogKP4
	 FvveROTHv4WJA==
Message-ID: <d1f20289-a6d6-44d6-988f-08fb87faa067@zytor.com>
Date: Mon, 11 Aug 2025 15:48:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/fred: Remove ENDBR64 from FRED entry points
From: Xin Li <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jmill@asu.edu, peterz@infradead.org, andrew.cooper3@citrix.com,
        stable@vger.kernel.org
References: <20250716063320.1337818-1-xin@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250716063320.1337818-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/2025 11:33 PM, Xin Li (Intel) wrote:
> The FRED specification has been changed in v9.0 to state that there
> is no need for FRED event handlers to begin with ENDBR64, because
> in the presence of supervisor indirect branch tracking, FRED event
> delivery does not enter the WAIT_FOR_ENDBRANCH state.
> 
> As a result, remove ENDBR64 from FRED entry points.
> 
> Then add ANNOTATE_NOENDBR to indicate that FRED entry points will
> never be used for indirect calls to suppress an objtool warning.
> 
> This change implies that any indirect CALL/JMP to FRED entry points
> causes #CP in the presence of supervisor indirect branch tracking.
> 
> Credit goes to Jennifer Miller <jmill@asu.edu> and other contributors
> from Arizona State University whose research shows that placing ENDBR
> at entry points has negative value thus led to this change.
> 
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> Link: https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/
> Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Cc: Jennifer Miller <jmill@asu.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: stable@vger.kernel.org # v6.9+
> ---
> 
> Change in v3:
> *) Revise the FRED spec change description to clearly indicate that it
>     deviates from previous versions and is based on new research showing
>     that placing ENDBR at entry points has negative value (Andrew Cooper).
> 
> Change in v2:
> *) CC stable and add a fixes tag (PeterZ).
> ---
>   arch/x86/entry/entry_64_fred.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> index 29c5c32c16c3..907bd233c6c1 100644
> --- a/arch/x86/entry/entry_64_fred.S
> +++ b/arch/x86/entry/entry_64_fred.S
> @@ -16,7 +16,7 @@
>   
>   .macro FRED_ENTER
>   	UNWIND_HINT_END_OF_STACK
> -	ENDBR
> +	ANNOTATE_NOENDBR
>   	PUSH_AND_CLEAR_REGS
>   	movq	%rsp, %rdi	/* %rdi -> pt_regs */
>   .endm


Ping :)


