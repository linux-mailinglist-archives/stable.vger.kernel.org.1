Return-Path: <stable+bounces-57914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A22592606D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7518DB316F6
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496417554A;
	Wed,  3 Jul 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QXkAxWXB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57163172798
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009362; cv=none; b=X/WrXHexbYXp+f7SYw2a0o+7TljAD2oCj3USO+5OGrmx3661eAGjWR/3bHqYqI/ix+UvhZjPVnZsHQgtpbGUBHMC7ClGqN5Yh/yD87WABSmo4GDTnm56nczCZ3f1xls/bFnZHLuaAhy/TJwAxO38KcU2h9WOU9ONrLlpQhMOnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009362; c=relaxed/simple;
	bh=TX2gvgdit2no2Bm4JOYvYuXVgfwUmwr1dfS1rQTimbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/S9ja7yHQHTliyfmXvQ6OLQyTIqSzQ2m5vfBAHjY3p+vRY3RP3Gu9YDLu3ta2G90qfnERP2OzCfQxMtkI5PsMExg9UHslAyBOXuanhEpF3tqj+xwFAnCsbtt+cLIw3x+JnPrCBZyPWjsMLL01V4sBLcbYKrtqEAUmMU6lwsQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QXkAxWXB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so59510361fa.0
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720009358; x=1720614158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYo5IBsgfXZoFfV/jrH0cWY+s6dZqG1CrWcT7nsdClQ=;
        b=QXkAxWXBHNwL167XOVQY5fWzRVOXxoEm2BmBn6sxC+LcqcFSbJohvP8kh3jrOcXevG
         TfNZQqv5GC6NvzJBzBD7Iv0i5s26+QRtwI6uJgIy183ciDlwcTmNKPz4w/4+d7KulSXT
         b+8V2C4n3ZTDkNd4qe8VAuOZN6sALW7zkbQQPmqHIFmv0YB+NRQFS/7ybc+fBXL49yv7
         OPlYo9hBiA1t9Z7E+7nYYyUTGZ+nDAoB24tVhXr7lm38ctyNct8h5PNpYfZXNBVnDBI3
         EyRu3MXoOL0wW3O6118tjF4tQDA4DNYfLUDFHSU/FxiqzL+eHiOSTI0gKQrHI3iFUwdV
         2JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720009358; x=1720614158;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYo5IBsgfXZoFfV/jrH0cWY+s6dZqG1CrWcT7nsdClQ=;
        b=wPlXv4GlZCaA2AOVC9aQqPDOvCgHcvT92p8nkHCj20tlGrh8j0oIZKp4teENMXEbn+
         Hy+G2DBl0EqiNAhw8169duhiydmYKQB0eelu5Fl0X+J3APinIf81pgg4bSwqmvXqEp+5
         TMDD4zOp0oxx3LZZLBFy7845ExAVmSmn+HQwa4BO0/SWWIXEGH08MBdxLT/FlpZDqOvw
         2QoGlBVcDZxkRF/zlXUotm9pDx0U8wFnmWuASA5x1FYS+ljvxI4keRkyL88vW2fJXH8C
         6M1gEGYWg/cICM0JCy32BmKdLY5iyAxS/XEzry1Xq9c3X/BByBkBz4ho8YhmWQcH5AA1
         Ndqw==
X-Forwarded-Encrypted: i=1; AJvYcCWTnoJcq6XwilMK/ceKL6/d1ZTnGiy/KLms1rssh6o2FgtKNmh/QtuXSCysRk4J0kX2juERHG+vRqj7TB8Vf8ZRMLzLAeNm
X-Gm-Message-State: AOJu0Ywo6IS6CwfBOCvgs992P42CPoM8szswFvI2v9cdfTrxMENxIvoK
	V6A7ypp/u/W7hDYBBjrucrTPhux7DiAfWS0ZNfBA2mO1wU8NIAF0MUVrFv0x568=
X-Google-Smtp-Source: AGHT+IHZ4VR/Z2EA5bNROzM44bBxwS+VTMY4KF41urbY5op+dc5ajamiSRVwX7gtAx+LOXib0By3RA==
X-Received: by 2002:a2e:a902:0:b0:2ee:6062:b559 with SMTP id 38308e7fff4ca-2ee6062b816mr81975241fa.8.1720009358326;
        Wed, 03 Jul 2024 05:22:38 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:757f:69b1:bdb0:82db:8b8b? ([2a10:bac0:b000:757f:69b1:bdb0:82db:8b8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b064f16sm236821285e9.27.2024.07.03.05.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:22:37 -0700 (PDT)
Message-ID: <d405c84e-2b8c-4139-b4ea-d716fe53dfca@suse.com>
Date: Wed, 3 Jul 2024 15:22:35 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
 <20240624114149.377492-4-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240624114149.377492-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24.06.24 г. 14:41 ч., Kirill A. Shutemov wrote:

<snip>



> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -19,9 +19,17 @@
>   #define TDG_VM_RD			7
>   #define TDG_VM_WR			8
>   
> -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
> +#define TDCS_CONFIG_FLAGS		0x1110000300000016
> +#define TDCS_TD_CTLS			0x1110000300000017
>   #define TDCS_NOTIFY_ENABLES		0x9100000000000010
>   
> +/* TDCS_CONFIG_FLAGS bits */
> +#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)


So where is this bit documented, because in td_scope_metadata.json 
CONFIG_FLAGS' individual bits aren't documented. All other TDX docs 
refer to the ABI .json file.

Landing code for undocumented bits unfortunately precludes any quality 
review on behalf of independent parties.

> +
> +/* TDCS_TD_CTLS bits */
> +#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)

In contrast the TD_CTLS bits are documented in the same .json file.

> +
>   /* TDX hypercall Leaf IDs */
>   #define TDVMCALL_MAP_GPA		0x10001
>   #define TDVMCALL_GET_QUOTE		0x10002

