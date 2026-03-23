Return-Path: <stable+bounces-227928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP6+BRsJwWmtPwQAu9opvQ
	(envelope-from <stable+bounces-227928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:34:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8373B2EF239
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 353FB30269D2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A4A2FE056;
	Mon, 23 Mar 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzFLVFFm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A638656D
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258174; cv=none; b=Lq8omzlFjyNLQFzsli3HPbfZYwKutVl2sxjlNfiSqpousXWG6BMU6DZHtrFwUbfQBJ0ize1pyZ5+qvnEbrNQ5W2HfCCTqmWX/v7OWBSHFtFpXVFlxl+t+6OcAyXyuyCuMqCgsLpZq9wYgthrCdTpkkoOnd7qRjD2Qd8O9nN69ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258174; c=relaxed/simple;
	bh=f74ATWNNn+axKP/voR3C5P4uQqjt6xMaqiv8LFrSIpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz4oxpQ08XHTmQNwUrkqFqavWkNTXLlMtC0KsdYo1MoEhpkYItPCgeXwW9ey1Wlutu+2QosTKt+GtALvAPfnGzpLMyHiP3S7Bgl6zuwsT4IfsOcFiFXc4YKNKqtiUskcUwUBYvVS/xclL9yFVrCAVp8nAlQv9uzRSUyZ49Ei3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzFLVFFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AA1C2BC9E;
	Mon, 23 Mar 2026 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774258173;
	bh=f74ATWNNn+axKP/voR3C5P4uQqjt6xMaqiv8LFrSIpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzFLVFFmy2j3bEzZxty27lkFHuOeDrTAOpFK2KR0fRbrnVLHuQeuC/b2JUkVy8Wph
	 gK/GdTbb3k8yL6baATH/j6PxcCddnbIeOGL50hk4jtowNBUka5jM5uARmHfTqaj1/Y
	 viuPjKl8XacLWD1+3LDnkY3Yt6ZWu8JVoVwXnYXk=
Date: Mon, 23 Mar 2026 10:29:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Zhang, Liyin (CN)" <liyin.zhang.cn@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: Backport request for two spi-nor otcal dtr odd length/address
 reads and writes patches to 6.12.y.
Message-ID: <2026032300-dictation-upper-71a6@gregkh>
References: <55ce141a-09fa-404a-9932-1e1d4b0ad034@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55ce141a-09fa-404a-9932-1e1d4b0ad034@windriver.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-227928-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8373B2EF239
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 03:53:09PM +0800, Zhang, Liyin (CN) wrote:
> Hi stable team,
> 
> Please consider applying the following mainlined patches to the 6.12.y
> stable tree:
> 
>   commit f156b23df6a84efb2f6686156be94d4988568954
>   "mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode"
> 
>   commit 17926cd770ec837ed27d9856cf07f2da8dda4131
>   "mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode"
> 
> Both patches are already present in mainline, 6.19, and 6.18.
> 
> Both patches fix the same class of bug: Octal DTR (8D-8D-8D) mode requires
> both the start address and transfer length to be even.
> And we actually encounter the same issues on different hardwares which
> supporting octal dtr in multiple earlier releases.
> 
> Now these two patches can be cleanly applied to 6.12 branch.
> Would you please help backport them to 6.12 first?

Now queued up, thanks.

greg k-h

