Return-Path: <stable+bounces-158201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC5BAE57A8
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 01:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F691C224C5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A9F227B8E;
	Mon, 23 Jun 2025 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="vPz+6CmW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3479F2
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750719799; cv=none; b=rTENB4m2x5JFROUy+99Z+e5kgW6F/NY/Jwee6Uabf6DTkkHKnl6ATGRefIt1OtmTnj+UVijpMk1OEg3Am+5W7bJidrb6rAdSN7C/E/mU1daojLIFHeQydlAnfvoyJZT5OImm57jx47S8B3GMb6XJfvsi4NrTQzRuDDSlBaEZRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750719799; c=relaxed/simple;
	bh=uTEBb1cLKaUAihyUsnq63yyQOaopJYSKtmeo92pIILM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=GxUgx3dIPN95S5NhRSAIjCkfAsGlh0c6Kl4l/Yh6Xj2t7iqrue+gNAeLwZdfyg4sYOmy9RlKCfRqMsxnW2qNPq9D0WfImtsyQKpbCOarBITF2xyKHD19/gcWSgdLe1pUVAV/LFHkI0cg71mRfk2sIREd210lR0VhJgD8tc8eoI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=vPz+6CmW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74924255af4so2185045b3a.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 16:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1750719796; x=1751324596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xq/zZtHXdIEWDg6PksJqtvJ5HWuiH6F2m2ZdOErRcaY=;
        b=vPz+6CmW6g8s5Hci583+oIcVf0YtxzSrOiEDZYW5Hr4Y5zOtME1Er1BjsfLNAKT94F
         O8JfK3WY5DhHVyVcN4HYOv7buORybu6y0S+bN/71wWXF+3Zpld7lDQ+MAGpD/AM4YKFK
         ywY5f0tkxKOITGuft111LZ7qHATAwjbQ+BE3CSGsZOSs3nYdbCayNlJKFKx6zHFJnxPr
         rCUMb2RuYCEhsUH6PsYAbu45+9vCTkkR3O4+ouU6TK7Ukeo6m8+Kk6uDPbDDRvIQQAcT
         gzy5cAO1W/gFgPFXWdL73B3tZM/sEYK+XGUIbqnJNYyZK4IvH5bEgdBJZjPwXrmGi0+D
         5yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750719796; x=1751324596;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq/zZtHXdIEWDg6PksJqtvJ5HWuiH6F2m2ZdOErRcaY=;
        b=tAcoNNj9DCoZR02RR8KpUc98mtXT0IjIlA50RsP3G/MTwzDQI1N90YZK2WIfbcqzBQ
         UIaNlog1l+bwCbYdvMjzVmrjsvSo2a4VyjLvYq6X1/nfXueTN77COutOs55Ac5TPQdwu
         wBtBJksrPyEIlwAhAgeFWCCZruLUU6dY8zmHPur06Pr11KA3q3ovj2qfqCVB74oZ9aQ0
         /Rn1DlnYetTDuHOSXjlMN7laxtoqR/IsQ0rEHEVv1TPnzCs7KPvSV6FdH3fAWZOhTVS1
         BTirpTqa7xwX+3Hw7GznIwvUOh8SpuY4Q9CuyxJWD+81m14xpdE6ORlosOtDnWvCVuJV
         aqkw==
X-Forwarded-Encrypted: i=1; AJvYcCWrX7IkWEbdynitvl8+9znNY4jdQkAoX0qoJuYpR6GlFCjCHhUt6fcPbj6WV0Ei+y1+adQsavY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmMYIo+r+RAGDqTI5s2jHIIo6eB8NcSrx3lUbe3jqaKDgxDNv
	zcHfOaxo6wiPJjz+k/M0MT5y6vXqyJ4ZvY5/ZTkUeXsU2lfLfYaAwOJbiAbWsYluk5w=
