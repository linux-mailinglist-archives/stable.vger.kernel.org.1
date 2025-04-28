Return-Path: <stable+bounces-136900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91DA9F417
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD1B169B9D
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06282797B3;
	Mon, 28 Apr 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WfYOF8MY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19132797A1
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852919; cv=none; b=h1f8h8FbkRgH7ccTujLF2Ad1VAPwkfVPhI/pOzapZPf5rdYtGc6xVJHp2ympUCPW8dHtRBCWYepoFKrTD1YfszoCfOtRiymtZm/jXaOP+K2TRTsczT/e+FIWiY7EkNZ6g1fTXLNJ9o1/k6Qb5MLGYVp64dCCzy0Ze+UN/k2SBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852919; c=relaxed/simple;
	bh=FCzZHV86sVHHYDKPJ0Lwcisils3t+8q6ZghFwsN3puU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Vg1VeWCEQOssNn4kVSXelg5zNEec4KbuCvGtIN2WEswxqhSApMyIQeBVd9Jyv/Nr2O83K0qvL7q/KpQMvWD4maICgtsX+le60K29frPT87zPn/OEtLcjeYdX4aJb5/3gUkCIs4rlrbKDGpA3YDwUIey8E4hAC/RNg8MRMMU9yDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WfYOF8MY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c9376c4dbaso560092685a.0
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745852917; x=1746457717; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6QvaUKEc64ZBq4JcxkJ+sgN35RTDPZcQh5DR7A39sE=;
        b=WfYOF8MYjZRBl0xIaNQ9trVlfrARyRCKtdGbgOyl45BcM8RQsbNAhFX5FHJ7ekOhL5
         jeKw07rQKfpkVd+XC2nBi+obtFXGnhOKKRKc0RZxrq2h/ekoZY2XPuFxkR9fXcXll0iW
         fIJ0YgkrystzKG7c+RzYqbr5vhPOXn6q2f4CusReaKc8W19oaXwF1/68RQZ7O1DM9GtL
         5fZeRB0MlFR7CUxbubdsnlxjgK4BpeU+hMpUhQLHBeBCJtgv3GG8BL/MWrodgQ6bBckF
         y6Q0ZSPbURfpChjYlTmRxVgkNQuoRW01mQ//Ff4OmtSIAuYCaTaqMsOCDrOeEyB3dWOe
         wrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745852917; x=1746457717;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P6QvaUKEc64ZBq4JcxkJ+sgN35RTDPZcQh5DR7A39sE=;
        b=VpFAZqpfEHCZ3straLkDECFHTfcf6CN4wNbM4QSGmNVYEAxLzoOsAmaAJMSrYZDdxn
         b6j0RJThElMQqGvE/o9GN5jh008pU8u4AIb+Hk8Zk5UsZ8aeG8BFNwh5JwlhR/5ht92g
         z4pRnoIOYJatTU4ZkplNh/m1VSIUKiCuBVVxTG8hjMXA72V66i58YCHzpHdxVnfonIN3
         mO2ZmjQLNBOAGfrOWG2X8LpL+Mrj2XZksFaD0GCCbO1RQNHj7WL9RwrX6gBIf+fxx9ab
         19w/XWenCH6gUkZ0OvyuMXx0evsscuu1E6aAKm8nch4pfqHvEtEmrIlBZuR1L5+Ktprf
         /mRw==
X-Gm-Message-State: AOJu0Yxu7BIp2shvC7NOpoWnO/XcbGUrFLOlBkTGUgJtrIzzye8Q53KB
	ugGsghbs7Ahb1EemA3MfZnQPvW2HY+tjsVGZn3lfiTka0SL0eUe8
X-Gm-Gg: ASbGncufzCMVBEyDui0jzJOTL+nvpe7vNeZOeukMOcTqbgSBhkH2f1K+GCNkfFy66Mf
	YgRVpS45Dvd45ZSxURYDNrHV8kB3JlKsGoxhZBiXNYFXVB36Tdo72SHv1F8hwPy/FRcMY9aYC7/
	TiofC07N/BM//mqclbRKkSFNR51Zfr/R7CJaB95aLzMBAaAPCp+smSp8X5fYwwHSEXCGDWkwqLF
	AyFuKDqHAiDJNqj4IuTtSHGO/IfUuV0MaaZ80xXVIR3qMIuL8MA+la/z65kLB3Yu4yOsiTDYaqp
	vpNrKw34RKtV5lhmqasIJPhu1mXGiZvY1DsM8AcpiSfbrwJ17zI=
X-Google-Smtp-Source: AGHT+IHGjZz4gjYEqIQksSKLic8If7GrSkdYXsDxALTpalldIzj8dbAhIvdHTVu73Qot72HmED+5Rw==
X-Received: by 2002:a05:620a:4250:b0:7c4:c38a:ca24 with SMTP id af79cd13be357-7c9612d18a5mr1760377685a.1.1745852914626;
        Mon, 28 Apr 2025 08:08:34 -0700 (PDT)
Received: from [192.168.1.10] ([176.25.125.185])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7c958caacbfsm629161185a.25.2025.04.28.08.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 08:08:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------88ptD6nb4etpblEza5C7H0FR"
Message-ID: <c6867c6c-bc47-4e3c-9676-70184baf21db@googlemail.com>
Date: Mon, 28 Apr 2025 16:08:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: GCC 15 and stable kernels
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 adobriyan@gmail.com
References: <fb4cce81-1e36-4887-a1e0-0cfd1a26693e@googlemail.com>
 <2025042814-sly-caring-8f38@gregkh>
Content-Language: en-GB
From: Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <2025042814-sly-caring-8f38@gregkh>

This is a multi-part message in MIME format.
--------------88ptD6nb4etpblEza5C7H0FR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/04/2025 12:22, Greg Kroah-Hartman wrote:
> On Mon, Apr 28, 2025 at 12:14:09PM +0100, Chris Clayton wrote:
>> Hi Greg,
>>
>> I've built the four stable kernels that were released on 25 April. I found that to successfully build with GCC-15, each
>> of them required backports of one or both of two upstream commits. Those commits are:
>>
>> Title		Commit						Author	
>> nonstring 	9d7a0577c9db35c4cc52db90bc415ea248446472  	Linus
>> gnu11		b3bee1e7c3f2b1b77182302c7b2131c804175870	Alexey Dobriyan
>>
>> 6.14.4 and 6.12.25 required only nonstring. 6.6.87 required only gnu11, 6.1.35 required both.
>>
>> Additionally, chasing down why my new Bluetooth mouse doesn't work, I also had cause to build 5.15.180 and found that it
>> needed gnull.
>>
>> I have TO dash out now, but I could send you a zip archive of the patches later today, if that would help.
> 
> Please send backported patches of the above, as they do not apply
> 

The patches are in the attached tarball.

cleanly as-is, and we will be glad to review and apply them.
> 
> thanks,
> 
> greg k-h

--------------88ptD6nb4etpblEza5C7H0FR
Content-Type: application/x-xz; name="backported-gcc15-patches.tar.xz"
Content-Disposition: attachment; filename="backported-gcc15-patches.tar.xz"
Content-Transfer-Encoding: base64

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
AARZWg==

--------------88ptD6nb4etpblEza5C7H0FR--

