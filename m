Return-Path: <stable+bounces-62445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734893F1E9
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B001F22388
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D149145A11;
	Mon, 29 Jul 2024 09:55:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC621422C5
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246908; cv=none; b=tM8htCNe2RSZxmHI/uUSAnQXdLvVWyMpMV+YiqDQMrkXIBjg0Rg9kekYrZdw7efquysq0P/DSy4t6Y8m1wzLPa+tE+B+gJe8SVnzqj2rxpFFb76+HLyHQzd7rKJc7gqIgleRqpMWvAehbcuGwepbUqPmi3ZQprwJdbuEuI0la/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246908; c=relaxed/simple;
	bh=QMQUs5dBec3jLLH3GDOuuG4Czix4bZYvDrgPsy5L5Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN6+3hFGwnZIDSex8rcvXWcd6NrOxQVVkb03ZtjQBT2eIeVxknQnVhEqScaVjtAGPoKyqvyKokNKMq71BSbzpSO/CPKv0gcs7h0uOSRJ9JpX0hzNTsEOLk7qKg9A/EnuXGCZFr4SAfigVCUjUsYb9/uVxekhE1q0e2Kb0TcrN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 702741007;
	Mon, 29 Jul 2024 02:55:31 -0700 (PDT)
Received: from arm.com (unknown [10.57.13.219])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FF453F64C;
	Mon, 29 Jul 2024 02:55:04 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:55:02 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] irqchip/gic-v3: Fix 'broken_rdists'
 unused warning when !SMP" failed to apply to 6.10-stable tree
Message-ID: <Zqdm9lQaL_ikpTgY@arm.com>
References: <2024072916-brewing-cavalier-a90a@gregkh>
 <86wml41uup.wl-maz@kernel.org>
 <2024072946-charbroil-emporium-ca54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072946-charbroil-emporium-ca54@gregkh>

On Mon, Jul 29, 2024 at 10:20:03AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 29, 2024 at 09:10:54AM +0100, Marc Zyngier wrote:
> > On Mon, 29 Jul 2024 08:51:16 +0100,
> > <gregkh@linuxfoundation.org> wrote:
> > > The patch below does not apply to the 6.10-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 080402007007ca1bed8bcb103625137a5c8446c6
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072916-brewing-cavalier-a90a@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..
> > > 
> > > Possible dependencies:
> > > 
> > > 080402007007 ("irqchip/gic-v3: Fix 'broken_rdists' unused warning when !SMP and !ACPI")
> > > d633da5d3ab1 ("irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs")
> > > fa2dabe57220 ("irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()")
> > 
> > None of these three patches should be stable candidate for 6.10. They
> > only matter to CPU hotplug, which is a new feature for 6.11 and has
> > no purpose being backported.
> 
> That's fine, thanks, it was odd that this commit was tagged for stable
> inclusion at all...

Ah, sorry, my script for generating the Fixes line inserted a cc stable
and I missed it. It should have only had the Fixes tag for something
that went in 6.11, no backports.

-- 
Catalin

