Return-Path: <stable+bounces-47951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A11918FBB2A
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6101F2601B
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531FE14A0BD;
	Tue,  4 Jun 2024 18:03:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403D149006
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524220; cv=none; b=c0EDKdCG9BDOwILMRzFkYSPNy3echyxwgINbgTHq0s3nwAL4H/9XYMPwrrii6lmFbt4y3HoSG8qbdIZ+fgZlV4e1BFZ9vMxkk/aqiX57gH9S1N2gToRxTTTwpyXAR2vF/JerS7Sb/MqOtg9FBEcx7sl7cIZLArbdezS1+ebSMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524220; c=relaxed/simple;
	bh=dHpZXgZEVGTh2BIL6iuH54wCENX+ew4giUXS5FaW2Gk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L/brJoc8hjjizZ5nSVs9scmXxWyrL0R5nqNen9qMvn/IXk3FgLRKPqgaX6U5mEj0k4zZKj/CJfj5oHHxcpGSocBhqj5WNks7nNXeGRm8GBNuPjuI4lGjatpr/PmTb3rZyeQn37Mp9djMN31kAvbbockQG8GbhMZ0WRzXJWCdvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd7553.dip0.t-ipconnect.de [93.221.117.83])
	by mail.itouring.de (Postfix) with ESMTPSA id A310810376E;
	Tue,  4 Jun 2024 20:03:35 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 6ABB4F0160B;
	Tue, 04 Jun 2024 20:03:35 +0200 (CEST)
Subject: Re: Please queue up f4dca95fc0f6 for 6.9 et.al.
To: Eric Dumazet <edumazet@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <575be1d3-d364-7719-5cfb-f89bdec66573@applied-asynchrony.com>
 <2024060452-headrest-deny-2a5b@gregkh>
 <ba29a0e9-8f4c-e209-fb2d-1ef80f97da6d@applied-asynchrony.com>
 <CANn89iKN3i6m4h=UUmQbRNSocNY61bb7OaS-tdTnnmWuaPot1w@mail.gmail.com>
 <CANn89i+6X6o8bQjVUatuvBTq1hCBB6345a1=E=kA3dJUQggGNA@mail.gmail.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <f90a9e26-4899-9b93-d874-34b9709ec5c0@applied-asynchrony.com>
Date: Tue, 4 Jun 2024 20:03:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89i+6X6o8bQjVUatuvBTq1hCBB6345a1=E=kA3dJUQggGNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2024-06-04 18:35, Eric Dumazet wrote:
> On Tue, Jun 4, 2024 at 6:32 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Tue, Jun 4, 2024 at 6:26 PM Holger Hoffstätte
>> <holger@applied-asynchrony.com> wrote:
>>>
>>> On 2024-06-04 17:44, Greg KH wrote:
>>>> On Tue, Jun 04, 2024 at 04:56:24PM +0200, Holger Hoffstätte wrote:
>>>>>
>>>>> Just ${Subject} since it's a fix for a potential security footgun/DOS, whereever
>>>>> commit 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv_wnd value")
>>>>> has been queued up.
>>>>
>>>> Only applies to 6.9.y, have backports for older kernels?
>>>
>>> No, sorry - I'm just the messenger here and moved everything to 6.9 already.
>>> Cc'ing Jakub and Eric.
>>>
>>> My understanding is that the previous commit was a performance enhancement,
>>> so if this turns out to be too difficult then maybe 378979e94e95 ("tcp: remove
>>> 64 KByte limit for initial tp->rcv_wnd value") should just not be merged either.
>>> I have both patches on 6.9 but really cannot say whether they should go to
>>> older releases.
>>>
>>
>> Sorry I am missing the prior emails, 378979e94e95 does not seem
>> security related to me,
>> only one small TCP change.
>>
>> What is the problem ?
> 
> Ah, I guess you are referring to
> 
> commit f4dca95fc0f6350918f2e6727e35b41f7f86fcce
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu May 23 13:05:27 2024 +0000
> 
>      tcp: reduce accepted window in NEW_SYN_RECV state
> 
> 
> Sure, If a stable kernel got 378979e94e95, it also needs
> commit f4dca95fc0f6350918

So I guess then it's probaby best to just drop them both from everwhere
and be done with it.

thanks,
Holger

