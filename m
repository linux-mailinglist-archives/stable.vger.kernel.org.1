Return-Path: <stable+bounces-215725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF3XKfXBi2l6aQAAu9opvQ
	(envelope-from <stable+bounces-215725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:40:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F712020B
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11AFB3070B1F
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA34A338907;
	Tue, 10 Feb 2026 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZJihtdu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8E336EE7;
	Tue, 10 Feb 2026 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766754; cv=none; b=LLgFWH60SYLFWN+d+BKT85nWEaJAMLo6JxSdLAArSp4eZn5BmudFARVAMgTuUcSUv9C1v3Py2LEi9lWvL6do2OVVS1YE1XO7lH//eWJ4q0i9rycgP0+NZ3x1d/bubKSWE5va15z8ArW138GF265ldEYvQlZhrdeDsKhJCB5FSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766754; c=relaxed/simple;
	bh=l40g5XI76/xjtVu1Jy+IaqFzXlkV1FpHj5AiocgwbO8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aJEmwfLZ5plYhouPko/vQTLCsSrbvMlMGWo1/efdZw/covQAKvBo2SFXJmHKSleYABRx0wx5eyYvxQP6usM2EfMS9cCO9zyRvqzKrKL0EHLImbSqXNk0BXc6Za/uyf/UW4m3Rq+rdazUpS0gGvAElEjNWIjuHofi0zrrWH6tgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZJihtdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2503C116C6;
	Tue, 10 Feb 2026 23:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766754;
	bh=l40g5XI76/xjtVu1Jy+IaqFzXlkV1FpHj5AiocgwbO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jZJihtdu138tStN5TC6+zNiXMs6e6OsK5vCJ57kpp0QTfjhvVtjevVk1jo1h7SDV5
	 612nz8Gqrzdnipw0K3meJ7Rb9qxC8DPC3FpID2GXrjImserEwTHvaX+ahhrelsZg08
	 33pKH3lZVtMIVauguNwwSu3nBNz113j0Xyh5Coy75w+PwMhYvpZK6JzoHXMnDcI5fz
	 BGKjVfF+cWlO3YWZ3JDIRzJwmD+QCeJbDOSdq5U+Qssbs8Oxikz6lLjwND6wBC6wWL
	 hyjhLMR0vHidMKkptqn+vmnpfXpkfYTVxa/nJ7fQfI7P8OanFUYh9WIJ4Mt5eWRxd3
	 N2AmndRMXtdkg==
Date: Tue, 10 Feb 2026 17:39:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Guo, Jinhui" <guojinhui.liam@bytedance.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
Message-ID: <20260210233912.GA93504@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276FCF5D751DE7432A32BBB8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215725-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email]
X-Rspamd-Queue-Id: 103F712020B
X-Rspamd-Action: no action

[+cc Alex, beginning of thread:
https://lore.kernel.org/all/20251211035946.2071-1-guojinhui.liam@bytedance.com/]

On Wed, Dec 24, 2025 at 03:08:49AM +0000, Tian, Kevin wrote:
> +Bjorn for guidance.

Sorry for the late response.

> quick context - previously intel-iommu driver fixed a lockup issue in surprise
> removal, by checking pci_dev_is_disconnected(). But Jinhui still observed the
> lockup issue in a setup where no interrupt is raised to pci core upon surprise
> removal (so pci_dev_is_disconnected() is false), hence suggesting to replace
> the check with pci_device_is_present() instead.

I think checking pci_dev_is_disconnected() or pci_device_is_present()
in drivers is usually bad practice because it's always racy, as you've
already pointed out.

I don't think it's possible to avoid Invalidate Completion Timeouts in
general, so I think the real solution is to figure out how to
gracefully handle them without running into the lockup detection.

I assume the lockup is the loop in qi_submit_sync() where we wait for
QI_DONE with interrupts disabled.  Maybe we need something like
watchdog_hardlockup_touch_cpu() there, along with a timeout in that
loop?

The PCIe r7.0, sec 10.3.1, implementation note suggests the timeout
might be in the 1-2 minute range, which is pretty extreme, but if we
can at least handle timeouts gracefully, we can think about ways to
make them less likely, e.g., by coordinating with FLR and VFIO detach
(maybe the sort of thing Alex alluded to at
https://lore.kernel.org/all/20251223153534.0968cc15.alex@shazbot.org).

> Bjorn, is it a common practice to fix it directly/only in drivers or should the
> pci core be notified e.g. simulating a late removal event? By searching the
> code looks it's the former, but better confirm with you before picking this
> fix...

I don't know exactly what it would look like to simulate a late
removal event, but it sounds like some kind of complicated
infrastructure that would still be only a 90% solution, which I
wouldn't recommend.

> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Tuesday, December 23, 2025 12:06 PM
> > 
> > On 12/22/25 19:19, Jinhui Guo wrote:
> > > On Thu, Dec 18, 2025 08:04:20AM +0000, Tian, Kevin wrote:
> > >>> From: Jinhui Guo<guojinhui.liam@bytedance.com>
> > >>> Sent: Thursday, December 11, 2025 12:00 PM
> > >>>
> > >>> Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
> > >>> request when device is disconnected") relies on
> > >>> pci_dev_is_disconnected() to skip ATS invalidation for
> > >>> safely-removed devices, but it does not cover link-down caused
> > >>> by faults, which can still hard-lock the system.
> > >> According to the commit msg it actually tries to fix the hard lockup
> > >> with surprise removal. For safe removal the device is not removed
> > >> before invalidation is done:
> > >>
> > >> "
> > >>      For safe removal, device wouldn't be removed until the whole software
> > >>      handling process is done, it wouldn't trigger the hard lock up issue
> > >>      caused by too long ATS Invalidation timeout wait.
> > >> "
> > >>
> > >> Can you help articulate the problem especially about the part
> > >> 'link-down caused by faults"? What are those faults? How are
> > >> they different from the said surprise removal in the commit
> > >> msg to not set pci_dev_is_disconnected()?
> > >>
> > > Hi, kevin, sorry for the delayed reply.
> > >
> > > A normal or surprise removal of a PCIe device on a hot-plug port normally
> > > triggers an interrupt from the PCIe switch.
> > >
> > > We have, however, observed cases where no interrupt is generated when
> > the
> > > device suddenly loses its link; the behaviour is identical to setting the
> > > Link Disable bit in the switch’s Link Control register (offset 10h). Exactly
> > > what goes wrong in the LTSSM between the PCIe switch and the endpoint
> > remains
> > > unknown.
> > 
> > In this scenario, the hardware has effectively vanished, yet the device
> > driver remains bound and the IOMMU resources haven't been released. I’m
> > just curious if this stale state could trigger issues in other places
> > before the kernel fully realizes the device is gone? I’m not objecting
> > to the fix. I'm just interested in whether this 'zombie' state creates
> > risks elsewhere.
> > 

