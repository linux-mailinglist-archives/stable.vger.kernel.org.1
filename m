Return-Path: <stable+bounces-227305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMBnB1kAvGmurAIAu9opvQ
	(envelope-from <stable+bounces-227305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:55:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF72CC420
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41E83300E2AB
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2931536165A;
	Thu, 19 Mar 2026 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KBVE9lBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39C2D481F;
	Thu, 19 Mar 2026 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928533; cv=none; b=O0EQ36Wqv9uwrQvrWCTP4uqUL5/TF2OZ86yKBWrai39HgaU3oA/RGGHlXD25fvG2k4F8ngLyDU9f+QKiSV1V8hvumQsV1JLDbZtk25Ds8UdNiWBmkU70wae1emPzbDRVnBj9jgk+xVkNfNNCY3yH6voBfRegYocKuPSfp21CGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928533; c=relaxed/simple;
	bh=B6Mgd6T/oAPkK1MX+JRTgOTzZFJd9XXazVfl//Yh5Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4i/UYUHA9ighViIcff2ZV/0legU7/RGHSglr8/59c8dVk6Pmb4JmhLDAwBzT+lLgqKI+0k3XTLokPco5Ju9V8unMEts/rI3N9sSfNc0JtWpwdJ+9k4eP0g9H69gasJqaD5I7cZCwbfd8GQtqDs7xWwcEkD7kRPwNe8ISEsWl1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KBVE9lBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09861C19424;
	Thu, 19 Mar 2026 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773928533;
	bh=B6Mgd6T/oAPkK1MX+JRTgOTzZFJd9XXazVfl//Yh5Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBVE9lBHWOLme+zG6Xu1ygf01iBFgrBUnqwMggMzC7Li9v7gC2q9NpPbmIB8D7+Uy
	 5lgaplkkKRcycjxHA6AF4g8h5NvbTasY52baaQE7tpg334zMVBMKTM+BAG1AFlPM8x
	 cswLU99L4A7QNcquqfiKNFERmKCUqkReZJTS2eQo=
Date: Thu, 19 Mar 2026 14:55:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Gao <zcgao@amazon.com>
Cc: ap420073@gmail.com, kuba@kernel.org, patches@lists.linux.dev,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.1 148/280] selftests: net: amt: wait longer for
 connection before sending packets
Message-ID: <2026031920-switch-coat-6f81@gregkh>
References: <20260204143914.959181459@linuxfoundation.org>
 <20260219213420.94656-1-zcgao@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219213420.94656-1-zcgao@amazon.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227305-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.882];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BADF72CC420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Feb 19, 2026 at 01:34:20PM -0800, Nathan Gao wrote:
> On Wed, Feb 04, 2026 at 03:38:42PM +0100, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> Hi Greg,
> 
> Apologies for the reply after review window. This patch depends on lib.sh under
> net selftests which doesn't exist in 6.1. The lib.sh file was introduced in
> v6.8-rc1 via commit 25ae948b4478 ("selftests/net: add lib.sh").
> 
> Without it, the test will fail on:
> ./amt.sh: line 76: source: lib.sh: file not found
> 
> Do you think, in this case, tools/testing/selftests/net/lib.sh is better
> backported? Or the patch should be reverted? 

Let's revert it, can you send a fix?

thanks,

greg k-h

