Return-Path: <stable+bounces-263181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2eNuFY3iL2rAIQUAu9opvQ
	(envelope-from <stable+bounces-263181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:31:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC2B685BDD
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:31:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=1HCsP8aM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263181-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263181-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A7673009F68
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3A3AB46F;
	Mon, 15 Jun 2026 11:31:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1262E7BB6;
	Mon, 15 Jun 2026 11:31:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523080; cv=none; b=O1iH/siq5KejWNhvrlMFNoPdet0NoyWAigz/mDmPuXBC/3KAXZKJ2vlmqXbeSt86Cu91oy2mGaaABRYlCa6eNTxtV96rQXkQuuKrY5WnGes0bkHHXiZinLeAAzzrSUmN+7lSzDMdiCKHQM+Hy+5AdrqgO7qYZNMNkkqK+gGWvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523080; c=relaxed/simple;
	bh=vGp9DeeFUhWXlnjhTHj/krKinCUvuD2zCvy7lDw0bp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeNj2SxGnNjhBmbKz1af37O5NUdVSipNfstXkeniswKIAQD9BzCz2+20BcnjalCzf5qZ7rQH28JHxdJZnL+AtqXbQfZcRGvIS38YLuz539jRiajjQGnpbRohka4TRoQdtQNvMN0awBLU8Hy5vTT5khwWTlX69EQtuzUlriMjlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1HCsP8aM; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dYCpL2v7hA6/R1B/68TFnCiOpsxkYHbF6QRYAWthKL8=; b=1HCsP8aMou7VyueWI4ao4mnO+y
	ysEVx8CdjtiPjz4A1VktRS9OAo3ZY1ihF6KiZSLWzEwFL6RjVTBmPcXqJmaGVKi17szH0AeEwh0Hd
	M67LUPjzeINeLgmag66iHSQrtzeM/7DiaFo2vEf9dW7y9Ig5xsOUrGQxYRwCJ4duJ82M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ5Wq-007n0V-0c; Mon, 15 Jun 2026 13:30:56 +0200
Date: Mon, 15 Jun 2026 13:30:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com,
	fengxw06@126.com, horms@kernel.org, kees@kernel.org,
	kuba@kernel.org, linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, qli01@tsinghua.edu.cn, stable@vger.kernel.org,
	wangao@seu.edu.cn, xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn
Subject: Re: [PATCH net] atm: br2684: validate IP header length before
 filtering
Message-ID: <354fec7a-608e-45a3-ba62-a6d532d26e46@lunn.ch>
References: <e85fe7cc-05d1-4fb1-a919-baa170d08307@lunn.ch>
 <20260615061055.30419-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615061055.30419-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263181-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:3chas3@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:fengxw06@126.com,m:horms@kernel.org,m:kees@kernel.org,m:kuba@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:qli01@tsinghua.edu.cn,m:stable@vger.kernel.org,m:wangao@seu.edu.cn,m:xuke@tsinghua.edu.cn,m:yangyx22@mails.tsinghua.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,126.com,kernel.org,lists.sourceforge.net,vger.kernel.org,redhat.com,tsinghua.edu.cn,seu.edu.cn,mails.tsinghua.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEC2B685BDD

On Mon, Jun 15, 2026 at 02:10:55PM +0800, Yizhou Zhao wrote:
> Hi Andrew,
> 
> On Sun, Jun 14, 2026 at 08:36:57PM +0800, Andrew Lunn wrote:
> > So did all these people find the problem at the same time in parallel?
> > Can you point to their reports?
> 
> No, they were not independent reports found in parallel. This came from
> one internal analysis/reproducer effort, and I do not have separate
> public reports to point to. Sorry for the confusion.

Please take a read of:

https://docs.kernel.org/process/submitting-patches.html

There is a section about Reported-by, and what it means.

>  > It is a long time since i worked with ATM. From what i remember,
> ATM > cells are 48 bytes in size. So can the packet actually be
> smaller than > 48? Would a 48 byte packet trigger this? Or is AAL5
> involved here? Can > AAL5 carry a frame smaller than 48 bytes?  On
> the cell-size question: yes, ATM cells carry 48 bytes of payload,
> but br2684_push() does not receive raw ATM cells.  It receives the
> reassembled AAL5 CPCS-SDU/PDU from the ATM layer.  AAL5 can carry a
> shorter user payload in one cell by padding the final cell, with the
> AAL5 trailer carrying the real payload length.  So an 8-byte
> LLC/SNAP BR2684 PDU can be carried in a single ATM cell with
> padding, while br2684 still sees skb->len == 8 after AAL5
> reassembly.  A reassembled 48-byte BR2684 PDU would not trigger the
> issue in the LLC case: after pulling the 8-byte LLC/SNAP header, 40
> bytes remain, so the IPv4 daddr access is in bounds. The problematic
> case is a reassembled AAL5 PDU shorter than the encapsulation header
> plus a minimum IPv4 header, for example an 8-byte LLC/SNAP IPv4 PDU
> with no IP payload. The VC-routed case is similar: the current code
> reads iph->version before checking that the reassembled PDU contains
> an IPv4 header.  > What hardware was used when finding this problem?
> I know DSL often > used ATM underneath, so was it a DSL modem?  I'm
> sorry that no physical ATM/DSL hardware was used. I verified this in
> QEMU/KVM with a small dummy ATM device that registers an atm_dev and
> injects reassembled AAL5 PDUs through the real VCC receive callback
> after BR2684 is attached.

So this is hypothetical and in real life not a real issue. Please drop
the Fixes tag, and submit to net next.

ATM is pretty much dead. If you do any further work, could you please
look at currently used hardware, and try to avoid wasting our time
with hypothetical problems.

    Andrew

---
pw-bot: cr

