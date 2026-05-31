Return-Path: <stable+bounces-259380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E0kO2CgHGooQwkAu9opvQ
	(envelope-from <stable+bounces-259380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 22:56:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F2617F01
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 22:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CFD63002F4A
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 20:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1FA369D79;
	Sun, 31 May 2026 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=kousu.ca header.i=@kousu.ca header.b="CpA7w6gB";
	dkim=pass (2048-bit key) header.d=kousu.ca header.i=@kousu.ca header.b="ONJ2JNJ2"
X-Original-To: stable@vger.kernel.org
Received: from comms.kousu.ca (comms.kousu.ca [46.23.90.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F43403EA;
	Sun, 31 May 2026 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.23.90.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780260951; cv=none; b=EbFvrk/gv7e88UzQKOKgT6Fr+AYlLt+yKTpoEP+iPsyNTwrG72isPlxF9BJwWlwVX3YNu69J7GIQS7MSaw6hUMwQmRslg72d0T4RufP9+8KCcLySaSXbeLyZYcKbg22/3L7MwighghIIlUMB1gUC89v29m643V/MnLuoZBrcdK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780260951; c=relaxed/simple;
	bh=jbTNWhwRndBe/mVL+d70N8jfHasPnypOTPoQZy75zdA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XBW3vCt3+N9BH6rGl9Vi6VHwTJ5unG2APGVcguokRzuan93g+pvHohvKNCwIEmWx82JoqJJWwrslUNSZr8rnpnL88mGWsLJ2Z211WeHLhiw9aoxR4i7EoBe1Pyj+nE/9ILqI0lhsChfn0e0RiPbWlWzOqJXUSaPjmFYHd/606Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kousu.ca; spf=pass smtp.mailfrom=kousu.ca; dkim=permerror (0-bit key) header.d=kousu.ca header.i=@kousu.ca header.b=CpA7w6gB; dkim=pass (2048-bit key) header.d=kousu.ca header.i=@kousu.ca header.b=ONJ2JNJ2; arc=none smtp.client-ip=46.23.90.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kousu.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kousu.ca
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=ed25519; bh=jbTNWhwR
	ndBe/mVL+d70N8jfHasPnypOTPoQZy75zdA=; h=references:in-reply-to:
	subject:cc:to:from:date; d=kousu.ca; b=CpA7w6gB2JlTc5jTyd+RffjydzAeIN1
	dOseUah03OXLKGGdvaa8JaiN13/TLtcrh7qGuy1E8djTQQ5RKrJsMAA==
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=rsa; bh=jbTNWhwRndBe/mVL
	+d70N8jfHasPnypOTPoQZy75zdA=; h=references:in-reply-to:subject:cc:to:
	from:date; d=kousu.ca; b=ONJ2JNJ28HFs2UWnALkXu9hXPsOd3JwCDmgSYe+FmxKRy
	vKfk6j5os6PEkcezplTMJAUrrmDJ6G2FzY7WpdjFVclqCZFd8jA+amQhaTcL/2uPp1C/P9
	rysnEtyhlys+3mwXQ+wsfQCBaJb+NTN0aqHBm2biDlQf9367TcBTTqP6PmhL+S0Y7ZABOE
	Fkv5NpDc4OMNCIsmPmBAkN9yluOtii+WtY6N3QxApB7Cq8h57ddW0jwhd17hhWlqXFhoC/
	NUuSOCmMGbwDmIEwP+i/2Mz2Vxe/QyFMKGhUB9l8EJmw0o8mZDAwNUMuRDPik79XsiuIjn
	WPQsRFQg2tENmJcuw==
Received: from comms.kousu.ca (localhost [127.0.0.1])
	by comms.kousu.ca (OpenSMTPD) with ESMTP id 6e368829;
	Sun, 31 May 2026 22:29:06 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 31 May 2026 16:29:06 -0400
From: Nick <nick@kousu.ca>
To: linux-acpi@vger.kernel.org
Cc: johannes.goede@oss.qualcomm.com, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 regressions@lists.linux.dev, John Veness <john-linux@pelago.org.uk>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
In-Reply-To: <75398536-2ca8-4205-9205-18afc5227397@pelago.org.uk>
References: <E2OXET.4X5GTP37VTNC3@kousu.ca>
 <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
 <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk>
 <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com>
 <75398536-2ca8-4205-9205-18afc5227397@pelago.org.uk>
Message-ID: <eddc6acd74abcea6131f3cfc606bc596@kousu.ca>
X-Sender: nick@kousu.ca
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kousu.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kousu.ca:s=ed25519,kousu.ca:s=rsa];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259380-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kousu.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nick@kousu.ca,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kousu.ca:mid,kousu.ca:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 013F2617F01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-31 11:17, John Veness wrote:
> On 30/05/2026 14:34, johannes.goede@oss.qualcomm.com wrote:
>> In case you've not seen it yet, Rafael send out the test patch
>> publicly later that day in another email in this thread:
>> 
>> https://lore.kernel.org/linux-acpi/12896447.O9o76ZdvQC@rafael.j.wysocki/
>> 
>> Regards,
>> 
>> Hans
> 
> Thanks for the pointer, and sorry for missing that! I had only been
> looking in the archives of platform-driver-x86@vger.kernel.org which 
> for
> some reason didn't receive the patch.
> 
> John

On 2026-05-31 11:25, John Veness wrote:
> I'm not Nick, but I have tested the patch here on my old Toshiba Tecra 
> Z50-A
> and it seems to have worked - I now have Fn+keys working fine, after 
> losing them
> in a recent kernel update (apart from Fn+3 for volume down, and Fn+4 
> for volume up,
> which for some reason continued to work when the others didn't).
> 
> John

Same here. All my Fn keys work except for Esc through F8. Glad Rafael's 
patch worked for you too! There's a newer copy of it at 
https://lore.kernel.org/linux-acpi/2046403.PYKUYFuaPT@rafael.j.wysocki/T/#t 
by the way.

- Nick

