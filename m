Return-Path: <stable+bounces-253487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJQaE5PODmpoCQYAu9opvQ
	(envelope-from <stable+bounces-253487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:21:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E30455A236C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9536C3064BB5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43523403F9;
	Thu, 21 May 2026 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="IKogwvfV"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69E36A036;
	Thu, 21 May 2026 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354911; cv=none; b=fRBMuuHnPxCQw88HtBmcy5vSo8Icj0WXQK6JK0IpQ33HVuKtyx9yY84H0sZo41/8b7QN9rH1dswm2Bkil0qJ+OQZKWzUO3llm4faELilXne+q60+KTBoVAlUJOLDwHLKrBDWEMAKZYB9M27MLHGkcv49CxufZOSAyg5bDv9F1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354911; c=relaxed/simple;
	bh=nUKuWNBiWhCdVz2rqw7fsH7QNaSazP392m7J6xx94wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsEPJINzS7kzaF0RsE7NqnhQKfwstmo+hBY1JqD7MveebZTgb3vgBbCtVBbWLn1ERfmN3CmzUNK0XKh+ReuyHBvku8ROhsj+2dU2fIeDEG7aEdtGd+Mt12ZFwAm85UeHnZDpxrQvRB2ZRw7/EGZ/5rXPUpbI6TJOwYkBqIIShkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=IKogwvfV; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 6C8F46005403;
	Thu, 21 May 2026 10:15:04 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id Cqj6B6mdGItx; Thu, 21 May 2026 10:15:02 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 69C4F6005408;
	Thu, 21 May 2026 10:15:01 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1779354901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myizXeQq+JV57MgRLAo4GSps27tWvx61wJ4rnoZ+ifg=;
	b=IKogwvfVGysD4oioV2P40t4MKEAUudRff+/8WQTV69J6TU670i1ZYHBulMgQ4eulUbOtpn
	osVcwvfG05/KGG98QZ6At4OaYWD+LVaGAnZbj8QB9sqD2wZV7zQlkN/E0yD2PmOMkIhrVM
	s2VXChjVRQLg1vEaarB2UGww2fgAkgcJt/R6zZVko5AKlWdq04m50DQvr136lXEHtEQhSz
	FKEmFedH3UcML9alnb6zUUvLtlOqIGhC5btb8gaCwmfL5f/kKpH20yAuN2LfQbIt3hcQFm
	k3LfK1QZ5r2iC2fcpxwKTHDbWyf8/kp47fuSPRK/cg5iwczcX1Aq/yfI9LFSNw==
Received: from [192.168.96.1] (unknown [89.214.153.114])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 1B00D360228;
	Thu, 21 May 2026 10:14:59 +0100 (WEST)
Message-ID: <9686be2b-8f9a-48e2-bb9b-b1e895f8772c@tecnico.ulisboa.pt>
Date: Thu, 21 May 2026 11:14:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: max77620: Avoid regmap mutex deadlock in power-off
 handler
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
 <c8d16352-63a3-4512-b90c-a79e7e96dd3c@gmail.com>
 <38f5201a-6b52-4f18-bbbe-775171a3f147@tecnico.ulisboa.pt>
 <20260520161900.GM2767592@google.com>
 <3b2b25f9-3ab5-4811-9945-f317b8788484@sirena.org.uk>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <3b2b25f9-3ab5-4811-9945-f317b8788484@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tecnico.ulisboa.pt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tecnico.ulisboa.pt:s=mail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253487-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[diogo.ivo@tecnico.ulisboa.pt,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[tecnico.ulisboa.pt:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E30455A236C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/26 18:23, Mark Brown wrote:
> On Wed, May 20, 2026 at 05:19:00PM +0100, Lee Jones wrote:
>> On Wed, 20 May 2026, Diogo Ivo wrote:
> 
>>> This patch was motivated by the Sashiko review I got in [1]. Its point
>>> here is that there is a possibility for a deadlock scenario in which
>>> a secondary CPU obtains the mutex for the regmap and then smp_send_stop()
>>> is called before this secondary CPU gets a chance to release the mutex,
>>> making it so that when the primary CPU tries to acquire it to issue the
>>> write it hangs. Is there something that I am misunderstanding here?
>>>
> 
>> It's my understanding that using the Regmap wrappers _prevents_ locking
>> issues, rather than causes them.
> 
> In the case where the CPU is being powered off during a regmap write
> there is a potential issue - as Diogo says if we're in the middle of
> holding the lock and we power off the CPU that owns the lock then it
> will never be able to release the lock.  I would expect the same issue
> to apply to a bus like I2C or SPI though, they'll hold a lock while
> they're in the middle of doing bus I/O unless you use some special API.

In that case can we call __i2c_smbus_xfer() directy from
max77620_pm_power_off()? Or is that unsafe because it can interfere with
an ongoing transfer? In essence my question is what can we do about
this, Sashiko suggested to move the handler to 
SYS_OFF_MODE_POWER_OFF_PREPARE
but I believe that that would/could be too soon.

Best regards,
Diogo