X-Gm-Gg: ASbGncutS5zAujmXBn2bsChJSMtoFr51uyoG990xz6o1GxakyOVzC1VqeZZzhuwsmJG
	Cx7vKhtJ7VFebLwClZpmbF6ZoeUe4XreIlwYTN6VJP9e02Y/efGyCzPw31QEe45BDvDf4yL0fhA
	VBzaolsaHzg5fSoedYPntt3ILhbo/U7FVQWtYaex2adif9cZhJ3DhHsuQLyJItx3lVtkwbJ7xYF
	hR3JhwfibaorbWWxshhc4A0gnUgx42lZS/EkomZwiYvXIcCusiZOeO07pld1c2EH2YdamdeY3U/
	84Unel/PaD3Z9J+aFwlAusOG+hxBOSvI54W1wVDHwhaQLNCyrxjAtdb+jKjd
X-Google-Smtp-Source: AGHT+IHo3IKRbWpWvprVqP+VM5IIGMy1WyvPfkLHogYWNfeYYT5jakVZXXuA0t9dLqqBcHxzu44RvA==
X-Received: by 2002:a05:6a00:2789:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-7490d4f533amr26121349b3a.3.1750719796228;
        Mon, 23 Jun 2025 16:03:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:8d10])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-749c8851b0asm212812b3a.124.2025.06.23.16.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:03:15 -0700 (PDT)
Date: Mon, 23 Jun 2025 16:03:15 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jun 2025 16:00:17 PDT (-0700)
Subject:     Re: [PATCH] Revert "riscv: Define TASK_SIZE_MAX for __access_ok()"
In-Reply-To: <027ef1a9-6a5c-4dba-8816-159411739b71@ghiti.fr>
CC: namcao@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  rtm@csail.mit.edu, stable@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <mhng-6AF58D5A-1FD3-4D1F-B006-18562AD0F9A2@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 02:15:48 PDT (-0700), Alexandre Ghiti wrote:
> Hi Nam,
>
> On 6/19/25 17:58, Nam Cao wrote:
>> This reverts commit ad5643cf2f69 ("riscv: Define TASK_SIZE_MAX for
>> __access_ok()").
>>
>> This commit changes TASK_SIZE_MAX to be LONG_MAX to optimize access_ok(),
>> because the previous TASK_SIZE_MAX (default to TASK_SIZE) requires some
>> computation.
>>
>> The reasoning was that all user addresses are less than LONG_MAX, and all
>> kernel addresses are greater than LONG_MAX. Therefore access_ok() can
>> filter kernel addresses.
>>
>> Addresses between TASK_SIZE and LONG_MAX are not valid user addresses, but
>> access_ok() let them pass. That was thought to be okay, because they are
>> not valid addresses at hardware level.
>>
>> Unfortunately, one case is missed: get_user_pages_fast() happily accepts
>> addresses between TASK_SIZE and LONG_MAX. futex(), for instance, uses
>> get_user_pages_fast(). This causes the problem reported by Robert [1].
>>
>> Therefore, revert this commit. TASK_SIZE_MAX is changed to the default:
>> TASK_SIZE.
>>
>> This unfortunately reduces performance, because TASK_SIZE is more expensive
>> to compute compared to LONG_MAX. But correctness first, we can think about
>> optimization later, if required.
>>
>> Reported-by: <rtm@csail.mit.edu>
>> Closes: https://lore.kernel.org/linux-riscv/77605.1750245028@localhost/
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> Cc: stable@vger.kernel.org
>> ---
>>   arch/riscv/include/asm/pgtable.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 438ce7df24c39..5bd5aae60d536 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -1075,7 +1075,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>>    */
>>   #ifdef CONFIG_64BIT
>>   #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
>> -#define TASK_SIZE_MAX	LONG_MAX
>>
>>   #ifdef CONFIG_COMPAT
>>   #define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
>
>
> I agree with this revert, the next step is to implement the same
> optimization using alternatives (like x86 does).
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> It should land into -fixes.

It's not clear if you're picking it up?  I will, it's hitting the 
tester now...

>
> Thanks,
>
> Alex

