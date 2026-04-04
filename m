Return-Path: <stable+bounces-233260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6bMLK02u0Gmy+wYAu9opvQ
	(envelope-from <stable+bounces-233260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 08:23:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C293A39A1C1
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 08:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89F4C301DE19
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 06:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5C377019;
	Sat,  4 Apr 2026 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MCavQK+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503B933BBBD;
	Sat,  4 Apr 2026 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775283783; cv=none; b=iDiKWradpRIiP3wFmU9Ezm3O+NfOuvgPljk15+bFN0NKQqUKTVuKHzmMlzxranz0//EeNhVtaQXsiSTq94HRq6VSiXQ9clgA/0NIAubU4jcbnhRI9Skvz2oUf2f2/+Qe8982zk78YeHAvNBFOUxUePTMpCsW7jgq10ZECd1SgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775283783; c=relaxed/simple;
	bh=iNnj5HZg++VmJ8JOVVzYwT6qH37ngG4hSW37NpcwluU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhCdUDgvExE76L+jTkU+WyzB+ft01oiEYJ7eYwuRkkCJaLobV9e13sKpz2UpXNFV4RMe49P7AhJiZE3nPGDWZTOBKdyRic7x2Aj/Ut/ynVUZREOg8ptQbZI8mhl7E2nUZlwFOMdDhpOhT3EjmkoZEvp7B0OmGwRDhe6l8f5hL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MCavQK+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67991C19423;
	Sat,  4 Apr 2026 06:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775283782;
	bh=iNnj5HZg++VmJ8JOVVzYwT6qH37ngG4hSW37NpcwluU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MCavQK+E7ntcMvzed7iOIiYphf12rgO2yG/mhea3c0ksZu6SOirNPtZG/rnVVLNvR
	 6ybmv2PFH9ep+c8SJG1IzJ8TVL36F4cUeCw2Oc75T3+Y2mtSb1YEso5JVY6T/AHlgD
	 BeanM1h0P4y4PZ6ABuhxoxVb1Dms3JoP833Jktho=
Date: Sat, 4 Apr 2026 08:23:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tomasz Kramkowski <tomasz@kramkow.ski>
Cc: stable@vger.kernel.org, Alva Lan <alvalan9@foxmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xattr: restore file descriptor checks
Message-ID: <2026040419-volumes-femur-731d@gregkh>
References: <20260403230636.344097-1-tomasz@kramkow.ski>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403230636.344097-1-tomasz@kramkow.ski>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233260-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,foxmail.com,zeniv.linux.org.uk,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C293A39A1C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 12:06:36AM +0100, Tomasz Kramkowski wrote:
> This patch restores the checks incorrectly removed by commit
> 5a1e865e5106 ("xattr: switch to CLASS(fd)").
> 
> That commit was an attempt backport an upstream commit which had
> modified but did not remove the checks to see if the passed file
> descriptor referred to an open file. This seems to have resulted in the
> backport removing the checks.
> 
> This leads to a kernel panic when calling `fgetxattr`, `flistxattr`,
> `fremovexattr`, and `fsetxattr` with a file descriptor which does not
> refer to an open file.
> 
> Tested in qemu.
> 
> Signed-off-by: Tomasz Kramkowski <tomasz@kramkow.ski>

Ah crap, I should have caught that in the original backport, sorry about
that.

Should we just revert the original and wait for a "fixed" version to
show up instead?

thanks,

greg k-h

