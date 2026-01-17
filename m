Return-Path: <stable+bounces-210146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC23AD38E65
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 13:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30C64300B357
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E816311C21;
	Sat, 17 Jan 2026 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzlzJA/X"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A7288B1
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768651601; cv=none; b=h+QNkuwF0OXzjCuNFVtKCE9ue81zat8hJMZj0J/kCSLqrxo7GmsIHpH1PGSFHh6Vav4KnrNz2EFoc+sMt0UNtBj02TQYkkohBYxs/k1efHKLOyADPJ8Xxo3zcbbZSCZ1cCd/YjD0MWm26/mPo2uI4SumGPWqcmQ4gBlvlb/buhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768651601; c=relaxed/simple;
	bh=Xuc98TObcn38gZY7CMrM88f1rNXWeDYWgmRVNN20vTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hi3rXX2WpFhCXP43D8dgy8/awDgUirXdjHbW7qdgnLHgBFS5DTcETnd8r+vXdisRfUAtw/EPAobxeto36zMWuF0OWimkmOYvm2wO3S6OvipHfNT4i1gq71hIUG3daGfaX3e4wprtUQMMV4xJtzhapxXKFWY7T8j3hpXt06vuiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzlzJA/X; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so1585113f8f.2
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 04:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768651598; x=1769256398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hgzz2g9xI3B7sKWHIbum1LJH2UJJWU63NtgcfullTeY=;
        b=IzlzJA/XnWZNQGYLxGdx5GX57judtiJOYIyo2FBZHzQ5zpgt5VxNWe1HfGz3T/5FqM
         cGtcP1BD/eEbCtWJCd9GxrlewMonBcnXXNr+zX9m79zwLgw/tVW7XvvqIFjwvzJwWKfI
         SwA8L2B29AMsjX4ZuMNNtKiBWda2RtyT9WqdQLrdKUEdFjyugByE+5AU4lecwmFMiHUt
         5bldbxRvcFKBr7PrXqtMAY1tcnbGBzKPSDDwkDXHaXVi6em0Fd1NMyy+bux7TO9TodQu
         0dWjIKV4XUYw93WjdqTi3qlQb6meOYWFGmx82sHPJMxobqc/wDbdQ23Op1P+TNZRYgVN
         7+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768651598; x=1769256398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hgzz2g9xI3B7sKWHIbum1LJH2UJJWU63NtgcfullTeY=;
        b=tnAKZqF6e3T0Ge8YR3usaqLQNvNEzHr8cxJ07Wt9EQ7/wEx6BYo8JaSQxKCuXX6OEh
         pkGGfzCHboUXG0teeFjeIMaknXGf1HPZ0NhX8bpSImRn/c84Y24Ce9w8ZWGB4CtEoTBD
         eU9CUnV+SIg1RKNMKFkut950sA5G6jXrx1vkytSeKIJwEbxUEx6mj/NHTK5IEeIcgdwJ
         PSOPHL4H2w1825kmsdVs2RQHl4/f0oqAfWusarW5xKgHEn+ErvGcnlY+aNJpTC1PmxOE
         t1bQjKuhE3V5PpoqtAusknE8ssGFO+qtTpMnuJo5sxSoxPN2b588nK9qPDIOBKhT2C6b
         mGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVchsEHe1KqeC7SBxkHiAHiuHPwJZ9MXWq+nqaOpsHbFQes2n9Uj1l7Yx4iyg+3qafb2Lsc/r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDnAzsCilbTGsEDa7Y3rVLB+I8ZwaN9tSejnqtXlqFciwHj2B
	D6R8itNj7vB6cZqOAuajGblRCb3LL7Wlf4KvYbdMJGBhEfh8rPrKbz7K
X-Gm-Gg: AY/fxX4h6YiNROhnEQlRaD1CgpPIv81r6gYw9iQ8UPv301wT94fpIGQniNVdJSV54ol
	jtfPTfI3HDjDm46HPVBJSreTbZa/NZhqvOSzMFFODCmo28TfClwxKgv0W4vJcfEEQzEcecFwIsA
	A4gAE9cbPSsMUGyMs2zuDRhcg6OdBrcggt8jshCCeXRAK4tNqd/JoSDpD+JVgcywfnk+NozLxPp
	+bsfEkCM9MFK/6buwgROJagjstfGkoC/z92daDNWCUW3bPh+tBpy1bUNgPa/Bsh+jSiQoTFFLdp
	lReO60+z+R8Bh4yygVkvsvz3ATOdvSDRhiGvptN1Jv9ZUb3rf4ygJuNtbEgKRHkbLqxv/kpLn3+
	Cvxj5NWN3GiBpDDPxgrPcrKgIcs53TTPhO2NDFQUTi/5auCIput4CJn28yi7z9fKSlHlLQksVKT
	3cOSSq9DbwHvhpM2Z3EbVDSLZSC6h8fj4UEW74G7jBnO2mtXoA+n8i
X-Received: by 2002:a5d:64e5:0:b0:432:dc1f:6982 with SMTP id ffacd0b85a97d-435699928ebmr6938489f8f.16.1768651597711;
        Sat, 17 Jan 2026 04:06:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm11193342f8f.42.2026.01.17.04.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 04:06:37 -0800 (PST)
Date: Sat, 17 Jan 2026 12:06:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Weigang He <geoffreyhe2@gmail.com>, mathias.nyman@intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: fix missing null termination after
 copy_from_user()
Message-ID: <20260117120632.75e3c394@pumpkin>
In-Reply-To: <2026011725-ecosystem-proved-a6ba@gregkh>
References: <20260117094631.504232-1-geoffreyhe2@gmail.com>
	<2026011725-ecosystem-proved-a6ba@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 10:58:41 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Jan 17, 2026 at 09:46:31AM +0000, Weigang He wrote:
> > The buffer 'buf' is filled by copy_from_user() but is not properly
> > null-terminated before being used with strncmp(). If userspace provides
> > fewer than 10 bytes, strncmp() may read beyond the copied data into
> > uninitialized stack memory.  
> 
> But that's fine, it will not match the check, and so it will stop when
> told, so no overflow happens anywhere.

That's not entirely true.
If the user passes "complianc" (without a '\0') and the on-stack buf[9]
happens to be 'e' then the test will succeed rather than fail.

But the only thing that will get upset is KASAN.

More 'interestingly':
- why is it min_t() not min(), everything is size_t.
- why sizeof(buf) - 1, reading into the last byte won't matter.
- why buf[32] not buf[10], even [16] would be plenty for 'future expansion'.

	David


