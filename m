Return-Path: <stable+bounces-230237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLHANk0Iw2lKnwQAu9opvQ
	(envelope-from <stable+bounces-230237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 22:55:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E841631D09D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 22:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1849D30197F8
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C7F3AC0E5;
	Tue, 24 Mar 2026 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzizuCls"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2A3B0AF8;
	Tue, 24 Mar 2026 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389315; cv=none; b=DK2wLxugqMwqfLYaaPggE1lURjREwG3VON7PHxOTSRTcMqYJwzb5OLl7dsaPAA1mrnJSMIuJtIUGu+6Yqe1Yxe4EIPMKtvdle6r8krfv6Rrz1hYwRlJ0T3vqTez5ZZv/kAIcucEcCSSs5v823/LbMHCz9m9Ax/TuSlagylQxEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389315; c=relaxed/simple;
	bh=NbPn1QcoeKA4LFa742s2OhhVtglnQi4bzx0DOF5KVhc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YfDwQET11kyVFY5ioMKnlXJosts2fVlvSTHhXQrNq0vUHlx9TvELqblSRtCyq9MdjOoHHo+sEdsF2XSDLK2tOQNAI7QM5kKmUXjjeE0SDSORk2FzeSk2WQfIB3AKpq+/PKnS+KgAitbJEddgKGDVhwTeMBWlq0ACPVuSg8Vd8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzizuCls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B2BC2BC9E;
	Tue, 24 Mar 2026 21:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774389315;
	bh=NbPn1QcoeKA4LFa742s2OhhVtglnQi4bzx0DOF5KVhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rzizuClsrPhu6brc3CzCIEZAnY9HbIYDN7IycjfkJcLjrtnjnwgm9k8yuD48Zio5T
	 BMiudm/jb4Z5sEDx3p26QtTFklnUxOP3KCbCRWw+9UKe5+QdbGQS2GKfoWg+9pw652
	 QFxY2IQ+Zu8RRyIQjrKl8ndsmeIbU2HIW+sP+gCIypDLnt8RFXVOQsBMmE1OqE9f3Q
	 KAmR8vTeVloLaL5cTsxXsf8xTTXYYcTSEkbxN2WyJsK+tBkYLyWipdPrxsJlrqeZQt
	 kcU81K7hCaLJr9G3ByZ02NCXOuUYehlGzNwlYpo9X6RqFOIpukl2Zq57NJ4B8tuJXA
	 7wxwQNeqvYXXA==
Date: Tue, 24 Mar 2026 16:55:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v11 1/9] PCI: Allow per function PCI slots
Message-ID: <20260324215513.GA1157029@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316191544.2279-2-alifm@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230237-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E841631D09D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 12:15:36PM -0700, Farhan Ali wrote:
> On s390 systems, which use a machine level hypervisor, PCI devices are
> always accessed through a form of PCI pass-through which fundamentally
> operates on a per PCI function granularity. This is also reflected in the
> s390 PCI hotplug driver which creates hotplug slots for individual PCI
> functions. Its reset_slot() function, which is a wrapper for
> zpci_hot_reset_device(), thus also resets individual functions.

I think this "pass-through" is from the hypervisor to Linux, i.e.,
what we think of as the host kernel, right?

> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
> to multifunction devices. This approach worked fine on s390 systems that
> only exposed virtual functions as individual PCI domains to the operating
> system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
> s390 supports exposing the topology of multifunction PCI devices by
> grouping them in a shared PCI domain. When attempting to reset a function
> through the hotplug driver, the shared slot assignment causes the wrong
> function to be reset instead of the intended one. It also leaks memory as
> we do create a pci_slot object for the function, but don't correctly free
> it in pci_slot_release().

This alludes to the patch fixing a reset issue, but I think it should
be more prominent, e.g., the reset and leak fixes could be a separate
paragraph.  The subject line should also mention at least the reset
fix.

> Add a flag for struct pci_slot to allow per function PCI slots for
> functions managed through a hypervisor, which exposes individual PCI
> functions while retaining the topology. Since we can use all 8 bits
> for slot 'number' (for ARI devices), change slot 'number' u16 to
> account for special values -1 and PCI_SLOT_ALL_DEVICES.
> ...

>  static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>  {
> -	if (slot->number == 0xff)
> +	if (slot->number == (u16)-1)

This "-1" is mentioned in the commit log, but I don't know where it
came from.  I guess we must assign -1 as a default somewhere?  Could
this be a #define to connect that assignment with this test?

>  		return sysfs_emit(buf, "%04x:%02x\n",
>  				  pci_domain_nr(slot->bus),
>  				  slot->bus->number);

