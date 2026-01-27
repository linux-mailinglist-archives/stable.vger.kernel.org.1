Return-Path: <stable+bounces-211817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDJbHazBeGn6sgEAu9opvQ
	(envelope-from <stable+bounces-211817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:46:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3454295120
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A04353014407
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB1A35B126;
	Tue, 27 Jan 2026 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goHiphA2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09456350D6E
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521572; cv=none; b=XvcMOqdLkOOwnpk6Q88soWKbjvJGKJokzrV2f80POI8ERg0B/xv9wwGF+J/hU2kA42yJZRN46HWw0M0EJA218znAN7q30ohww0sv+O4MxXrR2qSimEwKQu/6wLFgwbd13mfgwHnjLPJv+w0rmes6UKhM5SrqY56yXGFm+c8/14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521572; c=relaxed/simple;
	bh=re6NSiZizBDEm3EpB+1e8HbLc2V1raKduoGD2wp8Pe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyYsIIpXwYGKecVrHYgBrWa5tf4DHCUhrzro3IoUHIJcGDevF9IzJSMPF57YgotpU9Yehqux3JSrZXFBb718LWVlB6Y4cHEog+78FG5C9YsxW5Lh1ETzrp8ltt+31i7G87Bvmz6gnRoWPYDLlSNA5wnoENZToYV5RamTGidBWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goHiphA2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43284ed32a0so3410574f8f.3
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769521569; x=1770126369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6OQwLQVXz7cUVwRGuGUS5QtspAXdqTx91X6RLYCCic=;
        b=goHiphA2BY86LhXWzMT9cZDXAFvdKVS5K0wRNu/VOX/YDeliq7P1qru4TNUkrV+mW5
         2EpgC/05F8dCeMh/kn3W9x2pM1TlCHtiulznaekt1k2heI1ilxwDFFVhDPvrkOojAJXx
         iXsLxklr5PTjLnYW59zBtkY7cIRpF/mxoqp1ofZkiWl6eaY063h9zl5u1Kv/N95QvTxU
         hfFLR2RAKKd1aKr3PQAFyokEexebiLs/4Qrd8zx4pSC9ezL+K/APnmw5mzYCXMpkKvs9
         oqcpkRrjmpfsAoQmMgjR+AHMK6gbQSw8Uu8pPExDS/tuj3NN8pqDLoPYoHuaF2qOwz9X
         WgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769521569; x=1770126369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6OQwLQVXz7cUVwRGuGUS5QtspAXdqTx91X6RLYCCic=;
        b=KfKVtUcAU4Ul9m5m3Ydy69ccOmnkpgWg5KYeyCDu3fUW7GLFnv2GsFKuomAvssJJ+8
         K5f2vJcf+/CSaQMSdxzWupHUB5gaVxhWkE6HX0rw6FmTnLgMDs2CmmhZ2yZccu8Fc68y
         oD2BVTED8KS1u5aEVrK22esxBQ13KDB6h4Do2EJxKxxdoEn4eJqp+S26OCamz8To5ly2
         hv67dh1a+YhWiztHXVOfLcbVKLRxQdsgBrnohbCtYi7nxgAX/QcoLtY5rjhY7DtIiQB4
         bBKvmJYObdmHfeIYOhJr58Ppog1mAT+Aw1tNnx41UoYXBq+br4lF2C9gGVWhnBwCAdk5
         T8VA==
X-Forwarded-Encrypted: i=1; AJvYcCUx4u1U4ORSOKCZn7++twRd8w5DSDU3GGQ4MQZEV87zy+0HQr5LEKcTmMID52ivsWYvEbVIhbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TORGHKSPPpDxJVwWvx5rqo8Fm46+kVNKEiTc2UQ8ODO82wul
	ejXAlAL5lG7DXKChtqZjJNpbRsOkGn4av8qnMUhvHkWXHvbZzjz24u8m
X-Gm-Gg: AZuq6aLJ65mVqYCz1nqs9mc+1ueta01nvdc3X3QDxFu5t3Qpod8a82Jl+x5QNIEtlZU
	gJfjG71ntIC51dNOGEQxh7qJTuuupszauG3AVMa4hEJJoYZ7+VRiYLmJZwgUOWtwqOulILcHZHR
	cG1USGztYexJge70w5iZhTq2aD53brehU6cUz3P5F0hAB+a+Jf5P6CSDGrmwV6yuq1UKBlirViQ
	FVrTE2nkF6mA9360vyeL52o6jUgy82QNgNmUjcz87KMtA4ER+nF/Egp39hSRAf0xhL0DbBLwKBl
	a/C8NjcQc1iMQHNtMLA9QODq/r84hUbiJnO6wlNlSFNB6uzk+FIwubFayN5Xj+cbAyTaac8iuca
	jl8Jkel3QJnowmbmC47CadSk4uXs8EIyENc1yTdNou1192h0Px6jmWWdpNQI2cyXdW1mhCTiWF2
	hGq1ltft/ZR7farNyGuxfatgc=
X-Received: by 2002:a05:6000:2c0c:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-435dd02dc43mr2250887f8f.2.1769521569105;
        Tue, 27 Jan 2026 05:46:09 -0800 (PST)
Received: from debian.local ([2a0a:ef40:e94:5d01:a218:5589:9f9c:4f52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24a8asm37902764f8f.12.2026.01.27.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 05:46:08 -0800 (PST)
Date: Tue, 27 Jan 2026 13:46:06 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Message-ID: <aXjBnu8MAg5ly76z@debian.local>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local>
 <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
 <DM3PPF63A6024A9FCE1CF29C0492A406E7AA390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXit5795WQLL290t@debian.local>
 <DM3PPF63A6024A91EFB76D52F9590E82C30A390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF63A6024A91EFB76D52F9590E82C30A390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-211817-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[debian.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 3454295120
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:22:06PM +0000, Korenblit, Miriam Rachel wrote:
> 
> 
> > -----Original Message-----
> > From: Chris Bainbridge <chris.bainbridge@gmail.com>
> > Sent: Tuesday, January 27, 2026 2:22 PM
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> > Cc: kvalo@kernel.org; Berg, Johannes <johannes.berg@intel.com>;
> > benjamin@sipsolutions.net; gustavoars@kernel.org; linux-intel-wifi@intel.com;
> > linux-wireless@vger.kernel.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
> > 
> > On Tue, Jan 27, 2026 at 05:05:31AM +0000, Korenblit, Miriam Rachel wrote:
> > >
> > > Just making sure: have you been able to reproduce the assert
> > (ADVANCED_SYSASSERT in the log), and then the panic didn't happen?
> > 
> > Yes, the ADVANCED_SYSASSERT was logged but there was no subsequent null
> > pointer dereference.
> > 
> > > If yes, please test the attached patch, which is supposed to fix the assert itself.
> > With this, you are not even supposed to see an assert.
> > 
> > I ran this through 15 suspend/resume cycles with network traffic. The
> > ADVANCED_SYSASSERT did not occur, so it looks like the patch does fix the
> > SYSASSERT. There was a warning logged once out of the 15 cycles:
> > 
> > I think that this is probably a different bug though - checking previous logs with
> > journalctl, I see the same warning occurred once with 6.17.0-06871-
> > gf79e772258df which predates the "remove STATUS_SUSPENDED"
> > commit.
> 
> Thanks for the help!
> 
> Regarding the warning, please open Bugzilla ticket for that
> 
> Miri

Sure, ticket is https://bugzilla.kernel.org/show_bug.cgi?id=221017

