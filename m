Return-Path: <stable+bounces-227307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG7lCScCvGmurAIAu9opvQ
	(envelope-from <stable+bounces-227307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:03:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A01DA2CC5B8
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF903239FE7
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F936CDE0;
	Thu, 19 Mar 2026 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OPdJbKt0"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B199C3BED40
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928785; cv=none; b=ppIxz6SjTljIqndzFS+SST+IYkt3EBy/nXRq9qWi0RUE/+XfRMh2qyiz4XAvoDC+4Qh+/X7Okr23ukjbS1e0V3zS5qzrfQbv7znivtWcMzDtpaYvawexQ80P7mhe+8OfGqBGDgs7mrH2BJciAQNXKVCGR9guBfP7DeHfXqkWdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928785; c=relaxed/simple;
	bh=r1Oad3yEIm+4Mn3a5SSXoqW6hQtvMH82TAhx4xRxGmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ0+i7ktgAtmcz4l+3KMrSEok4IGLf5vj2w5yXTYSl/Gj6OYJBEzNBQSANtcnTPlNTOGfQhjQPpRko02x/nP95zUne/Rn4rKV9CKo9VzQdSC5EH9hD1qNjwCpGAebOufortQH9YvD6zj1JH3VxURx3t/T/P5E+45anmIjEgS6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OPdJbKt0; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-82-102.bstnma.fios.verizon.net [173.48.82.102])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62JDxQYq027693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 09:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1773928769; bh=XdmDZ/TgnLjxR3aRJ1G8nfZazOQHGOiLK/eYzaDPW+s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=OPdJbKt0Fltg0aXQ2+DW/beeyt+MeTo+TmigWI9MtD0w7EQFhZjx0IPkJttgNW22b
	 uUxeOY0CDQyLki8k9dRlV5qhVPdZbEtqAyou1NF1ww/EK+h+lpy5uToKUyx9N0rtIL
	 e2osJVxEHbe8g7VLHZ7VgIFkd+q89ZSsxf44gCXbMj29pbAWUrkPU7PMNLSWyq5SPs
	 BSZFBiMD0ojhCR6O7Baj0kJE2cEPbpez0dyp3FwSl3jE+LLeyhjCbAFp1nWHC4hipB
	 gskeUI1iNId8eOEOIGOL+OFKzz3fi4r4mmQOr39Ni98yfpt3Lw/tVVwciPjEswl++g
	 gCi3mzAcP0DhQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 4F59E5E493BD; Thu, 19 Mar 2026 09:58:26 -0400 (EDT)
Date: Thu, 19 Mar 2026 09:58:26 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: ZhengYuan Huang <gality369@gmail.com>
Cc: adilger.kernel@dilger.ca, tahsin@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        r33s3n6@gmail.com, zzzccc427@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: xattr: fix out-of-bounds access in
 ext4_xattr_set_entry
Message-ID: <20260319135826.GA91368@macsyma-wired.lan>
References: <20260318075842.3341370-1-gality369@gmail.com>
 <20260318144509.GA82331@macsyma-wired.lan>
 <CAOmEq9Uq5xMvhT7cyoY2uhSBhwSEEJ1vYRY36N4sxZSPCO1S8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOmEq9Uq5xMvhT7cyoY2uhSBhwSEEJ1vYRY36N4sxZSPCO1S8w@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	TAGGED_FROM(0.00)[bounces-227307-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A01DA2CC5B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 07:13:45PM +0800, ZhengYuan Huang wrote:
> 
> And yes, the reproducer does involve actively modifying the mounted
> filesystem image. We use ublk to enable this behavior.

We don't consider bugs which involve modfying the mounted filesystem
as valid from a security perspective.  In particular, I don't want to
add checks to hotpaths to try to protect against these sorts of
failures, because they simply shouldn't be allowed --- and/or if the
attacker has write access to the block device while the file system is
mounted, you've basically lost already.

We have added the ioctl EXT4_IOC_SET_TUNE_SB_PARAM to more recent
kernels, and will be teaching tune2fs to use that instead of modifying
the mounted file system directly.  Once that happens, we will add a
kernel configuration option which works like
CONFIG_BLK_DEV_WRITE_MOUNTED, but which is ext4 specific; so that for
distributions that are shipping a sufficiently new version of
e2fsprogs, they can block write access to mounted ext4 file systems.
Quoting from Kconfig documentation for CONFIG_BLK_DEV_WRITE_MOUNTED:

        When a block device is mounted, writing to its buffer cache is very
        likely going to cause filesystem corruption. It is also rather easy to
        crash the kernel in this way since the filesystem has no practical way
        of detecting these writes to buffer cache and verifying its metadata
        integrity. However there are some setups that need this capability
        like running fsck on read-only mounted root device, modifying some
        features on mounted ext4 filesystem, and similar. If you say N, the
        kernel will prevent processes from writing to block devices that are
        mounted by filesystems which provides some more protection from runaway
        privileged processes and generally makes it much harder to crash
        filesystem drivers.

The official syzkaller instance sets CONFIG_BLK_DEV_WRITE_MOUNTED to
"no" and we've asked them to block fuzzers which try to modify the
file used by loopback mounts, because these sorts of syzkaller reports
are pure noise as far as we are concerned.

If system administrators are stupid enough to make the block device
world writeable, they deserve everything they get.  Similarly, if
system administrators don't run fsck on random USB thumb drive dropped
in the parking lot by the MSS or the KGB before mounting it, again,
the bug is between the chair and keyboard.  (For that matter,
inserting a random USB device for which you aren't sure whether it
came from a trusted source can make you vulnerable to hardware-level
attacks.  Just don't do it.)

That being said, we are more likely to accept patches to address
static file system corruption, but the checks need to be done when the
metadata in question is first loaded, and outside of a hot path.  But
trying to defend against dynamic modifications of the block device is
really a fools errand, without completely trashing the performance of
the file system.

Cheers,

					- Ted

