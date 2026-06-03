Return-Path: <stable+bounces-260008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qgqoIH7yH2pItAAAu9opvQ
	(envelope-from <stable+bounces-260008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:23:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A66361E7
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:23:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="cym/tRus";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260008-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260008-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A86530D9D58
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616C391E59;
	Wed,  3 Jun 2026 09:17:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0E388E52
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:17:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478252; cv=none; b=eZ977lndKobGAO6l2GiYduPPyFxMFqs2iq7uz/+L6ObOFIHCA23jyw0vdSPRsC6zE5dED6Af1oz+6F6ADKiae6rDSSOGVwYECkqe+7/TRXAj7RQSUSknSgor/fHWPaW9T0qblacUtuL8a7pYUJccWAZQ9qrrL2QC5DrsOUpLTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478252; c=relaxed/simple;
	bh=kJ82LS2c7VtnpbVfYf6en1BpQwOaSYvNSWOCFvbtoh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxCCh9ZvPbXLHORmFfbIOPrPtrdm0qyamgQ5JBA7RttGSDuY4Jv89PnrjFX4k9Yqz+1zro87pfmF7YybFpe7JE5vAhEQMooYFfmOE+CKNGNKvKsjTeUMjH7LTifOm1F0dfwDgv2JZnuoYIEkheGSE6RE2HRWIuMcArYWwb4Rv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cym/tRus; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1991933f8f.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780478249; x=1781083049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWDk+OzqxFsgFShuxBM2y3BRidTB0F0fOkuYz1HmptU=;
        b=cym/tRusnyMIp6/h3qK2ijvvyyx00AR2Byuq7Ovs7ybtq1GEz20ygu6TS44YNA/DpL
         CbMa1Un5dBUjxztBBK9ajxF3Vm7t9oZ1EdyGj9/fcg3C/3+SQBwruqMjiQqwnHwSnLqd
         4jIozygkpmfpZziEsuQ1QUrC3qDtfebPOXMFGba5YyaEYGCdkr7MfZCylxBdWMSqZFpu
         xiEo/rd6Tr/zvzCf1nwwQPYU4C4zDxYgnqn7kz+uXMmSUbjFKTtb4EmM6yipX6Q0wiAX
         shqtVu8ElOt6widl0CiOMUQcnBxs3IL3CBkpGC8uGyspt6YK06RJHeiAvLnP5Ln9f0hv
         I/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780478249; x=1781083049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWDk+OzqxFsgFShuxBM2y3BRidTB0F0fOkuYz1HmptU=;
        b=XHVDiOfy37ioMUDhDuIeHGovvG/3nmPvKcYEkFu3oRaFN8hjHPu6FR0EhILo/egLQg
         WAU9HmwtKVXQLdDQ1jM9ZvcPdux0Ik2f85JWNkf6TIi1zkg9l2X6uUtP4Et+XgqFTONE
         AJWYw5/qlRTB+YJ6L+K6wgY5haJqqsJu9yfbBW5vzum3K7iXD03P9/GH8QK5B3UXvu4j
         Js5oyVASPXICh5PXduKAMWa/7oBl0CBJa9L7uboXZ76IU6img9s0EEPINw45JbZYOxhz
         4PWKO9zWoaf51zyNtaOnexwMfLVQq412Xd2E3ELNns/c2+2V/kwKnwQqa8oJtmJ4WpU4
         JJag==
X-Forwarded-Encrypted: i=1; AFNElJ+WCzm6ia/nAIVHFSd5JpQcAnmy8S7Vnp1K0OAs6KWZeJhsPhzeCdYT7iexCk7tNHE+41ZMn4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiMS1JPE/cSYpeZJpRIthWXa0kclOYqpIg8x/ELW1F9htML4K
	4ljPJdjtposN7RHpj+5B5A8nS7qewkLc3U1CjSGkPV4tKlR0lNw4vHYh
X-Gm-Gg: Acq92OEfDi/h4i3brNxh9/uWPHb8NbSCq9G4NbnCD0g5DTV5RX+Bh4L+rF29ULdiZ+D
	Sb7Tn+OMthrTz11Xx7KOgMlMCgu340ZidIdxh5e7ni1mcZ1XlkXIbC+nMhHSK5037NZPluRBMrT
	KRyyFWLdKVjeBz08VRbmZXYsuCuuMtCojUtJJD0EXezzNcGjgX2a/TqKKM/oku81qh+EURB8kQs
	jXv1U7Jle8RIpS2qcFXoa6tuQI0l7nUH4F7esB8mQK+BtFsYpSNon4OTzMydBd5jDizo4vRK86h
	NLEhon1aJszh2ft+aHUKL6qrPXa1LSzNTcSoljipjGCWjZyAHp3McwUiuM3XMCJdyzPFo/r8Z5v
	DCeFv10e2dEuYT+rrYRs+ikSdxhtfhLKw6NFdar7+VxzQN1XYRf4ryCoXGjv8nAfPv1E9sZKPYv
	SjpAmYs68g+qTL7EJIZkH0Wsa5456nmmd/w8BkZUoaOG8lOLAMpnshgscJtfQiXb7Z8zeGf8I=
X-Received: by 2002:a05:600c:c84:b0:490:389:7644 with SMTP id 5b1f17b1804b1-490b5fe0e36mr39962935e9.17.1780478248344;
        Wed, 03 Jun 2026 02:17:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b61511c4sm51593825e9.1.2026.06.03.02.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:17:28 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:17:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Aiden Bowling <aidenlbowling56@gmail.com>, Lorenzo Stoakes
 <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil
 Babka <vbabka@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] kernel/sys.c: fix prctl_set_auxv to use sizeof instead
 of user-supplied len
Message-ID: <20260603101726.05d1f7a8@pumpkin>
In-Reply-To: <f6d59be4-db98-431b-97d8-d991e7381135@kernel.org>
References: <20260602024001.14119-2-aidenlbowling56@gmail.com>
	<ah6jS246wBcTH6gr@lucifer>
	<CAGOa741UNr5DzK4vr8RBLvhZcCs9zdva6tqmMptQw5P8ooNEOA@mail.gmail.com>
	<f6d59be4-db98-431b-97d8-d991e7381135@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260008-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:aidenlbowling56@gmail.com,m:ljs@kernel.org,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC6A66361E7

On Tue, 2 Jun 2026 19:25:56 +0200
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 6/2/26 16:14, Aiden Bowling wrote:
> > The issue is that using the user-supplied 'len' risks a partial write into mm-  
> >>saved_auxv if they pass something smaller than the actual buffer size, even if  
> > the buffer is validated. We should always copy the full buffer size after
> > validation to maintain consistency and prevent accidental partial data exposure/
> > corruption.  
> 
> Which partial data exposure?
> 

The one you don't get with the patch because of the previously
unnecessary initialisation of the array :-)

