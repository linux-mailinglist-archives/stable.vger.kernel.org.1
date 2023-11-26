Return-Path: <stable+bounces-2682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FAC7F92D3
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 14:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE53B20CBC
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3ED262;
	Sun, 26 Nov 2023 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jidanni.org header.i=@jidanni.org header.b="gnK93z0k"
X-Original-To: stable@vger.kernel.org
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4369DD
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 05:15:56 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 40C118415CD;
	Sun, 26 Nov 2023 13:15:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EFD728411E0;
	Sun, 26 Nov 2023 13:15:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701004555; a=rsa-sha256;
	cv=none;
	b=2JhFDUZLGNtgrgVqRu6OTjOBoPrDAbQPUMp/d3SIlu9d5DYVEFjAtIwXB6MWOpuVtjIlLh
	r1rQRINfNPeID+2YC32eHeiftjmDcWIopD1As5hKFuscBKL0Up/Xqf+Ry+4KXZVB8QgiMz
	/bi0IBF0j4bpupO/Wn4BZfegclMRM3jkOFg1aQbDZAXnZiU+Fv1I6AKNkij4gHzusRwPuX
	whJ87w9C+xDbM4yvWupm67h+6xtxqzmnJtEQJ7nyKZoZuEP3lx66C7p0D3jXQ3dN7ve7XL
	yitrrgE+TtRtoT1VUNrEZ0OsZHcwPKnrONXlyS784SBLFJfokNywmPAwR/aySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701004555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OrLgS2KJlP8Ynld4XbrxM3XRQ+XOnp1IN7l0jt7p4sI=;
	b=FUtFnnRXQFSx4v5z5gfFQf6C0q0B0jocQaguFD60pqJCmloxmLhlFwc5WduZJJ2uuH3usf
	PBzk9Y/B0LdSKFBDVO7USxVgwykQJsOyivMi9gNJAbCrxbDM8zoxUeNyBYqf4u4n+BRuFw
	MOdvVN+kSSuRYCTOQ7WL1aw3L4YHO6EVPWLVtJZjL2oYi8uyndJ0p34hfsIOGXTDJYcODA
	qm/YIsnTT+qjYv8cEhot4iY1Yeo0h3qgZL71JYWDbMjeW+Z1kRzKHe+JbRUgsx2k2fC/wM
	HXcAeZgbwy0Ys4GImBtl5YeiXb7pm1ui4jIteiXuBSf+KO16faoF/qb+AAqpKQ==
ARC-Authentication-Results: i=1;
	rspamd-696ff67dc8-bpzzh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=jidanni@jidanni.org
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|jidanni@jidanni.org
X-MailChannels-Auth-Id: dreamhost
X-Left-Arch: 7e26ee0473b4768e_1701004555086_69594076
X-MC-Loop-Signature: 1701004555086:1739063577
X-MC-Ingress-Time: 1701004555086
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.22.63 (trex/6.9.2);
	Sun, 26 Nov 2023 13:15:55 +0000
Received: from webmail.dreamhost.com (ip-66-33-200-4.dreamhost.com [66.33.200.4])
	(Authenticated sender: jidanni@jidanni.org)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPA id 4SdTk25T6vzJJ;
	Sun, 26 Nov 2023 05:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jidanni.org;
	s=dreamhost; t=1701004554;
	bh=OrLgS2KJlP8Ynld4XbrxM3XRQ+XOnp1IN7l0jt7p4sI=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=gnK93z0k0h2B512jCcS+L4DpQfqz7K/lKLKEKpO8DhPZDDU+/rqweD1iLSRWLs7IS
	 fEo1gIpo3AaKphHijKcm4MZJCFOgLBL51q7hcjhwC1fNWHZAHOg9MOeowdXishPMk2
	 gKFbmvjjHjkG6V4HX9C0ksSePK26NdFRy5k5+mjgo8g1CBPkHYojyHMK75GwsWc9xG
	 tF7WgBRc5mipaQq/HkJaogAqfXPvhpl1E1T3swzhM0VpxNNB0SfYovJRgTU/7O3KIJ
	 e1d9RlojamnUBTOeHSOgPnKEMD2RXnW/gxzicroDrYu97OfyQHFJnkBv6LDLTOzyFS
	 rPQGfzQPJ5SwA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 26 Nov 2023 21:15:54 +0800
From: Dan Jacobson <jidanni@jidanni.org>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org
Subject: Re: Say that it was Linux that printed "Out of memory"
In-Reply-To: <2023112613-decorator-unroasted-500d@gregkh>
References: <9399ce7b9ffa0ff6da062e9f65543362@jidanni.org>
 <2023112613-decorator-unroasted-500d@gregkh>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <94d9fa8b79f32ca4a2a22773d742a524@jidanni.org>
X-Sender: jidanni@jidanni.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Prefixed to STDERR, right before the words Out of Memory.
Well at least bash error messages make it clear they are from bash.
Perl is in the habit of assuming everybody knows its messages come from 
perl.
And now the kernel assumes people can guess they come from the kernel.
Anyway, I bet half the people who see this message,
https://www.google.com/search?q=perl+out+of+memory
assume it is perl making it.
And... not everybody looks or can look at kernel logs.

