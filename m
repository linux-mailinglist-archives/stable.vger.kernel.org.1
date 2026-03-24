Return-Path: <stable+bounces-230246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EADdOkEcw2mJoQQAu9opvQ
	(envelope-from <stable+bounces-230246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 00:20:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F25731DAFF
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 00:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94B95302353F
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FEF3CA4B2;
	Tue, 24 Mar 2026 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKD5mzZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA22D94BA;
	Tue, 24 Mar 2026 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774394422; cv=none; b=LfKO6DG9txQZPb+rPuzwfpqk6Tofcf+1VdVIsYRpFdodd8NaOJFGbX095Z6dD5iinkq6y4mCAQGrroumb+SoQKOuJWsu1y2V7AVa6jsCaiTV6X28K+bT1nSlEIK8eMWLke2pHCnBAx38G0LxiFLdgErWJyk6vp+ckTrMEGu4WNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774394422; c=relaxed/simple;
	bh=++9RL6oLc7KHlnW8oTTMxeaPX+UhsArFOPi2TabxMok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TQ6FmWhEzMp/6OpsNkUEu9egBsyfZW8pvcwfmoNXITfuldN/yzp/wVTIKR24N1Q3d8YedbuJMPNt0PZIKEbQO9YaHyWLeX+RILHxtJyeDpQichvNvdfcXDHP73OYsoFy+wE/nFxubXDVWRNq/J9JJTIP2lCHolWx09MbSAVPW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKD5mzZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CCEC19424;
	Tue, 24 Mar 2026 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774394421;
	bh=++9RL6oLc7KHlnW8oTTMxeaPX+UhsArFOPi2TabxMok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mKD5mzZJuJkyRHF0ALZChJNomp7P+7HdyLnYIXm01pC7wrQoBJGudE5q1sbGMRDyT
	 M1fhaEucs/A8szf0J+ReqfVhvWsRHGhLa2djzkJxIiIOzl8AVAQCaSgxynvVlFTTwS
	 +B0qFOnR9N0kYv6/noqzGxVeZ3OvvTl+3IhaIZ0hnRdzzmlI0VnyMDQJA3zdo8HmBt
	 +3J0Dp87w0THlpoCWynUSbOTc/R8OAeXhNJ5fLDe+UAPLoFC8lDlsz94MVIEsh5+7A
	 LAlWw8auIIcT4Fe3okYWjeKniPVN5GMUr4V/0Ty7+0bmgAlAcxCSL93ew5H0LdXgxU
	 Cfdk6S4nCx5uQ==
Date: Tue, 24 Mar 2026 18:20:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v11 1/9] PCI: Allow per function PCI slots
Message-ID: <20260324232020.GA1163913@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b7c3d4-e16a-4522-ae56-655a9e38e6e7@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230246-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4F25731DAFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 04:08:28PM -0700, Farhan Ali wrote:
> On 3/24/2026 2:55 PM, Bjorn Helgaas wrote:
> > On Mon, Mar 16, 2026 at 12:15:36PM -0700, Farhan Ali wrote:
> > > On s390 systems, which use a machine level hypervisor, PCI devices are
> > > always accessed through a form of PCI pass-through which fundamentally
> > > operates on a per PCI function granularity. This is also reflected in the
> > > s390 PCI hotplug driver which creates hotplug slots for individual PCI
> > > functions. Its reset_slot() function, which is a wrapper for
> > > zpci_hot_reset_device(), thus also resets individual functions.
> ...

> > >   static ssize_t address_read_file(struct pci_slot *slot, char *buf)
> > >   {
> > > -	if (slot->number == 0xff)
> > > +	if (slot->number == (u16)-1)
> > This "-1" is mentioned in the commit log, but I don't know where it
> > came from.  I guess we must assign -1 as a default somewhere?  Could
> > this be a #define to connect that assignment with this test?
> 
> The -1 is used a placeholder and from what I could tell
> rpaphp_register_slot() would be the only one to use this. Would you prefer
> this to be a #define?

If that's the only place that uses it, I think a #define would help to
match that use with this one.

I hate having to put it in include/linux/pci.h, but it seems like it
would belong next to PCI_SLOT_ALL_DEVICES (which also doesn't need to
be exposed and is only there because it's next to the struct
pci_slot).

