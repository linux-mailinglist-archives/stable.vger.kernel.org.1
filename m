Return-Path: <stable+bounces-227087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM0OM4C8ummqbQIAu9opvQ
	(envelope-from <stable+bounces-227087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:53:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E72BD958
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F3EB30B3DBE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85593DEAC1;
	Wed, 18 Mar 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MDBNTWDB"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2593DD516
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845191; cv=none; b=gWTibFtCgicasM1AG5gutDZMVCDA8iKQ72gs7i0xBVE/D/W9meDpEVvaC/FX88sqoJurIe3de+lg83d76RHpR1GqFMQBy5O6wB8UBybo0qBCW90WJ4dT8xnwV/tC2+/YC/1xAP/Z18hnBiYUdnd7t9bpFuZn5BcfJqb2WxEOl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845191; c=relaxed/simple;
	bh=E3hkf7oJJHGAbkP5IiSZnym+Y8ReXAsW0vJHLINye7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0dqVDr4HG05oGAppWudhanlebsPhFAZ378+h8pL0L+mEqpWNSQBo4aEiHubF/1nMa0vcecfbUKsEoEepHuDn+ezubS5NQuJ1PrGlqE3WGlwGbwDhKqRqe0cc8ZSTiqExMXsPL1R41YRiEFKvcyRr4CDjur1pEiohRCxGRW+h+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MDBNTWDB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-82-106.bstnma.fios.verizon.net [173.48.82.106])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62IEkAUX002854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 10:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1773845172; bh=Ipml5wMNShVyp75/WWElayr2ONTOoHO9x8HhhqvmQ6w=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MDBNTWDBtrzmCK0H4IO3T1IenRepJMqIjELzs42ew18QyqQSA5Arn7Fb3ZKk99DEj
	 bWMCqA+f9SLepMDJO1B/NJ6DPY0wNLtklnmdHo4owGzeqcEXMGQrktNYMPDIXvfZac
	 0T50sD2fD4MXGPlNIDhbaJeST4V5sRu6oLoDfK59Q1hA4j/2BQYX9wJCu/ZHCUzaAL
	 HDVXLn37fNLJepJspYk0JgzgPf765y3gPp3NixeIrxcSr7KBFyJ4+MwfV3a0IBrImw
	 OsswJxyPQrZR7bHV6ZjWAD6axVkYCrRcspA26IwCzYm7iPFnU8fbFoKkrAPQGBPn84
	 eaH/Rb2UzSWlg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D122C5E200B9; Wed, 18 Mar 2026 10:45:09 -0400 (EDT)
Date: Wed, 18 Mar 2026 10:45:09 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: ZhengYuan Huang <gality369@gmail.com>
Cc: adilger.kernel@dilger.ca, tahsin@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        r33s3n6@gmail.com, zzzccc427@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: xattr: fix out-of-bounds access in
 ext4_xattr_set_entry
Message-ID: <20260318144509.GA82331@macsyma-wired.lan>
References: <20260318075842.3341370-1-gality369@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318075842.3341370-1-gality369@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[dilger.ca,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-227087-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,macsyma-wired.lan:mid]
X-Rspamd-Queue-Id: 4F6E72BD958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 03:58:42PM +0800, ZhengYuan Huang wrote:
> [BUG]
> KASAN reports show out-of-bounds and use-after-free memory accesses when
> ext4_xattr_set_entry() processes corrupted on-disk xattr entries:

Can you send us a pointer to the reproducer?  And does the reproducer
involve actively modifying the mounted file system image, either via
the block device or the underlying file (if a loop device is being used)?

    	  	    		   	    - Ted

