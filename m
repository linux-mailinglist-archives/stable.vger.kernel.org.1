Return-Path: <stable+bounces-196944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB0C87EBE
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 04:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F3F3B3F21
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 03:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB1530DD1D;
	Wed, 26 Nov 2025 03:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="QZDePy1B"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A630DD11
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127095; cv=none; b=T+JgQnf4n9C/VFF4gDmGxNMLF5yZuHaXnk6mmi+D4mC9YrsI321eTWroaFDtMqCuk5efY1m7tePMACID3j6piyAGmtqXgLvlIjmgWQ3nRES0TuDPYhsVj56ifJlEjKiCixvdwPOtiE0Q9m/D+wp5rV6nq57ccujolciZ/rE7Yl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127095; c=relaxed/simple;
	bh=MebXQ/i/4CXGFSpTUvGXKnO4bK1YiUe6DcpTQoQ/VGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck/pNoi++hdFizA4vmkwKmnKHiuMjTQhXyAwV5ukCm+tjjakIBF2MS1isOShrAjheEkL7pi1Ev6OauYPlIm1B6DakpYDhQEl6Ge+uZrxUe5voP5S6tNsBQaLdyztOXjYTX2fMYgJTTO685K2UObFRMHIydj5zcVk+ys/9HKf1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=QZDePy1B; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so52931401cf.1
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 19:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1764127093; x=1764731893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvs0VVC0mcv4NgOGijtzLsQWvxXXKQp640I94GmhkA8=;
        b=QZDePy1BQK7nrhF5my/7UsIFIUbHAKuC1dIVqNpFMrlAlNKOf+8jqdINeehVA6sbhO
         G4u5OeAiry1/XeS5XF9Fd+ARzW/ZbZUIn/7ev9ZZaNSOLiM5bc1cVetA49Luqt1vaPAQ
         56v7mzD8Eaw6HZuJknAQj+uP2sh4hB3TG/RuUB29vDr8zZQkK7ZGa5Evs7voMPiWYd9J
         knDDiD+QbtuiDTkN0OnlX8gQC1FwU3/b4bV+HWJZS6Kx04DXMnL99r5LqxiQfIBbvVBA
         QSkX2N4xYpTckY+63WFdTR6YRja49EEtM7sGqfCrhdiPle7ZnxgE3XKbpSlPPE3l3ERE
         R3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127093; x=1764731893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvs0VVC0mcv4NgOGijtzLsQWvxXXKQp640I94GmhkA8=;
        b=eBz99Jhj4EJWbA1Y7OVaHmM8Fq4S8l1eXlrjbOJVlWl9e/1+G+7ggNWMtNJ0dA/G5G
         ZFfjwB3q4sjVUOjx9onJh40knmDwwnFwrrve68becy+1wybMrhj88hXpD0bYea/vFxuH
         Cz6hvGJVy7XEj92PnBmBeazvigN7KMe2zlj+d+1k2mN2f1B3sk0VnJvkUAN7ajiVAo5H
         bN2Aw6F8EY0vmNLqydGL9/TNXbbISlmjbhWlku6cHEnd8ISESLZq5RMoFgL/A7DSoWfg
         ++mF+dSurNI0WQO3BurBPZ52gwL0v8/k9YbCWl5EIVdYAvidTP5DgQOYe7qM0rgWMiaa
         8OgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZJPVrJk3zr97FWE2UNBPdqxrPeH6+83S9zn1FL0vmgwUiNRAiAb8TnV0iK+K8tglINJg/MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZW1iyp9zUwIeD7e+UkLob1EGR+eu0AUR+rIMCyL931UA0jkys
	bgHleqN0H3IYaIE+xSg/wU+szRG1QBqzLuzSiNPV6MPSmJjVLvLJndo/5LmqwyXpPUc=
X-Gm-Gg: ASbGncsLVOBC2+6Glieki49hveRWW8MwLJGNyhNznNtGSe49sOfIyJ8GY6OpAceGQFg
	FMzvxAKox5RnAm78N0BIN7pch81i6WBeWd6hXDlYbmec2ayedF0XKhTUwpwT/qboyKmoMsAc5sv
	Ik7LvFiuDOXeC9h9Lpodiv0sQLFudAtvp/gyculoQAMIzRDpQOlhzZTTY0fmR+g2YozpLX0Gku4
	O/5qMTcQU8v8koYINQSG+lhDlDzKiSGxB1QS/MbX8Sd2VULL/U6gOOYHzhvwvzlQuGoYGoPBvpc
	5NWpaBgXKLK8OOo6M8a93AB/z4qgdL7GdBV/CeJrzsS3qRCXoU8jQPqkNHxnIUuGCPw9lKHLtNQ
	4I+enzZEIRfPpxltIF3tn39Y2tsQX86pQPwIQBgbjZPX7YL04Yw6N7L8eiNz8+hrFdNkK9PjrFS
	ufm0NGhBK0SqXuDoja33UVcDMWTgTNMz6/izBAO/BewsvLHk2wZrM=
X-Google-Smtp-Source: AGHT+IFVPZAvlFu8nDpWWVLI1C6FD2IyTsqdkG4yg1n+X5k0lKqQqgf0T0rJLMz2wOCW390Qqgh8pg==
X-Received: by 2002:ac8:5f84:0:b0:4ee:2c3c:6e with SMTP id d75a77b69052e-4efbda49e09mr73391871cf.30.1764127092631;
        Tue, 25 Nov 2025 19:18:12 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4ee48d3a041sm115728681cf.1.2025.11.25.19.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:18:11 -0800 (PST)
Date: Tue, 25 Nov 2025 22:18:10 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-rtc@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>, stable@vger.kernel.org, 
	sparclinux@vger.kernel.org
Subject: Re: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <gfwdg244bcmkv7l44fknfi4osd2b23unwaos7rnlirkdy2rrrt@yovd2vewdviv>
References: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>

Any thoughts?

The problem is still present in 6.18-rc7 and reverting the commit
indicated below still fixes it.

I am also seeing the same failure on a totally different system with
Dallas DS1286 RTC, which is also fixed by reverting this commit.

Since the initial report this regression has been further backported
to all the remaining longterm kernel series.

Thanks,
  Nick

On Thu, Oct 23, 2025 at 12:45:13AM -0400, Nick Bowler wrote:
> Hi,
> 
> After a stable kernel update, the hwclock command seems no longer
> functional on my SPARC system with an ST M48T59Y-70PC1 RTC:
> 
>   # hwclock
>   [...long delay...]
>   hwclock: select() to /dev/rtc0 to wait for clock tick timed out
> 
> On prior kernels, there is no problem:
> 
>   # hwclock
>   2025-10-22 22:21:04.806992-04:00
> 
> I reproduced the same failure on 6.18-rc2 and bisected to this commit:
> 
>   commit 795cda8338eab036013314dbc0b04aae728880ab
>   Author: Esben Haabendal <esben@geanix.com>
>   Date:   Fri May 16 09:23:35 2025 +0200
>   
>       rtc: interface: Fix long-standing race when setting alarm
> 
> This commit was backported to all current 6.x stable branches,
> as well as 5.15.x, so they all have the same regression.
> 
> Reverting this commit on top of 6.18-rc2 corrects the problem.
> 
> Let me know if you need any more info!
> 
> Thanks,
>   Nick

