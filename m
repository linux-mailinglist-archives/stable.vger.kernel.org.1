Return-Path: <stable+bounces-211260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O9jLIxbcmn5iwAAu9opvQ
	(envelope-from <stable+bounces-211260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:17:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA56B004
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ACD4305AEF0
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B83DC5AE;
	Thu, 22 Jan 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebQ1w49f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475643DC59D
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099994; cv=none; b=cbqRKvHTVGxAVS1/O/XzgHzSp7tkIEsB6r8gGJKhXmKUAqVMUpnIwD2auV2fr3bgPQqw+7lKKGXzWB8TFo/Zamt50W1K6joz2lwvtO8/AMp3332Rr3eNIYKYYJl9XsPA9JdBAYonKaDOl1evRfiJ0FnE5Royyw5XmdQZI+bld9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099994; c=relaxed/simple;
	bh=EsCE/BnCIvNXzPaBxEbpVMCORqPBp5CA3Nl5BGsB2UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u14YqFnk+E3B/oaxqrl97S86JJ1/q9Fl7VUTx+KolqfomyRqmtYKo8GaaywowT3MO0WxflTpbMBHlZfLWo7djpD5CwQbI8tlqZ5TKouD8Ibvb+zp+WmQIZbw97ofxpLTcs4gXNUd14kW+Z3xpbpnErCW1TXpWeY04aWZ7r1+ekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebQ1w49f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FE8C116C6;
	Thu, 22 Jan 2026 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769099993;
	bh=EsCE/BnCIvNXzPaBxEbpVMCORqPBp5CA3Nl5BGsB2UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebQ1w49fBz70PLfcbtqIxp2NL8eBpK2nAtqmdwbITf5Y3TUzChXXDYXhX7oxkvOMg
	 rHBzMuskdI9UzqhE2uUi6H+nUnzErmTaoZc97UdGO/HNKLVb55HdMLTEnlyfu6/JPg
	 G9Q5fIyIGzkcJcSQDr7rZX53FezK4ZjFOMtYxi1MfU49HymLYkciLDf/9o1Iy6tgIZ
	 KKgJ1hygoquUzEvriceV5zbouv1M/LR3WrZxDf1gBSuE2eL+77zvQzhYyFFRseKIZ3
	 g2485N0X92EvX4iJKHQPAfe4vvZyeznP5ZNdlTTX4BsB53aA8Sr7aMexjuIz+f5dKB
	 1ruTJRKk3uH0g==
Date: Thu, 22 Jan 2026 16:39:49 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	syzbot+7bfa4b72c6a5da128d32@syzkaller.appspotmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6 1/1] bridge: mcast: Fix use-after-free during router
 port configuration
Message-ID: <20260122163949.GO3831112@google.com>
References: <20260119121726.1376464-1-lee@kernel.org>
 <20260122110337.GA3831112@google.com>
 <2026012240-prowling-kindle-fd7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026012240-prowling-kindle-fd7d@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211260-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,7bfa4b72c6a5da128d32];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FAA56B004
X-Rspamd-Action: no action

On Thu, 22 Jan 2026, Greg KH wrote:

> On Thu, Jan 22, 2026 at 11:03:37AM +0000, Lee Jones wrote:
> > Intentional top-post - quoting everything!
> > 
> > I see that the v6.12 version was applied and is now queued, however this
> > one still remains.  Was that intentional or was this missed?
> 
> Intentional, I only caught up on 6.12.y and 6.18.y trees at the moment.
> Older ones are still in my queue to process, this patch being one of
> those not gotten to yet.

Great!  I knew it.  I believed in you all along.

-- 
Lee Jones [李琼斯]

