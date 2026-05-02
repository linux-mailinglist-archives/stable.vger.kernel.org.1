Return-Path: <stable+bounces-242606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAPSMbMD9mlPRgIAu9opvQ
	(envelope-from <stable+bounces-242606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 16:01:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8208D4B23CD
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 16:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDE85300383C
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB627FB1C;
	Sat,  2 May 2026 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="I4qhM1Lr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73761A9F83
	for <stable@vger.kernel.org>; Sat,  2 May 2026 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730479; cv=none; b=h3SFNHFPlk2R8VXlqv/Ej4EUkZikYYrj4PTL3WNoyPJ2ERAaRAklsDMrNlViqnFhq72e1437rm8p6ckquFN+kI9ZtkxLjf6puGhq+1C4OyHbEu7AsR4otZDp9VGVmjVXoEt7fFLZ7bkwR8EQpnO/ZT1w/rtD4pIKIxib1/SMjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730479; c=relaxed/simple;
	bh=ZWPAe5Q8mb3ayTG7zSObGrwzImhG6FNff0xTMir42UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZfJoTmICF0AHMcBWUn9ZkKlNflPFW+Foqgx3VdvRqCR5nfAm1DMlXCb5q7kad7R8BZO67QBlj/rMNjAKy+ZPvSHgEbZYEEWctLT6yUEOV1PjUHnYBvnEn/+u41R2pGh+fSkFP/BU2XJUKCciNJ0kix9plotYl7EI2KxVKcMkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=I4qhM1Lr; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dea1272943so1593918a34.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777730477; x=1778335277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvAa9MPN2K1pmz+3zxmz0oGcOkUukZ7tkrP7phZgyzQ=;
        b=I4qhM1LrCNCqwcBkCXJ+NIdRcOOGTGOdtQWpzYLKNP7/JVRGWM5DHtV68Bx5Tda2wG
         us2KyA/oFtBO7ISZzZVTpnuL0HobgXzc7jHPBDjXS/DUFzjK++66JEQKtXrOmxNdD3CR
         pDVksNjtP+Aw/rXj4rLJXZz89C7pGUi+JY2OoVGoaT2MVfEQXNGzhxWMYESlmKBBHT3b
         DoKyOiHYripYsDDjHA3l+M1UtdB4b1dPXEpbbpiQWPTeUv9ZZE4vjmQDYx4zdgnev7hv
         jiXbtt2aMSOri9zQlWMPH7x7CCDRSOv/261xbD4nEP/7AR6qCYAPGp227kVJMVSJW7Yk
         3nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777730477; x=1778335277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvAa9MPN2K1pmz+3zxmz0oGcOkUukZ7tkrP7phZgyzQ=;
        b=d+k+FuTXNpOHbeISZa9rnwPaLGFLJOB8fdHq2aYvJXR3W7NSkpeVm+1nlo5oJxwWkn
         Sa2EWSMJwV1ba1V+l70lrW07jpNRCPTzBcCTxGhB2rr8p/ZEO0QDT4ONOSzyG+XXS5B4
         JbsBr/OBVqm0RwLT8hCFCoQ41C6nsja+VpFPAwPexDTNQIkSeok5jLoMk8HFeLgdbYIS
         gTv8DTH2r/kLKiTrmdIxMi8eGig+HVMUciGvSbgCQC48A9CKOkcmylM2N2RgGcRIc7P0
         MMO8FkchXb+nkYS0sJgB+w3irG6mEyi0DxFsXtBDzqKByMoMLH6hh1gsDZf0UYIX6uId
         cxSQ==
X-Forwarded-Encrypted: i=1; AFNElJ90l3Vj+ZxkXVao96lMHr2FADGQmJ545elcZ6iqOHQz8joAEwLKsgrljfDRvJlGUWfNCXpK+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3agrryCrJ1NxvaEPfbChnSUy3fTrivnx/Cmn9iTgb52zsd0d
	1CB9wjyQsqXffJ+Ku8Y2Cc48WiENaR9yS8RrdmFFCH87SXbiqqeIl3+GloiXiWvASII=
X-Gm-Gg: AeBDieveZH/oOe+obSaTdnOtT4x2KTIW/rmXuS9Abx+zRtpQ0q7Qk8QeUgvJkh5724i
	f7lEWnDSpXyqlmbNQetxOck7o1ZmfKMFCMwhHfsNfmtsT+xkJIQeLsgt+INaqK0c7zjRGT4TzRZ
	GWh1eT3dF1JCnveqXdsBkrtxdqIjFaqX9XwyYEb3WwZ14Um4Q4fpjjAtzcOYgAnvNkTf5uaKYLW
	pi+cuRNyxSocS8U940TxehQ7UHrJsRgV82l736pFW1+vCsPM9oNQaqeTRcO+O0/kXlNktIk34kC
	s70iv2mrxYNtGVQ4G5qZgqRPTCBjWqeXkdSkswexAY+mGU0/z2km4ZQ+OCtlCQJfjXmnaAnr2D4
	75oEtFXU6SnuWI+ufPB2elHY3/8+xWVaTzmxamlRN6MzZ3x1nnbQD47/uQYsxiT2NqHJduS3EJ2
	NRgw7xIbl2IKR+hyflGdz2fdTmlxHl49qihcKNI0c8kFyraXEcECgsuxkziHGYlQWBpAD7tZQ1X
	EVTkxC/zDLFafi9JYP8
X-Received: by 2002:a05:6830:2785:b0:7dc:d0e3:5bdd with SMTP id 46e09a7af769-7dee143b7f2mr1811088a34.19.1777730476573;
        Sat, 02 May 2026 07:01:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decadc2906sm4076812a34.23.2026.05.02.07.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 07:01:15 -0700 (PDT)
Message-ID: <219bc2a8-cf81-4900-8d72-96646a87c7d7@kernel.dk>
Date: Sat, 2 May 2026 08:01:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] io_uring/poll: fix multishot recv missing EOF on
 wakeup race
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kai Aizen <kai.aizen.dev@gmail.com>, stable@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20260501225250.90152-1-kai.aizen.dev@gmail.com>
 <3fcf1bf1-23fb-4e01-ac3d-6ec6fb86da08@kernel.dk>
 <2026050246-estimator-hurry-3df6@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026050246-estimator-hurry-3df6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8208D4B23CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242606-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel-dk.20251104.gappssmtp.com:dkim,kernel.dk:mid]

On 5/2/26 12:29 AM, Greg KH wrote:
> On Fri, May 01, 2026 at 04:55:54PM -0600, Jens Axboe wrote:
>> First of all, I'm fine backporting these. But:
>>
>>> CVE: CVE-2026-23473
>>
>> How on earth is this a CVE?! That's bogus. Yes it violates application
>> expectations, it'll wait on a CQE it won't get, potentially. But this is
>> the only side effect. That is NOT a CVE. Greg, please retract that.
> 
> The CVE is now rejected.

Thanks.

-- 
Jens Axboe


