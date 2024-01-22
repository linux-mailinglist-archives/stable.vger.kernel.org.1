Return-Path: <stable+bounces-12822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C9E8377BA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9181028659F
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E334D5AE;
	Mon, 22 Jan 2024 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3WHkRvI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620814B5A6
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966114; cv=none; b=gEviTqnbSkHKxbp5wrOeLux+9vd64RVk5HQWaQ+09pyxCGlMxWBl2WFOnQbqw9NWOQ28K66f5ikSzkv22gcUUeYqwHLAKLjzGDJK4p6di1LDKQbpmLqxJbN2SJPURl82DOsxA3y2cVRdIFHDeozDj+ZID+8eKC35seqq+odzabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966114; c=relaxed/simple;
	bh=5rCYbb7y2L26PgWKiJThZZpZG8XkMJTFi4+R5bY6U04=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9qvE9ieVBXg7E8GI49ZWRZ/FRT5cD00Cc4Tq9y+cncs/EKblka0dHyYBDCXeuN5FkB9HyAN431zZoYrrH69bOAliAZUhY/UbR9wXb89MNmzzDE0+Mp4zOWRwsmO+YEUJl2wQ1Q4COuY2el/CJ1ylXyTOeKI8cguWMroLTH4Xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3WHkRvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA09C433C7
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 23:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705966114;
	bh=5rCYbb7y2L26PgWKiJThZZpZG8XkMJTFi4+R5bY6U04=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=m3WHkRvIcIwR4HMcA5reK5ndTOyBAnqYVLD49KTpXUAOjIF3QDesT90MT9HZBUJLs
	 VPdH0XghJvdh9ivYy4l4Jrmmt13xKRKLjU3WrEkmpOZ2jxbzldc4mHIH9KngZHIbIZ
	 yrz5uFxCqKP53aBrWT4ueEl7thBSE7B0Vt6yEez27gAnOY0D5Ztzdz3a5MPq8EPmT2
	 oBMlrwnjW1FOYO6D4JMAH1lVEdSm8J/ZDbD5nVO5r2JGfLiU4WmGjJZVX0xaqs1mXV
	 ZlGkQIVBjoz9hhUU36SznEua6fKJ0jrdOycjer3oOD1E+odBClNUvB0A7GsUlXOCia
	 XZCW/Sb3Ry31A==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd7c15a745so2667985b6e.2
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 15:28:34 -0800 (PST)
X-Gm-Message-State: AOJu0YwuSBQEywlgzXUChaBgCwAp14Ud+x9igGH31wZztUenW1B5XM46
	JnbQdauaNsEhkWP/M9AkEtD9QL0qP3tfgOlUwACJijmuY2RgpDRsuuceqYgokk6MCzMpwTAjKlx
	M1G4WMnkxYBBv9iGT6Q7jkrnP4S4=
X-Google-Smtp-Source: AGHT+IHfUa7ShqF8LCtNgvsTs+rf4L7B7CiXdDe03OWkD/123WTPg0ljK2DJubUKzuKlJu35SqzBGl8LV5HJ8MkEpuk=
X-Received: by 2002:a05:6870:b24e:b0:210:ad7a:7a0c with SMTP id
 b14-20020a056870b24e00b00210ad7a7a0cmr688128oam.84.1705966113591; Mon, 22 Jan
 2024 15:28:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6c8d:0:b0:513:8ad5:8346 with HTTP; Mon, 22 Jan 2024
 15:28:32 -0800 (PST)
In-Reply-To: <2024012246-rematch-magnify-ec8b@gregkh>
References: <20240121143038.10589-1-linkinjeon@kernel.org> <2024012246-rematch-magnify-ec8b@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 23 Jan 2024 08:28:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd80WYNKJ2DEBEzbiECCFJupd81ZPBREz7KaOT4cc0fdjg@mail.gmail.com>
Message-ID: <CAKYAXd80WYNKJ2DEBEzbiECCFJupd81ZPBREz7KaOT4cc0fdjg@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 00/11] ksmbd: backport patches from 6.8-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2024-01-23 0:03 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Sun, Jan 21, 2024 at 11:30:27PM +0900, Namjae Jeon wrote:
>> This patchset is backport patches from 6.8-rc1.
>
> Nice, but we obviously can not take patches only to 5.15.y as that would
> be a regression when people upgrade to a newer kernel.  Can you also
> provide the needed backports for 6.1.y and 6.6.y and 6.7.y?
Sure, I will do that.
Thanks!
>
> thanks,
>
> greg k-h
>

