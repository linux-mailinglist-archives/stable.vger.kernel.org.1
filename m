Return-Path: <stable+bounces-274729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pYUFDxoRV2pEEwEAu9opvQ
	(envelope-from <stable+bounces-274729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:48:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BAC75A849
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:48:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kroah.com header.s=fm2 header.b="asG/fVw2";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=HAlJCKAR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274729-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274729-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=kroah.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2229304972A
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117E3B42F7;
	Wed, 15 Jul 2026 04:48:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F13A759D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 04:48:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090890; cv=none; b=aJzN03eKSlG6JoZ8CC22RutNWh0auUNBqrJXnngkseLATfDe2kpD+R3bKcYBZrCi7t+N1hCIL7be/7QuAM/fuO++N9ugJtx05XislqF/hN+dfFx5e++wEjYEXhCvE00iVbJfGbTaZ1GmUJToDGfihBl7uLRkmu/dYTMzuYvuefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090890; c=relaxed/simple;
	bh=urCCCrkAkRNTc29dTxHX6weFSI5TZpYKP7wtj9CkgsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixg/zCNjMrqFRvFfuKWzfcRXgNP1B4f7nysOz25CneifUfbh9w1xpJRtlsIFOyrbtPJKaNZ233rbZho2WWOWkBVuCZkHTeiun++5sV1HYPy1mEHFgu4BkaFPb/gqm6/31/U6WPQf+n1buO3L/vOtsxuMohH61754Fyq79r5pyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=asG/fVw2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HAlJCKAR; arc=none smtp.client-ip=103.168.172.149
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 680C6EC01A9;
	Wed, 15 Jul 2026 00:48:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 00:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784090886; x=1784177286; bh=/0yz9iuK1r
	8V8zVCw0YNU5t1vxpOX5KPTrGyIK6i060=; b=asG/fVw2YHgmB4SEYevq8WGxt2
	nOgcb5RvpMzos7vIDZE9t+JEY1REKG6ybvRjBhwtcOsjjNiXy3Mx2RirhgFuGYga
	kdDk15xSCvHtVDteULQ+GqKa2cnc2ZZVmxB5GAUESgXCv6IsSzE2z5CRBW0Iq9ZJ
	MkDC4FMezyOgzxxUD/QmsQKwC9kmKDafM5ieb8pjGt9R/rF7s++MobkluyMm4J5m
	AxNZ1tNMas4w4pTRzwSAD+izSp0dxPn0SfhYsBUL4qaFSJ/yhoq/AcLH+7JLXiMb
	y1GzbG37yP07GF7AAWp6yb2RJoQCGDD7Knf4UV1jZqT12vTl5+8EYh5VucIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784090886; x=1784177286; bh=/0yz9iuK1r8V8zVCw0YNU5t1vxpOX5KPTrG
	yIK6i060=; b=HAlJCKARY5TxXe0bSZVD+kLM7cGslcriwwuVxbQbPHjGb2i+51A
	xVcb6mCk7k0Ui3gs2Ziej+mG9JbFhohIDQewCNV5brXxsmkY4eA0qeuxeJ/rs7Rk
	2e/U6NAkc5grEVSmO3gq2iQ53VPrsuC53mUuk4reNH4uDLGJu1CbsyjOtNst+D8e
	UnOu5lJ+fQ4Y6CaeZ6FS6hkzZiDX7DWxAjaOrgrQ27OKUzz3QcztQ9Qr4U+Am/2V
	DeD/6darqEIV1A0/U47pDU0BmI3TLACf3Cdaz5qXFLO4N8n12L0RFY7CdzfGmbDD
	b3hR+ckbpgo98n1JBq3E77woArr0RDaXAEQ==
X-ME-Sender: <xms:BhFXajKwKKl47AZlxIuU4ZvBNzixXGehYfofxZAOgGMdgBkByFh_4Q>
    <xme:BhFXagdhpUK6KBnQaonKhJU6MPigxRcQjDoEGX4eQGj2o0LvUXpiLUMKDTANyus1W
    VILSUG3Sd66c6bEQsHLx2PISSIInsq-KaRfC1vNA6EM-cHqxg>
X-ME-Received: <xmr:BhFXai9pgOAKEPDEMXNMXRS7Lzk4wHyd_2ZXX07zyURcH3wc2-Ur6zs4vYQ2_gpHGxH6s8zL_vyst-q7CtIsptYmng>
X-ME-Proxy-Cause: dmFkZTEc6xY7RNwrBQPipNcHEFIvYS9Kw2cQmcKWpyTGAR2bM3hxFLZepjHb1S1TiT3scs
    sy1wZDP8gS7mZIShiqrXQXoCPeG484+l2TWZMgHXnziF28qnx8uN3c8tR885YaXSJFBEwy
    oJVioRZEv00HB2+t8I7DY27nMgvgkO3NxAy0qJaq1CL1XXE2l0AftVvdlMBxO7xgCjy1KT
    94WcrZfgL4/kxdynYndUaWIY4fqHuHXfj2KLs6bAf9/EeNZUsbwn1VswORjRoNt8ErZo6f
    Gc+WzwzloPN4Ha73YpRFppBbLzhTBz/a78bjuRGFlh6P2xWI61/nqkErtU7Ogg2HkAJtV2
    IufsTrqpvUiHqYlWIAHhRQ/8tXKLedBgu2AwXgluieTiSI7lwLOwXW5dOlUvYUINEU3E3R
    XOjQbV3g59VsHKdZtWt1cwJUfLbe8q/POodv3MxNBs6jYZeE3oNF/cYWV+uajv1G0T5Q9s
    fanhsSvkYm1DjERJBHgy3SIi+AhFqSu45GPggC7ZqI+0kZ0mCD1nv5zv0WX3uQ0+w7ZhqN
    GD8QIAya+C62LhksSPnfe+40QZfZP1FQzp+Zr/U5KRI0VOV9Lh/VjDgeq9ynAmB2KYPotP
    PPg3YXIAATXgbfSXPS9Y72g8+drC/UG97mnxaElp/30U/R1+O6+jNwHFAn9g
X-ME-Proxy: <xmx:BhFXatohsT2egh19qb_spLWuNaM1lNOxe4HrvYN67kdz0VTwXUo3Pw>
    <xmx:BhFXanC81bc2kiAXDLkNIOaxrUX0hVdemxpH9Mj63QGV0no-jhf1UA>
    <xmx:BhFXavzfWyNgZAUi35UeOMxt2xoEKN3UaxfRCiYb7B2PM32HMLwYVA>
    <xmx:BhFXak2i7oh1_0gVXsqcPCbRmV663KJwImnW39KxpVXTwjZRFEtamA>
    <xmx:BhFXai8p_FCy61YGkfUe4s2Phfn9qMzI0KlPXcvdi-G20I8AoTKlFUtD>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 00:48:05 -0400 (EDT)
Date: Wed, 15 Jul 2026 06:48:00 +0200
From: Greg KH <greg@kroah.com>
To: Chao S <coshi036@gmail.com>
Cc: stable@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: Please backport 49f06cff50a4 ("block: skip sync_blockdev() on
 surprise removal in bdev_mark_dead()") to 6.6.y, 6.12.y, 6.18.y
Message-ID: <2026071548-remember-handling-8672@gregkh>
References: <CACd_6n3dExLLL8fziY0ha+nDupfb+q45VCbjA7aAYNnj-YkY8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n3dExLLL8fziY0ha+nDupfb+q45VCbjA7aAYNnj-YkY8g@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274729-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:coshi036@gmail.com,m:stable@vger.kernel.org,m:weizhu@fiu.edu,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kroah.com:from_mime,kroah.com:dkim,gregkh:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91BAC75A849

On Tue, Jul 14, 2026 at 05:20:19PM -0400, Chao S wrote:
> Hi stable team,
> 
> Please consider the following mainline commit for the stable trees:
> 
>   commit 49f06cff50a4ccf3b7a1a662ceb892b3b21a527a
>   Author: Chao Shi <coshi036@gmail.com>
>   "block: skip sync_blockdev() on surprise removal in bdev_mark_dead()"
> 
> Why it should be applied:
> On surprise removal (@surprise == true) the device is already gone, but the
> bare block-device path in bdev_mark_dead() (no ->mark_dead holder op) calls
> sync_blockdev() unconditionally. It can then hang forever in
> folio_wait_writeback() waiting on writeback that can never complete. We hit
> this via nvme_reset_work()'s "I/O queues lost" path
> (nvme_mark_namespaces_dead -> blk_mark_disk_dead -> bdev_mark_dead(bdev, true)),
> which wedges the reset worker and every task serialized behind it -- an
> unrecoverable hung-task/DoS (multiple tasks blocked >120s, reproduced several
> times under fuzzing). The fix simply skips the futile sync on surprise removal,
> matching fs_bdev_mark_dead(); invalidate_bdev() still runs and orderly removal
> is unchanged.
> 
> Affected versions:
>   Fixes: d8530de5a6e8 ("block: call into the file system for bdev_mark_dead")
> which first shipped in v6.6 (it dropped the pre-existing !surprise guard from
> the bare-bdev path). So the bug is present in v6.6 through the fix.
> v7.0+ already
> carries the fix, and pre-6.6 trees still have the original guard, so
> this is only
> needed for the 6.6.y, 6.12.y and 6.18.y stable trees.
> 
> The change is a self-contained one-line guard (plus a comment) in
> bdev_mark_dead()
> and should cherry-pick cleanly onto all three; happy to send adjusted backports
> if any tree conflicts.

We need a 6.6.y backport as it does not apply cleanly there.

thanks,

greg k-h

