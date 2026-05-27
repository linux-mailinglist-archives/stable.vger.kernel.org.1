Return-Path: <stable+bounces-254517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNcINsaxFmqOowcAu9opvQ
	(envelope-from <stable+bounces-254517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3863B5E16A0
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 695163073FA6
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1195630DD2A;
	Wed, 27 May 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci+pHJGj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF0F3E2ACF
	for <stable@vger.kernel.org>; Wed, 27 May 2026 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871805; cv=none; b=aDRwoAbFATCzIfDJeZtM+KP37inSLCXu08BzOtq0x35aWj2KkwDGVcdLiyUJmXiGhdw/pAkFQzexUp51X+TCPEFwIwOcQGXfxPnSJHvH1G6DwfNS7D1Y/zie+19AQ1eE/haoi8bCTENtE8jZPeT6HKvG9Fu0rzHqVVQhAACflBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871805; c=relaxed/simple;
	bh=d4mOSMwrGgndEpUNX9luVvoIJV0EIK0M/2MsFKF18to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPV+BOljhXFsqgI2B/4IIVIZ+O49eD64yLIDiZYnwK5iv0ZjZsVYal1BvyLCCelNG1RzNdswExw8boNe4GwEYpi235XB9lM3+PhK3nNI2U8xNJIQMxhbluFxMOGn3Ij4HHoleKCdOsVVjY/2P6UaR6e1cAYt5A6mzWFjC1L8jDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci+pHJGj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so3399955f8f.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779871803; x=1780476603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxsKIqh4N95awsepLUfZFifBLY4rZGMxIgBOQ6jmDpg=;
        b=Ci+pHJGjQiHjmk/tOtsmvuDg1u+jAdsABAMwgRuGbkQP6ogeHIrp1A5yrfOjLLbNe9
         4ZL0vOnnwuiDKBgmo0SraJ9FP/O6CT3KZ9Xg3TSHgRDY0R4xsT5u1vi2HHhng5e2lIcS
         jFuoZEEmpWsw5l+Gp+KE6lY+N7v8QFg6DB2zbuFgSvWD7Fiyq3kHv1hk3SVxjTwdabS5
         n7+nNe48GRYy0yxBNIemmi03N8Wca/iEETyHfNEVK9xrF7cuo3b7v8VqDOuU0UagTD0f
         RQX/+Muzw3rxZejhLSMVpmH3RqFWJKW9XgR7N80Jpi/5hjn5bO4H/H0a+OEnmskFp+K1
         8ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779871803; x=1780476603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxsKIqh4N95awsepLUfZFifBLY4rZGMxIgBOQ6jmDpg=;
        b=Fjdu9ybopR9vNjHYU42vUvOMYjuS4saC4uda27FhUlV3NX6ndFZVdjvK2UugFdwT9f
         9PskRTQEeonMqF9R/SvQ2Z7GWnabXTLwvOBz3c4UdgshVRZRtiL/K7wBffCYARV6lNge
         16ri4ItRdgGHlYe0yuGwtOH0P4RxBLcBDb1yi0VXhCwVIr+7mJJHx9HkHctAbJEkJ566
         qfne+l4WAujS3g8RiJowxhI18ArSOIzRPFqD3ylQEz5ONElpimLWj7xFsnw+4YENv1Lm
         JiKFeOXmIRbUEc9ujIoBSbc0Wi5JGYnTlYyuv46gEDAhh5pS8IUDkXiPNQCQrLMhEh8f
         mxtg==
X-Gm-Message-State: AOJu0YwutbVx1jPpEAqmRsS4W/CJF5zQFwRVurH8J1YfjOP9p4+3bT/X
	4z+qa8sLuwnJ3JreWHf3nefkgB7HsICbSP0oFaEoaF1S0yewPilrc7OU
X-Gm-Gg: Acq92OEz7U5yOlR1J4UYh1q3EeAQ3jslyJDx9ZHBV7DJVqRDz/V+OTFvBEmEZgscJoE
	K1Ym3fMQsYf6Q0KBjpvmjVZMHTPKYylrLE80nFwSA88xif7wwJnERFCHh1NTAPFieWmoICrwQkg
	6OIbpjzAAxfaAygK2Aq6BMX2Arup2Vy6l3ju00vVvz7yMi+IY1TT+JEovh/Txuc+vniGQ1myVFv
	drbFsFZD7N2uFRgRp+gi1SnzT5Ju2a36HLGhfJSaPbRMLtXgJbnU1l2EmRhS8YR1hw2Z9pWcWje
	Op5hNSoxfF6SmCYcCQV1xgw6TH3Dv4TloRlTKZOJdOJRA5WN42Ofa4jA2bRVg/8SmxXQ2pswVtI
	wAQITGkIN9/7nooL+kEZ5DtFGKUjwBjV37yIZIsMhzuEGAUKfbKrvm+jkixkSUfieytA8DUTPjZ
	QWaBgPeTJHnV3JekPOjQkof7QgpIcs3KTWSA0DOLLi8ra0shQpe5QPusOxRSk7jcI2EpRsPs/ed
	0+lKx+zg0I2QwLAOaDgXN+lb/Ji+EsLU5Ky623kLtYiZoVgwJaF34fpu1C5pOa1O2dzn+j3kgU=
X-Received: by 2002:a05:6000:2383:b0:43d:73d4:b2f with SMTP id ffacd0b85a97d-45eb38ca94emr38869194f8f.39.1779871802360;
        Wed, 27 May 2026 01:50:02 -0700 (PDT)
Received: from franzs-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54a3c3sm4347563f8f.8.2026.05.27.01.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:50:02 -0700 (PDT)
Date: Wed, 27 May 2026 10:50:01 +0200
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [stable 6.1.y] Will commit 7e96a281fa07 ("perf tools: Fix module
 symbol resolution for non-zero .text sh_addr") be included?
Message-ID: <sfhft5fhzby6fo52ltmioi5ziwwvgdofzknjhmpvmpbwfkiksu@u3nuemckqchx>
References: <ljz4f536p2oyxrtc2tklh7ymdqg2stcijj2cjepaaheqlw5ddq@vgqf24zcaadv>
 <2026052738-flannels-hardly-40ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026052738-flannels-hardly-40ea@gregkh>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254517-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fraschnyder@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3863B5E16A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 10:12:04AM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 26, 2026 at 03:50:08PM +0200, Franz Schnyder wrote:
> > Hello,
> > 
> > Our OE-Kirkstone builds of linux-6.1.y from linux-stable-rc are failing.
> > The problem is that the following commit is queued up:
> > 7e96a281fa07 ("perf tools: Fix module symbol resolution for non-zero .text sh_addr")
> 
> I do not see that git id in Linus's tree, are you sure that is correct?

I copied the id from the stable-rc tree instead of the one from Linus,
sorry.

The commit id in Linus's tree is
9a82bfde4775b ("perf tools: Fix module symbol resolution for non-zero .text sh_addr")

Thanks,

Franz

